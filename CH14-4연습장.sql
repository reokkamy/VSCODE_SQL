-- 유일하게 하나만 있는 값 PRIMARY KEY 제약조건을 가진 테이블을 생성합니다.

-- 방법1 , 테이블 생성시, 기본으로 , 이름 지정 없이 만들기
-- 방법2, 테이블 생성시, 제약 조건 이름을 설정해서 만들기 
-- 방법3, 테이블 생성 후, 제약 조건을 추가해서 만들기

create table user_table (
   id      number(5) primary key, --방법1
   name    varchar2(20) not null,
   user_id varchar2(20)
      constraint user_id_unique unique
);
-- -- 방법2, 테이블 생성시, 제약 조건 이름을 설정해서 만들기
create table user_table (
   id      number(5)
      constraint user_table_pk primary key, -- 방법2
   name    varchar2(20) not null,
   user_id varchar2(20)
      constraint user_id_unique unique
);
-- 방법3, 테이블 생성 후, 제약 조건을 추가해서 만들기
create table user_table (
   id      number(5),
   name    varchar2(20) not null,
   user_id varchar2(20)
      constraint user_id_unique unique
);
-- 방법3
alter table user_table add constraint user_table_pk primary key ( id );

-- 제약조건 확인 , 데이터 사전
select *
  from user_constraints
 where table_name = 'USER_TABLE';

--PK 생성 시 , 자동으로 인덱스 설정함, 인덱스 확인 , 데이터 사전 
select *
  from user_indexes
 where table_name = 'USER_TABLE';

-- PK 제약조건 삭제 
alter table user_table drop constraint user_table_pk;

-- 샘플 데이터 추가, 중복 방지 확인
insert into user_table (
   id,
   name,
   user_id
) values ( 1,
           '홍길동',
           'HONG' );
insert into user_table (
   id,
   name,
   user_id
) values ( 1,
           '이순신',
           'LEE' );

-- 샘플 데이터 추가, NULL 방지 확인
insert into user_table (
   id,
   name,
   user_id
) values ( null,
           '강감찬',
           'KANG' );

-- 퀴즈1, 
-- 테이블 생성 시 PRIMARY 지정 해보기, 방법 1, 2,3 
-- 테이블명 :  user_primay, 컬럼, user_id에 PRIMARY 설정 
drop table user_primay;
create table user_primay (
   id       number(5),
   name     varchar2(20) not null,
    -- USER_ID VARCHAR2(20) PRIMARY KEY -- 방법1
    -- USER_ID2 VARCHAR2(20) CONSTRAINT user_id_primary PRIMARY KEY -- 방법2
   user_id2 varchar2(20) -- 방법3
);
alter table user_primay add constraint user_id_primary primary key ( user_id2 ); -- 방법3
-- 제약조건 확인 , 데이터 사전
select *
  from user_constraints
 where table_name = 'USER_PRIMAY';
 
-- 퀴즈2, 
-- 테이블 생성 후, 제약 조건 추가 , 
-- 테이블명 :  user_primay2, 컬럼, user_id에 PRIMARY 설정 
create table user_primay2 (
   id       number(5),
   name     varchar2(20) not null,
    -- USER_ID VARCHAR2(20) PRIMARY KEY -- 방법1
    -- USER_ID2 VARCHAR2(20) CONSTRAINT user_id_primary PRIMARY KEY -- 방법2
   user_id2 varchar2(20) -- 방법3
);
alter table user_primay2 add constraint user_id_primary_q2 primary key ( user_id2 ); -- 방법3
-- 제약조건 확인 , 데이터 사전
select *
  from user_constraints
 where table_name = 'USER_PRIMAY2';
-- 퀴즈3, 
-- user_primay2 , 데이터 입력 . 
-- 중복 , null 테스트도 해보기. 
-- 샘플 데이터 추가, 중복 방지 확인
insert into user_primay2 (
   id,
   name,
   user_id2
) values ( 1,
           '홍길동',
           'HONG' );
insert into user_primay2 (
   id,
   name,
   user_id2
) values ( 2,
           '이순신',
           'HONG' );

-- 샘플 데이터 추가, NULL 방지 확인
insert into user_primay2 (
   id,
   name,
   user_id2
) values ( 3,
           '강감찬',
           null );