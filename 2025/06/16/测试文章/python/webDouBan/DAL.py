import pymysql
class DBHelper:
    #打开数据库
    def openDB(self):
        #把局部变量变成全局变量
        global conn
        conn=pymysql.connect(host="127.0.0.1",
                             user="root",
                             password="root123456",
                            database="test",
                            port=3306,charset="utf8")
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
    # 1.录⼊电影类型信息
    def insert(self,mt):
        sql=f"insert into MovieType values({mt.tid},'{mt.tname}','{mt.tcontent}',now())"
        return self.edit(sql)
    
    # 2.1 显示tid的数据内容
    def showformtid(self,tid):
        sql=f"select * from MovieType where tid='{tid}'"
        return self.chaOne(sql)
    
    # 2.2修改电影类型信息
    def update(self,mt):
        # sql=f"update MovieType set tname='{mt.tname}',tcontent='{mt.tcontent}' where tid={mt.tid}"
        # res=self.edit(sql)
        # return res

        edtname=0
        edtcontent=0
        if(mt.tname!=""):
            sql1=f"update MovieType set tname='{mt.tname}' where tid={mt.tid}"
            edtname=self.edit(sql1)

        if(mt.tcontent!=""):
            sql2=f"update MovieType set tcontent='{mt.tcontent}' where tid={mt.tid}"
            edtcontent=self.edit(sql2)

        return edtname,edtcontent
        
    # 3.删除电影类型信息
    def delet(self,tid):
        sql=f"delete from MovieType where tid={tid}"
        return self.edit(sql)

    # 4.显示所有电影类型信息
    def showall(self):
        sql="select *,DATE_FORMAT(TDATE,'%Y年%m月%d日') from MovieType"
        return self.chaAll(sql)
    