# 连接数据库
# mysql -h127.0.0.1 -P3306 -uroot -proot123456 test -e "select * from student"
# dbhost="127.0.0.1"
# dbprot=3306
# dbuser="root"
# dbpass="root123456"
# db="test"


# # 建表之前先删表
# sql1="drop table if exists ip"
# mysql -h$dbhost -P$dbprot -u$dbuser -p$dbpass $db -e  "$sql1"
# #确定没有同名的表后建表
# sql2="create table if not exists ip
# (
# one varchar(10),
# two varchar(10),
# three varchar(10),
# four varchar(10)
# )"
# mysql -h$dbhost -P$dbprot -u$dbuser -p$dbpass $db -e  "$sql2"
# #导入数据
# sql3="LOAD DATA INFILE '/usr/local/mysql/data/ip.csv' INTO TABLE ip
# CHARACTER SET utf8
# FIELDS TERMINATED BY ','
# LINES TERMINATED BY '\n'
# IGNORE 1 LINES"
# mysql -h$dbhost -P$dbprot -u$dbuser -p$dbpass $db -e  "$sql3"
# #查看表和数据
# sql4="select * from ip"
# mysql -h$dbhost -P$dbprot -u$dbuser -p$dbpass $db -e  "$sql4"


#自动获取列名

dbhost="127.0.0.1"
dbprot=3306
dbuser="root"
dbpass="root123456"
db="test"

# 建表之前先删表
sql1="drop table if exists $1"
mysql -h$dbhost -P$dbprot -u$dbuser -p$dbpass $db -e  "$sql1"
#确定没有同名的表后建表
#获取第一行
names=`head -n +1 /root/shell/douban.csv | sed 's/,/ /g'`

#打擂台
# lasetnames=" "
# for i in $names
#     do
#       lasetnames="$i" 
#     done
#   lasetnames="$i"
#   echo "$lasetnames"
#找出最后一个列名
 lastname=`echo "$names" | awk '{print $NF}'`
sql2="create table if not exists $1("
 for i in $names
    do
        if [ $i == "$lastname" ]
        then 
            sql2="$sql2$i varchar(200)"
        else
            sql2="$sql2$i varchar(200),"
        fi
        
    done
    sql2="$sql2)"


mysql -h$dbhost -P$dbprot -u$dbuser -p$dbpass $db -e  "$sql2"
#导入数据
sql3="LOAD DATA INFILE '$2' INTO TABLE $1
CHARACTER SET utf8
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES"
mysql -h$dbhost -P$dbprot -u$dbuser -p$dbpass $db -e  "$sql3"
#查看表和数据
sql4="select * from $1"
mysql -h$dbhost -P$dbprot -u$dbuser -p$dbpass $db -e  "$sql4"