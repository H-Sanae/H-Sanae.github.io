--�Ӳ�ѯ 
select * from emp where sal=(select max(sal) from emp )
select * from (select emp.*,row_number()over(order by sal) r from emp) 
where r between 5 and 10
select emp.*,(select sum(sal) from emp) from emp 

--�ҳ���30������Ա���ʶ���
select * from emp where sal>all(select sal from emp where deptno=30)
select * from emp where sal>(select max(sal) from emp where deptno=30)
--�ҳ���30����������Ա���ʸ�
select * from emp where sal>any(select sal from emp where deptno=30)
select * from emp where sal>(select min(sal) from emp where deptno=30)

��in ��exists�� �Ӳ�ѯ����������ȿ�����exists
��not in ��not exists ������ѡnot exists

--��s001ѧ��ͬ���γ̵���Ա
select * from sc where cno in (select cno from sc where sno='s001')
 100 in   3 c01 c02 c03 300
 exists
 select * from sc sc1 where exists(select 1 from sc sc2 where sc2.sno='s001' and sc1.cno =sc2.cno) 
 100 exists c01 c02 c03  
 
 --��s001ѧ����ͬ�γ̵�ѧ��
 select * from sc where cno  not in (select cno from sc where sno='s001')
 select * from sc sc1 where  not exists(select 1 from sc sc2 where sc2.sno='s001' and sc1.cno =sc2.cno) 


--���ϲ�ѯ
union all  �ϼ� ��ȥ�� ������ Ч�ʸ�

union  �ϼ�   ȥ��������   Ч�ʵ�

intersect ����

minus  �  ���Ⱥ�֮�� 

����
select * from  student where ssex='��' 
minus
select * from  student where ssex='Ů' 

--join 

select * from emp,dept
--where emp.deptno=dept.deptno



select * from emp  inner join dept on emp.deptnodept.deptno


--������  inner join 
--����(on)ƥ������ ����ʾ�� 
select * from emp  inner join dept on emp.deptno=dept.deptno

--��������
--���Ϊ���� ȫ��ʾ  �ұ�Ϊ�ӱ� ��ʾ���� (on)ƥ�������ļ�¼
select * from emp  left outer join dept on emp.deptno=dept.deptno

--��������
--�ұ�Ϊ���� ȫ��ʾ ���Ϊ�ӱ� ��ʾ����(on)ƥ�������ļ�¼
select * from emp  right outer join dept on emp.deptno=dept.deptno

--ȫ������
--���ұ���ʾ��������������ʾ ����������� 
select * from emp  full  outer join dept on emp.deptno=dept.deptno

--��������
select * from  emp,dept
select * from emp cross join dept

--��Ȼ����
--���������ӽ����

select * from emp natural join dept


--������
select e1.ename,e1.empno,e1.mgr,e2.ename from emp e1  inner join emp e2 on e1.mgr=e2.empno


--����ʽ����
select * from salgrade s join emp on emp.sal>s.losal  and emp.sal< hisal
select * from salgrade s join emp on emp.sal between s.losal  and  hisal

������һ��ѭ����̭�� 
with tmp as(
select 'laker' name from dual
union all
select '76h' name from dual
union all
select 'wolf' name from dual
union all
select 'wa' name from dual
union all
select 'kn' name from dual
)
select * from tmp t1   join tmp t2 on t1.name > t2.name



15
student ѧ����
sc �ɼ��� 
teacher ��ʦ
course  �γ�
���ݰ�  1500



