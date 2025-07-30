select job, substr(job, 1, 2), substr(job, -3)
from emp;
--1
select deptno, empno, ename, sal
from emp
where deptno =10;
--2
select empno, deptno, ename, hiredate
from emp
where empno =7369;
--3
select *
from emp
where ename='ALLEN';
--5
select *
from emp
where job!='MANAGER';
--6
select *
from emp
where hiredate >='81/04/02';
--7
select  ename, sal, deptno
from emp
where sal >=800;
--8
select *
from emp
where deptno>=20;
--10
select *
from emp
where hiredate <='81/12/09';
--11
select empno, ename
from emp
where empno <=7698;

--12
select ename, hiredate, sal, deptno
from emp
where hiredate >'81/04/02'
and  hiredate <'82/12/09';

--13
select  ename, sal, job
from emp
where sal >1600
and sal < 3000;

--14
select *
from emp
where empno between 7654 and 7782;

--15
select*
from emp
where ename between 'B' and 'J';

--16
select *
from emp
where hiredate not like '81/%' ;

--17
select *
from emp
where job IN ('MANAGER', 'SALESMAN') ;

--18
select empno, ename, deptno
from emp
where deptno NOT IN (20, 30) ;

--19
select empno, ename, hiredate,  deptno
from emp
where ename like 'S%' ;

--20
select *
from emp
where hiredate like '81/%' ;

--21
select *
from emp
where ename like '%S%';

--23
select empno, ename, hiredate, deptno
from emp
where ename like '_A%';

select *
from emp
where substr(ename, 2,1)='A';

--24
select *
from emp
where comm is null;

--25
select *
from emp
where comm is not null;

--26
select  ename,  sal, deptno
from emp
where deptno =30
and sal >=1500 
;

--27
select empno, ename,deptno
from emp
where ename like 'K%'
or deptno =30; 

--28
select *
from emp
where sal >= 1500
and deptno=30
and job='MANAGER';

--29
select *
from emp
WHERE deptno=30
ORDER BY empno;

--30
select *
from emp
ORDER BY sal desc;



--task

create table Member (
id VARCHAR2(20), 
name VARCHAR2(20), 
regno VARCHAR2(13), 
hp VARCHAR2(13),
address VARCHAR2(100)

);
create table Book (
code NUMBER(4), 
title VARCHAR2(50), 
count NUMBER(6), 
price NUMBER(10),
publish VARCHAR2(50)

);

create table Order2 (
no VARCHAR2(10) PRIMARY KEY, 
id VARCHAR2(20)
references Member(id) , 
code NUMBER(4)
references Book(code) ,
count NUMBER(6),
dr_date date
);

drop table Book;
drop table Member ;


create table Member (
id VARCHAR2(20) PRIMARY KEY, 
name VARCHAR2(20) not null, 
regno VARCHAR2(13) unique, 
hp VARCHAR2(13),
address VARCHAR2(100)

);

create table Book (
code NUMBER(4) PRIMARY key, 
title VARCHAR2(50) not null, 
count NUMBER(6), 
price NUMBER(10),
publish VARCHAR2(50)
);

create table Order2 (
no VARCHAR2(10) PRIMARY KEY, 
id VARCHAR2(20)
references Member(id) not null, 
code NUMBER(4)
references Book(code) not null,
count NUMBER(6),
dr_date date
);

into Member values('1','sk', '123', '1','12') ;
insert into Member values('2','skw', '12', '1w','1w2') ;
insert into Member values('3','sk', '124', '113','122') ;
insert into Book values('1','skw', '1', '1','1w2') ;
insert into Book values('2',null, '0', '1','1w2') ;
insert into Order2 values('1','1', 1, 1, '12/12/12') ;
insert into Order2 values('2','2', 1, 1, '12/12/12') ;


select empno, rpad(substr(empno, 1, 2), 4, '*') 
from emp;

select sal, ename, trunc(sal/21.5,2) "하루급여",  round(sal/21.5/8,2) "시급"
from emp;

select ename, hiredate, add_months(hiredate,3) , comm, nvl2(comm, TO_CHAR(comm), 'N/A')
from emp;

select  empno,ename, mgr,
nvl2(mgr,decode(substr(mgr,1,2), '75','5555','76','6666','77','7777','78','8888', mgr),'0000')
from emp;



create table dept_const (
deptno number(2), 
dname VARCHAR2(20),
loc VARCHAR2(20)
);

alter table dept_const
add constraint deptcont_deptno_pk PRIMARY key(deptno)
;

alter table dept_const
add constraint deptcont_dname_unq UNIQUE(dname)
;
alter table dept_const
modify loc constraint deptcont_loc_nn not null
;
create table emp_const (
empno number(4), 
ename VARCHAR2(10) not null,
job VARCHAR2(9),
tel VARCHAR2(20) UNIQUE,
hiredate date,
sal NUMBER(7),
comm NUMBER(7),
deptno  NUMBER(2)
);
alter table emp_const
add constraint EMPCONST_EMPNO_PK primary key(EMPNO)
;
alter table emp_const
add constraint EMPCONST_TEL_UNQ UNIQUE (tel)
;
alter table emp_const
modify ename constraint EMPCONST_ENAME_NN NOT NULL
;
alter table emp_const
drop constraint sys_c007068;

alter table emp_const
add constraint EMPCONST_SAL_CHK CHECK (sal >= 1000 and sal <=9999)
;
alter table emp_const
add constraint EMPCONST_DEPTNO_FK FOREIGN key(deptno)
references dept_const(deptno)
;

--이전
select e.employee_id, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and last_name = 'King';
--ansi
select e.employee_id, e.department_id, d.department_name
from employees e inner join departments d
on e.department_id = d.department_id
where last_name = 'King';


--1
select e.deptno,  d.dname, e.ename, e.sal
from emp e, dept d
where d.deptno = e.deptno
and sal > 2000
order by deptno
;
--2
select d.deptno, d.dname, trunc(avg(sal)) "평균", 
    max(sal) "최대", min(sal) "최소", count(*)
from emp e, dept d
where d.deptno = e.deptno
group by d.deptno, d.dname
;

--3
select d.*,  e.*
from emp e, dept d
where  d.deptno = e.deptno(+)
order by d.deptno, e.ename
--and order by e.ename
;

--4
select d.deptno, d.dname,e.empno, e.ename, e.mgr, e.sal,d.deptno "deptno_1",
g.losal, g.hisal, g.grade, ee.empno "mgr_empno", ee.ename "mgr_ename"
from emp e, dept d, emp ee, salgrade g
where  d.deptno = e.deptno(+)
and e.mgr = ee.empno(+)
and e.sal BETWEEN g.losal(+) and g.hisal(+)
order by d.deptno, e.empno
;


--서브쿼리
--1
SELECT e.job, e.empno, e.ename, e.sal, e.deptno, d.dname
from emp e inner join dept d
on e.deptno= d.deptno
where job = (
select job
from emp 
where ename = 'ALLEN'
)
;

--2
SELECT e.job, e.empno, e.ename, e.sal, e.deptno, d.dname, s.grade
from emp e inner join dept d
on e.deptno= d.deptno
inner join salgrade s
on e.sal between s.losal and s.hisal
where sal >
(
select avg(sal)
from emp
);

--3
select job
from emp
where deptno = '30'
;

select e.job, e.empno, e.ename, e.sal, e.deptno, d.dname
from emp e inner join dept d
on e.deptno= d.deptno
where e.deptno = '10'
and e.job not in (
select job
from emp
where deptno = '30'
)
;

select max(sal)
from emp
where job = 'SALESMAN'
;

SELECT e.job, e.empno, e.ename, e.sal,s.grade
from emp e inner join salgrade s
on e.sal between s.losal and s.hisal
where e.sal > (
select max(sal)
from emp
where job = 'SALESMAN'
)
;