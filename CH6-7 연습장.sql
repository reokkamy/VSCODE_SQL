--DECODE, CASE, ->조건문 쉽게 생각하기
--DECODE(표현식, 
--       값1, 반환값1, 
 --      값2, 반환값2, 
 --      ..., 
 --      기본값)

select ename,
       job,
       decode(
          job,
          'MANAGER',
          '관리자',
          'CLERK',
          '사무직',
          'SALESMAN',
          '영업직',
          'PRESIDENT',
          '대표이사',
          'ANALYST',
          '분석팀',
          '기타'
       ) as "직무이름"
  from emp;

--부서번호에 따라 부서명출력 (CASE)
--CASE 컬럼
 -- WHEN 값1 THEN 결과1
--  WHEN 값2 THEN 결과2
 -- ELSE 기본값
--END

select ename,
       deptno,
       case deptno
          when 10 then
             '인사부'
          when 20 then
             '연구개발부'
          when 30 then
             '영업부'
          else
             '기타부서'
       end as "부서명"
  from emp;


--급여에 따라 급여 등급 부여
--E:EMP, S: SALGRADE
select e.ename,
       e.sal,
       case
          when e.sal between s.losal and s.hisal then
             s.grade
       end as "급여 등급"
  from emp e,
       salgrade s;


-----------------------------------------------
--퀴즈1 
-- `DECODE`로 JOB에 따른 직책 명시 
-- (CLERK: 사원, MANAGER: 관리자, ANALYST: 분석가)
-- 별칭 : 직책 이름
select ename,
       job,
       decode(
          job,
          'MANAGER',
          '관리자',
          'CLERK',
          '사원',
          'ANALYST',
          '분석팀',
          '기타'
       ) as "직책이름"
  from emp;

--퀴즈2
-- `CASE`로 근속 연수 분류 
-- (HIREDATE 기준, 1982년 이전: 장기근속, 이후: 일반)
-- 별칭 : 근속 연수
select ename,
       hiredate,
       case
          when hiredate < to_date('1982-01-01','YYYY-MM-DD') then
             '장기근속'
          else
             '일반'
       end as "근속연수"
  from emp;

--퀴즈3
-- `CASE` 단순형으로 DEPTNO에 따라 위치 표시 
--(10: NEW YORK, 20: DALLAS, 30: CHICAGO)
-- 별칭 : 근무 지역

select ename,
       deptno,
       case deptno
          when 10 then
             'NEWYORK'
          when 20 then
             'DALLAS'
          when 30 then
             'CHICAGO'
          else
             '미지정'
       end as "급여 등급"
  from emp;