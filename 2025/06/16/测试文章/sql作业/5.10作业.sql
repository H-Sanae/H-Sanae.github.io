select * from student
select * from teacher
select * from course
select * from sc

--上机练习14

--1、检索“c001”课程分数小于80，按分数降序排列的同学学号
select sno,score from sc where cno='c001' and score<80 order by score desc

--2、查询各个课程及相应的选修人数
select c.cno,c.cname,count(sc.sno) 选修人数
from course c left join sc on c.cno=sc.cno 
group by c.cno,c.cname order by c.cno

--3、按照不同老师编号分类显示课程列表，课程之间用逗号隔开
select tno,listagg(cname,'，')within group(order by cno) from course group by tno

--4、查询各科成绩最高和最低的分：以如下形式显示：课程ID，最高分，最低分
select cno 课程ID, max(score) 最高分, min(score) 最低分 from sc group by cno order by cno

--5、查看成绩表信息，多加一列标注是否及格
select sc.*,case
       when score>=60 then '是'
       else '否'
       end 是否及格
from sc

--6、查询出只选修了一门课程的全部学生的学号和姓名
select sno,sname from student s where 
       (select count(*) from sc  where sc.sno=s.sno)=1
order by s.sno

--7、查询平均成绩大于85的所有学生的学号、姓名和平均成绩
select s.sno,s.sname,avg(score) 
from student s join sc on(s.sno=sc.sno) 
group by s.sno,s.sname having avg(score)>85 order by s.sno

--8、统计各科成绩,各分数段人数:分数段为[100-85] a,[84-70] b,[69-60] c,[ <60] d
select c.cno, c.cname,
    count(case when sc.score between 85 and 100 then 1 end) a,
    count(case when sc.score between 70 and 84 then 1 end) b,
    count(case when sc.score between 60 and 69 then 1 end) c,
    count(case when sc.score < 60 then 1 end) as d
from sc join course c on sc.cno=c.cno
group by c.cno, c.cname
order by c.cno

--9、查询课程名称为“Oracle”，且分数低于60 的学生姓名和分数
select s.sname, sc.score 
from student s 
join sc on sc.sno=s.sno
join course c on c.cno=sc.cno
where c.cname='Oracle' and sc.score<60

--10、查询所有学生的选课情况，选了多少门课程；
select s.sno,s.sname,
listagg(c.cname,'、')within group(order by sc.cno) 选课,
count(sc.cno) 合计
from student s 
join sc on sc.sno=s.sno
join course c on c.cno=sc.cno
group by s.sno,s.sname

--11、统计每门课程的学生选修人数（超过1人的课程才统计）。要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列
select cno,count(sno) 选修人数 from sc group by cno order by 选修人数 desc, cno 

--12.向SC表中插入一些记录，这些记录要求符合以下条件：没有上过编号“c002”课程的同学学号、“c002”号课的平均成绩；
insert into sc(sno,cno,score)
select s.sno,'c002',(select avg(score) from sc where cno='c002')
from student s
where s.sno not in (
      select sno from sc where cno='c002'
)

--13、查询全部学生都选修的课程的课程号和课程名
select c.cno,c.cname from course c
where not exists( --不存在未选修某一门课
      select 1 from student s where not exists(  --未选修某一门课
             select 1 from sc where sc.sno=s.sno and sc.cno=c.cno --选修了某一门课
      )
)

--14、查询没有学全所有课的同学的学号、姓名；
select sno,sname from student s
where exists(
      select 1 from course c where not exists(  --未选修某一门课
             select 1 from sc where sc.sno=s.sno and sc.cno=c.cno --选修了某一门课
      )
)

--15、查询“c001”课程比“c002”课程成绩高的所有学生的学号；
select sc1.sno,sc1.score,sc2.score from sc sc1 
join sc sc2 on sc1.sno=sc2.sno
where sc1.cno='c001' and sc2.cno='c002' and sc1.score>sc2.score

--16.将所有c001课程成绩低于平均成绩的同学的分数改为60分
update  sc set score = 60 where cno='c001' and score<(
        select avg(score) from sc where cno='c001'
)

--17.删除学习“谌燕”老师课的SC 表记录；
delete from sc where cno in(
       select c.cno from course c join teacher t on c.tno=t.tno where t.tname='谌燕'
)

--18.创建dept1表获取scott.dept表数据，再使用insert...select插入一次scott.dept表数据到detp1表，再使用删除语句删除重复数据
create table dept1 as select * from scott.dept; --建表
insert into dept1 select * from scott.dept; --插入
--删除重复数据
--方法一
delete from dept1 where rowid not in(
       select max(rowid) from dept1 group by deptno
)
--方法二
delete from dept1 where rowid not in(
       select rowid from(
              select dept1.*,rowid,row_number()over(partition by deptno order by deptno) r from dept1
       ) where r=1
)

--19、查询没学过“谌燕”老师课的同学的学号、姓名；
select sno,sname from student s where not exists(
       select 1 from sc 
       join course c on sc.cno=c.cno
       join teacher t on c.tno=t.tno
       where sc.sno=s.sno and t.tname='谌燕' 
) order by s.sno

--20、查询学过“c001”并且也学过编号“c002”课程的同学的学号、姓名；
select sno,sname from student s where exists(
       select 1 from sc where sc.sno=s.sno and cno='c001'
) and exists(
       select 1 from sc where sc.sno=s.sno and cno='c002'
) order by s.sno

--21、查询出每个学科排名第一名的学生姓名列表,包括课程编号，学生姓名，学生成绩
--子查询
select sc.cno,s.sname,sc.score from sc 
join student s on s.sno=sc.sno
where sc.score=(
      select max(score) from sc where cno=sc.cno
) order by sc.cno
--窗口函数
with rnk as(
     select sc.cno 课程编号, s.sname 学生姓名, sc.score 学生成绩,
     dense_rank()over(partition by sc.cno order by sc.score desc) 排名
     from sc join student s on s.sno=sc.sno
)
select 课程编号,学生姓名,学生成绩 from rnk where 排名=1 order by 课程编号

--22、查询选修“谌燕”老师所授课程的学生中，成绩最高的学生姓名及其成绩
with cy_c as( -- 获取谌燕老师教授的所有课程
     select c.cno from course c 
     join teacher t on t.tno=c.tno
     where t.tname='谌燕' 
),
top_s as( -- 找出这些课程中成绩最高的学生
      select sname 学生姓名, score 成绩 ,dense_rank()over(order by sc.score desc) 排名
      from sc join student s on s.sno=sc.sno
      where sc.cno in(select cno from cy_c)
)
select 学生姓名,成绩 from top_s where 排名=1

--23、查询学过“谌燕”老师所教的所有课的同学的学号、姓名；
with cy_c as( -- 获取谌燕老师教授的所有课程
     select c.cno from course c 
     join teacher t on t.tno=c.tno
     where t.tname='谌燕' 
)
select s.sno 学号, s.sname 姓名
from student s where not exists( -- 不存在没选修的课程->选修了全部课程
     select 1 from cy_c where not exists( --没选修谌燕老师某一课程
            select 1 from sc where sc.sno=s.sno and sc.cno=cy_c.cno --选修了谌燕老师某一课程
     )
) order by 学号


--24、查询至少有一门课与学号为“s001”的同学所学相同的同学的学号和姓名
with s1_c as( -- 获取s001同学的所有课程
     select cno from sc where sno='s001' 
)
select s.sno,s.sname from student s
join sc on sc.sno=s.sno
where sc.cno in(select * from s1_c)

--25、查询和“s001”号的同学学习的课程完全相同的其他同学学号和姓名
with s1_c as( -- 获取s1同学的所有课程
     select cno from sc where sno='s001' 
)
select s.sno 学号, s.sname 姓名 from student s
join sc on sc.sno=s.sno 
where s.sno!='s001' and not exists( --不存在
      select 1 from s1_c where not exists( --sc1没选
             select 1 from sc where sc.sno=s.sno and sc.cno=s1_c.cno --但sc选了
      )
) and not exists( --不存在
      select 1 from sc where sc.sno=s.sno and not exists( ---sc没选
             select 1 from s1_c where s1_c.cno=sc.cno --但s1选了
      )
) order by s.sno
