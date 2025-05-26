--더 빠른 검색을 위한 인덱스

-- 
-- | 항목 | 설명 |
-- |------|------|
-- | 인덱스(Index) | 특정 열 기준으로 검색 속도를 높이는 보조 구조 |
-- | 생성 구문 | `CREATE INDEX 인덱스명 ON 테이블명(열명)` |
-- | 삭제 구문 | `DROP INDEX 인덱스명` |
-- | 자동 생성 | PRIMARY KEY, UNIQUE 제약 시 자동 생성 |
-- | 수동 생성 | 성능 최적화를 위해 직접 지정 가능 |



--인덱스 생성, emp sal 급여를 이용해서 이름은 : EMP_SAL_IDX
create index emp_sal_idx on
   emp (
      sal
   );

--인덱스 목록 조회
select *
  from user_indexes;

--인덱스 컬럼조회
select *
  from user_ind_columns
 where index_name = 'EMP_SAL_IDX';

--인덱스 삭제
drop index emp_sal_idx;

--퀴즈1,
--SCOTT 계정에서 EMP 테이블의 JOB열에 인덱스를 생성해보기
create index emp_job_idx on
   emp (
      job
   );

--퀴즈2, 이름은: EMP_ENAME_SAL_IDX , 형식순서: (ENAME, SAL);
--합인덱스를 ENAME, SAL열로 생성해보기
create index emp_ename_sal_idx on
   emp (
      ename,
      sal
   );

--퀴즈3 
--USER_IND_COLUMNS 뷰를 사용해 JOB인덱스가 생성되었는지 확인해보기
select *
  from user_ind_columns
 where index_name = 'EMP_JOB_IDX';