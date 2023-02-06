-- �ּ�
-- * : ��� �ʵ�

select * from tab;

select dname,loc
from dept;
--            ����,��Ī(alias)
select deptno �μ��ڵ�, ename �����, sal as �޿� from emp;

select * from emp;

desc emp;

-- where �� : ���Ѵ� ���ǿ� �ش��ϴ� ���ڵ常 ���ð����ϴ�.
select ename, sal, deptno from emp
where deptno = 10;
-- ������ manager�� ����� �����϶�.
-- ����� ��ҹ��� ����. ���ڴ� ���� ����ǥ
select * from emp
where job='MANAGER';

-- �޿��� 2000�� �̻��� ����� �����϶�.
select * from emp where sal>=2000;
-- �޿��� 2000~3000�� �̻��� ����� �����϶�.
select * from emp where sal>=2000 and sal<=3000;
select * from emp where sal between 2000 and 3000;

-- emp���̺��� �����ȣ, �����, �޿�, �μ��ڵ带 �����ϵ� �޿��� 2500~3000�� ������ ���
select empno, ename, sal, deptno from emp where sal between 2500 and 3000;

-- emp���̺��� 10,30�� �μ��� ��� �� �������� manager�� ���
-- AND > OR
select * from emp where job='MANAGER' AND deptno in(10,30);
select * from emp where (deptno=10 or deptno=30) and job='MANAGER';

-- in ������ : or
-- emp���̺��� �޿��� 2000,3000,4000,5000�� ����� ����
select * from emp where sal in(2000,3000,4000,5000);
select * from emp where sal=2000 or sal=3000 or sal=4000 or sal=5000;

-- like������ : Data�� �Ϻΰ� ��ġ�ϸ� ����
select * from emp;
-- ������� A�� �����ϴ� ����� �����϶�.
select * from emp where ename like 'A%';
-- ������� S�� ������ ����� �����϶�.
select * from emp where ename like '%S';
-- ����� M�� ���ԵǾ� �ִ� ����� �����϶�.
select * from emp where ename like '%M%';

-- ������� 2��° ���� L�� ����� �����϶�.
select * from emp where ename like '_L%';

-- �޿��� 1500�� �̻��� ����� 12���� �Ի��� ����� �����϶�.
select * from emp where sal>=1500 and hiredate like '___12%'; -- '__/12%'

-- not between
-- �����ȣ�� 7500���� 7700�� ������ ����� �����ϰ� �����϶�.
select * from emp where empno<7500 or empno>7700;
select * from emp where empno not between 7500 and 7700;

-- not in
-- �޿��� 3000, 4000, 5000�� ����� �����ϰ� �����϶�.
select * from emp where sal not in(3000,4000,5000);

-- not like
-- ������ man�� ������ ������ �����ϰ� �����϶�.
select * from emp where job not like '%MAN%';

-- ���������
-- null�� ��� ���꿡�� ���ܵ� => is null, is not null
select empno, ename, sal, sal*2000 from emp;
select * from emp where comm=null; -- null�� null�����ڸ� �̿��Ͽ��� �Ѵ�.
select * from emp where comm is null;
select * from emp where job='SALESMAN';

-- �޿��� 10%�λ��� �ݾ����� �����϶�.
select ename, sal, sal*1.1 from emp;

-- emp���̺��� �����, ����, �޿�, �Ի���, ���ʽ��� �����ϵ�
-- �޿��� 20%�λ��� �ݾ��� �����ϰ�
-- 82�⵵, 83�⵵ �Ի��� ����� �����϶�.
select ename, job, sal*1.2 sal, hiredate, comm from emp where hiredate not like '82%' and hiredate not like '83%';
