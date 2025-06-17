--集合查询：行拼保证列一致
--交集intersect  并集:union union all 减集:minus
a:2 2 4 5 6
b:2 3 4 7 8
a交b:2  4
a并b:2 3 4 5 6 7 8 /2 2 2 3 4 4 5 6 7 8
a减b:5 6
b减a:3 7 8
---集合查询后的结果集字段名显示为第一条select语句的字段名
--union 拼接后结果集排序,去重
--union all不排序，不去重
--因此union all效率高于union
select deptno 编号 from emp  
union 
select deptno  from dept

select deptno from emp
union all
select deptno from dept

--集合查询关键词之间没有优先级，需要后面程序先执行用小括号括起来
select deptno from emp--10 20 30
union all
(select deptno from dept--10 20 30 40
intersect
select 40 from dual)

--minus永远都是上减下
select 50 from dual
minus
select deptno from dept


--集合查询要保证列的个数一致，当字段没值时用Null值填充
--对应字段的数据类型要保证一致
select empno,ename from emp
union all
select deptno,null from dept

---行拼+列拼
select * from emp inner join(
select deptno from emp
union
select deptno from dept) t
on t.deptno=emp.deptno

----
--5.查询部门平均工资大于整个公司平均工资的部门
select deptno,avg(sal) from emp group by deptno having avg(sal)>(select avg(sal) from emp)

--6.求工资前五名的员工信息
select * from(
select emp.*,row_number()over(order by sal desc) r from emp) t
where r<=5

--7.查询emp表中所有数据的第2条到第5条 7499 7521 7566 7654
select * from (
select emp.*,row_number()over(order by empno) r from emp) t
where r between 2 and 5
---rounum
select * from(
select emp.*,rownum r from emp) t
where r between 2 and 5

--8.求每个部门工资最高的员工信息
select * from emp where (deptno,sal) in(
select deptno,max(sal) from emp group by deptno)
---
select * from(
select emp.*,rank()over(partition by deptno order by sal desc) r from emp) t
where r=1

--1.查询所有员工的名字和部门名称
select ename,dname from emp left join dept on emp.deptno=dept.deptno
--3.求所有员工姓名,工资和其领导的姓名,工资
select emp.ename,emp.sal,ld.ename,ld.sal from emp left join emp ld on emp.mgr=ld.empno

--4.求所有员工工资大于其领导工资的员工姓名和其上级领导姓名，上级领导工资及员工工资
select emp.ename,emp.sal,ld.ename,ld.sal from emp left join emp ld on emp.mgr=ld.empno
where emp.sal>ld.sal

--5.在上题的基础上查询员工所对应的部门
select emp.ename,emp.sal,dname,ld.ename,ld.sal from emp 
left join emp ld on emp.mgr=ld.empno
left join dept on dept.deptno=emp.deptno
where emp.sal>ld.sal


--6.查询出不是领导的员工
select * from emp where empno in(
select empno from emp
minus
select mgr from emp)
---
select ld.* from emp right join emp ld on emp.mgr=ld.empno
where emp.empno is null
--
select * from emp where empno not in (select mgr from emp where mgr is not null )
--7.查询出每个员工编号，姓名，部门名称，工资等级和他的上级领导的姓名，工资等级

select emp.empno,emp.ename,dname,s.grade,ld.ename,lds.grade from emp
inner join dept on emp.deptno=dept.deptno
inner join salgrade s on emp.sal between s.losal and s.hisal
left join emp ld on emp.mgr=ld.empno
left join salgrade lds on ld.sal between lds.losal and lds.hisal


--10.实现下表功能

--小计：每个部门每个岗位有几个人
--合计：每个部门有几个人

select t.deptno 部门,dname 部门名称,job 工作,小计,合计 from dept inner join(
select deptno,job,count(1) 小计,null 合计 from emp group by deptno,job
union all
select deptno,null,null,count(1) from emp group by deptno) t
on t.deptno=dept.deptno
order by 部门,合计
---
select dept.deptno 部门,dname 部门名称,job 工作,count(1) 小计,null 合计 from emp 
inner join dept on emp.deptno=dept.deptno group by dept.deptno,dname,job
union all
select dept.deptno,dname,null,null,count(1) from emp 
inner join dept on emp.deptno=dept.deptno group by dept.deptno,dname
order by 部门,合计

---删除重复数据
create table dept1
as
select * from dept1

insert into dept1 select * from dept

--rowid
delete from dept1 where rowid not in(
select max(rowid) from dept1 group by deptno)
---
delete from dept1 where rowid not in(
select rowid from(
select rowid,row_number()over(partition by deptno order by rowid) r from dept1) t
where r=1)


--1、检索“c001”课程分数小于80，按分数降序排列的同学学号
select sno from sc where cno='c001' and score<80
order by score desc

--2、查询各个课程及相应的选修人数
select cno,count(1) from sc group by cno


--3、按照不同老师编号分类显示课程列表，课程之间用逗号隔开
select listagg(cname,',')within group(order by tno),tno from course group by tno

--4、查询各科成绩最高和最低的分：以如下形式显示：课程ID，最高分，最低分
select cno 课程ID,max(score) 最高分,min(score) 最低分 from sc group by cno
--5、查看成绩表信息，多加一列标注是否及格
select sc.*,
case when score>=60 then '及格'  
  else '不及格' end  标注
    from sc

--6、查询出只选修了一门课程的全部学生的学号和姓名
select sno,sname from student where sno in(
select sno from sc group by sno having count(1)=1)

--7、查询平均成绩大于85的所有学生的学号、姓名和平均成绩
select s.sno,pj,sname from student s inner join(
select sno,avg(score) pj from sc group by sno having avg(score)>85) t
on t.sno=s.sno

--8、统计各科成绩,各分数段人数:分数段为[100-85] a,[84-70] b,[69-60] c,[ <60] d
select 
case when score between 85 and 100 then 'a'
  when score between 70 and 84 then 'b'
    when score between 60 and 69 then 'c'
      when score<60 then 'd' end,count(1) from sc
        group by
        case when score between 85 and 100 then 'a'
  when score between 70 and 84 then 'b'
    when score between 60 and 69 then 'c'
      when score<60 then 'd' end
        
select 
count(case when score between 85 and 100 then 'a' end) a,
     count(case when score between 70 and 84 then 'b' end) b,
       count(case when score between 60 and 69 then 'c' end) c,
         count(case when score<60 then 'd' end) d from sc

--9、查询课程名称为“Oracle”，且分数低于60 的学生姓名和分数
select sname,score from sc 
inner join student s on s.sno=sc.sno
inner join course c on c.cno=sc.cno
where score<60 and cname='Oracle'


--10、查询所有学生的选课情况，选了多少门课程；
select sname,nvl2(xk,to_char(xk),'没选课') from student s left join (
select sno,count(1) xk from sc group by sno) t
on t.sno=s.sno
--
select sname,to_char(count(1)) from student s 
inner join sc on s.sno=sc.sno
group by sname
union all
select sname,'没选课' from student where sno not in(select sno from sc)


/*11、统计每门课程的学生选修人数（超过1人的课程才统计）。要求输出课程号和选修人
数，查询结果按人数降序排列，若人数相同，按课程号升序排列*/
select cno,count(1) from sc group by cno having count(1)>=1
order by count(1) desc,cno


/*12.向SC表中插入一些记录，这些记录要求符合以下条件：没有上过编号“c002”课程的同
学学号、“c002”号课的平均成绩；*/ 给没有上过c002课程的同学上一次c002课程

select * from sc  sno cno score

insert into sc 
select sno,'c002',(select avg(score) from sc where cno='c002') from student
where sno not in(select sno from sc where cno='c002')

--13、查询全部学生都选修的课程的课程号和课程名
select cno,cname from course where cno in(
select cno from sc group by cno having count(1)=(
select count(1) from student))
--14、查询没有学全所有课的同学的学号、姓名；
select sno,sname from student where sno in(
select sno  from sc group by sno having count(1)!=(
select count(1) from course))

---上机13
--1.查询比三个部门平均工资都高的员工编号，员工姓名，工种和收入
select empno,ename,job,sal from emp where sal >all(
select avg(sal) from emp group by deptno)

--2.显示部门名称为RESEARCH的员工姓名，工资
emp dept
--连接查询比子查询效率要高

select ename,sal from emp inner join dept on emp.deptno=dept.deptno
where dname='RESEARCH'
---
select ename,sal from emp where deptno in(
select deptno from dept where dname='RESEARCH')

--3.如果部门名称中含有字母T，则查询该部门所有员工信息，两种方法实现
select * from emp where deptno in(
select deptno from dept where instr(dname,'T',1,1)>0)
select * from emp where deptno in(
select deptno from dept where dname like '%T%')
--
select emp.* from emp inner join dept on emp.deptno=dept.deptno where instr(dname,'T',1,1)>0

select emp.* from emp inner join dept on emp.deptno=dept.deptno where  dname like '%T%'

--4.如果有平均工资不小于1500的部门信息则查询相应的部门信息
select * from dept where deptno in(
select  deptno from emp group by deptno having avg(sal)>=1500)

/*select dname,pj from dept inner join(
select  deptno,avg(sal) pj from emp group by deptno having avg(sal)>=1500) t
on t.deptno=dept.deptno*/

--5.查询出Emp表中比所有销售员(“SALESMAN”)工资低的员工姓名、工作、工资
select ename,job,sal from emp where sal<all(
select sal from emp where job='SALESMAN')

--6.显示比工资最高的员工参加工作时间晚的员工姓名，参加工作时间
select ename,hiredate from emp where hiredate>(
select hiredate from emp where sal=(select max(sal) from emp))
--
select * from emp where hiredate>(
select hiredate from(
select ename,hiredate,rank()over(order by sal desc) r from emp) t
where r=1)



--7.查询emp表中有2个以上直接下属的领导人员信息
select * from emp where empno in(
select mgr from emp group by mgr having count(1)>=2)

select ld.empno,count(1) from emp inner join emp ld on emp.mgr=ld.empno group by ld.empno
/*
8.使用开窗函数求出emp表中每一个部门工资第一高的人员姓名ename和人员工资sal，
以及他所在部门的最高工资*/
select * from(
select  ename,sal,rank()over(partition by deptno order by sal desc) r,
max(sal)over(partition by deptno)
 from emp) where r=1

--9.emp表中每个部门员工入职日期最早的员工信息，多条件子查询
select * from emp where (deptno,hiredate)in(
select deptno,min(hiredate) from emp group by deptno)



--10.实现下表功能
select t.deptno 部门, dname 部门名称,job 工作,小计，合计 from dept inner join(
select deptno,job,count(1) 小计,null 合计 from emp group by deptno,job
union all
select deptno,null,null,count(1) from emp group by deptno) t
on t.deptno=dept.deptno order by 部门,合计

update emp set deptno=30 where empno=7844

select dept.deptno 部门,dname 部门名称,job 工作,count(1) 小计,null 合计 from emp 
inner join dept on emp.deptno=dept.deptno
group by dept.deptno,dname,job
union all
select dept.deptno,dname,null,null,count(1) from emp 
inner join dept on emp.deptno=dept.deptno
group by dept.deptno,dname
order by 部门, 合计

select * from t

select substr(tno,1,1)+substr(tno,3,1)+substr(tno,5,1) from t

select sum(a) from (
select  substr(tno,1,1) a from t
union all
select  substr(tno,3,1) from t
union all
select  substr(tno,5,1) from t)


---
/*查询出每个部门中，连续三个月工资都增长的员工信息，
包括员工姓名、部门名称和连续增长的月份。
要求查询的结果格式：部门名称，员工姓名，连续增长月份*/
select * from yg 
inner join yg yg1 on yg.ygxm=yg1.ygxm 
and yg.dname=yg1.dname and yg.sal<yg1.sal and substr(yg.yf,6,1)+1=substr(yg1.yf,6,1)
inner join yg yg2 on yg.ygxm=yg2.ygxm 
and yg.dname=yg2.dname and yg1.sal<yg2.sal and substr(yg1.yf,6,1)+1=substr(yg2.yf,6,1)

------
select * from(
select dname,ygxm,sal,yf,
lead(sal,1,null)over(partition by ygxm,dname order by yf) next_sal,
lead(yf,1,null)over(partition by ygxm,dname order by yf) next_month,
lead(sal,2,null)over(partition by ygxm,dname order by yf) next_sal1,
lead(yf,2,null)over(partition by ygxm,dname order by yf) next_month1
 from yg) where sal<next_sal and next_sal<next_sal1 
 and substr(next_month1,6,1)-1=substr(next_month,6,1) 
 and substr(next_month,6,1)-1=substr(yf,6,1)

create table yg(
ygid number(4),
ygxm varchar2(10),
dname varchar2(10),
sal number(8,2),
yf varchar2(20)
)
select * from yg



--索引：目的是加快查询速度：原则上一个列最多只能建两个索引
--存储形式：
--b_tree索引
--位图索引
--基于函数索引
--反向键索引
select ename from emp--0.024
create index ind_emp_ename on emp(ename);
select ename from emp--0.019
--位图索引(目标11版本的oracle数据库不支持，升级版本即可)
create bitmap index bind_emp_ename on emp(ename);

--删除索引
drop index ind_emp_ename
--反向键索引

select* from emp where ename='张峻'--0.018

create index rind_emp_ename on emp(ename) reverse;

select* from emp where ename='张峻'--0.015

--基于函数
select * from emp where lower(ename)='smith'


create index ind_emp_ename on emp(lower(ename))

--索引的目的是加快查询速度不是改变语法的书写格式
select * from emp where lower(ename)='smith'--0.014

--按唯一性（表格建立主键约束时自动生成，正常情况下不需要手动书写）
create unique index ind_name on tb_name(col_name);

--2.非唯一索引=b_tree索引=单列索引 --索引列中可能出现重复值
create index ind_name on tb_name(col_name);


--按列的个数
--单列
create index ind_name on tb_name(col_name);

--复合索引(也称为联合索引）：写在前面的字段名且叫为主键列，
--触发索引需要用到主键列，与主键列的位置没有关系
select ename,job from emp--0.022
create index ind_emp_enamejob on emp(ename,job)

/*ename,job--走
ename--走
job--不走
job,ename--走*/

---索引失效 not like 聚合函数 != ...


select * from emp
select * from dept
select * from salgrade

select * from emp inner join   dept inner join salgrade

--exists(1 0) 判断结果集是否为真，位真则返回前面的查询语句结果集，为假则不执行前面的语句
select * from emp where exists(select deptno from dept where deptno>30);--14

select * from emp where deptno in(select deptno from dept where deptno>10)--10

--exists替换in
select * from emp where exists(select 1 from dept where dept.deptno=emp.deptno)

---大表小表  exists(and) in(or)

--外表大内表小 in 
--外表小内表大 exists

select * from emp where empno not in(select mgr from emp )

select * from emp e where  not exists(select mgr from emp  where e.empno=emp.mgr )

create table t1(c1 int,c2 int);
create table t2(c1 int,c2 int);
insert into t1 values(1,2);
insert into t1 values(1,3);
insert into t2 values(1,2);
insert into t2 values(1,null);
select * from t1 where c2 not in(select c2 from t2);  --2 null
-->执行结果：无
select * from t1 where not exists(select 1 from t2 where t2.c2=t1.c2)
-->执行结果：1 3



