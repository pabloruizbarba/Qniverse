"""qniverse URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
import webserviceapp.views as views

from webserviceapp import views

urlpatterns = [
    path('v1/questions/', views.add_question),
    path('v1/update-user/', views.update_user),
    path('v1/questions-to-validate/', views.questions_to_validate),
    path('admin/', admin.site.urls),
]
