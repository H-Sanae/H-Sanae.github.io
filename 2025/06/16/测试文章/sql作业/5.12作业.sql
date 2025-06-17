create table t(tno varchar2(20))
insert into t values('1,2,3')
select * from t
--求tno这个字段的累计总和
select substr(tno,1,1)+substr(tno,3,1)+substr(tno,5,1)  from t

--建表shuiguo
create table shuiguo(tdate varchar2(30),tname varchar2(20),saleamount number(10))
select * from shuiguo
--查询语句，结果按梨、葡萄、西瓜、橘子、柠檬、苹果、香蕉的顺序排序，同种水果按销量降序排序   
select * from shuiguo order by case tname
       when '梨' then 1
       when '葡萄' then 2
       when '西瓜' then 3
       when '橘子' then 4
       when '柠檬' then 5
       when '苹果' then 6
       when '香蕉' then 7
       else 8 end, 
       saleamount desc

--建表emp2
create table emp2(empno number(10), ename varchar2(20), dname varchar2(20), sal number(10), e_date date)
select * from emp2
--查询出每个部门中，连续三个月工资都增长的员工信息，包括员工姓名、部门名称和连续增长的月份。 要求查询的结果格式：部门名称，员工姓名，连续增长月份
with tmp as(
     select dname 部门名称, ename 员工姓名, count(*) 连续增长月份 from( --连续增长的月份
         select tmp1.*,lag(row_num,1,row_num-1)over(partition by ename order by ename,e_date,e_date) last_row_num from( --增长的月份
                select emp2.*, -- 偏移、编号
                       lag(sal,1,null)over(partition by ename order by ename,e_date) last_sal1, --上个月的工资
                       lag(sal,2,null)over(partition by ename order by ename,e_date) last_sal2, --上上个月的工资
                       row_number()over(partition by ename order by ename) row_num
                from emp2
         ) tmp1 where sal-last_sal1>0
     ) where row_num-last_row_num=1 group by dname,ename
)
select * from tmp where 连续增长月份>=3



       


