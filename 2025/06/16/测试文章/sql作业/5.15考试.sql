
--使用开窗函数求出emp表中每一个部门工资第二高的人员姓名ename和人员工资sal，
--以及他所在部门的平均工资。
select ename,sal,deptno,avgsal from(
       select emp.*,dense_rank()over(partition by deptno order by sal desc) rnk, 
       avg(sal)over(partition by deptno) avgsal
       from emp
) where rnk=2

--3.请通过SQL语句，筛选出表格中连续登录3天的用户。
create table usetable(id number(20) primary key,uname varchar2(20),utime date)
insert into usetable values(1,'jack',to_date('2024-01-01','yyyy-mm-dd'));
insert into usetable values(2,'jack',to_date('2024-01-02','yyyy-mm-dd'));
insert into usetable values(3,'jack',to_date('2024-01-03','yyyy-mm-dd'));
insert into usetable values(4,'tony',to_date('2024-01-11','yyyy-mm-dd'));
insert into usetable values(5,'tony',to_date('2024-01-21','yyyy-mm-dd'));
insert into usetable values(6,'tony',to_date('2024-01-24','yyyy-mm-dd'));
select * from usetable

select * from usetable u 
join usetable u1 on u1.uname=u.uname and u.utime+1=u1.utime
join usetable u2 on u2.uname=u.uname and u1.utime+1=u2.utime
 
--4.有一张article_history表存放文章的修改记录，
--有以下字段title(文章标题),last_time(修改时间),username(修改人姓名)，source(文章来源)，pin_name(作者笔名),
--要求写一个sql语句查询出每一个文章的最后修改人和修改时间。
select * from article_history

select username,last_time from(
       select article_history.*,row_number()over(partition by title order by last_time desc) rnk from article_history
) where rnk=1

Create table article_history
( title varchar(20),
last_time date,
username varchar(20),
source varchar2(20),
pin_name varchar2(20)
)

insert into article_history values('西游记',sysdate,'张三','漓江出版社','吴承恩');
insert into article_history values('西游记',sysdate-1,'李四','漓江出版社','吴承恩');
insert into article_history values('西游记',sysdate-2,'张三','漓江出版社','吴承恩');
insert into article_history values('西游记',sysdate-3,'李四','漓江出版社','吴承恩');
insert into article_history values('红楼梦',sysdate-1,'张三','漓江出版社','曹雪芹');
insert into article_history values('红楼梦',sysdate,'李四','漓江出版社','曹雪芹');
insert into article_history values('红楼梦',sysdate-2,'张三','漓江出版社','曹雪芹');
insert into article_history values('红楼梦',sysdate-3,'张三','漓江出版社','曹雪芹');

--5.使用merge into语句将TABLE2表中SETUP_DATE、MATURE_DATE更新到TABLE1表中
merge into table1
using table2
on(table1.id=table2.id)
when matched then 
update set table1.setup_date=table2.setup_date;
update set table1.mature_date=table2.mature_date
when not matched then 
insert values(table2.setup_date,table2.mature_date)



--6.
create table a
( year varchar(20),
month varchar(20),
amount varchar(20)
)

insert into a values(1991,1,1.1);
insert into a values(1991,2,1.2);
insert into a values(1991,3,1.3);
insert into a values(1991,4,1.4);
insert into a values(1992,1,2.1);
insert into a values(1992,2,2.2);
insert into a values(1992,3,2.3);
insert into a values(1992,4,2.4);

select * from a

select year, 
max(case when month=1 then amount end) m1, 
max(case when month=2 then amount end) m2, 
max(case when month=3 then amount end) m3, 
max(case when month=4 then amount end) m4
from a group by year

--7.
create table t1
( skuid varchar(20),
occmonth varchar(20),
debitoccur varchar(20)
);
insert into t1 values(8001,1,34);
insert into t1 values(8001,2,56);
insert into t1 values(8001,3,86);
insert into t1 values(8001,4,96);
insert into t1 values(8001,5,56);
insert into t1 values(8001,6,34);
insert into t1 values(8001,7,56);
insert into t1 values(8001,8,56);
insert into t1 values(8001,9,34);
insert into t1 values(8001,10,56);
insert into t1 values(8001,11,56);
insert into t1 values(8001,12,34);
insert into t1 values(8002,1,99);
insert into t1 values(8002,2,562);
insert into t1 values(8002,3,96);
insert into t1 values(8002,4,99);
insert into t1 values(8002,5,66);
insert into t1 values(8002,6,64);
insert into t1 values(8002,7,66);
insert into t1 values(8002,8,76);
insert into t1 values(8002,9,64);
insert into t1 values(8002,10,76);
insert into t1 values(8002,11,76);
insert into t1 values(8002,12,74);
insert into t1 values(8003,1,34);
insert into t1 values(8003,2,55);
insert into t1 values(8003,3,86);
insert into t1 values(8003,4,96);
insert into t1 values(8003,5,56);
insert into t1 values(8003,6,34);
insert into t1 values(8003,7,56);
insert into t1 values(8003,8,56);
insert into t1 values(8003,9,34);
insert into t1 values(8003,10,88);
insert into t1 values(8003,11,98);
insert into t1 values(8003,12,99);

--7.	从商品销售情况表T1中查询出所有月份的销售额都比sku为8001相应月份的销售额高的商品。
 --注：商品销售情况表T1中有多种商品，每个商品1－12月都有对应的销售额。
with t3 as(
     select * from t1 t join t1 t2 on t2.occmonth=t.occmonth
)
select * from t3 where not exists(
  select * from t3 where t1.occmonth=t2.occmonth and t1.debitoccur<t2.debitoccur
)

select t.skuid from t3 where t.occmonth=t2.occmonth and t.debitoccur<t2.debitoccur


t1.occmonth=t2.occmonth and t1.debitoccur>t2.debitoccur and t2.skuid=8001



select * from t1 where skuid=8001

with sku8001 as (
    select occmonth, debitoccur from t1 where skuid = '8001'
)
select distinct t.skuid
from t1 t where t.skuid != '8001' and not exists (
    select 1 from sku8001 s
    where s.occmonth = t.occmonth
    and t.debitoccur <= s.debitoccur
)

select * from t1 where skuid=8003 or skuid=8001


--8.
create table member(
       MEMBER_ID number(10) primary key,
       FIRST_NAME varchar2(25) not null,
       LAST_NAME varchar2(25),
       ADDRESS varchar2(100),
       CITY varchar2(30),
       PHONE varchar2(15),
       JOIN_DATE date default sysdate
);

create sequence member_id_seq
start with 101
increment by 1

select member_id_seq.nextval from dual

insert into member
select member_id_seq.nextval,
'Carmen ',
'Velasquez ',
'283 King Street',
'Seattle',
'206-899-6666',
to_date('08-12-1990','dd-mm-yyyy')
from dual

select * from member

create or replace view v_member as select * from member with read only

alter table member add age number(10) check(age between 20 and 60)

