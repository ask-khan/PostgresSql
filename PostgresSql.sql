--  POSTGRES SQL COMMAND:

-- \l - show the list of database
--  \q - quit
-- \c database name - switch to database
-- \d show table 
-- \d table name - table description
-- \! clear -- clear screen

---- 
-- // BIGSERIAL
CREATE TABLE person (
    id int NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(7) NOT NULL,
    data_of_birth DATE NOT NULL
);

INSERT INTO person(  first_name, last_name, gender, data_of_birth ) VALUES('Anne', 'Simth', 'Female', current_timestamp ); 
INSERT INTO person(  first_name, last_name, gender, email, date_of_birth ) VALUES( 'Jake', 'Jones', 'Male', 'jake@gmail.com' , current_timestamp );


-- Generate:
-- https://www.mockaroo.com/

-- Query:
SELECT * FROM person ORDER BY country_of_birth ASC;
SELECT DISTINCT country_of_birth FROM PERSON ORDER BY country_of_birth ASC;
SELECT * FROM person WHERE gender = 'Male' AND (country_of_birth = 'Poland' OR  country_of_birth = 'China' );
SELECT * FROM person LIMIT 10;
SELECT * FROM person OFFSET 5;
SELECT * FROM person OFFSET 5 FETCH FIRST 5 ROW ONLY;
SELECT * FROM person WHERE country_of_birth IN ('China', 'Brazil');
SELECT * FROM person WHERE country_of_birth IN ('China', 'Brazil');
SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth;
SELECT * FROM person
WHERE EMAIL LIKE '%.com';
SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth ORDER BY country_of_birth;
SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth HAVING COUNT(*) > 40 ORDER BY country_of_birth;
SELECT make, model, MAX(price) 
FROM car GROUP BY make, model;
SELECT MIN(price) 
FROM car;
SELECT AVG(price) 
FROM car;

-- https://www.postgresql.org/docs/9.5/functions-aggregate.html

SELECT SUM(price) 
FROM car;

SELECT make, SUM(price) FROM car GROUP BY make;
SELECT * FROM car;
SELECT 10-2;
SELECT 10+2;
SELECT 10/2;
SELECT 5!;
SELECT 10%3;
SELECT id, make, model, price, ROUND(price * .10, 2) AS DiscountPrice,  price - ROUND(price * .10, 2) AS AfterDiscount  FROM car;
SELECT COALESCE(1) FROM car;
SELECT  (email, 'Not Provided') FROM person;
SELECT 10/NULLIF(10, 10);
SELECT NOW();
SELECT NOW()::time;
SELECT NOW() - INTERVAL '1 YEAR';
SELECT NOW() - INTERVAL '1 DAY';
SELECT (NOW() - INTERVAL '1 DAY')::Date;
SELECT EXTRACT( YEAR FROM NOW());

SELECT EXTRACT( MONTH FROM NOW());
ALTER TABLE person ADD PRIMARY KEY(ID)
DELETE FROM person WHERE id=1;
SELECT EXTRACT( YEAR FROM NOW());

SELECT EXTRACT( MONTH FROM NOW());

SELECT * FROM person LIMIT 1;

SELECT first_name, last_name, email, gender, country_of_birth, date_of_birth, AGE(NOW(), date_of_birth) AS Age
FROM person;

SELECT email, count(*) FROM person GROUP BY email HAVING COUNT(*) > 1;

ALTER TABLE person ADD CONSTRAINT unique_email_address UNIQUE ( email);

DELETE FROM person where id = '1';
DELETE FROM person WHERE id = 1;
move to back 


UPDATE person SET email='ahmed@gmail.com' 	
WHERE id = 2;

UPDATE person SET first_name='ahmed saboor khan' 	
WHERE id = 2;

Select * from person;

-- On Conflict;
SELECT * FROM person where id = 1000;

-- INSERT QUERIES
ON CONFLICT (id) DO NOTHING;

-- ON UPSERT - UNIQUE.
ON CONFLICT (id) DO UPDATE SET email = EXCLUDED.email;

-- JOIN
DROP table person;
drop table car;


create table person (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	gender VARCHAR(7) NOT NULL,
	email VARCHAR(100),
	date_of_birth DATE NOT NULL,
	country_of_birth VARCHAR(50) NOT NULL,
	car_id BIGINT REFERENCES car (id),
	UNIQUE(car_id)
);

create table car (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	make VARCHAR(100) NOT NULL,
	model VARCHAR(100) NOT NULL,
	price NUMERIC(19, 2) NOT NULL
);

insert into person (first_name, last_name, gender, email, date_of_birth, country_of_birth) values ('Fernanda', 'Beardon', 'Female', 'fernandab@is.gd', '1953-10-28', 'Comoros');
insert into person (first_name, last_name, gender, email, date_of_birth, country_of_birth) values ('Omar', 'Colmore', 'Male', null, '1921-04-03', 'Finland');
insert into person (first_name, last_name, gender, email, date_of_birth, country_of_birth) values ('John', 'Matuschek', 'Male', 'john@feedburner.com', '1965-02-28', 'England');

insert into car (make, model, price) values ('Land Rover', 'Sterling', '87665.38');
insert into car (make, model, price) values ('GMC', 'Acadia', '17662.69');

SELECT * FROM person;
SELECT * FROM car;

UPDATE person set car_id = 3 Where id = 1;

-- INNER JOIN;
SELECT * FROM person 
JOIN car ON person.car_id = car.id;

SELECT person.first_name, car.make, car.model, car.price FROM person 
JOIN car ON person.car_id = car.id;

SELECT * FROM person 
LEFT JOIN car ON person.car_id = car.id;

ALTER SEQUENCE person_id_seq RESTART WITH 10; 

SELECT * 
FROM pg_available_extensions;


create table car (
	car_uid UUID NOT NULL PRIMARY KEY,
	make VARCHAR(100) NOT NULL,
	model VARCHAR(100) NOT NULL,
	price NUMERIC(19, 2) NOT NULL CHECK (price > 0)
);


create table person (
    person_uid UUID NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	gender VARCHAR(7) NOT NULL,
	email VARCHAR(100),
	date_of_birth DATE NOT NULL,
	country_of_birth VARCHAR(50) NOT NULL,
	car_uid UUID REFERENCES car(car_uid),
	UNIQUE(car_id),
	UNIQUE(email)
);

-- INSERT INTO PERSON
insert into person ( person_uid, first_name, last_name, gender, email, date_of_birth, country_of_birth)
values ( uuid_generate_v4(), 'Fernanda', 'Beardon', 'Female', 'fernandab@is.gd', '1953-10-28', 'Comoros');

insert into person ( person_uid, first_name, last_name, gender, email, date_of_birth, country_of_birth) 
values ( uuid_generate_v4(), 'Omar', 'Colmore', 'Male', null, '1921-04-03', 'Finland');

insert into person ( person_uid, first_name, last_name, gender, email, date_of_birth, country_of_birth) 
values ( uuid_generate_v4(), 'Adriana', 'Matuschek', 'Female', 'amatuschek2@feedburner.com', '1965-02-28', 'Cameroon');

-- INSERT INTO CAR
insert into car ( car_uid, make, model, price) values ( uuid_generate_v4(), 'Land Rover', 'Sterling', '87665.38');
insert into car ( car_uid, make, model, price) values ( uuid_generate_v4(), 'GMC', 'Acadia', '17662.69');

UPDATE person SET car_uid = 'e81a55ed-3542-439a-8572-54672bbb4b26' 
WHERE person_uid= 'f8475179-8d02-4b24-80bb-49600a4ec35e';

SELECT * FROM person
JOIN car ON person.car_uid=car.car_uid;

SELECT * FROM person
JOIN car USING(car_uid);
