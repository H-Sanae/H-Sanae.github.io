--ѧ������ϵͳ
select * from course
select * from student
select * from sc1

--1.��c002�γ̵ĳɼ�����5��
update sc set score=score+5 where cno='c002' 

--2.��c001�γ̳ɼ�С��80�ֵ�ͬѧ�ĳɼ�����10��
update sc set score=score+10 where cno='c001' and score<80

--3.����һ��ѧ��:ѧ��'s013'��������'������'�����䣺28���Ա���
insert into student values('s013','������',28,'��')

--4.����һ�ź�sc����ͬ�ı�����s001��s002ѧ����ѡ����Ϣ�����±���
create table sc1 as
select * from sc where sno='s001' or sno='s002'

--5.������c001�γ̳ɼ��������ͬѧ�ķ�����Ϊ60��
update sc set score=60 where cno='c001' and score<60

--6.ɾ����s002��ͬѧ�ġ�c001���γ̵���Ϣ��¼
delete from sc where sno='s002' and cno='c001'
--���²��롰s002��ͬѧ�ġ�c001���γ̵���Ϣ��¼
insert into sc values('s002','c001',80.90);

--7.��sc1ȥ����sc����ѧ����ѡ�޿γ���ͬ��ʱ�򣬰�sc1�ķ������µ�sc����ͬ��ʱ��Ͳ��뵽sc
 merge into sc
 using sc1
 on(sc.sno=sc1.sno and sc.cno=sc1.cno)
 when matched then
 update set sc.score=sc1.score
 when not matched then
 insert values(sc1.sno,sc1.cno,sc1.score)
 
 --��������ϰ
 select * from emp
 
--1.��ѯ������BLAKE���˵ı��,����,����
select empno,ename,sal from emp where ename='BLAKE'

--2.��ѯ�����7782��Ա���ı��,����,����,����
select empno,ename,sal,comm from emp where empno='7782'

--3.��ѯְλ������(SALESMAN)���˵�����,ְλ,��ְ����
select ename,job,hiredate from emp where job='SALESMAN'

--4.��ѯ������10���˵ı��,����,���ű��
select empno,ename,deptno from emp where deptno=10 

--5.��ѯ���ʴ���1500,����С��2500���˵ı��,����,����
select empno,ename,sal from emp where sal>1500

--6.��ѯ����С��2000���˵�����,����,����
select ename,sal,comm from emp where sal<2000

--7.������CLERK�Ļ��߹���С��2000Ա������,����,����
select ename,job,sal from emp where job='CLERK'

--8.����С��800���ߴ���1500��Ա������,����,����
select ename,job,sal from emp where sal<800 or sal>1500

--9.������CLERK,���ҹ���С��950���ߴ���1500��Ա������,����,����
select ename,job,sal from emp where job='CLERK' and (sal<950 or sal>1500)

--10.��10�Ų��Ź��ʴ���1000��20�Ų��Ź��ʴ���1500��Ա������
 select ename from emp where deptno=10 and sal>1000 or deptno=20 and sal>1500
 
--11.������1500��2000֮���Ա������
select ename from emp where sal  between 1500 and 2000

--12.���ű����10�ţ�20�ţ�30��������һ�����ŵ�Ա������
select ename from emp where deptno in(10,20,30)

--13.�������а���'M'��Ա������
select ename from emp where ename like '%M%'

--14.��Ա�������ڶ�λ��'M'��Ա������
 select ename from emp where ename like '_M%'

--15.�������а���A��L������
 select ename from emp where ename like '%A%' and ename like '%L%' 

--16.����������λ��Ա����Ϣ
select  * from emp where ename like '_____'

--17.�������е�3λ��%��Ա������
select ename from emp where ename like '__\%%' escape '\'

--18.���һλ��_,�����ڶ�λҲ��_��Ա������
select ename from emp where ename like '\_%' and ename like '%\__' escape '\'

--19.����_��ͷ,����λҲ���»���_,����λ��%��Ա������
select ename from emp where ename like '\__\___\%%' escape '\'

--20.�������в�����M��Ա������
select ename from emp where ename not like '%M%'
