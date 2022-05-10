DROP TABLE IF EXISTS test;
CREATE TABLE test (id serial, name text);
INSERT INTO test (name) SELECT 'test' FROM generate_series(1, 1000);

