# -*- coding:utf-8 -*-
from django.urls import path, re_path, include
from . import views

urlpatterns = [
    # http://localhost:8000/api/user/
    path('v1/test', views.TestView.as_view(), name="server-test"),
]
