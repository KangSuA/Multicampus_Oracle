select ename, sal, emp.deptno, dname from emp, dept
where emp.deptno = detpt.deptno;

-- [����]isbn, å�̸�, ����, ���ǻ��, ���ǻ翬��ó, �۰����� ����
-- �� 10000�� �̻��� ������ �����϶�.
select b.isbn, b.bookname, b.price, p.pub_name, p.pub_tel, a.author
from (select * from books where price>=10000) b
join pub_tbl p
on b.pub_code = p.pub_code
join author_tbl a
on b.author_code = a.author_code;

-- emp�� dept�� ����. ����� �μ��ڵ尡 30���� ����� �����, ����, �޿�, �μ����� �����϶�.
select ename,job,sal,dname, emp.deptno from emp, dept where emp.deptno = dept.deptno and emp.deptno=30;
select ename, job, sal, dname, e.deptno from emp e join dept d on e.deptno=d.deptno and e.deptno=30
order by e.ename asc;

-- [�ǽ�] SALESMAN�� �����ȣ, �̸�, �޿�, �μ���, �ٹ����� ����϶�.
select empno, ename, sal, dname, loc from emp e join dept d on e.deptno=d.deptno and job='SALESMAN';
select * from emp;

-- �񵿵����� : ����, ������ ������ �̿��Ͽ� �����Ѵ�.
-- �����, ����, �޿�, ȣ���� �����϶�.
select e.ename, e.job, e.sal, s.grade ȣ��
from emp e, salgrade s
where e.sal between s.losal and s.hisal;

select e.ename, e.job, e.sal, s.grade ȣ��
from emp e join salgrade s
on e.sal between s.losal and s.hisal;

-- [����] 10��,20�� �μ��� ����� �����ȣ, �����, �޿�, ���ʽ�, �μ���, ȣ���� �����϶�
select e.empno, e.ename, e.sal, e.comm, d.dname, s.grade
from emp e, salgrade s, dept d
where e.deptno=d.deptno and e.sal between s.losal and s.hisal and e.deptno in(10,20);

select e.empno, e.ename, e.sal, e.comm, d.dname, s.grade, e.deptno
from emp e join dept d on e.deptno=d.deptno
join salgrade s on e.sal between s.losal and s.hisal and e.deptno in(10,20)
order by s.grade asc;

update emp set deptno=30 where job=upper('manager');
select * from emp;
commit;

-- self join : ���� ���̺��� �����ϳ�.
-- �����, ����, �Ի���, �����ڸ�, ������ �Ի���, �޿��� �����϶�.
select e1.ename, e1.job, e1.hiredate, e2.ename �����ڸ�, e2.hiredate �������Ի���, e2.sal �����ڱ޿�
from emp e1 join emp e2 on e1.mgr=e2.empno;

-- [����] emp���̺��� "������ �����ڴ� �����̴�."�� ������ ����ϼ���
select e1.ename || '�� �����ڴ� '|| e2.ename || '�̴�.' ��������
from emp e1 join emp e2 on e1.mgr=e2.empno;

-- outer ����
-- null�� �� �ʿ� +�� �ٿ���.
-- �����, �޿�, �μ��ڵ�, �μ����� �����϶�.
select e.ename, e.sal, e.deptno, d.dname, d.deptno
from emp e, dept d
where e.deptno(+)=d.deptno;

select e.ename, e.sal, e.deptno, d.dname, d.deptno
from emp e join dept d
on e.deptno(+)=d.deptno;

select * from pub_tbl;
desc books;
-- å�̸�, ���ǻ��, ������ out join�϶�.
select b.bookname, p.pub_name, b.price
from books b join pub_tbl p
on b.pub_code(+) = p.pub_code;

-- left outer join : null�� �����ʿ� ������
-- right outer join : null�� ���ʿ� ������
-- �����, �޿�, �μ��ڵ�, �μ����� �����϶�.
select e.ename, e.sal, e.deptno, d.dname
from emp e right outer join dept d
on e.deptno = d.deptno;
-- ���Ʒ� ���� ��
select e.ename, e.sal, e.deptno, d.dname
from dept d left outer join emp e
on e.deptno = d.deptno;

-- full outer join
select e.ename, e.deptno, d.dname
from dept d  full outer join emp e
on e.deptno=d.deptno;

select distinct a.deptno, b.deptno
from emp a full outer join dept b
on a.deptno=b.deptno
order by a.deptno;

-- 1.
select e.ename, e.deptno, d.dname
from emp e, dept d -- emp e join dept d on
where e.deptno=d.deptno
order by d.deptno;

select * from EMP;
-- 2.
select e.ename, e.job, e.sal, d.dname
from emp e, dept d
where E.deptno=d.deptno and d.loc='NEW YORK';

-- 3.
select e.ename, d.dname, d.loc
from emp e, dept d
where e.deptno=d.deptno and nvl(e.comm,0)!=0; -- e.comm>0

-- 4.
select e.ename, d.dname, d.loc
from emp e, dept d
where e.deptno=d.deptno and e.ename like '%L%';

-- 5.
select e1.ename Employee, e1.empno EMP#, e2.ename Manager, e2.empno Mgr#
from emp e1 left outer join emp e2
on e1.mgr = e2.empno;
--from emp e1, emp e2
--where e1.mgr = e2.empno(+);

-- natural join
-- ������ ���̺���� ���� �ʵ���� ã�� �������ش�. ���� ���x
select empno, ename, deptno from emp natural join dept;

-- join ~ using
-- join ������ on ��� using�� ����� �� �ִ�.
select empno, ename, deptno from emp join dept using(deptno);