--1.��ѯ������BLAKE���˵ı��,����,����
select empno,ename,sal from emp where ename='BLAKE'

--2.��ѯ�����7782��Ա���ı��,����,����,����
select empno,ename,sal,comm from emp where empno=7782
--3.��ѯְλ������(SALESMAN)���˵�����,ְλ,��ְ����
select ename,job,hiredate from emp where job='SALESMAN'


--4.��ѯ������10���˵ı��,����,���ű��
select empno,ename,deptno from emp where deptno=10

--5.��ѯ���ʴ���1500,����С��2500���˵ı��,����,����
select empno,ename,sal from emp where sal>1500 and sal<2500

--6.��ѯ����С��2000���˵�����,����,����
select ename,sal,comm from emp where sal<2000

--7.������CLERK�Ļ��߹���С��2000Ա������,����,����
select ename,job,sal from emp where job='CLERK' or sal<2000

--8.����С��800���ߴ���1500��Ա������,����,����
select ename,job,sal from emp where sal<800 or sal>1500

--9.������CLERK,���ҹ���С��950���ߴ���1500��Ա������,����,����
select ename,job,sal from emp where job='CLERK' and (sal<950 or sal>1500)

--10.��10�Ų��Ź��ʴ���1000��20�Ų��Ź��ʴ���1500��Ա������
select ename from emp where deptno=10 and sal>1000 or deptno=20 and sal>1500

--11.������1500��2000֮���Ա������
select ename from emp where sal between 1500 and 2000

--12.���ű����10�ţ�20�ţ�30��������һ�����ŵ�Ա������
select ename from emp where deptno in(10,20,30)

select ename from emp where deptno =any(10,20,30)

select ename from emp where deptno=10 or deptno=20 or deptno=30

---like ģ������:ͨ�����_:����һ���ַ���ռһ��λ�� %:0������ַ���
select * from emp where  ename like '%M%'

select * from emp where ename like 'M%'

select * from emp where ename like '%N'

select * from emp where ename like '_____R%'

select * from emp where ename like '%L__'

select * from emp where ename like '%M%R%' or ename like '%R%M%'

select * from emp where ename like '%M%' and ename like  '%R%'

--��������ַ���_��%ת����ͨ�ַ�
--�����к���_����
--Ϊ�˺ͺ��������ͳһ������ת��Ҳ��\
select * from emp where ename like '_\__\%%' escape '\'

select * from emp where ename like '%\%__' escape '\'


--13.�������а���'M'��Ա������
select ename from emp where ename like '%M%'
--14.��Ա�������ڶ�λ��'M'��
select ename from emp where ename like '_M%'
--15.�������а���A��L������
select ename from emp where ename like '%A%' and ename like '%L%'
--16.����������λ��Ա����Ϣ
select * from emp where ename like '_____'

--17.�������е�3λ��%��Ա������
select ename from emp where ename like '__\%%' escape '\'

--18.���һλ��_,�����ڶ�λҲ��_��Ա������
select ename from emp where ename like '\_%\__' escape '\'
--19.����_��ͷ,����λҲ���»���_,����λ��%��Ա������
select ename from emp where ename like '\__\___\%%' escape '\'
--20.�������в�����M��Ա������
select ename from emp where ename not like '%M%'

--�������У�order by (���� asc(Ĭ��)����desc)
--�ؼ���һ��6��,һ����ѯ�������Ҫ��2���ؼ��ʣ����6���ؼ��ʣ�ÿ���ؼ���ֻ�ܳ���һ��
--�ؼ���ִ��˳�� 
           ��д˳��  ִ��˳��
select   ��     1       3
from     ��     2       1
where    ����   3       2
order by ��     4       4



select * from emp where deptno=10  order by sal desc

select * from emp  order by sal desc

--order by ��Ψһһ������ʹ�ñ����Ĺؼ��� 
select sal ����,deptno  ���� from emp  order by ���� desc

--������ֵ��� null !=0
select * from emp order by comm desc

--desc������(��ΪĬ������)
--����������ң���������ִ��
--����н�������ʱ���Ȱ�ȫ������ߵ��н������������������Ļ����ϣ������ұ���
select * from emp order by deptno desc,sal desc

--����ָ�����õ�������
select deptno,ename,sal from emp order by 1,3 desc


---���� group by (һ��ֻ����ۺϺ���һ��ʹ��)

select distinct deptno from emp 

select deptno from emp group by deptno

--�ۺϺ��� max(sal:����) min() sum() avg() count()
--���оۺϳ�һ�еĺ���


select sal from emp
--count��ľ��ǽ���������ж�������Ч����
select max(sal),min(sal),sum(sal),avg(sal),count(1) from emp

--������е���Ч����
select count(comm) from emp

--һ�Զ�Ĺ�ϵ
--��������һ��һ�Ĺ�ϵ
select max(sal),deptno from emp group by deptno

select max(sal) from emp--5000

select deptno from emp--10 20 30
select job from emp
select ename,sal from emp
--ÿ�������м�����
select  deptno,count(1) from emp where job='MANAGER' group by deptno

--�ؼ���ִ��˳�� 
           ��д˳��  ִ��˳��
select   ��     1       5
from     ��     2       1
where    ����   3       2
group by ��     4       3
having ����:�ۺ�5       4
order by ��     6       6

--�з���Ĳ�ѯ��䣬��ô�ۺϺ������ڷ�������
--��������4
--having ���ܵ�ͬwhere��ר������ɸѡ�ۺϺ���
select  deptno,count(1) from emp  group by deptno having count(1)>4 

--�������������Կ�����where ��Ч��Ҫ����having
select  deptno,count(1) from emp  group by deptno having count(1)>4 and deptno=30

select  deptno,count(1) from emp where deptno=30  group by deptno having count(1)>4
order by deptno 
 
---�����select ����ֻ�ܸ���������к;ۺϺ���

--group by����������еľۺϺ�����selectֻ��չʾ
select deptno,job,avg(sal),count(1),sum(sal) from emp group by deptno,job

--having ֻ��ɸѡ�ۺϺ����ͷ�������
select deptno,count(1) from emp where job='SALESMAN' group by deptno

select deptno,count(1) from emp   group by deptno having job='SALESMAN'


