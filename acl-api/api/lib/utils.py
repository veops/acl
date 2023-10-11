# -*- coding:utf-8 -*- 

import sys
import time
from typing import Set

import redis
import six
from flask import current_app


class BaseEnum(object):
    _ALL_ = set()  # type: Set[str]

    @classmethod
    def is_valid(cls, item):
        return item in cls.all()

    @classmethod
    def all(cls):
        if not cls._ALL_:
            cls._ALL_ = {
                getattr(cls, attr)
                for attr in dir(cls)
                if not attr.startswith("_") and not callable(getattr(cls, attr))
            }
        return cls._ALL_


def get_page(page):
    try:
        page = int(page)
    except (TypeError, ValueError):
        page = 1
    return page if page >= 1 else 1


def get_page_size(page_size):
    if page_size == "all":
        return page_size

    try:
        page_size = int(page_size)
    except (ValueError, TypeError):
        page_size = current_app.config.get("DEFAULT_PAGE_COUNT")
    return page_size if page_size >= 1 else current_app.config.get("DEFAULT_PAGE_COUNT")


def handle_bool_arg(arg):
    if arg in current_app.config.get("BOOL_TRUE"):
        return True
    return False


def handle_arg_list(arg):
    if isinstance(arg, (list, dict)):
        return arg

    if arg == 0:
        return [0]

    if not arg:
        return []

    if isinstance(arg, (six.integer_types, float)):
        return [arg]
    return list(filter(lambda x: x != "", arg.strip().split(","))) if isinstance(arg, six.string_types) else arg


class RedisHandler(object):
    def __init__(self, flask_app=None):
        self.flask_app = flask_app
        self.r = None

    def init_app(self, app):
        self.flask_app = app
        config = self.flask_app.config
        try:
            pool = redis.ConnectionPool(
                max_connections=config.get("REDIS_MAX_CONN"),
                host=config.get("CACHE_REDIS_HOST"),
                port=config.get("CACHE_REDIS_PORT"),
                password=config.get("CACHE_REDIS_PASSWORD"),
                db=config.get("REDIS_DB") or 0)
            self.r = redis.Redis(connection_pool=pool)
        except Exception as e:
            current_app.logger.warning(str(e))
            current_app.logger.error("init redis connection failed")

    def get(self, key_ids, prefix):
        try:
            value = self.r.hmget(prefix, key_ids)
        except Exception as e:
            current_app.logger.error("get redis error, {0}".format(str(e)))
            return
        return value

    def _set(self, obj, prefix):
        try:
            self.r.hmset(prefix, obj)
        except Exception as e:
            current_app.logger.error("set redis error, {0}".format(str(e)))

    def create_or_update(self, obj, prefix):
        self._set(obj, prefix)

    def delete(self, key_id, prefix):
        try:
            ret = self.r.hdel(prefix, key_id)
            if not ret:
                current_app.logger.warn("[{0}] is not in redis".format(key_id))
        except Exception as e:
            current_app.logger.error("delete redis key error, {0}".format(str(e)))


class Lock(object):
    def __init__(self, name, timeout=10, app=None, need_lock=True):
        self.lock_key = name
        self.need_lock = need_lock
        self.timeout = timeout
        if not app:
            app = current_app
        self.app = app
        try:
            self.redis = redis.Redis(host=self.app.config.get('CACHE_REDIS_HOST'),
                                     port=self.app.config.get('CACHE_REDIS_PORT'),
                                     password=self.app.config.get('CACHE_REDIS_PASSWORD'))
        except:
            self.app.logger.error("cannot connect redis")
            raise Exception("cannot connect redis")

    def lock(self, timeout=None):
        if not timeout:
            timeout = self.timeout
        retry = 0
        while retry < 100:
            timestamp = time.time() + timeout + 1
            _lock = self.redis.setnx(self.lock_key, timestamp)
            if _lock == 1 or (
                    time.time() > float(self.redis.get(self.lock_key) or sys.maxsize) and
                    time.time() > float(self.redis.getset(self.lock_key, timestamp) or sys.maxsize)):
                break
            else:
                retry += 1
                time.sleep(0.6)
        if retry >= 100:
            raise Exception("get lock failed...")

    def release(self):
        if time.time() < float(self.redis.get(self.lock_key)):
            self.redis.delete(self.lock_key)

    def __enter__(self):
        if self.need_lock:
            self.lock()

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.need_lock:
            self.release()
