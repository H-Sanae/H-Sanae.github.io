/****************ѧ��ϵͳ*********************/
create table teacher(
  tno varchar2(10) primary key,
  tname varchar2(20) not null
);

create table student(
  sno varchar2(20) primary key,
  sname varchar2(30),
  sage number(2),
  ssex varchar2(5) default '��',
  constraint ck_sage check(sage>=6 and sage<=40)
);

create table course(
  cno varchar2(10) primary key,
  cname varchar2(30),
  tno varchar2(20),
  constraint fk_tno foreign key (tno) references teacher(tno)
);

create table sc(
  sno varchar2(10),
  cno varchar2(10),
  score number(5,2),
  constraint pk_sc primary key (sno,cno),
  constraint fk_sc_sno foreign key (sno) references student(sno),
  constraint fk_sc_cno foreign key (cno) references course(cno),
  constraint ck_score check(score>=0 and score<=100)
);

drop table sc
--���������ӣ�ɾ��ӵ���
select * from student
/*******��ʼ��ѧ���������******/
insert into student values ('s001','����',23,'��');
insert into student values ('s002','����',23,'��');
insert into student values ('s003','����',25,'��');
insert into student values ('s004','����',20,'Ů');
insert into student values ('s005','����',20,'Ů');
insert into student values ('s006','�',21,'��');
insert into student values ('s007','����',21,'��');
insert into student values ('s008','����',21,'Ů');
insert into student values ('s009','������',23,'Ů');
insert into student values ('s010','����',22,'Ů');
insert into student values('s12','л����',20,'Ů');
insert into student values('s13','л�о�',20,'��');
insert into student values('s14','лһ��',20,'��');
commit;
--rollback;
/******************��ʼ����ʦ��***********************/

insert into teacher values ('t001', '����');
insert into teacher values ('t002', '����');
insert into teacher values ('t003', '������');
commit;
/***************��ʼ���γ̱�****************************/
insert into course values ('c001','J2SE','t002');
insert into course values ('c002','Java Web','t002');
insert into course values ('c003','SSH','t001');
insert into course values ('c004','Oracle','t001');
insert into course values ('c005','SQL SERVER 2005','t003');
insert into course values ('c006','C#','t003');
insert into course values ('c007','JavaScript','t002');
insert into course values ('c008','DIV+CSS','t001');
insert into course values ('c009','PHP','t003');
insert into course values ('c010','EJB3.0','t002');
commit;
/***************��ʼ���ɼ���***********************/
insert into sc values ('s001','c001',78.9);
insert into sc values ('s002','c001',80.9);
insert into sc values ('s003','c001',81.9);
insert into sc values ('s004','c001',60.9);
insert into sc values ('s001','c002',82.9);
insert into sc values ('s002','c002',72.9);
insert into sc values ('s003','c002',81.9);
insert into sc values ('s001','c003','59');
insert into sc values('s12','c005',89);
insert into sc values('s13','c008',87);
insert into sc values('s13','c007',65);
insert into sc values('s13','c010',85);
insert into sc values('s14','c007',100);
insert into sc values('s14','c005',60);
insert into sc values('s14','c006',92);
insert into sc values('s14','c008',95);
insert into sc values('s14','c010',91);
insert into sc values('s14','c004',57);
insert into sc values('s14','c001',58);
commit;
--------------
drop table teacher
drop table student
drop table course
drop table sc
----


--�ṹ����createɾdrop��alter��select 

--���ݣ���insertɾdelete��update��select 

--alter���ǻ��ڱ�ȥ�޸���

--������
create table bm1(bno number(10),bname varchar2(20),bloc varchar2(20));


select * from bm1

alter table  bm1 add city varchar2(20) not null;


--�޸���
alter table bm1 modify city varchar2(50) unique;


--unique  all  not null 

--ɾ����
alter table bm1 drop column city;


--��������  chengshi
alter table bm1 rename column city to chengshi;

select * from bumen

--��������
alter table bm1 rename to bumen

---�ڶ��ֽ���ʽ:����selcet��ѯ���Ľ�����������±�����ݺͽṹ
--�ṹ������һ��Ҫ,�ᶪʧԼ��,���������֮ǰ�ȼ�Լ��
create table bm2
as
select deptno,loc from scott.dept where deptno=20

drop table bm2

select * from bm2

create table bm2
as
select * from scott.dept

insert into bm2 values(50,'aa','bb') 
--���Լ��
alter table bm2 add constraint bm2_zjys primary key(deptno);
--�ǿ�Լ��
alter table bm2 modify loc varchar2(20) not null;

--ɾ��Լ��
alter table bm2 drop constraint BM2_ZJYS


--���ݲ���:insert
--��ʽһ��ʹ��ǰ��Ĳ���������п�Ϊ��
create table bm3
as
select * from scott.dept


insert into bm3(deptno,loc)values(50,'������');

insert into bm3(deptno,dname,loc) values(60,'a','a')

select * from bm3

--��ʽ��:��ָ���в��룬Ĭ�������ж���Ҫֵ,���������������ݵ�������nullֵ���
insert into bm3 values(70,'t',null);

--��ʽ��:ֻ����select��ѯ�����������,ע���ѯ�Ľ�����ṹҪ��֤�ͱ�ṹһ��
insert into bm3(deptno,dname) select deptno,dname from scott.dept

select * from bm3

insert into bm3 select 20,'z','z' from dual

insert into bm3 select deptno,ename,job from scott.emp

---update �޸�

update bm3 set deptno=80 where deptno=60

update bm3 set dname='���۲���',loc='������' where deptno=80

--��ʽ��
create table yg2
as
select * from scott.emp
--��WARD�Ĺ��ʸĳ�800��
update yg2 set sal=(select sal from yg2 where ename='SMITH') where ename='WARD'

---delete ɾ����������
select * from yg2

delete from yg2 where empno=7369

--delete insertֻ������Ϊ��λ���в���
alter table yg2 drop column deptno


delete from yg2 where sal>(select sal from yg2 where empno=7499)

select * from yg2
--ɾ�������� DDL�ṹ�ϵĲ��ܻع� DML�����ϵ��ܻع�
drop table yg2--ɾ���ṹ�����ݣ����ܻع�
truncate table yg2--ɾ������,���ܻع�
delete from yg2 --ɾ�����ݣ��ܻع�

--�ٶ�
drop>truncate>delete


--2.��c001�γ̳ɼ�С��80�ֵ�ͬѧ�ĳɼ�����10��

update sc set score=score+10 where cno='c001' and score<80


create table sc2
as
select * from sc2


drop table sc2

delete from sc2 where sno!='s001' and sno!='s002'

--1.��c002�γ̵ĳɼ�����5��
select * from teacher--��ʦ�ĸ�����Ϣ
select * from student--ѧ���ĸ�����Ϣ
select * from course--ѧ��ϵͳ�����м��ſγ�
select * from sc--ÿ��ѧ��ÿ�ſγ̵ĳɼ�
select * from sc where  cno='c002'
update  sc set score=score+5 where cno='c002'

--2.��c001�γ̳ɼ�С��80�ֵ�ͬѧ�ĳɼ�����10��
update sc set score=score+10 where cno='c001' and score<80


--3.����һ��ѧ��:ѧ��'s013'��������'������'�����䣺28���Ա���
insert into student values('s013','������',28,'��')

select * from student
--4.����һ�ź�sc����ͬ�ı�����s001��s002ѧ����ѡ����Ϣ�����±���
select * from sc1

create table sc1
as
select * from sc

delete from sc1 where sno !='s001' and sno!='s002'

insert into sc1 select * from sc where sno='s002'

--5.������c001�γ̳ɼ��������ͬѧ�ķ�����Ϊ60��
update sc set score=60 where cno='c001' and score<60


--6.ɾ����s002��ͬѧ�ġ�c001���γ̵���Ϣ��¼
delete from sc where sno='s002' and cno='c001'

select * from sc where sno='s002' and cno='c001'
/*7.��sc1ȥ����sc,��ѧ����ѡ�޿γ���ͬ��ʱ�򣬰�sc1�ķ������µ�sc����ͬ��ʱ��Ͳ�
�뵽sc*/

---������£��������
--merge :���ݻ�ԭ�������ݻ�ԭһ�ű�

select * from sc1

create table sc1
as
select * from sc

update sc set score=59 where sno='s001';

delete from sc where sno='s13'

--mergeҲ�������ϵ�����DML
merge into sc--Ŀ��Ҫ���µı�
using sc1--���ݱ�Դ��
on(sc.sno=sc1.sno and sc.cno=sc1.cno)
when matched then update set sc.score=sc1.score--��ֵ��ʱ��ȥ������
  when not matched then insert values(sc1.sno,sc1.cno,sc1.score)--ûֵ��ʱ��ֱ�Ӳ���
    
---������
--����������(һ�������������͵����㣬�����ڼӼ�����)��+ - * /
--���Ӳ�����: ||(�Ѷ���кϲ���һ����)
--�߼�������: and or  not(����)
--�Ƚϲ����������Ƿ���where�����������Ƚϣ���
--> >= < <= = != <> ��any�� all�� between..and��  like�� in�� is null
    
select 33/55,22+1,44-3,66/2 from dual

select sal,sal+100,hiredate,hiredate+2 from emp

select ename||sal||deptno||'���' from emp

select * from emp where sal>3000--���ֵĴ��ڲ���������
select * from emp where sal>=3000

select * from emp where ename>'C'--�ַ��Ĵ��ڰ��������ȵ������ݵ�����ĸA..Z��

select * from emp where sal<2000

select * from emp where sal<=3000

select * from emp where sal=3000

select * from emp where ename='SCOTT'

select * from emp where sal!=3000

select * from emp where ename !='SCOTT'
--һ����������Ӳ�ѯ�Զ��ֵ���бȽ�
>all:��ʾ�������ֵ
<all����ʾС����Сֵ
>any����ʾ������Сֵ
<any����ʾС�����ֵ
=any: ��in����
--> < >= <= !=ֻ�ܸ�һ��ֵ���Ƚ�
select * from emp where sal >all(800,1250,3000)
                                  800,2975,3000,1100,3000
select * from emp where sal>all(select sal from emp where deptno=20)

select * from emp where sal <all(1250,950,3000)

select * from emp where sal >any(1250,950,3000)
select * from emp where sal <any(1250,950,3000)

select * from emp where sal =any(1250,950,2000)

select * from emp where sal in(1250,950,1200,2000)

create table sc1
as
select * from sc where sno in('s001','s002')

--
select * from emp where sal between 950 and 3000--�����߽�ֵ���߽�ֵ�ô�С����

select * from emp where sal>=950 and sal<=3000

--is null
select * from emp where comm is null

select * from emp where comm  is  not null

--and  or not һ�����ڶ�������ж�ʽ������

select * from emp where sal>2000 and deptno=20--������������ߵ�ͬʱҪ�����ұߣ�

select * from emp where sal>2000 and deptno=20 and job='ANALYST' 

select * from emp where sal>2000 or deptno=20--������������߻����ұ�����һ�����ɣ�

--��ִ��ǰ����������� ��  ��ִ�к��������������һ�� ��
--not>and>or(��С���Ÿı����ȼ�)
select * from emp where (sal>2000 or deptno=20) and job='MANAGER'

--not ȡ�����Լ�������Ǹ������ж�ʽ
select * from emp where not sal>2000 or deptno=20 and job='MANAGER'

