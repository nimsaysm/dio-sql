create schema if not exists company_constraints;
use company_constraints;

create table employee(
	Fname varchar(15) not null,
    Minit char,
    Lname varchar(15) not null,
    Ssn char(9) not null,
    Bdate date,
    Adress varchar(30),
    Sex char,
    Salary decimal(10,2),
    Super_ssn char(9),
    Dno int not null,
    constraint chk_salary_employee check (Salary > 2000.0),
    constraint pk_employee primary key (Ssn)
);

alter table employee
	add constraint fk_employee
    foreign key(Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade;

create table department(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9) not null,
    Mgr_start_date date,
    Dept_create_date date,
    constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
    constraint pk_dept primary key (Dnumber),
    constraint unique_name_dept unique (Dname),
    foreign key (Mgr_ssn) references employee(Ssn)
);

-- modificar constraint: drop e add

alter table department drop constraint department_ibfk_1;
alter table department 
	add constraint fk_dept foreign key(Mgr_ssn) references employee(Ssn)
    on update cascade;

create table dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references department(Dnumber)
);

alter table dept_locations drop constraint fk_dept_locations;
alter table dept_locations 
	add constraint fk_dept_locations foreign key(Dnumber) references department(Dnumber)
	on delete cascade
    on update cascade;

create table project(
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnumber int not null,
    primary key (Pnumber),
    constraint unique_project unique (Pname),
    constraint fk_project_dnum foreign key (Dnumber) references department(Dnumber)
);

create table works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal (3,1) not null,
    primary key (Essn, Pno),
    constraint fk_employee_works_on foreign key (Essn) references employee(Ssn),
    constraint fk_project_works_on foreign key (Pno) references project(Pnumber)
);

drop table dependent;
create table dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char,
    Bdate date,
    Relationship varchar(8),
    primary key (Essn, Dependent_name),
    constraint fk_dependent foreign key (Essn) references employee(Ssn)
);

select * from information_schema.table_constraints
	where constraint_schema = 'company_constraints';
    
    
-- inserção de dados
insert into employee values ('John','B','Smith',123456789,'1999-05-04','731-Houston-TX','M',30000,Null,5);
insert into employee values ('Franklin','T','Wong',333445555,'1955-12-08','638-Voss-Houston-TX','M',40000,123456789,5), 
							('Alicia', 'Y', 'Zelaya',999587777,'1968-01-19','3321-Castle-Spring TX','F',25000,333445555,4),
                            ('Jennifer','J','Sallace',987654321,'1941-06-20','291-Berry-Bellaire-IX','F',43000,null,4),
                            ('Ramesh','Z','Narayan',666584444,'1962-09-15','975-Fire Oak-Humble-TX','M',38000,987654321,12),
                            ('Joyce','A','English',453453453,'1972-07-31','5631-Rice-Houston-TX','F',25000,987654321,5);
                            
insert into dependent values (333445555,'Alice','F','2000-04-05','Daughter'),
							(333445555,'Theodor','M','2005-07-15','Son'),
                            (666584444,'Michael','M','2008-07-14','Son'),
                            (666584444,'Elizabeth','F','1967-08-04','Spouse');

insert into department values ('Research', 5, 333445555, '1988-05-22', '1986-05-22'),
							('Administration', 4, 987654321, '1995-01-01', '1994-01-01');
                            
insert into dept_locations values (4, 'Stanford'),
								(5, 'Bellaire'),
                                (5, 'Sugarland'),
                                (5, 'Houston');
                                
insert into project values ('Productx', 1, 'Bellaire', 5),
							('Producty', 2, 'Sugarland', 5),
                            ('Productz', 3, 'Houston', 5),
                            ('Computerization', 10, 'Stanford', 4);

insert into works_on values (123456789, 1, 32.5),
							(123456789, 2, 7.5),
                            (453453453, 1, 20.0), 
                            (453453453, 2, 28.0),
                            (333445555, 2, 10.0),
                            (333445555, 3, 19.8),
                            (333445555, 10, 20.0);

-- gerente e dpto
select Ssn, Fname, Dname from employee e, department d where (e.Ssn = d.Mgr_ssn); 

-- dependentes do empregado
select Fname, Dependent_name, Relationship from employee, dependent where Essn = Ssn;

-- dpto específico
select * from department where Dname = 'Research';

select Dname, Lname, Adress from employee, department
	where Dname='Research' and Dnumber=Dno;
    
show tables;

desc department;
desc dept_locations;

-- retirar ambiguidade -> alias ou AS Statement
select Dname, l.Dlocation as Department_name
	from department as d, dept_locations as l
    where d.Dnumber = l.Dnumber;
    
select concat(Fname, ' ', Lname) from employee;

-- expressões e alias
select Fname, Lname, Salary, Salary*0.011 from employee;
select Fname, Lname, Salary, round(Salary*0.011,2) as INSS from employee; -- ajuda a ganhar performance, realizando a operação sem persistir no BD

-- aumento para gerentes do projeto associoado ao produto xa
desc works_on;
select *
	from employee e, works_on as w, project as p
    where (e.Ssn = w.Essn and w.Pno=p.Pnumber and p.Pname='ProductX');
    
select concat(Fname, ' ', Lname) as Complete_name, Salary, round(1.1*Salary,2) as increased_salary
	from employee e, works_on w, project p
    where (e.Ssn = w.Essn and w.Pno=p.Pnumber and p.Pname='ProductX');
    
-- infos de dptos presentes em Stanford
select Dname as Department_Name, Mgr_ssn as Manager, Adress from department d, dept_locations l, employee e
	where d.Dnumber = l.Dnumber and Dlocation='Stanford';

-- gerentes de Stanford
select Dname as Department_Name, concat(Fname, ' ', Lname) as Manager from department d, dept_locations l, employee e
	where d.Dnumber = l.Dnumber and Dlocation='Stanford' and Mgr_ssn = e.Ssn;
    
select concat(Fname, ' ', Lname) Complete_Name, Dname as Department_Name from employee, department
	where (Dno=Dnumber and Adress like '%Houston%');

select concat(Fname, ' ', Lname) Complete_Name, Adress from employee
	where (Adress like '%Houston%');

select Fname, Lname, Salary from employee where (Salary between 35000 and 40000);


-- subqueries
select distinct Pnumber from project
	where Pnumber in 
		(
        select distinct Pno
			from works_on, employee
            where (Essn=Ssn and Lname='Smith')
        or (
			select Pnumber
			from project, department, employee
            where (Mgr_ssn = Ssn and Lname = 'Smith' and Dnum = Dnumber)
		)
		);

select distinct Essn from works_on 
	where (Pno,Hours) IN (select Pno, Hours 
							from works_on
                            where Essn=123456789);
                            
-- sem dependentes
select e.Fname, e.Lname from employee as e
	where not exists (select * from dependent as d
						where e.Ssn = d.Essn);


-- ordenação
select * from employee order by Fname, LName;

select distinct d.Dname, concat(e.Fname, ' ', e.Lname) as Manager, Adress
	from department as d, employee as e, works_on as w, project as p
	where (d.Dnumber = e.Dno and e.Ssn = d.Mgr_ssn and w.Pno = p.Pnumber)
    order by d.Dname;

-- agrupamento
select * from employee;
select count(*) from employee;

select count(*) from employee, department
	where Dno=Dnumber and Dname = 'Research';

select Dno, count(*), round(avg(Salary),2) from employee
	group by Dno;

select Dno, count(*) as Number_of_employees, round(avg(Salary),2) as Salary_avg from employee
	group by Dno;
    
select Pnumber, Pname, count(*)
	from project, works_on
    where Pnumber = Pno
    group by Pnumber, Pname
    having count(*) > 2;
    
select Dno as Department, count(*) as NumberOfEmployees from employee
	where Salary > 20000
    and Dno in (select Dno from employee
				group by Dno
                having count(*)>= 2)
	group by Dno;

select * from employee;

update employee set Salary =
	case 
		when Dno=5 then Salary + 2000
        when Dno=4 then Salary + 1500
        else Salary + 0
	end;
    
-- join
select * from employee JOIN works_on on Ssn = Essn;
select * from employee JOIN department on Ssn = Mgr_ssn;

select Fname, Lname, Adress
	from (employee join department on Dno=Dnumber)
    where Dname = 'Research';

select Dname, Dept_create_date, Dlocation
	from department JOIN dept_locations using(Dnumber)
    order by Dept_create_date;
    
select concat(Fname, ' ', Lname) as Complete_name, Dno as DeptNumber, Pname as ProjectName, 
		Pno as ProjectNumber, Plocation as Location from employee
	inner join works_on on Ssn = Essn
    inner join project on Pno = Pnumber
    where Plocation like 'S%'
    order by Pnumber;

select Dnumber, Dname, concat(Fname, ' ', Lname) as Manager, Salary, round(Salary*0.05,2) as Bonus from department
	inner join dept_locations using (Dnumber)
    inner join (dependent inner join employee on Ssn = Essn) on Ssn = Mgr_ssn
    group by Dnumber
    having count(*)>1;
    
-- inner e left join
select * from employee inner join dependent on Ssn = Essn;
select * from employee left join dependent on Ssn = Essn;
select * from employee left outer join dependent on Ssn = Essn;
