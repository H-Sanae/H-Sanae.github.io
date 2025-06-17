# 1. 99乘法表
#   for i in `seq 1 9`
#     do
#         for j in `seq 1 $(($i))`
#             do
#                 echo -n "$j*$i=$(($i*$j)) "
#             done
#         echo " "
#     done
# 2. 拼接一个直角三角形
# for i in `seq 1 9`
#     do
#         for j in `seq 1 $((2*$i-1))`
#             do
#                 echo -n "*"
#             done
#         echo " "
#     done
# 3. 上个练习基础上拼接一个等腰三角形
# ########*              
# #######***      
# ######***** 
# #####******* 
# ####********* 
# ###*********** 
# ##************* 
# #*************** 
# *****************


# for i in `seq 1 9`
#     do
#         for k in `seq 1 $((9-$i))`
#             do
#                 echo -n " "
#             done
#         for j in `seq 1 $((2*$i-1))`
#             do
#                 echo -n "*"
#             done
#         echo " "
#     done
# 4. 上个练习基础上拼接一个菱形

# for i in `seq 1 9`
#     do
#         for k in `seq 1 $((9-$i))`
#             do
#                 echo -n " "
#             done
#         for j in `seq 1 $((2*$i-1))`
#             do
#                 echo -n "*"
#             done
#         echo " "
#     done
#     for i in `seq 8 -1 1`
#     do
#         for k in `seq 1 $((9-$i))`
#             do
#                 echo -n " "
#             done
#         for j in `seq 1 $((2*$i-1))`
#             do
#                 echo -n "*"
#             done
#         echo " "
#     done

# 1.编写函数, 函数传入三个参数,输出积
# getJi(){
#     jieguo=$(($1*$2*$3))
#     echo "$jieguo"
# }
# getJi 1 2 4

# 2.编写函数，传递一个数字参数5，实现1到5的累加，返回和，输出"和是：15"
# getlj(){
#     for i in `seq 1 $1`
#         do
#             he=$(($he+$i))
#         done
#         echo "$he"
# }

# getlj 5

# 4.编写函数，实现传入一个目录参数，将该目录下（递归）所有的文件都打印出来（遇
# 到文件则打印，遇到目录则继续调函数递归）

# getml(){
#     names=`ls $1`
#     for i in $names
#         do
#             if [ -f $1/$i ]
#             then
#             echo "$1/$i"
#             elif [ -d $1/$i ]
#             then
#                 getml $1/$i
#             fi
#         done
# }

# read -p "请输入一个目录:" ml
# jieguo=`getml $ml`
# echo "$jieguo"





# 5.编写函数，传入一个数字n，实现n的阶乘,效果如下：
# jiecheng(){
#     bds="$1!="
#     ji=1
#     for i in `seq $1 -1 1`
#         do
#           ji=$(($ji*$i))
#             if [ $i -eq 1 ]
#             then
#                  bds="$bds$i"  
#             else
#                 bds="$bds$i*"
#             fi
#         done
#         echo "$bds=$ji"
# }

# read -p "请输入一个数字:" n
# jieguo=`jiecheng $n `
# echo "根据数字$n得到的阶乘表达式是:$jieguo"

# 创建shell脚本来完成
# 1.复制网卡文件/etc/sysconfig/network-scripts/ifcfg-ens33 到家目录，并且改名为
# wangka.txt
# cp /etc/sysconfig/network-scripts/ifcfg-ens33 /root/wangka.txt

# 2.找到含有 IP 的行输出
# grep "IP" /root/wangka.txt

# 3.显示文件的第 3 行到第 5 行的内容
# sed -n '3,5 p' /root/wangka.txt
# 4.将文件中的255全部替换为250
# sed 's/255/250/g' /root/wangka.txt
# 5.以文件IPADDR开头的上一行添加hello
# sed '/^IPADDR/i hello' /root/wangka.txt

# 6.找到所有DNS，并且删掉
# sed 's/DNS//g' /root/wangka.txt
# 7.使用管道符连续处理4. 5. 6. 题，并且重定向结果保存为wangka.csv
# sed 's/255/250/g' /root/wangka.txt | sed '/^IPADDR/i hello' \
#  | sed 's/DNS//g' > /root/shell/wangka.csv

# 8. 根据wangka.csv文件自己灵活处理重定向为ip.txt,内容如下：
# 192.168.145.151
# 250.250.250.0
# 192.168.145.2
# 8.8.8.8
# 114.114.114.114
# tail -n -5 /root/shell/wangka.csv | awk -v FS='"' '{print $2}' >>/root/shell/ip.txt

# 9. ip.txt中以.分割，按照第一列进行降序排序
# sort -t '.' -nrk 1 /root/shell/ip.txt

# 10. ip.txt中以.为分隔符，打印第1列和第2列
# awk -v FS="." '{print $1,$2}' /root/shell/ip.txt
# 11. ip.txt中以.为分隔符，打印第3列和第4列，列之间用,分割
# awk -v FS="." -v OFS="," '{print $3,$4}' /root/shell/ip.txt
# 12. ip.txt中以.为分隔符，列之间用,分割，且加一行，保存为ip.csv,格式如下：
# one,two,three,four
# 192,168,145,151
# 250,250,250,0
# 192,168,145,2
# 8,8,8,8
# 114,114,114,114
# awk -v FS="." -v OFS="," 'BEGIN{print "one,two,three,four"}{print $1,$2,$3,$4}' \
# /root/shell/ip.txt > /root/shell/ip.csv

# 13. 在家目录下创建一个names.txt的文件，写入班级的所有同学的姓名，每个一行，每
# 次随机产生一个姓名
# $RANDOM for
# echo -e "韦志杰\n陈南杰\n张峻\n姚尹锦\n徐浩杰\n秦子超\n劳家恩" > /root/shell/name.txt
# sl=`cat names.txt | wc -l`
# sjs=$(($RANDOM%$sl+1))
# sed -n "$sjs p" names.txt 
# 14. 批量修改家目录下的文件扩展名，使用位置参数传递两种扩展名，例如txt文件为csv
# 文件。（注：碰到特殊符号使用\进行转义）
# 找出文件 find -f  ^-
# names=`ls -l /root | grep  "^-" | grep "\.$1$" | awk '{print $NF}'`
# echo "$names"
# for i in $names
#     do
#         lastname=`echo "$i" | awk -v FS="." '{print $1}'`
#         mv /root/$lastname.$1 /root/$lastname.$2
#     done
# 掐头-去尾-换行
# sed 's/{"subjects":\[{//g' /root/shell/douban.txt \
# | sed 's/}\]}//g' \
# | sed 's/},{/\n/g' \
# | sed 's/\\//g' \
# | sed 's/""/null/g' \
# | sed 's/"//g' \
# | awk -v FS="," -v OFS="," '{print $8,$4,$1,$2,$3,$5,$6,$7,$9,$10}' \
# | sed 's/id://g' \
# | sed 's/title://g' \
# | sed 's/episodes_info://g' \
# | sed 's/rate://g' \
# | sed 's/cover_x://g' \
# | sed 's/url://g' \
# | sed 's/playable://g' \
# | sed 's/cover://g' \
# | sed 's/cover_y://g' \
# | sed 's/is_new://g' \
# | awk -v FS="," -v OFS="," \
# 'BEGIN{print "id,title,episodes_info,rate,cover_x,url,playable,cover,cover_y,is_new"}{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10}'  >/root/shell/douban.csv





