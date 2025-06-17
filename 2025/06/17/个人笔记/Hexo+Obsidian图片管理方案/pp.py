from flask import Flask,render_template,request
from DAL import MovieTypeDAL,MovieDAL
from Model import MovieType,Movie

app=Flask(__name__)
mtdal=MovieTypeDAL()
mdal=MovieDAL()

@app.route("/")
def index():
    return "<a href='/list'><img src='/static/py11.png'></a>"

@app.route("/list")
def list():
    result=mtdal.select()
    # print(result)

    return render_template("list.html",info=result)

@app.route("/add")
def add():
    return render_template("add.html")


@app.route("/addSubmit",methods=["POST"])
def addSubmit():
    tid=request.form.get("tid")
    tname=request.form.get("tname")
    tcontent=request.form.get("tcontent")
    mt=MovieType(tid,tname,tcontent)
    result=mtdal.insert(mt)
    if result>0:
        return "录入成功 <a href='/list'>刷新</a>"
        # return "<script> alert('插入成功'); window.open('/list'); </script>"
    else:
        return "录入失败  <a href='/list'>刷新</a>"
    
@app.route("/update/<tid>")
def update(tid):
    result=mtdal.getMTByTid(tid)
    return render_template("update.html",info=result)

@app.route("/updateSubmit",methods=["POST"])
def updateSubmit():
    tid=request.form.get("tid")
    tname=request.form.get("tname")
    tcontent=request.form.get("tcontent")
    mt=MovieType(tid,tname,tcontent)
    result=mtdal.update(mt)
    if result>0:
        return "修改成功 <a href='/list'>刷新</a>"
        # return "<script> alert('插入成功'); window.open('/list'); </script>"
    else:
        return "保留原有信息  <a href='/list'>刷新</a>"

@app.route("/delete/<tid>")
def delete(tid):
    result=mtdal.delete(tid)
    if result>0:
        return "删除成功 <a href='/list'>刷新</a>"
        # return "<script> alert('插入成功'); window.open('/list'); </script>"
    else:
        return "删除失败  <a href='/list'>刷新</a>"
    
@app.route("/addMovie")
def addMovie():
    result=mtdal.select()
    return render_template("addMovie.html",info=result)


@app.route("/movieList/<tid>")
def movieList(tid):
    result=mdal.getMovieByTid(tid)
    return render_template("movieList.html",info=result)

@app.route("/addMovieSubmit",methods=["POST"])
def addMovieSubmit():
    id=request.form.get("id")
    title=request.form.get("title")
    mdate=request.form.get("mdate")
    score=request.form.get("score")
    tid=request.form.get("tid")
    m=Movie(id,title,mdate,score,tid)
    result=mdal.insert(m)
    if result>0:
        return f"添加成功 <a href='/movieList/{tid}'>刷新</a>"
    else:
        return f"添加失败 <a href='/movieList/{tid}'>刷新</a>"

if __name__=="__main__":
    app.run(host="127.0.0.1",port=5000,debug=True)