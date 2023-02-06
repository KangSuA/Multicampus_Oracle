-- 숫자함수
--     절대치    올림          버림             가상테이블
select abs(-45), ceil(12.1), floor(12.9) from dual;

--    나머지      반올림
select mod(12,5), round(12.669), round(12.669,2), round(12.669,-1) from dual;

-- power() : n승 구하기
select power(3,2) from dual;

-- 문자함수
-- concat() : 문자열 연결
select ename||'님', concat(ename, '님') from emp;
-- initcap(char) : 첫번째 문자열을 대문자로 변환
select initcap('hong') from dual;
-- lower(char) : 소문자, upper(char) : 대문자
select ename, lower(ename), upper('hi') from emp;

-- lpad : 왼쪽에 남는 자리에 문자를 표기, rpad : 오른쪽 남는 자리에 문자를 표기
select ename, lpad(ename,10), lpad(ename,10,'-'), rpad(ename, 10, '*') from emp;
-- ***8000불
select sal, rpad(lpad(sal,6,'*'),8,'불') from emp; --한글은 3바이트로 잡기

-- substr(char, start, count) : 문자열의 일부를 반환한다.
select ename, substr(ename,3) from emp;
select ename, substr(ename, 2, 3) from emp;
select ename, substr(ename, -2,3) from emp;

-- length() : 글자수
select length('홍길동이다.'), ename, length(ename), length(concat(sal,'')) from emp;

-- [문제] 이름을 글자길이의 50%만큼 출력하고 나머지 문자는 '*'으로 표시하여라.
select rpad(substr(ename,1,length(ename)/2),length(ename),'*') from emp;
select ename, rpad(substr(ename,0,floor(length(ename)/2)),length(ename),'*')ename2 from emp;

-- replace() : 치환
select ename, replace(ename, 'A', '에이') from emp;

-- instr() : 문자의 위치를 구해준다.
select ename, instr(ename,'A') from emp;
select instr('CORPORATE FLOOR','OR',3) from dual;
select instr('CORPORATE FLOOR','OR',3,2) FROM DUAL;

-- trim()
-- ltrim()
-- rtrim()
select sal, trim(0 from sal) from emp;
select ltrim('xyxxXxyLAST WORD','xy') from dual; -- 다른문자가 나올때까지 x이거나 y를 제거하라.
select rtrim('BROWINGyxyxy','xy') from dual; -- 오른쪽부터 x,y가 아닌 다른 문자가 나올때까지 제거하라.
select rtrim('     Test     ') as t from dual;

-- if 조건식 then
-- end if;
-- deconde

select deptno, decode(deptno,10,'기획부', 20,'인사부',30,'총무부') 부서명 from emp;

desc emp; -- description

-- 현재 시스템 날짜, 시간을 얻어 오는 변수
select sysdate, to_char(sysdate, 'YYYY-MM-DD- HH24:MI:SS PM') 오늘 from dual;
select to_char(sysdate, 'MONTH') FROM DUAL;
select to_char(sysdate, 'MM-DD') FROM DUAL;

select to_char(hiredate, 'YYYY-MM-DD HH24:MI') from emp;

-- last day() : 마지막 날
select last_day(sysdate) from dual;
select hiredate, last_day(hiredate) from emp;

-- add_months() : 월 계산
select add_months(sysdate, 15), add_months(sysdate, -3) from dual;
select ename, hiredate, add_months(hiredate,15) from emp;

select add_months('20-10-02',5), add_months('20/10/02',5), add_months('20.10.02',5) from dual;

select hiredate, floor(months_between(sysdate, hiredate)) from emp;

-- round() 반올림
select round(to_date('2020-10-20'),'YEAR'), round(sysdate,'YEAR') from dual; -- 월을 년도로
select round(to_date('2020-10-12'),'MONTH'), round(sysdate,'MONTH') from dual; -- 일을 월로
select round(to_date('2023-01-17'),'DAY'), round(to_date('2023-01-20'),'DAY') from dual; -- 요일

--날짜에 대한 +-
select sysdate+100, sysdate-100, sysdate-to_date('2020-09-10','YYYY-MM-DD') from dual;

-- 그룹함수

-- count() : 개수
select count(empno), count(ename), count(sal), count(nvl(comm,0)) from emp;

-- max() : 최댓값 min() : 최솟값
select max(sal) 최대값, min(sal) 최솟값 from emp;
--avg() : 평균 stddev() : 표준편차 sum() : 총합
select round(avg(sal),2), round(stddev(sal),3), sum(sal) from emp;

-- group by 절
select deptno, count(ename), sum(sal), round(avg(sal),2) from emp
group by deptno order by deptno;

select job, max(sal), min(sal), round(avg(sal),2), count(ename) from emp
where job!='SALESMAN' group by job;

-- 부서별 업무별 급여 합계, 평균, 사원수를 선택하라.
select deptno, job, sum(sal) 급여합계, avg(sal) 급여평균, count(ename) from emp
group by deptno, job
order by deptno asc, job asc;

-- having절 : 그룹함수의 결과값을 조건으로 사용해야 할 경우

-- 업무별 급여 합계, 급여 평균, 최고급여, 최저급여, 사원수를 선택하되 사원수가 3명 미만인 업무는 제외
select job, sum(sal) 급여합계, avg(sal) 급여평균, max(sal) 최고액, min(sal) 최저액, count(empno) 사원수
from emp
group by job
having count(ename)>=3;

-- [문제] 부서별, 업무에 대한 급여의 합계, 급여의 평균, 사원수, 표준편차를 구하라.
select deptno, job, sum(sal), avg(sal), count(ename), stddev(sal)
from emp
where hiredate >= '1981-01-01' and sal>=1000
group by deptno, job
order by deptno desc, job;

-- rollup() : 그룹함수에 전체 합추가
select job, sum(sal) from emp group by rollup(job);
select deptno, job, sum(sal) from emp group by rollup(deptno, job);
select deptno, job, sum(sal), count(ename) from emp group by rollup(deptno, job);

-- cube() : 그룹함수에 통계추가
select deptno, job, sum(sal), round(avg(sal),2), count(empno) from emp
group by cube(deptno,job) order by deptno,job;

-- grouping() : group by 처리된 행은 0, rollup, cube로 처리된 행은 1을 반환
select deptno, job, sum(sal), count(empno), grouping(deptno), grouping(job)
from emp
group by cube(deptno, job)
order by deptno, job;

-- [문제]이메일을 이용하여 아이디와 도메인을 분리하여라.
select substr('goguma@nate.com',0,instr('goguma@nate.com','@')-1) id,substr('goguma@nate.com',instr('goguma@nate.com','@')+1) domain from dual;

