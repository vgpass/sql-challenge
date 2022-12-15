-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/hdIv5A
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Department" (
    dept_no varchar(10)   NOT NULL,
    dept_name varchar(30)   NOT NULL,
    CONSTRAINT pk_Department PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE "Titles" (
    title_id varchar(10)   NOT NULL,
    title varchar(30)   NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (
        title_id
     )
);

CREATE TABLE if not exists Employees (
    emp_no varchar(20)   NOT NULL,
    emp_title varchar(10)   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar(40)   NOT NULL,
    last_name varchar(40)   NOT NULL,
    sex varchar(1)   NOT NULL,
    hire_date date   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE Managers (
    dept_no varchar(10)   NOT NULL,
    emp_no varchar(20)   NOT NULL,
    CONSTRAINT "pk_Managers" PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE Salaries (
    emp_no varchar(20)   NOT NULL,
    salary money   NOT NULL,
    CONSTRAINT pk_Salaries PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE Emp_dept_junction (
    emp_no varchar(20)   NOT NULL,
    dept_no varchar(10)   NOT NULL,
    PRIMARY KEY (
        emp_no, dept_no
     )
);

ALTER TABLE Employees ADD CONSTRAINT fk_Employees_emp_title FOREIGN KEY(emp_title)
REFERENCES Titles (title_id);

ALTER TABLE "Managers" ADD CONSTRAINT "fk_Managers_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Department" ("dept_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Emp_dept_junction" ("emp_no");

ALTER TABLE "Emp_dept_junction" ADD CONSTRAINT "fk_Emp_dept_junction_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Emp_dept_junction" ADD CONSTRAINT "fk_Emp_dept_junction_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Department" ("dept_no");

drop table Employees
select * from Employees
