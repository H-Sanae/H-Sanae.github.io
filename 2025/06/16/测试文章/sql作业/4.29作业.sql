--������ռ�
create tablespace huangwenzhe429 
datafile 'C:\workspace\sql\huangwenzhe429.dbf' 
size 100M autoextend on next 50M maxsize unlimited;

--�������ԱȨ��
grant dba to scott;

--������ʱ��ռ�
create temporary tablespace huangwenzheTemp429 
tempfile 'C:\workspace\sql\huangwenzheTemp429.dbf' 
size 100M autoextend on next 50M maxsize unlimited;

--�����û�
create user huangwenzhe
identified by oracle 
default tablespace huangwenzhe429 
temporary tablespace huangwenzheTemp429;

--�����û�����ԱȨ��
grant dba to huangwenzhe;

--�鿴����û��ı�
select * from scott.emp;
select * from scott.dept;

--ɾ����ռ�
drop tablespace huangwenzhe429 including contents;


--ѧ������ϵͳ

--����teacher��
create table teacher(
       TNO varchar2(10) primary key,
       TNAME varchar2(20) not null
);

--����teacher����
insert into teacher values('t001','����');
insert into teacher values('t002','����');
insert into teacher values('t003','������');

--�鿴/ɾ��teacher��
select * from teacher
drop table teacher

--����student��
create table student(
       SNO varchar2(20) primary key,
       SNAME varchar2(30),
       SAGE number(2) check(SAGE between 6 and 40),
       SSEX varchar2(5) default '��'
);

--����student����
insert into student values('s001','����',23,'��');
insert into student values('s002','����',23,'��');
insert into student values('s003','����',25,'��');
insert into student values('s004','����',20,'Ů');
insert into student values('s005','����',20,'Ů');
insert into student values('s006','�',21,'��');
insert into student values('s007','����',21,'��');
insert into student values('s008','����',21,'Ů');
insert into student values('s009','������',23,'Ů');
insert into student values('s010','����',22,'Ů');
insert into student values('s12','л����',20,'Ů');
insert into student values('s13','л�о�',20,'��');
insert into student values('s14','лһ��',20,'��');

--�鿴/ɾ��student��
select * from student
drop table student

--����course��
create table course(
       CNO varchar2(10) primary key,
       CNAME varchar2(30),
       TNO varchar2(20) references teacher(tno)
);

--����course����
insert into course values('c001','J2SE','t002');
insert into course values('c002','Java Web','t002');
insert into course values('c003','SSH','t001');
insert into course values('c004','Oracle','t001');
insert into course values('c005','SQL SERVER 2005','t003');
insert into course values('c006','C#','t003');
insert into course values('c007','JavaScript','t002');
insert into course values('c008','DIV+CSS','t001');
insert into course values('c009','PHP','t003');
insert into course values('c010','EJB3.0','t002');

--�鿴/ɾ��course��
select * from course
drop table course

--����sc��
create table sc(
       SNO varchar2(10) references student(sno),
       CNO varchar2(10) references course(cno),
       SCORE number(5,2) check(SCORE between 0 and 100),
       constraint fhzj primary key(sno,cno)
)

--����sc����
insert into sc values('s001','c001',78.90);
insert into sc values('s002','c001',80.90);
insert into sc values('s003','c001',81.90);
insert into sc values('s004','c001',60.90);
insert into sc values('s001','c002',82.90);
insert into sc values('s002','c002',72.90);
insert into sc values('s003','c002',81.90);
insert into sc values('s001','c003',59.00);
insert into sc values('s12','c005',89.00);
insert into sc values('s13','c008',87.00);
insert into sc values('s13','c007',65.00);
insert into sc values('s13','c010',85.00);
insert into sc values('s14','c007',100.00);
insert into sc values('s14','c005',60.00);
insert into sc values('s14','c006',92.00);
insert into sc values('s14','c008',95.00);
insert into sc values('s14','c010',91.00);
insert into sc values('s14','c004',57.00);

--�鿴/ɾ��sc��
select * from sc
drop table sc







