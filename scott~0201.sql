-- jdbc : 쿼리문 실행을 자바에서 할 수 있도록 도와주는 프레임워크
select * from tab;

select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp
order by ename;

select empno, ename, job, hiredate, sal from emp where ename=upper('adams');