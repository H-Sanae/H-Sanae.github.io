--1. 查询emp表中员工的名字和工资
select ename, sal from emp;

--2. 查询emp表中员工的编号,名字,奖金
select empno, ename, comm from emp;

--3. 查询部门编号和部门名称
select deptno, dname from dept;

--4. 查询员工名字和入职日期(列名中文显示 名字, 入职日期)
select ename 名字, hiredate 入职日期 from emp;

--5. 查询员工编号，名字，经理编号
select empno,  ename, mgr from emp;

--6. 查询公司里的所有部门的部门编号（去重）
select distinct deptno from emp;

--7. 查询员工的姓名和工资，按这种格式显示：simth的工资是800块
select ename || '的工资是' || sal || '块'  工资信息 from emp;

--8. 使用虚拟表来查看系统日期
select sysdate from dual;

--9. 查看员工表的前五条数据
select emp.*, rownum from emp where rownum<=5;

--10. 查看员工表的rowid
select emp.*,rowid from emp;
