--기본값을 정하는 DEFAULT

--방법1, 테이블 생성시 기본값 추가
create table emp_default (
   empno    number(4),
   ename    varchar2(20),
   hiredate date default sysdate
);



--방법2, ALTER TABLE로 기본값 추가
alter table emp_default add (
   sal number default 1000
);  

--제약 조건 확인
select 8
  from user_tab_columns
 where table_name = 'EMP_DEFAULT';
--제약조건 삭제
alter table emp_default modify (
   sal default null
); -- 기본값 제거

--샘플데이터 추가
insert into emp_default (
   empno,
   ename
) values ( 1,
           '홍길동' ); -- HIREDATE는 SYSDATE로 자동 설정
select *
  from emp_default;

-- 테이블 생성, 제약조건 설정, 샘플 데이터 입력, 제약 조건 확인. 
-- 퀴즈1, 
-- 테이블명 : EMP_MEMBER, 컬럼명 : ID(NUMBER), NAME(VARCHAR2), REGDATE(DATE)
-- REGDATE , 제약 조건 DEFAULT 이용하고, 현재 날짜로 입력하기. 
create table emp_member (
   id      number(4),
   name    varchar2(20),
   regdate date default sysdate
);
alter table emp_member add (
   regdate date default sysdate
);

select *
  from user_tab_columns
 where table_name = 'EMP_MEMBER';

insert into emp_member (
   id,
   name
) values ( 1,
           '홍길동' );
select *
  from emp_member;
-- 퀴즈2, 
-- 테이블명 : PRODUCT, 컬럼명 : PCODE (VARCHAR2), PNAME (VARCHAR2),USE_YN (CHAR(1))
-- USE_YN (CHAR(1)), DEFAULT 이용하고, Y 
create table product (
   pcode  varchar2(10),
   pname  varchar2(50),
   use_yn char(1) default 'Y' check ( use_yn in ( 'Y',
                                                  'N' ) )
);

select *
  from user_tab_columns
 where table_name = 'PRODUCT';

insert into product (
   pcode,
   pname
) values ( 'P001',
           '노트북' );

select *
  from product;
-- 퀴즈3, 
-- 테이블명 : INVENTORY , 컬럼명 : ITEM_ID (NUMBER), QUANTITY (NUMBER)
-- QUANTITY , DEFAULT, 기본 수량 10으로 설정 해보기.
create table inventory (
   item_id  number(4),
   quantity number default 10 check ( quantity >= 0 ) -- 수량은 0 이상
);

select *
  from user_tab_columns
 where table_name = 'INVENTORY';

insert into inventory ( item_id ) values ( 1 );

select *
  from inventory;