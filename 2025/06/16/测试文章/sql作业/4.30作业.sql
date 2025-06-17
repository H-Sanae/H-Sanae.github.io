--学生管理系统
select * from course
select * from student
select * from sc1

--1.将c002课程的成绩增加5分
update sc set score=score+5 where cno='c002' 

--2.将c001课程成绩小于80分的同学的成绩增加10分
update sc set score=score+10 where cno='c001' and score<80

--3.增加一个学生:学号's013'，姓名：'王麻子'，年龄：28，性别：男
insert into student values('s013','王麻子',28,'男')

--4.创建一张和sc表相同的表，并将s001和s002学生的选课信息插入新表中
create table sc1 as
select * from sc where sno='s001' or sno='s002'

--5.将所有c001课程成绩不及格的同学的分数改为60分
update sc set score=60 where cno='c001' and score<60

--6.删除“s002”同学的“c001”课程的信息记录
delete from sc where sno='s002' and cno='c001'
--重新插入“s002”同学的“c001”课程的信息记录
insert into sc values('s002','c001',80.90);

--7.用sc1去更新sc，当学生和选修课程相同的时候，把sc1的分数更新到sc，不同的时候就插入到sc
 merge into sc
 using sc1
 on(sc.sno=sc1.sno and sc.cno=sc1.cno)
 when matched then
 update set sc.score=sc1.score
 when not matched then
 insert values(sc1.sno,sc1.cno,sc1.score)
 
 --操作符练习
 select * from emp
 
--1.查询名字是BLAKE的人的编号,名字,工资
select empno,ename,sal from emp where ename='BLAKE'

--2.查询编号是7782的员工的编号,名字,工资,奖金
select empno,ename,sal,comm from emp where empno='7782'

--3.查询职位是销售(SALESMAN)的人的名字,职位,入职日期
select ename,job,hiredate from emp where job='SALESMAN'

--4.查询部门是10的人的编号,名字,部门编号
select empno,ename,deptno from emp where deptno=10 

--5.查询工资大于1500,并且小于2500的人的编号,名字,工资
select empno,ename,sal from emp where sal>1500

--6.查询工资小于2000的人的名字,工资,奖金
select ename,sal,comm from emp where sal<2000

--7.求工作是CLERK的或者工资小于2000员工姓名,工作,工资
select ename,job,sal from emp where job='CLERK'

--8.求工资小于800或者大于1500的员工姓名,工作,工资
select ename,job,sal from emp where sal<800 or sal>1500

--9.求工作是CLERK,并且工资小于950或者大于1500的员工姓名,工作,工资
select ename,job,sal from emp where job='CLERK' and (sal<950 or sal>1500)

--10.求10号部门工资大于1000和20号部门工资大于1500的员工姓名
 select ename from emp where deptno=10 and sal>1000 or deptno=20 and sal>1500
 
--11.求工资在1500到2000之间的员工姓名
select ename from emp where sal  between 1500 and 2000

--12.求部门编号是10号，20号，30号中任意一个部门的员工姓名
select ename from emp where deptno in(10,20,30)

--13.求姓名中包含'M'的员工姓名
select ename from emp where ename like '%M%'

--14.求员工姓名第二位是'M'的员工姓名
 select ename from emp where ename like '_M%'

--15.求姓名中包含A和L的姓名
 select ename from emp where ename like '%A%' and ename like '%L%' 

--16.求姓名是五位的员工信息
select  * from emp where ename like '_____'

--17.求姓名中第3位是%的员工姓名
select ename from emp where ename like '__\%%' escape '\'

--18.求第一位是_,倒数第二位也是_的员工姓名
select ename from emp where ename like '\_%' and ename like '%\__' escape '\'

--19.求以_开头,第三位也是下划线_,第六位是%的员工姓名
select ename from emp where ename like '\__\___\%%' escape '\'

--20.求名字中不包含M的员工姓名
select ename from emp where ename not like '%M%'
