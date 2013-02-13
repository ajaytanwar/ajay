from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

from views import *
from courseview import *
from forumsview import *

urlpatterns = patterns('',
    ('^home/$', home),
    ('^signup/$', signup),
    ('^login/$', login),
    ('^loggedin/$', loggedin),
    ('^adduser/$', adduser),
    ('^trial/$', trial),
    ('^signuserin/$', signuserin),
    ('^logout/$', logout),
    ('^tryhtml/$', tryhtml),
    ('^allcourses/$', allcourses),
    ('^createcourse/$', createcourse),
    (r'^course/(\d+)/$', course),
    (r'^enroll/(\d+)/$', enroll),
    ('^addcourse/$', addcourse),
    (r'^unenroll/(\d+)/$', unenroll),
    ('^submitrating/$', submitrating),
    ('^bycategory/$',bycategory),
    ('^yourcontents/$',yourcontents),
    (r'^deletecourse/(\d+)/$', deletecourse),
    (r'^viewcourse/(\d+)/$', viewcourse),
    (r'^byuser/(\S+)/$', byuser),
    (r'^forum/(\d+)/$', forum),
    ('^addforum/$',addforum),
    ('^viewforum/$',viewforum),
    ('^addpost/$',addpost),



)
