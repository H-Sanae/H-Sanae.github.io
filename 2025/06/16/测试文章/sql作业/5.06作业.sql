--1.��ѯԱ�����������ʣ����չ��ʵ���������
select enmae,sal from emp order by sal

--2.��ѯԱ����Ϣ���Ȱ��ղ��ű�Ž������У��ٰ��չ��ʵ���������
select * from emp order by deptno desc, sal

--3.��ѯԱ����Ϣ���Ȱ��չ��ʽ������У��ٰ��ղ��Ž�������
select * from emp order by sal desc, deptno desc

--4.��ÿ�������ж���Ա��
select deptno, count(1)  from emp group by deptno

--5.��ÿ�����������߹���
select deptno, max(sal) from emp group by deptno

--6.�μ�ÿ�ֹ���������
select job, count(1) from emp group by job

--7.��Ա���������߹���
select max(sal) from emp

--8.��˾�ж��ٸ�����
select count(1) from dept
select count(1) from (select distinct deptno from emp) --�Ӳ�ѯ

--9.����ƽ�����ʴ���1600�Ĳ��ű��
select deptno from emp group by deptno having avg(sal)>1600

--10.����ƽ�����ʴ���1600,���Ҳ���20�Ų��ŵĲ��ű��
select deptno from emp where deptno!=20 group by deptno having avg(sal)>1600

--11.�г����н�����1500�ĸ��ֹ���
select job from emp group by job having min(sal)>1500

--12.�г���ÿ�����Ź�����Ա��������ƽ������
select deptno,count(1), avg(sal) from emp group by deptno

--13.�г��������ŵ�MANAGER�����������н��
select deptno,min(sal) from emp where job='MANAGER' group by deptno

--14.��ѯÿ������ÿ����λ�Ĺ����ܺ͡�
select deptno, job, sum(sal) from emp group by deptno, job order by deptno

--15.��ѯ������������2�Ĳ��ű�ţ���͹��ʡ���߹���,����������
select deptno,min(sal),max(sal),count(1) from emp group by deptno having count(1)>2

--16.��ѯ����ƽ�����ʴ���2000������������2�� ���ű�š���������������ƽ������ �������ղ���������������
select deptno,count(1),avg(sal) from emp group by deptno having avg(sal)>2000 and count(1)>2 order by count(1)

--17.��ѯԱ����λ�в����ԡ�SA����ͷ����ƽ��������2500Ԫ���ϵĸ�λ��ƽ�����ʣ�����ƽ�����ʽ�������
select job,avg(sal) from emp where job not like 'SA%' group by job having avg(sal)>2500 order by avg(sal) desc

--18.��ѯ��λ��ΪSALESMAN�����ʺʹ��ڵ���2500�ĸ�λ�� ÿ�ָ�λ�Ĺ��ʺ�
select job,sum(sal) from emp where job!='SALESMAN' group by job having sum(sal)>=2500

--19.дһ����ѯ����ʾÿ��������߹��ʺ���͹��ʵĲ��
select deptno,max(sal)-min(sal) from emp group by deptno
