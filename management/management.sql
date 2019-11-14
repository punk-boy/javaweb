-- source /opt/mysql/table/management.sql
drop database if exists management;
create database management;
use management;
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
drop table if exists jobs;
create table jobs(
	job_id varchar(15) primary key,
	job_title varchar(50) not null,
	min_salary double,
	max_salary double
);
load data infile '/opt/mysql/table/jobs.csv'
into table jobs
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\r\n'
ignore 1 lines
(@job_id,@job_title,@min_salary,@max_salary)
set
job_id=nullif(@job_id,''),
job_title=nullif(@job_title,''),
min_salary=nullif(@min_salary,''),
max_salary=nullif(@max_salary,'')
;
select * from jobs;
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
drop table if exists regions;
create table regions(
	region_id int primary key,
	region_name varchar(40)
);
load data infile '/opt/mysql/table/regions.csv'
into table regions
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\r\n'
ignore 1 lines
(@region_id,@region_name)
set
region_id=nullif(@region_id,''),
region_name=nullif(@region_name,'')
;
select * from regions;
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
drop table if exists countries;
create table countries(
    country_id char(2) primary key,
    country_name varchar(30) not null,
    region_id int,
    foreign key(region_id) references regions(region_id)
);
load data infile '/opt/mysql/table/countries.csv'
into table countries
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\r\n'
ignore 1 lines
(@country_id,@country_name,@region_id)
set
country_id=nullif(@country_id,''),
country_name=nullif(@country_name,''),
region_id=nullif(@region_id,'')
;
select * from countries;
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
drop table if exists locations;
create table locations(
	location_id int primary key,
	street_address varchar(100),
	postal_code varchar(15),
	city varchar(20),
	state_province varchar(30),
	country_id char(2),
	foreign key(country_id) references countries(country_id)
);
load data infile '/opt/mysql/table/locations.csv'
into table locations
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\r\n'
ignore 1 lines
(@location_id,@street_address,@postal_code,@city,@state_province,@country_id)
set
location_id=nullif(@location_id,''),
street_address=nullif(@street_address,''),
postal_code=nullif(@postal_code,''),
city=nullif(@city,''),
state_province=nullif(@state_province,''),
country_id=nullif(@country_id,'')
;
select * from locations;
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
drop table if exists departments;
create table departments(
	department_id int primary key,
	department_name varchar(30) not null,
	location_id int,
	foreign key (location_id) references locations(location_id)
);
load data infile '/opt/mysql/table/departments.csv'
into table departments
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\r\n'
ignore 1 lines
(@department_id,@department_name,@location_id)
set
department_id=nullif(@department_id,''),
department_name=nullif(@department_name,''),
location_id=nullif(@location_id,'')
;
select * from departments;
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
drop table if exists employees;
create table employees(
	employee_id int primary key,
	first_name varchar(20) not null,
	last_name varchar(20) not null,
	email varchar(40),
	phone_number char(20),
	hire_date date,
	job_id varchar(15),
	salary double,
	commission_pct float,
	manager_id int,
	department_id int,
	foreign key (job_id) references jobs(job_id),
	foreign key (department_id) references departments(department_id),
	foreign key(manager_id) references employees(employee_id)

);
load data infile '/opt/mysql/table/employees.csv'
into table employees
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\r\n'
ignore 1 lines
(@employee_id,@first_name,@last_name,@email,@phone_number,@hire_date,@job_id,@salary,@commission_pct,@manager_id,@department_id)
set
employee_id=nullif(@employee_id,''),
first_name=nullif(@first_name,''),
last_name=nullif(@last_name,''),
email=nullif(@email,''),
phone_number=nullif(@phone_number,''),
hire_date=nullif(@hire_date,''),
job_id=nullif(@job_id,''),
salary=nullif(@salary,''),
commission_pct=nullif(@commission_pct,''),
manager_id=nullif(@manager_id,''),
department_id=nullif(@department_id,'')
;
select * from employees;
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


