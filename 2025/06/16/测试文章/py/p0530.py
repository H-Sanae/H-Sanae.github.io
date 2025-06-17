# 上机练习4
# 1. ⽣成⼀个存放1-100之间个位数为3的数据列表
# print([i for i in range(1,101) if i%10==3])
# 2. 利⽤列表推导式将已知列表中的整数提取出来[17, 98, 34, 21]
# list_two = [True, 17, "hello", "bye", 98, 34, 21]
# print([i for i in list_two if type(i)==int])
# 3. list_three=["good", "nice", "see you", "bye"]，根据列表利⽤推导式存放指定列表中
# 字符串的⻓度如下
# {'good':4, 'nice':4, 'see you':7, 'bye':3}
# list_three=["good", "nice", "see you", "bye"]
# print({i:len(i) for i in list_three})
# 4. ⽣成⼀个列表，其中的元素为'0-1'，'1-2'，'2-3'，'3-4'，'4-5'
# print([f"{i}-{(i+1)}" for i in range(5)])
# 5. 已知数据t1=((1,100),(2,30),(3,80),(4,234))
# t1=((1,100),(2,30),(3,80),(4,234))
# 推导成列表[100,30,80,234]
# print([i[1] for i in t1])
# 推导成字典{1: 100, 2: 30, 3: 80, 4: 234}
# print({ i[0]:i[1] for i in t1})
# 推导成列表[{'name': 1, 'value': 100}, {'name': 2, 'value': 30}, {'name': 3, 'value': 80},
# {'name': 4, 'value': 234}]
# print([{"name":i[0],"value":i[1]}  for i in t1])

# 6. 已知如下列表students，在列表中保存了6个学⽣的信息，根据要求完成下⾯的题⽬
# students = [
# {'name': '⼩花', 'age': 19, 'score': 90, 'gender': '⼥', 'tel':'15300022839'},
# {'name': '明明', 'age': 20, 'score': 40, 'gender': '男', 'tel':'15300022838'},
# {'name': '华仔', 'age': 18, 'score': 100, 'gender': '⼥', 'tel':'15300022839'},
# {'name': '静静', 'age': 16, 'score': 90, 'gender': '不明', 'tel':'15300022428'},
# {'name': 'Tom', 'age': 17, 'score': 59, 'gender': '不明', 'tel':'15300022839'},
# {'name': 'Bob', 'age': 18, 'score': 90, 'gender': '男', 'tel':'15300022839'}
# ]
# # 打印学⽣分数列表
# print([i['score'] for i in students])

# # 打印⼿机尾号是8的学⽣的名字列表

# print([ i['name'] for i in students if i['tel'][-1]=='8'])
# # 打印不及格的同学的所有信息列表，效果如下：
# # ['明明', 20, 40, '男', '15300022838', 'Tom', 17, 59, '不明', '15300022839']

# print([ j for i in students if i['score'] <60 for j in i.values()])

# 骆驼命名法：sayHiSayHi  say_hi_say_hi
# 帕斯卡：类名 SayHiSayHi

# def sayHi():
#     print("hello")
#     return 4
#     print("你好")

# jg=sayHi()
# print(jg)
# print(sayHi())
# sayHi()
# sayHi()

# 输入参数：0 1 多 形式参数 假
# 输出参数：0 1 多

# n1=3
# int n1=3
# 根据两个数求和 求差 求积
# def getJiSuan(n1,n2):
#     he=n1+n2
#     cha=n1-n2
#     ji=n1*n2
#     return he,cha,ji
    # l1=[he,cha,ji]
    # return l1,88
# 调用：实际参数
# jg=getJiSuan(5,2)
# print(jg)

# print(getJiSuan(n1=9,n2=100))
# print(getJiSuan(100))

def getLen(n1,**n):
    print(n1)
    print(n)
    print(len(n))

getLen(43,sno=65,sname=67,stest="hello")


# 3.输入s1和s2两个字符串，用于判断s1
# 是否是s2经过删除一些（也可以不删除）字符而不改变剩余字符相对位置形成的新
# 字符串。
# 示例：
# s1="zcv" s2="zxcvb" 输出: True
# s1="zvc" s2="zxcvb" 输出: False
# s1="ccccc" s2="ahcccac" 输出: False

