-- distinct 중복 값 제거 
SELECT DISTINCT JOB AS "직종" FROM EMP;

-- 반대(ALL, 기본값 생략 가능)
SELECT ALL JOB AS "직종" FROM EMP;

-- distinct 중복 값 제거 , 2개 열
-- JOB DEPTNO , 한세트이다.
SELECT DISTINCT JOB AS "직종", 
DEPTNO AS "부서번호" FROM EMP;


-- 연산자 복습

-- 이름의 첫글자를 F를 기준으로 사전식 정렬 
SELECT * FROM EMP WHERE ENAME < 'F';

-- 부정 연산자, !=, <>, ^= 
SELECT * FROM EMP WHERE SAL != 3000;
SELECT * FROM EMP WHERE SAL <> 3000;
SELECT * FROM EMP WHERE SAL ^= 3000;

-- OR 연산자를 조금 더 간결하게 표현하는 IN 연산자 
SELECT * FROM EMP WHERE JOB = 'MANAGER' OR 
JOB = 'SALESMAN' OR JOB = 'CLERK';

SELECT * FROM EMP 
WHERE JOB IN ('MANAGER','SALESMAN','CLERK');

-- BETWEEN A AND B , A 이상 B 이하 
SELECT * FROM EMP WHERE SAL >= 2000 AND SAL <=3000;
SELECT * FROM EMP WHERE SAL BETWEEN 2000 AND 3000 ;

-- % : 모든 문자, _: 한글자 
-- S로 시작하는 모든 문자열 검색. 
SELECT * FROM EMP WHERE ENAME LIKE 'S%';
-- 2번째 글자 L를 포함하는 이름 
SELECT * FROM EMP WHERE ENAME LIKE '_L%';
-- 이름에 AM를 포함하는 사원
SELECT * FROM EMP WHERE ENAME LIKE '%AM%';

--문자열 관련 내장 함수 

-- 대문자 
SELECT ENAME , UPPER(ENAME), LOWER(ENAME),
INITCAP(ENAME) FROM EMP;

--길자 길이 비교, 바이트로 비교 
-- DUAL, 더미 테이블, 간단한 테스트 용도로 사용함. 
SELECT LENGTH('이상용'),LENGTHB('이상용'),
LENGTH('ABC'),LENGTHB('ABC') FROM DUAL;

-- SUBSTR , 문자열에서 특정 구간을 자르기 할 때 사용
-- SUBSTR(선택 컬럼(문자열), 시작위치(1부터 시작),
-- 길이만큼 추출)
-- SUBSTR('HELLO',1,3) -> HEL
SELECT JOB, SUBSTR(JOB,1,2), SUBSTR(JOB,6) FROM EMP;
-- 조금 어려운 표현 
-- PRESIDENT
-- 123456789 ,정방향 표현
-- -9-8-7-6-5-4-3-2-1
SELECT JOB, SUBSTR(JOB,-LENGTH(JOB)),
SUBSTR(JOB,-LENGTH(JOB),3)
FROM EMP;
SELECT SUBSTR('HELLO',-5, 2) FROM DUAL;

--INSTR ,  문자의 특정 위치 추출 해보기. 
-- INSTR(컬러명(문자열),찾기 위한 문자, 시작 위치, 몇번째 출현 )
SELECT INSTR('HELLO HI LOTTO', 'L'),
INSTR('HELLO HI LOTTO', 'L',5),
INSTR('HELLO HI LOTTO', 'L',2,2),
INSTR('HELLO HI LOTTO', 'O',2,2)
FROM DUAL;

--REPLACE 
SELECT '010-7661-3709' AS "변경전 문자열",
REPLACE('010-7661-3709','-',' ') AS "-,공백으로 변경",
REPLACE('010-7661-3709','-') AS "변경 옵션이 없을경우"
FROM DUAL;

-- LPAD,왼쪽으로 특정 문자 채우기 
-- RPAD,오른쪽으로 특정 문자 채우기 
-- TRIM, 양쪽 공백 제거하기
SELECT 'ORACLE', 
LPAD('ORACLE',10,'#'), 
RPAD('ORACLE',10,'#'),
RPAD('841205-1',14,'*')
FROM DUAL;

SELECT TRIM('   ORACLE   '),
TRIM(LEADING FROM '   ORACLE   '),
TRIM(TRAILING FROM '   ORACLE   ')
FROM DUAL;

-- 검색, %am%
-- 현재, emp 테이블의 데이터 내용은 모두 대문자. 
-- 만약, 나중에 데이터가 대 , 소문자가 섞여 있는 상황
-- 사용자 검색을 단순 소문자로 만 했을 경우, 
-- 검색의 결과는 대소문자 상관없이 결과에 나오게 하기. 
--1, 정확히 일치하는 것만 검색
SELECT ENAME FROM EMP
WHERE LOWER(ENAME) = LOWER('scott');

--2, am 포함하는 키워드 찾기. 
SELECT ENAME FROM EMP 
WHERE ENAME LIKE UPPER('%am%');

--3,기존 데이터를 모두 소문자로 변경후 
-- am 포함하는 키워드 찾기. 
SELECT ENAME FROM EMP 
WHERE LOWER(ENAME) LIKE LOWER('%Am%');


-- 임의 숫자 : 123.4567
-- 별칭 : 소수점 둘째 자리까지 반올림
-- FROM DUAL 
SELECT ROUND(123.4567,2) AS "소수점 둘째 반올림" 
FROM DUAL;

-- 퀴즈2 TRUNC
-- 소수점 첫째 자리에서 내림 해보기, 
-- 임의 숫자 : 123.4567
-- 별칭 : 소수점 첫째 자리에서 내림
-- FROM DUAL 

SELECT TRUNC(123.4567,1) AS "소수점 첫째에서 내림" 
FROM DUAL;
-- 퀴즈3 CEIL, FLOOR
-- CEIL, FLOOR 비교 해보기, 
-- 임의 숫자 : 1.5, -1.5
-- 별칭 : CEIL , FLOOR
-- FROM DUAL 

--  1 ~ 2 사이에서 , 1.5 기준 큰수 : 2, 작은 수:1
SELECT CEIL(1.5) AS "CEIL" ,
FLOOR(1.5) AS "FLOOR",
--  -2 ~ -1 사이에서 , -1.5 기준 
-- 큰수 : -1, 작은 수:-2
CEIL(-1.5) AS "CEIL" ,
FLOOR(-1.5) AS "FLOOR"
FROM DUAL;
-- 퀴즈4 MOD
-- 사원 번호를 4로 나눈 나머지 출력
-- 별칭 : 4로 나눈 나머지
-- FROM DUAL 
SELECT EMPNO, MOD(EMPNO, 4) AS "4로 나눈 나머지"
FROM EMP;


