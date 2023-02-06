-- 주석
-- * : 모든 필드

select * from tab;

select dname,loc
from dept;
--            별명,별칭(alias)
select deptno 부서코드, ename 사원명, sal as 급여 from emp;

select * from emp;

desc emp;

-- where 절 : 원한느 조건에 해당하는 레코드만 선택가능하다.
select ename, sal, deptno from emp
where deptno = 10;
-- 업무가 manager인 사원을 선택하라.
-- 상수는 대소문자 구별. 문자는 작은 따옴표
select * from emp
where job='MANAGER';

-- 급여가 2000불 이상인 사원을 선택하라.
select * from emp where sal>=2000;
-- 급여가 2000~3000불 이상인 사원을 선택하라.
select * from emp where sal>=2000 and sal<=3000;
select * from emp where sal between 2000 and 3000;

-- emp테이블에서 사원번호, 사원명, 급여, 부서코드를 선택하되 급여가 2500~3000불 사이인 사원
select empno, ename, sal, deptno from emp where sal between 2500 and 3000;

-- emp테이블에서 10,30번 부서의 사원 중 담당업무가 manager인 사원
-- AND > OR
select * from emp where job='MANAGER' AND deptno in(10,30);
select * from emp where (deptno=10 or deptno=30) and job='MANAGER';

-- in 연산자 : or
-- emp테이블에서 급여가 2000,3000,4000,5000인 사원을 선택
select * from emp where sal in(2000,3000,4000,5000);
select * from emp where sal=2000 or sal=3000 or sal=4000 or sal=5000;

-- like연산자 : Data의 일부가 일치하면 선택
select * from emp;
-- 사원명이 A로 시작하는 사원을 선택하라.
select * from emp where ename like 'A%';
-- 사원명이 S로 끝나는 사원을 선택하라.
select * from emp where ename like '%S';
-- 사원명에 M이 포함되어 있는 사원을 선택하라.
select * from emp where ename like '%M%';

-- 사원명이 2번째 문자 L인 사원을 선택하라.
select * from emp where ename like '_L%';

-- 급여가 1500불 이상인 사원중 12월에 입사한 사원을 선택하라.
select * from emp where sal>=1500 and hiredate like '___12%'; -- '__/12%'

-- not between
-- 사원번호가 7500부터 7700번 사이의 사원을 제외하고 선택하라.
select * from emp where empno<7500 or empno>7700;
select * from emp where empno not between 7500 and 7700;

-- not in
-- 급여가 3000, 4000, 5000인 사원을 제외하고 선택하라.
select * from emp where sal not in(3000,4000,5000);

-- not like
-- 담당업무 man을 포함한 업무는 제외하고 선택하라.
select * from emp where job not like '%MAN%';

-- 산술연산자
-- null은 모든 연산에서 제외됨 => is null, is not null
select empno, ename, sal, sal*2000 from emp;
select * from emp where comm=null; -- null은 null연산자를 이용하여야 한다.
select * from emp where comm is null;
select * from emp where job='SALESMAN';

-- 급여를 10%인상한 금액으로 선택하라.
select ename, sal, sal*1.1 from emp;

-- emp테이블에서 사원명, 업무, 급여, 입사일, 보너스를 선택하되
-- 급여는 20%인상한 금액을 선택하고
-- 82년도, 83년도 입사한 사원을 제외하라.
select ename, job, sal*1.2 sal, hiredate, comm from emp where hiredate not like '82%' and hiredate not like '83%';
