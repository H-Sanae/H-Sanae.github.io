# shell变量
# 自定义变量
# =赋值，变量名和=之间不能用空格
# 用$符引用变量
# xm="哥哥"
# echo "$xm"
# age=5
# echo "$nu"
# xm='"哥哥"'
# echo "姓名是：$xm,年龄是:$age岁"

# 反点用来引起命令
# n=`cat /etc/passwd | grep -c "root"`
# echo "$n"

# 系统变量
# echo "$USER" 查看当前用户 whoami
# echo "$HOME" 查看用户当前目录 pwd
# echo "$RANDOM" 随机数

# 特殊变量
# echo "$0"  脚本名称
# echo "$2"
# echo "$1"
# echo "$#"获取位置参数的个数
# echo "$@" 展示所有的位置参数
# echo "$?"
# -t是以秒为单位
# read -p "请输入姓名:" -t 3 xm
# echo "$xm"
# $((运算式)) 或 $[运算式]
# read  -p "请输入数值1:" nu1
# read  -p "请输入数值2:" nu2
# # echo "$nu1,$nu2"
# he=$(($nu1+$nu2))
# cha=$(($nu1-$nu2))
# jieguo=$((($nu1*$nu2/$nu1)%5))
# echo "和是：$he,差是：$cha,$jieguo"
# 选择结构
# 单支：
# read -p "请输入性别:" sex
# echo "$sex"
# [ 条件判断式 ] 条件判断式左边右边分别要一个空格
# if [ $sex == "女" ] 
# then
#     echo "去化妆"
# fi

# 两重if
# if [ $sex == "女" ]
# then
#     echo "去吃饭"
# else
#     echo "去玩"
# fi

# 多重if
# read -p "请输入性别:" sex
# if [ $sex == "女" ]
# then
#     echo "去迪斯尼"
# elif [ $sex == "男" ]
# then
#     echo "去漫展"
# elif [ $sex == "人妖" ]
# then
#     echo "去泰国"
# else
#     echo "去睡觉"
# fi

# if选择结构的嵌套 女 10  男 8
# read -p "请输入性别:" sex
# read -p "请输入时间:" time
# if [ $sex == "女" ]
# then
#    if [ $time -le 10  ]
#    then
#         echo "恭喜你考试合格"
#     else
#         echo "废物，回去重修"
#     fi
#     echo "去迪斯尼"
# elif [ $sex == "男" ]
#     then 
#     if [ $time -le 8 ]
#        echo "恭喜你考试合格"
#     else
#         echo "废物，回去重修"
#     fi
# then
#     echo "去漫展"
# elif [ $sex == "人妖" ]
# then
#     echo "去泰国"
# else
#     echo "去睡觉"
# fi

# read -p "请输入性别:" sex
# read -p "请输入时间:" time
# if [ $sex == "女" -a $time -le 10 ]
# then 
#     echo "恭喜你考试及格，去迪斯尼"
# elif [ $sex == "男" -a $time -le 8 ]
# then
#     echo "恭喜你考试及格，去漫展"
# elif [ $sex == "人妖" ]
# then
#     echo "去泰国"
# else
#     echo "去睡觉"
# fi

# 判断输入的路径是否是文件
# read -p "请输入一个路径:" path
# if [  -d $path  ]
# then
#     ls -l $path
# else
#     echo "请检查你输入的文件"
# fi

# if [  -f $1  ]
# then
#     cat $1
# else
#     echo "请检查你输入的文件"
# fi

# 检查MySQL服务是否启动
# port=`netstat -nltp | grep -c "3306"`
# if [ $port -ge 1 ]
# then
#     echo "MySQL服务已启动"
# else
#     service mysql start
#     echo "mysql服务未启动，检查后启动"
# fi

# case when 只能做等值判断，所以一般不用
# read -p "请输入性别:" sex
# case  $sex in
# "男")
#     echo "去随便"
# ;;
# "女")
#     echo "去逛街"
# ;;
# *)
#     echo "不知道"
# ;;
# esac

# 11. 位置参数传递一个绝对路径的文件，添加所有人可执行权限且提示添加执行权限成
# 功，如果没有传递参数提示没有传递文件。


# 1. 输入两个数字判断两个数字的大小
# read  -p "请输入数字1:" nu1
# read -p "请输入数字2:" nu2
# if [ $nu1 -lt $nu2 ]
# then
#     echo "$nu1<$nu2"
# elif [ $nu1 -gt $nu2 ]
# then
#     echo "$nu1>$nu2"
# else
#     echo "$nu1=$nu2"
# fi

# 2. 输入一个数字输出这个数字是偶数还是奇数  %
# read -p "请输入数字1:" nu1
# jieguo=$(($nu1%2))
# if [ $nu1 -eq 0 ]
# then 
#     echo "nu1非奇非偶"
# elif [ $jieguo -eq 0 ]
# then
#     echo "$nu1是偶数"
# else
#     echo "$nu1是奇数"
# fi

# 3. 判断一个年份是否是闰年,400整除是世纪闰年，100不整除并且被4整除是闰年，其余是平年
# read -p "请输入一个年份:" nf
# sjrn=$(($nf%400))
# rn=$(($nf%100))
# rn1=$(($nf%4))
# if [ $sjrn -eq 0 ]
# then
#     echo "$nf世纪闰年"
# elif [ $rn -ne 0 -a $rn1 -eq 0 ]
# then
#     echo "$nf是闰年"
# else
#     echo "$nf是平年"
# fi

# 4. 输入三个数，不考虑相等，有小到大打印输出
# 换底公式：冒泡排序
# read -p "请输入数字1:" a
# read -p "请输入数字2:" b
# read -p "请输入数字3:" c
# d=0
# if [ $a -gt $b ] 
# then
#    d=$a
#    a=$b
#    b=$d
# fi
# if [ $a -gt $c ]
# then
#     d=$a
#     a=$c
#     c=$d
# fi
# if [ $b -gt $c ]
# then
#     d=$b
#     b=$c
#     c=$d
# fi
# echo "$a<$b<$c"

# 5. 编写脚本,将系统日志文件（/var/log/messages），拷贝到/root/文件夹中
# cp /var/log/messages /root/

# 6. 编写脚本，位置参数传入学生的姓名和班级，打印“我的名字叫xx，我的班级是xx班”

# echo "我的名字叫$1,我的班级是$2班"

# 7. 用if，写一个shell脚本，运行时输入一个数字，如果是666则输出 evil，如果是777则
# 输出lucky, 如果是其他则输出human。
# read -p "请输入一个数字:" n1
# if [ $n1 -eq 666 ]
# then
#     echo "evil"
# elif [ $n1 -eq 777 ]
# then
#     echo "lucky"
# else
#     echo "human"
# fi
# 8. 用case方法改写上面的功能。
# read -p "请输入一个数字:" n1
# case $n1 in
# 666)
#     echo "evil"
# ;;
# 777)
#     echo "lucky"
# ;;
# *)
#     echo "human"
# ;;
# esac

# 9. 判断/root/hosts是否是存在并且是普通文件，如果不存在则新建一个，如果已经存
# 在，则追加写入当前时间到此文件中
# $(cat)
# `cat`
# path="/root/hosts"
# if [ -f $path ]
# then
#     date >> $path
#     cat $path
#     echo "是文件已追加当前时间到该文件"
# else
#     touch $path
#     echo "没有该文件已新建"
# fi

# 10. 判断当前用户是否为root，如果不是则打印非root账号，是的话就执行ifconfig查看
# 网卡信息（$USER获取当前用户）

# if [ $USER == "root" ]
# then
#     ifconfig
# else
#     echo "$USER非root账号"
# fi

# 11. 位置参数传递一个绝对路径的文件，添加所有人可执行权限且提示添加执行权限成
# 功，如果没有传递参数提示没有传递文件。
# if [ -f $1  ]
# then
#     chmod a+x $1
#     echo "添加执行权限成功"
# else
#     echo "没有传递文件"
# fi
# 优化后的
# if [ $# -eq 0 ]
# then
#     echo "没有传递文件"
# else
#     if [ -f $1 ]
#     then
#         chmod a+x $1
#         cat $1
#         echo "添加执行权限成功"
#     else
#         echo "不是文件"
#     fi
# fi




# 12. 编写脚本判断mysql是否正常启动（端口号3306，查看端口netstat -nltp,然后grep过
# 滤返回行数，判断行数是否大于0）
# gs=`netstat -nltp | grep -c "3306"`
# if [ $gs -ge 1 ]
# then
#     echo "mysql正常启动"
# else 
#     echo "mysql没启动"
# fi


# 13. 首先显示当天日期， 然后查找给定的用户是否在系统中工作（cat /etc/passwd）。
# 如果在系统中，就输出一条欢迎语句（例如 hello，root！）；如果不在系统中，就
# 输出一条语句（waiting for root！）
# date
# read -p "请输入用户名:" yh
# name=`cat /etc/passwd | grep  -c "$yh"`
# if  [ $name -ge 1 ]
# then
#     echo "hello,$yh!"
# else
#     echo "waiting for $yh!"
# fi


# 14. 接受一个参数，若给定参数不是目录， 则给出提示信息；
# 否则使用 ls -l 命令列出该目录下的内容，并输出有多少个子目录（d 开头），多少
# 个普通文件(-开头）。显示示例如下：
# 目录的数量：16
# 文件的数量：25
# read -p "请输入一个目录:" ml
# if [ ! -d $ml ]
# then
#     echo "不是目录"
# else
#     ls -l $ml 
#     d1=`ls -l $ml | grep -c "^d"`
#     wj=`ls -l $ml | grep -c "^-"`
#     echo "目录的数量：$d1"
#     echo "文件的数量：$wj"
# fi


# 循环：
# for循环:明确的循序次数，且不提前结束循环（每次递增为1）
# while循环:不明确循环次数，有明确的终止条件

# 1 2 3 4 5 6 7 8 9
# n=11
# while [ $n -le 10 ] # bool类型，如果条件为false则不进入循环
#     do
#        n=$(($n+1))
#         echo "$n" #自增条件   
#     done
#     echo "自己see see"
# for 循环每次递增1
# for  i  in `seq 1 2 10` 
#     do
#         echo "$i"
#     done

# for i in {10..1}
#     do
#         echo "$i"
#     done

# (i=1;i<=10;i++)

# 1 ..100的和

# for  i in `seq 1 100`
#     do
#       he=$(($he+$i))
       
#     done
#    echo "$he"
# 1 ..100的奇数和

# for  i in `seq 1 100`
#     do
#         if [ $(($i%2)) -ne 0 ]
#         then
#          he=$(($he+$i))
#         fi
#     done
#    echo "$he"


# for i in $@
#     do
#         if [ $(($i%2)) -eq 0 ]
#         then
#         echo "$i"
#         fi
#     done

# name="韦志杰 梁海朋 廖浩翔"
# for i in $name
#     do
#         echo "$i"
#     done

# 查看root下的所有文件和目录
# names=`ls /root/`
# for i in $names
#     do
#         echo "$names"
#     done
# 查看root下的所有目录
# d -
# -f -d
# names=`ls /root`
# echo "$names"
#     for i in $names
#         do
#             if [ -d /root/$i ] #必须要带绝对路径
#             then
#             echo "/root/$i"
#             fi
#         done

# read -p "请输入考试结果(y/n):" jieguo
# while [ $jieguo == "n" ]
#     do
#     read -p "请输入考试结果(y/n):" jieguo
#         if [ $jieguo == "n" ]
#         then
#             echo "考试不合格继续努力"
#         else
#             echo "考试合格"
#         fi 
#     done



# while [ 1 -eq 1 ]
#     do
#     read -p "请输入考试结果(y/n):" jieguo
#         if [ $jieguo == "n" ]
#         then
#             echo "考试不合格继续努力"
#         else
#             echo "考试合格"
#             break
#         fi 
#     done