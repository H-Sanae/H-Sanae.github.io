--1.查询名字是BLAKE的人的编号,名字,工资
select empno,ename,sal from emp where ename='BLAKE'

--2.查询编号是7782的员工的编号,名字,工资,奖金
select empno,ename,sal,comm from emp where empno=7782
--3.查询职位是销售(SALESMAN)的人的名字,职位,入职日期
select ename,job,hiredate from emp where job='SALESMAN'


--4.查询部门是10的人的编号,名字,部门编号
select empno,ename,deptno from emp where deptno=10

--5.查询工资大于1500,并且小于2500的人的编号,名字,工资
select empno,ename,sal from emp where sal>1500 and sal<2500

--6.查询工资小于2000的人的名字,工资,奖金
select ename,sal,comm from emp where sal<2000

--7.求工作是CLERK的或者工资小于2000员工姓名,工作,工资
select ename,job,sal from emp where job='CLERK' or sal<2000

--8.求工资小于800或者大于1500的员工姓名,工作,工资
select ename,job,sal from emp where sal<800 or sal>1500

--9.求工作是CLERK,并且工资小于950或者大于1500的员工姓名,工作,工资
select ename,job,sal from emp where job='CLERK' and (sal<950 or sal>1500)

--10.求10号部门工资大于1000和20号部门工资大于1500的员工姓名
select ename from emp where deptno=10 and sal>1000 or deptno=20 and sal>1500

--11.求工资在1500到2000之间的员工姓名
select ename from emp where sal between 1500 and 2000

--12.求部门编号是10号，20号，30号中任意一个部门的员工姓名
select ename from emp where deptno in(10,20,30)

select ename from emp where deptno =any(10,20,30)

select ename from emp where deptno=10 or deptno=20 or deptno=30

---like 模糊搜索:通配符（_:代表一个字符，占一个位置 %:0到多个字符）
select * from emp where  ename like '%M%'

select * from emp where ename like 'M%'

select * from emp where ename like '%N'

select * from emp where ename like '_____R%'

select * from emp where ename like '%L__'

select * from emp where ename like '%M%R%' or ename like '%R%M%'

select * from emp where ename like '%M%' and ename like  '%R%'

--想把特殊字符的_和%转成普通字符
--姓名中含有_的人
--为了和后面的语言统一，我们转义也用\
select * from emp where ename like '_\__\%%' escape '\'

select * from emp where ename like '%\%__' escape '\'


--13.求姓名中包含'M'的员工姓名
select ename from emp where ename like '%M%'
--14.求员工姓名第二位是'M'的
select ename from emp where ename like '_M%'
--15.求姓名中包含A和L的姓名
select ename from emp where ename like '%A%' and ename like '%L%'
--16.求姓名是五位的员工信息
select * from emp where ename like '_____'

--17.求姓名中第3位是%的员工姓名
select ename from emp where ename like '__\%%' escape '\'

--18.求第一位是_,倒数第二位也是_的员工姓名
select ename from emp where ename like '\_%\__' escape '\'
--19.求以_开头,第三位也是下划线_,第六位是%的员工姓名
select ename from emp where ename like '\__\___\%%' escape '\'
--20.求名字中不包含M的员工姓名
select ename from emp where ename not like '%M%'

--排序（排列）order by (升序 asc(默认)降序desc)
--关键词一共6个,一条查询语句最少要有2个关键词，最多6个关键词，每个关键词只能出现一次
--关键词执行顺序 
           书写顺序  执行顺序
select   列     1       3
from     表     2       1
where    条件   3       2
order by 列     4       4



select * from emp where deptno=10  order by sal desc

select * from emp  order by sal desc

--order by 是唯一一个可以使用别名的关键词 
select sal 工资,deptno  部门 from emp  order by 工资 desc

--排序后空值最大 null !=0
select * from emp order by comm desc

--desc不共用(因为默认升序)
--程序从左往右，从上往下执行
--多个列进行排序时，先安全按照左边的列进行排序，在左边列排完的基础上，再排右边列
select * from emp order by deptno desc,sal desc

--数字指代能用但不常用
select deptno,ename,sal from emp order by 1,3 desc


---分组 group by (一般只搭配聚合函数一起使用)

select distinct deptno from emp 

select deptno from emp group by deptno

--聚合函数 max(sal:参数) min() sum() avg() count()
--多行聚合成一行的函数


select sal from emp
--count求的就是结果集里面有多少条有效数据
select max(sal),min(sal),sum(sal),avg(sal),count(1) from emp

--求的是列的有效数字
select count(comm) from emp

--一对多的关系
--分组后才有一对一的关系
select max(sal),deptno from emp group by deptno

select max(sal) from emp--5000

select deptno from emp--10 20 30
select job from emp
select ename,sal from emp
--每个部门有几个人
select  deptno,count(1) from emp where job='MANAGER' group by deptno

--关键词执行顺序 
           书写顺序  执行顺序
select   列     1       5
from     表     2       1
where    条件   3       2
group by 列     4       3
having 条件:聚合5       4
order by 列     6       6

--有分组的查询语句，那么聚合函数则在分组后产生
--人数大于4
--having 功能等同where：专门用与筛选聚合函数
select  deptno,count(1) from emp  group by deptno having count(1)>4 

--以下两条语句可以看出，where 的效率要高于having
select  deptno,count(1) from emp  group by deptno having count(1)>4 and deptno=30

select  deptno,count(1) from emp where deptno=30  group by deptno having count(1)>4
order by deptno 
 
---分组后select 后面只能跟分了组的列和聚合函数

--group by后面产生所有的聚合函数，select只是展示
select deptno,job,avg(sal),count(1),sum(sal) from emp group by deptno,job

--having 只能筛选聚合函数和分组后的列
select deptno,count(1) from emp where job='SALESMAN' group by deptno

select deptno,count(1) from emp   group by deptno having job='SALESMAN'


