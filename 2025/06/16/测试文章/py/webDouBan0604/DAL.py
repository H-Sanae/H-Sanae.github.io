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
        sql="select * from MovieType"
        return self.chaAll(sql)