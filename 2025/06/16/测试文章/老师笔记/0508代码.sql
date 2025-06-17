

--函数
--转换函数
to_date
to_char
to_number

日期 

number(5,-2)

select hiredate,to_char(hiredate,'day'),to_char(hiredate,'d'),to_date('1999-12-12','yyyy-mm-dd'),to_char(sal,'$99999D99') from emp
世纪 ：   cc
年份格式： yyyy yy
季度： q
月份      mm  mon month
周   w  ww  day
日   d  dd ddd  
时   h  hh24 hh  
分   mi
秒   ss
 



字符 


--数字函数列表 
abs()--绝对值
sign() --取符号 

ceil()向上取整
floor() 向下取整 

round() 四舍五入
trunc() 切取


mod() 余数 
power() 幂运算  
select  chr(97) from dual 
这个字符串里时数字还是字母

--字符串函数 
ascii()数字转换成对应的字母
chr(65) 把字母转换成对应的数字 

concat() 拼接 2个
lower     大写转小写
upper     小写转大写
initcap    首字母大写

--替换函数
replace()    替换单词
translate()  替换 字母

--字符操作
substr(处理对象，从哪开始，长度) 拆分 
instr(查找对象，查找什么，从第几个字符开始，查找第几次出现)   查找  
length    长度测量  
--字符填充和删除 
ltrim
lpad
rtrim
rpad

trim(both|leading|trailing '剔除字符' from 列名)

--日期函数 
add_months 
select hiredate,add_months(hiredate,6) from emp
months_between 
select hiredate,months_between(sysdate,hiredate) from emp


last_day
select last_day(sysdate) from dual
next_day--里当前最近的星期几
select next_day(sysdate,4) from dual

round
select round(sysdate,'dd') from dual

trunc
select to_char(trunc(sysdate,'yyyy'),'yyyymmdd hh24:mi:ss') from dual

 select systimestamp -hiredate,sysdate-hiredate,sysdate+ interval '365 2:25:50'day(3) to second from emp
interval 

select add_months(last_day(sysdate),1) from dual



interval year to month
interval day to second 

本月第一天  trunc(sysdate,'mm')
本年第一天  trunc(sysdate,'yyyy')
本周第一天 select  next_day(sysdate,1)-7 from dual

本月最后一天 last_day
本年最后一天 select to_date(to_char(sysdate,'yyyy')||'1231','yyyymmdd') from dual
本周最后一天  next_day(sysdate,7)
SYSTIMESTAMP - INTERVAL '1' HOUR

date timestamp


select comm ,nvl2(comm,comm+100,500) from emp

1、使用concat 函数完成 "我是***,我的工作是***" 
2、对emp  ename字段首字母进行大写
3、使用函数 求所有人员姓名的大写 首字母大写 小写 以及姓名字符长度 initcap（），upper（），lower（），length（）

1、查询emp表所有列，并对所有列设置别名，查询时使用表别名进行操作。
2、计算所有员工的年薪、日薪、以及总薪资 【sal（月薪），comm（奖金）nvl()】取中文别名
3、从EMP表中获取job下所有职业名【distinct】（进阶需求：将工作名称都替换成中文case when）
4、使用 员工姓名以及工作和工资组成 “我是**，我的工作是** ，我的工资是￥***”【ename、job、sal || 】
5、获取‘SMITH’的员工信息 将其工资提高50% 并将其奖金加100.【ename、comm、sal 、nvl（）   】
6、求所有工资大于1000并有奖金的员工的姓名ename、部门deptno、工资sal、奖金comm。（进阶需求：将姓名首字母大写，计算他们的总薪酬（sal+comm）nvl）
7、获取所有职位是销售（SALESMAN）,办事员（CLERK ）、经理（manager）的员工的姓名、入职时间、所在部门以及工资。（使用in 和or两种方法进行判断）（进阶需求：剔除名字中有A的员工以及名字长度大于5的员工（使用两种方法实现））
8、获取工资在1000至3000的人员姓名，按照人员名称ename进行排序【进阶需求、使用ename字母数多少以及工资高低进行排序】between
9、获取早于1982的员工的信息，剔除所有带A字符的员工。（to_date或to_char、not ）
10、查询各个部门经理('MANAGER')的工资，并排序（进阶需求：根据部门进行涨工资、10号部门涨薪100，20号部门涨新=200 30号部门涨薪300）



1.求姓名为SMITH的员工的工作名称长度
select length(job) from emp where ename='SMITH'
2.求名字长度为6的员工姓名，编号
select ename,empno from emp where length(ename)=6
3.求员工的工资，格式如：姓名是：SMITH,工资是：800
select '姓名是：'||ename||'，工资是：'||sal from emp 
where ename='SMITH'

4.找出emp表中员工名字包含T字母的员工
SELECT ENAME FROM emp where instr(ename,'T')>0
 5.找出emp表里名字第4位之后含T字母的员工
 SELECT ENAME FROM emp where instr(ename,'T',4)>0
6.找出emp表里名字倒数第3位之前含M字母的员工
select ename from emp  where instr(ename,'M',-3)>0
7.求第五位是H的员工姓名
select ename from emp where substr(ename,5,1)='H'
8.求姓名中带有三个L的姓名
select ename from emp where instr(ename,'L',1,3)>0 
select ename from emp where length(ename)-length(replace(ename,'L',''))>=3
like %L%L%L%
9.将员工姓名首字母大写，其余字母小写 
initcap 
10.将员工姓名首字母小写，其余字母大写 
select ename,lower(substr(ename,1,1))||substr(ename,2) from emp
11.查询工资是偶数的员工
select ename ,sal from emp where mod(sal,2)=0 
 12.求1981年2月20号入职的员工
 select * from emp where hiredate = to_date(19810220,'yyyymmdd')
13.求1981年入职的员工
 select * from emp where to_char(hiredate,'yyyy') = 1981

14.求2月份入职的员工
 select * from emp where to_char(hiredate,'mm') = 2

15.取当前月倒数第5天入职的员工
select * from emp where hiredate=last_day(hiredate)-5


16.取每个月倒数第5天入职的员工


17.求下下个周三的日期
select next_day(sysdate,'4')+7 from dual


18.求3个月后的今天
add_months(sysdate,3)

19.求每个员工的月收入
select sal+nvl(comm,0) from emp 
20.如果comm为空就显示“No Commission”，如果不为空就显示comm的值
select nvl(to_char(comm),'No Commission') from emp

21.求员工的一年的总收入（工资和佣金）
(sal+nvl(comm,0))*12



9.求所有ename带‘L’的员工，并以L为界将L前的字母大写，之后的字母小写。
select ename,substr(ename,1,instr(ename,'L')),lower(substr(ename,instr(ename,'L')+1))
from emp
where ename like '%L%'

10.对所有ename用空格进行长度补齐，左右两边的空格数大致相同，使其统一长度为15，（对该列数据进行去空格操作）
select rpad(lpad(ename,8+floor(length(ename)/2),'*'),15,'*') a from emp
lpad  rpad

substr（ename，-3）
order by length(ename)

select * from emp
where instr(ename,'T',-1)=length(ename)
and  


ceil+mod

select * from emp where hiredate =(select max(hiredate)from emp ) or hiredate =(select min(hiredate) from emp )  

select to_char(hiredate,'day') ,hiredate + interval '10' year from  emp



months_between
(sysdate-hiredate) /7

to_char(last_day(hiredate),'day')
next_day(last_day(hiredate),2)


to_date('2015-3月-18 13:13:13','yyyy-mon-dd hh24:mi:ss')

select ename,deptno,
case when deptno=10 then '总经理部'
  when deptno =20 then '研发部'
    when deptno=30 then  '销售部'
      end --简单case
      
      
case  when  判断条件1  then  输出结果1 
  when 判断条件2  then 输出结果2 
    else  输出结果3 
      end
      
      
case deptno when  10 then  '总经理部' 
   when  20  then '研发部'
     when 30 then   '销售部'
      end
      -- 简单case
case 比较字段 when     then  输出结果1 
  when 比较值 then 输出结果2 
    else  输出结果3 
      end
      select ename,sal, 
 case when sal<1000   then case when ename='SMITH' THEN  'q'else 'M'end
   when  sal<2000 then 'B'
     when sal<3000 then 'C'
       when sal< 4000 then 'D'
         else 'E'
         end
         from emp
         order by 1,3
         
         
         
select * 
from emp
where  sal>1000 
and deptno=20
and ename ='SMITH'
AND JOB ='MANAGER'
group by
having
order by

         
 decode(deptno,10 ,'总经理部',20,'研发部',30,'销售部','教学部')

decode(sign(sal-comm),-1,'小于',1,'大于',0,'等于')


--库存衣服 size
L
S
M
XL

xxL

s  m   l  xl  xxl
order by decode(size,'s',1,'m',2,'l',3,'xl',4,'xxl',5) 

case when
  

select sno,
max(case when cno='c001' then score end) c001 ,
max(case when cno='c002' then score end) c002 ,
max(case when cno='c003' then score end) c003 ,
max(case when cno='c004' then score end) c004 ,
max(case when cno='c005' then score end) c005 ,
max(case when cno='c006' then score end) c006 ,
max(case when cno='c007' then score end) c007 ,
max(case when cno='c008' then score end) c008 ,
max(case when cno='c009' then score end) c009 ,
max(case when cno='c010' then score end) c010 
from sc
group by sno
order by sno

select * from (
select * from  sc
pivot (max(score) for cno in ('c001' c001,'c002' c002,'c003' c003,'c004' c004,'c005' c005,'c006' c006,'c007' c007,'c008' c008,'c009'c009,'c010' c010)))
unpivot(score for cno in (c001,c002,c003,c004,c005,c006,c007,c008,c009,c010))


--排序开窗 

提取 前10名的学生成绩 

select * from sc
where rownum<=10
order by score desc

select * from (
select sc.* ,
row_number()over(partition by cno  order by  SCORE desc ) r,--没并列
rank() over(partition by cno  order by  SCORE desc) rr, --并列但是跳号
dense_rank() over(partition by cno  order by  SCORE desc) rrr--并列但是连续不跳号
from sc
)
where r<=10

select * from (
select sno,cno,score,rank()over(partition by sno order by score desc) r,
row_number() over(partition by sno order by score desc) rr
from sc 
)
where r=1
and rr=2


---聚合开窗 
sum avg max min count


select sno,cno,score,case when score=max(score)over(partition by sno) then '最高分科目'else '其他' end
from sc



充值记录表 
第一笔充值 一直到 充满300元 用了多少时间
ID 充值金额 充值时间 
select sno,cno, score, sum(score)over(partition by sno order by cno)
from sc



--偏移开窗 
同比 去年同月增长
环比 上月数据增长

lag
lead

select sno,cno,score,
lag(score,1)over(partition by cno order by score desc),
lead(score,1)over(partition by cno order by score desc)
 from sc



