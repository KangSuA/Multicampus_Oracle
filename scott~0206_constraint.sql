-- primary key 제약조건 설정하기
-- constraint 제약조건변수명 : 테이블명_제약조건종류_필드명
alter table emp add constraint emp_pk_empno primary key(empno);

-- 제약조건 확인하기
select * from user_constraints where table_name='EMP' order by table_name;

insert into emp(empno, ename) values(7369, 'choi');

desc emp;

-- unique : 중복데이터 허용안함
alter table salgrade add constraint salgrade_uk_grade unique(grade);
insert into salgrade values(6,0,699);
insert into salgrade values(5,3001,9999);
delete from salgrade where grade=6;
select * from salgrade;

-- number(7,2) :  9999.99까지 저장 가능
-- 급여는 800~6000까지 허용
-- check : 데이터의 범위를 설정하는 제약조건
alter table emp add constraint emp_ck_sal check(sal between 800 and 6000);
insert into emp(empno, ename, sal) values(2222, 'kim', 5500);

-- 10,20,30,40,50,60,70,80,90
alter table dept add constraint dept_ck_deptno check(deptno in(10,20,30,40,50,60,70,80,90));
insert into dept values(50,'기획부','강남구');
select * from user_constraints;
select * from dept;
desc dept;

-- 외래키
insert into emp(empno, ename, deptno) values(1234,'choi',60);

-- emp테이블의 deptno가 dept테이블의 deptno를 참조한다.
-- no action : 참조되고 있는 레코드는 삭제하지 않는다.
-- on delete cascade : 참조되는 레코드를 지운다.
alter table emp add constraint emp_fk_deptno foreign key(deptno) references dept(deptno);
alter table dept add constraint dept_pk_deptno primary key(deptno);

commit;

select * from emp;
select * from user_constraints;

delete from emp where ename='kim';

delete from dept where deptno=50;
delete from dept where deptno=20;

-- 제약조건 삭제
alter table dept drop constraint dept_ck_deptno;
insert into emp(empno, ename, deptno) values(555,'gang',15);
insert into dept values(15,'인사부','송파구');

-- commit
-- rollback
-- savepoint
select * from dept;
insert into dept values(1,'기획부','영등포구');
savepoint a;
insert into dept values(2,'총무부','구로구');
update dept set loc='seoul';
rollback to a;

