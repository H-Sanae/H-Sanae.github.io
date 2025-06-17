select * from student
select * from teacher
select * from course
select * from sc

--�ϻ���ϰ14

--1��������c001���γ̷���С��80���������������е�ͬѧѧ��
select sno,score from sc where cno='c001' and score<80 order by score desc

--2����ѯ�����γ̼���Ӧ��ѡ������
select c.cno,c.cname,count(sc.sno) ѡ������
from course c left join sc on c.cno=sc.cno 
group by c.cno,c.cname order by c.cno

--3�����ղ�ͬ��ʦ��ŷ�����ʾ�γ��б��γ�֮���ö��Ÿ���
select tno,listagg(cname,'��')within group(order by cno) from course group by tno

--4����ѯ���Ƴɼ���ߺ���͵ķ֣���������ʽ��ʾ���γ�ID����߷֣���ͷ�
select cno �γ�ID, max(score) ��߷�, min(score) ��ͷ� from sc group by cno order by cno

--5���鿴�ɼ�����Ϣ�����һ�б�ע�Ƿ񼰸�
select sc.*,case
       when score>=60 then '��'
       else '��'
       end �Ƿ񼰸�
from sc

--6����ѯ��ֻѡ����һ�ſγ̵�ȫ��ѧ����ѧ�ź�����
select sno,sname from student s where 
       (select count(*) from sc  where sc.sno=s.sno)=1
order by s.sno

--7����ѯƽ���ɼ�����85������ѧ����ѧ�š�������ƽ���ɼ�
select s.sno,s.sname,avg(score) 
from student s join sc on(s.sno=sc.sno) 
group by s.sno,s.sname having avg(score)>85 order by s.sno

--8��ͳ�Ƹ��Ƴɼ�,������������:������Ϊ[100-85] a,[84-70] b,[69-60] c,[ <60] d
select c.cno, c.cname,
    count(case when sc.score between 85 and 100 then 1 end) a,
    count(case when sc.score between 70 and 84 then 1 end) b,
    count(case when sc.score between 60 and 69 then 1 end) c,
    count(case when sc.score < 60 then 1 end) as d
from sc join course c on sc.cno=c.cno
group by c.cno, c.cname
order by c.cno

--9����ѯ�γ�����Ϊ��Oracle�����ҷ�������60 ��ѧ�������ͷ���
select s.sname, sc.score 
from student s 
join sc on sc.sno=s.sno
join course c on c.cno=sc.cno
where c.cname='Oracle' and sc.score<60

--10����ѯ����ѧ����ѡ�������ѡ�˶����ſγ̣�
select s.sno,s.sname,
listagg(c.cname,'��')within group(order by sc.cno) ѡ��,
count(sc.cno) �ϼ�
from student s 
join sc on sc.sno=s.sno
join course c on c.cno=sc.cno
group by s.sno,s.sname

--11��ͳ��ÿ�ſγ̵�ѧ��ѡ������������1�˵Ŀγ̲�ͳ�ƣ���Ҫ������γ̺ź�ѡ����������ѯ����������������У���������ͬ�����γ̺���������
select cno,count(sno) ѡ������ from sc group by cno order by ѡ������ desc, cno 

--12.��SC���в���һЩ��¼����Щ��¼Ҫ���������������û���Ϲ���š�c002���γ̵�ͬѧѧ�š���c002���ſε�ƽ���ɼ���
insert into sc(sno,cno,score)
select s.sno,'c002',(select avg(score) from sc where cno='c002')
from student s
where s.sno not in (
      select sno from sc where cno='c002'
)

--13����ѯȫ��ѧ����ѡ�޵Ŀγ̵Ŀγ̺źͿγ���
select c.cno,c.cname from course c
where not exists( --������δѡ��ĳһ�ſ�
      select 1 from student s where not exists(  --δѡ��ĳһ�ſ�
             select 1 from sc where sc.sno=s.sno and sc.cno=c.cno --ѡ����ĳһ�ſ�
      )
)

--14����ѯû��ѧȫ���пε�ͬѧ��ѧ�š�������
select sno,sname from student s
where exists(
      select 1 from course c where not exists(  --δѡ��ĳһ�ſ�
             select 1 from sc where sc.sno=s.sno and sc.cno=c.cno --ѡ����ĳһ�ſ�
      )
)

--15����ѯ��c001���γ̱ȡ�c002���γ̳ɼ��ߵ�����ѧ����ѧ�ţ�
select sc1.sno,sc1.score,sc2.score from sc sc1 
join sc sc2 on sc1.sno=sc2.sno
where sc1.cno='c001' and sc2.cno='c002' and sc1.score>sc2.score

--16.������c001�γ̳ɼ�����ƽ���ɼ���ͬѧ�ķ�����Ϊ60��
update  sc set score = 60 where cno='c001' and score<(
        select avg(score) from sc where cno='c001'
)

--17.ɾ��ѧϰ�����ࡱ��ʦ�ε�SC ���¼��
delete from sc where cno in(
       select c.cno from course c join teacher t on c.tno=t.tno where t.tname='����'
)

--18.����dept1���ȡscott.dept�����ݣ���ʹ��insert...select����һ��scott.dept�����ݵ�detp1����ʹ��ɾ�����ɾ���ظ�����
create table dept1 as select * from scott.dept; --����
insert into dept1 select * from scott.dept; --����
--ɾ���ظ�����
--����һ
delete from dept1 where rowid not in(
       select max(rowid) from dept1 group by deptno
)
--������
delete from dept1 where rowid not in(
       select rowid from(
              select dept1.*,rowid,row_number()over(partition by deptno order by deptno) r from dept1
       ) where r=1
)

--19����ѯûѧ�������ࡱ��ʦ�ε�ͬѧ��ѧ�š�������
select sno,sname from student s where not exists(
       select 1 from sc 
       join course c on sc.cno=c.cno
       join teacher t on c.tno=t.tno
       where sc.sno=s.sno and t.tname='����' 
) order by s.sno

--20����ѯѧ����c001������Ҳѧ����š�c002���γ̵�ͬѧ��ѧ�š�������
select sno,sname from student s where exists(
       select 1 from sc where sc.sno=s.sno and cno='c001'
) and exists(
       select 1 from sc where sc.sno=s.sno and cno='c002'
) order by s.sno

--21����ѯ��ÿ��ѧ��������һ����ѧ�������б�,�����γ̱�ţ�ѧ��������ѧ���ɼ�
--�Ӳ�ѯ
select sc.cno,s.sname,sc.score from sc 
join student s on s.sno=sc.sno
where sc.score=(
      select max(score) from sc where cno=sc.cno
) order by sc.cno
--���ں���
with rnk as(
     select sc.cno �γ̱��, s.sname ѧ������, sc.score ѧ���ɼ�,
     dense_rank()over(partition by sc.cno order by sc.score desc) ����
     from sc join student s on s.sno=sc.sno
)
select �γ̱��,ѧ������,ѧ���ɼ� from rnk where ����=1 order by �γ̱��

--22����ѯѡ�ޡ����ࡱ��ʦ���ڿγ̵�ѧ���У��ɼ���ߵ�ѧ����������ɼ�
with cy_c as( -- ��ȡ������ʦ���ڵ����пγ�
     select c.cno from course c 
     join teacher t on t.tno=c.tno
     where t.tname='����' 
),
top_s as( -- �ҳ���Щ�γ��гɼ���ߵ�ѧ��
      select sname ѧ������, score �ɼ� ,dense_rank()over(order by sc.score desc) ����
      from sc join student s on s.sno=sc.sno
      where sc.cno in(select cno from cy_c)
)
select ѧ������,�ɼ� from top_s where ����=1

--23����ѯѧ�������ࡱ��ʦ���̵����пε�ͬѧ��ѧ�š�������
with cy_c as( -- ��ȡ������ʦ���ڵ����пγ�
     select c.cno from course c 
     join teacher t on t.tno=c.tno
     where t.tname='����' 
)
select s.sno ѧ��, s.sname ����
from student s where not exists( -- ������ûѡ�޵Ŀγ�->ѡ����ȫ���γ�
     select 1 from cy_c where not exists( --ûѡ��������ʦĳһ�γ�
            select 1 from sc where sc.sno=s.sno and sc.cno=cy_c.cno --ѡ����������ʦĳһ�γ�
     )
) order by ѧ��


--24����ѯ������һ�ſ���ѧ��Ϊ��s001����ͬѧ��ѧ��ͬ��ͬѧ��ѧ�ź�����
with s1_c as( -- ��ȡs001ͬѧ�����пγ�
     select cno from sc where sno='s001' 
)
select s.sno,s.sname from student s
join sc on sc.sno=s.sno
where sc.cno in(select * from s1_c)

--25����ѯ�͡�s001���ŵ�ͬѧѧϰ�Ŀγ���ȫ��ͬ������ͬѧѧ�ź�����
with s1_c as( -- ��ȡs1ͬѧ�����пγ�
     select cno from sc where sno='s001' 
)
select s.sno ѧ��, s.sname ���� from student s
join sc on sc.sno=s.sno 
where s.sno!='s001' and not exists( --������
      select 1 from s1_c where not exists( --sc1ûѡ
             select 1 from sc where sc.sno=s.sno and sc.cno=s1_c.cno --��scѡ��
      )
) and not exists( --������
      select 1 from sc where sc.sno=s.sno and not exists( ---scûѡ
             select 1 from s1_c where s1_c.cno=sc.cno --��s1ѡ��
      )
) order by s.sno
