/* 1st table created. */
--create table employees(
--emp_id number(10),
--emp_fname varchar2(20) not null,
--emp_lname varchar2(20) not null,
--emp_addr varchar2(30),
--emp_dob date,
--emp_age number(3),
--emp_sex char(6),
--base_salary number(7, 2),
--bonus number(4, 2),
--deductions number(4, 2),
--rate_per_hour number(5, 2),
--dpt_number number(10),
--constraint emp_pk primary key(emp_id),
--constraint chk_age check(emp_age >= 22),
--constraint chk_sex check(emp_sex = 'Male' OR emp_sex = 'male' OR emp_sex = 'Female' OR emp_sex = 'female'),
--constraint chk_salary check(base_salary >= 5000),
--constraint chk_bonus check(bonus >= 0),
--constraint chk_deductions check(deductions >= 0));


/* 2nd table created. */
--create table dependants(
--emp_id number(10),
--dpnd_fname varchar2(15),
--dpnd_lname varchar2(15),
--dpnd_sex char(6),
--dpnd_relationship varchar2(20),
--constraint emp_id_fk foreign key(emp_id) references employees(emp_id),
--constraint dpnd_chk_sex check(dpnd_sex = 'Male' OR dpnd_sex = 'male' OR dpnd_sex = 'Female' OR dpnd_sex = 'female'));
--
--alter table dependants modify (dpnd_fname not null, dpnd_lname not null, dpnd_relationship not null); 
--alter table dependants modify emp_id not null;

/* 3rd table created. */
--create table departments(
--dpt_number number(10),
--dpt_name varchar2(30) not null unique,
--dpt_location varchar2(30) not null unique,
--mgr_id number(10),
--mgr_sDate date,
--constraint dpt_num_pk primary key(dpt_number),
--constraint mgr_id_fk foreign key(mgr_id)
--references employees(emp_id));

/* 4th table. */
--create table projects(
--prj_number number(10),
--prj_name varchar2(30),
--prj_location varchar2(30),
--managed_by_dpt number(10),
--constraint dpt_prj_fk foreign key(managed_by_dpt) references departments(dpt_number),
--constraint prj_num_pk primary key(prj_number));
--alter table projects modify (prj_name not null unique, prj_location not null unique);

/* 5th table. */
--create table works_on(
--emp_id number(10),
--prj_number number(10),
--worked_hours number(4, 1),
--constraint works_on_pk primary key(emp_id, prj_number),
--constraint emp_works_on_fk foreign key(emp_id) references employees(emp_id),
--constraint prj_number_fk foreign key(prj_number) references projects(prj_number));
--
--alter table works_on add constraint chk_hours check(worked_hours >= 0);
--alter table works_on modify worked_hours not null;

/* 6th table. */
--create table tasks(
--task_id number(5),
--task_name varchar2(30) NOT NULL UNIQUE,
--emp_id number(10),
--status boolean,
--constraint tsk_pk primary key(task_id),
--constraint emp_tsk_fk foreign key(emp_id)
--references employees(emp_id));

/* display tables' structure. */
--desc employees;
--desc departments;
--desc dependants;
--desc projects;
--desc works_on;
--desc tasks;



