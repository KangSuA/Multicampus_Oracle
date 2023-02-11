-- pl/sql

set serveroutput on; -- ���α׷� ���� �� �ּ� �ѹ��� �����ؾ� ��¹� Ȯ�� ����
-- �͸��� block
declare
    -- ��������
    i_name varchar2(10);
begin
    i_name := 'ȫ�浿'; -- ������ �� ����
    dbms_output.put_line('Hello Oracle!!!'); -- ��ũ��Ʈ�� ���
    dbms_output.put_line('�̸�:'||i_name);
end;

-- emp ���̺��� ���ʺ�ȣ, �����, �޿��� �����Ͽ� ����ϴ� ���ν��� ����
-- in �Ķ���� : �ܺο��� ���ν��� ���� ���� �־��ִ� ���� ����� ���
-- %type : ���̺��� Ư�� �ʵ�� ���� ������������ �����Ѵ�.
create or replace procedure emp_select(i_empno in emp.empno%type)
is
-- ��������, record....
    s_empno emp.empno%type;
    s_ename emp.ename%type;
    s_sal emp.sal%type;
begin
-- ���ڵ带 �����Ͽ� into������ ����� ������ �������ش�.
    select empno, ename, sal into s_empno, s_ename, s_sal from emp where empno=i_empno;
    dbms_output.put_line('�����ȣ='||s_empno);
    dbms_output.put_line('�����='||s_ename);
    dbms_output.put_line('�޿�='||s_sal);
end;

select * from user_source;

-- ���ν��� �����ϱ�
execute emp_select(7788);

-- %rowtype : ���̺��� ��� �ʵ�� ���� ������������ ���� �����ϱ�
-- ����� �Է¹޾� �����ȣ, �����, ����, �޿�,�μ���ȣ�� �����Ͽ� ����ϴ� ���ν����� �ۼ��϶�.
create or replace procedure emp_row(i_empno in number)
is
-- select�� �����͸� ���� ���� ����
    record_emp emp%rowtype;
    record_dept dept%rowtype;
begin
    select empno, ename, job, sal, emp.deptno, dname
    into record_emp.empno, record_emp.ename, record_emp.job, record_emp.sal, record_emp.deptno, record_dept.dname
    from emp join dept on emp.deptno=dept.deptno and empno=i_empno;
    
    dbms_output.put_line('empno='||record_emp.empno);
    dbms_output.put_line('ename='||record_emp.ename);
    dbms_output.put_line('job='||record_emp.job);
    dbms_output.put_line('sal='||record_emp.sal);
    dbms_output.put_line('deptno='||record_emp.deptno);
    dbms_output.put_line('dname='||record_dept.dname);
end;

select * from user_source where name='EMP_ROW';
 
execute emp_row(7900);

-- Exception ó���ϱ�
-- ������� �Է¹޾� �ش����� �����ȣ, �����, �޿��� �����ϴ� ���ν���
create or replace procedure emp_ename(i_ename in emp.ename%type)
is
    o_empno emp.empno%type; -- o_empno number;
    o_ename emp.ename%type;
    o_sal emp.sal%type;
begin
    select empno, ename, sal into o_empno, o_ename, o_sal
    from emp where ename=upper(i_ename);
    
    dbms_output.put_line(o_empno || ', ' || o_ename || ', ' || o_sal);
    
    exception
        when NO_DATA_FOUND then -- ������ ���ڵ尡 ������
            dbms_output.put_line(i_ename || '����� �����ϴ�.');
        when TOO_MANY_ROWS then -- ������ ���ڵ尡 2�� �̻��϶�
            dbms_output.put_line(i_ename || '2�� �̻��Դϴ�.');
        when OTHERS then
            dbms_output.put_line('�׿� ���ܹ߻�...');
end;

execute emp_ename('james');
execute emp_ename('gildong');
execute emp_ename('ford');

insert into emp(empno, ename, sal, deptno) values(8888,'FORD',4000,40);
COMMIT;
select * from emp;

-- in parameter : ���ν������� ������ �־��ִ� ��
-- out parameter : ���ν��������� ������ �����͸� ��������
-- in out parameter : ���� ���� in�� out�� ó���ϴ� ����

-- �����ȣ, �����, �޿�, �μ���ȣ�� �Է¹޾� �������ϴ� ���ν��� �ۼ��ϱ�
create or replace procedure emp_insert(i_empno in emp.empno%type, i_ename in emp.ename%type,
                                        i_sal in number, i_deptno in emp.deptno%type)
is

begin
    insert into emp(empno, ename, sal, deptno) values(i_empno, i_ename, i_sal, i_deptno);
    commit;
    dbms_output.put_line(i_ename || '����� ��ϵǾ����ϴ�.');
end;

-- connect, conn
-- execute, exec
execute emp_insert(3333,'PARK',5200,10);

-- �����ȣ�� �Է¹޾� �̸�, ����, �׺��� �����ϴ� ���ν��� �����
create or replace procedure emp_list(i_empno in emp.empno%type,
                                    o_ename out emp.ename%type, o_job out emp.job%type, o_sal out emp.sal%type)
is
begin
    select ename, job, sal into o_ename, o_job, o_sal
    from emp where empno=i_empno;
end;

-- ��������
variable p_ename varchar2(20);
variable p_job varchar2(20);
variable p_sal number;
exec emp_list(7788,:p_ename,:p_job,:p_sal);

print p_ename;
print p_job;
print p_sal;

-- in put parameter
-- �����ȣ, �����, �μ��ڵ�, �޿��� �Է¹޾� ����� ����ϴ� ���ν��� �����
create or replace procedure emp_in(i_empno emp.empno%type, i_ename emp.ename%type,i_deptno emp.deptno%type, i_sal emp.sal%type)
is
begin
    insert into emp(empno, ename, sal, hiredate, deptno)
    values(i_empno, i_ename, i_sal, sysdate, i_deptno);
    dbms_output.put_line(i_ename||'����� ��ϵǾ����ϴ�.');
end;

exec emp_in(6666,'LEE',40,2500);

-- �����ȣ�� �޿��λ����� �Է¹޾� �ش��� �޿��� �����ϴ� ���ν��������
create or replace procedure emp_sal_update(i_empno emp.empno%type, i_rate number)
is
    r_emp emp%rowtype;
begin
    update emp set sal = sal+(sal*(i_rate/100))
    where empno = i_empno;
    dbms_output.put_line('������Ʈ �Ǿ����ϴ�.');
    commit;
    
    select empno, ename, sal into r_emp.empno, r_emp.ename, r_emp.sal
    from emp where empno = i_empno;
    dbms_output.put_line(r_emp.empno||'/'||r_emp.ename||'/'||r_emp.sal);
end;

exec emp_sal_update(7777,10);

-- �����ȣ�� �Է¹޾� �ش� ��� �����ϱ�
create or replace procedure emp_del(i_empno emp.empno%type)
is
begin
    delete from emp where empno=i_empno;
    dbms_output.put_line(i_empno||'����� �����Ǿ����ϴ�.');
    commit;
end;

exec emp_del(5555);

-- TYPE �����
create or replace procedure emp_search(i_empno emp.empno%type)
is
    -- ���ڵ��� ������ Ÿ�� �����
    TYPE emp_record_type IS RECORD(
        v_empno emp.empno%type,
        v_ename emp.ename%type,
        v_job emp.job%type,
        v_mgr emp.mgr%type,
        v_hiredate emp.hiredate%type,
        v_sal emp.sal%type,
        v_comm emp.comm%type,
        v_deptno emp.deptno%type
    );
    --��������
    e_record emp_record_type;
begin
    select * into e_record
    from emp where empno=i_empno;
    dbms_output.put_line(e_record.v_empno||', '||e_record.v_ename||', '||e_record.v_hiredate||', '||e_record.v_sal);
end;


exec emp_search(7521);

-- �������̺�
-- ������, ���ǻ��, ����, �۰���, ī�װ��� �Է¹޾� å�� ����ϴ� ���ν����� �����϶�.
-- execute('ȫ�浿��','�Ѻ��̵��',1500,'ȫ�浿' '����');
desc books;
insert into author_tbl(author_code, author) values(30,'�̼���');
insert into pub_tbl(pub_code,pub_name,pub_tel) values(10,'�Ѻ��̵��','010-1111-2222');

select * from books;

create or replace procedure book_in(i_bname books.bookname%type, i_pname pub_tbl.pub_name%type,
i_price books.price%type, i_aname author_tbl.author%type, i_category books.category%type)
is
    v_pcode pub_tbl.pub_code%type;
    v_acode author_tbl.author_code%type;
begin
    select pub_code into v_pcode
    from pub_tbl where pub_name=i_pname;
    select author_code into v_acode
    from author_tbl where author=i_aname;
    insert into books(isbn,bookname,price,category,pub_code,author_code)
    values(book_sq.nextval,i_bname,i_price,i_category,v_pcode,v_acode);
    commit;
    exception
        when others then
            dbms_output.put_line('�߸��� ������ �ֽ��ϴ�. å�� ������� �ʾҽ��ϴ�.');
end;

-- subquery�� �̿��ϴ� ���
create or replace procedure book_in(i_bname books.bookname%type, i_pname pub_tbl.pub_name%type,
i_price books.price%type, i_aname author_tbl.author%type, i_category books.category%type)
is
begin
    insert into books(isbn, bookname, price, category, pub_code, author_code)
    values(book_sq.nextval, i_bookname, i_price, i_category,
    (select pub_code from pub_tbl where pub_name=i_pname),
    (select author_code from author_tbl where author=i_aname));
    exception
        when others then
            dbms_output.put_line('���ܹ߻�');
end;

execute book_in('ȫ�浿��','�Ѻ��̵��',1500,'ȫ�浿','����');

-- if��
-- �����ȣ�� �ش��ϴ� ����� �����, �μ�����  ����ϴ� ���ν���
create or replace procedure emp_if(i_empno in number)
is
    s_ename emp.ename%type;
    s_deptno emp.deptno%type;
    
    s_dname varchar2(30);
begin
    select ename, deptno into s_ename, s_deptno from emp where empno=i_empno;
    if s_deptno=10 then
        s_dname := 'ȸ��μ�';
    elsif s_deptno=20 then
        s_dname := '�����μ�';
    elsif s_deptno=30 then
        s_dname := '�����μ�';
    elsif s_deptno=40 then
        s_dname := '��μ�';
    else
        s_dname := '���� �μ��Դϴ�.';
    end if;
    
    dbms_output.put_line(s_ename||','||s_dname);
end;

exec emp_if(7902);

------------------
-- �μ��ڵ带 �Է¹޾� �ش� �μ��� ����� ��� �����϶�.
create or replace procedure emp_ename_sal(i_deptno emp.deptno%type)
is
    -- �迭 ����
    -- ������� ������ �迭�� ����
    type ename_arr is table of emp.ename%type index by binary_integer;
    -- �޿��� ������ �迭�� ����
    type sal_arr is table of emp.sal%type index by binary_integer;
    -- �Ի����� ������ �迭�� ����
    type hiredate_arr is table of emp.hiredate%type index by binary_integer;
    
    -- �迭�� ���� ����
    s_ename ename_arr;
    s_sal sal_arr;
    s_hiredate hiredate_arr;
    
    idx integer := 0;
begin
    
    for e in (select ename, sal, hiredate from emp where deptno=i_deptno) loop
        idx := idx+1;
        s_ename(idx) := e.ename;
        s_sal(idx) := e.sal;
        s_hiredate(idx) := e.hiredate;
    end loop;
    -- �迭�� �ִ� ������� ����ϱ�
    for i in 1..idx loop -- idptj idx���� 1�� ����
        dbms_output.put_line(s_ename(i) || ', ' || s_sal(i) || ', ' || s_hiredate(i));
    end loop;
end;

execute emp_ename_sal(20);

-- loop��
-- exit ������ ���϶� ����ȴ�.
create or replace procedure emp_loop_insert(i_start in number, i_deptno in emp.deptno%type)
is
    i number;
begin
    i := i_start;
    loop
        insert into emp(empno, ename, deptno) values(i, 'loop'||i, i_deptno);
        i:=i+1;
        exit when i>i_start+5;-- ������ ���̸� ����
    end loop;
    dbms_output.put_line('����� ����Ͽ����ϴ�.');
end;

execute emp_loop_insert(1000,10);

-- while loop��
-- ������ ���϶� �ݺ�����
create or replace procedure emp_while_insert(i_max number, i_deptno emp.deptno%type)
is
    v_i number;
begin
    v_i := i_max-10;
    
    while v_i<i_max loop -- ���϶� �ݺ�
        insert into emp(empno, ename, hiredate, deptno)
        values(v_i, 'while'||v_i, sysdate, i_deptno);
        exit when v_i>=i_max-5;
        v_i := v_i+1;
    end loop;
end;
execute emp_while_insert(3000,20);
rollback;
-- ���ν��� �����
drop procedure emp_ename_sal;

-- �������� �Է¹޾� �ش����� �����ȣ, �����, ������, �޿��� ����ϴ� ���ν��� �����
-- execute ���ν����� ('manager');
create or replace procedure emp_job_sel(i_job emp.job%type)
is
begin
    for e in (select * from emp where job=upper(i_job)) loop
        dbms_output.put_line(e.empno||', '||e.ename||', '||e.job||', '||e.sal);
    end loop;
end;

execute emp_job_sel('salesman');

select * from user_source;
select * from emp;









