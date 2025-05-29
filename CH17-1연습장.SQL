--copilot, gpt ,ai툴을 이요해서

--샘플 디비 설계 (쇼핑몰 예시)
--ERD 다이어그램 확인
--시퀀스 다이어그램 확인
--DFD다이어그램 확인

--샘플 디비 설계, 쇼핑몰을 예시로해서
--간단한 프롬프트 명령어를 작성

예시
간단한 쇼핑몰  DB설계를 할거야
생각한 테이블은 사용자, 게시글, 댓글, 상품, 장바구니, 주문, 결제, 배송
중간테이블(장바구니에 담긴 상품). (주문된 상품) 등도 고려해줘
혹시나 빠진 중간 테이블이 있다면 추가도 해줘
설계한 코드는 DDL.sql파일로 제공해주고,
create 코드 형식으로 코드 알려줘

--1차견본 받은후
-- filepath: c:\Users\it\Documents\ORACLE SQL\DDL.sql

-- 사용자 테이블
CREATE TABLE USERS (
    USER_ID      NUMBER(10) PRIMARY KEY,
    USERNAME     VARCHAR2(30) NOT NULL,
    PASSWORD     VARCHAR2(100) NOT NULL,
    EMAIL        VARCHAR2(100) NOT NULL,
    REGDATE      DATE DEFAULT SYSDATE
);

-- 게시글 테이블
CREATE TABLE POSTS (
    POST_ID      NUMBER(10) PRIMARY KEY,
    USER_ID      NUMBER(10) REFERENCES USERS(USER_ID),
    TITLE        VARCHAR2(100) NOT NULL,
    CONTENT      VARCHAR2(1000),
    REGDATE      DATE DEFAULT SYSDATE
);

-- 댓글 테이블
CREATE TABLE COMMENTS (
    COMMENT_ID   NUMBER(10) PRIMARY KEY,
    POST_ID      NUMBER(10) REFERENCES POSTS(POST_ID),
    USER_ID      NUMBER(10) REFERENCES USERS(USER_ID),
    CONTENT      VARCHAR2(500),
    REGDATE      DATE DEFAULT SYSDATE
);

-- 상품 테이블
CREATE TABLE PRODUCTS (
    PRODUCT_ID   NUMBER(10) PRIMARY KEY,
    NAME         VARCHAR2(100) NOT NULL,
    PRICE        NUMBER(10,2) NOT NULL,
    STOCK        NUMBER(10) DEFAULT 0,
    DESCRIPTION  VARCHAR2(1000),
    REGDATE      DATE DEFAULT SYSDATE
);

-- 장바구니 테이블
CREATE TABLE CARTS (
    CART_ID      NUMBER(10) PRIMARY KEY,
    USER_ID      NUMBER(10) REFERENCES USERS(USER_ID),
    CREATED_AT   DATE DEFAULT SYSDATE
);

-- 장바구니에 담긴 상품 (중간테이블)
CREATE TABLE CART_ITEMS (
    CART_ITEM_ID NUMBER(10) PRIMARY KEY,
    CART_ID      NUMBER(10) REFERENCES CARTS(CART_ID),
    PRODUCT_ID   NUMBER(10) REFERENCES PRODUCTS(PRODUCT_ID),
    QUANTITY     NUMBER(5) DEFAULT 1
);

-- 주문 테이블
CREATE TABLE ORDERS (
    ORDER_ID     NUMBER(10) PRIMARY KEY,
    USER_ID      NUMBER(10) REFERENCES USERS(USER_ID),
    ORDER_DATE   DATE DEFAULT SYSDATE,
    STATUS       VARCHAR2(20)
);

-- 주문된 상품 (중간테이블)
CREATE TABLE ORDER_ITEMS (
    ORDER_ITEM_ID NUMBER(10) PRIMARY KEY,
    ORDER_ID      NUMBER(10) REFERENCES ORDERS(ORDER_ID),
    PRODUCT_ID    NUMBER(10) REFERENCES PRODUCTS(PRODUCT_ID),
    QUANTITY      NUMBER(5) DEFAULT 1,
    PRICE         NUMBER(10,2) NOT NULL
);

-- 결제 테이블
CREATE TABLE PAYMENTS (
    PAYMENT_ID   NUMBER(10) PRIMARY KEY,
    ORDER_ID     NUMBER(10) REFERENCES ORDERS(ORDER_ID),
    AMOUNT       NUMBER(10,2) NOT NULL,
    PAYMENT_DATE DATE DEFAULT SYSDATE,
    METHOD       VARCHAR2(30)
);

-- 배송 테이블
CREATE TABLE DELIVERIES (
    DELIVERY_ID  NUMBER(10) PRIMARY KEY,
    ORDER_ID     NUMBER(10) REFERENCES ORDERS(ORDER_ID),
    ADDRESS      VARCHAR2(200) NOT NULL,
    STATUS       VARCHAR2(20),
    DELIVERY_DATE DATE
);

-- (선택) 찜/좋아요 테이블 (추가 중간테이블 예시)
CREATE TABLE WISHLISTS (
    WISHLIST_ID  NUMBER(10) PRIMARY KEY,
    USER_ID      NUMBER(10) REFERENCES USERS(USER_ID),
    PRODUCT_ID   NUMBER(10) REFERENCES PRODUCTS(PRODUCT_ID),
    REGDATE      DATE DEFAULT SYSDATE
);


--누락된 부분, 또는 테스트나 검증등을 해서 수정될 가능성이 있음
--예시
제공해준 테이블을 이용해서, 샘플 데이터를 추가하는 예시를 제공해줘
각각의 모든 테이블을 검사 할 수 있는 샘플 데이터를 추가하는 예시코드
추가하는 명령어, 조회 명령어도 같이 첨부해줘

--샘플 데이터 추가 예시 및 조회 예시
-- USERS (사용자)
INSERT INTO USERS (USER_ID, USERNAME, PASSWORD, EMAIL) VALUES (1, 'hong', 'pw123', 'hong@test.com');
INSERT INTO USERS (USER_ID, USERNAME, PASSWORD, EMAIL) VALUES (2, 'kim', 'pw456', 'kim@test.com');
SELECT * FROM USERS;

-- PRODUCTS (상품)
INSERT INTO PRODUCTS (PRODUCT_ID, NAME, PRICE, STOCK, DESCRIPTION) VALUES (1, '노트북', 1200000, 10, '고성능 노트북');
INSERT INTO PRODUCTS (PRODUCT_ID, NAME, PRICE, STOCK, DESCRIPTION) VALUES (2, '마우스', 20000, 50, '무선 마우스');
SELECT * FROM PRODUCTS;

-- CARTS (장바구니)
INSERT INTO CARTS (CART_ID, USER_ID) VALUES (1, 1);
INSERT INTO CARTS (CART_ID, USER_ID) VALUES (2, 2);
SELECT * FROM CARTS;

-- CART_ITEMS (장바구니에 담긴 상품)
INSERT INTO CART_ITEMS (CART_ITEM_ID, CART_ID, PRODUCT_ID, QUANTITY) VALUES (1, 1, 1, 1);
INSERT INTO CART_ITEMS (CART_ITEM_ID, CART_ID, PRODUCT_ID, QUANTITY) VALUES (2, 1, 2, 2);
SELECT * FROM CART_ITEMS;

-- ORDERS (주문)
INSERT INTO ORDERS (ORDER_ID, USER_ID, STATUS) VALUES (1, 1, '결제완료');
INSERT INTO ORDERS (ORDER_ID, USER_ID, STATUS) VALUES (2, 2, '배송중');
SELECT * FROM ORDERS;

-- ORDER_ITEMS (주문된 상품)
INSERT INTO ORDER_ITEMS (ORDER_ITEM_ID, ORDER_ID, PRODUCT_ID, QUANTITY, PRICE) VALUES (1, 1, 1, 1, 1200000);
INSERT INTO ORDER_ITEMS (ORDER_ITEM_ID, ORDER_ID, PRODUCT_ID, QUANTITY, PRICE) VALUES (2, 2, 2, 2, 40000);
SELECT * FROM ORDER_ITEMS;

-- PAYMENTS (결제)
INSERT INTO PAYMENTS (PAYMENT_ID, ORDER_ID, AMOUNT, METHOD) VALUES (1, 1, 1200000, '카드');
INSERT INTO PAYMENTS (PAYMENT_ID, ORDER_ID, AMOUNT, METHOD) VALUES (2, 2, 40000, '계좌이체');
SELECT * FROM PAYMENTS;

-- DELIVERIES (배송)
INSERT INTO DELIVERIES (DELIVERY_ID, ORDER_ID, ADDRESS, STATUS) VALUES (1, 1, '서울시 강남구', '배송완료');
INSERT INTO DELIVERIES (DELIVERY_ID, ORDER_ID, ADDRESS, STATUS) VALUES (2, 2, '부산시 해운대구', '배송중');
SELECT * FROM DELIVERIES;

-- POSTS (게시글)
INSERT INTO POSTS (POST_ID, USER_ID, TITLE, CONTENT) VALUES (1, 1, '첫 게시글', '안녕하세요!');
INSERT INTO POSTS (POST_ID, USER_ID, TITLE, CONTENT) VALUES (2, 2, '리뷰', '상품이 좋아요.');
SELECT * FROM POSTS;

-- COMMENTS (댓글)
INSERT INTO COMMENTS (COMMENT_ID, POST_ID, USER_ID, CONTENT) VALUES (1, 1, 2, '환영합니다!');
INSERT INTO COMMENTS (COMMENT_ID, POST_ID, USER_ID, CONTENT) VALUES (2, 2, 1, '감사합니다.');
SELECT * FROM COMMENTS;

-- WISHLISTS (찜/좋아요)
INSERT INTO WISHLISTS (WISHLIST_ID, USER_ID, PRODUCT_ID) VALUES (1, 1, 2);
INSERT INTO WISHLISTS (WISHLIST_ID, USER_ID, PRODUCT_ID) VALUES (2, 2, 1);
SELECT * FROM WISHLISTS;

--검사 도구로, 다이어그램 등을 이용해서 그림으로 확인.
--
--아래 사이트에서, 그림 도식화 할 예정,
--https://www.gist.github.com
--.md 파일에, mermaid 라는 문법을 통해서, erd 그림을 그리기

--예시, 연속적으로 작업 하는 중이라서, 이미 코파일럿 메모리에 작성된 테이블이 있다는 가정하에
--만약 연속 작업이 아니라고 한다면, 실제 테이블을 같이 복사를 하고 물어보기

--현재는 , 연속적인 상황이라서, 이렇게만 질의하기
-- 위에 작성된 ddl.sql 파일, create 테이블을 참고해서,
-- mermaid 문법으로, erd 다이어그램 작성하는 코드 생성해줘

-- 1차 결과 코드에서, 앞쪽에 (`) 백티 3개 있고, 맨 마지막에도 (`) 백티 3개 있음
-- 여기서 마지막 백틱 3개는 삭제 .

 ```mermaid
erDiagram
    USERS {
        NUMBER USER_ID PK
        VARCHAR2 USERNAME
        VARCHAR2 PASSWORD
        VARCHAR2 EMAIL
        DATE REGDATE
    }
    POSTS {
        NUMBER POST_ID PK
        NUMBER USER_ID FK
        VARCHAR2 TITLE
        VARCHAR2 CONTENT
        DATE REGDATE
    }
    COMMENTS {
        NUMBER COMMENT_ID PK
        NUMBER POST_ID FK
        NUMBER USER_ID FK
        VARCHAR2 CONTENT
        DATE REGDATE
    }
    PRODUCTS {
        NUMBER PRODUCT_ID PK
        VARCHAR2 NAME
        NUMBER PRICE
        NUMBER STOCK
        VARCHAR2 DESCRIPTION
        DATE REGDATE
    }
    CARTS {
        NUMBER CART_ID PK
        NUMBER USER_ID FK
        DATE CREATED_AT
    }
    CART_ITEMS {
        NUMBER CART_ITEM_ID PK
        NUMBER CART_ID FK
        NUMBER PRODUCT_ID FK
        NUMBER QUANTITY
    }
    ORDERS {
        NUMBER ORDER_ID PK
        NUMBER USER_ID FK
        DATE ORDER_DATE
        VARCHAR2 STATUS
    }
    ORDER_ITEMS {
        NUMBER ORDER_ITEM_ID PK
        NUMBER ORDER_ID FK
        NUMBER PRODUCT_ID FK
        NUMBER QUANTITY
        NUMBER PRICE
    }
    PAYMENTS {
        NUMBER PAYMENT_ID PK
        NUMBER ORDER_ID FK
        NUMBER AMOUNT
        DATE PAYMENT_DATE
        VARCHAR2 METHOD
    }
    DELIVERIES {
        NUMBER DELIVERY_ID PK
        NUMBER ORDER_ID FK
        VARCHAR2 ADDRESS
        VARCHAR2 STATUS
        DATE DELIVERY_DATE
    }
    WISHLISTS {
        NUMBER WISHLIST_ID PK
        NUMBER USER_ID FK
        NUMBER PRODUCT_ID FK
        DATE REGDATE
    }

    USERS ||--o{ POSTS : "writes"
    USERS ||--o{ COMMENTS : "writes"
    USERS ||--o{ CARTS : "has"
    USERS ||--o{ ORDERS : "places"
    USERS ||--o{ WISHLISTS : "likes"
    POSTS ||--o{ COMMENTS : "has"
    PRODUCTS ||--o{ CART_ITEMS : "in"
    PRODUCTS ||--o{ ORDER_ITEMS : "ordered"
    PRODUCTS ||--o{ WISHLISTS : "wished"
    CARTS ||--o{ CART_ITEMS : "contains"
    ORDERS ||--o{ ORDER_ITEMS : "contains"
    ORDERS ||--o{ PAYMENTS : "paid by"
    ORDERS ||--o{ DELIVERIES : "delivered by"


    --gist.github.com 사이트 접속, 로그인
    --READ.md 파일을 만들어서,
    --위의 코드를 복사 할 예정

--같은 형식으로,
--2)DFD 다이어그램 코드 만들어줘


--gist.github.com 사이트 접속, 로그인
--READ.md 파일을 만들어서,
--위의 코드를 복사 할 예정

--  앞쪽에 (`) 백티 3개 있고, 맨 마지막에도 (`) 백티 3개 있음
-- 여기서 마지막 백틱 3개는 삭제 .

```mermaid
flowchart TD
    사용자((사용자))
    게시글((게시글))
    댓글((댓글))
    상품((상품))
    장바구니((장바구니))
    장바구니상품((장바구니에 담긴 상품))
    주문((주문))
    주문상품((주문된 상품))
    결제((결제))
    배송((배송))
    찜((찜/좋아요))

    사용자-->|게시글 작성|게시글
    사용자-->|댓글 작성|댓글
    사용자-->|상품 조회/구매|상품
    사용자-->|장바구니 생성|장바구니
    장바구니-->|상품 담기|장바구니상품
    사용자-->|주문 생성|주문
    주문-->|상품 포함|주문상품
    주문-->|결제 요청|결제
    주문-->|배송 요청|배송
    사용자-->|찜/좋아요|찜
    상품-->|찜/좋아요 대상|찜
    게시글-->|댓글 달기|댓글

--3)시퀀스 다이어그램 코드 만들어줘
--  앞쪽에 (`) 백티 3개 있고, 맨 마지막에도 (`) 백티 3개 있음
-- 여기서 마지막 백틱 3개는 삭제 .

```mermaid
sequenceDiagram
    participant U as 사용자
    participant C as 장바구니
    participant CI as 장바구니상품
    participant P as 상품
    participant O as 주문
    participant OI as 주문상품
    participant Pay as 결제
    participant D as 배송

    U->>P: 상품 조회
    U->>C: 장바구니 생성/조회
    U->>CI: 장바구니에 상품 추가
    CI->>P: 상품 정보 참조
    U->>O: 주문 생성
    O->>OI: 주문상품 생성
    OI->>P: 주문 상품 정보 참조
    U->>Pay: 결제 요청
    Pay->>O: 결제 처리
    O->>D: 배송 요청
    D->>U: 배송 상태 알림

    --gist.github.com 사이트 접속, 로그인
--READ.md 파일을 만들어서,
--위의 코드를 복사 할 예정

--기스트에서 임베디드 코드 복사후
<script src="https://gist.github.com/reokkamy/d3935cdfeef73af23789b3d4f6397123.js"></script>

commit;