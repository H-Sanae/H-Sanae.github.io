from Model import MovieType
from DAL import MovieTypeDAL
import datetime

mtdal=MovieTypeDAL()
menu="""\n-------------⾖瓣⽹管理系统-----------------
===========功能菜单===========
1 录⼊电影类型信息
2 修改电影类型信息
3 删除电影类型信息
4 显⽰所有电影类型信息
0 退出系统
============================="""

# 1.录⼊电影类型信息
def option1():
    tid=input("请输⼊编号：")
    res=mtdal.showformtid(tid)
    if not res:
        tname=input("请输⼊名称：")
        tcontent=input("请输⼊内容：")
        mt=MovieType(tid,tname,tcontent)
        res= mtdal.insert(mt)
        if res>0:
            print("录入成功")
        else:
            print("录入失败")
    else:
        print("编号已存在！")
    input("\n按下回车键返回主菜单..")
        

# 2.修改电影类型信息
def option2():
    tid=input("请输入修改编号：")
    print("\n编号 名称 内容 创建⽇期")
    res=mtdal.showformtid(tid)
    if not res:
        print("此电影类型不存在！")
        input("\n按下回车键返回主菜单..")
        return
    print(res[0],res[1],res[2],datetime.datetime.strftime(res[3],"%Y年%m月%d日\n"))

    tname=input("请输入修改名称（若不修改则直接回车）：")
    tcontent=input("请输⼊修改内容（若不修改则直接回车）：")
    mt=MovieType(tid,tname,tcontent)
    res=mtdal.update(mt)
    print(f"{res[0]}个名称被修改，{res[1]}个内容被修改")
    input("\n按下回车键返回主菜单..")

# 3.删除电影类型信息
def option3():
    tid=input("请输入删除编号：")
    res1=mtdal.showformtid(tid)
    if not res1:
        print("此电影类型不存在！")
        input("\n按下回车键返回主菜单..")
        return
    
    print("\n编号 名称 内容 创建⽇期")
    print(res1[0],res1[1],res1[2],datetime.datetime.strftime(res1[3],"%Y年%m月%d日\n"))
    esc=input("确认要删除吗? y/n:")
    if esc.lower() == 'y' or esc.lower() == 'yes':
        res2=mtdal.delet(tid)
        if res2>0 :
            print("删除成功")
        else:
            print("删除失败")
    input("\n按下回车键返回主菜单..")

# 4.显示所有电影类型信息
def option4():
    print("\n编号 名称 内容 创建⽇期")
    res=mtdal.showall()
    for i in res:
        print(i[0],i[1],i[2],datetime.datetime.strftime(i[3],"%Y年%m月%d日"))
    input("\n按下回车键返回主菜单..")

# 0.退出系统
def option0():
    esc=input("请问是否退出? y/n:")
    if esc.lower() == 'y' or esc.lower() == 'yes':
        print("已成功退出")
        exit()
    else:
        input("\n按下回车键返回主菜单..")

if __name__=="__main__":
    while True:
        print(menu)
        option=input("请输⼊操作选项：")
        if option=="1":
            option1()
        elif option=="2":
            option2()
        elif option=="3":
            option3()
        elif option=="4":
            option4()
        elif option=="0":
            option0()
        else:
            print("无效操作，请重新输入！")
            input("按下回车键继续..")
        