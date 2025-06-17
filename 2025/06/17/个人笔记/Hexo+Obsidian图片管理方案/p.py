from flask import Flask, render_template, request
from DAL import MovieTypeDAL
from Model import MovieType

mtdal=MovieTypeDAL()
app = Flask(__name__)

@app.route("/")
def index():
    res=mtdal.showall()
    return render_template('home.html',info=res)

@app.route("/list")
def list():
    res=mtdal.showall()
    return render_template('list.html',info=res)

@app.route("/add")
def add():
    return render_template('add.html')

@app.route("/addSubmit",methods=["POST"])
def addSubmit():
    tid=request.form.get("tid")
    exist=mtdal.showformtid(tid)
    if not exist:
        tname=request.form.get("tname")
        tcontent=request.form.get("tcontent")
        mt=MovieType(tid,tname,tcontent)
        res=mtdal.insert(mt)
        if res>0:
            return "录入成功 <br><a href='/list'>刷新</a>"
        else:
            return "录入失败 <br><a href='/list'>刷新</a>"
    else:
        return "录入失败，编号已存在！ <br><a href='/list'>刷新</a>"

@app.route("/update/<tid>")
def update(tid):
    res=mtdal.showformtid(tid)
    return render_template('update.html',info=res)

@app.route("/updateSubmit",methods=["POST"])
def updateSubmit():
    tid=request.form.get("tid")
    tname=request.form.get("tname")
    tcontent=request.form.get("tcontent")
    mt=MovieType(tid,tname,tcontent)
    res=mtdal.update(mt)
    if res[0]>0:
        edname="名称已修改"
    else:
        edname="名称未修改"
    if res[1]>0:
        edcontent="内容已修改"
    else:
        edcontent="内容未修改"
    return f"{edname}<br>{edcontent}<br><a href='/list'>刷新</a>"
    
@app.route("/delete/<tid>")
def delete(tid):
    res=mtdal.delet(tid)
    if res>0:
        return "删除成功 <br><a href='/list'>刷新</a>"
    else:
        return "删除失败 <br><a href='/list'>刷新</a>"

if __name__=="__main__":
    app.run(host="127.0.0.1",port=5000,debug=True)