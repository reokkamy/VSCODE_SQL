-- 사용자 관리 (단순, 생성만 했지, 다른 권한이 없음. 
-- 그래서, 결론은, 접근도 아직은 안된다.)

-- 사용자 생성 예시 
create user lsy2 identified by 1234; -- 사용자 생성

-- 사용자 정보 조회 
select *
  from all_users
 where username = 'LSY2'; -- 새 사용자 확인
-- 사용자 상태 확인
select username,
       account_status,
       created
  from dba_users
 where username = 'LSY2'; 

-- 사용자 비밀번호 변경 
alter user lsy2 identified by 5678; -- 비밀번호 변경
 
 -- 사용자 삭제 
drop user lsy2; -- 기본 사용자 삭제 
drop user lsy2 cascade; -- 사용자 삭제 (CASCADE 옵션으로 모든 객체도 삭제)

-- 사용자 권한 부여 , 기본 권한, 접근 권한, 자원에 접근하는 권한 2가지 확인. 
-- CONNECT : 데이터베이스 접속 가능 권한 
-- RESOURCE : 자원에 접근 가능 권한, 테이블, 인덱스, 시퀀스 등 객체 생성 권한
grant connect to lsy2; -- 세션 생성 권한 부여
grant resource to lsy2; -- 자원 접근 권한 부여

-- RESOURCE 권한으로 테이블 생성 가능
create table user_primay3 (
   id       number(5),
   name     varchar2(20) not null,
    -- USER_ID VARCHAR2(20) PRIMARY KEY -- 방법1
    -- USER_ID2 VARCHAR2(20) CONSTRAINT user_id_primary PRIMARY KEY -- 방법2
   user_id2 varchar2(20) -- 방법3
);

-- SCOTT 계정으로 생성한 테이블 조회. 
select *
  from emp;


-- 퀴즈1, 
-- SYSTEM 계정에서, LSY3 사용자 생성 , 패스워드 1234
create user lsy3 identified by 1234; 
 
-- 퀴즈2, 
-- LSY3 계정에 접근 권한, 자원 권한 부여 
grant connect to lsy3; -- 세션 생성 권한 부여
grant resource to lsy3; -- 자원 접근 권한 부여

  
-- 퀴즈3, 
-- 패스워드 5678 변경해보기., 유저 삭제 확인 
alter user lsy3 identified by 5678;

drop user lsy3 cascade;


--SCOTT 계정으로 생성한 테이블 EMP-> LSY3
grant select on emp to lsy3;
select *
  from scott emp;