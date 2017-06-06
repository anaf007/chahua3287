#coding=utf-8
"""filename:app/admin/views.py
Created 2017-06-01
Author: by anaf
note:admin视图函数
"""


from flask import Flask,request,redirect,url_for
from flask.ext.admin import Admin, BaseView, expose
from app import admin_app,db
from app.models import Article,Category,User,User_msg,Category_attribute,Comment
from flask.ext.admin.contrib.sqla import ModelView
from flask.ext.login import current_user,login_required
from wtforms.validators import Required
from wtforms import TextAreaField
from wtforms.widgets import TextArea
from jinja2 import Markup
from flask_admin.form import rules
from flask.ext.admin.contrib.fileadmin import FileAdmin


# class admin_index_view(BaseView):
# 	@expose('/')
# 	@login_required
# 	def index(self):
# 		return '<a href="/admin">Click me to get to Admin!</a>'


#增加一个导航
# admin_app.add_view(admin_index_view(name=u'主页'))

# admin_app.add_view(ModelView(User,db.session,name=u'用户管理'))

class CKTextAreaWidget(TextArea):
	def __call__(self, field, **kwargs):
		if kwargs.get('class'):
			kwargs['class'] += ' ckeditor'
		else:
			kwargs.setdefault('class', 'ckeditor')
		return super(CKTextAreaWidget, self).__call__(field, **kwargs)

class CKTextAreaField(TextAreaField):
	widget = CKTextAreaWidget()

class ModelView_User(ModelView):
	#认证
	def is_accessible(self):
		return current_user.is_authenticated

	#跳转
	def inaccessible_callback(self, name, **kwargs):
		return redirect(url_for('auth.login', next=request.url))

	#是否允许创建、删除、编辑、只读
	can_create = True
	# can_delete = False
	# can_edit = False
	# can_view_details = True
	#每页记录显示行数
	page_size = 50

	#删除行
	# column_exclude_list = ['password', ]

	#搜索列表
	column_searchable_list = ['username', 'name']
	#筛选列表
	# column_filters = ['location']
	#直接在视图中启用内联编辑，快速编辑行
	column_editable_list = ['name']
	#直接在当前页弹框 进行 编辑或者添加，  不是很大用
	# create_modal = True
	# edit_modal = True
	#移除创建的字段
	form_excluded_columns = ['comments','last_seen', 'avatar_hash','article_id','followed','followers']
	#form  WTForms 表单验证，详细验证规则 看WTForms 
	form_args={'name':{'label':u'名字','validators':[Required()]}}
	#制定form渲染参数
	form_widget_args = {
					'about_me': {
					'rows': 10,
					'style': 'color: black'
						}
					}
	#当表单包含外键时，使用Ajax加载那些相关的模型（没会用）
	# form_ajax_refs = {
	# 	'role_id': {
	# 		'fields': ['first_name', 'last_name', 'email'],
	# 		'page_size': 10
	# 		}
	# 	}
	#过滤ajax加载的结果 没会用
	# form_ajax_refs = {'active_user': QueryAjaxModelLoader('user', db.session, User,filters=["is_active=True", "id>1000"])}


	# select choices   没有select选择器  不知道效果
	# form_choices = {
	# 	'title': [
 #    		('MR', 'Mr'),
 #        	('MRS', 'Mrs'),
 #        	('MS', 'Ms'),
 #        	('DR', 'Dr'),
 #        	('PROF', 'Prof.')
 #        	]
 #        }
 	
    
	#列表行重写
	column_labels = {
		'id':u'序号',
		'username' : u'用户账号',
		'password_hash':u'密码',
		'name':u'真实姓名',
		'location':u'地址',
		'about_me':u'自我简介',
		'avatar_hash':u'头像加密值',
    }
	column_list = ('id', 'username','name',
				'location','about_me','avatar_hash')
	#JS文件
	# extra_js = [url_for('static',filename='ckeditor/ckeditor.js')]
	extra_js = ['/static/ckeditor/ckeditor.js']
	form_overrides ={'about_me':CKTextAreaField}

	#头像
	def _list_thumbnail(view, context, model, name):
		if not model.avatar_hash:
			return ''
		return Markup('<img src="http://www.gravatar.com/avatar/%s?d=identicon&s=32"' % model.avatar_hash)

	def _list_about_me_sub(view, context, model, name):
		if model.about_me:
			return model.about_me[0:50]
		return model.about_me
	#格式化列
	column_formatters = {'avatar_hash': _list_thumbnail,'about_me':_list_about_me_sub}

	# form_create_rules = ('location', rules.HTML('<input type="text" />'), 'username', 'about_me')


	def __init__(self, session, **kwargs):
		super(ModelView_User, self).__init__(User, session, **kwargs)




	



#文件管理
class Admin_file(FileAdmin):
	#认证
	def is_accessible(self):
		return current_user.is_authenticated

	#跳转
	def inaccessible_callback(self, name, **kwargs):
		return redirect(url_for('auth.login', next=request.url))

import os.path as op
path = op.join(op.dirname(__file__), 'static/uploads')


#用户退出
class Admin_logout(BaseView):
	@expose('/')
	def index(self):
		return redirect(url_for('auth.logout'))



admin_app.add_view(ModelView_User(db.session,name=u'用户管理'))
admin_app.add_view(ModelView(Article,db.session,name=u'文章管理'))
admin_app.add_view(ModelView(Category,db.session,name=u'栏目管理'))
admin_app.add_view(ModelView(User_msg,db.session,name=u'留言管理'))
admin_app.add_view(ModelView(Category_attribute,db.session,name=u'栏目属性表(不要随意更改)'))
admin_app.add_view(ModelView(Comment,db.session,name=u'评论管理'))
admin_app.add_view(Admin_file(path,'/static', name=u'静态文件'))
admin_app.add_view(Admin_logout(name=u'退出'))





