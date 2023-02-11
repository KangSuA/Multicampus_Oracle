-- cursor

select e.job, avg(e.sal) from emp e join dept d
on e.deptno=d.deptno and e.deptno=30 group by e.job;

-- �μ��ڵ带 �Է��Ͽ� �ش�μ��� ������ �޿���, �޿����, �����, �ְ�޿�, �����޿��� ���ϴ� ���ν����� �ۼ�
create or replace procedure emp_info(i_deptno in emp.deptno%type)
is
    --1. Ŀ�� �����ϱ� : ������ �ۼ�
    cursor emp_result is
        select e.job, sum(e.sal) sal_sum, round(avg(e.sal),2) sal_avg, count(e.empno) cnt,
        max(e.sal) sal_max, min(e.sal) sal_min
        from emp e  where e.deptno=i_deptno group by e.job;
    -- ������ ���� ������ ���� ����
    v_job emp.job%type;
    v_sum number;
    v_avg number;
    v_cnt number;
    v_max number;
    v_min number;
begin
    --2. Ŀ�� open
    open emp_result;
    --3. fetch
    loop
        fetch emp_result into v_job,v_sum, v_avg, v_cnt, v_max, v_min;
        exit when emp_result%NOTFOUND;
        dbms_output.put_line(v_job||', '||v_sum||', '||v_avg||', '||v_cnt||', '||v_max||', '||v_min);
    end loop;
    --4. close
    close emp_result;
    dbms_output.put_line('����Ϸ�.');
end;

execute emp_info(30);

select * from user_source;






