--֪ʶ����
--����
--�ַ�����
--length  lengthb
select length('���') from dual--��������Ӣ��

select lengthb(66) from dual--������Ӣ��

--��������5λ���ȵ�Ա��
select ename from emp where ename like '_____'

select ename from emp where length(ename)=5

--concat = ||֧��oracle��MySQL
--ĳĳĳ�Ĺ����Ƕ���Ԫ

select ename||'�Ĺ�����'||sal||'Ԫ' from emp

select concat(concat(concat(ename,'�Ĺ�����'),sal),'Ԫ') from emp

select concat(concat(ename,'�Ĺ�����'),concat(sal,'Ԫ')) from emp

--ascii���ת���ľ��Ǽ��̽��������м�

--instr('aaaabbbcccdd' ԭʼ�ַ���,'b' Ŀ���ַ���,1 ��ʼλ��,1 Ŀ���ַ������ֵ�λ����)
select  instr('aaaabbbcccdd','c',9,3) from dual

--�滻like ���ҵڼ�λ��ʲô�ַ���ȷ��ԭʼ�ַ��������ж��ٸ��ַ�

select ename from emp where instr(ename,'M',1,1)!=0

select ename from emp where instr(ename,'L',1,2)!=0

select instr('aaaabbbcccdd','c',-4,1) from dual--�Ӻ���ǰ������ǰ�����


---substr('aaaabbbcccdd' Ŀ���ַ���,1 ��ʼλ��,1 ��ȡ����)
select substr('aaaabbbcccdd',8,10) from dual

select substr('aaaabbbcccdd',-6,3) from dual--�Ӻ���ǰ��������ʼλ��ͣ���������

--�����к���M--һ�����ģ��������instr
--�����е���λ��M��--һ�������ȷ������substr

select ename,substr(ename,5,1) from emp where substr(ename,5,1)='H'

select ename,instr(ename,'H',5,1) from emp where instr(ename,'H',5,1)=5

---������

create table t(tno varchar2(20))
insert into t values('1,2,3')
--��tno����ֶε��ۼ��ܺ�
select * from t


--�ַ��滻����replace(str,s ��ɾ�����ֶ�,d �滻��ֵ)
--�滻
--ɾ��
--����
select replace('������һ','��','����') from dual--�滻

select replace('���������','������') from dual--ɾ��

select replace('�����Ǿ�����','������','�����') from dual--����
--ƥ���滻
select
translate('�������','�����','�Ϻ���'),
translate('�������','���������','������ʿ��'),
translate('�������','���������','1������ʿ��'),
translate('�������','1���������','������ʿ��') from dual;

--���ֺ���
--round
select round(56.56555,2) from dual--������С����֮��


select round(56.56555) from dual

select round(56.56555,-2) from dual--������С����֮ǰ

--mod���ຯ��
select mod(5,2) from dual

--�ж���ż

select sal,mod(sal,2) from emp where mod(sal,2)!=0


select trunc(98.56),round(98.56),floor(98.56),ceil(98.56) from dual


select power(5,3) from dual

select sqrt(9) from dual

--ת������ �ַ�ת������  ����ת������ ����ת������
--�����ڶԱ�ʱ���������Ͳ�ͳһ
--������������ֿ���������ʽת�����������ֵĲ���ʹ��to_numberת�������۾���һ���������
select * from emp where empno='7499'--��ʽת��


select * from emp where empno=7499

select * from emp where empno=to_number('7499')--������ת����ǰ���ǿ����������֣�

select * from emp where empno=to_number('���ľž�')

--to_date
--1981220
select * from emp where hiredate=to_date(19810220,'yyyymmdd')

select * from emp where hiredate=to_date(1981,'yyyy')
--�������йصĲ���������ת�ַ������ַ�ת���ڶ���������ڸ�ʽ
--����to_char
select * from emp where to_char(hiredate,'yyyy')='1981'

select * from emp where to_char(hiredate,'mm')='06'

---�������йص�to_charת��һ����֤����������
select  to_char(sysdate,'day') from dual

--����20080907�����ڼ�
select to_char(to_date(20080907,'yyyymmdd'),'day') from dual


select to_char(sysdate,'d') from dual

select to_char(sysdate,'dd') from dual
select to_char(sysdate,'ddd') from dual


--next_day(sysdate,n),ȡ���Լ����������һ���ܣ����ܣ� �ĵڼ��죬���籾�ܻ�δ������һ�죬��ô��ľ��Ǳ��ܶ�Ӧ������

select next_day(next_day(sysdate,2),2) from dual

--add_months(����,��)
select add_months(sysdate,144) from dual

--nvl2(commĿ���ֶ�,comm Ŀ���ֶ���ֵȡ,0 Ŀ���ֶ�nullֵȡ)��ֵ�滻���� null����������
select sal,nvl2(comm,comm,0),sal+nvl2(comm,comm,0) from emp

--nvl2������������������Ҫһ��
select comm,nvl2(comm,'1','û��') from emp

--nvl
select comm,nvl(comm,0) from emp

--���뺯��case
--��case��д��Ҫ������У�ֻ������ֵ�ж�
--����case
select deptno,
case deptno
  when 10  then 'ʮ�Ų���'
    when 20 then '��ʮ�Ų���'
      when 30 then '��ʮ�Ų���'
        else null--else��д�ɲ�д
          end from emp
--
select deptno,
case--case ��ͷ
  when deptno=10 then 'ʮ�Ų���'
    when deptno=20 then '��ʮ�Ų���'
      when deptno=30 then '��ʮ�Ų���'
        else null end from emp --end��β
          
--Case����ֻ���ص�һ������������ֵ��ʣ�µ�Case���ֽ��ᱻ�Զ����ԡ� 
select deptno,
case
  when deptno=10 then 'ʮ�Ų���'
    when deptno=20 then '��ʮ�Ų���'
      when deptno=30 then '��ʮ�Ų���'
        when sal>2000 then '���ʺø�'
        else null end from emp
          
---then �� ��ֱֵ����Ҫ�ÿո����
--���������ֶ���������Ҫ��֤һ��
select deptno,
case
  when deptno=10 then '6'
    when deptno=20 then '��ʮ'
      when deptno=30 then '��ʮ'
        else null end from emp

---case when���п���ֱ�ӷ���group by ֮��

select deptno from emp group by deptno

select 
case
  when deptno=10 then 'ʮ�Ų���'
    when deptno=20 then '��ʮ�Ų���'
      when deptno=30 then '��ʮ�Ų���'
        else null end from emp  
          group by 
          case
  when deptno=10 then 'ʮ�Ų���'
    when deptno=20 then '��ʮ�Ų���'
      when deptno=30 then '��ʮ�Ų���'
        else null end
---

--3.ͳ�ƹ��ʼ�����Ӧ��������1600���� C��,1600-3000 B��,3000���� A����
select count(1),
case 
  when sal<1600 then 'C��'
    when sal between 1600 and 3000 then 'B��'
      when sal>3000 then 'A��'
       else null end from emp
        group by 
        case 
  when sal<1600 then 'C��'
    when sal between 1600 and 3000 then 'B��'
      when sal>3000 then 'A��'
       else null end
---
select 
 count(case when sal<1600 then 'C��' end) C��,
   count(case when sal between 1600 and 3000 then 'B��' end) B��,
     count(case when sal>3000 then 'A��' end) A��  from emp

select count(ename) from emp

---
select job from emp

select deptno,
max(case when job='SALESMAN' then sal end) SALESMAN,
  max(case when job='MANAGER' then sal end) MANAGER,
    max(case when job='CLERK' then sal end) CLERK from emp group by deptno

--
select * from
(select deptno,job,sal from emp)--������ת���õ��ϵ��ֶ�
pivot
(
max(sal) for job in ('SALESMAN','MANAGER','CLERK')
)
--
select * from
(select deptno,job,sal from emp)
pivot
(
max(sal) for job in ('SALESMAN' salesman,'MANAGER' manager,'CLERK' clerk)
)
unpivot
(
newsal for job in(salesman,manager,clerk)
)
----
select sal,
case 
when comm is null then 0 
  else comm end from emp
    

--�������������ں�������over( partition by ���ɼӿɲ��ӣ� order by(�����������ش�))

--�ۺϺ���:avg() sum() count() max() min()
--���к���: row_number() rank() dense_rank()
--��������:listagg()
--ƫ�ƺ�����lead  lag
select sum(sal) from emp
select sum(sal),deptno from emp group by deptno

select sum(sal)over() from emp--�����ܳ������岻��

select sum(sal)over(),deptno,job,ename from emp--�ۺϼӿ�����֤�������������У����ǽ����ûɶ����
--����ָ��������ֻ�ܴ�1��ʼ��
select emp.*,rownum from emp
--���к������俪����over��������order
--�Ӳ�ѯ
select * from(
select emp.*,row_number()over(order by sal desc) r from emp) t
where r=4

select * from(
select emp.*,max(sal)over(partition by deptno order by sal desc) r from emp) t
where sal=r
----
select emp.*,row_number()over(order by sal desc) r from emp--�����ǲ��е�������

select emp.*,rank()over(order by sal desc) r from emp--���ǲ��е�����

select emp.*,dense_rank()over(order by sal desc) r from emp--���ǲ����Ҳ�����

--partition by ����=group by 
--partition by û��ȥ�ص�Ч������Ϊpartition by�ǻ�������Ļ�����ȥ������
select * from (
select emp.*,rank()over(partition by deptno order by sal desc) r from emp) t
where r=1

--��ÿ��������߹�����Ա��Ϣ
select * from emp where sal in(
select max(sal) from emp group by deptno)--2850 3000 5000


---�ۼ� sum +����over(order by),��ֵһ��ʱ���ۼ�ֵ��Ĭ�ϼӵ���ֵͬ�����һ����ʧȥ�ۼ�Ч��

select sum(sal) from emp
select sum(sal),deptno from emp group by deptno
select sum(sal)over() from emp

select sum(sal)over(partition by deptno) from emp
--�ۼ�Ч����partition by ����Ҫ��ӣ�û��Ҫ�Ͳ���
select deptno,sal,sum(sal)over(order by sal) from emp

--partition by ���Ժ�group by ����,ǰ����group by�������У������������򣨿����õ��Ǻ����õ���
select deptno,row_number()over(partition by deptno order by deptno desc) r from emp
group by deptno

--listagg=�ۺϺ���

select max(sal) from emp
select max(sal),deptno from emp group by deptno
select max(sal)over() from emp
select max(sal)over(partition by deptno) from emp
select max(sal)over(partition by deptno order by sal) from emp

select listagg(ename,',')within group(order by ename) from emp

select listagg(ename,',')within group(order by ename),deptno from emp group by deptno

select listagg(ename,',')within group(order by ename)over() from emp
---listagg�����order by���﷨�ش������俪�������������orderby���ô�
select listagg(ename,',')within group(order by ename)over(partition by deptno order by deptno ) from emp

---wm_concat(ename) ���ɺ���
select wm_concat(ename) from emp  group by deptno;
--ƫ�Ƶ�Ŀ���ǰѲ�ͬ�е����ݷŵ�ͬһ��������
---���������� =������������������/ ������ ��100%
select sal,lead(sal,1,0)over(order by sal),lag(sal,1,0)over(order by sal) from emp

select ((sal-sy)/sy)*100 from(
select sal,
case 
  when lag(sal,1,0)over(order by sal)=0 then null 
    else  lag(sal,1,0)over(order by sal) end sy
 from emp) t
--to_char��ռλ�÷�,9����ռһ��λ��,0�����С����֮ǰ��0����

select to_char(((sal-sy)/sy)*100,'990.99')||'%' from(
select sal,lag(sal,1,null)over(order by sal) sy from emp) t

create table shuiguo(tdate varchar2(20),tname varchar2(20),saleamount number(10))
--�����������뷽ʽ
--����һ:ִ���������-�������-�������--������������ɫ-ѡ����Ҫ���Ƶ�����--����������ճ��
select * from shuiguo  for update

delete from shuiguo

--����������ͼ�ڰ�Ⱥ
--�Ӳ�ѯ
select   1    5  ��
from     2    1  ��
where    3    2  ������sal>2000ֵ��
group by 4    3  ��
having   5    4  ������ɸѡ�ۺϺ�����
order by 6    6  ��

--���е��� ֵ ��  ��
select avg(sal) from emp--2073.21428571428

--���ʴ���ƽ������
select * from emp where sal>(select avg(sal) from emp)--�м�ֵ���÷�

select ename,(select avg(sal) from emp) from emp

select * from (select avg(sal) from emp)

---���е���  ֵ��any  all in�� ��  ��
select deptno from dept--10 20 30 40

select * from emp where deptno in(select deptno from dept)
---��20�Ų��Ź��ʻ�Ҫ�ߵ�Ա����Ϣ
select * from emp where sal>all(
select sal from emp where deptno=20)

---��Ϊ�У�û������
select ename,(select deptno from dept where dept.deptno=emp.deptno) from emp


select * from(select deptno from dept) t

---���ж��� ���ж��� ��

--��ÿ�����ŵ���߹���
select * from(
select emp.*,rank()over(partition by deptno order by sal desc) r from emp) t
where r=1

--�������Ӳ�ѯ oracle 
select * from emp where (deptno,sal) in(
select deptno,max(sal) from emp group by deptno)

--4.��ѯԱ�����ʺ͹�������20�Ų���ͬʱһ����Ա����Ϣ

select * from emp where (job,sal) in(
select job,sal from emp where deptno=20) and deptno!=20


select * from emp where sal in (select sal from emp where deptno = 20) 
and job in ��select job from emp where deptno = 20��and deptno !=20 
