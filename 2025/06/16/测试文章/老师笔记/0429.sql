--1. ��ѯemp����Ա�������ֺ͹���
select ename,sal from emp

--2. ��ѯemp����Ա���ı��,����,����
select empno,ename,comm from emp

--3. ��ѯ���ű�źͲ�������
select deptno,dname from dept

--4. ��ѯԱ�����ֺ���ְ����(����������ʾ ����, ��ְ����)
select ename ����,hiredate ��ְ���� from emp

--5. ��ѯԱ����ţ����֣�������
select empno,ename,mgr from emp

--6. ��ѯ��˾������в��ŵĲ��ű�ţ�ȥ�أ�
select distinct deptno from emp
select distinct deptno from dept
--7. ��ѯԱ���������͹��ʣ������ָ�ʽ��ʾ��simth�Ĺ�����800��
select ename||'�Ĺ�����'||sal||'��' from emp where ename='SMITH'

--8. ʹ����������鿴ϵͳ����
select sysdate from dual

--9. �鿴Ա�����ǰ��������
select emp.*, rownum from emp where rownum<=5




--10. �鿴Ա�����rowid

select emp.*,rowid from emp

--�������ͣ���������
--�ַ�����   ��������  ��������
--�ַ����ͣ��ı����ַ�������char(2000)�̶�����  varchar2(4000)�ɱ䳤��
--����ռ�����ֽ�Ӣ��ռһ���ֽ�(����ͬ��)
--xm char(10)10   xm varchar2(10)7  ���ӳ�a��9  ���ӳ�a,8 

--nchar(2000)  nvarchar2(4000) ��������Ӣ��

--xm nchar(10)  xm nvarchar2(10) ���ӳ�a��5  ���ӳ�a,5

select length('���ӳ�a��') from dual---��������Ӣ��
select lengthb('���ӳ�a��') from dual--������Ӣ��

--�������ͣ� ���� number(38) ������ number(7,2)��λ����7λ����2λ��С���㣬С����֮ǰ��5λ

--number����ֻ�ܴ洿����
sfz varchar2(18) 
dh varchar2(11) 13678456378

--sal number(38,37)��������С����λ�����ܳ�����λ��
--sal number(5) 

--numer�����������㣬�ַ�����ԭ�����ǲ��ܽ��������
-- + - * /
select sal,comm,sal/100 from emp

--�������� date ���ڸ�ʽ'yyyymmddH24miss'
--�������Ϳ�ֱ�ӼӼ����ܳ˳�:���ڼӼ���������
select sysdate,hiredate from emp

select sysdate-(365*17)from dual

null
select sal,comm,sal+nvl2(comm,comm,0) from emp

---����---�ϰ�---���� 
--���ݿ⣨��ռ䣩--�û�--���ݱ�--������
--�ṹ����createɾdrop�Ĳ�select
--���ݣ���ɾ�Ĳ�select 

--������ռ�

create tablespace student--��ı�ռ���
datafile 'c:\test\student.dbf'--���ɵ��ļ���
size 100M autoextend on next 50M maxsize unlimited;

--��¼system����Ա��Ȩ��
grant dba to scott;

--������ʱ��ռ�(һ����select��ѯ�����������)
create temporary tablespace student1
tempfile 'c:\test\student1.dbf'
size 50M autoextend on next 10M maxsize unlimited;
--�û�
create user panyinchun
identified by oracle default tablespace student temporary tablespace student1;

--�����û�Ȩ��
grant dba to panyinchun;
--�鿴����û��ı�
select * from scott.emp

--ɾ����ռ�
drop tablespace student1 including contents;

--ɾ���û�(ǰ��Ҫ�Ͽ�����)
drop user panyinchun


--���� ��ռ�
alter tablespace student
add datafile 'C:\test\student.dbf' size 100m autoextend on next 10m maxsize unlimited;

alter user panyinchun identified by oracle1;


--���ݿ⣨��ռ䣩--�û�--���ݱ�--������
--�ṹ����createɾdrop�Ĳ�select
--���ݣ���insertɾ�Ĳ�select 

select * from scott.emp

select * from scott.dept

--�������ͣ�number  varchar2  date
--����Լ����not null �ǿ�  unique Ψһ  primary key ����Լ�����ǿ�&Ψһ����ϣ�
--default Ĭ��Լ��  check ���Լ�� references ���Լ��


create table bm(bmno number(4),bmmc varchar2(20),bmdz varchar2(20));
select * from bm
---�ظ�����=��������
null=��
insert into bm values(10,'���۲���','������');
insert into bm values(20,'������','������');
insert into bm values(10,'���۲���','������');
insert into bm values(30,'������','������');
insert into bm values(40,null,'������');
insert into bm values(null,null,null);

select * from bm
---ɾ����
drop table bm


create table bm(
bmno number(4) primary key,
bmmc varchar2(20) unique,
bmdz varchar2(20) not null
);

insert into bm values(10,'���۲���','������');
insert into bm values(20,'������','������');
insert into bm values(30,'���۲���һ','������');
insert into bm values(40,'������һ','������');
insert into bm values(50,null,'������');
insert into bm values(60,null,'������');

select * from bm


select * from scott.emp

create table yg(
ygno number(6) primary key,--�м�Լ��
ygxm varchar2(20) not null,
job varchar2(20) not null,
rzrq date default sysdate,
gz number(7,2) check(gz>=1500),--Ψһһ���������жϵ�Լ��
bmno number(4) references bm(bmno)
constraint zjys primary key(ygno),--��Լ��
constraint wjys foreign key(bmno) references bm(bmno)
)

select * from yg
drop table yg
insert into yg values(1111,'�κ���','boss',sysdate-30,1500,60);
insert into yg values(2222,'������','CEO',sysdate,1500,60);
insert into yg values(3333,'���ҿ�','����',sysdate-4,8000,10);
insert into yg values(5555,'�׽���','����',sysdate,9000,20);
insert into yg values(6666,'Ҧ����','����',sysdate,19000,40);
insert into yg values(7777,'�ž�','����',default,19000,40);


create table yg(
ygno number(6) primary key,--�м�Լ��
ygxm varchar2(20) not null,
job varchar2(20) not null,
rzrq date default sysdate,
gz number(7,2) check(gz>=1500),--Ψһһ���������жϵ�Լ��
bmno number(4) references bm(bmno)
constraint zjys primary key(ygno),--��Լ��
constraint wjys foreign key(bmno) references bm(bmno)
)

drop table yg1
create table yg1(
ygno number(6),
ygxm varchar2(20) not null,
job varchar2(20) not null,
rzrq date,
gz number(7,2),
bmno number(4),
constraint yg1_zjys primary key(ygno),
constraint yg1_wjys foreign key(bmno) references bm(bmno)
)
---�����ñ�Լ��
--��������
create table cj(
sno number(5),
course varchar2(20),
score number(6,3),
constraint fhzj primary key(sno,course)
)

drop table cj
insert into cj values(1,'����',99);
insert into cj values(1,'��ѧ',99);
select * from cj
--�����������  ɾ���ȴӺ���

age number(7,2) check(age between 6 and 40)

--��������  ����Լ�����м� ������������Ҫ�ñ��� ���ݵĲ��룺insert into ���� values���ύ��
--����ṹ��create table 
--ɾ��drop table ������ɾ����ṹ�����ݣ�

