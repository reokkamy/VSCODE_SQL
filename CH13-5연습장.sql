--공식 별칭을 지정하는 동의어 synonym을 생성합니다. 즐겨찾기, 또는 사이트 도메인 이름, 연락처 이름


--동의어 생성
CREATE SYNONYM EMP_SYNONYM FOR EMP;--  이름 의미있게 이용
CREATE SYNONYM E FOR EMP; --비추

--동의어 조회
SELECT * FROM USER_SYNONYMS;

--동의어를 이용한 조회
SELECT * FROM EMP_SYNONYM; -- EMP 테이블 조회

--권한 부여
GRANT SELECT ON EMP TO PUBLIC; -- 모든 사용자에게 EMP 테이블 조회 권한 부여
GRANT SELECT ON EMP TO SCOTT; -- 특정 사용자에게 권한 부여

--동의어 삭제
DROP SYNONYM EMP_SYNONYM; -- EMP_SYNONYM 동의어 삭제

--스키마명 포함 접근
SELECT * FROM SCOTT.EMP;
SELECT * FROM EMP;

--PRIVATE 동의어 생성
CREATE SYNONYM MY_EMP FOR SCOTT.EMP; -- 현재 사용자만 사용가능

--사용자 추가
CREATE USER KMJ IDENTIFIED BY 1212; --  새 사용자 생성
--기본 접속 권한만 추가
GRANT CREATE SESSION TO KMJ; -- 세션 생성 권한 부여

--사용자 조회
SELECT * FROM ALL_USERS WHERE USERNAME;  -- KMJ 새 사용자 확인


--세션 기존 SCOTT 계정-> KMJ 계정으로 변경
- MY_EMP 동의어를 이용한 조회
SELECT * FROM MY_EMP; -- KMJ 계정에서 SCOTT.EMP 테이블 조회
-- -- 동의어 삭제
SELECT * FROM DEPT;
==================================================

--SCOTT 계정에서 동의어 생성하기
--예를 들어서, 사용하는 테이블이 EMP, DEPT, SALGRADE 테이블이있다면
--EMP2,DEPT2,SALGRADE2 로 변경해서 사용 고려해보기


-- 퀴즈1, EMP2, DEPT2 조인 고려하기
-- 동의어를 활용해서 부서명이 ‘ACCOUNTING’인 사원 이름과 직무를 출력하라.
CREATE SYNONYM EMP2 FOR SCOTT.EMP;
CREATE SYNONYM DEPT2 FOR SCOTT.DEPT;
CREATE SYNONYM SALGRADE2 FOR SCOTT.SALGRADE;

--동의어 조회 EMP2
SELECT * FROM USER_SYNONYMS WHERE SYNONYM_NAME = 'EMP2';

--

SELECT E.ENAME, E.JOB
FROM EMP2 E
JOIN DEPT2 D ON E.DEPTNO = D.DEPTNO
WHERE D.DNAME = 'ACCOUNTING';





-- 퀴즈2, EMP2, SALGRADE2 고려하기 
-- 급여 등급(GRADE) 3에 해당하는 사원 목록 출력
SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP2 E
JOIN SALGRADE2 S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE S.GRADE = 3;

  
-- 퀴즈3, 자체 조인 및, SALGRADE 테이블 까지 조인을 고려하기
-- 관리자 이름과 급여 등급을 동의어 기반으로 출력
SELECT E.ENAME AS 사원명,
         M.ENAME AS 관리자명,
         S.GRADE AS 급여등급
         FROM EMP2 E
         JOIN EMP2 M ON E.MGR = M.EMPNO  --자가조인
         JOIN SALGRADE2 S ON E.SAL BETWEEN S.LOSAL AND S.HISAL --비등가 조인
         WHERE E.MGR IS NOT NULL; --관리자가 있는 사원만 조회