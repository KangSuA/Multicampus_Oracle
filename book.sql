/* å���� */
CREATE TABLE books (
	isbn NUMBER(5) NOT NULL, /* ������ȣ */
	bookname VARCHAR2(100) NOT NULL, /* å�̸� */
	price NUMBER(7) NOT NULL, /* å���� */
	pub_date DATE, /* ������ */
	category VARCHAR2(30) NOT NULL, /* ī���ڸ� */
	pub_code NUMBER(5) NOT NULL, /* ���ǻ��ڵ� */
	author_code NUMBER(5) NOT NULL, /* �۰��ڵ� */
	writedate DATE DEFAULT sysdate /* ����� */
);

ALTER TABLE books
	ADD
		CONSTRAINT PK_books
		PRIMARY KEY (
			isbn
		);

/* ���ǻ����̺� */
CREATE TABLE pub_tbl (
	pub_code NUMBER(5) NOT NULL, /* ���ǻ��ڵ� */
	pub_name VARCHAR2(100) NOT NULL, /* ���ǻ�� */
	pub_ceo VARCHAR2(30), /* ���ǻ��ǥ */
	pub_tel VARCHAR2(15) NOT NULL, /* ���ǻ翬��ó */
	pub_fax VARCHAR2(15), /* ���ǻ��ѽ� */
	pub_addr VARCHAR2(300), /* ���ǻ��ּ� */
	writedate DATE DEFAULT sysdate /* ����� */
);

ALTER TABLE pub_tbl
	ADD
		CONSTRAINT PK_pub_tbl
		PRIMARY KEY (
			pub_code
		);

/* �۰����̺� */
CREATE TABLE author_tbl (
	author_code NUMBER(5) NOT NULL, /* �۰��ڵ� */
	author VARCHAR2(30) NOT NULL, /* �۰��� */
	debut VARCHAR2(100), /* ������ */
	debut_year DATE, /* ���߳⵵ */
	email VARCHAR2(50), /* �̸��� */
	homepage VARCHAR2(100), /* Ȩ������ */
	writedate DATE DEFAULT sysdate /* ����� */
);

ALTER TABLE author_tbl
	ADD
		CONSTRAINT PK_author_tbl
		PRIMARY KEY (
			author_code
		);