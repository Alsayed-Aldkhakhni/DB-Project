/*
 * ===========================================
 * Subject : Define the tables' structure.
 * Date    : December 18, 2024
 * Author  : Alsayed A. khaleel
 * Last mod: December 19, 2024
 * ===========================================
 */


/* 1st table created. */
CREATE TABLE employees(
emp_id          NUMBER(10),
emp_first_name  VARCHAR2(20) NOT NULL,
emp_last_name   VARCHAR2(20) NOT NULL,
emp_address     VARCHAR2(30),
date_of_birth   DATE,
emp_age         NUMBER(3),
emp_sex         CHAR(6),
salary          NUMBER(7, 2),
bonus           NUMBER(4, 2),
deductions      NUMBER(4, 2),
rate_per_hour   NUMBER(5, 2),
dpt_number      NUMBER(10),
CONSTRAINT emp_id_pk      PRIMARY KEY(emp_id),
CONSTRAINT chk_age        check(emp_age >= 20),
CONSTRAINT chk_sex        check(emp_sex IN('Male', 'male', 'Female', 'female')),
CONSTRAINT chk_salary     check(salary >= 0),
CONSTRAINT chk_bonus      check(bonus >= 0),
CONSTRAINT chk_deductions check(deductions >= 0));


/* 2nd table created. */
CREATE TABLE dependants(
emp_id            NUMBER(10)   NOT NULL,
dpnd_first_name   VARCHAR2(15) NOT NULL,
dpnd_last_name    VARCHAR2(15) NOT NULL,
dpnd_sex          CHAR(6),
dpnd_relationship VARCHAR2(20) NOT NULL,
CONSTRAINT emp_id_fk      FOREIGN KEY(emp_id) references employees(emp_id),
CONSTRAINT dpnd_chk_sex   check(emp_sex IN('Male', 'male', 'Female', 'female')));


/* 3rd table created. */
CREATE TABLE departments(
dpt_number    NUMBER(10),
dpt_name      VARCHAR2(30) NOT NULL UNIQUE,
dpt_location  VARCHAR2(30) NOT NULL UNIQUE,
mgr_id        NUMBER(10)   UNIQUE,
mgr_sDate     DATE         DEFAULT SYSDATE,
CONSTRAINT dpt_num_pk      PRIMARY KEY(dpt_NUMBER),
CONSTRAINT mgr_id_fk       FOREIGN KEY(mgr_id) references employees(emp_id));

/* connect the employees table with departments one after creation. */
ALTER TABLE employees ADD CONSTRAINT emp_dpt_fk FOREIGN KEY(dpt_number) references departments(dpt_number);


/* 4th table. */
CREATE TABLE projects(
prj_number     NUMBER(10),
prj_name       VARCHAR2(30) NOT NULL UNIQUE,
prj_location   VARCHAR2(30) NOT NULL UNIQUE,
managed_by_dpt NUMBER(10),
CONSTRAINT prj_num_pk PRIMARY KEY(prj_number),
CONSTRAINT dpt_prj_fk FOREIGN KEY(managed_by_dpt) references departments(dpt_NUMBER));


/* 5th table. */
CREATE TABLE works_on(
emp_id       NUMBER(10),
prj_number   NUMBER(10),
worked_hours NUMBER(4, 1)    NOT NULL,
CONSTRAINT   works_on_pk     PRIMARY KEY(emp_id, prj_number),
CONSTRAINT   emp_works_on_fk FOREIGN KEY(emp_id)     references employees(emp_id),
CONSTRAINT   prj_number_fk   FOREIGN KEY(prj_NUMBER) references projects(prj_number),
CONSTRAINT   chk_hours       check(worked_hours >= 0));


/* 6th table. */
CREATE TABLE tasks(
task_id     NUMBER(5),
task_name   VARCHAR2(30) NOT NULL UNIQUE,
emp_id      NUMBER(10),
task_status VARCHAR2(20),
CONSTRAINT tsk_pk        PRIMARY KEY(task_id),
CONSTRAINT chk_status    check(task_status in('Done', 'In progress')),
CONSTRAINT emp_tsk_fk    FOREIGN KEY(emp_id) references employees(emp_id));


/* insert data to employees table. */
insert into employees values(1001, 'Alsayed',  'Ali',   '25 Tanta, Eg',  to_date('10-18-2003', 'mm-dd-yyyy'),  NULL, 'Male', 0, 90, 60, 25.9,   NULL);
insert into employees values(1002, 'Mostafa',  'Ahmed', '125 Cairo, Eg', to_date('1-8-2000', 'mm-dd-yyyy'),    NULL, 'Male', 0, 50, 20, 20.0,   NULL);
insert into employees values(1003, 'Abdallah', 'Tarik', '40 Tanta, Eg',  to_date('10-8-2002', 'mm-dd-yyyy'),   NULL, 'Male', 0, 15, 10, 15.5,   NULL);
insert into employees values(1004, 'Mona',     'Adel',  '16 Menof, Eg',  to_date('5-5-1999', 'mm-dd-yyyy'),    NULL, 'Female', 0, 10, 50, 15.9, NULL);
insert into employees values(1005, 'Soha',     'Khalid','123 Giza, Eg',  to_date('7-8-1995', 'mm-dd-yyyy'),    NULL, 'female', 0, 15, 40, 12.9, NULL);
insert into employees values(1006, 'Sami',     'Amr',   '666 Qina, Eg',  to_date('9-9-2001', 'mm-dd-yyyy'),    NULL, 'Male', 0, 0, 10, 21.9,    NULL);
insert into employees values(1007, 'Soli',     'Ameen', '44 Aswan, Eg',  to_date('11-11-2002', 'mm-dd-yyyy'),  NULL, 'Male', 0, 10, 0, 23.9,    NULL);


-- update the age of the employees automatically.
update EMPLOYEES set emp_age = (FLOOR(MONTHS_BETWEEN(SYSDATE, date_of_birth) / 12));

/* insert data into dependants */
insert into dependants values(1001, 'Hoda',    'Saad', 'female', 'wife');
insert into dependants values(1001, 'Khalid',  'Alsayed', 'male', 'son');
insert into dependants values(1002, 'Mohammed','Mostafa', 'male', 'son');
insert into dependants values(1002, 'Soha',    'Mostafa', 'female', 'daugther');
insert into dependants values(1003, 'Tarik',   'Abdalla', 'male', 'son');
insert into dependants values(1003, 'Sara',    'Adel', 'female', 'wife');
insert into dependants values(1004, 'Fahd',    'Sameer', 'male', 'son');


/* insert data into departments. */
insert into departments values(101, 'CS', 'Floor01', 1001, to_date('05-10-2001', 'mm-dd-yyyy'));
insert into departments values(102, 'IT', 'Floor02', 1004, to_date('01-02-2005', 'mm-dd-yyyy'));
insert into departments values(103, 'IS', 'Floor03', 1005, SYSDATE);
insert into departments values(104, 'OR', 'Floor04', 1002, SYSDATE);


/* update the department of each employee. */
update employees set dpt_NUMBER = 101 where emp_id = 1001;
update employees set dpt_NUMBER = 101 where emp_id = 1002;
update employees set dpt_NUMBER = 103 where emp_id = 1003;
update employees set dpt_NUMBER = 102 where emp_id = 1004;
update employees set dpt_NUMBER = 104 where emp_id = 1005;
update employees set dpt_NUMBER = 104 where emp_id = 1006;
update employees set dpt_NUMBER = 104 where emp_id = 1007;


/* insert data into projects table. */
insert into projects values(511, 'ABC', 'Cairo', 101);
insert into projects values(512, 'XYZ', 'Alex', 102);
insert into projects values(513, 'QWE', 'Giza', 102);
insert into projects values(514, 'UEF', 'Menofia', 104);


/* insert data into works_on table. */
insert into works_on values(1001, 511, 150);
insert into works_on values(1001, 514, 160);
insert into works_on values(1002, 514, 200);
insert into works_on values(1003, 511, 160);
insert into works_on values(1004, 513, 140);
insert into works_on values(1005, 512, 120);
insert into works_on values(1006, 513, 140);
insert into works_on values(1007, 512, 200);


/* automatically calculate the total salary of employees. */
UPDATE employees
SET salary = (
    SELECT SUM(worked_hours) * employees.rate_per_hour
    FROM works_on
    WHERE works_on.emp_id = employees.emp_id
    GROUP BY works_on.emp_id ) + (bonus - deductions)

    WHERE EXISTS (
    SELECT 1
    FROM works_on
    WHERE works_on.emp_id = employees.emp_id
);


/* inser data into tasts table. */
insert into tasks values(301, 'Task01',	1001, 'In progress');
insert into tasks values(302, 'Task02',	1001, 'Done');
insert into tasks values(303, 'Task03',	1003, 'In progress');
insert into tasks values(304, 'Task04',	1005, 'In progress');

