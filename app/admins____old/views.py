#coding=utf-8
"""filename:app/admin/views.py
Created 2017-06-01
Author: by anaf
note:admin视图函数
"""


from flask import Flask
from flask.ext.admin import Admin, BaseView, expose
from app import admin_app,db
from app.models import Article,Category,User,User_msg,Category_attribute,Comment
from flask.ext.admin.contrib.sqla import ModelView
from flask.ext.login import current_user,login_required


class MyView(BaseView):
	@expose('/')
	@login_required
	def index(self):
		return self.render('admin/111.html')


#增加一个导航
admin_app.add_view(MyView(name=u'index'))
admin_app.add_view(ModelView(Article,db.session,name=u'文章管理'))
admin_app.add_view(ModelView(Category,db.session,name=u'栏目管理'))
admin_app.add_view(ModelView(User_msg,db.session,name=u'留言管理'))
admin_app.add_view(ModelView(Category_attribute,db.session,name=u'栏目属性表(不要随意更改)'))
admin_app.add_view(ModelView(Comment,db.session,name=u'评论管理'))
# admin_app.add_view(ModelView(User,db.session,name=u'用户管理'))



class Admin_v(ModelView):
	def is_accessible(self):
		return current_user.is_authenticated 
		
	can_create = False

	column_labels = {
		'id':u'序号',
		'username' : u'用户账号',
		'password_hash':u'密码加密值',
		'name':u'真实姓名',
		'location':u'地址',
		'about_me':u'自我简介',
		'avatar_hash':u'头像加密值',
    }
	column_list = ('id', 'username','password_hash','name',
				'location','about_me','avatar_hash')
	def __init__(self, session, **kwargs):
		super(Admin_v, self).__init__(User, session, **kwargs)
admin_app.add_view(Admin_v(db.session,name=u'用户管理'))


from flask.ext.admin.contrib.fileadmin import FileAdmin
import os.path as op
path = op.join(op.dirname(__file__), 'static')
# print app.root_path
from flask import current_app as app
app.app_context().push() 
with current_app.app_context():
	print current_app
admin_app.add_view(FileAdmin(path,'../static/', name=u'静态文件'))


