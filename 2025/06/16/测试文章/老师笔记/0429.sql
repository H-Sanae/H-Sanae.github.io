--1. 查询emp表中员工的名字和工资
select ename,sal from emp

--2. 查询emp表中员工的编号,名字,奖金
select empno,ename,comm from emp

--3. 查询部门编号和部门名称
select deptno,dname from dept

--4. 查询员工名字和入职日期(列名中文显示 名字, 入职日期)
select ename 名字,hiredate 入职日期 from emp

--5. 查询员工编号，名字，经理编号
select empno,ename,mgr from emp

--6. 查询公司里的所有部门的部门编号（去重）
select distinct deptno from emp
select distinct deptno from dept
--7. 查询员工的姓名和工资，按这种格式显示：simth的工资是800块
select ename||'的工资是'||sal||'块' from emp where ename='SMITH'

--8. 使用虚拟表来查看系统日期
select sysdate from dual

--9. 查看员工表的前五条数据
select emp.*, rownum from emp where rownum<=5




--10. 查看员工表的rowid

select emp.*,rowid from emp

--数据类型：三大类型
--字符类型   数字类型  日期类型
--字符类型（文本，字符串）：char(2000)固定长度  varchar2(4000)可变长度
--中文占两个字节英文占一个字节(符号同理)
--xm char(10)10   xm varchar2(10)7  秦子超a，9  秦子超a,8 

--nchar(2000)  nvarchar2(4000) 不区分中英文

--xm nchar(10)  xm nvarchar2(10) 秦子超a，5  秦子超a,5

select length('秦子超a，') from dual---不区分中英文
select lengthb('秦子超a，') from dual--区分中英文

--数字类型： 整数 number(38) 浮点数 number(7,2)总位数是7位其中2位是小数点，小数点之前是5位

--number类型只能存纯数字
sfz varchar2(18) 
dh varchar2(11) 13678456378

--sal number(38,37)浮点数的小数点位数不能超过总位数
--sal number(5) 

--numer类型用于运算，字符类型原理上是不能进行运算的
-- + - * /
select sal,comm,sal/100 from emp

--日期类型 date 日期格式'yyyymmddH24miss'
--日期类型可直接加减不能乘除:日期加减的是天数
select sysdate,hiredate from emp

select sysdate-(365*17)from dual

null
select sal,comm,sal+nvl2(comm,comm,0) from emp

---房子---老板---架子 
--数据库（表空间）--用户--数据表--数据列
--结构：增create删drop改查select
--数据：增删改查select 

--创建表空间

create tablespace student--真的表空间名
datafile 'c:\test\student.dbf'--生成的文件名
size 100M autoextend on next 50M maxsize unlimited;

--登录system管理员给权限
grant dba to scott;

--创建临时表空间(一般存放select查询出来的虚拟表)
create temporary tablespace student1
tempfile 'c:\test\student1.dbf'
size 50M autoextend on next 10M maxsize unlimited;
--用户
create user panyinchun
identified by oracle default tablespace student temporary tablespace student1;

--给新用户权限
grant dba to panyinchun;
--查看别的用户的表
select * from scott.emp

--删除表空间
drop tablespace student1 including contents;

--删除用户(前提要断开连接)
drop user panyinchun


--扩容 表空间
alter tablespace student
add datafile 'C:\test\student.dbf' size 100m autoextend on next 10m maxsize unlimited;

alter user panyinchun identified by oracle1;


--数据库（表空间）--用户--数据表--数据列
--结构：增create删drop改查select
--数据：增insert删改查select 

select * from scott.emp

select * from scott.dept

--三大类型：number  varchar2  date
--六大约束：not null 非空  unique 唯一  primary key 主键约束（非空&唯一的组合）
--default 默认约束  check 检查约束 references 外键约束


create table bm(bmno number(4),bmmc varchar2(20),bmdz varchar2(20));
select * from bm
---重复数据=冗余数据
null=空
insert into bm values(10,'销售部门','桂林市');
insert into bm values(20,'财务部门','柳州市');
insert into bm values(10,'销售部门','桂林市');
insert into bm values(30,'财务部门','柳州市');
insert into bm values(40,null,'柳州市');
insert into bm values(null,null,null);

select * from bm
---删除表
drop table bm


create table bm(
bmno number(4) primary key,
bmmc varchar2(20) unique,
bmdz varchar2(20) not null
);

insert into bm values(10,'销售部门','桂林市');
insert into bm values(20,'财务部门','柳州市');
insert into bm values(30,'销售部门一','桂林市');
insert into bm values(40,'财务部门一','柳州市');
insert into bm values(50,null,'柳州市');
insert into bm values(60,null,'南宁市');

select * from bm


select * from scott.emp

create table yg(
ygno number(6) primary key,--列级约束
ygxm varchar2(20) not null,
job varchar2(20) not null,
rzrq date default sysdate,
gz number(7,2) check(gz>=1500),--唯一一个带条件判断的约束
bmno number(4) references bm(bmno)
constraint zjys primary key(ygno),--表级约束
constraint wjys foreign key(bmno) references bm(bmno)
)

select * from yg
drop table yg
insert into yg values(1111,'廖浩翔','boss',sysdate-30,1500,60);
insert into yg values(2222,'蒋敏洋','CEO',sysdate,1500,60);
insert into yg values(3333,'李忠凯','保安',sysdate-4,8000,10);
insert into yg values(5555,'易锦华','保洁',sysdate,9000,20);
insert into yg values(6666,'姚尹锦','财务',sysdate,19000,40);
insert into yg values(7777,'张峻','财务',default,19000,40);


create table yg(
ygno number(6) primary key,--列级约束
ygxm varchar2(20) not null,
job varchar2(20) not null,
rzrq date default sysdate,
gz number(7,2) check(gz>=1500),--唯一一个带条件判断的约束
bmno number(4) references bm(bmno)
constraint zjys primary key(ygno),--表级约束
constraint wjys foreign key(bmno) references bm(bmno)
)

drop table yg1
create table yg1(
ygno number(6),
ygxm varchar2(20) not null,
job varchar2(20) not null,
rzrq date,
gz number(7,2),
bmno number(4),
constraint yg1_zjys primary key(ygno),
constraint yg1_wjys foreign key(bmno) references bm(bmno)
)
---必须用表级约束
--复合主键
create table cj(
sno number(5),
course varchar2(20),
score number(6,3),
constraint fhzj primary key(sno,course)
)

drop table cj
insert into cj values(1,'语文',99);
insert into cj values(1,'数学',99);
select * from cj
--建表：先主后从  删表：先从后主

age number(7,2) check(age between 6 and 40)

--三大类型  六大约束：列级 表级（复合主键要用表级） 数据的插入：insert into 表名 values（提交）
--建表结构：create table 
--删表：drop table 表名（删除表结构和数据）

