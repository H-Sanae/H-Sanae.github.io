import csv

data=[{'id':'1001','passwd':'123456','bat':'1000'},
 {'id':'1002','passwd':'123456','bat':'2000'},
 {'id':'1003','passwd':'123456','bat':'3000'},
 {'id':'1004','passwd':'123456','bat':'4000'}]
userdata={}

# 操作页面
def CaoZuoYeMian(userdata):
    menu="""----------操作⻚⾯----------
1.存款
2.取款
3.查询余额
4.转账
5.退出
----------------------------"""
    print(menu)
    while True:
        ctrl = input("请输入操作选项:")
        if ctrl == '1':
            CunKuan(userdata)
        elif ctrl == '2':
            QuKuan(userdata)
        elif ctrl == '3':
            ChaXun(userdata)
        elif ctrl == '4':
            ZhuanZhang(userdata)
        elif ctrl == '5':
            TuiChu(userdata)
        else:
            print("无效的操作选项，请重新输入！")
# 存款
def CunKuan(userdata):
    money=input("请输入存款金额:")
    money=checkMoney(money)
    userdata["bat"]=str(float(userdata["bat"])+money)
    print(f"您已成功存款{money}，您当前的余额为：{userdata['bat']}")
    inputToReturn()

# 取款
def QuKuan(userdata):
    money=input("请输入取款金额:")
    money=checkMoney(money)
    if float(userdata["bat"]) >= money:
        userdata["bat"]=str(float(userdata["bat"])-money)
        print(f"您已成功取款{money}，您当前的余额为：{userdata['bat']}")
        inputToReturn()
    else:
        print("您的余额不足！")
        inputToReturn()

# 查询
def ChaXun(userdata):
    print(f"您当前的余额为：{userdata['bat']}")
    inputToReturn()

# 转账
def ZhuanZhang(userdata):
    skzh=input("请输入收款账号:")
    if skzh==userdata['id']:
        print("收款账号不能是自己！")
        inputToReturn()
    for i in data:
        if i['id']==skzh:
            money=input("请输入转帐金额：")
            try:
                money=float(money)
                if money <=0 :
                    print("转账金额必须大于0!")
                    inputToReturn()
            except ValueError:
                print("输入不合法！")
                inputToReturn()

            if float(userdata["bat"]) > money:
                userdata["bat"]=str(float(userdata["bat"])-money)
                i["bat"]=str(float(i["bat"])+money)
                print(f"您已成功转帐{money}，您当前的余额为：{userdata['bat']}")
                inputToReturn()
            else:
                print("您的余额不足！")
                inputToReturn()

    print("收款账号不存在！")
    inputToReturn()
    
# 保存退出
def TuiChu(userdata):
    esc=input("请问是否退出? y/n:")
    if esc.lower() == 'y' or esc.lower() == 'yes':
        with open("/root/python/user.csv",mode="w") as f:
            result=csv.DictWriter(f,fieldnames=["id","passwd","bat"])
            result.writeheader()
            result.writerows(data)
            f.close()
        print("已成功退出，请取回您的银行卡")
        exit()
    else:
        CaoZuoYeMian(userdata)

# 检测金额输入
def checkMoney(m):
    try:
        m=float(m)
        if m <=0 or m%100!=0:
            raise Exception("金额必须为100倍数的正整数!")
        return m
    except ValueError:
        print("请输入整数！")
        inputToReturn()
    except Exception as e:
        print(e)
        inputToReturn()

# 输入任意键返回主菜单
def inputToReturn():
    global userdata
    input("输入任意键返回主菜单..")
    CaoZuoYeMian(userdata)

# 导入数据
def init():
    try:
        with open("/root/python/user.csv",mode="r") as f:
            result=csv.DictReader(f)
            data.clear()
            for i in result:
                data.append(i)
            f.close()
    except FileNotFoundError:
        print("没有文件使用原数据")

def main():
    global userdata
    init()

    while True:
        print("----------欢迎使用ATM机----------")
        userid=input("请输入账号:")
        pwd=input("请输入密码:")
        isLogin=False
        for i in data:
            if i['id']==userid and i['passwd']==pwd:
                isLogin=True
                userdata=i
                break

        if isLogin==True:
            print("登录成功，请进⾏下列操作：")
            CaoZuoYeMian(userdata)
        else:
            print("账号或密码错误！")

if __name__ == "__main__":
    main()


