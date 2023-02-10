TRIGGER
=========
> insert, update, delete문이 실행될 때 묵시적으로 실행되는 프로시저이다.   

+ #### [EX] 변경 전,후 부서명 출력하는 트리거
```sql
create or replace trigger trigger_name
  before --쿼리문 실행 전
  update on tbl_name -- tbl_name 테이블을 업데이트할 때 실행.
  for each row -- 행단위로 트리거 실행, 생략하면 문장단위 트리거가 된다.
declare --변수 선언하여 사용할 수 있음.
  avg_sal number;
begin
  dbms_output.put_line('부서명 변경전 데이터 : '|| :old.dname);
  dbms_output.put_line('부서명 변경후 데이터 : '|| :new.dname);
end;
-- 이후 update명령문 실행 시 출력문 출력됨.
```
+ #### 트리거 확인
```sql
select * from all_triggers;
```
+ ### 트리거 삭제
```sql
drop trigger trigger_name;
```
