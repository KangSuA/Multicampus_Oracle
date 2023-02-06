-- �����Լ�
--     ����ġ    �ø�          ����             �������̺�
select abs(-45), ceil(12.1), floor(12.9) from dual;

--    ������      �ݿø�
select mod(12,5), round(12.669), round(12.669,2), round(12.669,-1) from dual;

-- power() : n�� ���ϱ�
select power(3,2) from dual;

-- �����Լ�
-- concat() : ���ڿ� ����
select ename||'��', concat(ename, '��') from emp;
-- initcap(char) : ù��° ���ڿ��� �빮�ڷ� ��ȯ
select initcap('hong') from dual;
-- lower(char) : �ҹ���, upper(char) : �빮��
select ename, lower(ename), upper('hi') from emp;

-- lpad : ���ʿ� ���� �ڸ��� ���ڸ� ǥ��, rpad : ������ ���� �ڸ��� ���ڸ� ǥ��
select ename, lpad(ename,10), lpad(ename,10,'-'), rpad(ename, 10, '*') from emp;
-- ***8000��
select sal, rpad(lpad(sal,6,'*'),8,'��') from emp; --�ѱ��� 3����Ʈ�� ���

-- substr(char, start, count) : ���ڿ��� �Ϻθ� ��ȯ�Ѵ�.
select ename, substr(ename,3) from emp;
select ename, substr(ename, 2, 3) from emp;
select ename, substr(ename, -2,3) from emp;

-- length() : ���ڼ�
select length('ȫ�浿�̴�.'), ename, length(ename), length(concat(sal,'')) from emp;

-- [����] �̸��� ���ڱ����� 50%��ŭ ����ϰ� ������ ���ڴ� '*'���� ǥ���Ͽ���.
select rpad(substr(ename,1,length(ename)/2),length(ename),'*') from emp;
select ename, rpad(substr(ename,0,floor(length(ename)/2)),length(ename),'*')ename2 from emp;

-- replace() : ġȯ
select ename, replace(ename, 'A', '����') from emp;

-- instr() : ������ ��ġ�� �����ش�.
select ename, instr(ename,'A') from emp;
select instr('CORPORATE FLOOR','OR',3) from dual;
select instr('CORPORATE FLOOR','OR',3,2) FROM DUAL;

-- trim()
-- ltrim()
-- rtrim()
select sal, trim(0 from sal) from emp;
select ltrim('xyxxXxyLAST WORD','xy') from dual; -- �ٸ����ڰ� ���ö����� x�̰ų� y�� �����϶�.
select rtrim('BROWINGyxyxy','xy') from dual; -- �����ʺ��� x,y�� �ƴ� �ٸ� ���ڰ� ���ö����� �����϶�.
select rtrim('     Test     ') as t from dual;

-- if ���ǽ� then
-- end if;
-- deconde

select deptno, decode(deptno,10,'��ȹ��', 20,'�λ��',30,'�ѹ���') �μ��� from emp;

desc emp; -- description

-- ���� �ý��� ��¥, �ð��� ��� ���� ����
select sysdate, to_char(sysdate, 'YYYY-MM-DD- HH24:MI:SS PM') ���� from dual;
select to_char(sysdate, 'MONTH') FROM DUAL;
select to_char(sysdate, 'MM-DD') FROM DUAL;

select to_char(hiredate, 'YYYY-MM-DD HH24:MI') from emp;

-- last day() : ������ ��
select last_day(sysdate) from dual;
select hiredate, last_day(hiredate) from emp;

-- add_months() : �� ���
select add_months(sysdate, 15), add_months(sysdate, -3) from dual;
select ename, hiredate, add_months(hiredate,15) from emp;

select add_months('20-10-02',5), add_months('20/10/02',5), add_months('20.10.02',5) from dual;

select hiredate, floor(months_between(sysdate, hiredate)) from emp;

-- round() �ݿø�
select round(to_date('2020-10-20'),'YEAR'), round(sysdate,'YEAR') from dual; -- ���� �⵵��
select round(to_date('2020-10-12'),'MONTH'), round(sysdate,'MONTH') from dual; -- ���� ����
select round(to_date('2023-01-17'),'DAY'), round(to_date('2023-01-20'),'DAY') from dual; -- ����

--��¥�� ���� +-
select sysdate+100, sysdate-100, sysdate-to_date('2020-09-10','YYYY-MM-DD') from dual;

-- �׷��Լ�

-- count() : ����
select count(empno), count(ename), count(sal), count(nvl(comm,0)) from emp;

-- max() : �ִ� min() : �ּڰ�
select max(sal) �ִ밪, min(sal) �ּڰ� from emp;
--avg() : ��� stddev() : ǥ������ sum() : ����
select round(avg(sal),2), round(stddev(sal),3), sum(sal) from emp;

-- group by ��
select deptno, count(ename), sum(sal), round(avg(sal),2) from emp
group by deptno order by deptno;

select job, max(sal), min(sal), round(avg(sal),2), count(ename) from emp
where job!='SALESMAN' group by job;

-- �μ��� ������ �޿� �հ�, ���, ������� �����϶�.
select deptno, job, sum(sal) �޿��հ�, avg(sal) �޿����, count(ename) from emp
group by deptno, job
order by deptno asc, job asc;

-- having�� : �׷��Լ��� ������� �������� ����ؾ� �� ���

-- ������ �޿� �հ�, �޿� ���, �ְ�޿�, �����޿�, ������� �����ϵ� ������� 3�� �̸��� ������ ����
select job, sum(sal) �޿��հ�, avg(sal) �޿����, max(sal) �ְ��, min(sal) ������, count(empno) �����
from emp
group by job
having count(ename)>=3;

-- [����] �μ���, ������ ���� �޿��� �հ�, �޿��� ���, �����, ǥ�������� ���϶�.
select deptno, job, sum(sal), avg(sal), count(ename), stddev(sal)
from emp
where hiredate >= '1981-01-01' and sal>=1000
group by deptno, job
order by deptno desc, job;

-- rollup() : �׷��Լ��� ��ü ���߰�
select job, sum(sal) from emp group by rollup(job);
select deptno, job, sum(sal) from emp group by rollup(deptno, job);
select deptno, job, sum(sal), count(ename) from emp group by rollup(deptno, job);

-- cube() : �׷��Լ��� ����߰�
select deptno, job, sum(sal), round(avg(sal),2), count(empno) from emp
group by cube(deptno,job) order by deptno,job;

-- grouping() : group by ó���� ���� 0, rollup, cube�� ó���� ���� 1�� ��ȯ
select deptno, job, sum(sal), count(empno), grouping(deptno), grouping(job)
from emp
group by cube(deptno, job)
order by deptno, job;

-- [����]�̸����� �̿��Ͽ� ���̵�� �������� �и��Ͽ���.
select substr('goguma@nate.com',0,instr('goguma@nate.com','@')-1) id,substr('goguma@nate.com',instr('goguma@nate.com','@')+1) domain from dual;

