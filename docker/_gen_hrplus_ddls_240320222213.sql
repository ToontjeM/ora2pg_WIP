######################################################################################################################
## EDB DDL Extractor Utility. Version: 2.4.4
##
## Source Database Version: Oracle Database 18c Express Edition Release 18.0.0.0.0 - Production
##
## Extracted On: 20-03-2024 22:22:13
######################################################################################################################
-- WINDOWS_NLS_LANG: %NLS_LANG%
-- LINUX_NLS_LANG:
########################################
## SYNONYM
########################################
########################################
## DATABASE LINKS
########################################
########################################
## TYPE SPECIFICATION
########################################
########################################
## TYPE BODY
########################################
########################################
## SEQUENCES
########################################
--START_OF_DDL
   CREATE SEQUENCE  "HRPLUS"."DEPARTMENTS_SEQ"  MINVALUE 1 MAXVALUE 9990 INCREMENT BY 10 START WITH 280 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--END_OF_DDL

--START_OF_DDL
   CREATE SEQUENCE  "HRPLUS"."EMPLOYEES_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 207 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--END_OF_DDL

--START_OF_DDL
   CREATE SEQUENCE  "HRPLUS"."LOCATIONS_SEQ"  MINVALUE 1 MAXVALUE 9900 INCREMENT BY 100 START WITH 3300 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--END_OF_DDL

########################################
## TABLE DDL
########################################
--START_OF_DDL
  CREATE TABLE "HRPLUS"."DEPARTMENTS"
   (	"DEPARTMENT_ID" NUMBER(4,0),
	"DEPARTMENT_NAME" VARCHAR2(30) CONSTRAINT "DEPT_NAME_NN" NOT NULL ENABLE,
	"MANAGER_ID" NUMBER(6,0),
	"LOCATION_ID" NUMBER(4,0),
	 CONSTRAINT "DEPT_ID_PK" PRIMARY KEY ("DEPARTMENT_ID")
  USING INDEX  ENABLE
   ) ;
   COMMENT ON TABLE "HRPLUS"."DEPARTMENTS"  IS 'Departments table that shows details of departments where employees
work. Contains 27 rows; references with locations, employees, and job_history tables.';
   COMMENT ON COLUMN "HRPLUS"."DEPARTMENTS"."DEPARTMENT_ID" IS 'Primary key column of departments table.';
   COMMENT ON COLUMN "HRPLUS"."DEPARTMENTS"."DEPARTMENT_NAME" IS 'A not null column that shows name of a department. Administration,
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public
Relations, Sales, Finance, and Accounting. ';
   COMMENT ON COLUMN "HRPLUS"."DEPARTMENTS"."MANAGER_ID" IS 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.';
   COMMENT ON COLUMN "HRPLUS"."DEPARTMENTS"."LOCATION_ID" IS 'Location id where a department is located. Foreign key to location_id column of locations table.';
--END_OF_DDL

--START_OF_DDL
  CREATE TABLE "HRPLUS"."EMPLOYEES"
   (	"EMPLOYEE_ID" NUMBER(6,0),
	"FIRST_NAME" VARCHAR2(20),
	"LAST_NAME" VARCHAR2(25) CONSTRAINT "EMP_LAST_NAME_NN" NOT NULL ENABLE,
	"EMAIL" VARCHAR2(25) CONSTRAINT "EMP_EMAIL_NN" NOT NULL ENABLE,
	"PHONE_NUMBER" VARCHAR2(20),
	"HIRE_DATE" DATE CONSTRAINT "EMP_HIRE_DATE_NN" NOT NULL ENABLE,
	"JOB_ID" VARCHAR2(10) CONSTRAINT "EMP_JOB_NN" NOT NULL ENABLE,
	"SALARY" NUMBER(8,2),
	"COMMISSION_PCT" NUMBER(2,2),
	"MANAGER_ID" NUMBER(6,0),
	"DEPARTMENT_ID" NUMBER(4,0),
	 CONSTRAINT "EMP_SALARY_MIN" CHECK (salary > 0) ENABLE,
	 CONSTRAINT "EMP_EMAIL_UK" UNIQUE ("EMAIL")
  USING INDEX  ENABLE,
	 CONSTRAINT "EMP_EMP_ID_PK" PRIMARY KEY ("EMPLOYEE_ID")
  USING INDEX  ENABLE
   ) ;
   COMMENT ON TABLE "HRPLUS"."EMPLOYEES"  IS 'employees table. Contains 107 rows. References with departments,
jobs, job_history tables. Contains a self reference.';
   COMMENT ON COLUMN "HRPLUS"."EMPLOYEES"."EMPLOYEE_ID" IS 'Primary key of employees table.';
   COMMENT ON COLUMN "HRPLUS"."EMPLOYEES"."FIRST_NAME" IS 'First name of the employee. A not null column.';
   COMMENT ON COLUMN "HRPLUS"."EMPLOYEES"."LAST_NAME" IS 'Last name of the employee. A not null column.';
   COMMENT ON COLUMN "HRPLUS"."EMPLOYEES"."EMAIL" IS 'Email id of the employee';
   COMMENT ON COLUMN "HRPLUS"."EMPLOYEES"."PHONE_NUMBER" IS 'Phone number of the employee; includes country code and area code';
   COMMENT ON COLUMN "HRPLUS"."EMPLOYEES"."HIRE_DATE" IS 'Date when the employee started on this job. A not null column.';
   COMMENT ON COLUMN "HRPLUS"."EMPLOYEES"."JOB_ID" IS 'Current job of the employee; foreign key to job_id column of the
jobs table. A not null column.';
   COMMENT ON COLUMN "HRPLUS"."EMPLOYEES"."SALARY" IS 'Monthly salary of the employee. Must be greater
than zero (enforced by constraint emp_salary_min)';
   COMMENT ON COLUMN "HRPLUS"."EMPLOYEES"."COMMISSION_PCT" IS 'Commission percentage of the employee; Only employees in sales
department elgible for commission percentage';
   COMMENT ON COLUMN "HRPLUS"."EMPLOYEES"."MANAGER_ID" IS 'Manager id of the employee; has same domain as manager_id in
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query)';
   COMMENT ON COLUMN "HRPLUS"."EMPLOYEES"."DEPARTMENT_ID" IS 'Department id where employee works; foreign key to department_id
column of the departments table';
--END_OF_DDL

--START_OF_DDL
  CREATE TABLE "HRPLUS"."EMP_AUDIT"
   (	"EMP_AUDIT_ID" NUMBER(6,0),
	"UP_DATE" DATE,
	"NEW_SAL" NUMBER(8,2),
	"OLD_SAL" NUMBER(8,2)
   ) ;
--END_OF_DDL

--START_OF_DDL
  CREATE TABLE "HRPLUS"."JOBS"
   (	"JOB_ID" VARCHAR2(10),
	"JOB_TITLE" VARCHAR2(35) CONSTRAINT "JOB_TITLE_NN" NOT NULL ENABLE,
	"MIN_SALARY" NUMBER(6,0),
	"MAX_SALARY" NUMBER(6,0),
	 CONSTRAINT "JOB_ID_PK" PRIMARY KEY ("JOB_ID")
  USING INDEX  ENABLE
   ) ;
   COMMENT ON TABLE "HRPLUS"."JOBS"  IS 'jobs table with job titles and salary ranges. Contains 19 rows.
References with employees and job_history table.';
   COMMENT ON COLUMN "HRPLUS"."JOBS"."JOB_ID" IS 'Primary key of jobs table.';
   COMMENT ON COLUMN "HRPLUS"."JOBS"."JOB_TITLE" IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT';
   COMMENT ON COLUMN "HRPLUS"."JOBS"."MIN_SALARY" IS 'Minimum salary for a job title.';
   COMMENT ON COLUMN "HRPLUS"."JOBS"."MAX_SALARY" IS 'Maximum salary for a job title';
--END_OF_DDL

--START_OF_DDL
  CREATE TABLE "HRPLUS"."JOB_HISTORY"
   (	"EMPLOYEE_ID" NUMBER(6,0) CONSTRAINT "JHIST_EMPLOYEE_NN" NOT NULL ENABLE,
	"START_DATE" DATE CONSTRAINT "JHIST_START_DATE_NN" NOT NULL ENABLE,
	"END_DATE" DATE CONSTRAINT "JHIST_END_DATE_NN" NOT NULL ENABLE,
	"JOB_ID" VARCHAR2(10) CONSTRAINT "JHIST_JOB_NN" NOT NULL ENABLE,
	"DEPARTMENT_ID" NUMBER(4,0),
	 CONSTRAINT "JHIST_DATE_INTERVAL" CHECK (end_date > start_date) ENABLE,
	 CONSTRAINT "JHIST_EMP_ID_ST_DATE_PK" PRIMARY KEY ("EMPLOYEE_ID", "START_DATE")
  USING INDEX  ENABLE
   ) ;
   COMMENT ON TABLE "HRPLUS"."JOB_HISTORY"  IS 'Table that stores job history of the employees. If an employee
changes departments within the job or changes jobs within the department,
new rows get inserted into this table with old job information of the
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.';
   COMMENT ON COLUMN "HRPLUS"."JOB_HISTORY"."EMPLOYEE_ID" IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table';
   COMMENT ON COLUMN "HRPLUS"."JOB_HISTORY"."START_DATE" IS 'A not null column in the complex primary key employee_id+start_date.
Must be less than the end_date of the job_history table. (enforced by
constraint jhist_date_interval)';
   COMMENT ON COLUMN "HRPLUS"."JOB_HISTORY"."END_DATE" IS 'Last day of the employee in this job role. A not null column. Must be
greater than the start_date of the job_history table.
(enforced by constraint jhist_date_interval)';
   COMMENT ON COLUMN "HRPLUS"."JOB_HISTORY"."JOB_ID" IS 'Job role in which the employee worked in the past; foreign key to
job_id column in the jobs table. A not null column.';
   COMMENT ON COLUMN "HRPLUS"."JOB_HISTORY"."DEPARTMENT_ID" IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table';
--END_OF_DDL

--START_OF_DDL
  CREATE TABLE "HRPLUS"."LOCATIONS"
   (	"LOCATION_ID" NUMBER(4,0),
	"STREET_ADDRESS" VARCHAR2(40),
	"POSTAL_CODE" VARCHAR2(12),
	"CITY" VARCHAR2(30) CONSTRAINT "LOC_CITY_NN" NOT NULL ENABLE,
	"STATE_PROVINCE" VARCHAR2(25),
	"COUNTRY_ID" CHAR(2),
	 CONSTRAINT "LOC_ID_PK" PRIMARY KEY ("LOCATION_ID")
  USING INDEX  ENABLE
   ) ;
   COMMENT ON TABLE "HRPLUS"."LOCATIONS"  IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables. ';
   COMMENT ON COLUMN "HRPLUS"."LOCATIONS"."LOCATION_ID" IS 'Primary key of locations table';
   COMMENT ON COLUMN "HRPLUS"."LOCATIONS"."STREET_ADDRESS" IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name';
   COMMENT ON COLUMN "HRPLUS"."LOCATIONS"."POSTAL_CODE" IS 'Postal code of the location of an office, warehouse, or production site
of a company. ';
   COMMENT ON COLUMN "HRPLUS"."LOCATIONS"."CITY" IS 'A not null column that shows city where an office, warehouse, or
production site of a company is located. ';
   COMMENT ON COLUMN "HRPLUS"."LOCATIONS"."STATE_PROVINCE" IS 'State or Province where an office, warehouse, or production site of a
company is located.';
   COMMENT ON COLUMN "HRPLUS"."LOCATIONS"."COUNTRY_ID" IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.';
--END_OF_DDL

--START_OF_DDL
  CREATE TABLE "HRPLUS"."REGIONS"
   (	"REGION_ID" NUMBER CONSTRAINT "REGION_ID_NN" NOT NULL ENABLE,
	"REGION_NAME" VARCHAR2(25),
	 CONSTRAINT "REG_ID_PK" PRIMARY KEY ("REGION_ID")
  USING INDEX  ENABLE
   ) ;
--END_OF_DDL

########################################
## PARTITION TABLE DDL
########################################
########################################
## CACHE TABLE DDL
########################################
########################################
## CLUSTER TABLE DDL
########################################
########################################
## KEEP TABLE DDL
########################################
########################################
## IOT TABLE DDL
########################################
--START_OF_DDL
  CREATE TABLE "HRPLUS"."COUNTRIES"
   (	"COUNTRY_ID" CHAR(2) CONSTRAINT "COUNTRY_ID_NN" NOT NULL ENABLE,
	"COUNTRY_NAME" VARCHAR2(40),
	"REGION_ID" NUMBER,
	 CONSTRAINT "COUNTRY_C_ID_PK" PRIMARY KEY ("COUNTRY_ID") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS ;
   COMMENT ON TABLE "HRPLUS"."COUNTRIES"  IS 'country table. Contains 25 rows. References with locations table.';
   COMMENT ON COLUMN "HRPLUS"."COUNTRIES"."COUNTRY_ID" IS 'Primary key of countries table.';
   COMMENT ON COLUMN "HRPLUS"."COUNTRIES"."COUNTRY_NAME" IS 'Country name';
   COMMENT ON COLUMN "HRPLUS"."COUNTRIES"."REGION_ID" IS 'Region ID for the country. Foreign key to region_id column in the departments table.';
--END_OF_DDL

########################################
## COMPRESSED TABLE DDL
########################################
########################################
## EXTERNAL TABLE DDL
########################################
########################################
## INDEXES DDL
########################################
--START_OF_DDL
  CREATE INDEX "HRPLUS"."DEPT_LOCATION_IX" ON "HRPLUS"."DEPARTMENTS" ("LOCATION_ID")
  ;
--END_OF_DDL

--START_OF_DDL
  CREATE INDEX "HRPLUS"."EMP_DEPARTMENT_IX" ON "HRPLUS"."EMPLOYEES" ("DEPARTMENT_ID")
  ;
--END_OF_DDL

--START_OF_DDL
  CREATE INDEX "HRPLUS"."EMP_JOB_IX" ON "HRPLUS"."EMPLOYEES" ("JOB_ID")
  ;
--END_OF_DDL

--START_OF_DDL
  CREATE INDEX "HRPLUS"."EMP_MANAGER_IX" ON "HRPLUS"."EMPLOYEES" ("MANAGER_ID")
  ;
--END_OF_DDL

--START_OF_DDL
  CREATE INDEX "HRPLUS"."EMP_NAME_IX" ON "HRPLUS"."EMPLOYEES" ("LAST_NAME", "FIRST_NAME")
  ;
--END_OF_DDL

--START_OF_DDL
  CREATE INDEX "HRPLUS"."JHIST_DEPARTMENT_IX" ON "HRPLUS"."JOB_HISTORY" ("DEPARTMENT_ID")
  ;
--END_OF_DDL

--START_OF_DDL
  CREATE INDEX "HRPLUS"."JHIST_EMPLOYEE_IX" ON "HRPLUS"."JOB_HISTORY" ("EMPLOYEE_ID")
  ;
--END_OF_DDL

--START_OF_DDL
  CREATE INDEX "HRPLUS"."JHIST_JOB_IX" ON "HRPLUS"."JOB_HISTORY" ("JOB_ID")
  ;
--END_OF_DDL

--START_OF_DDL
  CREATE INDEX "HRPLUS"."LOC_CITY_IX" ON "HRPLUS"."LOCATIONS" ("CITY")
  ;
--END_OF_DDL

--START_OF_DDL
  CREATE INDEX "HRPLUS"."LOC_COUNTRY_IX" ON "HRPLUS"."LOCATIONS" ("COUNTRY_ID")
  ;
--END_OF_DDL

--START_OF_DDL
  CREATE INDEX "HRPLUS"."LOC_STATE_PROVINCE_IX" ON "HRPLUS"."LOCATIONS" ("STATE_PROVINCE")
  ;
--END_OF_DDL

########################################
## CONSTRAINTS
########################################
## Foreign Keys
###############

--START_OF_DDL
  ALTER TABLE "HRPLUS"."COUNTRIES" ADD CONSTRAINT "COUNTR_REG_FK" FOREIGN KEY ("REGION_ID")
	  REFERENCES "HRPLUS"."REGIONS" ("REGION_ID") ENABLE;
--END_OF_DDL

--START_OF_DDL
  ALTER TABLE "HRPLUS"."DEPARTMENTS" ADD CONSTRAINT "DEPT_LOC_FK" FOREIGN KEY ("LOCATION_ID")
	  REFERENCES "HRPLUS"."LOCATIONS" ("LOCATION_ID") ENABLE;
--END_OF_DDL

--START_OF_DDL
  ALTER TABLE "HRPLUS"."DEPARTMENTS" ADD CONSTRAINT "DEPT_MGR_FK" FOREIGN KEY ("MANAGER_ID")
	  REFERENCES "HRPLUS"."EMPLOYEES" ("EMPLOYEE_ID") ENABLE;
--END_OF_DDL

--START_OF_DDL
  ALTER TABLE "HRPLUS"."EMPLOYEES" ADD CONSTRAINT "EMP_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID")
	  REFERENCES "HRPLUS"."DEPARTMENTS" ("DEPARTMENT_ID") ENABLE;
--END_OF_DDL

--START_OF_DDL
  ALTER TABLE "HRPLUS"."EMPLOYEES" ADD CONSTRAINT "EMP_JOB_FK" FOREIGN KEY ("JOB_ID")
	  REFERENCES "HRPLUS"."JOBS" ("JOB_ID") ENABLE;
--END_OF_DDL

--START_OF_DDL
  ALTER TABLE "HRPLUS"."EMPLOYEES" ADD CONSTRAINT "EMP_MANAGER_FK" FOREIGN KEY ("MANAGER_ID")
	  REFERENCES "HRPLUS"."EMPLOYEES" ("EMPLOYEE_ID") ENABLE;
--END_OF_DDL

--START_OF_DDL
  ALTER TABLE "HRPLUS"."JOB_HISTORY" ADD CONSTRAINT "JHIST_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID")
	  REFERENCES "HRPLUS"."DEPARTMENTS" ("DEPARTMENT_ID") ENABLE;
--END_OF_DDL

--START_OF_DDL
  ALTER TABLE "HRPLUS"."JOB_HISTORY" ADD CONSTRAINT "JHIST_EMP_FK" FOREIGN KEY ("EMPLOYEE_ID")
	  REFERENCES "HRPLUS"."EMPLOYEES" ("EMPLOYEE_ID") ENABLE;
--END_OF_DDL

--START_OF_DDL
  ALTER TABLE "HRPLUS"."JOB_HISTORY" ADD CONSTRAINT "JHIST_JOB_FK" FOREIGN KEY ("JOB_ID")
	  REFERENCES "HRPLUS"."JOBS" ("JOB_ID") ENABLE;
--END_OF_DDL

--START_OF_DDL
  ALTER TABLE "HRPLUS"."LOCATIONS" ADD CONSTRAINT "LOC_C_ID_FK" FOREIGN KEY ("COUNTRY_ID")
	  REFERENCES "HRPLUS"."COUNTRIES" ("COUNTRY_ID") ENABLE;
--END_OF_DDL

########################################
## VIEWS
########################################
--START_OF_DDL
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HRPLUS"."EMP_DETAILS_VIEW" ("EMPLOYEE_ID", "JOB_ID", "MANAGER_ID", "DEPARTMENT_ID", "LOCATION_ID", "COUNTRY_ID", "FIRST_NAME", "LAST_NAME", "SALARY", "COMMISSION_PCT", "DEPARTMENT_NAME", "JOB_TITLE", "CITY", "STATE_PROVINCE", "COUNTRY_NAME", "REGION_NAME") AS
  SELECT
  e.employee_id,
  e.job_id,
  e.manager_id,
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id
WITH READ ONLY;
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HRPLUS"."EMPLOYEE_MANAGEMENT_CHAIN_VIEW" ("Employee", "Heirarchy Level", "Management Chain") AS
  SELECT last_name||', '||first_name "Employee"
     , LEVEL "Heirarchy Level"
     , SUBSTR( SYS_CONNECT_BY_PATH( last_name||', '||SUBSTR(first_name, 1, 1)||'.', ' -> ' ), 4 ) "Management Chain"
  FROM hrplus.employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY last_name, first_name;
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HRPLUS"."EMPLOYEES_BY_DEPARTMENT_VIEW" ("EMPLOYEE_ID", "FIRST_NAME", "LAST_NAME", "DEPARTMENT_NAME", "POSITION", "SALARY", "MANAGER") AS
  SELECT e.employee_id
     , e.first_name
     , e.last_name
     , d.department_name
     , j.job_title position
     , e.salary
     , em.last_name manager
  FROM hrplus.employees e
     , hrplus.jobs j
     , hrplus.departments d
     , hrplus.employees em
 WHERE e.job_id = j.job_id
   AND e.department_id = d.department_id
   AND em.employee_id (+) = e.manager_id
ORDER BY 4, 7, 5, 3, 2, 1;
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HRPLUS"."EMPLOYEES_MANAGER_ID" ("EMPLOYEE_ID", "LAST_NAME", "MANAGER_ID") AS
  SELECT employee_id, last_name, manager_id
   FROM employees
   CONNECT BY PRIOR employee_id = manager_id;
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HRPLUS"."ERROR_VIEW" ("COUNTRY_ID", "REGION_ID", "BITANDTEST") AS
  SELECT
  country_id,
  region_id,
  BITAND(10111, 10101) bitandtest
FROM COUNTRIES;
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HRPLUS"."EMPLOYEES_DEPARTMENT_OUTER_JOIN" ("FIRST_NAME", "LAST_ANME", "DEPARTMENT_NAME") AS
  SELECT first_name,
         last_name,
         department_name
  FROM   hrplus.employees e,
         hrplus.departments d
  WHERE  e.department_id (+) = d.department_id;
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HRPLUS"."PLANNED_COMMISSION_UPDATES_VIEW" ("FIRST_NAME", "LAST_NAME", "SALARY", "CURRENT_COMMISSION_PCT", "NEW_COMMISSION_PCT") AS
  SELECT first_name
     , last_name
     , salary
     , commission_pct current_commission_pct
     , ROUND(commission_pct*1.0825,2.0) new_commission_pct
  FROM emp_details_view
 WHERE commission_pct IS NOT NULL;
--END_OF_DDL

########################################
## MATERIALIZED VIEWS
########################################
########################################
## TRIGGERS
########################################
--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE TRIGGER "HRPLUS"."AUDIT_SAL"
   AFTER UPDATE OF salary ON employees FOR EACH ROW
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
-- bind variables are used here for values
   INSERT INTO emp_audit VALUES( :old.employee_id, SYSDATE,
                                 :new.salary, :old.salary );
  COMMIT;
END;
/
ALTER TRIGGER "HRPLUS"."AUDIT_SAL" ENABLE;
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE TRIGGER "HRPLUS"."SECURE_EMPLOYEES"
  BEFORE INSERT OR UPDATE OR DELETE ON employees
BEGIN
  secure_dml;
END secure_employees;
/
ALTER TRIGGER "HRPLUS"."SECURE_EMPLOYEES" DISABLE;
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE TRIGGER "HRPLUS"."UPDATE_JOB_HISTORY"
  AFTER UPDATE OF job_id, department_id ON employees
  FOR EACH ROW
BEGIN
  add_job_history(:old.employee_id, :old.hire_date, sysdate,
                  :old.job_id, :old.department_id);
END;
/
ALTER TRIGGER "HRPLUS"."UPDATE_JOB_HISTORY" ENABLE;
--END_OF_DDL

########################################
## FUNCTIONS
########################################
--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE FUNCTION "HRPLUS"."EMP_SAL_RANKING" (empid NUMBER)
  RETURN NUMBER IS
  minsal        employees.salary%TYPE; -- declare a variable same as salary
  maxsal        employees.salary%TYPE; -- declare a variable same as salary
  jobid         employees.job_id%TYPE; -- declare a variable same as job_id
  sal           employees.salary%TYPE; -- declare a variable same as salary
BEGIN
-- retrieve the jobid and salary for the specific employee ID
  SELECT job_id, salary INTO jobid, sal FROM employees WHERE employee_id = empid;
-- retrieve the minimum and maximum salaries for employees with the same job ID
  SELECT MIN(salary), MAX(salary) INTO minsal, maxsal FROM employees
      WHERE job_id = jobid;
-- return the ranking as a decimal, based on the following calculation
  RETURN ((sal - minsal)/(maxsal - minsal));
END emp_sal_ranking;
/
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE FUNCTION "HRPLUS"."LAST_FIRST_NAME" (empid NUMBER)
  RETURN VARCHAR2 IS
  lastname   employees.last_name%TYPE; -- declare a variable same as last_name
  firstname  employees.first_name%TYPE; -- declare a variable same as first_name
BEGIN
  SELECT last_name, first_name INTO lastname, firstname FROM employees
    WHERE employee_id = empid;
  RETURN ( 'Employee: ' || empid || ' - ' || UPPER(lastname)
                                 || ', ' || UPPER(firstname) );
END last_first_name;
/
--END_OF_DDL

########################################
## PROCEDURES
########################################
--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE PROCEDURE "HRPLUS"."ADD_JOB_HISTORY"
  (  p_emp_id          job_history.employee_id%type
   , p_start_date      job_history.start_date%type
   , p_end_date        job_history.end_date%type
   , p_job_id          job_history.job_id%type
   , p_department_id   job_history.department_id%type
   )
IS
BEGIN
  INSERT INTO job_history (employee_id, start_date, end_date,
                           job_id, department_id)
    VALUES(p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id);
END add_job_history;
/
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE PROCEDURE "HRPLUS"."AWARD_BONUS" (emp_id IN NUMBER, bonus_rate IN NUMBER)
  AS
-- declare variables to hold values from table columns, use %TYPE attribute
   emp_comm        employees.commission_pct%TYPE;
   emp_sal         employees.salary%TYPE;
-- declare an exception to catch when the salary is NULL
   salary_missing  EXCEPTION;
BEGIN  -- executable part starts here
-- select the column values into the local variables
   SELECT salary, commission_pct INTO emp_sal, emp_comm FROM employees
    WHERE employee_id = emp_id;
-- check whether the salary for the employee is null, if so, raise an exception
   IF emp_sal IS NULL THEN
     RAISE salary_missing;
   ELSE
     IF emp_comm IS NULL THEN
-- if this is not a commissioned employee, increase the salary by the bonus rate
-- for this example, do not make the actual update to the salary
-- UPDATE employees SET salary = salary + salary * bonus_rate
--   WHERE employee_id = emp_id;
       DBMS_OUTPUT.PUT_LINE('Employee ' || emp_id || ' receives a bonus: '
                            || TO_CHAR(emp_sal * bonus_rate) );
     ELSE
       DBMS_OUTPUT.PUT_LINE('Employee ' || emp_id
                            || ' receives a commission. No bonus allowed.');
     END IF;
   END IF;
EXCEPTION  -- exception-handling part starts here
   WHEN salary_missing THEN
      DBMS_OUTPUT.PUT_LINE('Employee ' || emp_id ||
                           ' does not have a value for salary. No update.');
   WHEN OTHERS THEN
      NULL; -- for other exceptions do nothing
END award_bonus;
/
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE PROCEDURE "HRPLUS"."COMMA_TO_TABLE" (
    p_list      VARCHAR2
)
IS
    r_lname     DBMS_UTILITY.LNAME_ARRAY;
    v_length    BINARY_INTEGER;
BEGIN
    DBMS_UTILITY.COMMA_TO_TABLE(p_list,v_length,r_lname);
    FOR i IN 1..v_length LOOP
        DBMS_OUTPUT.PUT_LINE(r_lname(i));
    END LOOP;
END;
/
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE PROCEDURE "HRPLUS"."CREATE_LOG_TABLE"
-- use AUTHID CURRENT _USER to execute with the privileges and
-- schema context of the calling user
  AUTHID CURRENT_USER AS
  tabname       VARCHAR2(30); -- variable for table name
  temptabname   VARCHAR2(30); -- temporary variable for table name
  currentdate   VARCHAR2(8);  -- varible for current date
BEGIN
-- extract, format, and insert the year, month, and day from SYSDATE into
-- the currentdate variable
  SELECT TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ||
     TO_CHAR(EXTRACT(MONTH FROM SYSDATE),'FM09') ||
     TO_CHAR(EXTRACT(DAY FROM SYSDATE),'FM09') INTO currentdate FROM DUAL;
-- construct the log table name with the current date as a suffix
  tabname := 'log_table_' || currentdate;

-- check whether a table already exists with that name
-- if it does NOT exist, then go to exception handler and create table
-- if the table does exist, then note that table already exists
  SELECT TABLE_NAME INTO temptabname FROM USER_TABLES
    WHERE TABLE_NAME = UPPER(tabname);
  DBMS_OUTPUT.PUT_LINE('Table ' || tabname || ' already exists.');

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
    -- this means the table does not exist because the table name
    -- was not found in USER_TABLES
      BEGIN
-- use EXECUTE IMMEDIATE to create a table with tabname as the table name
        EXECUTE IMMEDIATE 'CREATE TABLE ' || tabname
                         || '(op_time VARCHAR2(10), operation VARCHAR2(50))' ;
        DBMS_OUTPUT.PUT_LINE(tabname || ' has been created');
      END;

END create_log_table;
/
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE PROCEDURE "HRPLUS"."INCREASE_SALARY_BULK"
IS
 TYPE EmployeeSet IS TABLE OF employees%ROWTYPE;
   underpaid EmployeeSet;
     -- Holds set of rows from EMPLOYEES table.
   CURSOR c1 IS SELECT first_name, last_name FROM employees;
   TYPE NameSet IS TABLE OF c1%ROWTYPE;
   some_names NameSet;
     -- Holds set of partial rows from EMPLOYEES table.
BEGIN
-- With one query,
-- bring all relevant data into collection of records.
   SELECT * BULK COLLECT INTO underpaid FROM employees
      WHERE salary < 5000 ORDER BY salary DESC;
-- Process data by examining collection or passing it to
-- eparate procedure, instead of writing loop to FETCH each row.
   DBMS_OUTPUT.PUT_LINE
     (underpaid.COUNT || ' people make less than 5000.');
   FOR i IN underpaid.FIRST .. underpaid.LAST
   LOOP
     DBMS_OUTPUT.PUT_LINE
       (underpaid(i).last_name || ' makes ' || underpaid(i).salary);
   END LOOP;
-- You can also bring in just some of the table columns.
-- Here you get the first and last names of 10 arbitrary employees.
   SELECT first_name, last_name
     BULK COLLECT INTO some_names
     FROM employees
     WHERE ROWNUM < 11;
   FOR i IN some_names.FIRST .. some_names.LAST
   LOOP
      DBMS_OUTPUT.PUT_LINE
        ('Employee = ' || some_names(i).first_name
         || ' ' || some_names(i).last_name);
   END LOOP;
END;
/
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE PROCEDURE "HRPLUS"."NESTED_SWAP_PROCEDURE"
IS
    first_number    NUMBER;
    second_number   NUMBER;

    PROCEDURE swapn (num_one IN OUT NUMBER, num_two IN OUT NUMBER) IS
      temp_num    NUMBER;
    BEGIN
      temp_num := num_one;
      num_one := num_two;
      num_two := temp_num ;
    END;

  BEGIN

    first_number := 10;
    second_number := 20;
    DBMS_OUTPUT.PUT_LINE('First Number = ' || TO_CHAR (first_number));
    DBMS_OUTPUT.PUT_LINE('Second Number = ' || TO_CHAR (second_number));

    --Swap the values
    DBMS_OUTPUT.PUT_LINE('Swapping the two values now.');
    swapn(first_number, second_number);

    --Display the results
    DBMS_OUTPUT.PUT_LINE('First Number = ' || to_CHAR (first_number));
    DBMS_OUTPUT.PUT_LINE('Second Number = ' || to_CHAR (second_number));
  END;
/
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE PROCEDURE "HRPLUS"."NEW_EMPLOYEE" (i_FIRST    IN VARCHAR2,
                                          i_LAST     IN VARCHAR2,
                                          i_email    IN VARCHAR2,
                                          i_phone    IN VARCHAR2,
                                          i_hired    IN DATE,
                                          i_job      IN VARCHAR2,
                                          i_deptno   IN NUMBER DEFAULT 0)
AS
   v_sql           VARCHAR2 (1000);

   cursor_var      NUMBER := DBMS_SQL.OPEN_CURSOR;
   rows_complete   NUMBER := 0;
   next_emp_id     NUMBER := employees_seq.NEXTVAL;
BEGIN
   IF i_deptno != 0
   THEN
      v_sql :=
            'INSERT INTO EMPLOYEES ( '
         || 'employee_id, first_name, last_name, email, '
         || 'phone_number, hire_date, job_id, department_id) '
         || 'VALUES( '
         || ':next_emp_id, :first, :last, :email, :phone, :hired, '
         || ':job_id, :dept)';
   ELSE
      v_sql :=
            'INSERT INTO EMPLOYEES ( '
         || 'employee_id, first_name, last_name, email, '
         || 'phone_number, hire_date, job_id) '
         || 'VALUES( '
         || ':next_emp_id, :first, :last, :email, :phone, :hired, '
         || ':job_id)';
   END IF;

   DBMS_SQL.PARSE (cursor_var, v_sql, DBMS_SQL.NATIVE);
   DBMS_SQL.BIND_VARIABLE (cursor_var, ':next_emp_id', next_emp_id);
   DBMS_SQL.BIND_VARIABLE (cursor_var, ':first', i_FIRST);
   DBMS_SQL.BIND_VARIABLE (cursor_var, ':last', i_LAST);
   DBMS_SQL.BIND_VARIABLE (cursor_var, ':email', i_email);
   DBMS_SQL.BIND_VARIABLE (cursor_var, ':phone', i_phone);

   DBMS_SQL.BIND_VARIABLE (cursor_var, ':hired', i_hired);

   DBMS_SQL.BIND_VARIABLE (cursor_var, ':job_id', i_job);

   IF i_deptno != 0
   THEN
      DBMS_SQL.BIND_VARIABLE (cursor_var, ':dept', i_deptno);
   END IF;

   rows_complete := DBMS_SQL.EXECUTE (cursor_var);
   DBMS_SQL.CLOSE_CURSOR (cursor_var);
   COMMIT;
END;
/
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE PROCEDURE "HRPLUS"."SECURE_DML"
IS
BEGIN
  IF TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00'
        OR TO_CHAR (SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
	RAISE_APPLICATION_ERROR (-20205,
		'You may only make changes during normal office hours');
  END IF;
END secure_dml;
/
--END_OF_DDL

--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE PROCEDURE "HRPLUS"."TODAY_IS" AS
BEGIN
-- display the current system date in long format
  DBMS_OUTPUT.PUT_LINE( 'Today is ' || TO_CHAR(SYSDATE, 'DL') );
END today_is;
/
--END_OF_DDL

########################################
## PACKAGE SPECIFICATION
########################################
--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE PACKAGE "HRPLUS"."EMP_ACTIONS" AS  -- package specification

  PROCEDURE hire_employee (lastname VARCHAR2,
    firstname VARCHAR2, email VARCHAR2, phoneno VARCHAR2,
    hiredate DATE, jobid VARCHAR2, sal NUMBER, commpct NUMBER,
    mgrid NUMBER, deptid NUMBER);
  PROCEDURE remove_employee (empid NUMBER);
  FUNCTION emp_sal_ranking (empid NUMBER) RETURN NUMBER;
END emp_actions;
/
--END_OF_DDL

########################################
## PACKAGE BODY
########################################
--START_OF_DDL
  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HRPLUS"."EMP_ACTIONS" AS  -- package body

-- code for procedure hire_employee, which adds a new employee
  PROCEDURE hire_employee (lastname VARCHAR2,
    firstname VARCHAR2, email VARCHAR2, phoneno VARCHAR2, hiredate DATE,
    jobid VARCHAR2, sal NUMBER, commpct NUMBER, mgrid NUMBER, deptid NUMBER) IS
    min_sal    employees.salary%TYPE; -- variable to hold minimum salary for jobid
    max_sal    employees.salary%TYPE; -- variable to hold maximum salary for jobid
    seq_value  NUMBER;  -- variable to hold next sequence value
  BEGIN
    -- get the next sequence number in the employees_seq sequence
    SELECT employees_seq.NEXTVAL INTO seq_value FROM DUAL;
    -- use the next sequence number for the new employee_id
    INSERT INTO employees VALUES (seq_value, lastname, firstname, email,
     phoneno, hiredate, jobid, sal, commpct, mgrid, deptid);
     SELECT min_salary INTO min_sal FROM jobs WHERE job_id = jobid;
     SELECT max_salary INTO max_sal FROM jobs WHERE job_id = jobid;
     IF sal > max_sal THEN
       DBMS_OUTPUT.PUT_LINE('Warning: ' || TO_CHAR(sal)
                 || ' is greater than the maximum salary '
                 || TO_CHAR(max_sal) || ' for the job classification ' || jobid );
     ELSIF sal < min_sal THEN
       DBMS_OUTPUT.PUT_LINE('Warning: ' || TO_CHAR(sal)
                 || ' is less than the minimum salary '
                 || TO_CHAR(min_sal) || ' for the job classification ' || jobid );
     END IF;
  END hire_employee;

-- code for procedure remove_employee, which removes an existing employee
  PROCEDURE remove_employee (empid NUMBER) IS
     firstname employees.first_name%TYPE;
     lastname  employees.last_name%TYPE;
  BEGIN
    SELECT first_name, last_name INTO firstname, lastname FROM employees
      WHERE employee_id = empid;
    DELETE FROM employees WHERE employee_id = empid;
    DBMS_OUTPUT.PUT_LINE('Employee: ' || TO_CHAR(empid) || ', '
                      || firstname || ', ' || lastname || ' has been deleted.');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Employee ID: ' || TO_CHAR(empid) || ' not found.');
  END remove_employee;

-- code for function emp_sal_ranking, which calculates the salary ranking of the
-- employee based on the minimum and maximum salaries for the job category
  FUNCTION emp_sal_ranking (empid NUMBER) RETURN NUMBER IS
    minsal        employees.salary%TYPE; -- declare a variable same as salary
    maxsal        employees.salary%TYPE; -- declare a variable same as salary
    jobid         employees.job_id%TYPE; -- declare a variable same as job_id
    sal           employees.salary%TYPE; -- declare a variable same as salary
  BEGIN
-- retrieve the jobid and salary for the specific employee ID
    SELECT job_id, salary INTO jobid, sal FROM employees
       WHERE employee_id = empid;
-- retrieve the minimum and maximum salaries for the job ID
    SELECT min_salary, max_salary INTO minsal, maxsal FROM jobs
       WHERE job_id = jobid;
-- return the ranking as a decimal, based on the following calculation
    RETURN ((sal - minsal)/(maxsal - minsal));
  END emp_sal_ranking;
END emp_actions;
/
--END_OF_DDL

########################################
## PROFILES
########################################
--START_OF_DDL
   ALTER PROFILE "DEFAULT"
    LIMIT
         COMPOSITE_LIMIT UNLIMITED
         SESSIONS_PER_USER UNLIMITED
         CPU_PER_SESSION UNLIMITED
         CPU_PER_CALL UNLIMITED
         LOGICAL_READS_PER_SESSION UNLIMITED
         LOGICAL_READS_PER_CALL UNLIMITED
         IDLE_TIME UNLIMITED
         CONNECT_TIME UNLIMITED
         PRIVATE_SGA UNLIMITED
         FAILED_LOGIN_ATTEMPTS 10
         PASSWORD_LIFE_TIME 15552000/86400
         PASSWORD_REUSE_TIME UNLIMITED
         PASSWORD_REUSE_MAX UNLIMITED
         PASSWORD_VERIFY_FUNCTION NULL
         PASSWORD_LOCK_TIME 86400/86400
         PASSWORD_GRACE_TIME 604800/86400
         INACTIVE_ACCOUNT_TIME UNLIMITED ;
--END_OF_DDL

########################################
## ROLES
########################################
########################################
## USERS
########################################
--START_OF_DDL
   CREATE USER "HRPLUS" IDENTIFIED BY VALUES 'S:55331FC53579807DFDEC45FB8EF352864C1ECEAC7EF3FB79CAED7AA0C9E6;T:DA2E8814526B6A6C864E575FC50DECF1FB0B9AD755621E35A23F6EB4266AB60141229631E75BCF1DD602C2A96EFBA28C3EADE54EA75BBB9ED5FB976893B2D796C3777E377FA34AE9738E989562EDD8A4'
      DEFAULT TABLESPACE "USERS"
      TEMPORARY TABLESPACE "TEMP";
--END_OF_DDL

####################################################################################################################################
## 1 Schema(s) Extracted Successfully:  HRPLUS
##
## Extraction Completed: 20-03-2024 22:22:37
####################################################################################################################################
