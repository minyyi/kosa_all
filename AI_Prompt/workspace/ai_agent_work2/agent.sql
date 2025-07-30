SELECT sno "학번", sname "이름", avr "학점" 
FROM student;


SELECT sno "학번", sname "이름", ceil(avr / 8 * 9) "환산학점" 
FROM student;


SELECT cno "과목번호", cname "과목명", st_num "학점수" 
FROM course;

SELECT section "학과", pname "교수이름", orders "직위", hiredate
FROM professor 
    ORDER BY section, hiredate;
    
    
SELECT eno "사원번호", ename "사원이름", sal*1.1 "연봉" 
FROM emp 
    ORDER BY sal DESC;

SELECT syear "학년", sname "이름", avr "학점" 
FROM student
    WHERE avr BETWEEN 2.0 AND 3.0
    AND syear IN (2 , 3);


SELECT syear "학년", sname "이름", avr "학점", major "학과"
FROM student
    WHERE syear IN (1,2)
    AND major IN ('화학', '물리')
    ORDER BY avr DESC;
    
SELECT section "학과", pname "교수이름", orders "직위", hiredate
FROM professor 
    WHERE section IN  ('화학')
      AND    orders IN ('정교수');
--    ORDER BY section, hiredate;
   
SELECT  sname "이름",  major "학과"
FROM student
    WHERE major='화학'
    AND sname like '관%'; 
    
SELECT  pname "교수이름", orders "직위", hiredate
FROM professor 
WHERE hiredate <= '95/01/01'
      AND  orders ='정교수';
   
SELECT  sname "이름",  major "학과",avr "환산학점"
FROM student
    WHERE major='화학'
    AND (avr / 8 * 9) >= 3.5;
    
SELECT  sname "이름", syear "학년", major "학과",avr "학점"
FROM student
    WHERE not major='화학'
    order BY major, syear ;
    
    
SELECT  major "학과", syear "학년", avg(avr)
FROM student
WHERE major='화학'
    GROUP BY syear, major;
    
    
select major, count(*)
from student
group by major;

select major, AVG(avr / 8 * 9)
from student
    WHERE major in ('화학','생물')
    group by major;
    
select major, AVG(avr)
from student
-- WHERE not major='화학'
 GROUP by major
 HAVING not major='화학'
 ;
 
select major, AVG(avr)
from student
-- WHERE not major='화학'
 GROUP by major
 HAVING not major='화학' 
 and avg(avr) > 2.0
 ;
 
 select count(*), dno
 from emp
 group by dno 
 having count(*) >= 3;
 
 
 select 'DataBase', lower('DataBase') from dual;
 
 select substr('abcdef', 2, 3) from dual;
 
 select cname, substr(cname,1, length(cname)-1)
 from course;
 
 select 'Oracle', rpad('Oracle', 10, '#') from dual;
 select round (23423.23523423423, 2) from dual;
select sysdate + 1 "내일" from dual;


select p.pname,c.cname, c.pno
from professor p, course c
where p.pno = c.pno
--이너조인
and p.pname = '송강';

select s.sno,s.sname, s.syear,s.major , sc.result 
from student s, score sc
where s.sno = sc.sno 
--이너조인
and major = '화학'
and s.syear = '1';

select s.sno,s.sname, s.syear,s.major , c.cno, c.cname
from student s, score sc, course c
where s.sno = sc.sno 
and c.cno = sc.cno
--이너조인
and major = '화학'
and s.syear = '1'
group by s.sname,c.cname, s.sno, s.syear, s.major , c.cno ;

select major, syear, sname, cname
from student s, score s1, course c
where  s.sno = s1.sno
and c.cno = s1.cno
and major = '화학'
and s.syear = 1;

select DISTINCT A.sname, B.sname
from student A, student B
where A.sname = B.sname
and a.sno != b.sno
;

select DISTINCT A.sno, A.sname
from student A, student B
where A.sname = B.sname
and a.sno != b.sno
;

select * from course;


select p.pname, c.cname, c.cno, c.st_num
from course c full join professor p
on c.pno = p.pno
;

select  ename, sal, grade
from emp, salgrade
where sal BETWEEN losal and hisal
order by grade
;

select ename, dno, job
from emp
where ename='정의찬'
;

select dno, job, ename
from emp
where job = (select job
from emp
where ename='정의찬')
and dno != (select dno
from emp
where ename='정의찬'
)
;

select max(avg(sal)) 
from emp
group by dno
;

select dno 
from emp
GROUP by dno 
HAVING avg(sal) = (
select max(avg(sal)) 
from emp
group by dno
)
;

select max(count(*))
from student
GROUP by major
;

select major, count(*)
from student
group by major
having count(*) = (
select max(count(*))
from student
GROUP by major
)
;

select min(avg(result))
from score sc
group by sno
; 

select s.sno, s.sname, avg(result)
from student s, score sc
where sc.sno = s.sno
group by s.sno, s.sname
having avg(result) = (
select min(avg(result))
from score
group by sno
);

select avg(avr)
from student
where syear = 1
and major= '화학'
;

select *
from student
where major = '화학'
and syear = 1
and avr < (
select avg(avr)
from student
where syear = 1
)
;

select mgr, job
from emp e
where ename = '손하늘'
;

select mgr, job,ename
from emp e
where (mgr, job) in (
select mgr, job
from emp e
where ename = '손하늘'
)
;

select avr, sname
from student
where major = '화학'
;

select sno, sname, avr, major
from student
where avr in (
select avr
from student
where major = '화학'
)
;


select sno, sname, avr, syear, major
from student
where (avr, syear) in (
select avr, syear
from student
where major = '화학'
)
;

create table board (
seq number primary key,
title varchar2(50),
writer varchar2(50),
contents varchar2(200),
regdate date,
hitcount number
);
create sequence board_seq
;

insert into board VALUES(10, 'a1', 'a','a', sysdate, 0);

select * from board
order by seq desc
;

select a.*
from (
select * from board
order by seq desc
)a
where rownum BETWEEN 6 and 10;
;

select rownum as row_num, temp.*
from (
select * from board
order by seq desc
) temp
;
select * 
from 
        (
        select rownum as row_num, temp.*
        from (
                    select * from board
                    order by seq desc
        ) temp
)
where row_num between 3and 7
;

drop table board ;

create table blog (
 id number,
 title varchar2(50),
 content varchar2(200),
 author_id number
);


create table author(
 author_id number,
 name varchar2(50),
 address varchar2(50)
);

alter table blog
    add constraint blog_id_pk Primary key(id);
    
alter table author
 add constraint author_author_id Primary key(author_id);
 
 alter table blog 
    add constraint blog_author_id_fk foreign key (author_id)
    references author(author_id);
    
insert into author values(100, '홍길동', '서울');   
insert into author values(200, '박길동', '제주');   


commit;

insert into blog values(1, '자바', 'good', 100);
insert into blog values(2, 'jsp', 'very good', 200);

select
		b.id as id,
		b.title as title,
		b.content as content,
		a.author_id as author_id,
		a.name as name,
		a.address as address
		from blog b, author a
		where b.author_id = a.author_id
		and id = 1;
        
        create table tbl_reply (
  rno number(10,0), 
  bno number(10,0) not null,
  reply varchar2(1000) not null,
  replyer varchar2(50) not null, 
  replyDate date default sysdate, 
  updateDate date default sysdate
);

create sequence seq_reply;

alter table tbl_reply add constraint pk_reply primary key (rno);

alter table tbl_reply  add constraint fk_reply_board  
foreign key (bno)  references  tbl_board (bno); 



create table tbl_sample1(
 col1 varchar2(500)
);

create table tbl_sample2(
 col2 varchar2(50)
);

commit;

alter table tbl_board add(
    replycnt number default 0);
    
    UPDATE tbl_board set replycnt = (
    select count(rno) 
    from tbl_reply 
    where tbl_reply.bno = tbl_board.bno);
    
    commit;
    
    create table tbl_member(
      userid varchar2(50) not null primary key,
      userpw varchar2(100) not null,
      username varchar2(100) not null,
      regdate date default sysdate, 
      updatedate date default sysdate,
      enabled char(1) default '1');
      
      create table tbl_member_auth (
     userid varchar2(50) not null,
     auth varchar2(50) not null,
     constraint fk_member_auth foreign key(userid) references tbl_member(userid)
);

create table users(
  id number primary key,
  name varchar2(50),
  joinDate DATE,
  password varchar2(50),
  ssn varchar2(50)
);
create sequence user_seq;

insert into users values(user_seq.nextval,'User1', sysdate, 'test1111','750411-111111');
insert into users values(user_seq.nextval,'User2', sysdate, 'test2222','850411-111111');
insert into users values(user_seq.nextval,'User3', sysdate, 'test3333','950411-111111');

commit;

create table post(
  id number primary key,
  description varchar2(50),
  user_id number references users(id)
);

create sequence post_seq;

insert into post values(post_seq.nextval, 'first post', 1);

create table restaurant (
    id number primary key,
    name varchar2(100),
    address varchar2(300),
    create_at Date,
    update_at Date    
);


    
create table r_menu (    
    m_id number primary key,
    r_id number references restaurant(id),
    name varchar2(100),
    price int,
    created_at Date,
    updated_at Date
    );
    
create table review (
    rv_id number primary key,
    r_id number references restaurant(id),
    content varchar2(500),
    score float,
    created_at Date
    );
    insert into restaurant 
    values(restaurant_seq.nextval, '맛집', '서울시 서초구 방배동', sysdate, sysdate);
    
    commit;
    
 insert into restaurant 
    values(restaurant_seq.nextval, '맛있는 밥집', '서울시 송파구 가락동', sysdate, sysdate);
    
    commit;
    
ALTER TABLE restaurant RENAME COLUMN create_at TO created_at;
ALTER TABLE restaurant RENAME COLUMN update_at TO updated_at;

create sequence  restaurant_seq;
create sequence  r_menu_seq;
create sequence  review_seq;

select * from restaurant;

INSERT INTO r_menu (m_id, r_id, name, price)
VALUES (r_menu_seq.NEXTVAL, 2, '부대찌개', 9000);

INSERT INTO r_menu (m_id, r_id, name, price)
VALUES (r_menu_seq.NEXTVAL, 2, '고추장찌개', 7000);

select * from r_menu;