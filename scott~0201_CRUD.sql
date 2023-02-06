-- 테이블 복사
-- 기존테이블의 필드와 레코드를 이용하여 새로운 테이블을 생성한다.
select * from tab;
select * from emp;
select * from emp2;
select * from emp3;
select * from emp4;
-- 모든 플디와 모든 레코드 복사
create table emp2 
as 
select * from emp;
-- 원하는 필드와 레코드 복사
create table emp3
as
select empno, ename, sal from emp;

-- 원하는 레코드만 복사
create table emp4
as
select * from emp where deptno=20;

-- 레코드 없이 필드의 구조만 복사
create table emp5
as
select * from emp where 1=2;
select * from emp5;

-- 사원등록
insert into emp2(empno) values(1111);
insert into emp2(empno, sal, ename) values(2222,5500,'홍길동');
insert into emp2(empno, ename, sal, deptno) values(3333,'세종대',6000,40);
-- 모든 필드의 값이 있을 때 필드명 생략 가능
insert into emp2 values(4444,'이순신','경리','7777',sysdate, 4500,200,40);

commit; -- 작업완료

-- emp테이블에서 10번 부서의 사원을 emp4에 삽입
insert into emp4(empno,ename,sal, deptno)
select empno, ename, sal, deptno from emp where deptno=10;

-- update : 레코드 수정하기
update emp2 set ename='test', job='CLERK', sal=3000 where empno=1111;
-- 급여를 10프로 증가하라
update emp2 set sal=sal*1.1;
update emp2 set sal=sal*1.2 where job='SALESMAN';
select * from emp2;

rollback;

-- delete: 레코드 삭제하기
delete from emp2 where comm=200;
delete from emp2;
