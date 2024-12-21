/*
 * ===========================================
 * Subject : Define the TABLEs' structure.
 * Date    : December 18, 2024
 * Author  : Alsayed A. khaleel
 * Last mod: December 19, 2024
 * ===========================================
 */


/* 1st TABLE created. */
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


/* 2nd TABLE created. */
CREATE TABLE dependants(
emp_id            NUMBER(10)   NOT NULL,
dpnd_first_name   VARCHAR2(15) NOT NULL,
dpnd_last_name    VARCHAR2(15) NOT NULL,
dpnd_sex          CHAR(6),
dpnd_relationship VARCHAR2(20) NOT NULL,
CONSTRAINT emp_id_fk      FOREIGN KEY(emp_id) references employees(emp_id),
CONSTRAINT dpnd_chk_sex   check(dpnd_sex IN('Male', 'male', 'Female', 'female')));


/* 3rd TABLE created. */
CREATE TABLE departments(
dpt_number    NUMBER(10),
dpt_name      VARCHAR2(30) NOT NULL UNIQUE,
dpt_location  VARCHAR2(30) NOT NULL UNIQUE,
mgr_id        NUMBER(10)   UNIQUE,
mgr_sDate     DATE         DEFAULT SYSDATE,
CONSTRAINT dpt_num_pk      PRIMARY KEY(dpt_NUMBER),
CONSTRAINT mgr_id_fk       FOREIGN KEY(mgr_id) references employees(emp_id));

/* connect the employees TABLE with departments one after creation. */
ALTER TABLE employees ADD CONSTRAINT emp_dpt_fk FOREIGN KEY(dpt_number) references departments(dpt_number);


/* 4th TABLE. */
CREATE TABLE projects(
prj_number     NUMBER(10),
prj_name       VARCHAR2(30) NOT NULL UNIQUE,
prj_location   VARCHAR2(30) NOT NULL UNIQUE,
managed_by_dpt NUMBER(10),
CONSTRAINT prj_num_pk PRIMARY KEY(prj_number),
CONSTRAINT dpt_prj_fk FOREIGN KEY(managed_by_dpt) references departments(dpt_NUMBER));


/* 5th TABLE. */
CREATE TABLE works_on(
emp_id       NUMBER(10),
prj_number   NUMBER(10),
worked_hours NUMBER(4, 1)    NOT NULL,
CONSTRAINT   works_on_pk     PRIMARY KEY(emp_id, prj_number),
CONSTRAINT   emp_works_on_fk FOREIGN KEY(emp_id)     references employees(emp_id),
CONSTRAINT   prj_number_fk   FOREIGN KEY(prj_NUMBER) references projects(prj_number),
CONSTRAINT   chk_hours       check(worked_hours >= 0));


/* 6th TABLE. */
CREATE TABLE tasks(
task_id     NUMBER(5),
task_name   VARCHAR2(30) NOT NULL UNIQUE,
emp_id      NUMBER(10),
task_status VARCHAR2(20),
CONSTRAINT tsk_pk        PRIMARY KEY(task_id),
CONSTRAINT chk_status    check(task_status in('Done', 'In progress')),
CONSTRAINT emp_tsk_fk    FOREIGN KEY(emp_id) references employees(emp_id));


/* insert data to employees TABLE. */
INSERT INTO employees VALUES(1001, 'Alsayed',  'Ali',   '25 Tanta, Eg',  to_date('10-18-2003', 'mm-dd-yyyy'),  NULL, 'Male', 0, 90, 60, 25.9,   NULL);
INSERT INTO employees VALUES(1002, 'Mostafa',  'Ahmed', '125 Cairo, Eg', to_date('1-8-2000', 'mm-dd-yyyy'),    NULL, 'Male', 0, 50, 20, 20.0,   NULL);
INSERT INTO employees VALUES(1003, 'Abdallah', 'Tarik', '40 Tanta, Eg',  to_date('10-8-2002', 'mm-dd-yyyy'),   NULL, 'Male', 0, 15, 10, 15.5,   NULL);
INSERT INTO employees VALUES(1004, 'Mona',     'Adel',  '16 Menof, Eg',  to_date('5-5-1999', 'mm-dd-yyyy'),    NULL, 'Female', 0, 10, 50, 15.9, NULL);
INSERT INTO employees VALUES(1005, 'Soha',     'Khalid','123 Giza, Eg',  to_date('7-8-1995', 'mm-dd-yyyy'),    NULL, 'female', 0, 15, 40, 12.9, NULL);
INSERT INTO employees VALUES(1006, 'Sami',     'Amr',   '666 Qina, Eg',  to_date('9-9-2001', 'mm-dd-yyyy'),    NULL, 'Male', 0, 0, 10, 21.9,    NULL);
INSERT INTO employees VALUES(1007, 'Soli',     'Ameen', '44 Aswan, Eg',  to_date('11-11-2002', 'mm-dd-yyyy'),  NULL, 'Male', 0, 10, 0, 23.9,    NULL);


-- UPDATE the age of the employees automatically.
UPDATE EMPLOYEES set emp_age = (FLOOR(MONTHS_BETWEEN(SYSDATE, date_of_birth) / 12));


/* insert data into dependants */
INSERT INTO dependants VALUES(1001, 'Hoda',    'Saad', 'female', 'wife');
INSERT INTO dependants VALUES(1001, 'Khalid',  'Alsayed', 'male', 'son');
INSERT INTO dependants VALUES(1002, 'Mohammed','Mostafa', 'male', 'son');
INSERT INTO dependants VALUES(1002, 'Soha',    'Mostafa', 'female', 'daugther');
INSERT INTO dependants VALUES(1003, 'Tarik',   'Abdalla', 'male', 'son');
INSERT INTO dependants VALUES(1003, 'Sara',    'Adel', 'female', 'wife');
INSERT INTO dependants VALUES(1004, 'Fahd',    'Sameer', 'male', 'son');


/* insert data into departments. */
INSERT INTO departments VALUES(101, 'CS', 'Floor01', 1001, to_date('05-10-2001', 'mm-dd-yyyy'));
INSERT INTO departments VALUES(102, 'IT', 'Floor02', 1004, to_date('01-02-2005', 'mm-dd-yyyy'));
INSERT INTO departments VALUES(103, 'IS', 'Floor03', 1005, SYSDATE);
INSERT INTO departments VALUES(104, 'OR', 'Floor04', 1002, SYSDATE);


/* UPDATE the department of each employee. */
UPDATE employees set dpt_NUMBER = 101 WHERE emp_id = 1001;
UPDATE employees set dpt_NUMBER = 101 WHERE emp_id = 1002;
UPDATE employees set dpt_NUMBER = 103 WHERE emp_id = 1003;
UPDATE employees set dpt_NUMBER = 102 WHERE emp_id = 1004;
UPDATE employees set dpt_NUMBER = 104 WHERE emp_id = 1005;
UPDATE employees set dpt_NUMBER = 104 WHERE emp_id = 1006;
UPDATE employees set dpt_NUMBER = 104 WHERE emp_id = 1007;


/* insert data into projects TABLE. */
INSERT INTO projects VALUES(511, 'ABC', 'Cairo', 101);
INSERT INTO projects VALUES(512, 'XYZ', 'Alex', 102);
INSERT INTO projects VALUES(513, 'QWE', 'Giza', 102);
INSERT INTO projects VALUES(514, 'UEF', 'Menofia', 104);


/* insert data into works_on TABLE. */
INSERT INTO works_on VALUES(1001, 511, 150);
INSERT INTO works_on VALUES(1001, 514, 160);
INSERT INTO works_on VALUES(1002, 514, 200);
INSERT INTO works_on VALUES(1003, 511, 160);
INSERT INTO works_on VALUES(1004, 513, 140);
INSERT INTO works_on VALUES(1005, 512, 120);
INSERT INTO works_on VALUES(1006, 513, 140);
INSERT INTO works_on VALUES(1007, 512, 200);


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


/* inser data into tasts TABLE. */
INSERT INTO tasks VALUES(301, 'Task01',	1001, 'In progress');
INSERT INTO tasks VALUES(302, 'Task02',	1001, 'Done');
INSERT INTO tasks VALUES(303, 'Task03',	1003, 'In progress');
INSERT INTO tasks VALUES(304, 'Task04',	1005, 'Done');
INSERT INTO tasks VALUES(305, 'Task05',	1004, 'In progress');
INSERT INTO tasks VALUES(306, 'Task06',	1006, 'Done');
INSERT INTO tasks VALUES(307, 'Task07',	1007, 'In progress');
INSERT INTO tasks VALUES(308, 'Task08',	1007, 'Done');


/* retrieve the data. */
-- SELECT * FROM employees;
-- SELECT * FROM DEPARTMENTS;
-- SELECT * FROM PROJECTS;
-- SELECT * FROM dependants;
-- SELECT * from TASKS;
-- SELECT * FROM WORKS_ON;


/* easy in, easy out. */
/* clean in one step. */
-- ALTER TABLE projects DROP CONSTRAINT dpt_prj_fk;
-- ALTER TABLE works_on DROP CONSTRAINT prj_number_fk;
-- ALTER TABLE works_on DROP CONSTRAINT emp_works_on_fk;
-- ALTER TABLE departments DROP CONSTRAINT mgr_id_fk;
-- ALTER TABLE employees DROP CONSTRAINT emp_dpt_fk;

-- DROP TABLE projects;
-- DROP TABLE works_on;
-- DROP TABLE tasks;
-- DROP TABLE dependants;
-- DROP TABLE departments;
-- DROP TABLE employees;


