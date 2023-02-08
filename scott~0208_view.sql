-- VIEW : 가상테이블
create or replace view emp_dept
as
select e.empno, e.ename, e.sal, d.dname
from emp e join dept d
on e.deptno=d.deptno;

select * from tab;

select * from emp_dept;

select * from user_constraints where table_name='EMP';

-- emp 테이블에서 사원번호, 사원명, 급여, 부서번호를 이용하여 view생성하기
create or replace view emp_view
as
select empno, ename, sal, deptno from emp;

--emp 테이블에서 30번부서의 사원 중 사원번호, 사원명, 업무, 급여, 부서번호를 이용하여 view생성
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

-- 읽기 전용 뷰 만들기
create view emp_read
as
select empno, ename, sal from emp
with read only;
select * from emp_read;
-- readonly이므로 레코드 추가 할 수 없다.
insert into emp_read(empno, ename, sal) values(8888,'LEE', 3500);
-- 뷰정보 확인
select * from user_views;
-- 뷰삭제
drop view emp_read;
drop view emp_30;
drop view emp_dept;
drop view emp_view;







