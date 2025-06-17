create table student(
	sno int,
	sname varchar(20),
	sex varchar(10),
	age int,
	class varchar(20),
	score float(8,2),
	sdate datetime
)

select * from student 

insert into student values(1,'周杰伦','男',29,'45班',99,now()),
(2,'蔡依林','女',30,'45班',66,now()),
(3,'蔡徐坤','男',20,'45班',28,now())