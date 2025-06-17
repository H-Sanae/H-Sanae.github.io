-- 上机练习10

--1.查询工资比20号部门工资都大的员工信息
select * from emp where sal>(select max(sal) from emp where deptno=20)

--2.查询工资比20号部门工资任意一个大的员工信息
select * from emp where sal>(select min(sal) from emp where deptno=20)

--3.求最高工资员工的姓名
select ename from emp where sal=(select max(sal) from emp)

--4.查询员工工资和工作都和20号部门同时一样的员工信息
select * from emp where (sal,job) in(select sal,job from emp where deptno=20)

--5.查询部门平均工资大于整个公司平均工资的部门
select deptno from emp group by deptno having avg(sal)>(select avg(sal) from emp)

--6.求工资前五名的员工信息
select * from (
       select emp.*,dense_rank()over(order by sal desc) rnk from emp
) where rnk<=5

--7.查询emp表中所有数据的第2条到第5条
select * from(
       select emp.*,row_number()over(order by rownum desc) rnk from emp
) where rnk between 2 and 5 

--8.求每个部门工资最高的员工信息
select * from emp where (deptno,sal) in(
       select deptno,max(sal) from emp group by deptno
)

-- 上机练习11

--1.查询所有员工的名字和部门名称
select ename,dname from emp,dept where emp.deptno=dept.deptno
select ename,dname from emp inner join dept on emp.deptno=dept.deptno

--2.查询所有部门名称及部门的所有员工列表
select d.deptno,wm_concat(ename)
from dept d left join emp e on d.deptno = e.deptno
group by d.deptno,d.dname
order by d.deptno

--3.求所有员工姓名,工资和其领导的姓名,工资
select yg.ename,yg.sal,ld.ename,ld.sal 
from emp yg inner join emp ld on yg.mgr=ld.empno

--4.求所有员工工资大于其领导工资的员工姓名和其上级领导姓名，上级领导工资及员工工资
select yg.ename,yg.sal,ld.ename,ld.sal 
from emp yg inner join emp ld on yg.mgr=ld.empno 
where yg.sal>ld.sal

--5.在上题的基础上查询员工所对应的部门
select yg.deptno,dname,yg.ename,yg.sal,ld.ename,ld.sal 
from emp yg inner join emp ld on yg.mgr=ld.empno
inner join dept on yg.deptno=dept.deptno
where yg.sal>ld.sal

--6.查询出不是领导的员工
select * from emp where empno not in (select mgr from emp where mgr is not null)

--7.查询出每个员工编号，姓名，部门名称，工资等级和他的上级领导的姓名，工资等级
select yg.empno,yg.ename,dname,yg_sg.grade,ld.ename,ld_sg.grade
from  emp yg 
inner join dept d on yg.deptno=d.deptno
left join emp ld on yg.mgr=ld.empno
left join salgrade yg_sg on yg.sal between yg_sg.losal and yg_sg.hisal
left join salgrade ld_sg on ld.sal between ld_sg.losal and ld_sg.hisal


-- 上机练习12
--1.10号部门的部门名称和7369的员工姓名进行行拼显示，使用union all实现
select dname from dept where deptno=10
union all
select ename from emp where empno=7369

--2.查看不是领导的员工编号和员工姓名，使用minus和子查询实现
select empno,ename from emp
minus
select empno,ename from emp where empno in (select mgr from emp where mgr is not null)


--上机练习13

--1.查询比三个部门平均工资都高的员工编号，员工姓名，工种和收入
select empno,ename,job,sal from emp where sal>all(
       select avg(sal) from emp group by deptno
)

--2.显示部门名称为RESEARCH的员工姓名，工资
select ename,sal from emp e
join dept d on e.deptno=d.deptno
where dname='RESEARCH'

--3.如果部门名称中含有字母T，则查询该部门所有员工信息，两种方法实现
--join
select * from emp e
join dept d on e.deptno=d.deptno
where dname like '%T%'
--子查询
select * from emp where deptno in(
       select deptno from dept where dname like '%T%'
)

--4.如果有平均工资不小于1500的部门信息则查询相应的部门信息
select * from dept where deptno in(
       select deptno from emp group by deptno having avg(sal)>=1500
)

--5.查询出Emp表中比所有销售员(“SALESMAN”)工资低的员工姓名、工作、工资
select ename,job,sal from emp where sal<(
       select min(sal) from emp where job='SALESMAN' 
)

--6.显示比工资最高的员工参加工作时间晚的员工姓名，参加工作时间
select ename,hiredate from emp where hiredate>all(
       select hiredate from emp where sal=(
              select max(sal) from emp
       )
)

--7.查询emp表中有2个以上直接下属的领导人员信息
select * from emp e where exists(
       select 1 from emp where mgr=e.empno  group by mgr having count(*)=2
)

--8.使用开窗函数求出emp表中每一个部门工资第一高的人员姓名ename和人员工资sal，以及他所在部门的最高工资
with rnk_emp as(
     select ename,sal,deptno,
            row_number()over(partition by deptno order by sal desc)  row_num,
            max(sal)over(partition by deptno) dept_max_sal
     from emp
)
select * from rnk_emp where row_num=1

--9.emp表中每个部门员工入职日期最早的员工信息，多条件子查询
select e.* from emp e join(
       select deptno,min(hiredate) min_date from emp group by deptno
) d on e.deptno=d.deptno and e.hiredate = d.min_date

--10.实现下表功能
--小计
select e.deptno "部门", d.dname "部门名称", e.job "工作", count(*) "小计", null "合计"
from emp e join dept d on e.deptno = d.deptno
group by e.deptno, d.dname, e.job
union all
--合计
select e.deptno "部门", d.dname "部门名称", null "工作", null "小计", count(*) "合计"
from emp e join dept d on e.deptno = d.deptno
group by e.deptno, d.dname
order by "部门","工作" nulls first
