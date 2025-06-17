--1.给emp表的ename列创建一个索引，建立索引前后时间对比
select * from emp where ename like 'S%'
create index idx_emp_ename on emp(ename);
select * from emp where ename like 'S%'

--2.创建job和sal的复合索引，查询工资大于2000的MANAGER员工信息
create index idx_emp_jobsal on emp(job,sal)
select * from emp where sal>2000

--3.查询所有人选修c002课程及格的情况,自己判断如何创建索引
--在sc表的cno和score字段上创建复合索引
create index idx_sc_sccno on sc(cno,score)
select sc.*,case when score>=60 then '及格' else '不及格' end 及格情况 
from sc where cno='c002' 

--4.使用小写函数来创建索引，查询带有m的员工信息
create index idx_emp_ename on emp(lower(ename))
select * from emp where ename like 'm%'

--5.修改删除一个索引
alter index idx_emp_ename rename to ind_emp_ename1；--修改
drop index ind_emp_ename1 --删除
