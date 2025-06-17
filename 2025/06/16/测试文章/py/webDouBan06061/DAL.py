import pymysql
class DBHelper:
    #打开数据库
    def openDB(self):
        #把局部变量变成全局变量
        global conn
        conn=pymysql.connect(host="127.0.0.1",user="root",password="root123456",
                            database="test",port=3306,charset="utf8")
        global baoma
        baoma=conn.cursor()


    #关闭数据库
    def closeDB(self):
        baoma.close()
        conn.close()

    def edit(self,sql):
        self.openDB()
        result=baoma.execute(sql)
        conn.commit()
        self.closeDB()
        return result
        
    def chaOne(self,sql):
        self.openDB()
        baoma.execute(sql)
        result=baoma.fetchone()
        self.closeDB()
        return result
    
    def chaAll(self,sql):
        self.openDB()
        baoma.execute(sql)
        result=baoma.fetchall()
        self.closeDB()
        return result
     
class MovieTypeDAL(DBHelper):
    #录入
    def insert(self,mt):
        sql=f"insert into MovieType values({mt.tid},'{mt.tname}','{mt.tcontent}',now())"
        return self.edit(sql)
    
    #查询
    def select(self):
        sql="select *,DATE_FORMAT(tdate,'%Y年%m月%d日')  from MovieType"
        return self.chaAll(sql)

    def getMTByTid(self,tid):
        sql=f"select * from MovieType where tid={tid}"
        return self.chaOne(sql)
    
    def update(self,mt):
        sql=f"update MovieType set tname='{mt.tname}',tcontent ='{mt.tcontent}' where tid={mt.tid}"
        return self.edit(sql)
    
    def delete(self,tid):
        sql=f"delete from MovieType where tid={tid}"
        return self.edit(sql)
    

class MovieDAL(DBHelper):
    #插入
    def insert(self,m):
        sql=f"insert into Movie values({m.id},'{m.title}','{m.mdate}',{m.score},{m.tid})"
        return self.edit(sql)
       
    #查询
    def getMovieByTid(self,tid):
        sql=f"""
        select id,title,mdate,score,tname from MovieType mt 
        inner join Movie m on mt.tid=m.tid 
        where mt.tid={tid}
            """
        return self.chaAll(sql)
        

