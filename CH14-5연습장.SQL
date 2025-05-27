-- 다른 테이블과 관계를 맺는 FOREIGN KEY 제약조건을 추가하는 예제

-- 기본 문법 

-- 방법1, 테이블 생성시, 외래키 설정
create table dept_fk ( -- 부모 테이블 : 1
   deptno number primary key,
   dname  varchar2(20),
   loc    varchar2(20)
);

create table emp_fk ( -- 자식 테이블 : N
   empno  number primary key,
   ename  varchar2(20),
   deptno number,
  -- CONSTRAINT 제약조건_이름 FOREIGN KEY (현재 테이블의 컬럼명:deptno)
  -- REFERENCES (부모테이블: dept_fk) (부모테이블의 컬럼명:deptno)
   constraint fk_dept foreign key ( deptno )
      references dept_fk ( deptno )
);
-- 결론, 외래키 설정은 자식 테이블에서 한다. 

--제약조건 확인
select *
  from user_constraints
 where table_name = 'EMP_FK';

-- 제약 조건 위배 되는 상황 
-- 1) emp_fk 테이블에 데이터를 추가시, 부서 번호가 없는 번호를 입력시 오류
--샘플 데이터 추가
insert into dept_fk values ( 10,
                             '개발부',
                             '서울' );
insert into dept_fk values ( 20,
                             '인사부',
                             '부산' );
select *
  from dept_fk;
insert into emp_fk values ( 100,
                            '홍길동',
                            10 ); -- 정상
insert into emp_fk values ( 101,
                            '강감찬',
                            20 ); -- 정상
insert into emp_fk values ( 102,
                            '이순신',
                            30 ); -- 오류 발생, 30번 부서가 없음
insert into emp_fk values ( 103,
                            '김유신',
                            null ); -- NULL 허용됨
select *
  from emp_fk;
-- 자식 테이블에 , 외래키 설정시, 부모 데이터가 삭제시 같이 삭제되는 옵션 CASCADE 설정 확인. 
-- 부모 데이터 삭제시 확인 
--CASECADE 설정 없이 삭제시 , 오류발생
delete from dept_fk
 where deptno = 10; -- 오류 발생 10번부서 삭제

-- 기존 자식 테이블에서 외래키 설정 삭제 후, 
--CASCADE 설정 추가해서 제약조건 다시 설정
alter table emp_fk drop constraint fk_dept; -- 기존 외래키 제약조건 삭제

-- 외래키 제약조건 다시 설정, CASCADE 옵션 추가
alter table emp_fk
   add constraint fk_dept
      foreign key ( deptno )
         references dept_fk ( deptno )
            on delete cascade;

-- 삭제 테스트 
delete from dept_fk
 where deptno = 10; -- 10번 부서 삭제, 자식 테이블도 같이 삭제됨
select *
  from emp_fk; -- 10번 부서에 속한 사원 데이터도 삭제됨


-- 퀴즈1, 
-- 부모 테이블 : DEPT_FK2 , 
-- 컬럼 : deptno NUMBER PRIMARY KEY,, dname VARCHAR2(20)
-- 자식 테이블 : EMP_FK2, 
-- 컬럼 : empno, ename, deptno, 제약조건명 : fk_dept2
-- 외래키 설정 해보기, 방법1으로 해보기 
create table dept_fk2 ( -- 부모 테이블 : 1
   deptno number primary key,
   dname  varchar2(20),
   loc    varchar2(20)
);
create table emp_fk2 ( -- 자식 테이블 : N
   empno  number primary key,
   ename  varchar2(20),
   deptno number,
  -- CONSTRAINT 제약조건_이름 FOREIGN KEY (현재 테이블의 컬럼명:deptno)
  -- REFERENCES (부모테이블: dept_fk) (부모테이블의 컬럼명:deptno)
   constraint fk_dept2 foreign key ( deptno )
      references dept_fk2 ( deptno )
);
 
-- 퀴즈2, 
-- 제약 조건 위반 확인 
-- 1) 부모테이블 먼저 삭제 시도시 오류 확인
-- 2) 추가시, 부모 테이블에 없는 데이터를 추가시 오류 확인 
insert into dept_fk2 values ( 10,
                              '개발부',
                              '서울' );
insert into dept_fk2 values ( 20,
                              '인사부',
                              '부산' );
select *
  from dept_fk2;
insert into emp_fk2 values ( 100,
                             '홍길동',
                             10 ); -- 정상
insert into emp_fk2 values ( 101,
                             '이순신',
                             20 ); -- 정상
insert into emp_fk2 values ( 102,
                             '강감찬',
                             30 ); -- 오류 발생, 30번 부서가 없음
insert into emp_fk2 values ( 102,
                             '강감찬',
                             null ); --  NULL 입력해보기
select *
  from emp_fk2;
  
-- 퀴즈3, 
-- 3) ON DELETE CASCADE 옵션 설정 및 , 삭제 확인, 부모 데이터 삭제시 
-- 자식 데이터 삭제 확인 해보기 
-- 삭제 테스트 
delete from dept_fk2
 where deptno = 10; -- 10번 부서 삭제, 자식 테이블도 같이 삭제됨
select *
  from emp_fk2; -- 10번 부서에 속한 사원 데이터도 삭제됨

-- 기존 자식 테이블에서 외래키 설정 삭제 후, 
--CASCADE 설정 추가해서 제약조건 다시 설정
alter table emp_fk2 drop constraint fk_dept2; -- 기존 외래키 제약조건 삭제

-- 외래키 제약조건 다시 설정, CASCADE 옵션 추가
alter table emp_fk2
   add constraint fk_dept2
      foreign key ( deptno )
         references dept_fk2 ( deptno )
            on delete cascade;

-- 삭제 테스트 
delete from dept_fk2
 where deptno = 10; -- 10번 부서 삭제, 자식 테이블도 같이 삭제됨
select *
  from emp_fk2; -- 10번 부서에 속한 사원 데이터도 삭제됨