-- Table creation and schema
-- Vincent Passanisi

CREATE TABLE IF NOT EXISTS departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE IF NOT EXISTS emp_dept_junction (
    emp_no INT   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    CONSTRAINT pk_emp_dept_junction PRIMARY KEY (
        emp_no,dept_no
     )
);

CREATE TABLE IF NOT EXISTS managers (
    dept_no VARCHAR   NOT NULL,
    emp_no INT   NOT NULL,
    CONSTRAINT pk_managers PRIMARY KEY (
        dept_no,emp_no
     )
);

CREATE TABLE IF NOT EXISTS employees (
    emp_no INT   NOT NULL,
    emp_title_id VARCHAR   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE IF NOT EXISTS salaries (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL,
    CONSTRAINT pk_salaries PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE IF NOT EXISTS titles (
    title_id VARCHAR   NOT NULL,
    title VARCHAR   NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (
        title_id
     )
);

-- ***IMPORTED DATA INTO TABLES HERE***

-- Add foreign keys to all tables. 

ALTER TABLE emp_dept_junction ADD CONSTRAINT fk_emp_dept_junction_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE emp_dept_junction ADD CONSTRAINT fk_emp_dept_junction_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE managers ADD CONSTRAINT fk_managers_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE managers ADD CONSTRAINT fk_managers_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE employees ADD CONSTRAINT fk_employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES titles (title_id);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

-- Verify table data is complete and primary and foreign keys have been generated.

select * from employees;
select * from emp_dept_junction;
select * from departments;
select * from managers;
select * from titles;
select * from salaries;
