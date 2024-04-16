import click
from flask import current_app
from flask.cli import with_appcontext
from werkzeug.datastructures import MultiDict

from api.lib.common_setting.acl import ACLManager
from api.lib.common_setting.employee import EmployeeAddForm, GrantEmployeeACLPerm
from api.lib.common_setting.resp_format import ErrFormat
from api.lib.common_setting.utils import CheckNewColumn
from api.models.common_setting import Employee, Department


class InitEmployee(object):

    def __init__(self):
        self.log = current_app.logger

    def import_user_from_acl(self):
        """
        Import users from ACL
        """

        InitDepartment().init()
        acl = ACLManager('acl')
        user_list = acl.get_all_users()

        username_list = [e['username'] for e in Employee.get_by()]

        for user in user_list:
            acl_uid = user['uid']
            block = 1 if user['block'] else 0
            acl_rid = self.get_rid_by_uid(acl_uid)
            if user['username'] in username_list:
                existed = Employee.get_by(first=True, username=user['username'], to_dict=False)
                if existed:
                    existed.update(
                        acl_uid=acl_uid,
                        acl_rid=acl_rid,
                        block=block,
                    )
                continue
            try:
                form = EmployeeAddForm(MultiDict(user))
                if not form.validate():
                    raise Exception(
                        ','.join(['{}: {}'.format(filed, ','.join(msg)) for filed, msg in form.errors.items()]))
                data = form.data
                data['acl_uid'] = acl_uid
                data['acl_rid'] = acl_rid
                data['block'] = block
                data.pop('password')
                Employee.create(
                    **data
                )
            except Exception as e:
                self.log.error(ErrFormat.acl_import_user_failed.format(user['username'], str(e)))
                self.log.error(e)

    @staticmethod
    def get_rid_by_uid(uid):
        from api.models.acl import Role
        role = Role.get_by(first=True, uid=uid)
        return role['id'] if role is not None else 0


class InitDepartment(object):
    def __init__(self):
        self.log = current_app.logger

    def init(self):
        self.init_wide_company()

    @staticmethod
    def hard_delete(department_id, department_name):
        existed_deleted_list = Department.query.filter(
            Department.department_name == department_name,
            Department.department_id == department_id,
            Department.deleted == 1,
        ).all()
        for existed in existed_deleted_list:
            existed.delete()

    @staticmethod
    def get_department(department_name):
        return Department.query.filter(
            Department.department_name == department_name,
            Department.deleted == 0,
        ).first()

    def run(self, department_id, department_name, department_parent_id):
        self.hard_delete(department_id, department_name)

        res = self.get_department(department_name)
        if res:
            if res.department_id == department_id:
                return
            else:
                res.update(
                    department_id=department_id,
                    department_parent_id=department_parent_id,
                )
                return

        Department.create(
            department_id=department_id,
            department_name=department_name,
            department_parent_id=department_parent_id,
        )
        new_d = self.get_department(department_name)

        if new_d.department_id != department_id:
            new_d.update(
                department_id=department_id,
                department_parent_id=department_parent_id,
            )
        self.log.info(f"init {department_name} success.")

    def run_common(self, department_id, department_name, department_parent_id):
        try:
            self.run(department_id, department_name, department_parent_id)
        except Exception as e:
            current_app.logger.error(f"init {department_name} err:")
            current_app.logger.error(e)
            raise Exception(e)

    def init_wide_company(self):
        department_id = 0
        department_name = '全公司'
        department_parent_id = -1

        self.run_common(department_id, department_name, department_parent_id)

    @staticmethod
    def create_acl_role_with_department():
        acl = ACLManager('acl')
        role_name_map = {role['name']: role for role in acl.get_all_roles()}

        d_list = Department.query.filter(
            Department.deleted == 0, Department.department_parent_id != -1).all()
        for department in d_list:
            if department.acl_rid > 0:
                continue

            role = role_name_map.get(department.department_name)
            if not role:
                payload = {
                    'app_id': 'acl',
                    'name': department.department_name,
                }
                role = acl.create_role(payload)

            acl_rid = role.get('id') if role else 0

            department.update(
                acl_rid=acl_rid
            )
            info = f"update department acl_rid: {acl_rid}"
            current_app.logger.info(info)

    def init_backend_resource(self):
        acl = self.check_app('backend')
        acl_rid = self.get_admin_user_rid()

        if acl_rid == 0:
            return
        GrantEmployeeACLPerm(acl).grant_by_rid(acl_rid, True)

    @staticmethod
    def check_app(app_name):
        acl = ACLManager(app_name)
        payload = dict(
            name=app_name,
            description=app_name
        )
        app = acl.validate_app()
        if not app:
            acl.create_app(payload)
        return acl

    @staticmethod
    def get_admin_user_rid():
        admin = Employee.get_by(first=True, username='admin', to_dict=False)
        return admin.acl_rid if admin else 0


@click.command()
@with_appcontext
def init_import_user_from_acl():
    """
    Import users from ACL
    """
    InitEmployee().import_user_from_acl()


@click.command()
@with_appcontext
def init_department():
    """
    Department initialization
    """
    cli = InitDepartment()
    cli.init_wide_company()
    cli.create_acl_role_with_department()
    cli.init_backend_resource()


@click.command()
@with_appcontext
def common_check_new_columns():
    """
    add new columns to tables
    """
    CheckNewColumn().run()


@click.command()
@with_appcontext
def common_sync_file_to_db():
    from api.lib.common_setting.upload_file import CommonFileCRUD
    CommonFileCRUD.sync_file_to_db()


@click.command()
@with_appcontext
@click.option('--value', type=click.INT, default=-1)
def set_auth_auto_redirect_enable(value):
    if value < 0:
        return
    from api.lib.common_setting.common_data import CommonDataCRUD
    CommonDataCRUD.set_auth_auto_redirect_enable(value)
