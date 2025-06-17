/****************学生系统*********************/
create table teacher(
  tno varchar2(10) primary key,
  tname varchar2(20) not null
);

create table student(
  sno varchar2(20) primary key,
  sname varchar2(30),
  sage number(2),
  ssex varchar2(5) default '男',
  constraint ck_sage check(sage>=6 and sage<=40)
);

create table course(
  cno varchar2(10) primary key,
  cname varchar2(30),
  tno varchar2(20),
  constraint fk_tno foreign key (tno) references teacher(tno)
);

create table sc(
  sno varchar2(10),
  cno varchar2(10),
  score number(5,2),
  constraint pk_sc primary key (sno,cno),
  constraint fk_sc_sno foreign key (sno) references student(sno),
  constraint fk_sc_cno foreign key (cno) references course(cno),
  constraint ck_score check(score>=0 and score<=100)
);

drop table sc
--建表主到从，删表从到主
select * from student
/*******初始化学生表的数据******/
insert into student values ('s001','张三',23,'男');
insert into student values ('s002','李四',23,'男');
insert into student values ('s003','吴鹏',25,'男');
insert into student values ('s004','琴沁',20,'女');
insert into student values ('s005','王丽',20,'女');
insert into student values ('s006','李波',21,'男');
insert into student values ('s007','刘玉',21,'男');
insert into student values ('s008','萧蓉',21,'女');
insert into student values ('s009','陈萧晓',23,'女');
insert into student values ('s010','陈美',22,'女');
insert into student values('s12','谢丰琴',20,'女');
insert into student values('s13','谢中菊',20,'男');
insert into student values('s14','谢一才',20,'男');
commit;
--rollback;
/******************初始化教师表***********************/

insert into teacher values ('t001', '刘阳');
insert into teacher values ('t002', '谌燕');
insert into teacher values ('t003', '胡明星');
commit;
/***************初始化课程表****************************/
insert into course values ('c001','J2SE','t002');
insert into course values ('c002','Java Web','t002');
insert into course values ('c003','SSH','t001');
insert into course values ('c004','Oracle','t001');
insert into course values ('c005','SQL SERVER 2005','t003');
insert into course values ('c006','C#','t003');
insert into course values ('c007','JavaScript','t002');
insert into course values ('c008','DIV+CSS','t001');
insert into course values ('c009','PHP','t003');
insert into course values ('c010','EJB3.0','t002');
commit;
/***************初始化成绩表***********************/
insert into sc values ('s001','c001',78.9);
insert into sc values ('s002','c001',80.9);
insert into sc values ('s003','c001',81.9);
insert into sc values ('s004','c001',60.9);
insert into sc values ('s001','c002',82.9);
insert into sc values ('s002','c002',72.9);
insert into sc values ('s003','c002',81.9);
insert into sc values ('s001','c003','59');
insert into sc values('s12','c005',89);
insert into sc values('s13','c008',87);
insert into sc values('s13','c007',65);
insert into sc values('s13','c010',85);
insert into sc values('s14','c007',100);
insert into sc values('s14','c005',60);
insert into sc values('s14','c006',92);
insert into sc values('s14','c008',95);
insert into sc values('s14','c010',91);
insert into sc values('s14','c004',57);
insert into sc values('s14','c001',58);
commit;
--------------
drop table teacher
drop table student
drop table course
drop table sc
----


--结构：增create删drop改alter查select 

--数据：增insert删delete改update查select 

--alter都是基于表去修改列

--新增列
create table bm1(bno number(10),bname varchar2(20),bloc varchar2(20));


select * from bm1

alter table  bm1 add city varchar2(20) not null;


--修改列
alter table bm1 modify city varchar2(50) unique;


--unique  all  not null 

--删除列
alter table bm1 drop column city;


--列重命名  chengshi
alter table bm1 rename column city to chengshi;

select * from bumen

--表重命名
alter table bm1 rename to bumen

---第二种建表方式:根据selcet查询语句的结果集来定义新表的数据和结构
--结构和数据一起要,会丢失约束,在添加数据之前先加约束
create table bm2
as
select deptno,loc from scott.dept where deptno=20

drop table bm2

select * from bm2

create table bm2
as
select * from scott.dept

insert into bm2 values(50,'aa','bb') 
--添加约束
alter table bm2 add constraint bm2_zjys primary key(deptno);
--非空约束
alter table bm2 modify loc varchar2(20) not null;

--删除约束
alter table bm2 drop constraint BM2_ZJYS


--数据插入:insert
--格式一：使用前提的不被插入的列可为空
create table bm3
as
select * from scott.dept


insert into bm3(deptno,loc)values(50,'七星区');

insert into bm3(deptno,dname,loc) values(60,'a','a')

select * from bm3

--格式二:不指定列插入，默认所有列都需要值,如遇到不插入数据的列则用null值填充
insert into bm3 values(70,'t',null);

--格式三:只插入select查询结果集的数据,注意查询的结果集结构要保证和表结构一致
insert into bm3(deptno,dname) select deptno,dname from scott.dept

select * from bm3

insert into bm3 select 20,'z','z' from dual

insert into bm3 select deptno,ename,job from scott.emp

---update 修改

update bm3 set deptno=80 where deptno=60

update bm3 set dname='销售部门',loc='八星区' where deptno=80

--格式二
create table yg2
as
select * from scott.emp
--把WARD的工资改成800块
update yg2 set sal=(select sal from yg2 where ename='SMITH') where ename='WARD'

---delete 删除的是数据
select * from yg2

delete from yg2 where empno=7369

--delete insert只能以行为单位进行操作
alter table yg2 drop column deptno


delete from yg2 where sal>(select sal from yg2 where empno=7499)

select * from yg2
--删除表数据 DDL结构上的不能回滚 DML数据上的能回滚
drop table yg2--删除结构和数据，不能回滚
truncate table yg2--删除数据,不能回滚
delete from yg2 --删除数据，能回滚

--速度
drop>truncate>delete


--2.将c001课程成绩小于80分的同学的成绩增加10分

update sc set score=score+10 where cno='c001' and score<80


create table sc2
as
select * from sc2


drop table sc2

delete from sc2 where sno!='s001' and sno!='s002'

--1.将c002课程的成绩增加5分
select * from teacher--老师的个人信息
select * from student--学生的个人信息
select * from course--学生系统里面有几门课程
select * from sc--每个学生每门课程的成绩
select * from sc where  cno='c002'
update  sc set score=score+5 where cno='c002'

--2.将c001课程成绩小于80分的同学的成绩增加10分
update sc set score=score+10 where cno='c001' and score<80


--3.增加一个学生:学号's013'，姓名：'王麻子'，年龄：28，性别：男
insert into student values('s013','王麻子',28,'男')

select * from student
--4.创建一张和sc表相同的表，并将s001和s002学生的选课信息插入新表中
select * from sc1

create table sc1
as
select * from sc

delete from sc1 where sno !='s001' and sno!='s002'

insert into sc1 select * from sc where sno='s002'

--5.将所有c001课程成绩不及格的同学的分数改为60分
update sc set score=60 where cno='c001' and score<60


--6.删除“s002”同学的“c001”课程的信息记录
delete from sc where sno='s002' and cno='c001'

select * from sc where sno='s002' and cno='c001'
/*7.用sc1去更新sc,当学生和选修课程相同的时候，把sc1的分数更新到sc，不同的时候就插
入到sc*/

---有则更新，无则插入
--merge :备份还原（仅备份还原一张表）

select * from sc1

create table sc1
as
select * from sc

update sc set score=59 where sno='s001';

delete from sc where sno='s13'

--merge也是数据上的属于DML
merge into sc--目标要更新的表
using sc1--备份表（源表）
on(sc.sno=sc1.sno and sc.cno=sc1.cno)
when matched then update set sc.score=sc1.score--有值的时候去做更新
  when not matched then insert values(sc1.sno,sc1.cno,sc1.score)--没值的时候直接插入
    
---操作符
--算术操作符(一般用与数字类型的运算，和日期加减运算)：+ - * /
--连接操作符: ||(把多个列合并成一个列)
--逻辑操作符: and or  not(与或非)
--比较操作符（都是放在where后面做条件比较）：
--> >= < <= = != <> 、any、 all、 between..and、  like、 in、 is null
    
select 33/55,22+1,44-3,66/2 from dual

select sal,sal+100,hiredate,hiredate+2 from emp

select ename||sal||deptno||'你好' from emp

select * from emp where sal>3000--数字的大于不包含本身
select * from emp where sal>=3000

select * from emp where ename>'C'--字符的大于包含本身（比的是数据的首字母A..Z）

select * from emp where sal<2000

select * from emp where sal<=3000

select * from emp where sal=3000

select * from emp where ename='SCOTT'

select * from emp where sal!=3000

select * from emp where ename !='SCOTT'
--一般搭配后面的子查询对多个值进行比较
>all:表示大于最大值
<all：表示小于最小值
>any：表示大于最小值
<any：表示小于最大值
=any: 和in类似
--> < >= <= !=只能跟一个值做比较
select * from emp where sal >all(800,1250,3000)
                                  800,2975,3000,1100,3000
select * from emp where sal>all(select sal from emp where deptno=20)

select * from emp where sal <all(1250,950,3000)

select * from emp where sal >any(1250,950,3000)
select * from emp where sal <any(1250,950,3000)

select * from emp where sal =any(1250,950,2000)

select * from emp where sal in(1250,950,1200,2000)

create table sc1
as
select * from sc where sno in('s001','s002')

--
select * from emp where sal between 950 and 3000--包含边界值，边界值得从小到大

select * from emp where sal>=950 and sal<=3000

--is null
select * from emp where comm is null

select * from emp where comm  is  not null

--and  or not 一般用于多个条件判断式的连接

select * from emp where sal>2000 and deptno=20--交集（满足左边的同时要满足右边）

select * from emp where sal>2000 and deptno=20 and job='ANALYST' 

select * from emp where sal>2000 or deptno=20--并集（满足左边或者右边任意一个即可）

--先执行前面的两个：张 秦  先执行后面的两个：后面一排 蒋
--not>and>or(用小括号改变优先级)
select * from emp where (sal>2000 or deptno=20) and job='MANAGER'

--not 取反离自己最近的那个条件判断式
select * from emp where not sal>2000 or deptno=20 and job='MANAGER'

