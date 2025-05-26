-- 조인 사용 하기 전에 문제점 제시, 
-- 카티션 곱 , 
select *
  from emp; -- 몇개 : 14개
select *
  from dept; -- 몇개 : 10개
-- KING , DEPTNO 10, DNAME : ACCOUNTING , 
-- 이거 외에 다른 부서도 또 출력이됨. 중복이됨. 
select e.ename,
       d.dname  -- 총: 140개 
  from emp e,
       dept d;
select *
  from dept;
select *
  from emp;
-- 테이블 별칭 이용해서, 조인 해보기. 
select e.empno,
       e.sal,
       e.hiredate,
       e.ename,
       e.deptno as "EMP의 부서번호",
       d.deptno as "DEPT의 부서번호",
       d.dname,
       d.loc
  from emp e,
       dept d
 where e.deptno = d.deptno;

-- EMP와 DEPT 테이블 등가 조인하여 부서번호가 30번인
-- 사원만 출력해보기. 
select *
  from emp;
select *
  from dept;

select e.ename,
       e.deptno,
       e.sal,
       e.hiredate,
       d.dname,
       d.deptno,
       d.loc
  from emp e,
       dept d
 where e.deptno = d.deptno
   and e.deptno = 30;


--퀴즈 1
-- EMP 와 DEPT 테이블 조인하여 
-- 관리자(MANAGER)직무를 가진 사원의 이름과 
-- 부서명 출력 해보기.
-- 별칭 : 사원명, 부서명 
select e.ename,
       e.job,
       d.dname
  from emp e,
       dept d
 where e.deptno = d.deptno
   and e.job = 'MANAGER';


--퀴즈 2, 힌트 : 같은 테이블을 활용해보기.
-- 각 사원의 이름과 그 사원의 직속 상관의 이름을 함께 출력해보기. 
-- 별칭 : 사원명, 직속 상관명
select *
  from emp;
select e.empno as "EMP 사원번호",
       e.ename as "EMP 사원명",
       e.mgr as "EMP직속 상관번호",
       m.ename as "EMP2직속 상관명"
  from emp e,
       emp m
 where e.mgr = m.empno;