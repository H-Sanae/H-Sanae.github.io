--创建表空间
create tablespace huangwenzhe429 
datafile 'C:\workspace\sql\huangwenzhe429.dbf' 
size 100M autoextend on next 50M maxsize unlimited;

--给予管理员权限
grant dba to scott;

--创建临时表空间
create temporary tablespace huangwenzheTemp429 
tempfile 'C:\workspace\sql\huangwenzheTemp429.dbf' 
size 100M autoextend on next 50M maxsize unlimited;

--创建用户
create user huangwenzhe
identified by oracle 
default tablespace huangwenzhe429 
temporary tablespace huangwenzheTemp429;

--给予用户管理员权限
grant dba to huangwenzhe;

--查看别的用户的表
select * from scott.emp;
select * from scott.dept;

--删除表空间
drop tablespace huangwenzhe429 including contents;


--学生管理系统

--创建teacher表
create table teacher(
       TNO varchar2(10) primary key,
       TNAME varchar2(20) not null
);

--插入teacher数据
insert into teacher values('t001','刘阳');
insert into teacher values('t002','谌燕');
insert into teacher values('t003','胡明星');

--查看/删除teacher表
select * from teacher
drop table teacher

--创建student表
create table student(
       SNO varchar2(20) primary key,
       SNAME varchar2(30),
       SAGE number(2) check(SAGE between 6 and 40),
       SSEX varchar2(5) default '男'
);

--插入student数据
insert into student values('s001','张三',23,'男');
insert into student values('s002','李四',23,'男');
insert into student values('s003','吴鹏',25,'男');
insert into student values('s004','琴沁',20,'女');
insert into student values('s005','王丽',20,'女');
insert into student values('s006','李波',21,'男');
insert into student values('s007','刘玉',21,'男');
insert into student values('s008','萧蓉',21,'女');
insert into student values('s009','陈萧晓',23,'女');
insert into student values('s010','陈美',22,'女');
insert into student values('s12','谢丰琴',20,'女');
insert into student values('s13','谢中菊',20,'男');
insert into student values('s14','谢一才',20,'男');

--查看/删除student表
select * from student
drop table student

--创建course表
create table course(
       CNO varchar2(10) primary key,
       CNAME varchar2(30),
       TNO varchar2(20) references teacher(tno)
);

--插入course数据
insert into course values('c001','J2SE','t002');
insert into course values('c002','Java Web','t002');
insert into course values('c003','SSH','t001');
insert into course values('c004','Oracle','t001');
insert into course values('c005','SQL SERVER 2005','t003');
insert into course values('c006','C#','t003');
insert into course values('c007','JavaScript','t002');
insert into course values('c008','DIV+CSS','t001');
insert into course values('c009','PHP','t003');
insert into course values('c010','EJB3.0','t002');

--查看/删除course表
select * from course
drop table course

--创建sc表
create table sc(
       SNO varchar2(10) references student(sno),
       CNO varchar2(10) references course(cno),
       SCORE number(5,2) check(SCORE between 0 and 100),
       constraint fhzj primary key(sno,cno)
)

--插入sc数据
insert into sc values('s001','c001',78.90);
insert into sc values('s002','c001',80.90);
insert into sc values('s003','c001',81.90);
insert into sc values('s004','c001',60.90);
insert into sc values('s001','c002',82.90);
insert into sc values('s002','c002',72.90);
insert into sc values('s003','c002',81.90);
insert into sc values('s001','c003',59.00);
insert into sc values('s12','c005',89.00);
insert into sc values('s13','c008',87.00);
insert into sc values('s13','c007',65.00);
insert into sc values('s13','c010',85.00);
insert into sc values('s14','c007',100.00);
insert into sc values('s14','c005',60.00);
insert into sc values('s14','c006',92.00);
insert into sc values('s14','c008',95.00);
insert into sc values('s14','c010',91.00);
insert into sc values('s14','c004',57.00);

--查看/删除sc表
select * from sc
drop table sc







