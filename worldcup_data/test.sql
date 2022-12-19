drop table customers;
create table customers (id serial primary key, name varchar(100));
insert into customers values (nextval('customers_id_seq'), 'Test 1');
insert into customers values (nextval('customers_id_seq'), 'Test 2');
insert into customers values (nextval('customers_id_seq'), 'Test 3');

