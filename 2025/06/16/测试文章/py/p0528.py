# n=3>5
# print(n)
# print(type(n))

# pwd=input("请输入密码：")
# print(type(pwd))
# print(int(pwd)+5)
# print("密码是："+pwd+str(5))  

#小明学号为00001，年龄为18岁，身高为1.79米
# sno=102
# age=18
# sname="小明"
# high=1.786

# print(sname+"学号为"+str(sno))
# print(f"{sname}学号为{sno:05d}，年龄为{age}岁，身高为{high:.2f}米",end="")
# print("hello")

# n1=5
# n2=2
# print(5//2)
# n1+=3
# # n1=n1+3
# print(n1)
# n2**=10
# print(n2)

# sex=input("请输入性别：")
# if sex=="男":
#     print("打游戏")
#     print("ttt")
# elif sex=="女":
#     print("去逛街")
# else:
#     print("其他")

# names="hello w*&^%&orl水电费565d"
# for  i in names:
#     print(i)

# for i in range(1,10,2):
#     print(i)

# for i in range(9,0,-2):
#     print(i)

# test="-"
# print(test*50)
# sjx="""*
# ***
# *****"""
# print(sjx)

# 字符串 数组类型
#数据类型：bool int float str 
# test="helloworld"
# print(test)
# print(test[1])
# print(test[-1])
# print(test[3:6])
# print(test[3::2])

# test="he45llow565673orld"
# print(len(test))
# print(test.find("l",5,6))
# print(test.rfind("l"))
# print(test.isdigit())
# for i in test:
#     if i.isdigit()==True:
#         print(i)
#统计l出现的次数
# ci=0
# for i in test:
#     if i=="l":
#         ci+=1
# print(ci)
# print(test.count("l"))

# 上机练习1
# 1.定⼀个浮点型，将其转成int类型，观察取整后截断情况
# pai=3.1415926535
# print(int(pai))
# 2.定义⼀个整型，将其转成float，再计算其平⽅
# zx=3
# print(float(zx**2))
# 3.不换⾏输出两个字符串（print⽅法的end参数） 我喜欢 编程
# str1="我喜欢"
# str2="编程"
# print(str1,end=" ")
# print(str2)
# print(str1+str2)
# print(str1,str2)
# 4.输⼊⼀个数字，判断是奇数还是偶数
# n=input("请输入一个数字：")
# if n.isdigit():
#     if int(n)%2==0:
#         print(n+"是偶数")
#     else:
#         print(n+"是奇数")
# else:
#     print(n+"不是整数")
# 5.输出8到88的偶数
# for i in range(8,89,2):
#     print(i)
# 6.已知字符串，s = "哈佛在等我呢"
# 获取第4⾄第5个字符
# 获取左起第3个起所有的字符
# 字符串做*运算，拷⻉字符串5次
# s = "哈佛在等我呢"
# print(s[3:5])
# print(s[2:])
# print(s*5)

# 7.从键盘接收⼀个字符串，查找它在s="aforsadvj happy so thank"中是否存在，如果存在
# 就打印"找到你了"
# ，并且显⽰出现的次数，不存在就打印"怎么没有你"
# str = input("请输入一个字符串：")
# # str='a'
# s="aforsadvj happy so thank"
# if s.find(str) != -1 :
#     print(f"找到你了{s.count(str)}")
# else:
#      print("怎么没有你")


# 8.从键盘接收⼀个字符串，取出字符串中的数字，并且统计字符串的总⻓度及所有数字
# 出现的个数。
# 运⾏效果如下：
# 请输⼊字符串：hello234a2
# 总⻓度：10
# 所有数字数量：4
# a=input("请输入一个字符串：")
# c=0
# for i in a:
#     if i.isdigit()==True:
#         c+=1
# print("总⻓度：",len(a))
# print("所有数字数量：",c)


# 9.根据完整路径从路径中取出⽂件路径，⽂件扩展名py
# str2 = "D:\软件\python\python39\Tools\scripts\mitype.py"
# 输出结果为：
# D:\软件\python\python39\Tools\scripts
# py

# str2 = "D:\软件\python\python39\Tools\scripts\mitype.py"
# a=str2.rfind("\\")
# b=str2.rfind(".")
# print(str2[:a])
# print(str2[b+1:])



# list1=[435,65,7,4,"hello",False,4.5,[65,645,"hello"]]
# print(list1)
# print(type(list1))
# print(len(list1))
# print(list1[0])
# print(list1[-1][-1][0])
# # 二维数组 矩阵
# list2=["ttt",
#        list1
#        ]
# print(list2)
# print(len(list2))
# list1=[435,56,67,34,75,56,1]

# 索引和元素同时显示
# for i in range(len(list1)):
#     print(i,list1[i])

# if 100 in list1:
#     print("在")
# else:
#     print("不在")

# list1.sort(reverse=True)
# list1.sort()
# list1.reverse()
# list1.reverse()
# print(list1)

# print(list1.count(560))
# list1.append(100)
# list1.extend([200,300])
# list1.append([400,900])
# list1.extend([800])
# list1.insert(1,100)
# list1.remove(56)
# list1.remove(56)
# list1.pop()
# del list1[0:4:2]
# list1.clear()
# list1[0]=100
# print(sum(list1)/len(list1))
# print(list1)
# print(f"{sum(list1)/len(list1):.2f}")
# print(round(sum(list1)/len(list1),2))

names="hello world test"
# list1=list(names)
list1=names.split(" ")
print(list1)
# for i in list1:
#     print(i)
# for i in names:
#     print(i)
# hello
# world
# test
# hello_world_test
str2="_".join(list1)
print(str2)
print(type(str2))
