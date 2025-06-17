--上机练习7

--1.求姓名为SMITH的员工的工作名称长度
select length(job) from emp where ename='SMITH'

--2.求名字长度为6的员工姓名，编号
select ename,empno from emp where length(ename)=6

--3.求员工的工资，格式如：姓名是：SMITH,工资是：800
select '姓名是：' || ename || '，工资是：' || sal from emp

--4.找出emp表中员工名字包含T字母的员工
select ename from emp where ename like '%T%'

--5.找出emp表里名字第4位之后含T字母的员工
select ename from emp where ename like '____%T%'

--6.找出emp表里名字倒数第3位之前含M字母的员工
select ename from emp where ename like '%M%___'

--7.求第五位是H的员工姓名
select ename from emp where ename like '____H%'

--8.求姓名中带有三个L的姓名
select ename from emp where ename like '%LLL%'

--9.将员工姓名首字母大写，其余字母小写
select initcap(ename) from emp

--10.将员工姓名首字母小写，其余字母大写
select lower(substr(ename,1,1)) || upper(substr(ename,2)) from emp

--11.查询工资是偶数的员工
select ename,sal from emp where mod(sal,2)=0

--12.求1981年2月20号入职的员工
select ename,hiredate from emp where hiredate = date '1981-02-20'

--13.求1981年入职的员工
select ename,hiredate from emp where to_char(hiredate,'yyyy')='1981'

--14.求2月份入职的员工
select ename,hiredate from emp where to_char(hiredate,'mm')='02'

--15.取当前月倒数第5天入职的员工
select ename,hiredate from emp where 
to_char(hiredate,'yyyy-mm-dd')= to_char(last_day(sysdate)-4,'yyyy-mm-dd')

--16.取每个月倒数第5天入职的员工
select ename,hiredate from emp where 
to_char(hiredate,'dd')= to_char(last_day(hiredate)-4,'dd')

--17.求下下个周三的日期
select next_day(sysdate,4)+7 from dual

--18.求3个月后的今天
select add_months(sysdate,3) from dual

--19.求每个员工的月收入
select ename,sal+nvl(comm,0) from emp

--20.如果comm为空就显示“No Commission”，如果不为空就显示comm的值
select nvl(to_char(comm),'No Commission') from emp

--21.求员工的一年的总收入（工资和佣金）
select sal*12+nvl(comm,0) 总薪资 from emp


--进阶额外40题

--1、使用concat 函数完成 "我是***,我的工作是***" 
select concat(concat('我是',ename),concat('我的工作是',job)) from emp

--2、对emp  ename字段首字母进行大写
select initcap(ename) from emp

--3、使用函数 求所有人员姓名的大写 首字母大写 小写 以及姓名字符长度 initcap（），upper（），lower（），length（）
select upper(ename),initcap(ename),lower(ename),length(ename) from emp

--3、从EMP表中获取job下所有职业名【distinct】（进阶需求：将工作名称都替换成中文case when）
select distinct case
       when job = 'CLERK' then '职员'
       when job = 'SALESMAN' then '销售'
       when job = 'PRESIDENT' then '董事'
       when job = 'MANAGER' then '经理'
       when job = 'ANALYST' then '分析'
       else '其他'
       end 职业
from emp

--4.instr()求ename字段 A字母位置 
select ename,instr(ename,'A') from emp

--5.显示所有员工的姓名，用“ai”替换所有“A”
select replace(ename,'A','ai') from emp

--6.以首字母小写后面大写方式显示所有员工姓名。
select lower(substr(ename,1,1)) || upper(substr(ename,2)) from emp

--7.查询员工姓名的第三个字母是A的员工姓名 
select ename from emp where ename like '__A%'

--8.显示正好为5个字符的员工的姓名。
select ename from emp where length(ename)=5
select ename from emp where ename like '_____'

--9.求所有ename带‘L’的员工，并以L为界将L前的字母大写，之后的字母小写。
select upper(substr(ename,1,instr(ename,'L'))) || lower(substr(ename,instr(ename,'L')+1))
from emp where ename like '%L%'

--10.对所有ename用空格进行长度补齐，左右两边的空格数大致相同，使其统一长度为15，（对该列数据进行去空格操作）。
select rpad(lpad(ename,length(ename)+ceil((15-length(ename))/2)),15) 姓名 from emp 

--11.在所有的名字中间使用‘+’进行补齐至18位（奇数名使用数字函数round（）将位数取整）
select ename,substr(ename,1,length(ename)-round(length(ename)/2)) || lpad(substr(ename,round(length(ename)/2)),18-round(length(ename)/2),'+') from emp

--12.将所有的ename中A开头或A结尾的记录 中的A去掉
select ename,replace(ename,'A') from emp where ename like 'A%' or ename like '%A'

--13.求所有名字，b字母出现的个数
select ename,length(ename)-length(replace(ename,'b')) from emp

--15.截取ename字段的后3位字母
select substr(ename,length(ename)-2) from emp

--16.求所有员工的名字字符长度，并按照从高到低排列，所有员工名称小写
select lower(ename) 员工, length(ename) 字符长度 from emp order by 字符长度 desc

--17.将ename和job 进行并列并在中间填充 * 使整列达到20个字符
select rpad(ename,20-length(job),'*') || job from emp

--18.显示员工姓名中最后一个字符是T的员工以及姓名第二个字是L 的员工 用instr这个语句实现 
select ename from emp where instr(ename,'T',-1)=length(ename) or instr(ename,'L',2)=2

--19.取所有员工日薪，精确到分，对后面的位数进行四舍五入。
select round(sal/30,2) from emp

--20.取所有员工日薪，精确到分，对小数位数进行截断，只保留整数部分
select trunc(round(sal/30,2)) from emp

21.求所有员工日薪的最大整数并加余数 

22.求所有员工日薪的最大小数点后2位有效数
23.求入职最早和入职最晚员工
24.求所有员工入职10年后的日期
25求员工入职的时间时星期几
26求员工到目前入职了多少月多少周多少天多少年，所有日期都四舍五入
27.员工入职时间月底是星期几
28求所有员工入职的下一个月的第一个星期一
29求当前时间的一个月零12天是几月几号
30求当前年月日时分秒数值相加之和
31.将2018年1月1日加一年零2个月 后是什么日期
32.把字符串2015-3月-18 13:13:13?转换成日期格式?转换成日期格式，并计算和系统当前时间间隔多少天。
33.找出各月倒数第2天受雇的所有员工。
34.显示所有11月份入职的员工
35.求 各个工作岗位中 工资最高的金额和最低的金额
36.求各个部门的工资总和，并列出工资数最高的金额，求标准差。
37.求各部门薪酬最大值和最小值的差值
38.统计 85年前入职的员工 和85年入职后的员工的平均工资
39. 将30号部门人员都改40号部门 人员显示
40.对员工工资进行评级 4000-5000 A级   3000-4000B级 2-3000C级 1-2000D级 1000以下的是F级
41对各个部门各职业工资情况进行从高到低排序
