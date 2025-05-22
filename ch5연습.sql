--where  기본 문법 확인
--where 조건식 (true) 일 경우의 행만 출력
-- 부선 번호가 30인 경우
select * from emp where deptno = 30;

--직무(job)가 'SALESMAN'인 사원조회
SELECT * FROM EMP WHERE JOB='SALESMAN';

--퀴즈1
--급여가 SAL) 2000이상인 사원만 조회하기
SELECT * FROM EMP WHERE SAL>=2000 ORDER BY SAL DESC;

--퀴즈2
--입사일 (HIRE DATE)이 '1981-02-20' 이후인 사원만 조회하기
SELECT * FROM EMP WHERE HIREDATE > '1981-02-20';
--퀴즈3
--부서번호가 10이 아닌 사원만 조회하기
--아니다는 표현이 일단은 '<>'표기하기
SELECT * FROM EMP WHERE DEPTNO<>10;

--5-2 AND, OR 논리 조건, 다중조건
SELECT * FROM EMP WHERE DEPTNO =30 AND JOB='SALESMAN';

--OR조건
--하나라도 만족하면 출력됨.
--JOB이 CLERK또는 MANAGER인 사원 출력해보기
SELECT * FROM EMP WHERE JOB='CLERK' OR JOB = 'MANAGER';

--괄호 사용(우선순위 명확히 하기)
-- 부서 번호가 10번 또는 20번이고 , 급여가 2000을 초과인경우
SELECT * FROM EMP
WHERE (DEPTNO = 10 OR DEPTNO =20)
AND SAL > 2000;

--퀴즈1
--급여가 1500이상이고 커미션이 NULL이 아닌 사원만 조회
-- 힌트) NULL 이 아닌 표현 : IS NOT NULL
SELECT * FROM EMP WHERE SAL>=1500 AND COMM IS NOT NULL;
--퀴즈2 
--직무가 'SALESMAN' 이거나 급여가 3000이상인 사운출력
SELECT * FROM EMP WHERE JOB='SALESMAN' OR SAL>3000;
--퀴즈3
--부서번호가 10,20,30중 하나이고 급여가 2000이상인 사원 출력
--힌트) 10,20,30중하나 표현: IN(10,20,30)]
--OR조건을 간단히
--컬럼명 IN(값1, 값2, 값3...)-
--컬럼명의 조건이 IN안의 값을 하나라도만족한다면 TRUE
SELECT * FROM EMP WHERE DEPTNO IN(10,20,30) AND SAL>=2000;


--------------------------------------------------------------------
--5-3 연산자 종류와 활용 기본
SELECT ENAME, SAL * 12 AS "기본연봉" FROM EMP;

--비교연산자
SELECT * FROM EMP WHERE SAL>=2000;

--문자 비교(1글자VS여러글자)
--L보다 뒤에, 사전식 기준 생각하기
SELECT * FROM EMP WHERE ENAME > 'L';
--여러글자, 순서대로 앞의 글자 비교하고 다음글자 비교
SELECT * FROM EMP WHERE ENAME < 'MILLER';

--등가 비교 연산자
-- !=, <>, ^=
--JOB CLERK이 아닌 사원만 출력
SELECT * FROM EMP WHERE JOB != 'CLERK';
SELECT * FROM EMP WHERE JOB <> 'CLERK';
SELECT * FROM EMP WHERE JOB ^= 'CLERK';

--NOT 연산자
-- JOB이 MANAGER가 아닌 사원만 출력
SELECT * FROM EMP WHERE NOT JOB = 'MANAGER';

--IN 연산자(NOT IN)
--OR 을 간결히 사용하기
--컬럼명 IN (값1, 값2, 값3...) 컬럼의 값이 IN 연산자 안의 값을 만족하면 TRUE
--부서 번호가 10, 30, 이 아닌 사원출력
SELECT * FROM EMP WHERE DEPTNO  NOT IN(10,30);

--BETWEEN A AND B
--급여가 1000이상 3000이하인 사원출력해보기
SELECT * FROM EMP WHERE SAL BETWEEN 1000 AND 3000;

--위의 경우의 반대인 경우
SELECT * FROM EMP WHERE SAL NOT BETWEEN 1100 AND 3000;

--LIKE 연산자
--컬렴명 LIKE '조건식'
--%:모든글자  (_)언더바: 특정글자 수
--S로 시작하는 사원명 출력
SELECT * FROM EMP WHERE ENAME LIKE 'S%';

--사원명이 두 번째 글자가 L 을 포함하는 사원출력 
SELECT * FROM EMP WHERE ENAME LIKE '_L%';

--사원명이 AM 글자를 포함하는 사원출력
SELECT * FROM EMP WHERE ENAME LIKE '%AM%';

--위경우 반대
SELECT * FROM EMP WHERE ENAME NOT LIKE '%AM%';

-- IS NULL 널조건이니? / IN NOT NULL 널이 아닌 조건
-- 커미션이 널인 사원만 출력
--위의 경우 반대인 경우
SELECT * FROM EMP WHERE COMM IS NULL;
SELECT * FROM EMP WHERE COMM IS NOT NULL;

--AND+IS NULL
--JOB가 SALESMAN이고 COMM이 널인 사원출력
SELECT * FROM EMP WHERE JOB = 'SALESMAN' AND COMM IS NULL;
SELECT * FROM EMP WHERE JOB = 'SALESMAN' AND COMM IS NOT NULL;

--OR + IS NULL
--JOB MANAGE이거나
--MGR(직속상관)이 NULL인 사원 출력하기
SELECT * FROM EMP WHERE JOB = 'MANAGER' OR MGR IS NULL;

-- 집합 연산자
--1 UNION 중복제거
--JOB  MANEGER 이거나, DEPTNO 10인 사원 출력
SELECT ENAME,JOB,DEPTNO FROM EMP WHERE JOB = 'MANAGER' UNION 
SELECT ENAME,JOB,DEPTNO FROM EMP WHERE DEPTNO =10;

--2 UNION 중복포함
--JOB  MANEGER 이거나, DEPTNO 10인 사원 출력
SELECT ENAME,JOB,DEPTNO FROM EMP WHERE JOB = 'MANAGER' UNION ALL
SELECT ENAME,JOB,DEPTNO FROM EMP WHERE DEPTNO =10;
--CLARK 중복이 되어서 출력이 됨

-- 3 MINUS (차집합)
-- 부서 번호가 10인 사원들 중에서 
-- 직무가 MANAGER 인 사원을 제외한 모든 사원 출력하기. 
SELECT ENAME,JOB,DEPTNO FROM EMP 
WHERE DEPTNO = 10
MINUS 
SELECT ENAME,JOB,DEPTNO FROM EMP 
WHERE JOB = 'MANAGER';

--4 INTERSECT (교집합)
-- JOB CLERK 이면서 동시에, 부서번호가 20인 사원 SELECT ENAME,JOB,DEPTNO FROM EMP 
SELECT ENAME,JOB,DEPTNO FROM EMP 
WHERE JOB = 'CLERK'
INTERSECT
SELECT ENAME,JOB,DEPTNO FROM EMP 
WHERE DEPTNO = 20;


--퀴즈1
--급여가 2500이상인 사원들의 이름과 급여를 조회하기
SELECT ENAME, SAL FROM EMP WHERE SAL>=2500;

--퀴즈2
--부서번호가 10 또는 20이면서 직무가 'CLERK'  인 사원 조회
SELECT * FROM EMP WHERE DEPTNO IN(10,20) AND JOB = 'CLERK';
--퀴즈3
--수당이 존재하지않는 사원중에서 직무가 'SLAESMAN'인 사원 조회하기
SELECT * FROM EMP WHERE JOB = 'SALESMAN' AND COMM IS NULL;
--퀴즈4
--직무가 'CLERK'인 사원중 급여가 1000이상 1500이하 인 사원 조회
SELECT * FROM EMP WHERE JOB = 'CLERK' AND SAL BETWEEN 1000 AND 1500;
--퀴즈5
--이름에 'DA'포함하는 사원이름과 직무를 조회하기
SELECT ENAME, JOB FROM EMP WHERE ENAME LIKE '%DA%';
--퀴즈6
--부서번호가 10번인 사원중 , 직무가 'MAMAGER' 가 아닌 사원출력하기
--단 MGR이 NULL인 사람도 포함하기
SELECT * FROM EMP WHERE DEPTNO = 10 AND (JOB <>'MANAGER' OR MGR IS NOT NULL);