--테이블처럼 사용하는 뷰

--기본개념



--기본 문법 예시
-- 뷰 생성
create view emp_view as --뷰 이름: EMP_VIEW
--EMP 테이블에서 사원번호, 이름 , 부서번호 선택-> 뷰에 넣을 예정
   select empno,
          ename,
          deptno
     from emp
    where deptno = 10;

--데이터 사진 이용해서 뷰 정보 확인
select *
  from user_views
 where view_name = 'EMP_VIEW';

--뷰에서 데이터 조회
select *
  from emp_view;

--뷰 삭제
drop view emp_view;

--인라인 뷰 사용 예시
select empno,
       ename,
       sal
  from emp;
select *
  from (
   select empno,
          ename,
          sal
     from emp
)--서브쿼리
 where rownum <= 5; --상위 5개행만 조회

    --ROWNUM을 같이 출력하는 예제
select rownum,
       empno,
       ename,
       sal
  from (
   select empno,
          ename,
          sal
     from emp
);

    --WITH 절을 사용한 뷰 예시
with emp_sal_top_3 as (
   select empno,
          ename,
          sal
     from emp
    order by sal desc
)
        --상위 3개 행만 조회
select *
  from emp_sal_top_3
 where rownum <= 3;

        --EMP 테이블에서 부서번호가 20인 사원만 표시하는 뷰 생성
create view emp_dept20_view as
   select empno,
          ename,
          hiredate,
          deptno
     from emp
    where deptno = 20;

-- 뷰에서 데이터 조회
select *
  from emp_dept20_view;

--생성된 뷰의 구조 정보 확인
DESC EMP_DEPT20_VIEW;

--생성 뷰 삭제
drop view emp_dept20_view;