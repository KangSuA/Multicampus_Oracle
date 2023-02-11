-- pl/sql

set serveroutput on; -- 프로그램 실행 후 최소 한번은 실행해야 출력문 확인 가능
-- 익명의 block
declare
    -- 변수선언
    i_name varchar2(10);
begin
    i_name := '홍길동'; -- 변수에 값 대입
    dbms_output.put_line('Hello Oracle!!!'); -- 스크립트에 출력
    dbms_output.put_line('이름:'||i_name);
end;

-- emp 테이블에서 사우너변호, 사원명, 급여를 선택하여 출력하는 프로시저 생성
-- in 파라미터 : 외부에서 프로시저 내로 값을 넣어주는 변수 선언시 사용
-- %type : 테이블내의 특정 필드와 같은 데이터형으로 선언한다.
create or replace procedure emp_select(i_empno in emp.empno%type)
is
-- 변수선언, record....
    s_empno emp.empno%type;
    s_ename emp.ename%type;
    s_sal emp.sal%type;
begin
-- 레코드를 선택하여 into다음에 명시한 변수에 대입해준다.
    select empno, ename, sal into s_empno, s_ename, s_sal from emp where empno=i_empno;
    dbms_output.put_line('사원번호='||s_empno);
    dbms_output.put_line('사원명='||s_ename);
    dbms_output.put_line('급여='||s_sal);
end;

select * from user_source;

-- 프로시저 실행하기
execute emp_select(7788);

-- %rowtype : 테이블내의 모든 필드와 같은 데이터형으로 변수 선언하기
-- 사번을 입력받아 사원번호, 사원명, 업무, 급여,부서번호를 선택하여 출력하는 프로시저를 작성하라.
create or replace procedure emp_row(i_empno in number)
is
-- select한 데이터를 담을 변수 선언
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

-- Exception 처리하기
-- 사원명을 입력받아 해당사원의 사원번호, 사원명, 급여를 선택하는 프로시저
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
        when NO_DATA_FOUND then -- 선택한 레코드가 없을때
            dbms_output.put_line(i_ename || '사원이 없습니다.');
        when TOO_MANY_ROWS then -- 선택한 레코드가 2행 이상일때
            dbms_output.put_line(i_ename || '2명 이상입니다.');
        when OTHERS then
            dbms_output.put_line('그외 예외발생...');
end;

execute emp_ename('james');
execute emp_ename('gildong');
execute emp_ename('ford');

insert into emp(empno, ename, sal, deptno) values(8888,'FORD',4000,40);
COMMIT;
select * from emp;

-- in parameter : 프로시저내로 데이터 넣어주는 것
-- out parameter : 프로시저내에서 밖으로 데이터를 내보내기
-- in out parameter : 같은 변수 in과 out을 처리하는 변수

-- 사원번호, 사원명, 급여, 부서번호를 입력받아 사원등록하는 프로시저 작성하기
create or replace procedure emp_insert(i_empno in emp.empno%type, i_ename in emp.ename%type,
                                        i_sal in number, i_deptno in emp.deptno%type)
is

begin
    insert into emp(empno, ename, sal, deptno) values(i_empno, i_ename, i_sal, i_deptno);
    commit;
    dbms_output.put_line(i_ename || '사원이 등록되었습니다.');
end;

-- connect, conn
-- execute, exec
execute emp_insert(3333,'PARK',5200,10);

-- 사원번호를 입력받아 이름, 업무, 그병를 선택하는 프로시저 만들기
create or replace procedure emp_list(i_empno in emp.empno%type,
                                    o_ename out emp.ename%type, o_job out emp.job%type, o_sal out emp.sal%type)
is
begin
    select ename, job, sal into o_ename, o_job, o_sal
    from emp where empno=i_empno;
end;

-- 변수선언
variable p_ename varchar2(20);
variable p_job varchar2(20);
variable p_sal number;
exec emp_list(7788,:p_ename,:p_job,:p_sal);

print p_ename;
print p_job;
print p_sal;

-- in put parameter
-- 사원번호, 사원명, 부서코드, 급여를 입력받아 사원을 등록하는 프로시저 만들기
create or replace procedure emp_in(i_empno emp.empno%type, i_ename emp.ename%type,i_deptno emp.deptno%type, i_sal emp.sal%type)
is
begin
    insert into emp(empno, ename, sal, hiredate, deptno)
    values(i_empno, i_ename, i_sal, sysdate, i_deptno);
    dbms_output.put_line(i_ename||'사원이 등록되었습니다.');
end;

exec emp_in(6666,'LEE',40,2500);

-- 사원번호와 급여인상율을 입력받아 해당사원 급여를 수정하는 프로시저만들기
create or replace procedure emp_sal_update(i_empno emp.empno%type, i_rate number)
is
    r_emp emp%rowtype;
begin
    update emp set sal = sal+(sal*(i_rate/100))
    where empno = i_empno;
    dbms_output.put_line('업데이트 되었습니다.');
    commit;
    
    select empno, ename, sal into r_emp.empno, r_emp.ename, r_emp.sal
    from emp where empno = i_empno;
    dbms_output.put_line(r_emp.empno||'/'||r_emp.ename||'/'||r_emp.sal);
end;

exec emp_sal_update(7777,10);

-- 사원번호를 입력받아 해당 사원 삭제하기
create or replace procedure emp_del(i_empno emp.empno%type)
is
begin
    delete from emp where empno=i_empno;
    dbms_output.put_line(i_empno||'사원이 삭제되었습니다.');
    commit;
end;

exec emp_del(5555);

-- TYPE 만들기
create or replace procedure emp_search(i_empno emp.empno%type)
is
    -- 레코드형 데이터 타입 만들기
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
    --변수선언
    e_record emp_record_type;
begin
    select * into e_record
    from emp where empno=i_empno;
    dbms_output.put_line(e_record.v_empno||', '||e_record.v_ename||', '||e_record.v_hiredate||', '||e_record.v_sal);
end;


exec emp_search(7521);

-- 도서테이블
-- 도서명, 출판사명, 가격, 작가명, 카테고리를 입력받아 책을 등록하는 프로시저를 생성하라.
-- execute('홍길동전','한빛미디어',1500,'홍길동' '고전');
desc books;
insert into author_tbl(author_code, author) values(30,'이순신');
insert into pub_tbl(pub_code,pub_name,pub_tel) values(10,'한빛미디어','010-1111-2222');

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
            dbms_output.put_line('잘못된 정보가 있습니다. 책을 등록하지 않았습니다.');
end;

-- subquery를 이용하는 방법
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
            dbms_output.put_line('예외발생');
end;

execute book_in('홍길동전','한빛미디어',1500,'홍길동','고전');

-- if문
-- 사원번호에 해당하는 사원의 사원명, 부서명을  출력하는 프로시저
create or replace procedure emp_if(i_empno in number)
is
    s_ename emp.ename%type;
    s_deptno emp.deptno%type;
    
    s_dname varchar2(30);
begin
    select ename, deptno into s_ename, s_deptno from emp where empno=i_empno;
    if s_deptno=10 then
        s_dname := '회계부서';
    elsif s_deptno=20 then
        s_dname := '연구부서';
    elsif s_deptno=30 then
        s_dname := '영업부서';
    elsif s_deptno=40 then
        s_dname := '운영부서';
    else
        s_dname := '없는 부서입니다.';
    end if;
    
    dbms_output.put_line(s_ename||','||s_dname);
end;

exec emp_if(7902);

------------------
-- 부서코드를 입력받아 해당 부서의 사원을 모두 선택하라.
create or replace procedure emp_ename_sal(i_deptno emp.deptno%type)
is
    -- 배열 생성
    -- 사원명을 보관할 배열형 생성
    type ename_arr is table of emp.ename%type index by binary_integer;
    -- 급여를 보관할 배열형 생성
    type sal_arr is table of emp.sal%type index by binary_integer;
    -- 입사일을 보관할 배열형 생성
    type hiredate_arr is table of emp.hiredate%type index by binary_integer;
    
    -- 배열형 변수 선언
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
    -- 배열에 있는 사원정보 출력하기
    for i in 1..idx loop -- idptj idx까지 1씩 증가
        dbms_output.put_line(s_ename(i) || ', ' || s_sal(i) || ', ' || s_hiredate(i));
    end loop;
end;

execute emp_ename_sal(20);

-- loop문
-- exit 조건이 참일때 종료된다.
create or replace procedure emp_loop_insert(i_start in number, i_deptno in emp.deptno%type)
is
    i number;
begin
    i := i_start;
    loop
        insert into emp(empno, ename, deptno) values(i, 'loop'||i, i_deptno);
        i:=i+1;
        exit when i>i_start+5;-- 조건이 참이면 종료
    end loop;
    dbms_output.put_line('사원을 등록하였습니다.');
end;

execute emp_loop_insert(1000,10);

-- while loop문
-- 조건이 참일때 반복실행
create or replace procedure emp_while_insert(i_max number, i_deptno emp.deptno%type)
is
    v_i number;
begin
    v_i := i_max-10;
    
    while v_i<i_max loop -- 참일때 반복
        insert into emp(empno, ename, hiredate, deptno)
        values(v_i, 'while'||v_i, sysdate, i_deptno);
        exit when v_i>=i_max-5;
        v_i := v_i+1;
    end loop;
end;
execute emp_while_insert(3000,20);
rollback;
-- 프로시저 지우기
drop procedure emp_ename_sal;

-- 담당업무를 입력받아 해당사원의 사원번호, 사원명, 담당업무, 급여를 출력하는 프로시저 만들기
-- execute 프로시저명 ('manager');
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









