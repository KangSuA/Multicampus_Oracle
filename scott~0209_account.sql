-- cmdâ�� �Է��� �����!!!!
sqlplus sys as sysdba;

-- �������
select username from dba_users;
select username from all_users;

-- ���� ��� �ϱ�
create user sam_id identified by 1234;
grant conncet, resource to sam_id;
conn sam_id/1234;
create table aaaa(no number);

conn sys as sysdba;
set linesize 150;
set pagesize 30;
-- account_status : ���� ��� ���� Ȯ��
select username, account_status from dba_users;
-- ���� ��ݼ���(lock)  : ������ �������� �����ؾ���.
alter user sam_id account lock;
conn sam_id/234; -- ���� �Ұ�
-- ���� �������(unlock)
conn sys as sysdba;
alter user sam_id account unlock;
conn sam_id/1234;
select * from tab;

conn sys as sysdba;
select username, account_status from dba_users;

alter user hr account unlock; -- ������ ����
-- ��й�ȣ ����(�̹� ������� ����)
alter user sam_id identified by 5678;
conn sam_id/1234; -- ������

alter user hr identified by 1234;
conn hr/1234;
select * from tab;
select *  from employees;

conn sys as sysdba;
select username, account_status from dba_users;

-- sam_id ���� ����
conn sam_id/5678;
drop table aaaa;
conn sys as sysdba;
drop user sam_id;





















