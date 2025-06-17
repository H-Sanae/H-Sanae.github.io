--视图：用于查看表的数据，不真实存储数据，只访问基表中的行
--当视图表结构和原表结构一致的前提下，是可以通过视图表往原表里插入数据
/*当视图表结构和原表结构不一致的前提下，
原表插入数据的字段可为空，也可以通过对应视图表插入数据*/
--综合以上情况只要是视图表都最好加只读

create or replace view v_dept
as
select * from dept  with read only

select * from v_dept
select * from dept

insert into v_dept values(60,'a','a');

create or replace view v_emp
as
select ename,dname from emp inner join dept on emp.deptno=dept.deptno with read only

select * from v_emp

insert into v_emp values('a','a');

---序列：数据库的对象之一，和表之间没有关联关系，用于数字型的主键列
create sequence seq_dept
start with 1
increment by 1

--调用序列
select seq_dept.nextval from dual--序列的下一个值，nextval第一次执行相当激活序列
select seq_dept.currval from dual--查看序列的当前值

select * from dept 16 销售部门  桂林市
insert into dept values(seq_dept.nextval,'销售部门','桂林市')


create table yg1
as
select empno,ename,sal from emp


select * from yg1


create sequence seq_emp
start with 1
increment by 1


insert into yg1 values(seq_emp.nextval,'张三',seq_emp1.nextval);

--修改序列
alter sequence  seq_emp increment by 100;

---删除序列
drop sequence seq_emp
---没激活的序列直接修改增长值，那么该序列的初始值变成增长值

create sequence seq_emp
start with 1
increment by 1

select seq_emp.nextval from dual
select seq_emp.currval from dual

---循序序列
create sequence seq_aa
start with 5
minvalue 1
maxvalue 30
increment by 1

drop sequence seq_aa
select seq_aa.nextval from dual
alter sequence seq_aa cycle




--15、查询“c001”课程比“c002”课程成绩高的所有学生的学号；自己跟自己比
select * from sc inner join sc sc1 on sc.sno=sc1.sno and sc.cno='c001' and sc1.cno='c002'
where sc.score>sc1.score

--
select * from(
select sno,cno,score from sc where cno='c001') t1 inner join 
(select sno,cno,score from sc where cno='c002') t2 on t1.sno=t2.sno
where t1.score>t2.score
---走子查询
select * from sc where sno in(
select sno from sc where cno='c001'
intersect
select sno from sc where cno='c002')

---16.将所有c001课程成绩低于平均成绩的同学的分数改为60分
select * from sc where cno='c001' and score<(select avg(score) from sc where cno='c001')
update sc set score=60 where cno='c001' and score<(select avg(score) from sc where cno='c001')
--17.删除学习“谌燕”老师课的SC 表记录；
select * from sc
select * from course
select * from teacher

--找出谌燕教学的科目，再找出学过谌燕课程的学生
select sno from sc where cno in(
select cno from course where tno in(
select tno from teacher where tname='谌燕'))
--
delete from sc where sno in(
select sno from sc 
inner join course c on c.cno=sc.cno
inner join teacher t on t.tno=c.tno
where tname='谌燕')


--19、查询没学过“谌燕”老师课的同学的学号、姓名；
select sno,count(1) from sc group by sno

delete from sc where sno='s007'

select sno,sname from student where sno not in(
select sno from sc where cno in(
select cno from course where tno in(
select tno from teacher where tname='谌燕')))--c001 c002 c007 c010


--20、查询学过“c001”并且也学过编号“c002”课程的同学的学号、姓名；
select sno,sname from student where sno in(
select sno from sc where cno='c001'
intersect
select sno from sc where cno='c002')

---
select sno,sname from student where sno in(
select sno from sc where cno='c001' or cno='c002' group by sno having count(1)=2)

--21、查询出每个学科排名第一名的学生姓名列表,包括课程编号，学生姓名，学生成绩
select cno,sname,score from student s inner join(
select sno,cno,score,rank()over(partition by cno order by score desc) r from sc) t
on t.sno=s.sno 
where r=1

--22、查询选修“谌燕”老师所授课程的学生中，成绩最高的学生姓名及其成绩
select sname,score from student s inner join(--5
select sno,score,rank()over(partition by cno order by score desc) r --3
from sc where cno in(--4
select cno from course where tno in(--2
select tno from teacher where tname='谌燕'))) --1
t on t.sno=s.sno  where r=1---6


--23、查询学过“谌燕”老师所教的所有课的同学的学号、姓名；
select sno,sname from student where sno in(--5
select sno from sc --1
where cno in(select cno from course where tno in(
select tno from teacher where tname='谌燕'))---2
 group by sno having count(1)=(--3
select count(1) from course where tno in(--4
select tno from teacher where tname='谌燕')))
--24、查询至少有一门课与学号为“s001”的同学所学相同的同学的学号和姓名
select sno,sname from student where sno in(
select sno from sc where cno in(
select cno from sc where sno='s001'))


--25、查询和“s002”号的同学学习的课程完全相同的其他同学学号和姓名
select * from student s inner join(
select sno,listagg(cno,',')within group(order by cno) r from sc group by sno) t
on t.sno=s.sno 
where r=(select listagg(cno,',')within group(order by cno)  from sc where sno='s002')

--DQL（Data Query Language，数据查询语言）:select
--DDL（Data Definition Language，数据定义语言）:create、drop、alter、truncate
--DML（Data Manipulation Language，数据操作语言）:insert、delete 、update、merge
--DCL（Data Control Language，数据控制语言）:grant、revoke。
--TCL（Trasactional Control Languag, 事务控制语言）：commit、rollback和savepoint

--事务产生于会话的第一条DML语句

select * from dept

delete from dept where deptno=50;
delete from dept where deptno=70;

update dept set deptno=70 where deptno=60;

--结束事务
commit;
rollback;

create table aa(ano number(10));

delete from dept where deptno=16
select * from emp---9000
update emp set sal=9000 where empno=7499;

---
select * from emp;
update emp set sal=5000 where empno=7369;
savepoint sp1;
update emp set sal=3300 where empno=7369;
savepoint sp2;
update emp set sal=2200 where empno=7369;
--rollback to XXX 不会使事务结束。
rollback to sp2;
rollback to sp1;
rollback to sp2;
commit;

---大数据分析师 780 99% 三个月考一次

--影刀（免费）  帆软FCA 免费      fcp（499）

--软考 150+ 南宁 45分  45分 （一年两次）

--PMP（认可度高） 2500+2900+每年续费200 = 系统集成项目管理工程师

--相关专业：职称（初级职称）


select * from emp











