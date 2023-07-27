# -*- coding:utf-8 -*-

import hashlib
import traceback

import requests
from flask import current_app, g, has_request_context
from flask import session, abort

from api.extensions import cache

ACL_URI = "http://{xxx}/api/v1"
APP_ID = "{app id}"
APP_SECRET_KEY = "{app secret key}"


def get_access_token():
    url = "{0}/acl/apps/token".format(ACL_URI)
    payload = dict(app_id=APP_ID,
                   secret_key=hashlib.md5(APP_SECRET_KEY.encode('utf-8')).hexdigest())
    try:
        res = requests.post(url, data=payload).json()
        return res.get("token")
    except Exception as e:
        current_app.logger.error(str(e))


class AccessTokenCache(object):
    TOKEN_KEY = 'AccessToken'

    @classmethod
    def get(cls):
        if cache.get(cls.TOKEN_KEY) is not None:
            return cache.get(cls.TOKEN_KEY)

        res = get_access_token() or ""

        cache.set(cls.TOKEN_KEY, res, timeout=60 * 60)
        return res

    @classmethod
    def clean(cls):
        cache.clear(cls.TOKEN_KEY)


class ACLManager(object):
    def __init__(self):
        self.access_token = AccessTokenCache.get()
        self.headers = {'App-Access-Token': self.access_token}
        self.user_info = session["acl"] if has_request_context() and "acl" in session else {}

    def build_user_info(self, username):
        session["acl"] = self.get_user_info(username)
        self.user_info = session["acl"]

    def get_user_info(self, username):
        url = '{0}/acl/users/info'.format(ACL_URI)
        payload = dict(username=username)

        try:
            res = requests.get(url, data=payload, headers=self.headers).json()
            if not res.get("result"):
                return abort(400, res.get("message"))

            result = res.get("result")
            return result
        except Exception as e:
            current_app.logger.error(str(e))
            return abort(400, f"ACL: get user info failed: {e}")

    def has_permission(self, resource_name, resource_type, perm, rid=None):

        if rid is None:
            if "acl" not in session and hasattr(g, "user"):
                self.build_user_info(g.user.username)
            elif "acl" not in session:
                abort(405)

            rid = session.get('acl', {}).get('rid')

        url = '{0}/acl/roles/has_perm'.format(ACL_URI)
        payload = dict(rid=rid,
                       resource_name=resource_name,
                       resource_type_name=resource_type,
                       perm=perm)
        try:
            res = requests.get(url, data=payload, headers=self.headers).json()

            return res.get("result")
        except Exception as e:
            current_app.logger.error(str(e))
            return abort(400, f"ACL: has permission failed: {e}")

    def get_resource_id(self, name, resource_type):
        url = '{0}/acl/resources'.format(ACL_URI)
        payload = dict(q=name, resource_type_id=resource_type)

        try:
            res = requests.get(url, data=payload, headers=self.headers).json()
            for r in res.get('resources', []):
                if r.get('name') == name:
                    return r.get('id')

        except Exception as e:
            current_app.logger.error(str(e))
            return abort(400, f"ACL: get resource id failed: {e}")

    def get_resources(self, resource_type_name=None):
        if "acl" not in session and hasattr(g, "user"):
            self.build_user_info(g.user.username)
        elif "acl" not in session:
            abort(405)

        url = '{0}/acl/roles/{1}/resources'.format(ACL_URI, session.get('acl', {}).get('rid'))
        payload = dict(resource_type_id=resource_type_name)
        try:
            res = requests.get(url, data=payload, headers=self.headers).json()
            return res.get('resources')
        except Exception as e:
            current_app.logger.error(str(e))
            current_app.logger.error(traceback.format_exc())
            return abort(400, f"ACL: has permission failed: {e}")

    def add_resource(self, name, resource_type_name=None, uid=None, rid=None):
        if "acl" not in session and hasattr(g, "user"):
            self.build_user_info(g.user.username)
        elif "acl" not in session:
            abort(405)

        url = '{0}/acl/resources'.format(ACL_URI)
        payload = dict(type_id=resource_type_name, name=name, uid=uid or g.user.uid)
        try:
            res = requests.post(url, data=payload, headers=self.headers).json()
            if res.get("id") is None:
                return abort(400, res.get("message"))
        except Exception as e:
            current_app.logger.error(str(e))
            return abort(400, f"ACL: add resource failed: {e}")

        self.grant_resource_to_role(name, resource_type_name, rid=rid)

    def update_resource(self, old, new, resource_type):
        resource_id = self.get_resource_id(old, resource_type)
        url = '{0}/acl/resources/{1}'.format(ACL_URI, resource_id)
        payload = dict(name=new)

        try:
            res = requests.put(url, data=payload, headers=self.headers).json()
            if res.get("message") is not None:
                return abort(400, res.get("message"))
        except Exception as e:
            current_app.logger.error(str(e))
            return abort(400, f"ACL: add resource failed: {e}")

    def grant_resource_to_role(self, name, resource_type, rid=None, perms=None):
        if "acl" not in session and hasattr(g, "user"):
            self.build_user_info(g.user.username)
        elif "acl" not in session:
            abort(405)

        perms = perms or []

        resource_id = self.get_resource_id(name, resource_type)

        url = '{0}/acl/roles/{1}/resources/{2}/grant'.format(ACL_URI,
                                                             rid or self.user_info.get('rid'),
                                                             resource_id)
        payload = dict(perms=perms)
        try:
            res = requests.post(url, json=payload, headers=self.headers).json()
            if res.get("rid") is None:
                return abort(400, res.get("message"))
        except Exception as e:
            current_app.logger.error(str(e))
            return abort(400, f"ACL: grant resource to role failed: {e}")

    def revoke_resource_to_role(self, name, resource_type, rid=None, perms=None):
        if "acl" not in session and hasattr(g, "user"):
            self.build_user_info(g.user.username)
        elif "acl" not in session:
            abort(405)

        perms = perms or []

        resource_id = self.get_resource_id(name, resource_type)

        url = '{0}/acl/roles/{1}/resources/{2}/revoke'.format(ACL_URI,
                                                              rid or self.user_info.get('rid'),
                                                              resource_id)
        payload = dict(perms=perms)
        try:
            res = requests.post(url, json=payload, headers=self.headers).json()
            if res.get("rid") is None:
                return abort(400, res.get("message"))
        except Exception as e:
            current_app.logger.error(str(e))
            return abort(400, f"ACL: revoke resource to role failed: {e}")

    def del_resource(self, name, resource_type):
        if "acl" not in session and hasattr(g, "user"):
            self.build_user_info(g.user.username)
        elif "acl" not in session:
            abort(405)

        resource_id = self.get_resource_id(name, resource_type)

        url = '{0}/acl/resources/{1}'.format(ACL_URI, resource_id)
        payload = dict()
        try:
            res = requests.delete(url, data=payload, headers=self.headers).json()
            if res.get("resource_id") is None:
                return abort(400, res.get("message"))
        except Exception as e:
            current_app.logger.error(str(e))
            return abort(400, f"ACL: del resource failed: {e}")

    def get_permissions(self, resource_name, resource_type):
        resource_id = self.get_resource_id(resource_name, resource_type)

        url = '{}/acl/resources/{}/permissions'.format(ACL_URI, resource_id)

        try:
            return requests.get(url, headers=self.headers).json()
        except Exception as e:
            current_app.logger.error(str(e))
            return abort(400, f"ACL: get resource permissions failed: {e}")

    def get_roles(self, q=None):
        url = '{}/acl/roles'.format(ACL_URI)
        params = dict(page_size=100000)
        if q:
            params['q'] = q

        try:
            return requests.get(url, params=params, headers=self.headers).json()
        except Exception as e:
            current_app.logger.error(str(e))
            return abort(400, f"ACL: get resource permissions failed: {e}")

    def get_users(self, q=None):
        url = '{}/acl/users'.format(ACL_URI)
        params = dict(page_size=100000)
        if q:
            params['q'] = q

        try:
            return requests.get(url, params=params, headers=self.headers).json()
        except Exception as e:
            current_app.logger.error(str(e))
            return abort(400, f"ACL: get resource permissions failed: {e}")

    def get_users_by_rid(self, rid):
        url = '{}/acl/roles/{}/users'.format(ACL_URI, rid)

        try:
            return requests.get(url, params=dict(page_size=100000), headers=self.headers).json()
        except Exception as e:
            current_app.logger.error(str(e))
            return abort(400, f"ACL: get users by rid failed: {e}")
