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

--create table for department.csv
create table if not exists department (
			dept_no varchar(10) not null
			, emp_no varchar(30) not null
			, primary key (dept_no));

--create table for managers.csv
create table if not exists managers (
			dept_no varchar(10) not null
			, emp_no varchar(40) not null
		--	, mgr_id serial not null
		--	, primary key (mgr_id)
			, foreign key (dept_no) references department(dept_no));

--create table for salaries.csv
create table if not exists salaries (
			emp_no varchar(20) not null
			, salary money not null
			, primary key (emp_no)
			, foreign key (emp_no) references employees(emp_no));

--create table for title.csv
create table if not exists titles (
			title_id varchar(10) not null
			, title varchar(30) not null
			, primary key (title_id));
--			, foreign key (title_id) references employees(emp_title));

--create table for junction table			
create table if not exists emp_dept_junction (
			emp_no varchar(20) not null
			, dept_no varchar(10) not null
			, primary key (emp_no, dept_no)
			, foreign key (emp_no) references employees(emp_no)
			, foreign key (dept_no) references department(dept_no)
			);
			
insert into emp_dept_junction (emp_no, dept_no)
			  values ('10001', 'd005');
			
 drop table emp_dept_junction

alter table employees
add foreign key (emp_no) references emp_dept_junction(emp_no);

alter table department
add foreign key (dept_no) references emp_dept_junction(dept_no)

alter table managers
add primary key (emp_no, dept_no);

alter table titles
add primary key 
add foreign key (title_id) references employees(emp_title)

alter table employees
add foreign key (emp_title) references titles(title_id)

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

select employees.last_name
	, employees.first_name
	, employees.hire_date
	from employees
	where hire_date >= '1986-01-01'
		and hire_date <= '1986-12-31'
		
--List the manager of each department along with their department number, department name, employee number, last name, and first name.

select department.dept_no
		, department.dept_name
		, employees.emp_no
		, employees.last_name
		, employees.first_name
		from managers
		inner join employees on managers.emp_no = employees.emp_no
		inner join department on managers.dept_no = department.dept_no;

select * from managers

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

select d.dept_no
		, e.emp_no
		, e.last_name
		, e.first_name
		, d.dept_name
		from employees as e
		join emp_dept_junction as j on e.emp_no = j.emp_no
		left join department as d on d.dept_no = j.dept_no
		order by e.last_name

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

select employees.first_name
		, employees.last_name
		, employees.sex
		from employees
		where employees.first_name = 'Hercules'
		and employees.last_name like 'B%'


--List each employee in the Sales department, including their employee number, last name, and first name.

select e.emp_no
		, e.last_name
		, e.first_name
		, j.dept_no
		, d.dept_name
		from employees as e
		left join emp_dept_junction as j on e.emp_no = j.emp_no
		left join department as d on d.dept_no = j.dept_no
		where d.dept_name = 'Sales'
				
--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

select e.emp_no
		, e.last_name
		, e.first_name
		, j.dept_no
		, d.dept_name
		from employees as e
		left join emp_dept_junction as j on e.emp_no = j.emp_no
		left join department as d on d.dept_no = j.dept_no
		where d.dept_name = 'Sales'
		or d.dept_name = 'Development';

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

select e.last_name, count(e.last_name) as last_name_count
	from employees as e
	group by e.last_name
	order by e.last_name
