-- cursor

select e.job, avg(e.sal) from emp e join dept d
on e.deptno=d.deptno and e.deptno=30 group by e.job;

-- 부서코드를 입력하여 해당부서의 업무별 급여합, 급여평균, 사원수, 최고급여, 최저급여를 구하는 프로시저를 작성
create or replace procedure emp_info(i_deptno in emp.deptno%type)
is
    --1. 커서 선언하기 : 쿼리문 작성
    cursor emp_result is
        select e.job, sum(e.sal) sal_sum, round(avg(e.sal),2) sal_avg, count(e.empno) cnt,
        max(e.sal) sal_max, min(e.sal) sal_min
        from emp e  where e.deptno=i_deptno group by e.job;
    -- 선택한 값을 저장할 변수 선언
    v_job emp.job%type;
    v_sum number;
    v_avg number;
    v_cnt number;
    v_max number;
    v_min number;
begin
    --2. 커서 open
    open emp_result;
    --3. fetch
    loop
        fetch emp_result into v_job,v_sum, v_avg, v_cnt, v_max, v_min;
        exit when emp_result%NOTFOUND;
        dbms_output.put_line(v_job||', '||v_sum||', '||v_avg||', '||v_cnt||', '||v_max||', '||v_min);
    end loop;
    --4. close
    close emp_result;
    dbms_output.put_line('실행완료.');
end;

execute emp_info(30);

select * from user_source;






