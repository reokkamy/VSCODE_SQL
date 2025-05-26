-- 비등가 조인,  
-- 외부 조인 (오라클 전용),-> 표준 문법도  같이 소개

-- 비등가 조인 
select e.ename,
       e.sal,
       g.grade,
       g.losal,
       g.hisal
  from emp e,
       salgrade g
 where e.sal between g.losal and g.hisal;

-- 외부 조인 (오라클 전용)
-- 오른쪽 외부 조인, 
-- 오른쪽 기준으로, 왼쪽에 값이 없어도 표기하겠다. 
-- 값이 NULL 이어도 표기 하겠다. 
select e.ename,
       d.dname
  from emp e,
       dept d
 where e.deptno = d.deptno (+);


--원본, 자체 조인 = 등가 조인, MGR = EMPNO
-- NULL  인 경우  , 데이터가 누락이됨.
select *
  from emp;
select e.empno as "EMP 사원번호",
       e.ename as "EMP 사원명",
       e.mgr as "EMP직속 상관번호",
       m.ename as "EMP2직속 상관명"
  from emp e,
       emp m
 where e.mgr = m.empno;

-- 외부 조인 버전으로 변경해서 누락 없이 
-- 왼쪽 컬럼을 기준으로 표기하기. 
-- 왼쪽 외부 조인

select e.empno as "EMP 사원번호",
       e.ename as "EMP 사원명",
       e.mgr as "EMP직속 상관번호",
       m.ename as "EMP2직속 상관명"
  from emp e,
       emp m
 where e.mgr = m.empno (+);



-- 외부 조인 버전으로 변경해서 누락 없이 
-- 오른쪽 컬럼을 기준으로 표기하기. 
-- 오른쪽 외부 조인

select e.empno as "EMP 사원번호",
       e.ename as "EMP 사원명",
       e.mgr as "EMP직속 상관번호",
       m.ename as "EMP2직속 상관명"
  from emp e,
       emp m
 where e.mgr (+) = m.empno;


--퀴즈 1,
-- EMP와 DEPT 테이블에서 부서가 없는 사원도 포함해 
-- 사원명과 부서명을 출력하시오 (왼쪽 외부 조인)
select e.ename,
       d.dname
  from emp e,
       dept d
 where e.deptno = d.deptno (+);

--퀴즈 2
-- 오른쪽 외부 조인을 사용하여 부서가 있지만, 
-- 사원이 없는 부서를 포함해서 출력하시오. 
select e.ename,
       d.dname,
       e.job
  from emp e,
       dept d
 where e.deptno (+) = d.deptno;

--퀴즈 3
-- WHERE 절에 추가 조건(`job = 'CLERK'`)을 넣고 부서별 사원 출력  
select e.ename,
       d.dname
  from emp e,
       dept d
 where e.deptno = d.deptno
   and e.job = 'CLERK';