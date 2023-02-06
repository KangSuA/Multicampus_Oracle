/* 책정보 */
CREATE TABLE books (
	isbn NUMBER(5) NOT NULL, /* 고유번호 */
	bookname VARCHAR2(100) NOT NULL, /* 책이름 */
	price NUMBER(7) NOT NULL, /* 책가격 */
	pub_date DATE, /* 출판일 */
	category VARCHAR2(30) NOT NULL, /* 카테코리 */
	pub_code NUMBER(5) NOT NULL, /* 출판사코드 */
	author_code NUMBER(5) NOT NULL, /* 작가코드 */
	writedate DATE DEFAULT sysdate /* 등록일 */
);

ALTER TABLE books
	ADD
		CONSTRAINT PK_books
		PRIMARY KEY (
			isbn
		);

/* 출판사테이블 */
CREATE TABLE pub_tbl (
	pub_code NUMBER(5) NOT NULL, /* 출판사코드 */
	pub_name VARCHAR2(100) NOT NULL, /* 출판사명 */
	pub_ceo VARCHAR2(30), /* 출판사대표 */
	pub_tel VARCHAR2(15) NOT NULL, /* 출판사연락처 */
	pub_fax VARCHAR2(15), /* 출판사팩스 */
	pub_addr VARCHAR2(300), /* 출판사주소 */
	writedate DATE DEFAULT sysdate /* 등록일 */
);

ALTER TABLE pub_tbl
	ADD
		CONSTRAINT PK_pub_tbl
		PRIMARY KEY (
			pub_code
		);

/* 작가테이블 */
CREATE TABLE author_tbl (
	author_code NUMBER(5) NOT NULL, /* 작가코드 */
	author VARCHAR2(30) NOT NULL, /* 작가명 */
	debut VARCHAR2(100), /* 데뷔작 */
	debut_year DATE, /* 데뷔년도 */
	email VARCHAR2(50), /* 이메일 */
	homepage VARCHAR2(100), /* 홈페이지 */
	writedate DATE DEFAULT sysdate /* 등록일 */
);

ALTER TABLE author_tbl
	ADD
		CONSTRAINT PK_author_tbl
		PRIMARY KEY (
			author_code
		);