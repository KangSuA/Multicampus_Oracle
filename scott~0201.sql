-- jdbc : ������ ������ �ڹٿ��� �� �� �ֵ��� �����ִ� �����ӿ�ũ
select * from tab;

select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp
order by ename;

select empno, ename, job, hiredate, sal from emp where ename=upper('adams');