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

--List the employee number, last name, first name, sex, and salary of each employee.

select employees.emp_no
		, employees.last_name
		, employees.first_name
		, employees.sex 
		, salaries.salary
	from employees
	left join salaries on employees.emp_no = salaries.emp_no
	order by employees.last_name

--List the first name, last name, and hire date for the employees who were hired in 1986.

select emp.last_name
	, emp.first_name
	, emp.hire_date
	from employees as emp
	where hire_date >= '1986-01-01'
		and hire_date <= '1986-12-31'
	order by emp.hire_date;
		
--List the manager of each department along with their department number, department name, employee number, last name, and first name.

select dept.dept_no
		, dept.dept_name
		, emp.emp_no
		, emp.last_name
		, emp.first_name
		from managers
		inner join employees as emp on managers.emp_no = emp.emp_no
		inner join departments as dept on managers.dept_no = dept.dept_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

select dept.dept_no
		, emp.emp_no
		, emp.last_name
		, emp.first_name
		, dept.dept_name
		from employees as emp
		join emp_dept_junction as j on emp.emp_no = j.emp_no
		left join departments as dept on dept.dept_no = j.dept_no
		order by emp.last_name;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

select emp.first_name
		, emp.last_name
		, emp.sex
		from employees as emp
		where emp.first_name = 'Hercules'
		and emp.last_name like 'B%';


--List each employee in the Sales department, including their employee number, last name, and first name.

select emp.emp_no
		, emp.last_name
		, emp.first_name
		, j.dept_no
		, dept.dept_name
		from employees as emp
		left join emp_dept_junction as j on emp.emp_no = j.emp_no
		left join departments as dept on dept.dept_no = j.dept_no
		where dept.dept_name = 'Sales'
		order by emp.emp_no;
				
--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

select emp.emp_no
		, emp.last_name
		, emp.first_name
		, j.dept_no
		, dept.dept_name
		from employees as emp
		left join emp_dept_junction as j on emp.emp_no = j.emp_no
		left join departments as dept on dept.dept_no = j.dept_no
		where dept.dept_name = 'Sales'
		or dept.dept_name = 'Development';

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

select emp.last_name, count(emp.last_name) as last_name_count
	from employees as emp
	group by emp.last_name
	order by last_name_count desc;
