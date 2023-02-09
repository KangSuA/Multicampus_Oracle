-- cmd창에 입력한 내용들!!!!
sqlplus sys as sysdba;

-- 계정목록
select username from dba_users;
select username from all_users;

-- 계정 잠금 하기
create user sam_id identified by 1234;
grant conncet, resource to sam_id;
conn sam_id/1234;
create table aaaa(no number);

conn sys as sysdba;
set linesize 150;
set pagesize 30;
-- account_status : 계정 잠금 여부 확인
select username, account_status from dba_users;
-- 계정 잠금설정(lock)  : 관리자 계정에서 설정해야함.
alter user sam_id account lock;
conn sam_id/234; -- 접근 불가
-- 계정 잠금해제(unlock)
conn sys as sysdba;
alter user sam_id account unlock;
conn sam_id/1234;
select * from tab;

conn sys as sysdba;
select username, account_status from dba_users;

alter user hr account unlock; -- 연습용 계정
-- 비밀번호 설정(이미 만들어진 계정)
alter user sam_id identified by 5678;
conn sam_id/1234; -- 오류남

alter user hr identified by 1234;
conn hr/1234;
select * from tab;
select *  from employees;

conn sys as sysdba;
select username, account_status from dba_users;

-- sam_id 계정 삭제
conn sam_id/5678;
drop table aaaa;
conn sys as sysdba;
drop user sam_id;





















