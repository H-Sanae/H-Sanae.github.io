--1. ��ѯemp����Ա�������ֺ͹���
select ename, sal from emp;

--2. ��ѯemp����Ա���ı��,����,����
select empno, ename, comm from emp;

--3. ��ѯ���ű�źͲ�������
select deptno, dname from dept;

--4. ��ѯԱ�����ֺ���ְ����(����������ʾ ����, ��ְ����)
select ename ����, hiredate ��ְ���� from emp;

--5. ��ѯԱ����ţ����֣�������
select empno,  ename, mgr from emp;

--6. ��ѯ��˾������в��ŵĲ��ű�ţ�ȥ�أ�
select distinct deptno from emp;

--7. ��ѯԱ���������͹��ʣ������ָ�ʽ��ʾ��simth�Ĺ�����800��
select ename || '�Ĺ�����' || sal || '��'  ������Ϣ from emp;

--8. ʹ����������鿴ϵͳ����
select sysdate from dual;

--9. �鿴Ա�����ǰ��������
select emp.*, rownum from emp where rownum<=5;

--10. �鿴Ա�����rowid
select emp.*,rowid from emp;
