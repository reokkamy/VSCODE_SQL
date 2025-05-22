--NVL, NVL2 함수 예시

--급여가 NULL이면 0으로 대체
SELECT ENAME,COMM,JOB,  NVL(COMM,0) AS "수당" FROM EMP;

--커미션이 있으면 '0', 없으면 'X' 
SELECT ENAME, NVL2(COMM,'0','X') AS "NVL2함수" FROM EMP;


----------------------------------------------------------
--퀴즈1
--EMP테이블에서 커미션이 있는 직원 'O' 머지는 X로 표시하고 NVL2표기
--별칭 수당여부
SELECT ENAME, NVL2(COMM, '0','X')AS "수당여부" FROM EMP;
--연봉계산해보기,NVL이용해서, NULL인경우 0으로해서 계산해보기
--별칭 전체 급여
SELECT ENAME, SAL*12,NVL(COMM,0), NVL(COMM,0) + SAL*12 AS "전체 급여" FROM EMP;