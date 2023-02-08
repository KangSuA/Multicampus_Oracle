-- VIEW : �������̺�
create or replace view emp_dept
as
select e.empno, e.ename, e.sal, d.dname
from emp e join dept d
on e.deptno=d.deptno;

select * from tab;

select * from emp_dept;

select * from user_constraints where table_name='EMP';

-- emp ���̺��� �����ȣ, �����, �޿�, �μ���ȣ�� �̿��Ͽ� view�����ϱ�
create or replace view emp_view
as
select empno, ename, sal, deptno from emp;

--emp ���̺��� 30���μ��� ��� �� �����ȣ, �����, ����, �޿�, �μ���ȣ�� �̿��Ͽ� view����
create view emp_30
as
select empno, ename, job, sal, deptno from emp
where deptno=30;
select * from emp_30;

desc emp;
insert into emp(empno, ename, deptno) values(5555,'HONG',10);
insert into emp(empno, ename, deptno) values(6666,'PARK', 30);
insert into emp_30(empno,ename,job, sal, deptno) values(7777,'COHI','PROGRAMER',5000,20);
select * from emp;

commit;
delete from emp_dept where empno=6666;

-- �б� ���� �� �����
create view emp_read
as
select empno, ename, sal from emp
with read only;
select * from emp_read;
-- readonly�̹Ƿ� ���ڵ� �߰� �� �� ����.
insert into emp_read(empno, ename, sal) values(8888,'LEE', 3500);
-- ������ Ȯ��
select * from user_views;
-- �����
drop view emp_read;
drop view emp_30;
drop view emp_dept;
drop view emp_view;







