--1.��emp���ename�д���һ����������������ǰ��ʱ��Ա�
select * from emp where ename like 'S%'
create index idx_emp_ename on emp(ename);
select * from emp where ename like 'S%'

--2.����job��sal�ĸ�����������ѯ���ʴ���2000��MANAGERԱ����Ϣ
create index idx_emp_jobsal on emp(job,sal)
select * from emp where sal>2000

--3.��ѯ������ѡ��c002�γ̼�������,�Լ��ж���δ�������
--��sc���cno��score�ֶ��ϴ�����������
create index idx_sc_sccno on sc(cno,score)
select sc.*,case when score>=60 then '����' else '������' end ������� 
from sc where cno='c002' 

--4.ʹ��Сд������������������ѯ����m��Ա����Ϣ
create index idx_emp_ename on emp(lower(ename))
select * from emp where ename like 'm%'

--5.�޸�ɾ��һ������
alter index idx_emp_ename rename to ind_emp_ename1��--�޸�
drop index ind_emp_ename1 --ɾ��
