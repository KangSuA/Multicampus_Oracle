-- ���̺� ����
-- �������̺��� �ʵ�� ���ڵ带 �̿��Ͽ� ���ο� ���̺��� �����Ѵ�.
select * from tab;
select * from emp;
select * from emp2;
select * from emp3;
select * from emp4;
-- ��� �õ�� ��� ���ڵ� ����
create table emp2 
as 
select * from emp;
-- ���ϴ� �ʵ�� ���ڵ� ����
create table emp3
as
select empno, ename, sal from emp;

-- ���ϴ� ���ڵ常 ����
create table emp4
as
select * from emp where deptno=20;

-- ���ڵ� ���� �ʵ��� ������ ����
create table emp5
as
select * from emp where 1=2;
select * from emp5;

-- ������
insert into emp2(empno) values(1111);
insert into emp2(empno, sal, ename) values(2222,5500,'ȫ�浿');
insert into emp2(empno, ename, sal, deptno) values(3333,'������',6000,40);
-- ��� �ʵ��� ���� ���� �� �ʵ�� ���� ����
insert into emp2 values(4444,'�̼���','�渮','7777',sysdate, 4500,200,40);

commit; -- �۾��Ϸ�

-- emp���̺��� 10�� �μ��� ����� emp4�� ����
insert into emp4(empno,ename,sal, deptno)
select empno, ename, sal, deptno from emp where deptno=10;

-- update : ���ڵ� �����ϱ�
update emp2 set ename='test', job='CLERK', sal=3000 where empno=1111;
-- �޿��� 10���� �����϶�
update emp2 set sal=sal*1.1;
update emp2 set sal=sal*1.2 where job='SALESMAN';
select * from emp2;

rollback;

-- delete: ���ڵ� �����ϱ�
delete from emp2 where comm=200;
delete from emp2;
