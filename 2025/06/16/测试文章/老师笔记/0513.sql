--���ϲ�ѯ����ƴ��֤��һ��
--����intersect  ����:union union all ����:minus
a:2 2 4 5 6
b:2 3 4 7 8
a��b:2  4
a��b:2 3 4 5 6 7 8 /2 2 2 3 4 4 5 6 7 8
a��b:5 6
b��a:3 7 8
---���ϲ�ѯ��Ľ�����ֶ�����ʾΪ��һ��select�����ֶ���
--union ƴ�Ӻ���������,ȥ��
--union all�����򣬲�ȥ��
--���union allЧ�ʸ���union
select deptno ��� from emp  
union 
select deptno  from dept

select deptno from emp
union all
select deptno from dept

--���ϲ�ѯ�ؼ���֮��û�����ȼ�����Ҫ���������ִ����С����������
select deptno from emp--10 20 30
union all
(select deptno from dept--10 20 30 40
intersect
select 40 from dual)

--minus��Զ�����ϼ���
select 50 from dual
minus
select deptno from dept


--���ϲ�ѯҪ��֤�еĸ���һ�£����ֶ�ûֵʱ��Nullֵ���
--��Ӧ�ֶε���������Ҫ��֤һ��
select empno,ename from emp
union all
select deptno,null from dept

---��ƴ+��ƴ
select * from emp inner join(
select deptno from emp
union
select deptno from dept) t
on t.deptno=emp.deptno

----
--5.��ѯ����ƽ�����ʴ���������˾ƽ�����ʵĲ���
select deptno,avg(sal) from emp group by deptno having avg(sal)>(select avg(sal) from emp)

--6.����ǰ������Ա����Ϣ
select * from(
select emp.*,row_number()over(order by sal desc) r from emp) t
where r<=5

--7.��ѯemp�����������ݵĵ�2������5�� 7499 7521 7566 7654
select * from (
select emp.*,row_number()over(order by empno) r from emp) t
where r between 2 and 5
---rounum
select * from(
select emp.*,rownum r from emp) t
where r between 2 and 5

--8.��ÿ�����Ź�����ߵ�Ա����Ϣ
select * from emp where (deptno,sal) in(
select deptno,max(sal) from emp group by deptno)
---
select * from(
select emp.*,rank()over(partition by deptno order by sal desc) r from emp) t
where r=1

--1.��ѯ����Ա�������ֺͲ�������
select ename,dname from emp left join dept on emp.deptno=dept.deptno
--3.������Ա������,���ʺ����쵼������,����
select emp.ename,emp.sal,ld.ename,ld.sal from emp left join emp ld on emp.mgr=ld.empno

--4.������Ա�����ʴ������쵼���ʵ�Ա�����������ϼ��쵼�������ϼ��쵼���ʼ�Ա������
select emp.ename,emp.sal,ld.ename,ld.sal from emp left join emp ld on emp.mgr=ld.empno
where emp.sal>ld.sal

--5.������Ļ����ϲ�ѯԱ������Ӧ�Ĳ���
select emp.ename,emp.sal,dname,ld.ename,ld.sal from emp 
left join emp ld on emp.mgr=ld.empno
left join dept on dept.deptno=emp.deptno
where emp.sal>ld.sal


--6.��ѯ�������쵼��Ա��
select * from emp where empno in(
select empno from emp
minus
select mgr from emp)
---
select ld.* from emp right join emp ld on emp.mgr=ld.empno
where emp.empno is null
--
select * from emp where empno not in (select mgr from emp where mgr is not null )
--7.��ѯ��ÿ��Ա����ţ��������������ƣ����ʵȼ��������ϼ��쵼�����������ʵȼ�

select emp.empno,emp.ename,dname,s.grade,ld.ename,lds.grade from emp
inner join dept on emp.deptno=dept.deptno
inner join salgrade s on emp.sal between s.losal and s.hisal
left join emp ld on emp.mgr=ld.empno
left join salgrade lds on ld.sal between lds.losal and lds.hisal


--10.ʵ���±���

--С�ƣ�ÿ������ÿ����λ�м�����
--�ϼƣ�ÿ�������м�����

select t.deptno ����,dname ��������,job ����,С��,�ϼ� from dept inner join(
select deptno,job,count(1) С��,null �ϼ� from emp group by deptno,job
union all
select deptno,null,null,count(1) from emp group by deptno) t
on t.deptno=dept.deptno
order by ����,�ϼ�
---
select dept.deptno ����,dname ��������,job ����,count(1) С��,null �ϼ� from emp 
inner join dept on emp.deptno=dept.deptno group by dept.deptno,dname,job
union all
select dept.deptno,dname,null,null,count(1) from emp 
inner join dept on emp.deptno=dept.deptno group by dept.deptno,dname
order by ����,�ϼ�

---ɾ���ظ�����
create table dept1
as
select * from dept1

insert into dept1 select * from dept

--rowid
delete from dept1 where rowid not in(
select max(rowid) from dept1 group by deptno)
---
delete from dept1 where rowid not in(
select rowid from(
select rowid,row_number()over(partition by deptno order by rowid) r from dept1) t
where r=1)


--1��������c001���γ̷���С��80���������������е�ͬѧѧ��
select sno from sc where cno='c001' and score<80
order by score desc

--2����ѯ�����γ̼���Ӧ��ѡ������
select cno,count(1) from sc group by cno


--3�����ղ�ͬ��ʦ��ŷ�����ʾ�γ��б��γ�֮���ö��Ÿ���
select listagg(cname,',')within group(order by tno),tno from course group by tno

--4����ѯ���Ƴɼ���ߺ���͵ķ֣���������ʽ��ʾ���γ�ID����߷֣���ͷ�
select cno �γ�ID,max(score) ��߷�,min(score) ��ͷ� from sc group by cno
--5���鿴�ɼ�����Ϣ�����һ�б�ע�Ƿ񼰸�
select sc.*,
case when score>=60 then '����'  
  else '������' end  ��ע
    from sc

--6����ѯ��ֻѡ����һ�ſγ̵�ȫ��ѧ����ѧ�ź�����
select sno,sname from student where sno in(
select sno from sc group by sno having count(1)=1)

--7����ѯƽ���ɼ�����85������ѧ����ѧ�š�������ƽ���ɼ�
select s.sno,pj,sname from student s inner join(
select sno,avg(score) pj from sc group by sno having avg(score)>85) t
on t.sno=s.sno

--8��ͳ�Ƹ��Ƴɼ�,������������:������Ϊ[100-85] a,[84-70] b,[69-60] c,[ <60] d
select 
case when score between 85 and 100 then 'a'
  when score between 70 and 84 then 'b'
    when score between 60 and 69 then 'c'
      when score<60 then 'd' end,count(1) from sc
        group by
        case when score between 85 and 100 then 'a'
  when score between 70 and 84 then 'b'
    when score between 60 and 69 then 'c'
      when score<60 then 'd' end
        
select 
count(case when score between 85 and 100 then 'a' end) a,
     count(case when score between 70 and 84 then 'b' end) b,
       count(case when score between 60 and 69 then 'c' end) c,
         count(case when score<60 then 'd' end) d from sc

--9����ѯ�γ�����Ϊ��Oracle�����ҷ�������60 ��ѧ�������ͷ���
select sname,score from sc 
inner join student s on s.sno=sc.sno
inner join course c on c.cno=sc.cno
where score<60 and cname='Oracle'


--10����ѯ����ѧ����ѡ�������ѡ�˶����ſγ̣�
select sname,nvl2(xk,to_char(xk),'ûѡ��') from student s left join (
select sno,count(1) xk from sc group by sno) t
on t.sno=s.sno
--
select sname,to_char(count(1)) from student s 
inner join sc on s.sno=sc.sno
group by sname
union all
select sname,'ûѡ��' from student where sno not in(select sno from sc)


/*11��ͳ��ÿ�ſγ̵�ѧ��ѡ������������1�˵Ŀγ̲�ͳ�ƣ���Ҫ������γ̺ź�ѡ����
������ѯ����������������У���������ͬ�����γ̺���������*/
select cno,count(1) from sc group by cno having count(1)>=1
order by count(1) desc,cno


/*12.��SC���в���һЩ��¼����Щ��¼Ҫ���������������û���Ϲ���š�c002���γ̵�ͬ
ѧѧ�š���c002���ſε�ƽ���ɼ���*/ ��û���Ϲ�c002�γ̵�ͬѧ��һ��c002�γ�

select * from sc  sno cno score

insert into sc 
select sno,'c002',(select avg(score) from sc where cno='c002') from student
where sno not in(select sno from sc where cno='c002')

--13����ѯȫ��ѧ����ѡ�޵Ŀγ̵Ŀγ̺źͿγ���
select cno,cname from course where cno in(
select cno from sc group by cno having count(1)=(
select count(1) from student))
--14����ѯû��ѧȫ���пε�ͬѧ��ѧ�š�������
select sno,sname from student where sno in(
select sno  from sc group by sno having count(1)!=(
select count(1) from course))

---�ϻ�13
--1.��ѯ����������ƽ�����ʶ��ߵ�Ա����ţ�Ա�����������ֺ�����
select empno,ename,job,sal from emp where sal >all(
select avg(sal) from emp group by deptno)

--2.��ʾ��������ΪRESEARCH��Ա������������
emp dept
--���Ӳ�ѯ���Ӳ�ѯЧ��Ҫ��

select ename,sal from emp inner join dept on emp.deptno=dept.deptno
where dname='RESEARCH'
---
select ename,sal from emp where deptno in(
select deptno from dept where dname='RESEARCH')

--3.������������к�����ĸT�����ѯ�ò�������Ա����Ϣ�����ַ���ʵ��
select * from emp where deptno in(
select deptno from dept where instr(dname,'T',1,1)>0)
select * from emp where deptno in(
select deptno from dept where dname like '%T%')
--
select emp.* from emp inner join dept on emp.deptno=dept.deptno where instr(dname,'T',1,1)>0

select emp.* from emp inner join dept on emp.deptno=dept.deptno where  dname like '%T%'

--4.�����ƽ�����ʲ�С��1500�Ĳ�����Ϣ���ѯ��Ӧ�Ĳ�����Ϣ
select * from dept where deptno in(
select  deptno from emp group by deptno having avg(sal)>=1500)

/*select dname,pj from dept inner join(
select  deptno,avg(sal) pj from emp group by deptno having avg(sal)>=1500) t
on t.deptno=dept.deptno*/

--5.��ѯ��Emp���б���������Ա(��SALESMAN��)���ʵ͵�Ա������������������
select ename,job,sal from emp where sal<all(
select sal from emp where job='SALESMAN')

--6.��ʾ�ȹ�����ߵ�Ա���μӹ���ʱ�����Ա���������μӹ���ʱ��
select ename,hiredate from emp where hiredate>(
select hiredate from emp where sal=(select max(sal) from emp))
--
select * from emp where hiredate>(
select hiredate from(
select ename,hiredate,rank()over(order by sal desc) r from emp) t
where r=1)



--7.��ѯemp������2������ֱ���������쵼��Ա��Ϣ
select * from emp where empno in(
select mgr from emp group by mgr having count(1)>=2)

select ld.empno,count(1) from emp inner join emp ld on emp.mgr=ld.empno group by ld.empno
/*
8.ʹ�ÿ����������emp����ÿһ�����Ź��ʵ�һ�ߵ���Ա����ename����Ա����sal��
�Լ������ڲ��ŵ���߹���*/
select * from(
select  ename,sal,rank()over(partition by deptno order by sal desc) r,
max(sal)over(partition by deptno)
 from emp) where r=1

--9.emp����ÿ������Ա����ְ���������Ա����Ϣ���������Ӳ�ѯ
select * from emp where (deptno,hiredate)in(
select deptno,min(hiredate) from emp group by deptno)



--10.ʵ���±���
select t.deptno ����, dname ��������,job ����,С�ƣ��ϼ� from dept inner join(
select deptno,job,count(1) С��,null �ϼ� from emp group by deptno,job
union all
select deptno,null,null,count(1) from emp group by deptno) t
on t.deptno=dept.deptno order by ����,�ϼ�

update emp set deptno=30 where empno=7844

select dept.deptno ����,dname ��������,job ����,count(1) С��,null �ϼ� from emp 
inner join dept on emp.deptno=dept.deptno
group by dept.deptno,dname,job
union all
select dept.deptno,dname,null,null,count(1) from emp 
inner join dept on emp.deptno=dept.deptno
group by dept.deptno,dname
order by ����, �ϼ�

select * from t

select substr(tno,1,1)+substr(tno,3,1)+substr(tno,5,1) from t

select sum(a) from (
select  substr(tno,1,1) a from t
union all
select  substr(tno,3,1) from t
union all
select  substr(tno,5,1) from t)


---
/*��ѯ��ÿ�������У����������¹��ʶ�������Ա����Ϣ��
����Ա���������������ƺ������������·ݡ�
Ҫ���ѯ�Ľ����ʽ���������ƣ�Ա�����������������·�*/
select * from yg 
inner join yg yg1 on yg.ygxm=yg1.ygxm 
and yg.dname=yg1.dname and yg.sal<yg1.sal and substr(yg.yf,6,1)+1=substr(yg1.yf,6,1)
inner join yg yg2 on yg.ygxm=yg2.ygxm 
and yg.dname=yg2.dname and yg1.sal<yg2.sal and substr(yg1.yf,6,1)+1=substr(yg2.yf,6,1)

------
select * from(
select dname,ygxm,sal,yf,
lead(sal,1,null)over(partition by ygxm,dname order by yf) next_sal,
lead(yf,1,null)over(partition by ygxm,dname order by yf) next_month,
lead(sal,2,null)over(partition by ygxm,dname order by yf) next_sal1,
lead(yf,2,null)over(partition by ygxm,dname order by yf) next_month1
 from yg) where sal<next_sal and next_sal<next_sal1 
 and substr(next_month1,6,1)-1=substr(next_month,6,1) 
 and substr(next_month,6,1)-1=substr(yf,6,1)

create table yg(
ygid number(4),
ygxm varchar2(10),
dname varchar2(10),
sal number(8,2),
yf varchar2(20)
)
select * from yg



--������Ŀ���Ǽӿ��ѯ�ٶȣ�ԭ����һ�������ֻ�ܽ���������
--�洢��ʽ��
--b_tree����
--λͼ����
--���ں�������
--���������
select ename from emp--0.024
create index ind_emp_ename on emp(ename);
select ename from emp--0.019
--λͼ����(Ŀ��11�汾��oracle���ݿⲻ֧�֣������汾����)
create bitmap index bind_emp_ename on emp(ename);

--ɾ������
drop index ind_emp_ename
--���������

select* from emp where ename='�ž�'--0.018

create index rind_emp_ename on emp(ename) reverse;

select* from emp where ename='�ž�'--0.015

--���ں���
select * from emp where lower(ename)='smith'


create index ind_emp_ename on emp(lower(ename))

--������Ŀ���Ǽӿ��ѯ�ٶȲ��Ǹı��﷨����д��ʽ
select * from emp where lower(ename)='smith'--0.014

--��Ψһ�ԣ����������Լ��ʱ�Զ����ɣ���������²���Ҫ�ֶ���д��
create unique index ind_name on tb_name(col_name);

--2.��Ψһ����=b_tree����=�������� --�������п��ܳ����ظ�ֵ
create index ind_name on tb_name(col_name);


--���еĸ���
--����
create index ind_name on tb_name(col_name);

--��������(Ҳ��Ϊ������������д��ǰ����ֶ����ҽ�Ϊ�����У�
--����������Ҫ�õ������У��������е�λ��û�й�ϵ
select ename,job from emp--0.022
create index ind_emp_enamejob on emp(ename,job)

/*ename,job--��
ename--��
job--����
job,ename--��*/

---����ʧЧ not like �ۺϺ��� != ...


select * from emp
select * from dept
select * from salgrade

select * from emp inner join   dept inner join salgrade

--exists(1 0) �жϽ�����Ƿ�Ϊ�棬λ���򷵻�ǰ��Ĳ�ѯ���������Ϊ����ִ��ǰ������
select * from emp where exists(select deptno from dept where deptno>30);--14

select * from emp where deptno in(select deptno from dept where deptno>10)--10

--exists�滻in
select * from emp where exists(select 1 from dept where dept.deptno=emp.deptno)

---���С��  exists(and) in(or)

--�����ڱ�С in 
--���С�ڱ�� exists

select * from emp where empno not in(select mgr from emp )

select * from emp e where  not exists(select mgr from emp  where e.empno=emp.mgr )

create table t1(c1 int,c2 int);
create table t2(c1 int,c2 int);
insert into t1 values(1,2);
insert into t1 values(1,3);
insert into t2 values(1,2);
insert into t2 values(1,null);
select * from t1 where c2 not in(select c2 from t2);  --2 null
-->ִ�н������
select * from t1 where not exists(select 1 from t2 where t2.c2=t1.c2)
-->ִ�н����1 3



