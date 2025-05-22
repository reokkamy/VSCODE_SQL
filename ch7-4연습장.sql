--다양한 고급 그룹화 함수 기능 소개

--부서별, 직책별 급여 합계 (ROLLUP):계층적 요약
--기본문법
--SELECT 부서, 직책, SUM(급여)
--FROM EMP
--GROUP BY ROLLUP(부서,직책)
--상위항목(부서)->하위항목(직책)순서로 요약
--마지막행은 전체총합
SELECT DEPTNO, JOB, SUM(SAL) FROM EMP 
GROUP BY ROLLUP(DEPTNO, JOB);

--CUBE:모든 조합 분석
--기본문법
--SELECT 부서 , 직책, SUM(급여)
--FROM EMP
--GROUP BY CUBE(부서, 직책)
--ROLLUP보다 더 많은 조합 생성
--(부서,직책), (부서),(직책) 모든 집계 조합가능.
SELECT DEPTNO, JOB, SUM(SAL) AS "총급여"
FROM EMP
GROUP BY CUBE(DEPTNO,JOB);

--GROUPING
--집계로인한 NULL 여부식별에 사용함
--기본문법
--SELECT 컬럼1, 컬럼2, 집계함수(컬럼3),
--GROUPING(컬럼1) AS 그룹1,
--GROUPING(컬럼2) AS 그룹2
--FROM 테이블명
--GROUP BY ROLLUP(컬럼1, 컬럼2);

--DEPTNO = 1이면 전체 집계로 생긴 NULL
--JOB =1 이면 부서 합계로 생긴 NULL
SELECT DEPTNO, JOB, SUM(SAL) AS "총급여",
GROUPING(DEPTNO) AS "GROUP_DEPTNO",
GROUPING(JOB) AS "GROUP_JOB"
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

--PIVOT 
--기본문법
--행-> 열로 전환하기
--기본문법
--SELECT * 
--FROM (
--SELECT  기준컬럼, 피벗컬럼, 값 컬럼 FROM 테이블명
--)
--PIVOT(
--집계함수(값 컬럼)
--FOR 피벗컬럼 IN (값 AS 별칭1, 값2 AS 별칭2...)
--)

--직책별 급여 합계를 부서별로 , 가로 형태로 전환
SELECT * FROM(SELECT DEPTNO, JOB, SAL FROM EMP)
PIVOT(
SUM(SAL)
FOR JOB IN('CLERK'AS "사무직", 'MANAGER' AS "관리자", 'ANALYST' AS "분석가") 
);

--UNPIVIOT
--열 데이터를 다시 행으로 전환
--기본문법
--SELECT *
--FROM(SELECT 기준컬럼, 열1, 열2,...FROM 테이블명)
--UNPIVOT(
--값 컬럼 FOR 피벗 컬럼IN(열1, 열2,..)
--);

--위에서 PIVOT된 결과를 다시 행으로 변환
SELECT DEPTNO, 직무, 급여합계
FROM (
  SELECT DEPTNO, "사무직", "관리자", "분석가"
  FROM (
    SELECT DEPTNO, JOB, SAL
    FROM EMP
  )
  PIVOT (
    SUM(SAL)
    FOR JOB IN (
      'CLERK' AS "사무직",
      'MANAGER' AS "관리자",
      'ANALYST' AS "분석가"
    )
  )
)
UNPIVOT (
  급여합계 FOR 직무 IN ("사무직", "관리자", "분석가")
);
--


-- UNPIVOT 간단한 예시 
-- 열 기준의 급여 데이터를 연도 기준 행으로 전환하기. 
-- 실제로 출력이 되는 컬럼은 
-- EMPNO, ENAME, 항목, 금액

SELECT EMPNO, ENAME, 항목, 금액 
FROM (
    SELECT EMPNO, ENAME, SAL, COMM FROM EMP
)
-- UNPIVOT : 열 -> 행으로 변환하는 절
UNPIVOT (
    -- 실제 값이 들어갈 컬러명
    금액 
    -- 어떤 항목인 구분하는 컬럼명, 
    -- (예시:급여, 커미션)
    FOR 항목 
    IN (
    -- SAL, COMM UNPIVOT의 대상이 되는 열
    -- SAL 컬럼을 급여이라는 별칭 변환
        SAL AS '급여',
    -- COMM 컬럼을 수당이라는 별칭 변환
        COMM AS '수당'
    )
);


-- UNPIVOT 
-- 열 데이터를 다시 행으로 전환  
-- 기본 문법
-- SELECT * 
-- FROM ( SELECT  기준컬럼, 열1, 열2,... FROM 테이블명)
-- UNPIVOT (
-- 값 컬럼 FOR 피벗 커럼 IN (열1, 열2,...)
--);

--퀴즈 1
-- EMP 테이블에서 SAL, COMM 을 UNPIVOT 한 후, 
-- 항목별 (급여/커미션) 전체 합계를 구하기. 
-- 별칭 : 항목, 총합계
SELECT ENAME, SAL, COMM FROM EMP;
--기존테이블 , 가로로 되잇음 
-------------------------------------
SELECT ENAME, 항목, SUM(금액) AS "총합계"
FROM 
--UNPIVOT이 되는 대상 컬럼
--원래 가로로 배치된데이터를 변환해서 세로로배치할계획
(SELECT ENAME, SAL, COMM FROM EMP)
UNPIVOT(금액 FOR 항목 IN(
SAL AS '급여', COMM AS '수당'))
GROUP BY ENAME, 항목;
