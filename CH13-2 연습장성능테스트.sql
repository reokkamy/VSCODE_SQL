-- 인덱스를 이용한 성능 테스트
-- 더미 테이블 생성, EMP_INDEX_TEST 테이블 생성
DESC EMP;
-- 기존 EMP 테이블은 4자리 사원 번호까지만 이용가능해서, 6자리로 교체.
-- DROP TABLE EMP_INDEX_TEST;
create table emp_index_test (
   empno    number(6) primary key,
   ename    varchar2(50),
   job      varchar2(20),
   mgr      number(6),
   hiredate date,
   sal      number(8,2),
   comm     number(8,2),
   deptno   number(2)
);
select *
  from emp_index_test;

-- 더미 데이터 삽입 , 100000건 삽입
begin
   for i in 1..100000 loop
      insert into emp_index_test (
         empno,
         ename,
         job,
         sal,
         deptno
      ) values ( 10000 + i,
                 'USER' || i,
                 case mod(
                    i,
                    5
                 )
                    when 0 then
                       'CLERK'
                    when 1 then
                       'MANAGER'
                    when 2 then
                       'SALESMAN'
                    when 3 then
                       'ANALYST'
                    else
                       'PRESIDENT'
                 end,
                 1000 + mod(
                    i,
                    5000
                 ),
                 mod(
                    i,
                    4
                 ) * 10 + 10  -- 10, 20, 30, 40 중 하나
                  );
   end loop;
   commit;
end;

select *
  from emp_index_test;

-- 기본 EMP_INDEX_TEST , 자동 생성된 인덱스, EMPNO 로 생성 조회, 
select *
  from user_indexes
 where table_name = 'EMP_INDEX_TEST';

--------------------------------------------------------------------
-- 인덱스 없이 실행 
select *
  from emp_index_test
 where ename = 'USER50000';

-- 성능 비교 (실행계획 확인)
explain plan
   for
select *
  from emp_index_test
 where ename = 'USER50000';
-- 실행계획 확인
select *
  from table ( dbms_xplan.display );
--------------------------------------------------------------------
--------------------------------------------------------------------
-- 인덱스 생성
create index emp_index_test_ename_idx on
   emp_index_test (
      ename
   );
select *
  from emp_index_test
 where ename = 'USER50000';

-- 성능 비교 (실행계획 확인)
explain plan
   for
select *
  from emp_index_test
 where ename = 'USER50000';
-- 실행계획 확인
select *
  from table ( dbms_xplan.display );
-- |*  2 |   INDEX RANGE SCAN          | EMP_INDEX_TEST_ENAME_IDX |   401 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------

-- 복합키 예시 
-- 순서, JOB, DEPTNO 컬럼의 순서로 인덱스 생성, 
-- 전 , 후 성능 비교 
---------------------------------------------------------------------------------
-- 인덱스 생성 전 
select *
  from emp_index_test
 where job = 'CLERK'
   and deptno = 10;
-- 성능 비교 (실행계획 확인)
explain plan
   for
select *
  from emp_index_test
 where job = 'CLERK'
   and deptno = 10;
-- 실행계획 확인
select *
  from table ( dbms_xplan.display );
-- 결과 
--| Id  | Operation         | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
--|*  1 |  TABLE ACCESS FULL| EMP_INDEX_TEST |  4993 |   550K|   147   (3)| 00:00:02 |
---------------------------------------------------------------------------------
-- 인덱스 생성
create index emp_index_test_job_deptno_idx on
   emp_index_test (
      job,
      deptno
   );
-- 인덱스 조회 
select *
  from user_indexes
 where table_name = 'EMP_INDEX_TEST';

select *
  from emp_index_test
 where job = 'CLERK'
   and deptno = 10;
-- 성능 비교 (실행계획 확인)
explain plan
   for
select *
  from emp_index_test
 where job = 'CLERK'
   and deptno = 10;
-- 실행계획 확인
select *
  from table ( dbms_xplan.display );
-- 결과 
--| Id  | Operation         | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
--|*  1 |  TABLE ACCESS FULL| EMP_INDEX_TEST |  4993 |   550K|   147   (3)| 00:00:02 |
-- 인덱스 검색이 아닌 전체 검색이 나온 이유는 

select *
  from emp_index_test
 where job = 'CLERK';
select count(*)
  from emp_index_test
 where job = 'CLERK';
---------------------------------------------------------------------------------
-- 복합키 인덱스 예시2 
-- 기존 단일키 인덱스 삭제
drop index emp_index_test_ename_idx;
-- 기존 복합키 인덱스 삭제 
drop index emp_index_test_job_deptno_idx;
-- 인덱스 조회 
select *
  from user_indexes
 where table_name = 'EMP_INDEX_TEST';
-- ENAME, JOB 컬럼의 순서로 인덱스 생성,
--인덱스 생성전
select *
  from emp_index_test
 where ename = 'USER50000'
   and job = 'CLERK';
-- 성능 비교 (실행계획 확인)
explain plan
   for
select *
  from emp_index_test
 where ename = 'USER50000'
   and job = 'CLERK';
-- 실행계획 확인
select *
  from table ( dbms_xplan.display );


-- 인덱스 생성 후
create index emp_index_test_ename_job_idx on
   emp_index_test (
      ename,
      job
   );
-- 인덱스 조회
select *
  from user_indexes
 where table_name = 'EMP_INDEX_TEST';

select *
  from emp_index_test
 where ename = 'USER50000'
   and job = 'CLERK';
-- 성능 비교 (실행계획 확인)
explain plan
   for
select *
  from emp_index_test
 where ename = 'USER50000'
   and job = 'CLERK';
-- 실행계획 확인
select *
  from table ( dbms_xplan.display );
-- 결과
--| Id  | Operation         | Name                          | Rows  | Bytes | Cost (%CPU)| Time     |
--|*  2 |   INDEX RANGE SCAN| EMP_INDEX_TEST_ENAME_JOB_IDX |     1 |       |     1   (0)| 00:00:01 |