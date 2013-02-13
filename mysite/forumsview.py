from django.shortcuts import render_to_response
import MySQLdb
from django.http import HttpResponse,HttpResponseRedirect
from django.core.validators import email_re
from django.core.mail import send_mail
from django.views.decorators.csrf import csrf_exempt
import datetime

def forum(request,offset):
    offset=int(offset)
    if "umail" not in request.session or request.session['umail']=="":
        return HttpResponseRedirect("/login/")
    else:
        db = MySQLdb.connect(user='root', db='mysite', passwd='', host='')
        cursor = db.cursor()
        sql="select cid from enrollments where cid='%d' and uid='%s'" %(offset,request.session['umail'])
        cursor.execute(sql)
        x = [row[0] for row in cursor.fetchall()]
        if not x:
            msg="not enrolled to this course.. go back"
        else:
            sql="select fno,cid,owner,fname,no_of_posts,start_date from forums where cid='%d'"%(offset)
            cursor.execute(sql)
            results=cursor.fetchall()
            db.close()
            return render_to_response('forums.html',{'results':results})
        db.close()
        return render_to_response('all courses.html',{'msg':msg})

def addforum(request):
    if "umail" not in request.session or request.session['umail']=="":
        return HttpResponseRedirect("/login/")
    else:
        cid=int(request.GET['cid'])
        db = MySQLdb.connect(user='root', db='mysite', passwd='', host='')
        cursor = db.cursor()
        sql="select cid from enrollments where cid='%d' and uid='%s'" %(cid,request.session['umail'])
        cursor.execute(sql)
        x = [row[0] for row in cursor.fetchall()]
        if not x:
            msg="not enrolled to this course.. go back"
        else:
            dt=datetime.date.today()
            fname=str(request.GET['fname'])
            sql="insert into forums (cid,owner,fname,start_date) \
            values('%d','%s','%s','%s')" %(cid,request.session['umail'],fname,dt)
            cursor.execute(sql)
            db.commit()
            db.close()
            return HttpResponse("forum added")
        db.close()
        return HttpResponse(x)

def addpost(request):
    if "umail" not in request.session or request.session['umail']=="":
        return HttpResponseRedirect("/login/")
    else:
        cid=int(request.GET['cid'])
        db = MySQLdb.connect(user='root', db='mysite', passwd='', host='')
        cursor = db.cursor()
        sql="select cid from enrollments where cid='%d' and uid='%s'" %(cid,request.session['umail'])
        cursor.execute(sql)
        x = [row[0] for row in cursor.fetchall()]
        if not x:
            msg="not enrolled to this course.. go back"
        else:
            dt=datetime.date.today()
            fno=int(request.GET["fno"])
            content=str(request.GET['content'])
            sql="insert into forumsposts (cid,fno,posted_by,posted_on,content) \
            values('%d','%d','%s','%s','%s')" %(cid,fno,request.session['umail'],dt,content)
            cursor.execute(sql)
            db.commit()
            db.close()
            return HttpResponse("post added")
        db.close()
        return HttpResponse(x)


def viewforum(request):
    if "umail" not in request.session or request.session['umail']=="":
        return HttpResponseRedirect("/login/")
    else:
        cid=int(request.GET['cid'])
        db = MySQLdb.connect(user='root', db='mysite', passwd='', host='')
        cursor = db.cursor()
        sql="select cid from enrollments where cid='%d' and uid='%s'" %(cid,request.session['umail'])
        cursor.execute(sql)
        x = [row[0] for row in cursor.fetchall()]
        if not x:
            msg="not enrolled to this course.. go back"
        else:
            fno=int(request.GET["fno"])
            sql="select pno,cid,fno,posted_by,posted_on,likes from forumsposts \
                 where fno='%d'"%(fno)
            cursor.execute(sql)
            results=cursor.fetchall()
            return render_to_response('viewforum.html',{'results':results,'cid':cid,'fno':fno})

