from Model import MovieType
from DAL import MovieTypeDAL
import datetime

mtdal=MovieTypeDAL()
menu="""-------------⾖瓣⽹管理系统-----------------
===========功能菜单===========
1 录⼊电影类型信息
2 修改电影类型信息
3 删除电影类型信息
4 显⽰所有电影类型信息
0 退出系统
============================="""

if __name__=="__main__":
    while True:
        print(menu)
        option=input("请输⼊操作选项：")
        if option=="1":
            tid=input("请输⼊编号：")
            tname=input("请输⼊名称：")
            tcontent=input("请输⼊内容：")
            mt=MovieType(tid,tname,tcontent)
            result= mtdal.insert(mt)
            if result>0:
                print("录入成功")
            else:
                print("录入失败")
        elif option=="4":
            print("编号 名称 内容 创建⽇期")
            result=mtdal.select()
            for i in result:
                print(i[0],i[1],i[2],datetime.datetime.strftime(i[3],"%Y年%m月%d日"))

