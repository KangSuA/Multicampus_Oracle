-- Ʈ���� : insert, update, delete���� ����Ǵ� ���������� ����Ǵ� ���ν����̴�.

select * from dept;

create or replace trigger dept_dname_trigger
    before -- ������ ���� ��
    update on dept
    for each row -- ������� Ʈ���� ����, �����ϸ� ������� Ʈ���Ű� �ȴ�.
begin 
    dbms_output.put_line('�μ��� ������ ������ : '|| :old.dname);
    dbms_output.put_line('�μ��� ������ ������ : '|| :new.dname);
end;
-- Ʈ���� Ȯ��
select * from all_triggers;
-- dept���̺��� �μ��� ����
select * from dept;
update dept set dname='�ѹ���' where deptno=15;

-- emp���̺��� insert, update�� �����ϱ� ��, �޿��� ����� �����ִ� Ʈ���� �����
create or replace trigger sum_trigger
    before
    insert or update on emp
    --for each row
declare
   avg_sal number;
begin
    select round(avg(sal),2) into avg_sal from emp;
    dbms_output.put_line('�޿��� ��� : '||avg_sal);
end;
select avg(sal) from emp; --2706.578947368421052631578947368421052632

insert into emp(empno, ename, sal, deptno) values(5100,'aaaa', 5000,40);
select avg(sal) from emp; --2821.25
update emp set sal = sal*1.02;
delete from emp where sal is null;
rollback;
select * from emp;
-- Ʈ���� ����
drop trigger sum_trigger;
drop trigger dept_dname_trigger;





