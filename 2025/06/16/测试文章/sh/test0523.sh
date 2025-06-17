# 1. 写一个循环，输出20-40
# for i in `seq 20 40`
#     do
#         echo "$i"
#     done
# a=20
# while [ $a -le 40  ]
#     do
#         echo "$a"
#         a=$(($a+1))
#     done


# 2. 从1-50的单数，倒序
# for i in `seq 50 -1 1`
#     do
#        a=$[$i%2]
#        if [ $a -ne 0 ]
#        then
#             echo "$i"
#         fi

#     done

# 3. 计算并显示 1 到 100 之间的奇数之和
# for  i in `seq 1 100`
#     do
#         if [ $(($i%2)) -ne 0 ]
#         then
#             he=$(($he+$i))
#         fi
#     done
#         echo "$he"

# 5. 有若干只鸡兔同在一个笼子里，从上面数有35个头，从下面数有94只脚。问笼中各有
# 多少只鸡和兔？
# ji+tu=35 ji*2+tu*4=94
# ji  tu
# 1   34
# 2   33
# 3   32

# for ji in `seq 0 35`
#     do
#      tu=$((35-$ji))
#      tou=$(($ji+$tu))
#      jiao=$(($ji*2+$tu*4))
#         if [ $tou -eq 35 -a $jiao -eq 94 ]
#         then
#             echo "鸡有$ji只，兔有$tu只"
#         fi
#     done

# for ji in `seq 0 35` # 0  1 2 
#     do
#         for tu in `seq 0 35` #0-35  0-35 0-35
#             do
#                tou=$(($ji+$tu))
#                jiao=$(($ji*2+$tu*4))
#                if [ $tou -eq 35 -a $jiao -eq 94 ]
#                then
#                     echo "鸡有$ji只，兔有$tu只"
#                 fi
#             done
#     done


# 6. 猴子吃桃问题：猴子第一天摘下若干个桃子，当即吃了一半，还不瘾，又多吃了一
# 个，第二天早上又将剩下的桃子吃掉一半，又多吃了一个。以后每天早上都吃了前
# 一天剩下的一半零一个。到第10天早上想再吃时，见只剩下一个桃子了。求第一天共摘了多少。
# tian  tao     tao=(tao+1)*2
# 10     1
# 9      4
# 8      10

# tao=1
# for i in `seq 1 9`
#     do 
#       tao=$((($tao+1)*2))
#     done
#     echo "$tao"

# 7. 创建用户组wanmei，批量建立用户wm1到wm9,用户属于wanmei组,创建完成查
# 看/etc/group 和 /etc/passwd文件
# groupadd wanmei
# useradd -g wanmei wm{1..9}
# for i in `seq 1 9`
#     do
#         useradd -g wanmei wm$i
#     done
#     cat /etc/group
#     cat /etc/passwd

# 8. 删除上面的用户和用户组
# for i in `seq 1 9`
#     do
#         userdel wm$i
#     done
#     groupdel wanmei

# 9. 实现传入一个目录作为参数，如果传入的不是目录则提示不是目录，如果是目录则
# 将该目录下所有的普通文件的文件名都罗列出来
#     if [ ! -d $1 ]
#     then
#         echo "不是目录"
#     else
#         names=`ls $1` #ls root
#         for i in $names
#             do
#               if [ -f $1/$i ]
#               then
#                 echo "$i"
#               fi

#             done
#         fi

# read -p "输入一个目录路径:" names
# if [ -d $names ]
# then
#     for i in $names
#         do
#             ls -l $i |grep "^-"
#         done
#             echo "输出完毕"
# else 
#     echo "不是目录"
# fi
      


# 10. 猜数字游戏：电脑随机产生一个100以内的数字（1-99），通过每次键盘输入来猜数
# 字，输入的小了就提示往大猜，输入大了就提示往小里猜， 直到输入正确数字（通
# 过$RANDOM获取随机数）

# sjs=$(($RANDOM%99+1))
# while [ 1 -eq 1 ]
#     do
#     read -p "请输入一个数字:" n1 
#         if [  $n1 -gt $sjs ]
#         then
#             echo "输入大了往小里猜"
#         elif [ $n1 -lt $sjs ]
#         then
#             echo "输入的小了往大猜"
#         else
#             echo "棒棒的"
#             break
#         fi
#     done

# a=$RANDOM
# if [ $a -ge 100 ]
#  then
#  while [ $a -ge 100 ]
#  do
#  a=$RANDOM
#  done 
#  echo "开始抽奖"
#  else
# echo "开始抽奖"
# fi
# while [ $a -lt 100 ]
#  do
#  read -p "请输入您的数字" b
#  if [ $b -lt $a ]
#  then
#  echo "往大了猜"
#  elif [ $b -gt $a ]
#  then
#  echo "往小了猜"
#  else
#  echo "恭喜您猜对啦，答案是$a，获得100万美金"
#  break
#  fi
#  done

# 二重循环:外层循环先开始，内层结束后，再开始外层的下一个循环
# for i in `seq 1 5`  #1
#     do
#       for j in `seq 1 5` #1..5 
#             do
#              echo -n "*" #内层控制个数
#             done
#        echo " " #外层控制行数
#     done

# *
# **
# ***
# **** 
# ***** 
# i  j  i=j
# 1  1
# 2  2
# 3  3
# 4  4
# 5  5

# for i in `seq 1 5`
#     do
#       for j in `seq 1 $i`
#         do
#             echo -n "*"
#         done
#         echo " "
#     done

# * 
# *** 
# *****
# *******
# *********

# i  j  2*i-1
# 1  1
# 2  3
# 3  5
# 4  7
# 5  9
# for i in `seq 1 5`
#     do
#         for j in `seq 1 $(($i*2-1))`
#             do
#                 echo -n "*"
#             done
#            echo " "
#     done
# 金字塔：等腰三角形
# $$$$* 
# $$$*** 
# $$***** 
# $******* 
# ********* 
# i  j   k  j=2*i-1  k=5-i
# 1  1   4
# 2  3   3
# 3  5   2
# 4  7   1
# 5  9   0

# for i in `seq 1 5`
#     do
#       for k in `seq 1 $((5-$i))`
#             do
#                echo -n " " 
#             done
#         for j in `seq 1 $(($i*2-1))`
#             do
#                 echo -n "*"
#             done
#            echo " "
#     done

#     * 
#    *** 
#   ***** 
#  ******* 
# ********* 

# 循环控制:只影响离自己最近的那个循环
# break：遇到匹配条件直接结束
# continue：跳过条件继续下一个

# for i in `seq 1 5`
#     do
#         for j in `seq 1 5`
#         do
#           if [ $j -eq 3 ]
#           then 
#             continue
#           fi 
#           echo -n "$j"
#         done
#           echo "$i"
#     done
# 123451
# 123452
# 123453
# 123454
# 123455
# 12451
# 12452
# 12453
# 12454
# 12455
# 121
# 122
# 123
# 124
# 125

# 自定义函数
# name(){
#     echo "hello 易锦华"
# }
# 函数之间是可以相互嵌套的，前提是被嵌套的函数要先声明
# name
# $1 $2是函数里面的位置参数，通过调用函数的时候获取
# getSum(){
#     he=$(($1+$2)) #这是函数自带的位置参数
#     echo "$he"
#     name
# }

# 函数的使用方法有两种：调用 传递
# getSum $1 $2 # 这是系统的特色变量的位置参数

# read -p "请输入数字1:" n1
# read -p "请输入数字2:" n2
# he=`getSum $n1 $n2`
# echo "$he"


# 输入一个目录显示里面的所有目录
# getMl(){
#     names=`ls $1`
#     for i in $names
#         do
#             if [ -d $1/$i ]
#             then
#                 echo "$1/$i"
#                 getMl $1/$i
                 
#             fi
#         done
# }

# read  -p "请输入一个目录:" ml
# d1=`getMl $ml`
# echo "$d1"


# 5. 打印输出100至200之间的全部素数，输出素数并统计共有多少个素数。
# 注：质数(prime number)又称素数，有无限个。一个大于1的自然数，除了1和它本
# 身外，不能被其他自然数整除，换句话说就是该数除了1和它本身以外不再有其他的
# 因数;否则称为合数。
# 100..200
# 100  2..99
# 101  2..100
# 102  2..101
# 103  2..102
# count=0
# for i in `seq 100 200`
#     do
#       for j in `seq 2 $(($i-1))`
#         do
#           result=$(($i%$j))
#           if [ $result -eq 0 ]
#           then
#             break
#            elif [ $j -eq $(($i-1)) ]
#            then
#                 echo "$i是素数"
#                 count=$(($count+1))
#            fi
#         done      
#     done
#     echo "$count"

# shu="是"
# count=0
# for i in `seq 100 200`
#     do
#       shu="是" #洗牌，重置旗帜
#       for j in `seq 2 $(($i-1))`
#         do
#           result=$(($i%$j))
#           if [ $result -eq 0 ]
#           then
#              shu="不是" 
#              break
#           fi
#         done
#         if [ $shu == "是" ]
#         then
#             echo "$i是素数"
#             count=$(($count+1))
#         fi
#     done
#     echo "$count"

# jiecheng(){
#       bds="$1!="
#       echo "$bds"
# }

# read  -p "请输入一个数字:" n1
# result=`jiecheng $n1`
# echo "根据什么什么:$result"

# 3.编写函数,当该函数没有参数或参数多于2个, 输出-1,只有一个参数时, 输出1,有两个参数
# 时, 输出2
# 提示：使用$#判断参数的个数

# getZhi(){
#    if [ $# -eq 0 -o $# -gt 2 ]
#    then
#      echo "-1"
#     elif [ $# -eq 1 ]
#     then
#         echo "1"
#     else
#         echo "2"
#     fi
# }

# getZhi 1 2 3


# getZhi(){
#    if [ $1 -eq 0 -o $1 -gt 2 ]
#    then
#      echo "-1"
#     elif [ $1 -eq 1 ]
#     then
#         echo "1"
#     else
#         echo "2"
#     fi
# }

# getZhi $#


# shell工具
# sort排序相当于原来的order by

# sort -t ":" -nrk 2 /root/shell/sort.txt

# sed 以行为单位
# sed -n '2 p' /root/shell/sort.txt
# 只能连续打
# sed -n '2,4 p' /root/shell/sort.txt
# 替换/更新
# sed 's/ss/SS/g' /root/shell/sort.txt
# 删除
# sed 's/ss//g' /root/shell/sort.txt

# 新增
# sed '/^bb/ a hello' /root/shell/sort.txt

# sed '/1.6$/ a hello' /root/shell/sort.txt

# csv格式是按逗号区分的
# sed 's/bd/BB/g' /root/shell/sort.txt \
# |  sed 's/ss/SS/g' | sed 's/cls/AA/g' \
# | sort -t ":"  -nrk 3 | sed '/^bb/i one,two,three' \
# | sed 's/:/./g' > /root/shell/sort.csv
# 不写导出后的分隔符默认以空格划分
# awk -v FS=":" '{print $3,$1,$1}' /root/shell/sort.txt

# awk -v FS=":" -v OFS="," '{print $1,$2,$3}' /root/shell/sort.txt

# awk -v FS=":" -v OFS="," \
#  'BEGIN{print "one,two,three"}{print $1,$2,$3}' /root/shell/sort.txt  > /root/shell/sort.csv


# 拓展

# awk -v FS=":" '{ if($2>30){print $2}}' /root/shell/sort.txt

# awk -v FS=":" 'BEGIN{n=0}{for(i=1;i<=NF;i++){n++} }END{print n}' /root/shell/sort.txt