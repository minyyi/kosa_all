

--회원정보
create table member(
m_code VARCHAR2(12) primary key,
m_idnum NUMBER(13) not null,
m_address VARCHAR2(100) not null,
m_mailId VARCHAR2(20)not null,
m_cellnum number(11) not null
);

--도서선택
create table selectBook (
s_number VARCHAR2(12),
s_code VARCHAR2(12) REFERENCES member(m_code),
s_booknum VARCHAR2(12) not null,
s_pubnum VARCHAR2(12) not null,
s_count NUMBER(3) not null,
s_pubconstart Date not null,
s_price NUMBER(9) not null
);



alter table selectbook 
add CONSTRAINT selectBook_pk PRIMARY key(s_number);

alter table selectbook
add CONSTRAINT selectBook_fk FOREIGN key (s_booknum, s_pubnum, s_pubconstart)
REFERENCES book(b_number, b_publishno, b_stdate);

alter table selectbook 
modify s_code not null;


--선택주문
create  table selectorder (
so_ordernum VARCHAR2(12),
so_getType VARCHAR2(10),
so_selnum VARCHAR2(12) REFERENCES selectbook(s_number)
);

alter table selectorder 
add CONSTRAINT selectorder_pk primary key (so_ordernum, so_getType)
;

alter table selectorder 
modify so_selnum not null;


--주문서
create table orderlist (
o_deliveryNum VARCHAR(12),
o_getType VARCHAR2(10)NOT NULL CHECK (o_getType in ('pickup','delivery')) ,
o_phoneNum NUMBER NOT NULL,
o_orderDate  date NOT NULL,
o_getDate date NOT NULL,
o_delFee number(10),
o_buyTotal NUMBER NOT NULL
);

alter table orderlist 
add CONSTRAINT orderlist_pk primary key (o_deliveryNum, o_getType)
;
alter table orderlist 
modify o_delFee  not null;


-- 택배업체 테이블
CREATE TABLE delivery (
d_deliveryNum VARCHAR(12),
d_startDate date,
d_name VARCHAR2(10) NOT NULL,
d_phoneNum NUMBER NOT NULL,
d_address VARCHAR2(100) NOT NULL,
d_endDate date NOT NULL,
d_state NUMBER(1) NOT NULL CHECK (d_state in (0,1))
);


alter table delivery add CONSTRAINT delivery_pk 
    primary key(d_deliveryNum, d_startDate);
     
    
-- 배송요청서
CREATE TABLE deliveryOrder (

do_deliveryorderNum VARCHAR(12),
do_orderNum VARCHAR(12),
do_getType VARCHAR2(10),
do_deliveryNum VARCHAR(12) NOT NULL,
do_startDate date NOT NULL,
do_getLoc VARCHAR(100) NOT NULL,
do_cost NUMBER NOT NULL
);


alter table deliveryOrder add CONSTRAINT deliveryOrder_pk 
    primary key(do_deliveryorderNum, do_orderNum, do_getType);
    
alter table deliveryOrder add CONSTRAINT deliveryOrder_fk 
    FOREIGN key(do_deliveryNum, do_startDate) REFERENCES delivery(d_deliveryNum, d_startDate);

alter table deliveryOrder add CONSTRAINT deliveryOrder_pk_fk 
    FOREIGN key(do_orderNum, do_getType) REFERENCES orderlist(o_deliveryNum, o_getType);


--book 테이블 생성
CREATE TABLE book (
    b_number VARCHAR2(12),
    b_publishno VARCHAR2(12),
    b_stdate DATE,
    b_name VARCHAR2(50) NOT NULL,
    b_author VARCHAR2(50) NOT NULL,
    b_stpublication DATE NOT NULL,
    b_regularprice NUMBER NOT NULL,
    b_newbook VARCHAR2(50) NOT NULL
    );

--PRIMARY 키 지정
ALTER TABLE book
    ADD CONSTRAINT b_number_pk PRIMARY KEY(b_number, b_publishno, b_stdate);
;
--publisher 테이블 생성--
CREATE TABLE publisher (
    p_publishno VARCHAR2(12),
    p_stdate DATE,
    p_name VARCHAR2(50) NOT NULL,
    p_phonenumber VARCHAR2(50) NOT NULL,
    p_address VARCHAR2(50) NOT NULL,
    p_account VARCHAR2(50) NOT NULL,
    p_eddate DATE NOT NULL,
    p_status NUMBER(1),
    CONSTRAINT p_status CHECK(p_status IN(0,1))
    );
    
    alter table publisher 
modify p_status  not null;
    
--PRIMARY 키 지정
ALTER TABLE publisher
    ADD CONSTRAINT p_publishno_pk PRIMARY KEY(p_publishno, p_stdate)
 ;    
--book 테이블 Forign키 생성
AlTER TABLE book
    ADD CONSTRAINT book_publishno_fk FOREIGN KEY(b_publishno, b_stdate)
        REFERENCES publisher(p_publishno, p_stdate);

-- deliveryaccount 테이블 생성  
CREATE TABLE deliveryaccount (
    d_date DATE NOT NULL,
    d_holidaydiscount NUMBER NOT NULL 
    );

-- 데이터 삽입 deliveryaccount --
INSERT INTO deliveryaccount VALUES('2025-03-26',30);
INSERT INTO deliveryaccount VALUES('2025-03-24',30);




--도서할인
create table bookdiscount (
bd_discount NUMBER,
bd_maxbooksum number,
bd_minbooksum number
)
;

insert into bookdiscount values(5, 99999, 50000);
insert into bookdiscount values(10, 149999, 100000);
insert into bookdiscount values(15, 199999, 150000);
insert into bookdiscount values(20, 99999999999999, 200000);

---------------------------------------------------------------

select b_stpublication, b_name, b_author, b_regularprice
from book
order by b_stpublication desc;

select b_stpublication, b_name, b_author, b_regularprice
from book
where  sysdate <= add_months( b_stpublication , 3)
order by b_stpublication desc;


--신간도서_3개월 이내에 출간 된 책 중 최대 10개까지만 
select a.*
from (
select b_stpublication, b_name, b_author, b_regularprice
from book
where b_stpublication BETWEEN ADD_MONTHS(SYSDATE, -3) AND SYSDATE
order by b_stpublication desc
) a
where rownum <= 10
;

--회원가입확인
select *
from member
where m_mailId = 'member1@mail.com'
;





UPDATE delivery
SET d_state = 0
WHERE d_enddate  < sysdate;

select *
from delivery
where d_enddate < sysdate;

UPDATE publisher
SET p_status = 0
WHERE p_eddate < sysdate;

select *
from publisher
where p_eddate < sysdate;


--공휴일
select *
from deliveryaccount
;

--배송비 공휴일 할증
select o.*, do.d_date, o.o_delfee * 1.3 AS "공휴일_할증"
from orderlist o inner join deliveryorder do
on do.do_ordernumber = o.o_deliverynumber
and deliveryaccount da
on do.d_date in (da.d_date)
;
select o.*, d.d_date, o.o_delfee * 1.3 AS "공휴일_할증"
from orderlist o inner join deliveryaccount d 
ON o.o_getdate = d.d_date
where o.o_getdate in (
    select d_date
    from deliveryaccount
);
select o.*, d.d_date, o.o_delfee * 1.3 AS "공휴일_할증"
from orderlist o 
inner join deliveryaccount d 
ON o.o_getdate = d.d_date;

--where o.o_getdate = da.d_date
--where o.o_getdate in (
--    select d_date
--    from deliveryaccount
--);

select *
from bookdiscount;

select * 
from selectbook
where s_price * s_count "합계" ;

select sb.*, bd.bd_discount
from selectbook sb inner join bookdiscount bd
on sb.s_price between bd.bd_maxbooksum and bd.bd_minbooksum
where sb.s_price ;

