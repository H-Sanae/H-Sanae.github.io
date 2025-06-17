import pymysql
import datetime

def dbconnect():
    # 连接database
    conn = pymysql.connect(
        host="127.0.0.1",
        user="root",
        password="root123456",
        database="test",
        port=3306,
        charset="utf8"
    )
    print("连接数据库成功")
    return conn


def jiegou():
    sql="""create table if not exists MovieType(
    tid int primary key,
    tname varchar(20),
    tcontent varchar(200),
    tdate datetime
    )"""
    # 连接database
    conn = dbconnect()
    jianbiao=conn.cursor()
    jianbiao.execute(sql)
    print("MovieType表创建完成")
    jianbiao.close()
    conn.close()

def edit():
    print("示例: 1,喜剧,这是一个搞笑的电影")
    data=input("请输入要插入的数据（逗号隔开）:").split(",")
    sql=f"insert into MovieType values({data[0]},'{data[1]}','{data[2]}',now())"
    conn = dbconnect()
    idata=conn.cursor()
    res=idata.execute(sql)
    if res>0:
        print("添加成功")
    else:
        print("添加失败")
    conn.commit()
    idata.close()
    conn.close()

def cha():
    sql="select * from MovieType"
    conn=dbconnect()
    show=conn.cursor()
    show.execute(sql)
    res=show.fetchall()
    for i in res:
        print(i[0],i[1],i[2],datetime.datetime.strftime(i[3],"%Y年%m月%d日"))
    show.close()
    conn.close()

if __name__=="__main__":
    # jiegou()
    edit()
    cha()
