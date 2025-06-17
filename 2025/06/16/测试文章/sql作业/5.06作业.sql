--1.查询员工姓名、工资，按照工资的正序排列
select enmae,sal from emp order by sal

--2.查询员工信息，先按照部门编号降序排列，再按照工资的正序排列
select * from emp order by deptno desc, sal

--3.查询员工信息，先按照工资降序排列，再按照部门降序排列
select * from emp order by sal desc, deptno desc

--4.求每个部门有多少员工
select deptno, count(1)  from emp group by deptno

--5.求每个部门里的最高工资
select deptno, max(sal) from emp group by deptno

--6.参加每种工作的人数
select job, count(1) from emp group by job

--7.求员工里面的最高工资
select max(sal) from emp

--8.求公司有多少个部门
select count(1) from dept
select count(1) from (select distinct deptno from emp) --子查询

--9.求部门平均工资大于1600的部门编号
select deptno from emp group by deptno having avg(sal)>1600

--10.求部门平均工资大于1600,并且不是20号部门的部门编号
select deptno from emp where deptno!=20 group by deptno having avg(sal)>1600

--11.列出最低薪金大于1500的各种工作
select job from emp group by job having min(sal)>1500

--12.列出在每个部门工作的员工数量、平均工资
select deptno,count(1), avg(sal) from emp group by deptno

--13.列出各个部门的MANAGER（经理）的最低薪金
select deptno,min(sal) from emp where job='MANAGER' group by deptno

--14.查询每个部门每个岗位的工资总和。
select deptno, job, sum(sal) from emp group by deptno, job order by deptno

--15.查询部门人数大于2的部门编号，最低工资、最高工资,部门人数。
select deptno,min(sal),max(sal),count(1) from emp group by deptno having count(1)>2

--16.查询部门平均工资大于2000，且人数大于2的 部门编号、部门人数、部门平均工资 ，并按照部门人数升序排序。
select deptno,count(1),avg(sal) from emp group by deptno having avg(sal)>2000 and count(1)>2 order by count(1)

--17.查询员工岗位中不是以“SA”开头并且平均工资在2500元以上的岗位及平均工资，并按平均工资降序排序
select job,avg(sal) from emp where job not like 'SA%' group by job having avg(sal)>2500 order by avg(sal) desc

--18.查询岗位不为SALESMAN，工资和大于等于2500的岗位及 每种岗位的工资和
select job,sum(sal) from emp where job!='SALESMAN' group by job having sum(sal)>=2500

--19.写一个查询，显示每个部门最高工资和最低工资的差额
select deptno,max(sal)-min(sal) from emp group by deptno
