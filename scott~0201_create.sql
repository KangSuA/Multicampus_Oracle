-- 테이블 생성
create table member(
    no number(3) primary key,
    username varchar2(30) not null,
    tel varchar2(15) not null,
    email varchar2(30),
    addr varchar2(100),
    writedate date default sysdate -- 날짜를 등록하지 않으면 현재날짜를 등록
);

insert into member values(1,'홍길동','010-1234-1234','gggg@naver.com','서울시 강남구',sysdate);
insert into member(no,username,tel) values(3,'이순신','010-9999-8888');
select * from member;
select * from tab;
desc member;

-- 우리집에 있는 책 정보를 보관할 테이블 설계
create table library(
    no number(4) primary key,
    title varchar2(200) not null,
    author varchar2(50) not null,
    publisher varchar2(50) not null,
    genre varchar2(20),
    purchasedate date default sysdate
);

-- 생성된 테이블을 수정, 삭제
select * from tab;

desc member;
select * from member;

-- member 테이블에 필드 추가하기
-- 취미필드 추가(not null은 넣을 수 없음)
alter table member add (hobby varchar2(30));
-- 필드 수정(필드에 값이 존재할 때 30자리에서 15자리 -> 기존의 데이터가 15자 이상이면 불가능)
alter table member modify (email varchar2(50));
-- 필드 삭제
alter table member drop column email;

-- 테이블 삭제
drop table member;
drop table emp2;
drop table emp3;
drop table emp4;
drop table emp5 purge; --purge : 찌꺼기 제거됨

-- [과제물] 우리집에 있는 책정보를 보관할 테이블을 설계한다.
-- 책정보
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

-- 테이블구조
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

