--��ͼ�����ڲ鿴������ݣ�����ʵ�洢���ݣ�ֻ���ʻ����е���
--����ͼ��ṹ��ԭ��ṹһ�µ�ǰ���£��ǿ���ͨ����ͼ����ԭ�����������
/*����ͼ��ṹ��ԭ��ṹ��һ�µ�ǰ���£�
ԭ��������ݵ��ֶο�Ϊ�գ�Ҳ����ͨ����Ӧ��ͼ���������*/
--�ۺ��������ֻҪ����ͼ����ü�ֻ��

create or replace view v_dept
as
select * from dept  with read only

select * from v_dept
select * from dept

insert into v_dept values(60,'a','a');

create or replace view v_emp
as
select ename,dname from emp inner join dept on emp.deptno=dept.deptno with read only

select * from v_emp

insert into v_emp values('a','a');

---���У����ݿ�Ķ���֮һ���ͱ�֮��û�й�����ϵ�����������͵�������
create sequence seq_dept
start with 1
increment by 1

--��������
select seq_dept.nextval from dual--���е���һ��ֵ��nextval��һ��ִ���൱��������
select seq_dept.currval from dual--�鿴���еĵ�ǰֵ

select * from dept 16 ���۲���  ������
insert into dept values(seq_dept.nextval,'���۲���','������')


create table yg1
as
select empno,ename,sal from emp


select * from yg1


create sequence seq_emp
start with 1
increment by 1


insert into yg1 values(seq_emp.nextval,'����',seq_emp1.nextval);

--�޸�����
alter sequence  seq_emp increment by 100;

---ɾ������
drop sequence seq_emp
---û���������ֱ���޸�����ֵ����ô�����еĳ�ʼֵ�������ֵ

create sequence seq_emp
start with 1
increment by 1

select seq_emp.nextval from dual
select seq_emp.currval from dual

---ѭ������
create sequence seq_aa
start with 5
minvalue 1
maxvalue 30
increment by 1

drop sequence seq_aa
select seq_aa.nextval from dual
alter sequence seq_aa cycle




--15����ѯ��c001���γ̱ȡ�c002���γ̳ɼ��ߵ�����ѧ����ѧ�ţ��Լ����Լ���
select * from sc inner join sc sc1 on sc.sno=sc1.sno and sc.cno='c001' and sc1.cno='c002'
where sc.score>sc1.score

--
select * from(
select sno,cno,score from sc where cno='c001') t1 inner join 
(select sno,cno,score from sc where cno='c002') t2 on t1.sno=t2.sno
where t1.score>t2.score
---���Ӳ�ѯ
select * from sc where sno in(
select sno from sc where cno='c001'
intersect
select sno from sc where cno='c002')

---16.������c001�γ̳ɼ�����ƽ���ɼ���ͬѧ�ķ�����Ϊ60��
select * from sc where cno='c001' and score<(select avg(score) from sc where cno='c001')
update sc set score=60 where cno='c001' and score<(select avg(score) from sc where cno='c001')
--17.ɾ��ѧϰ�����ࡱ��ʦ�ε�SC ���¼��
select * from sc
select * from course
select * from teacher

--�ҳ������ѧ�Ŀ�Ŀ�����ҳ�ѧ������γ̵�ѧ��
select sno from sc where cno in(
select cno from course where tno in(
select tno from teacher where tname='����'))
--
delete from sc where sno in(
select sno from sc 
inner join course c on c.cno=sc.cno
inner join teacher t on t.tno=c.tno
where tname='����')


--19����ѯûѧ�������ࡱ��ʦ�ε�ͬѧ��ѧ�š�������
select sno,count(1) from sc group by sno

delete from sc where sno='s007'

select sno,sname from student where sno not in(
select sno from sc where cno in(
select cno from course where tno in(
select tno from teacher where tname='����')))--c001 c002 c007 c010


--20����ѯѧ����c001������Ҳѧ����š�c002���γ̵�ͬѧ��ѧ�š�������
select sno,sname from student where sno in(
select sno from sc where cno='c001'
intersect
select sno from sc where cno='c002')

---
select sno,sname from student where sno in(
select sno from sc where cno='c001' or cno='c002' group by sno having count(1)=2)

--21����ѯ��ÿ��ѧ��������һ����ѧ�������б�,�����γ̱�ţ�ѧ��������ѧ���ɼ�
select cno,sname,score from student s inner join(
select sno,cno,score,rank()over(partition by cno order by score desc) r from sc) t
on t.sno=s.sno 
where r=1

--22����ѯѡ�ޡ����ࡱ��ʦ���ڿγ̵�ѧ���У��ɼ���ߵ�ѧ����������ɼ�
select sname,score from student s inner join(--5
select sno,score,rank()over(partition by cno order by score desc) r --3
from sc where cno in(--4
select cno from course where tno in(--2
select tno from teacher where tname='����'))) --1
t on t.sno=s.sno  where r=1---6


--23����ѯѧ�������ࡱ��ʦ���̵����пε�ͬѧ��ѧ�š�������
select sno,sname from student where sno in(--5
select sno from sc --1
where cno in(select cno from course where tno in(
select tno from teacher where tname='����'))---2
 group by sno having count(1)=(--3
select count(1) from course where tno in(--4
select tno from teacher where tname='����')))
--24����ѯ������һ�ſ���ѧ��Ϊ��s001����ͬѧ��ѧ��ͬ��ͬѧ��ѧ�ź�����
select sno,sname from student where sno in(
select sno from sc where cno in(
select cno from sc where sno='s001'))


--25����ѯ�͡�s002���ŵ�ͬѧѧϰ�Ŀγ���ȫ��ͬ������ͬѧѧ�ź�����
select * from student s inner join(
select sno,listagg(cno,',')within group(order by cno) r from sc group by sno) t
on t.sno=s.sno 
where r=(select listagg(cno,',')within group(order by cno)  from sc where sno='s002')

--DQL��Data Query Language�����ݲ�ѯ���ԣ�:select
--DDL��Data Definition Language�����ݶ������ԣ�:create��drop��alter��truncate
--DML��Data Manipulation Language�����ݲ������ԣ�:insert��delete ��update��merge
--DCL��Data Control Language�����ݿ������ԣ�:grant��revoke��
--TCL��Trasactional Control Languag, ����������ԣ���commit��rollback��savepoint

--��������ڻỰ�ĵ�һ��DML���

select * from dept

delete from dept where deptno=50;
delete from dept where deptno=70;

update dept set deptno=70 where deptno=60;

--��������
commit;
rollback;

create table aa(ano number(10));

delete from dept where deptno=16
select * from emp---9000
update emp set sal=9000 where empno=7499;

---
select * from emp;
update emp set sal=5000 where empno=7369;
savepoint sp1;
update emp set sal=3300 where empno=7369;
savepoint sp2;
update emp set sal=2200 where empno=7369;
--rollback to XXX ����ʹ���������
rollback to sp2;
rollback to sp1;
rollback to sp2;
commit;

---�����ݷ���ʦ 780 99% �����¿�һ��

--Ӱ������ѣ�  ����FCA ���      fcp��499��

--�� 150+ ���� 45��  45�� ��һ�����Σ�

--PMP���Ͽɶȸߣ� 2500+2900+ÿ������200 = ϵͳ������Ŀ������ʦ

--���רҵ��ְ�ƣ�����ְ�ƣ�


select * from emp











