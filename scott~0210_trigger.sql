-- 트리거 : insert, update, delete문이 실행되는 묵시적으로 실행되는 프로시저이다.

select * from dept;

create or replace trigger dept_dname_trigger
    before -- 쿼리문 실행 전
    update on dept
    for each row -- 행단위로 트리거 실행, 생략하면 문장단위 트리거가 된다.
begin 
    dbms_output.put_line('부서명 변경전 데이터 : '|| :old.dname);
    dbms_output.put_line('부서명 변경후 데이터 : '|| :new.dname);
end;
-- 트리거 확인
select * from all_triggers;
-- dept테이블의 부서명 변경
select * from dept;
update dept set dname='총무부' where deptno=15;

-- emp테이블에서 insert, update를 실행하기 전, 급여의 평균을 구해주는 트리거 만들기
create or replace trigger sum_trigger
    before
    insert or update on emp
    --for each row
declare
   avg_sal number;
begin
    select round(avg(sal),2) into avg_sal from emp;
    dbms_output.put_line('급여의 평균 : '||avg_sal);
end;
select avg(sal) from emp; --2706.578947368421052631578947368421052632

insert into emp(empno, ename, sal, deptno) values(5100,'aaaa', 5000,40);
select avg(sal) from emp; --2821.25
update emp set sal = sal*1.02;
delete from emp where sal is null;
rollback;
select * from emp;
-- 트리거 삭제
drop trigger sum_trigger;
drop trigger dept_dname_trigger;





