

--����
--ת������
to_date
to_char
to_number

���� 

number(5,-2)

select hiredate,to_char(hiredate,'day'),to_char(hiredate,'d'),to_date('1999-12-12','yyyy-mm-dd'),to_char(sal,'$99999D99') from emp
���� ��   cc
��ݸ�ʽ�� yyyy yy
���ȣ� q
�·�      mm  mon month
��   w  ww  day
��   d  dd ddd  
ʱ   h  hh24 hh  
��   mi
��   ss
 



�ַ� 


--���ֺ����б� 
abs()--����ֵ
sign() --ȡ���� 

ceil()����ȡ��
floor() ����ȡ�� 

round() ��������
trunc() ��ȡ


mod() ���� 
power() ������  
select  chr(97) from dual 
����ַ�����ʱ���ֻ�����ĸ

--�ַ������� 
ascii()����ת���ɶ�Ӧ����ĸ
chr(65) ����ĸת���ɶ�Ӧ������ 

concat() ƴ�� 2��
lower     ��дתСд
upper     Сдת��д
initcap    ����ĸ��д

--�滻����
replace()    �滻����
translate()  �滻 ��ĸ

--�ַ�����
substr(������󣬴��Ŀ�ʼ������) ��� 
instr(���Ҷ��󣬲���ʲô���ӵڼ����ַ���ʼ�����ҵڼ��γ���)   ����  
length    ���Ȳ���  
--�ַ�����ɾ�� 
ltrim
lpad
rtrim
rpad

trim(both|leading|trailing '�޳��ַ�' from ����)

--���ں��� 
add_months 
select hiredate,add_months(hiredate,6) from emp
months_between 
select hiredate,months_between(sysdate,hiredate) from emp


last_day
select last_day(sysdate) from dual
next_day--�ﵱǰ��������ڼ�
select next_day(sysdate,4) from dual

round
select round(sysdate,'dd') from dual

trunc
select to_char(trunc(sysdate,'yyyy'),'yyyymmdd hh24:mi:ss') from dual

 select systimestamp -hiredate,sysdate-hiredate,sysdate+ interval '365 2:25:50'day(3) to second from emp
interval 

select add_months(last_day(sysdate),1) from dual



interval year to month
interval day to second 

���µ�һ��  trunc(sysdate,'mm')
�����һ��  trunc(sysdate,'yyyy')
���ܵ�һ�� select  next_day(sysdate,1)-7 from dual

�������һ�� last_day
�������һ�� select to_date(to_char(sysdate,'yyyy')||'1231','yyyymmdd') from dual
�������һ��  next_day(sysdate,7)
SYSTIMESTAMP - INTERVAL '1' HOUR

date timestamp


select comm ,nvl2(comm,comm+100,500) from emp

1��ʹ��concat ������� "����***,�ҵĹ�����***" 
2����emp  ename�ֶ�����ĸ���д�д
3��ʹ�ú��� ��������Ա�����Ĵ�д ����ĸ��д Сд �Լ������ַ����� initcap������upper������lower������length����

1����ѯemp�������У��������������ñ�������ѯʱʹ�ñ�������в�����
2����������Ա������н����н���Լ���н�� ��sal����н����comm������nvl()��ȡ���ı���
3����EMP���л�ȡjob������ְҵ����distinct�����������󣺽��������ƶ��滻������case when��
4��ʹ�� Ա�������Լ������͹������ ������**���ҵĹ�����** ���ҵĹ����ǣ�***����ename��job��sal || ��
5����ȡ��SMITH����Ա����Ϣ ���乤�����50% �����佱���100.��ename��comm��sal ��nvl����   ��
6�������й��ʴ���1000���н����Ա��������ename������deptno������sal������comm�����������󣺽���������ĸ��д���������ǵ���н�꣨sal+comm��nvl��
7����ȡ����ְλ�����ۣ�SALESMAN��,����Ա��CLERK ��������manager����Ա������������ְʱ�䡢���ڲ����Լ����ʡ���ʹ��in ��or���ַ��������жϣ������������޳���������A��Ա���Լ����ֳ��ȴ���5��Ա����ʹ�����ַ���ʵ�֣���
8����ȡ������1000��3000����Ա������������Ա����ename�������򡾽�������ʹ��ename��ĸ�������Լ����ʸߵͽ�������between
9����ȡ����1982��Ա������Ϣ���޳����д�A�ַ���Ա������to_date��to_char��not ��
10����ѯ�������ž���('MANAGER')�Ĺ��ʣ������򣨽������󣺸��ݲ��Ž����ǹ��ʡ�10�Ų�����н100��20�Ų�������=200 30�Ų�����н300��



1.������ΪSMITH��Ա���Ĺ������Ƴ���
select length(job) from emp where ename='SMITH'
2.�����ֳ���Ϊ6��Ա�����������
select ename,empno from emp where length(ename)=6
3.��Ա���Ĺ��ʣ���ʽ�磺�����ǣ�SMITH,�����ǣ�800
select '�����ǣ�'||ename||'�������ǣ�'||sal from emp 
where ename='SMITH'

4.�ҳ�emp����Ա�����ְ���T��ĸ��Ա��
SELECT ENAME FROM emp where instr(ename,'T')>0
 5.�ҳ�emp�������ֵ�4λ֮��T��ĸ��Ա��
 SELECT ENAME FROM emp where instr(ename,'T',4)>0
6.�ҳ�emp�������ֵ�����3λ֮ǰ��M��ĸ��Ա��
select ename from emp  where instr(ename,'M',-3)>0
7.�����λ��H��Ա������
select ename from emp where substr(ename,5,1)='H'
8.�������д�������L������
select ename from emp where instr(ename,'L',1,3)>0 
select ename from emp where length(ename)-length(replace(ename,'L',''))>=3
like %L%L%L%
9.��Ա����������ĸ��д��������ĸСд 
initcap 
10.��Ա����������ĸСд��������ĸ��д 
select ename,lower(substr(ename,1,1))||substr(ename,2) from emp
11.��ѯ������ż����Ա��
select ename ,sal from emp where mod(sal,2)=0 
 12.��1981��2��20����ְ��Ա��
 select * from emp where hiredate = to_date(19810220,'yyyymmdd')
13.��1981����ְ��Ա��
 select * from emp where to_char(hiredate,'yyyy') = 1981

14.��2�·���ְ��Ա��
 select * from emp where to_char(hiredate,'mm') = 2

15.ȡ��ǰ�µ�����5����ְ��Ա��
select * from emp where hiredate=last_day(hiredate)-5


16.ȡÿ���µ�����5����ְ��Ա��


17.�����¸�����������
select next_day(sysdate,'4')+7 from dual


18.��3���º�Ľ���
add_months(sysdate,3)

19.��ÿ��Ա����������
select sal+nvl(comm,0) from emp 
20.���commΪ�վ���ʾ��No Commission���������Ϊ�վ���ʾcomm��ֵ
select nvl(to_char(comm),'No Commission') from emp

21.��Ա����һ��������루���ʺ�Ӷ��
(sal+nvl(comm,0))*12



9.������ename����L����Ա��������LΪ�罫Lǰ����ĸ��д��֮�����ĸСд��
select ename,substr(ename,1,instr(ename,'L')),lower(substr(ename,instr(ename,'L')+1))
from emp
where ename like '%L%'

10.������ename�ÿո���г��Ȳ��룬�������ߵĿո���������ͬ��ʹ��ͳһ����Ϊ15�����Ը������ݽ���ȥ�ո������
select rpad(lpad(ename,8+floor(length(ename)/2),'*'),15,'*') a from emp
lpad  rpad

substr��ename��-3��
order by length(ename)

select * from emp
where instr(ename,'T',-1)=length(ename)
and  


ceil+mod

select * from emp where hiredate =(select max(hiredate)from emp ) or hiredate =(select min(hiredate) from emp )  

select to_char(hiredate,'day') ,hiredate + interval '10' year from  emp



months_between
(sysdate-hiredate) /7

to_char(last_day(hiredate),'day')
next_day(last_day(hiredate),2)


to_date('2015-3��-18 13:13:13','yyyy-mon-dd hh24:mi:ss')

select ename,deptno,
case when deptno=10 then '�ܾ���'
  when deptno =20 then '�з���'
    when deptno=30 then  '���۲�'
      end --��case
      
      
case  when  �ж�����1  then  ������1 
  when �ж�����2  then ������2 
    else  ������3 
      end
      
      
case deptno when  10 then  '�ܾ���' 
   when  20  then '�з���'
     when 30 then   '���۲�'
      end
      -- ��case
case �Ƚ��ֶ� when     then  ������1 
  when �Ƚ�ֵ then ������2 
    else  ������3 
      end
      select ename,sal, 
 case when sal<1000   then case when ename='SMITH' THEN  'q'else 'M'end
   when  sal<2000 then 'B'
     when sal<3000 then 'C'
       when sal< 4000 then 'D'
         else 'E'
         end
         from emp
         order by 1,3
         
         
         
select * 
from emp
where  sal>1000 
and deptno=20
and ename ='SMITH'
AND JOB ='MANAGER'
group by
having
order by

         
 decode(deptno,10 ,'�ܾ���',20,'�з���',30,'���۲�','��ѧ��')

decode(sign(sal-comm),-1,'С��',1,'����',0,'����')


--����·� size
L
S
M
XL

xxL

s  m   l  xl  xxl
order by decode(size,'s',1,'m',2,'l',3,'xl',4,'xxl',5) 

case when
  

select sno,
max(case when cno='c001' then score end) c001 ,
max(case when cno='c002' then score end) c002 ,
max(case when cno='c003' then score end) c003 ,
max(case when cno='c004' then score end) c004 ,
max(case when cno='c005' then score end) c005 ,
max(case when cno='c006' then score end) c006 ,
max(case when cno='c007' then score end) c007 ,
max(case when cno='c008' then score end) c008 ,
max(case when cno='c009' then score end) c009 ,
max(case when cno='c010' then score end) c010 
from sc
group by sno
order by sno

select * from (
select * from  sc
pivot (max(score) for cno in ('c001' c001,'c002' c002,'c003' c003,'c004' c004,'c005' c005,'c006' c006,'c007' c007,'c008' c008,'c009'c009,'c010' c010)))
unpivot(score for cno in (c001,c002,c003,c004,c005,c006,c007,c008,c009,c010))


--���򿪴� 

��ȡ ǰ10����ѧ���ɼ� 

select * from sc
where rownum<=10
order by score desc

select * from (
select sc.* ,
row_number()over(partition by cno  order by  SCORE desc ) r,--û����
rank() over(partition by cno  order by  SCORE desc) rr, --���е�������
dense_rank() over(partition by cno  order by  SCORE desc) rrr--���е�������������
from sc
)
where r<=10

select * from (
select sno,cno,score,rank()over(partition by sno order by score desc) r,
row_number() over(partition by sno order by score desc) rr
from sc 
)
where r=1
and rr=2


---�ۺϿ��� 
sum avg max min count


select sno,cno,score,case when score=max(score)over(partition by sno) then '��߷ֿ�Ŀ'else '����' end
from sc



��ֵ��¼�� 
��һ�ʳ�ֵ һֱ�� ����300Ԫ ���˶���ʱ��
ID ��ֵ��� ��ֵʱ�� 
select sno,cno, score, sum(score)over(partition by sno order by cno)
from sc



--ƫ�ƿ��� 
ͬ�� ȥ��ͬ������
���� ������������

lag
lead

select sno,cno,score,
lag(score,1)over(partition by cno order by score desc),
lead(score,1)over(partition by cno order by score desc)
 from sc



