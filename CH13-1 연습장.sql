-- 데이터베이스를 위한 데이터를 저장한 데이터 사전 

-- | 접두어 | 설명 | 사용 권한 |
-- |--------|------|------------|
-- | `USER_` | 현재 사용자가 소유한 객체 정보 | 모든 사용자 사용 가능 |
-- | `ALL_` | 현재 사용자가 접근 가능한 객체 정보 | 모든 사용자 사용 가능 |
-- | `DBA_` | 모든 사용자의 모든 객체 정보 | DBA, SYSTEM 사용자 전용 |

--데이터 사전 목록 조회 
select *
  from dict;

-- SCOTT 계정 객체 조회 
select *
  from user_objects;

-- SCOTT 계정 접근 가능한 모든 테이블 조회 
select *
  from all_tables
 where owner = 'SCOTT';

-- SYSTEM 계정에서 모든 사용자 조회 
select *
  from dba_users;

-- USER 접두어 
select *
  from user_tables;

-- ALL_ 접두어 사용 VIEW 조회
select *
  from all_views
 where owner = 'SCOTT';

-- SYSTEM 계정에서 DBA_ 접두어 사용 
select username,
       created
  from dba_users;

-- SCOTT 계정에서 현재 자신이 소유한 객체 리스트 조회 
select object_name,
       object_type
  from user_objects;

-- SCOTT 계정에서 모든 테이블의 컬럼 구조를 조회
select table_name,
       column_name,
       data_type,
       data_length
  from user_tab_columns;