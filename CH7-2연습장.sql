--기본문법
--SELECT 그룹열 , 집계함수
--FROM 테이블
--GROUP BY 그룹열
--[ORDER BY 정렬열]

--기본예제확인
select deptno,
       avg(sal)
  from emp
 group by deptno;

--직책별 최대급여
select job,
       max(sal)
  from emp
 group by job;

--부서번호 + 직책 기준 평균 급여
select deptno,
       job,
       avg(sal)
  from emp
 group by deptno,
          job;

--부서별 사원수 구하기
select deptno,
       count(*)
  from emp
 group by deptno;

--각 부서의 평균 급여를 내림 차순으로 정렬해보기
select deptno,
       avg(sal)
  from emp
 group by deptno
 order by avg(sal) desc;

--퀴즈1
--부서번호와 직책별 평균급여를 출력하고 평균 급여 기준 내림차순 정렬
--별칭: 평균급여
select deptno,
       job,
       avg(sal) as "평균급여"
  from emp
 group by deptno,
          job
 order by avg(sal) desc; 

--퀴즈2
--GROUP BY 절에 포함되지 않은 ENAME을 SELECT에서 사용한 경우 오류상황을 만들어보시오
select deptno,
       job,
       ename,
       avg(sal)
  from emp
 group by deptno,
          job,
          ename;

--퀴즈3
--각 부서별로 보너스가 있는 사원의 수를 구하시오
--별칭:보너스

select deptno,
       count(comm) as "보너스"
  from emp
 group by deptno;