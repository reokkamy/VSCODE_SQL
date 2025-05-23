--하나의 단위로 데이터를 처리하는 트랜잭션

--기본 문법
--데이터 변경
select *
  from emp_copy;
--emp_copy 테이블에 원본 EMP 테이블 복사
insert into emp_copy
   select *
     from emp;
commit;

--순서1 , EMP_COPY 테이블 데이터 변경
update emp_copy
   set
   sal = sal + 10000
 where deptno = 10;

--순서2, 트랜잭션 저장
commit;

--순서3, 트랜잭션 취소
rollback;

--순서4, 특정 지점으로 설정
savepoint sp1;

--순서4, 특정 지점으로 롤백
rollback to sp1;


--EMP -> EMP_COPY2 테이블 복사해보기 테이블생성
create table emp_copy2
   as
      select *
        from emp;
--조회
select *
  from emp_copy2;
--복사
insert into emp_copy2
   select *
     from emp;
commit;
--퀴즈1
--부서번호가 20인 사원들의 급여를 10%인상후 
--조건에 따라 되돌릴수있도록 SAVEPOINT2 설정
update emp_copy2
   set
   sal = sal * 1.1
 where deptno = 20;

savepoint sp2;

--퀴즈2
--사번이 7839인 사원의 급여를 5000으로 변경하고
--이 작업만 ROLLBACK으로 취소하기
update emp_copy2
   set
   sal = 7000
 where empno = 7839;

rollback to sp2;

commit;

-- 퀴즈3, 
-- 여러 UPDATE 작업 수행 후 COMMIT하지 않고
-- 전체를 ROLLBACK 하시오.
update emp_copy2
   set
   sal = sal * 1.1
 where deptno = 10;
update emp_copy2
   set
   sal = sal * 1.1
 where deptno = 20;
update emp_copy2
   set
   sal = sal * 1.1
 where deptno = 30;
-- COMMIT OR ROLLBACK;
rollback;