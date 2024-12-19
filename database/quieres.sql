/*
 * ===========================================
 * Subject: Define the tables' structure.
 * Date   : December 18, 2024
 * Author : Alsayed A. khaleel
 * ===========================================
 */

/* 1st table created. */
create table employees(
emp_id number(10),
emp_fname varchar2(20) not null,
emp_lname varchar2(20) not null,
emp_addr varchar2(30),
emp_dob date,
emp_age number(3),
emp_sex char(6),
base_salary number(7, 2),
bonus number(4, 2),
deductions number(4, 2),
rate_per_hour number(5, 2),
dpt_number number(10),
constraint emp_pk primary key(emp_id),
constraint chk_age check(emp_age >= 22),
constraint chk_sex check(emp_sex = 'Male' OR emp_sex = 'male' OR emp_sex = 'Female' OR emp_sex = 'female'),
constraint chk_salary check(base_salary >= 0),
constraint chk_bonus check(bonus >= 0),
constraint chk_deductions check(deductions >= 0));


/* 2nd table created. */
create table dependants(
emp_id number(10),
dpnd_fname varchar2(15),
dpnd_lname varchar2(15),
dpnd_sex char(6),
dpnd_relationship varchar2(20),
constraint emp_id_fk foreign key(emp_id) references employees(emp_id),
constraint dpnd_chk_sex check(dpnd_sex = 'Male' OR dpnd_sex = 'male' OR dpnd_sex = 'Female' OR dpnd_sex = 'female'));

alter table dependants modify (dpnd_fname not null, dpnd_lname not null, dpnd_relationship not null); 
alter table dependants modify emp_id not null;


/* 3rd table created. */
create table departments(
dpt_number number(10),
dpt_name varchar2(30) not null unique,
dpt_location varchar2(30) not null unique,
mgr_id number(10) UNIQUE,
mgr_sDate date DEFAULT SYSDATE,
constraint dpt_num_pk primary key(dpt_number),
constraint mgr_id_fk foreign key(mgr_id)
references employees(emp_id));


/* 4th table. */
create table projects(
prj_number number(10),
prj_name varchar2(30),
prj_location varchar2(30),
managed_by_dpt number(10),
constraint dpt_prj_fk foreign key(managed_by_dpt) references departments(dpt_number),
constraint prj_num_pk primary key(prj_number));
alter table projects modify (prj_name not null unique, prj_location not null unique);


/* 5th table. */
create table works_on(
emp_id number(10),
prj_number number(10),
worked_hours number(4, 1),
constraint works_on_pk primary key(emp_id, prj_number),
constraint emp_works_on_fk foreign key(emp_id) references employees(emp_id),
constraint prj_number_fk foreign key(prj_number) references projects(prj_number));

alter table works_on add constraint chk_hours check(worked_hours >= 0);
alter table works_on modify worked_hours not null;


/* 6th table. */
create table tasks(
task_id number(5),
task_name varchar2(30) NOT NULL UNIQUE,
emp_id number(10),
status varchar2(20),
constraint tsk_pk primary key(task_id),
constraint chk_status check(status in('Done', 'In progress')),
constraint emp_tsk_fk foreign key(emp_id)
references employees(emp_id));


/* insert data to employees table. */
insert into employees values(1001, 'Alsayed', 'Ali', '25 Tanta, Eg', to_date('10-18-2003', 'mm-dd-yyyy'),
                             NULL, 'Male', 6000, 90, 60, 25.9, NULL);

insert into employees values(1002, 'Mostafa', 'Ahmed', '125 Cairo, Eg', to_date('1-8-2000', 'mm-dd-yyyy'),
                             NULL, 'Male', 7000.25, 50, 20, 20.0, NULL);

insert into employees values(1003, 'Abdallah', 'Tarik', '40 Tanta, Eg', to_date('10-8-2002', 'mm-dd-yyyy'),
                             NULL, 'Male', 6000.25, 15, 10, 15.5, NULL);

insert into employees values(1004, 'Mona', 'Adel', '16 Menof, Eg', to_date('5-5-1999', 'mm-dd-yyyy'),
                             NULL, 'Female', 8000.25, 10, 50, 15.9, NULL);

insert into employees values(1005, 'Soha', 'Khalid', '123 Giza, Eg', to_date('7-8-1995', 'mm-dd-yyyy'),
                             NULL, 'female', 5500.25, 15, 40, 12.9, NULL);

insert into employees values(1006, 'Sami', 'Amr', '666 Qina, Eg', to_date('9-9-2001', 'mm-dd-yyyy'),
                             NULL, 'Male', 6000.25, 0, 10, 21.9, NULL);

insert into employees values(1007, 'Soli', 'Ameen', '44 Aswan, Eg', to_date('11-11-2002', 'mm-dd-yyyy'),
                             NULL, 'Male', 7000.25, 10, 0, 23.9, NULL);


/* insert data into dependants */
insert into dependants values(1001, 'Hoda', 'Saad', 'female', 'wife');
insert into dependants values(1001, 'Khalid', 'Alsayed', 'male', 'son');
insert into dependants values(1002, 'Mohammed', 'Mostafa', 'male', 'son');
insert into dependants values(1002, 'Soha', 'Mostafa', 'female', 'daugther');
insert into dependants values(1003, 'Tarik', 'Abdalla', 'male', 'son');
insert into dependants values(1003, 'Sara', 'Adel', 'female', 'wife');
insert into dependants values(1004, 'Fahd', 'Sameer', 'male', 'son');


/* insert data into departments. */
insert into departments values(101, 'CS', 'Floor01', 1001, to_date('05-10-2001', 'mm-dd-yyyy'));
insert into departments values(102, 'IT', 'Floor02', 1004, to_date('01-02-2005', 'mm-dd-yyyy'));
insert into departments values(103, 'IS', 'Floor03', 1005, SYSDATE);
insert into departments values(104, 'OR', 'Floor04', 1002, SYSDATE);


/* update the department of each employee. */
update employees set dpt_number = 101 where emp_id = 1001;
update employees set dpt_number = 101 where emp_id = 1002;
update employees set dpt_number = 103 where emp_id = 1003;
update employees set dpt_number = 102 where emp_id = 1004;
update employees set dpt_number = 104 where emp_id = 1005;
update employees set dpt_number = 104 where emp_id = 1006;
update employees set dpt_number = 104 where emp_id = 1007;


/* insert data into projects table. */
insert into projects values(511, 'ABC', 'Cairo', 101);
insert into projects values(512, 'XYZ', 'Alex', 102);
insert into projects values(513, 'QWE', 'Giza', 102);
insert into projects values(514, 'UEF', 'Menofia', 104);


/* insert data into works_on table. */
insert into works_on values(1001, 511, 150);
insert into works_on values(1001, 514, 160);
insert into works_on values(1003, 511, 60);
insert into works_on values(1004, 513, 40);
insert into works_on values(1005, 512, 20);
insert into works_on values(1006, 513, 140);
insert into works_on values(1007, 512, 200);


/* inser data into tasts table. */
insert into tasks values(301, 'Task01',	1001, 'In progress');
insert into tasks values(302, 'Task02',	1001, 'Done');
insert into tasks values(303, 'Task03',	1003, 'In progress');
insert into tasks values(304, 'Task04',	1005, 'In progress');


/* display tables' structure. */
-- desc employees;
-- desc departments;
-- desc dependants;
-- desc projects;
-- desc works_on
-- desc tasks;