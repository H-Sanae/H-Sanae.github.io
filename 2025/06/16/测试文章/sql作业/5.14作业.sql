--上机练习17
--1.创建一个视图，查询出来emp表的所有数据，并用insert into 给这个插入一条数据
create or replace view v_emp as select * from emp
insert into v_emp values(1111,'HWZ','CLERK',null,trunc(sysdate),888,null,40)
delete from emp where empno=1111

--2.创建一个查询emp表所有部门平均工资的视图，并试图去修改这个视图的数据
create or replace view v_emp_avgsal as
select deptno,avg(sal) 平均工资 from emp group by deptno
select * from v_emp_avgsal
update v_emp_avgsal set 平均工资=round(平均工资) --非法

--3.创建一个只读视图，查询学生的平均成绩，并试图去修改数据
create or replace view v_avg as
select sno,avg(score) 平均成绩 from sc group by sno order by sno
with read only
update v_avg set 平均成绩=round(平均成绩) --非法

--4.创建一个序列，从1开始，每次增长1
create sequence seq_emp
start with 1
increment by 1

--5.使用序列，把序列是8的插入到emp表中作为主键
select seq_emp.nextval from dual
select seq_emp.currval from dual
insert into emp values(seq_emp.currval,'hwz','CLERK',1111,trunc(sysdate),888,null,40)
select *from emp

--6.修改序列增长值为10，把序列是38的插入到emp表中作为主键
alter sequence seq_emp increment by 10
select seq_emp.nextval from dual
insert into emp values(seq_emp.currval,'hwz2','CLERK',1111,trunc(sysdate),666,null,40)


--上机练习18

--创建字典表 t_dic
create table t_dic(
       type varchar2(10),
       name varchar2(20),
       key varchar2(10) unique,
       value varchar2(20) not null
);
--批量插入数据
select * from t_dic for update

--创建货物表 goods
create table goods(
       id varchar2(32) primary key,
       type varchar2(10) references t_dic(key),
       name varchar2(100),
       inprice number(10,2), 
       outprice number(10,2),
       tjdw varchar2(10) references t_dic(key),
       qualitydate number(4) check(qualitydate>0) 
);
--批量插入数据
select * from goods for update

--创建货物库存表 stock
create table stock(
       id varchar2(32) primary key,
       goodsid varchar2(32) references goods(id),
       sl number(4),
       intime date default sysdate,
       productime date
);

--创建进帐表 income
create table income(
       id varchar2(32) primary key,
       goodsid varchar2(32) references goods(id),
       stockid varchar2(32) references stock(id),
       sl number(4) check(sl>0),
       discount number(4,1),
       allprice number(8,1),
       outtime date default sysdate
);

--创建出帐表 outcome
create table outcome(
       id varchar2(32) primary key,
       goodsid varchar2(32) references goods(id),
       stockid varchar2(32) references stock(id),
       sl number(4,1) check(sl>0),
       allprice number(8,1),
       intime date default sysdate
);
drop table outcome

select * from t_dic --字典表
select * from goods --货物表
select * from stock  --库存表
select * from income --进帐表
select * from outcome --出帐表

--1. 在货物库存表stock的goodsid建立索引
create index idx_stock_goodsid on stock(goodsid)

--2. 在货物类型表goods的货物名称列添加唯一约束
alter table goods add constraint wyys unique(name)

--3. 将货物类型表的各种物品，在库存表插入一条记录，要求每个字段都填写完整，保证数量都在100以上。
insert into stock(id,goodsid,sl,intime,productime)
select 
    g.id id,
    g.id goodsid,
    floor(dbms_random.value(100, 300))  sl,  -- 随机生成100-300的数量
    trunc(sysdate) - 30  intime,  -- 进货日期（一个月前）
    trunc(sysdate - dbms_random.value(30,90))  productime  -- 生产日期（1-3个月前）
from goods g order by g.id

delete from stock --删除数据

--4. 查询出货物表中过期的所有物品
select * from goods g join stock s on s.id=g.id where productime+qualitydate<sysdate

--5. 查询货物表中10天之内过期的所有物品
select * from goods g join stock s on s.id=g.id where sysdate-(productime+qualitydate) between 0 and 10

--6. 于当前时间新进货脉动50瓶，可口可乐50瓶，在出账表outcome和库存表stock插入相应记录
create sequence seq_stock --库存序列
start with 12
increment by 1

drop sequence seq_stock 
select seq_stock.nextval from dual
select seq_stock.currval from dual

create sequence seq_outcome --出账序列
start with 1
increment by 1

drop sequence seq_outcome
select seq_outcome.nextval from dual
select seq_outcome.currval from dual

--库存表插入
insert into stock
select seq_stock.nextval,id,50,trunc(sysdate),trunc(sysdate)-20
from goods where id in (select id from goods where name = '脉动' or name='可口可乐')
       
--出账插入
insert into outcome --脉动
select seq_outcome.nextval,id,seq_outcome.nextval,50,inprice*50,trunc(sysdate) 
from goods where id in (select id from goods where name = '脉动' or name='可口可乐')

delete from outcome

--7. 于当前时间卖出泰山一包，在进账表插入相应记录，在库存表修改相应记录
select * from income --进帐表

create sequence seq_income --出账序列
start with 1
increment by 1

drop sequence seq_income
select seq_income.nextval from dual
select seq_income.currval from dual

--进帐插入
insert into income(id, goodsid, stockid, sl, discount, allprice, outtime) 
values(
    seq_income.nextval, -- id
    (select id from goods where name = '泰山'), -- 商品id
    (select s.id from stock s join goods g on s.goodsid = g.id where g.name = '泰山'), -- 库存id
    1, -- 销售数量1包
    1, -- 不打折
    (select outprice from goods where name = '泰山')*1, -- 总价
    sysdate -- 销售时间
);
--更新库存
update stock set sl = sl-1 where goodsid = (select id from goods where name = '泰山') and sl > 0; -- 确保库存充足

--8. 查询库存内所有物品的总价，进货价计算
select s.*, outprice*sl 总价, inprice*sl 进货价 from stock s join goods g on g.id=s.id 

--9. 查询酒水类物品的仓库保有量最大的物品id和总价
select * from (
    select g.id, g.outprice * sum(s.sl) 总价
    from stock s
    join goods g on s.goodsid = g.id
    where g.type = 'g02'
    group by g.id, g.outprice
    order by sum(s.sl) desc
)
where rownum = 1;

--10. 查询价格大于5元低于10元的所有物品名称
select name from goods where outprice between 5 and 10

--11. 查询名称中有山字的所有物品
select name from goods where name like '%山%'

--12. 查询进货日期是今天的所有进货记录
select * from outcome where intime = trunc(sysdate)

--13. 查询名称长度最大的物品名称
select name from(
    select name from goods order by length(name) desc
) where rownum = 1;

--14. 汇总各类型物品的库存，其中烟和酒水单独统计，其他物品展示为其他
select case when
       g.type in('g01','g02') then (g.name)
       else '其他' end 名称, sum(s.sl) 库存
from stock s join goods g on g.id=s.goodsid
group by case when
       g.type in('g01','g02') then (g.name)
       else '其他' end
order by 库存

--15. 更新可比克薯片的名称，将名称改为可比克薯片（袋装）
update goods set name='可比克薯片（袋装）' where name='可比克薯片'

--16. 将各类物品根据价格倒序排列展示
select * from goods order by outprice desc

--17. 查询出今天的销售额，毛利润
select sum(allprice) 销售额, sum(allprice-inprice*sl) 毛利润
from income i join goods g on g.id=i.goodsid

--18. 根据每种物品类型（类型包括很多物品）昨天销售的累计数量，求出最大的数量的类型名称及总数量
with 昨日销售 as (
    select g.type as 类型代码,sum(i.sl) as 销售总量
    from income i join goods g on i.goodsid = g.id
    where trunc(i.outtime) = trunc(sysdate) - 1  -- 昨天的销售记录
    group by g.type
)
select d.name 类型名称, y.销售总量
from 昨日销售 y join t_dic d on y.类型代码 = d.key
where y.销售总量 = (select max(销售总量) from 昨日销售);

19. 查询出烟类，近10天的销售情况，展示出物品名称，卖出数量，总价格，毛利润
select name,sum(sl),sum(allprice),sum(allprice-inprice*sl) from goods g
inner join income i on i.goodsid=g.id
where g.type in(select key from t_dic where value='烟类') and outtime between sysdate-10 and sysdate
group by name

20. 根据天数分组，汇总近10天每天的销售情况，毛利润和总价格
select sum(mlr),sum(zjg),ot from(
select allprice-inprice*sl mlr,allprice zjg,to_char(outtime,'yyyymmdd') ot from goods g
inner join income i on i.goodsid=g.id) t
group by ot

21. 创建视图，展示当月销售物品中，分类统计各类物品的销售数量，总进价，总卖出价，毛利润
create or replace view v_xsqk
as
select sum(sl) zsl,sum(inprice) zjj,sum(outprice) zmc,sum(allprice-inprice*sl) mlr from goods g
inner join income i on i.goodsid=g.id 
where to_char(outtime,'mm')=to_char(sysdate,'mm')
with read only
select * from v_xsqk

22. 在物品表里查出利润率最大的物品
select * from(
select name,rank()over(order by (outprice-inprice)/inprice desc) r from goods ) t
where r=1

23. 因为某人讲价，于当前时间，以8折卖出馒头50个，在进账表和库存表做出相应修改
select * from income
insert into income values(seq_income.nextval,
(select id from goods where name='馒头'),
(select id from stock where goodsid in(select id from goods where name='馒头')),
50,
0.8,
(select outprice from goods where name='馒头')*50*0.8,
sysdate
)

update stock set sl=sl-50 where id=9


