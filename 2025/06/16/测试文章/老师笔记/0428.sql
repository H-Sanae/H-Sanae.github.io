--查看员工表(单行注释)
select * from emp--查看员工表(单行注释)

/*多行
注释*/
select * from emp

--分号结尾;(一句话的情况下可加可不加)
/*select * from emp;*/

select * from dept;
select * from emp;


--大小写不敏感(关键词、表名、列名),插入到表里的数据区分大小写
SElect Ename FroM eMP 

select * from emp where ename='smith'

--

select*from emp

--''字符要用单引号引起,数字直接书写
--列和列之间用逗号隔开
--常量 变量
select ename,job,66,'你好','aa','姚尹锦' from emp

--一条语句的组成至少需要2个关键词 select from
--select 后面跟的是 列（字段，可以对列进行筛选）from 后面跟的是表
--*代表所有列（慎用）

select * from emp

select ename,sal from emp

--where (跟条件判断式)=
--where 对行进行筛选
select  * from emp where deptno=10

--别名（列：空格  as  表:空格）,别名不需要用单引号

select ename 姓名,sal as 工资 from emp 

select e.ename,e.sal from emp e

select emp.ename,emp.sal from emp

glxmb_bumen1_xiaozu1 

--去重 distinct 单列（完全去重）  多列
select distinct deptno from emp
select distinct deptno,job from emp 

--连接符 || oracle mysql可以使用
--使用前提是左边有值右边也有值
select ename||sal from emp

--某某某的工资是多少元
select ename||'的工资是'||sal||'元' 工资信息 from emp

--单引号：引用字符  转义
--单引号：成对开始成对结束 ，就近原则
/*"韦志杰
韦志杰'*/
select '韦志杰','"韦志杰?','''韦志杰''','''''韦志杰','韦志杰''' from dual


--虚拟表  dual  做测试  看系统日期sysdate
select sysdate from dual

select '你好' from dual


select userenv('language')from dual;

SIMPLIFIED CHINESE_CHINA.ZHS16GBK

--伪列rownum:只能从1开始数(rownum只能小于任何数和等于1)：根据查询结果集生成的一个列
--rowid:在数据插入到表里的时候就生成的，真实一直存在，有点类似身份证，用于区分数据的唯一性
select emp.*, rownum from emp where rownum<5
select emp.*,rowid from emp



