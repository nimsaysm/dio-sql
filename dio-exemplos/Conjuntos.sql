create database conjuntos;
use conjuntos;

create table R(
	A char(2)
);

create table S(
	A char(2)
);

insert into R(A) values ('a1'),('a2'),('a2'),('a3');
insert into S(A) values ('a1'),('a1'),('a2'),('a3'),('a4'),('a5');


select * from R;
select * from S;

-- except -> not in
select * from S where A not in (select A from R);

-- intersect
select distinct R.A from R where R.A in (select S.A from S);

-- union
(select R.A from R)
	UNION
    (select S.A from S);

