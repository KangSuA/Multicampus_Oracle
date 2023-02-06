select * from tab;
select * from emp;

-- order by�� : asc, desc
-- ������� ������������ �����϶�.
select ename, sal, deptno from emp
order by ename;
select * from emp order by sal asc;
select * from emp order by hiredate asc;
-- ������ �޿������� �����϶�.
select * from emp
order by job asc, sal desc, ename desc;

-- distinct : �ߺ��� ����
select distinct job from emp;
select distinct deptno, job from emp order by deptno;

-- emp���̺��� �����, �޿�, ���޾��� �����϶�. ��, ������� ������������ �����Ѵ�.
-- ���޾� = �޿� + ���ʽ�
select ename �����, sal �޿�, comm ���ʽ�,sal+nvl(comm,0) ���޾� from emp
order by ename;

select empno, ename, sal from emp
order by 2 desc;

-- 1
select empno, ename, sal from emp;
-- 2
select empno, ename, sal, job from emp order by 2;
-- 3
select * from emp where hiredate like '___05%';
-- 4
select * from emp where ename like '%A%' or sal>=3000;
-- 5
select * from emp where job in('SALESMAN','MANAGER');
-- 6
select * from emp where sal>=3000 and (comm is null or comm=0);
select * from emp where sal>=3000 and nvl(comm,0)=0;
-- 7
select * from emp where comm is not null and comm!=0 or sal between 2000 and 4000
order by sal desc;
select * from emp where sal between 2000 and 4000 or nvl(comm,0)>0 order by sal desc;
-- 8
select * from tab;
select * from tabs;
-- 9
select empno, ename, job, hiredate, sal from emp where deptno in(10,20)
order by job asc, sal desc;

select * from emp;

-- literal
-- ���� �̸��� scott�Դϴ�.
select '���� �̸��� ' || ename || '�Դϴ�.' �̸� from emp;
-- ex
select ENAME  || ': 1YEAR SALARY = ' || sal*12 �̸������� from emp;