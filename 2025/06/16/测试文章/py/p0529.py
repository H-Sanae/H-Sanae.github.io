# 上机练习2
# 1.请将列表l1=["hello","world","test"]中的每个元素通过 "_" 链接起来。
# 输出结果：hello_world_test
# l1=["hello","world","test"]
# str="_".join(l1)
# print(str)
# 2.有如下两个列表
# list1 = ["M", "na", "i", "Ke"]
# list2 = ["y", "me", "s", "lly"]
# 处理后保存到新列表中，输出结果：['My', 'name', 'is', 'Kelly']
# list1 = ["M", "na", "i", "Ke"]
# list2 = ["y", "me", "s", "lly"]
# list3=[]
# for i in range(len(list1)):
#     list3.append(list1[i]+list2[i])
# print(list3)
# 3.⽣成100个卡号,存储到列表中打印输出；卡号以6102009开头, 后⾯3位依次是
# （001,002,003,...,100）
# list1=[]
# i=1
# while i<=100:
#     list1.append(f"6102009{i:03d}")
#     i+=1
# print(list1)



# 4.已知字符串str1="hello c sharp",将其中的单词以反序输出
# 输出结果：sharp c hello
# str1="hello c sharp"
# list1=str1.split(" ")
# list1.reverse()
# str2=" ".join(list1)
# print(str2)


# 5.给定⼀个列表,将每⼀位数字变成它的平⽅ alist = [1, 2, 3, 4, 5, 6, 7]
# 输出结果：[1, 4, 9, 16, 25, 36, 49]
# alist = [1, 2, 3, 4, 5, 6, 7]
# ll=[]
# for i in alist:
#     ll.append(i ** 2)
# print(ll)


# 6.重新使⽤split和join的⽅法做1.9题
# 9.根据完整路径从路径中取出⽂件路径，⽂件扩展名py
# str2 = "D:\软件\python\python39\Tools\scripts\mitype.py"
# 输出结果为：
# D:\软件\python\python39\Tools\scripts
# py
# str2 = "D:\软件\python\python39\Tools\scripts\mitype.py"
# ll=[]
# aa=[]
# ll=str2.split("\\")
# aa=str2.split(".")
# del ll[-1]
# n="\\".join(ll)
# print(n)
# print(aa[-1])

# 7.把下⾯的列表⾥⾯的数字提取出来⽣成⼀个新的列表
# list1 = [13,2,55,[11,32,"eee"],["ssd",55,"ggg"]]
# ⽤type去判断元素如果是int就塞进新列表 if type(i) == int
# 如果类型是list则继续循环
# list1 = [13,2,55,[11,32,"eee"],["ssd",55,"ggg"]]
# list2=[]
# for i in range(0,len(list1)):
#     a=list1[i]
#     if type(a) == int:
#         list2.append(a)
#     elif type(a)==list:
#         for k in range(0,len(a)):
#             b=a[k]
#             if type(b)==int:
#                 list2.append(b)
# print(list2)


# list1 = [13,2,55,[11,32,"eee"],["ssd",55,"ggg"]]
# list2=[]
# for a in list1:
#     if type(a) == int:
#         list2.append(a)
#     elif type(a)==list:
#         for b in a:
#             if type(b)==int:
#                 list2.append(b)
# print(list2)


#数据类型：bool int float str list tuple(元组) set(集合) dict(字典)

# t1=(54,56,324)
# l1=list(t1)
# print(l1)
# print(type(l1))
# l1.append(100)
# t2=tuple(l1)
# print(t2)
# print(t1[0])
# for i in t1:
#     print(i)
# print(len(t1))


# s1={3,546,3,3,56546,546,5,5,44,5}
# s1=set()
# print(type(s1))
# print(s1)

# for i in set(s1):
#     print(i)
# s1.add(58)
# s1.remove(3)
# print(s1[0])
# print(s1)
# l1=[4,6,45,76]
# d1={"sno":43,"sname":"周杰伦",
#     "score":
#     ["hello",
#              l1,67,87]}
# print(type(d1))
# print(len(d1))
# print(d1)
# print(l1[0])
# print(d1["sno"])
# print(d1["score"][0][0])
# print(d1)
# d1={"sno":1,"sname":"周杰伦"}
# # d1["sno1"]=2
# d1.pop("sno")
# print(d1)

# del d1["sname"]

# print(d1.keys())
# for i in d1.values():
#     print(i)

# for i in d1:
#     print(i,d1[i])
# json {} [{}] 
# {"subjects":[{},{}.....]}




# 上机练习3
# 1.获取字典中的值：获取下列字典键为 'history' 的值
# sampleDict = {"class":{"student":{"name":"Mike","marks":{"physics":70,"history":80}}}}
# values=sampleDict["class"]["student"]["marks"]["history"]
# print(values)
# 2.请将元组 v1 = (11,22,33) 中的所有元素追加到列表 v2 = [44,55,66] 中
# v1 = (11,22,33)
# v2 = [44,55,66]
# l1=list(v1)
# v2.extend(l1)
# print(v2)
# 3.已知列表：
# list1 = ['life','is','short']
# list2 = ['you','need','python']
# list3 = [1,2,3,4,5,3,4,2,1,5,7,9]
# 完成以下操作：
# （1）把上述三个列表构造为⼀个集合 set1
# list1 = ['life','is','short']
# list2 = ['you','need','python']
# list3 = [1,2,3,4,5,3,4,2,1,5,7,9]
# set1=set(list1+list2+list3)
# print(set1)
# # （2）输出集合的⻓度
# print(len(set1))
# # （3）把python从集合中移除
# set1.remove('python')
# print(set1)

# 4.已知列表li= [11,22,100,33,44,66,55,77,88,99,90] ,将所有⼤于 66 的值保存⾄字典的第⼀
# 个key对应的列表中，将⼩于 66 的值保存⾄第⼆个key对应的列表中。
# 输出结果：{'key1':[100,77,88,99,90],'key2':[11,22,33,44,55]}
# li= [11,22,100,33,44,66,55,77,88,99,90]
# key1=[]
# key2=[]
# for i in li:
#     if i > 66:
#         key1.append(i)
#     elif i < 66:
#         key2.append(i)
# key={'key1':key1,'key2':key2}
# print(key)

# 5.已知列表list1 = [11,22,11,33,44,55,66,55,66],
# 统计列表中每个元素出现的次数，⽣成⼀个字典
# 输出结果：{11:2,22:1.....}
# 注：顺序不要求
# list1 = [11,22,11,33,44,55,66,55,66]
# jh =set(list1)
# zd={}
# for i in jh:
#     zd[i]=list1.count(i)
# print (zd)

# 6.已知字典d1={"subjects":[{"rate":"7.4","cover_x":640},{"rate":"6.0","cover_x":1080}]}
# 处理显⽰成如下格式输出：
# 7.4 640
# 6.0 1080
# d1={"subjects":[{"rate":"7.4","cover_x":640},{"rate":"6.0","cover_x":1080}]}

# for i in d1.keys():
#     for j in d1[i]:
#         for k in j.keys():
#             print(j[k],end=" ")
#         print()    
# 7.已知如下数据
# d1 = {
# '192.168.1.1':{'cpu':'0.23','内存':'16','硬盘':'500'},
# '192.168.1.2':{'cpu':'3.22','内存':'64','硬盘':'700'},
# '192.168.1.3':{'cpu':'1.99','内存':'32','硬盘':'800'}
# }
# 处理显⽰成如下格式输出：
# 192.168.1.1: cpu 0.23 内存 16 硬盘 500
# 192.168.1.2: cpu 3.22 内存 64 硬盘 700
# 192.168.1.3: cpu 1.99 内存 32 硬盘 800
# d1 = {
# '192.168.1.1':{'cpu':'0.23','内存':'16','硬盘':'500'},
# '192.168.1.2':{'cpu':'3.22','内存':'64','硬盘':'700'},
# '192.168.1.3':{'cpu':'1.99','内存':'32','硬盘':'800'}
# }

# for i in d1.keys():
#     print(i,end=": ")
#     for j in d1[i].keys():
#         print(j,end=" ")
#         print(d1[i][j],end=" ")
#     print()

# d1 = {
# '192.168.1.1':{'cpu':'0.23','内存':'16','硬盘':'500'},
# '192.168.1.2':{'cpu':'3.22','内存':'64','硬盘':'700'},
# '192.168.1.3':{'cpu':'1.99','内存':'32','硬盘':'800'}
# }

# for i in d1:
#     print(i,end=": ")
#     for j in d1[i]:
#         print(j,end=" ")
#         print(d1[i][j],end=" ")
#     print("")




# 8.有字符串"k: 1|k1:2|k2:3 |k3 :4" 处理成字典 {'k':1,'k1':2,'k3':4}
# 注：字符串替换使⽤replace函数
# d={}
# a1="k: 1|k1:2|k2:3 |k3 :4"
# a1=a1.replace(" ","")
# a1=a1.split("|")
# for u in a1:
#     s=u.split(":")
#     print(s)
#     if s[0] != "k2":
#         d[s[0]]=int(s[1])
# print(d)

# n1,n2,n3=4,6,"hello"
# print(n1)
# print(n2,n3)


# 5.给定⼀个列表,将每⼀位数字变成它的平⽅ alist = [1, 2, 3, 4, 5, 6, 7]
# 输出结果：[1, 4, 9, 16, 25, 36, 49]
# alist = [1, 2, 3, 4, 5, 6, 7]
# ll=[]
# for i in alist:
#     ll.append(i ** 2)
# print(ll)

# alist = [1, 2, 3, 4, 5, 6, 7]
# print([i**2 for i in alist])

# [25, 36, 49]
# print([i**2 for i in alist if i>4])

# {25, 36, 49}
# print({i**2 for i in alist if i>4})

# {5:25, 6:36, 7:49}
# print({i:i**2 for i in alist if i>4})

# {"5的平方是：25", 36, 49}
# print({f"{i}的平方是：{i**2}" for i in alist if i>4})

# (25, 36, 49)
# print(tuple((i**2 for i in alist if i>4)))

#推导 30 以内可以被 3 整除的整数为列表：
# print([i for i in range(30) if i%3==0])
# print([i for i in range(0,30,3)])

# d1={"张三":20,"李四":30,"王五":40}
# # [20,30,40]
# print([d1[i] for i in d1])
# print([i for i in d1.values()])

# 二重循环 提取数字为列表[45,67,45,34,65,78]
# l1=[[45,67,45,"hhh"],[34,65,78,"test"]]

# print([f"{j}{i}" for i in l1 if type(i)==list for j in i if type(j)==int])






