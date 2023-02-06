-- primary key �������� �����ϱ�
-- constraint �������Ǻ����� : ���̺��_������������_�ʵ��
alter table emp add constraint emp_pk_empno primary key(empno);

-- �������� Ȯ���ϱ�
select * from user_constraints where table_name='EMP' order by table_name;

insert into emp(empno, ename) values(7369, 'choi');

desc emp;

-- unique : �ߺ������� ������
alter table salgrade add constraint salgrade_uk_grade unique(grade);
insert into salgrade values(6,0,699);
insert into salgrade values(5,3001,9999);
delete from salgrade where grade=6;
select * from salgrade;

-- number(7,2) :  9999.99���� ���� ����
-- �޿��� 800~6000���� ���
-- check : �������� ������ �����ϴ� ��������
alter table emp add constraint emp_ck_sal check(sal between 800 and 6000);
insert into emp(empno, ename, sal) values(2222, 'kim', 5500);

-- 10,20,30,40,50,60,70,80,90
alter table dept add constraint dept_ck_deptno check(deptno in(10,20,30,40,50,60,70,80,90));
insert into dept values(50,'��ȹ��','������');
select * from user_constraints;
select * from dept;
desc dept;

-- �ܷ�Ű
insert into emp(empno, ename, deptno) values(1234,'choi',60);

-- emp���̺��� deptno�� dept���̺��� deptno�� �����Ѵ�.
-- no action : �����ǰ� �ִ� ���ڵ�� �������� �ʴ´�.
-- on delete cascade : �����Ǵ� ���ڵ带 �����.
alter table emp add constraint emp_fk_deptno foreign key(deptno) references dept(deptno);
alter table dept add constraint dept_pk_deptno primary key(deptno);

commit;

select * from emp;
select * from user_constraints;

delete from emp where ename='kim';

delete from dept where deptno=50;
delete from dept where deptno=20;

-- �������� ����
alter table dept drop constraint dept_ck_deptno;
insert into emp(empno, ename, deptno) values(555,'gang',15);
insert into dept values(15,'�λ��','���ı�');

-- commit
-- rollback
-- savepoint
select * from dept;
insert into dept values(1,'��ȹ��','��������');
savepoint a;
insert into dept values(2,'�ѹ���','���α�');
update dept set loc='seoul';
rollback to a;

