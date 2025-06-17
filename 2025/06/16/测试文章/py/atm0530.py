#全局变量
data=[{'id':'1001','passwd':'123456','bat':'1000'},
{'id':'1002','passwd':'123456','bat':'2000'},
{'id':'1003','passwd':'123456','bat':'3000'},
{'id':'1004','passwd':'123456','bat':'4000'}]

menu="""----------操作⻚⾯----------
1.存款
2.取款
3.查询余额
4.转账
5.退出
----------------------------"""

#函数
#存款
def cunMoney(ka1):
    # print(ka1)
    # pass
    money=input("请输⼊存款⾦额：")
    ka1["bat"]=str(int(ka1["bat"])+int(money))
    print(f"您已成功存款{money}，您当前的余额为：{ka1['bat']}")


#取款
def quMoney():
    pass

#查询
def chaMoney():
    pass

#转账
def zhuanMoney():
    pass


#入口
if __name__=="__main__":

    ka={}
    print("---------- 欢迎使⽤ATM机 ----------")
    userName=input("请输⼊账号：")
    userPwd=input("请输⼊密码：")
    #标记法
    isLogin=False
    #找
    for i in data:
        if i["id"]==userName and i["passwd"]==userPwd:
            ka=i
            isLogin=True
            # print("登录成功，请进⾏下列操作：")
            break
        # else:
        #     print("账号或密码错误")

    #输出
    if isLogin==True:
        print("登录成功，请进⾏下列操作：")
        while True:
            print(menu)
            option=input("请输⼊操作选项：")
            if option=="1":
                cunMoney(ka)
            elif option=="2":
                quMoney()
            elif option=="3":
                chaMoney()
            elif option=="4":
                zhuanMoney()
            elif option=="5":
                answer=input("请问是否退出? y/n：")
                if answer=="y" or answer=="Y" or answer=="yes":
                    print("已成功退出，请取回您的银⾏卡")
                    break
            else:
                print("输⼊错误")

    else:
        print("账号或密码错误")

