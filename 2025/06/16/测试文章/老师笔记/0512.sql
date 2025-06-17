--知识复盘
--函数
--字符函数
--length  lengthb
select length('你好') from dual--不区分中英文

select lengthb(66) from dual--区分中英文

--求姓名是5位长度的员工
select ename from emp where ename like '_____'

select ename from emp where length(ename)=5

--concat = ||支持oracle和MySQL
--某某某的工资是多少元

select ename||'的工资是'||sal||'元' from emp

select concat(concat(concat(ename,'的工资是'),sal),'元') from emp

select concat(concat(ename,'的工资是'),concat(sal,'元')) from emp

--ascii码表转换的就是键盘交互的所有键

--instr('aaaabbbcccdd' 原始字符串,'b' 目标字符串,1 开始位置,1 目标字符串出现的位置数)
select  instr('aaaabbbcccdd','c',9,3) from dual

--替换like 查找第几位有什么字符，确定原始字符串里面有多少个字符

select ename from emp where instr(ename,'M',1,1)!=0

select ename from emp where instr(ename,'L',1,2)!=0

select instr('aaaabbbcccdd','c',-4,1) from dual--从后往前数，从前往后截


---substr('aaaabbbcccdd' 目标字符串,1 开始位置,1 截取个数)
select substr('aaaabbbcccdd',8,10) from dual

select substr('aaaabbbcccdd',-6,3) from dual--从后往前数，到开始位置停下了往后截

--名字中含有M--一般情况模糊搜索用instr
--名字中第五位是M的--一般情况精确搜索用substr

select ename,substr(ename,5,1) from emp where substr(ename,5,1)='H'

select ename,instr(ename,'H',5,1) from emp where instr(ename,'H',5,1)=5

---附加题

create table t(tno varchar2(20))
insert into t values('1,2,3')
--求tno这个字段的累计总和
select * from t


--字符替换函数replace(str,s 被删除的字段,d 替换的值)
--替换
--删除
--脱敏
select replace('今天周一','今','周六') from dual--替换

select replace('疯狂星期四','星期四') from dual--删除

select replace('这里是军事区','军事区','博物馆') from dual--脱敏
--匹配替换
select
translate('重庆的人','重庆的','上海男'),
translate('重庆的人','重庆的重庆','北京男士们'),
translate('重庆的人','重庆的重庆','1北京男士们'),
translate('重庆的人','1重庆的重庆','北京男士们') from dual;

--数字函数
--round
select round(56.56555,2) from dual--正数是小数点之后


select round(56.56555) from dual

select round(56.56555,-2) from dual--负数是小数点之前

--mod求余函数
select mod(5,2) from dual

--判断奇偶

select sal,mod(sal,2) from emp where mod(sal,2)!=0


select trunc(98.56),round(98.56),floor(98.56),ceil(98.56) from dual


select power(5,3) from dual

select sqrt(9) from dual

--转换函数 字符转换函数  数字转换函数 日期转换函数
--数据在对比时，数据类型不统一
--正常情况下数字可以自信隐式转换，不是数字的不能使用to_number转换，结论就是一般情况不用
select * from emp where empno='7499'--隐式转换


select * from emp where empno=7499

select * from emp where empno=to_number('7499')--（数字转换的前提是看起来像数字）

select * from emp where empno=to_number('七四九九')

--to_date
--1981220
select * from emp where hiredate=to_date(19810220,'yyyymmdd')

select * from emp where hiredate=to_date(1981,'yyyy')
--跟日期有关的不管是日期转字符还是字符转日期都必须带日期格式
--万能to_char
select * from emp where to_char(hiredate,'yyyy')='1981'

select * from emp where to_char(hiredate,'mm')='06'

---跟日期有关的to_char转换一定保证是日期类型
select  to_char(sysdate,'day') from dual

--看看20080907是星期几
select to_char(to_date(20080907,'yyyymmdd'),'day') from dual


select to_char(sysdate,'d') from dual

select to_char(sysdate,'dd') from dual
select to_char(sysdate,'ddd') from dual


--next_day(sysdate,n),取离自己日期最近的一个周（下周） 的第几天，假如本周还未过到这一天，那么求的就是本周对应的天数

select next_day(next_day(sysdate,2),2) from dual

--add_months(日期,月)
select add_months(sysdate,144) from dual

--nvl2(comm目标字段,comm 目标字段有值取,0 目标字段null值取)空值替换函数 null不能做运算
select sal,nvl2(comm,comm,0),sal+nvl2(comm,comm,0) from emp

--nvl2后两个参数数据类型要一致
select comm,nvl2(comm,'1','没有') from emp

--nvl
select comm,nvl(comm,0) from emp

--翻译函数case
--简单case：写死要翻译的列，只能做等值判断
--搜索case
select deptno,
case deptno
  when 10  then '十号部门'
    when 20 then '二十号部门'
      when 30 then '三十号部门'
        else null--else可写可不写
          end from emp
--
select deptno,
case--case 开头
  when deptno=10 then '十号部门'
    when deptno=20 then '二十号部门'
      when deptno=30 then '三十号部门'
        else null end from emp --end结尾
          
--Case函数只返回第一个符合条件的值，剩下的Case部分将会被自动忽略。 
select deptno,
case
  when deptno=10 then '十号部门'
    when deptno=20 then '二十号部门'
      when deptno=30 then '三十号部门'
        when sal>2000 then '工资好高'
        else null end from emp
          
---then 和 数值直接需要用空格隔开
--被翻译后的字段数据类型要保证一致
select deptno,
case
  when deptno=10 then '6'
    when deptno=20 then '二十'
      when deptno=30 then '三十'
        else null end from emp

---case when的列可以直接放在group by 之后

select deptno from emp group by deptno

select 
case
  when deptno=10 then '十号部门'
    when deptno=20 then '二十号部门'
      when deptno=30 then '三十号部门'
        else null end from emp  
          group by 
          case
  when deptno=10 then '十号部门'
    when deptno=20 then '二十号部门'
      when deptno=30 then '三十号部门'
        else null end
---

--3.统计工资级别相应的数量（1600以下 C级,1600-3000 B级,3000以上 A级）
select count(1),
case 
  when sal<1600 then 'C级'
    when sal between 1600 and 3000 then 'B级'
      when sal>3000 then 'A级'
       else null end from emp
        group by 
        case 
  when sal<1600 then 'C级'
    when sal between 1600 and 3000 then 'B级'
      when sal>3000 then 'A级'
       else null end
---
select 
 count(case when sal<1600 then 'C级' end) C级,
   count(case when sal between 1600 and 3000 then 'B级' end) B级,
     count(case when sal>3000 then 'A级' end) A级  from emp

select count(ename) from emp

---
select job from emp

select deptno,
max(case when job='SALESMAN' then sal end) SALESMAN,
  max(case when job='MANAGER' then sal end) MANAGER,
    max(case when job='CLERK' then sal end) CLERK from emp group by deptno

--
select * from
(select deptno,job,sal from emp)--后面行转列用到上的字段
pivot
(
max(sal) for job in ('SALESMAN','MANAGER','CLERK')
)
--
select * from
(select deptno,job,sal from emp)
pivot
(
max(sal) for job in ('SALESMAN' salesman,'MANAGER' manager,'CLERK' clerk)
)
unpivot
(
newsal for job in(salesman,manager,clerk)
)
----
select sal,
case 
when comm is null then 0 
  else comm end from emp
    

--开窗函数（窗口函数）：over( partition by （可加可不加） order by(搭配排序函数必带))

--聚合函数:avg() sum() count() max() min()
--序列函数: row_number() rank() dense_rank()
--分析函数:listagg()
--偏移函数：lead  lag
select sum(sal) from emp
select sum(sal),deptno from emp group by deptno

select sum(sal)over() from emp--数据能出来意义不大

select sum(sal)over(),deptno,job,ename from emp--聚合加开窗保证程序能正常运行，但是结果集没啥意义
--不能指定列排序，只能从1开始数
select emp.*,rownum from emp
--序列函数搭配开窗，over里面必须带order
--子查询
select * from(
select emp.*,row_number()over(order by sal desc) r from emp) t
where r=4

select * from(
select emp.*,max(sal)over(partition by deptno order by sal desc) r from emp) t
where sal=r
----
select emp.*,row_number()over(order by sal desc) r from emp--不考虑并列但不跳号

select emp.*,rank()over(order by sal desc) r from emp--考虑并列但跳号

select emp.*,dense_rank()over(order by sal desc) r from emp--考虑并列且不跳号

--partition by 分组=group by 
--partition by 没有去重的效果，因为partition by是基于排序的基础上去做分组
select * from (
select emp.*,rank()over(partition by deptno order by sal desc) r from emp) t
where r=1

--求每个部门最高工资人员信息
select * from emp where sal in(
select max(sal) from emp group by deptno)--2850 3000 5000


---累加 sum +开窗over(order by),当值一致时，累计值会默认加到相同值的最后一个，失去累加效果

select sum(sal) from emp
select sum(sal),deptno from emp group by deptno
select sum(sal)over() from emp

select sum(sal)over(partition by deptno) from emp
--累计效果的partition by 有需要则加，没需要就不加
select deptno,sal,sum(sal)over(order by sal) from emp

--partition by 可以和group by 共存,前提是group by分组后的列，才能做的排序（可以用但是很少用到）
select deptno,row_number()over(partition by deptno order by deptno desc) r from emp
group by deptno

--listagg=聚合函数

select max(sal) from emp
select max(sal),deptno from emp group by deptno
select max(sal)over() from emp
select max(sal)over(partition by deptno) from emp
select max(sal)over(partition by deptno order by sal) from emp

select listagg(ename,',')within group(order by ename) from emp

select listagg(ename,',')within group(order by ename),deptno from emp group by deptno

select listagg(ename,',')within group(order by ename)over() from emp
---listagg里面的order by是语法必带，搭配开窗，开窗里面的orderby不用带
select listagg(ename,',')within group(order by ename)over(partition by deptno order by deptno ) from emp

---wm_concat(ename) 过渡函数
select wm_concat(ename) from emp  group by deptno;
--偏移的目的是把不同行的数据放到同一行做运算
---环比增长率 =（本期数－上期数）/ 上期数 ×100%
select sal,lead(sal,1,0)over(order by sal),lag(sal,1,0)over(order by sal) from emp

select ((sal-sy)/sy)*100 from(
select sal,
case 
  when lag(sal,1,0)over(order by sal)=0 then null 
    else  lag(sal,1,0)over(order by sal) end sy
 from emp) t
--to_char的占位用法,9代表占一个位置,0代表把小数点之前的0补齐

select to_char(((sal-sy)/sy)*100,'990.99')||'%' from(
select sal,lag(sal,1,null)over(order by sal) sy from emp) t

create table shuiguo(tdate varchar2(20),tname varchar2(20),saleamount number(10))
--两种批量插入方式
--方法一:执行以下语句-点击开锁-光标向右--鼠标左键拉成蓝色-选择需要复制的数据--到工具里面粘贴
select * from shuiguo  for update

delete from shuiguo

--方法二：截图在班群
--子查询
select   1    5  列
from     2    1  表
where    3    2  条件（sal>2000值）
group by 4    3  列
having   5    4  条件（筛选聚合函数）
order by 6    6  列

--单行单列 值 列  表
select avg(sal) from emp--2073.21428571428

--工资大于平均工资
select * from emp where sal>(select avg(sal) from emp)--有价值的用法

select ename,(select avg(sal) from emp) from emp

select * from (select avg(sal) from emp)

---多行单列  值（any  all in） 列  表
select deptno from dept--10 20 30 40

select * from emp where deptno in(select deptno from dept)
---比20号部门工资还要高的员工信息
select * from emp where sal>all(
select sal from emp where deptno=20)

---作为列，没有意义
select ename,(select deptno from dept where dept.deptno=emp.deptno) from emp


select * from(select deptno from dept) t

---多行多列 单行多列 表

--求每个部门的最高工资
select * from(
select emp.*,rank()over(partition by deptno order by sal desc) r from emp) t
where r=1

--多条件子查询 oracle 
select * from emp where (deptno,sal) in(
select deptno,max(sal) from emp group by deptno)

--4.查询员工工资和工作都和20号部门同时一样的员工信息

select * from emp where (job,sal) in(
select job,sal from emp where deptno=20) and deptno!=20


select * from emp where sal in (select sal from emp where deptno = 20) 
and job in （select job from emp where deptno = 20）and deptno !=20 
