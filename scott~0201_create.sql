-- ���̺� ����
create table member(
    no number(3) primary key,
    username varchar2(30) not null,
    tel varchar2(15) not null,
    email varchar2(30),
    addr varchar2(100),
    writedate date default sysdate -- ��¥�� ������� ������ ���糯¥�� ���
);

insert into member values(1,'ȫ�浿','010-1234-1234','gggg@naver.com','����� ������',sysdate);
insert into member(no,username,tel) values(3,'�̼���','010-9999-8888');
select * from member;
select * from tab;
desc member;

-- �츮���� �ִ� å ������ ������ ���̺� ����
create table library(
    no number(4) primary key,
    title varchar2(200) not null,
    author varchar2(50) not null,
    publisher varchar2(50) not null,
    genre varchar2(20),
    purchasedate date default sysdate
);

-- ������ ���̺��� ����, ����
select * from tab;

desc member;
select * from member;

-- member ���̺� �ʵ� �߰��ϱ�
-- ����ʵ� �߰�(not null�� ���� �� ����)
alter table member add (hobby varchar2(30));
-- �ʵ� ����(�ʵ忡 ���� ������ �� 30�ڸ����� 15�ڸ� -> ������ �����Ͱ� 15�� �̻��̸� �Ұ���)
alter table member modify (email varchar2(50));
-- �ʵ� ����
alter table member drop column email;

-- ���̺� ����
drop table member;
drop table emp2;
drop table emp3;
drop table emp4;
drop table emp5 purge; --purge : ��� ���ŵ�

-- [������] �츮���� �ִ� å������ ������ ���̺��� �����Ѵ�.
-- å����
create table books(
    isbn number(10) primary key,
    bookname varchar2(100) not null,
    price number(7) not null,
    pub_date date,
    category varchar2(30) not null,
    pub_code number(5) not null,
    author_code number(5) not null,
    writedate date default sysdate
);

create table pub_tbl (
    pub_code number(5) primary key,
    pub_name varchar2(50) not null,
    pub_ceo varchar2(30),
    pub_tel varchar2(15) not null,
    pub_fax varchar2(15),
    pub_Addr varchar2(300),
    writedate date default sysdate
);

create table author_tbl (
    author_code number(5) primary key,
    author varchar2(30) not null,
    debut varchar2(100),
    debut_year date,
    email varchar2(100),
    homepage varchar2(100),
    writedate date default sysdate
);

drop table books;
drop table pub_tbl;
drop table author_tbl;

-- ���̺���
desc emp;
desc dept;
desc salgrade;

insert into emp(empno, ename) values(1234,'hong');
insert into emp(ename, sal) values('park', 3500); --error

alter table emp modify (ename varchar2(20) not null);

insert into emp(empno, ename) values(7934, 'lee');

delete from emp where empno=1234;

rollback;
commit;

select * from emp;

