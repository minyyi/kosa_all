SELECT employee_id, last_name, hire_date
    FROM employees
    WHERE hire_date >='03/01/01'
    AND last_name = 'King'
    ;
    
    
SELECT employee_id, last_name, salary
FROM employees
WHERE salary >=5000 AND salary <= 10000;

SELECT employee_id, last_name, salary
FROM employees
WHERE salary BETWEEN 5000 AND 10000;


SELECT employee_id, last_name, job_id
FROM employees
    WHERE job_id = 'FI_MGR' OR  job_id = 'FI_ACCOUNT';
    
SELECT employee_id, last_name, job_id
FROM employees
    
    WHERE job_id IN ('FI_MGR' ,  'FI_ACCOUNT');
    
SELECT department_id, department_name
FROM departments
    WHERE department_id != 10;
    
    
    SELECT employee_id, last_name, commission_pct
FROM employees
where commission_pct is not null;

SELECT employee_id, last_name, hire_date
FROM employees
    where hire_date like '07%';
--where hire_date BETWEEN '07/01/01' and '07/12/31';

SELECT last_name
FROM employees
    WHERE last_name not LIKE '%a%' 
    and last_name not LIKE '%A%' ;
    
select SUM(salary) "Total" from employees;
select avg(salary) from employees;
select max(salary)  from employees;
select count(salary) from employees;
select count(*) from employees;

select department_id, AVG(salary)
from employees
GROUP BY department_id;

select department_id, count(*), count(commission_pct)
from employees
GROUP BY department_id 
order by department_id
;


select department_id, avg(salary)
from employees
--where avg(salary) < 5000
group by department_id
having avg(salary) < 5000;

select first_name, hire_date, round((sysdate - hire_date)/365, 1) || '년'
from employees;

SELECT sysdate, next_day(sysdate, '토요일') from dual;
select to_char(sysdate, 'yyyy-MM-DD'), to_char(50000000,'$999,999,999,999') from dual;
select to_date('2025-03-20', 'YYYY-MM-DD'), to_date('20250321', 'YYYY-MM-DD') from dual;

select *
from employees
where to_char(hire_date,'yyyy') = '2007'
;

select employee_id, salary, NVL(commission_pct,0) from employees;
select employee_id, salary, NVL2(commission_pct,'o','X') from employees;

select job_id, DECODE(job_id, 'SA_MAN', 'Sales Dept', 'SH_CLERK','Sales Dept', 'another') 
from employees;


--DDL 정의어
create table emp01 
as select * from employees;
create table emp02 as select * from employees where 1=0;

alter table emp02 add (job varchar2(50));
alter table emp02 modify (job varchar2(100));
alter table emp02 drop column job;
delete from emp01;
rollback;
drop table emp01;

create table dept01 
as select * from departments;
insert into dept01 values(300, 'Developer', 100, 10);

insert into dept01(department_id, department_name) values(400, 'Sales');
update dept01 set department_name = 'IT service' 
where department_id=300;

create table emp01 as select * from employees;
update emp01 set salary= salary * 1.1
where salary >=3000;

delete from dept01 
where department_name = 'IT service';

DROP TABLE emp02;

create table emp01 (
empno NUMBER, ename VARCHAR2(20), 
job VARCHAR2(20), deptno NUMBER
);

create table emp02 (
empno NUMBER not null, 
ename VARCHAR2(20) not null, 
job VARCHAR2(20), 
deptno NUMBER
);

INSERT INTO emp02 values(null, null, 'IT',30);

insert into emp02 values(100, 'kim', 'IT', 30);

create table emp03 (
empno NUMBER UNIQUE, 
ename VARCHAR2(20) not null, 
job VARCHAR2(20), 
deptno NUMBER
);

INSERT INTO emp03 values(100, 'lee', 'IT',30);
insert into emp03 values(100, 'kim', 'IT', 30);

create table emp04 (
empno NUMBER PRIMARY KEY, 
ename VARCHAR2(20) not null, 
job VARCHAR2(20), 
deptno NUMBER
);

create table emp05 (
empno NUMBER PRIMARY KEY, 
ename VARCHAR2(20) not null, 
job VARCHAR2(20), 
deptno NUMBER references departments (department_id)
);

insert into emp05 values(100, 'park', 'IT',30000);

create table emp0 (
empno NUMBER, 
ename VARCHAR2(20) not null, 
job VARCHAR2(20), 
deptno,

CONSTRAINT emp06_empno_pk PRIMARY key(empno),
CONSTRAINT emp06_deptno_fk FOREIGN key(deptno)
    references departments(department_id)
);

create table emp07 (
empno NUMBER, 
ename VARCHAR2(20), 
job VARCHAR2(20), 
deptno NUMBER
);

alter table emp07 
add CONSTRAINT emp07_empno_pk PRIMARY key(empno);
alter table emp07 
add CONSTRAINT emp07_deptno_fk FOREIGN key(deptno)
REFERENCES departments(department_id);
alter table emp07 
MODIFY ename CONSTRAINT emp07_ename_nn not null;

create table emp08 (
empno NUMBER, 
ename VARCHAR2(20), 
job VARCHAR2(20), 
deptno NUMBER,
gender CHAR(1) CHECK(gender in('M','F'))
);

insert into emp08 values(100, 'park', 'IT', 30, 'A');

create table emp09 (
empno NUMBER, 
ename VARCHAR2(20), 
job VARCHAR2(20), 
deptno NUMBER,
loc VARCHAR2(20) DEFAULT 'Seoul'
);

insert into emp09(empno, ename, job, deptno) 
values(100, 'kim', 'IT', 30);

create table 데이블명(
컬럼1 number ,
컬럼2 number ,

constraint 제약조건명 primary key(컬럼1, 컬럼2)
);

create table emp10 (
empno NUMBER, 
ename VARCHAR2(20), 
job VARCHAR2(20), 
deptno NUMBER
);

alter table emp10
add CONSTRAINT emp10_empno_ename_pk primary key(empno, ename);

insert into emp10 values(100, 'kim', 'IT', 30);
insert into emp10 values(100, 'park', 'IT', 30);
insert into emp10 values(100, 'kim', 'IT', 30);


create table emp11 (
empno NUMBER, 
ename VARCHAR2(20), 
job VARCHAR2(20), 
deptno NUMBER
);

alter table dept01
add constraint dept01_department_id_pk primary key(department_id);

alter table emp11
add constraint emp11_deotno_fk foreign key(deptno)
references dept01(department_id);

insert into emp11 values(100, 'park', 'IT', 30);
delete from dept01 where department_id =30;
--=> 삭제 안됨. 참조관계 유지중이기 때문에 

create table emp12 (
empno NUMBER, 
ename VARCHAR2(20), 
job VARCHAR2(20), 
deptno NUMBER references dept01(department_id)
on delete cascade
);
insert into emp12 values(100, 'park', 'IT', 20);

delete from dept01 where department_id = 20;
delete from dept01 where department_id = 20;

drop table emp11;

select employee_id, department_id
from employees
where last_name = 'King';

select department_id, department_name
from  departments
where department_id in(80,90);

select e.employee_id, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
--이너조인
and last_name = 'King';

select e.employee_id, e.department_id, d.department_name
from employees e inner join departments d
on e.department_id = d.department_id
where last_name = 'King';


select e.first_name, e.email, d.department_id, j.job_id, d.department_name, j.job_title
from employees e inner join departments d
on e.department_id = d.department_id
inner join jobs j 
on e.job_id = j.job_id;

select e.first_name, e.email, d.department_id, j.job_id, d.department_name, j.job_title
from employees e, departments d, jobs j 
where  e.department_id = d.department_id
and e.job_id = j.job_id
;

select e.first_name, d.department_id, j.job_id, d.department_name, 
        l.location_id, l.country_id, l.city, j.job_title 
from employees e, departments d, jobs j, locations l
where  e.department_id = d.department_id
and e.job_id = j.job_id
and l.location_id = d.location_id
and l.city = 'Seattle'
;
select e.first_name, d.department_id, j.job_id, d.department_name, 
        l.location_id, l.country_id, l.city, j.job_title 
from employees e inner join departments d
on e.department_id = d.department_id
inner join jobs j 
on e.job_id = j.job_id
inner join  locations l
on l.location_id = d.location_id
where l.city = 'Seattle';


select A.last_name || '의 매니저는 '  ||B.last_name|| ' 이다.'
from employees A, employees B
where A.manager_id = B.employee_id
and A.last_name = 'Kochhar'
;
select * from employees;

select e.employee_id, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
;
--outer join
select e.employee_id, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+)
;
select e.employee_id, e.department_id, d.department_name
from employees e left join departments d
on e.department_id = d.department_id
;
--1
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and last_name = 'Himuro';

--2
select e.last_name, e.department_id, d.department_name, j.job_title, e.job_id
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id
and job_title = 'Accountant'
;

--3
select e.last_name, e.department_id,
    d.department_name, e.commission_pct
from employees e, departments d
where  e.department_id = d.department_id
and commission_pct is not null
;

--4
select e.last_name, e.salary, e.department_id, d.location_id, l.city
from employees e, departments d, locations l
where  e.department_id = d.department_id
and d.location_id = l.location_id
and salary <= 4000
;

--5
select d.last_name, d.department_id
--, d.department_name
from employees e, employees d
where  e.department_id = d.department_id
and e.last_name = 'Chen'

--and department_name = 'Finance'
;

select avg(salary) from employees;
--=>6461.831775700934579439252336448598130841
select last_name, salary
from employees
where salary > 6461.831775700934579439252336448598130841
;

select last_name, salary
from employees
where salary > (select avg(salary) from employees)
;


select last_name, salary
from employees
where last_name = 'Chen'
;

select last_name, salary
from employees
where salary > (select salary from employees 
                where last_name = 'Chen')
;

select job_id, max(salary) 
from employees
group by job_id
;

select employee_id, last_name, salary, job_id
from employees
where salary in  (
select max(salary) 
from employees
group by job_id
)
;

select employee_id, last_name, salary, job_id
from employees
where (salary, job_id) in  (
select max(salary) , job_id
from employees
group by job_id
)
;

select employee_id, last_name, hire_date
from employees
order by hire_date
;

select alias.*
from (
select employee_id, last_name, hire_date
from employees
order by hire_date
) alias
where rownum <= 5
;

select salary, last_name
from employees
order by salary desc
;

select a.*
from (
select salary, last_name
from employees
order by salary desc
) a
where rownum <=3
;
--서브쿼리
select  department_id
from employees
where last_name = 'Patel'
;

select employee_id, last_name, hire_date, salary
from employees
where  department_id = (
select   department_id
from employees
where last_name = 'Patel'
)
;

select employee_id, last_name, hire_date, salary
from employees
where  job_id = (
select   job_id
from employees
where last_name = 'Austin'
)
;

select employee_id, last_name, salary
from employees
where salary =
(select salary
from employees
where last_name = 'Seo'
)
;
select employee_id, last_name, salary
from employees
where salary > (
select max(salary)
from employees
where  department_id= '30')
;

select employee_id, last_name, salary
from employees
where salary > (
select min(salary)
from employees
where  department_id= '30')
;
select e.employee_id, e.last_name, e.job_id, e.hire_date, l.city, e.salary
from employees e inner join departments d
on d.department_id = e.department_id
inner join locations l
on d.location_id = l.location_id
where salary > (
select avg(salary)
from employees
);

select job_id 
from employees
where department_id='30'
;

select e.employee_id, e.last_name, d.department_name, e.hire_date, l.city
from employees e inner join departments d
on d.department_id = e.department_id
inner join locations l
on d.location_id = l.location_id
where d.department_id='100'
and e.job_id not in (
select job_id 
from employees
where department_id='30'
)
;





