drop table test;
create table test (id int, timestamp timestamp);
insert into test values (1, now());
select * from test;

