--create table for managers.csv
create table if not exists managers (
			dept_no varchar(10) not null
			, emp_no varchar(20) not null
		--	, mgr_id serial not null
			, primary key (emp_no);
		--	, foreign key (dept_no) references department(dept_no));

--create table for department.csv
create table if not exists department (
			dept_no varchar(10) not null
			, emp_no varchar(20) not null
			, primary key (dept_no)
			, foreign key (dept_no) references managers(dept_no));

--create table for employees.csv

create table if not exists employees (
			emp_no varchar(20) not null
			, emp_title varchar(5) not null
			, birth_date date not null
			, first_name varchar not null
			, last_name varchar not null
			, sex varchar(1) not null
			, hire_date date not null
			, primary key (emp_no));
			, foreign key (emp_no) references managers(emp_no);

	
	--create table for title.csv
create table if not exists titles (
			title_id varchar(10) not null
			, title varchar(30) not null
			, primary key (title_id));
			, foreign key (title_id) references employees(emp_title));
	
	
--create table for salaries.csv
create table if not exists salaries (
			emp_no varchar(20) not null
			, salary money not null
			, primary key (emp_no)
			, foreign key (emp_no) references employees(emp_no));


--create table for junction table			
create table if not exists emp_dept_junction (
			emp_no varchar(20) not null
			, dept_no varchar(10) not null
			, primary key (emp_no, dept_no)
		--	, foreign key (emp_no) references employees(emp_no)
		--	, foreign key (dept_no) references department(dept_no)
			);
			
--insert into emp_dept_junction (emp_no, dept_no)
			 -- values ('10001', 'd005');
			
-- drop table emp_dept_junction

alter table employees
add foreign key (emp_no) references emp_dept_junction(emp_no);

alter table department
add foreign key (dept_no) references emp_dept_junction(dept_no)

--alter table managers
--add primary key (emp_no, dept_no);

--alter table titles
--add primary key 
--add foreign key (title_id) references employees(emp_title)

--alter table employees
--add foreign key (emp_title) references titles(title_id)


--List the employee number, last name, first name, sex, and salary of each employee.

select employees.emp_no
		, employees.last_name
		, employees.first_name
		, employees.sex 
		, salaries.salary
	from employees
	left join salaries on employees.emp_no = salaries.emp_no
	order by employees.last_name

select * from employees
select * from emp_dept_junction
select * from department
select * from managers
select * from titles
select * from salaries

-- adding foreign keys



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
		inner join department as dept on managers.dept_no = dept.dept_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

select dept.dept_no
		, emp.emp_no
		, emp.last_name
		, emp.first_name
		, dept.dept_name
		from employees as emp
		join emp_dept_junction as j on emp.emp_no = j.emp_no
		left join department as dept on dept.dept_no = j.dept_no
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
		left join department as dept on dept.dept_no = j.dept_no
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
		left join department as dept on dept.dept_no = j.dept_no
		where dept.dept_name = 'Sales'
		or dept.dept_name = 'Development';

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

select emp.last_name, count(emp.last_name) as last_name_count
	from employees as emp
	group by emp.last_name
	order by last_name_count desc;
