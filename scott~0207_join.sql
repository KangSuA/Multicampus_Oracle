select ename, sal, emp.deptno, dname from emp, dept
where emp.deptno = detpt.deptno;

-- [문제]isbn, 책이름, 가격, 출판사명, 출판사연락처, 작가명을 선택
-- 단 10000원 이상인 도서를 선택하라.
select b.isbn, b.bookname, b.price, p.pub_name, p.pub_tel, a.author
from (select * from books where price>=10000) b
join pub_tbl p
on b.pub_code = p.pub_code
join author_tbl a
on b.author_code = a.author_code;

-- emp와 dept를 조인. 사원중 부서코드가 30번인 사원의 사원명, 업무, 급여, 부서명을 선택하라.
select ename,job,sal,dname, emp.deptno from emp, dept where emp.deptno = dept.deptno and emp.deptno=30;
select ename, job, sal, dname, e.deptno from emp e join dept d on e.deptno=d.deptno and e.deptno=30
order by e.ename asc;

-- [실습] SALESMAN의 사원번호, 이름, 급여, 부서명, 근무지를 출력하라.
select empno, ename, sal, dname, loc from emp e join dept d on e.deptno=d.deptno and job='SALESMAN';
select * from emp;

-- 비동등조인 : 학점, 평점등 범위를 이용하여 조인한다.
-- 사원명, 업무, 급여, 호봉을 선택하라.
select e.ename, e.job, e.sal, s.grade 호봉
from emp e, salgrade s
where e.sal between s.losal and s.hisal;

select e.ename, e.job, e.sal, s.grade 호봉
from emp e join salgrade s
on e.sal between s.losal and s.hisal;

-- [문제] 10번,20번 부서의 사원중 사원번호, 사원명, 급여, 보너스, 부서명, 호봉을 선택하라
select e.empno, e.ename, e.sal, e.comm, d.dname, s.grade
from emp e, salgrade s, dept d
where e.deptno=d.deptno and e.sal between s.losal and s.hisal and e.deptno in(10,20);

select e.empno, e.ename, e.sal, e.comm, d.dname, s.grade, e.deptno
from emp e join dept d on e.deptno=d.deptno
join salgrade s on e.sal between s.losal and s.hisal and e.deptno in(10,20)
order by s.grade asc;

update emp set deptno=30 where job=upper('manager');
select * from emp;
commit;

-- self join : 같은 테이블을 조인하낟.
-- 사원명, 업무, 입사일, 관리자명, 관리자 입사일, 급여를 선택하라.
select e1.ename, e1.job, e1.hiredate, e2.ename 관리자명, e2.hiredate 관리자입사일, e2.sal 관리자급여
from emp e1 join emp e2 on e1.mgr=e2.empno;

-- [문제] emp테이블에서 "누구의 관리자는 누구이다."는 내용을 출력하세요
select e1.ename || '의 관리자는 '|| e2.ename || '이다.' 셀프조인
from emp e1 join emp e2 on e1.mgr=e2.empno;

-- outer 조인
-- null이 들어갈 쪽에 +를 붙여라.
-- 사원명, 급여, 부서코드, 부서명을 선택하라.
select e.ename, e.sal, e.deptno, d.dname, d.deptno
from emp e, dept d
where e.deptno(+)=d.deptno;

select e.ename, e.sal, e.deptno, d.dname, d.deptno
from emp e join dept d
on e.deptno(+)=d.deptno;

select * from pub_tbl;
desc books;
-- 책이름, 출판사명, 가격을 out join하라.
select b.bookname, p.pub_name, b.price
from books b join pub_tbl p
on b.pub_code(+) = p.pub_code;

-- left outer join : null이 오른쪽에 있으면
-- right outer join : null이 왼쪽에 있으면
-- 사원명, 급여, 부서코드, 부서명을 선택하라.
select e.ename, e.sal, e.deptno, d.dname
from emp e right outer join dept d
on e.deptno = d.deptno;
-- 위아래 같은 것
select e.ename, e.sal, e.deptno, d.dname
from dept d left outer join emp e
on e.deptno = d.deptno;

-- full outer join
select e.ename, e.deptno, d.dname
from dept d  full outer join emp e
on e.deptno=d.deptno;

select distinct a.deptno, b.deptno
from emp a full outer join dept b
on a.deptno=b.deptno
order by a.deptno;

-- 1.
select e.ename, e.deptno, d.dname
from emp e, dept d -- emp e join dept d on
where e.deptno=d.deptno
order by d.deptno;

select * from EMP;
-- 2.
select e.ename, e.job, e.sal, d.dname
from emp e, dept d
where E.deptno=d.deptno and d.loc='NEW YORK';

-- 3.
select e.ename, d.dname, d.loc
from emp e, dept d
where e.deptno=d.deptno and nvl(e.comm,0)!=0; -- e.comm>0

-- 4.
select e.ename, d.dname, d.loc
from emp e, dept d
where e.deptno=d.deptno and e.ename like '%L%';

-- 5.
select e1.ename Employee, e1.empno EMP#, e2.ename Manager, e2.empno Mgr#
from emp e1 left outer join emp e2
on e1.mgr = e2.empno;
--from emp e1, emp e2
--where e1.mgr = e2.empno(+);

-- natural join
-- 조인할 테이브렝서 같은 필드명을 찾아 조인해준다. 별명 사용x
select empno, ename, deptno from emp natural join dept;

-- join ~ using
-- join 조건을 on 대신 using을 사용할 수 있다.
select empno, ename, deptno from emp join dept using(deptno);