from django.shortcuts import render_to_response
import MySQLdb
from django.http import HttpResponse,HttpResponseRedirect
from django.core.validators import email_re
from django.core.mail import send_mail
from django.views.decorators.csrf import csrf_exempt
import datetime

def submitrating(request):
    score=float( request.GET["score"] )
    cid=int( request.GET["cid"] )
    db = MySQLdb.connect(user='root', db='mysite', passwd='', host='')
    cursor = db.cursor()
    sql="select rating,raters from courses where cid='%d'"%(cid)
    cursor.execute(sql)
    result=cursor.fetchall()
    row=result[0]
    rating = row[0]
    raters = row[1]
    raters=raters+1
    rating=(rating*(raters-1)+score)/raters
    sql="update courses set rating='%f',raters='%d' where cid='%d'"%(rating,raters,cid)
    cursor.execute(sql)
    db.commit()
    db.close()
    return HttpResponse(rating)

def course(request, offset):
    if "umail" not in request.session:
        return HttpResponseRedirect("/login/")
    else:
        offset=int(offset)
        db = MySQLdb.connect(user='root', db='mysite', passwd='', host='')
        cursor = db.cursor()
        sql="select owner from courses where cid='%d'"%(offset)
        cursor.execute(sql)
        result=cursor.fetchall()
        owner=result[0][0]
        db.close()
        if request.session['umail']!=owner:
            return HttpResponseRedirect("/viewcourse/%d"%(offset))
        else:
            return HttpResponseRedirect("/viewcourse/%d"%(offset)) #to be changed to owners view


def viewcourse(request,offset):
    offset=int(offset)
    if "umail" not in request.session:
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
            sql="select l.*,cname from lessons as l,courses as c where l.cid='%d' \
                    and c.cid ='%d' and l.submitted_by=c.owner order by lno"%(offset,offset)
            cursor.execute(sql)
            results=cursor.fetchall()
            sql="select l.*,cname from lessons as l,courses as c where l.cid='%d' \
                    and c.cid ='%d' and l.submitted_by<>c.owner order by lno"%(offset,offset)
            cursor.execute(sql)
            newresults=cursor.fetchall()
            db.close()
            return render_to_response('viewcourse.html',{'cid':offset,'results':results,'newresults':newresults})
        return render_to_response('all courses.html',{'msg':msg})


