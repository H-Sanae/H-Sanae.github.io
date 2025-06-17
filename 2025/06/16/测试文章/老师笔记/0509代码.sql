--子查询 
select * from emp where sal=(select max(sal) from emp )
select * from (select emp.*,row_number()over(order by sal) r from emp) 
where r between 5 and 10
select emp.*,(select sum(sal) from emp) from emp 

--找出比30部门人员工资都高
select * from emp where sal>all(select sal from emp where deptno=30)
select * from emp where sal>(select max(sal) from emp where deptno=30)
--找出比30部门任意人员工资高
select * from emp where sal>any(select sal from emp where deptno=30)
select * from emp where sal>(select min(sal) from emp where deptno=30)

在in 和exists中 子查询结果集大优先考虑用exists
在not in 和not exists 中无脑选not exists

--和s001学过同样课程的人员
select * from sc where cno in (select cno from sc where sno='s001')
 100 in   3 c01 c02 c03 300
 exists
 select * from sc sc1 where exists(select 1 from sc sc2 where sc2.sno='s001' and sc1.cno =sc2.cno) 
 100 exists c01 c02 c03  
 
 --和s001学过不同课程的学生
 select * from sc where cno  not in (select cno from sc where sno='s001')
 select * from sc sc1 where  not exists(select 1 from sc sc2 where sc2.sno='s001' and sc1.cno =sc2.cno) 


--联合查询
union all  合集 不去重 不排序 效率高

union  合集   去重且排序   效率低

intersect 交集

minus  差集  有先后之分 

交集
select * from  student where ssex='男' 
minus
select * from  student where ssex='女' 

--join 

select * from emp,dept
--where emp.deptno=dept.deptno



select * from emp  inner join dept on emp.deptnodept.deptno


--内连接  inner join 
--满足(on)匹配条件 才显示的 
select * from emp  inner join dept on emp.deptno=dept.deptno

--左外连接
--左表为主表 全显示  右表为子表 显示满足 (on)匹配条件的记录
select * from emp  left outer join dept on emp.deptno=dept.deptno

--右外连接
--右表为主表 全显示 左表为子表 显示满足(on)匹配条件的记录
select * from emp  right outer join dept on emp.deptno=dept.deptno

--全外连接
--左右表都显示，满足条件的显示 不满足的留空 
select * from emp  full  outer join dept on emp.deptno=dept.deptno

--交叉连接
select * from  emp,dept
select * from emp cross join dept

--自然连接
--等于内连接结果集

select * from emp natural join dept


--自连接
select e1.ename,e1.empno,e1.mgr,e2.ename from emp e1  inner join emp e2 on e1.mgr=e2.empno


--不等式连接
select * from salgrade s join emp on emp.sal>s.losal  and emp.sal< hisal
select * from salgrade s join emp on emp.sal between s.losal  and  hisal

我想做一个循环淘汰赛 
with tmp as(
select 'laker' name from dual
union all
select '76h' name from dual
union all
select 'wolf' name from dual
union all
select 'wa' name from dual
union all
select 'kn' name from dual
)
select * from tmp t1   join tmp t2 on t1.name > t2.name



15
student 学生表
sc 成绩表 
teacher 教师
course  课程
数据包  1500



