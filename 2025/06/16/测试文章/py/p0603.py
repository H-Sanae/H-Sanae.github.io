import csv

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
    try:
        money=input("请输⼊存款⾦额：")
        ka1["bat"]=str(int(ka1["bat"])+int(money))
        # n=100/int(money)
        if int(money)<0 or int(money)%100!=0:
            raise Exception("大于0的100倍数")
        print(f"您已成功存款{money}，您当前的余额为：{ka1['bat']}")
    except ValueError:  #catch Exception
        print("只能输入整数")
    except ZeroDivisionError:
        print("不能输入0")
    except Exception as e:
        print("其他错误，请联系管理员",e)


#取款
def quMoney(ka1):
    money=input("请输⼊取款⾦额：")
    if int(ka1["bat"])<int(money):
        print("余额不足")
        return
    
    ka1["bat"]=str(int(ka1["bat"])-int(money))
    print(f"您已成功取款{money}，您当前的余额为：{ka1['bat']}")

#查询
def chaMoney(ka1):
    print(f"您当前的余额为：{ka1['bat']}")

#转账
def zhuanMoney(ka1):
    zid=input("请输⼊收款账号：")
    if zid==ka1["id"]:
        print("不能给自己转账")
        return
    
    #找
    isExist=False
    zka={}
    for i in data:
        if i["id"]==zid:
            zka=i
            isExist=True
            break

    #输出
    if isExist==False:
        print("账号不存在")
        return
    
    money=input("请输⼊转账⾦额：")
    if int(ka1["bat"])<int(money):
        print("转账余额不足")
        return
    
    #开始转账
    ka1["bat"]=str(int(ka1["bat"])-int(money))
    zka["bat"]=str(int(zka["bat"])+int(money))
    print(f"您已成功转账{money}，您当前余额为：{ka1['bat']}")
    print(zka["bat"])

#把data保存到csv
def save():
    with open("/root/python/user.csv",mode="w") as f:
        result=csv.DictWriter(f,fieldnames=["id","passwd","bat"])
        result.writeheader()
        result.writerows(data)
        f.close()

#读取csv覆盖data
def init():
    with open("/root/python/user.csv",mode="r") as f:
        result=csv.DictReader(f)
        data.clear()
        for i in result:
            data.append(i)
        f.close()

#入口
if __name__=="__main__":

    #获取最新数据
    init()

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
                quMoney(ka)
            elif option=="3":
                chaMoney(ka)
            elif option=="4":
                zhuanMoney(ka)
            elif option=="5":
                answer=input("请问是否退出? y/n：")
                if answer=="y" or answer=="Y" or answer=="yes":
                    print("已成功退出，请取回您的银⾏卡")
                    #保存
                    save()
                    break
            else:
                print("输⼊错误")

    else:
        print("账号或密码错误")

