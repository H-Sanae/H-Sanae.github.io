# 上机练习8
# 1. 定义⼀个⽔果类，定义属性（名称和颜⾊），使⽤魔法⽅法，然后通过⽔果类，创建
# 苹果对象、橘⼦对象、西⽠对象并分别添加上颜⾊属性，定义⼀个⽅法分别输出
# 如：
# 红⾊的苹果真好吃
# 橙⾊的橘⼦真好吃
# 绿⾊的西⽠真好吃
# 定义
# class shuiguo:
#     color=""
#     name=""

#     def __init__(self,color1,name1):
#         self.color=color1
#         self.name=name1

#     def saygood(self):
#         print(f"{self.color}的{self.name}真好吃")


# if  __name__=="__main__":
#     pg=shuiguo("红色","苹果")
#     pg.saygood()
#     jz=shuiguo("橙色","橘子")
#     jz.saygood()
#     xg=shuiguo("绿色","西瓜")
#     xg.saygood()


# 2. 猫类Cat。属性:⽑的颜⾊color，品种breed，亲和度love。⽅法:吃饭eat()
# 狗类Dog。属性:⽑的颜⾊color，品种breed，忠诚度loyal。⽅法:吃饭eat()
# 要求: 使⽤封装、继承和多态
# 根据以上要求抽取⽗类为Animal
# 重写eat⽅法
# 输出打印如下：
# 有⼀只亲和度是10级的花⾊的波斯猫正在吃⻥.....
# 有⼀只忠诚度是9级的⿊⾊的藏獒正在啃⻣头.....
# 有⼀只亲和度是8级的⽩⾊的加菲猫正在吃⻥.....
# 有⼀只忠诚度是6级的棕⾊的茶杯⽝正在啃⻣头.....

# class Animal:
#     color=""
#     breed=""

#     def __init__(self,color,breed):
#         self.color=color
#         self.breed=breed

#     def eat(self):
#         pass

# class Cat(Animal):
#     love=0
#     def __init__(self,qhd,color,breed):
#         super().__init__(color,breed)
#         self.love=qhd
#     def eat(self):
#         print(f"有⼀只亲和度是{self.love}级的{self.color}的{self.breed}正在吃⻥.....")
        
# class Dog(Animal):
#     loyal=0
#     def __init__(self,zcd,color,breed):
#         super().__init__(color,breed)
#         self.loyal=zcd
#     def eat(self):
#         print(f"有⼀只忠诚度是{self.loyal}级的{self.color}的{self.breed}正在啃骨头.....")

# list=[Cat(10,"花⾊","波斯猫"),
#       Dog(9,"黑色","藏獒"),
#       Cat(8,"白色","加菲猫"),
#       Dog(6,"棕色","茶杯犬")]
# for i in list:
#     i.eat()


#标准库：csv time datetime
#扩展库：pymysql pyoracle
#数据类型：bool int float str list tuple set dict class

# date time datetime
import time
import datetime
import pymysql

# d1=time.localtime()
# print(d1)
# s1=time.strftime("%Y年%m-%d",d1)
# print(s1)
# f1=time.perf_counter()
# s2="20090912"
# d2=time.strptime(s2,"%Y%m%d")
# print(d2)
# time.sleep(3)
# print("hello")
# f2=time.perf_counter()
# print(f2-f1)
# d1=datetime.datetime.now()
# print(d1)
# s1=datetime.datetime.strftime(d1,"%Y年")
# print(s1)
# s2="20090912"
# d2=datetime.datetime.strptime(s2,"%Y%m%d")
# print(d2)

def jiegou():
    sql="""create table student (
	sno int primary key,
	sname varchar(10),
	sdate datetime
    )"""
    conn=pymysql.connect(host="127.0.0.1",user="root",password="root123456",
                         database="test",port=3306,charset="utf8")
    print("链接数据库成功")
    baoma=conn.cursor()
    baoma.execute(sql)
    print("操作成功")

    baoma.close()

    conn.close()
    print("关闭数据库成功")


def edit():
    sno=input("请输入学号：")
    sname=input("请输入名字：")
    sql=f"insert into student values({sno},'{sname}',now())"
    conn=pymysql.connect(host="127.0.0.1",user="root",password="root123456",
                         database="test",port=3306,charset="utf8")
    print("链接数据库成功")
    baoma=conn.cursor()
    result=baoma.execute(sql)
    if result>0:
        print("添加成功")
    else:
        print("添加失败")

    conn.commit()
    
    baoma.close()

    conn.close()
    print("关闭数据库成功")

def cha():
    sql="select * from student"
    conn=pymysql.connect(host="127.0.0.1",user="root",password="root123456",
                         database="test",port=3306,charset="utf8")
    print("链接数据库成功")
    baoma=conn.cursor()
    baoma.execute(sql)
    result=baoma.fetchall()
    print("学号 姓名 日期")
    for i in result:
        print(i[0],i[1],datetime.datetime.strftime(i[2],"%Y年%m月%d日"))
        # print(type(i[2]))

    baoma.close()

    conn.close()
    print("关闭数据库成功")

if __name__=="__main__":
    # jiegou()
    # edit()
    cha()