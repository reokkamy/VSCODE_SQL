-- 데이터 형태와 범위를 정하는 CHECK 제약 조건

-- 방법1, 테이블 생성시 제약 조건 추가 
create table emp_check (
   empno    number(4) primary key,
   ename    varchar2(10) not null,
   job      varchar2(9),
   mgr      number(4),
   hiredate date default sysdate,
   sal      number(7,2) check ( sal >= 0 ), -- 급여는 0 이상
   comm     number(7,2) check ( comm >= 0
       or comm is null ), -- 커미션은 0 이상 또는 NULL
   deptno   number(2) check ( deptno in ( 10,
                                        20,
                                        30,
                                        40 ) ) -- 부서번호는 지정된 값 중 하나
);
-- 방법2, 테이블 생성 후 ALTER TABLE 명령어로 제약 조건 추가
alter table emp_check add constraint emp_sal_check check ( sal >= 0 );

-- 제약 조건 조회 
select *
  from user_constraints
 where table_name = 'EMP_CHECK';
-- 제약 조건 삭제 
alter table emp_check drop constraint emp_sal_check;

-- 샘플 데이터 삽입, 제약 조건 위배 확인
insert into emp_check (
   empno,
   ename,
   job,
   sal,
   deptno
) values ( 1,
           '홍길동',
           'CLERK',
           1000,
           10 ); -- 정상
insert into emp_check (
   empno,
   ename,
   job,
   sal,
   deptno
) values ( 2,
           '김철수',
           'MANAGER',
           1000,
           50 ); -- 급여 음수, 제약 조건 위배
insert into emp_check (
   empno,
   ename,
   job,
   sal,
   deptno
) values ( 3,
           '이영희',
           'SALESMAN',
           - 500,
           20 ); -- 급여 음수, 제약 조건 위배
select *
  from emp_check;



-- EMP_CHECK , 테이블 생성해서 해보기
-- 퀴즈1, 
-- 테이블 명: EMP_CHECK , SAL 0 이상, 10000 이하 경우만 입력 허용
 
-- 퀴즈2, 
-- 테이블 명: EMP_CHECK , 직무(JOB) : 'MANAGER', 'CLERK', 'ANALYST', 
-- 현재 직무 외에는 입력 불가 

-- 퀴즈3, 
-- 테이블 명: EMP_CHECK, COMM , NOT NULL 또는 0이상인 조건만 허용.

create table emp_check3 (
   empno    number(4) primary key,
   ename    varchar2(10) not null,
   mgr      number(4),
   hiredate date default sysdate,
    -- NUMBER(7,2) : -- 전체 7자리, 소수점 2자리, 즉 정수 5자리 + 소수 2자리
   sal      number(7,2) check ( sal >= 0
      and sal <= 10000 ), -- 급여는 0 이상
   job      varchar2(9) check ( job in ( 'MANAGER',
                                    'CLERK',
                                    'ANALYST' ) ), -- 직무는 지정된 값 중 하나
   comm     number(7,2) check ( comm >= 0
      and comm is not null ), -- 커미션은 0 이상 또는 NULL
   deptno   number(2) check ( deptno in ( 10,
                                        20,
                                        30,
                                        40 ) ) -- 부서번호는 지정된 값 중 하나
);
-- 제약 조건 조회
select *
  from user_constraints
 where table_name = 'EMP_CHECK2';

insert into emp_check2 (
   empno,
   ename,
   job,
   sal,
   deptno
) values ( 1,
           '홍길동',
           'CLERK2',
           1000,
           10 );
insert into emp_check2 (
   empno,
   ename,
   job,
   sal,
   deptno
) values ( 1,
           '홍길동',
           'CLERK',
           100000,
           10 );
insert into emp_check3 (
   empno,
   ename,
   job,
   sal,
   comm
) values ( 2,
           '홍길동',
           'CLERK',
           1000,
           null );
select *
  from emp_check3;