--�鿴Ա����(����ע��)
select * from emp--�鿴Ա����(����ע��)

/*����
ע��*/
select * from emp

--�ֺŽ�β;(һ�仰������¿ɼӿɲ���)
/*select * from emp;*/

select * from dept;
select * from emp;


--��Сд������(�ؼ��ʡ�����������),���뵽������������ִ�Сд
SElect Ename FroM eMP 

select * from emp where ename='smith'

--

select*from emp

--''�ַ�Ҫ�õ���������,����ֱ����д
--�к���֮���ö��Ÿ���
--���� ����
select ename,job,66,'���','aa','Ҧ����' from emp

--һ���������������Ҫ2���ؼ��� select from
--select ��������� �У��ֶΣ����Զ��н���ɸѡ��from ��������Ǳ�
--*���������У����ã�

select * from emp

select ename,sal from emp

--where (�������ж�ʽ)=
--where ���н���ɸѡ
select  * from emp where deptno=10

--�������У��ո�  as  ��:�ո�,��������Ҫ�õ�����

select ename ����,sal as ���� from emp 

select e.ename,e.sal from emp e

select emp.ename,emp.sal from emp

glxmb_bumen1_xiaozu1 

--ȥ�� distinct ���У���ȫȥ�أ�  ����
select distinct deptno from emp
select distinct deptno,job from emp 

--���ӷ� || oracle mysql����ʹ��
--ʹ��ǰ���������ֵ�ұ�Ҳ��ֵ
select ename||sal from emp

--ĳĳĳ�Ĺ����Ƕ���Ԫ
select ename||'�Ĺ�����'||sal||'Ԫ' ������Ϣ from emp

--�����ţ������ַ�  ת��
--�����ţ��ɶԿ�ʼ�ɶԽ��� ���ͽ�ԭ��
/*"Τ־��
Τ־��'*/
select 'Τ־��','"Τ־��?','''Τ־��''','''''Τ־��','Τ־��''' from dual


--�����  dual  ������  ��ϵͳ����sysdate
select sysdate from dual

select '���' from dual


select userenv('language')from dual;

SIMPLIFIED CHINESE_CHINA.ZHS16GBK

--α��rownum:ֻ�ܴ�1��ʼ��(rownumֻ��С���κ����͵���1)�����ݲ�ѯ��������ɵ�һ����
--rowid:�����ݲ��뵽�����ʱ������ɵģ���ʵһֱ���ڣ��е��������֤�������������ݵ�Ψһ��
select emp.*, rownum from emp where rownum<5
select emp.*,rowid from emp



