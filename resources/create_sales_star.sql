DROP TABLE IF EXISTS sale_fact;
DROP TABLE IF EXISTS time_dimension;
DROP TABLE IF EXISTS store_dimension;

create table time_dimension (
	time_key		integer primary key,
	thedate			date not null,
	day_of_week		varchar(9) not null, -- 'Maandag', 'Dinsdag'...
	day_number_in_month	integer not null, -- 1 to 31
	day_number_overall	integer not null, -- days from the epoch (first day is 1)
	week_number_in_year	integer not null, -- 1 to 52
	week_number_overall	integer not null, -- weeks start on Sunday 
	month			integer not null, -- 1 to 12
	month_number_overall	integer not null,
	quarter			integer not null, -- 1 to 4
	fiscal_period		varchar(10),
	holiday_flag		char(1) default 'f' check (holiday_flag in ('t', 'f')),
	weekday_flag		char(1) default 'f' check (weekday_flag in ('t', 'f')),
	season			varchar(50),
	event			varchar(50)
);

insert into time_dimension values (1, STR_TO_DATE('2019-11-12 09:35:14', '%Y-%m-%d %h:%i:%s'), 'Dinsdag', 12, 316, 45, 45, 11, 11, 4, 'NOV. 2019', 'f', 't', 'herfst', '');
insert into time_dimension values (2, STR_TO_DATE('2019-11-12 09:35:17', '%Y-%m-%d %h:%i:%s'), 'Dinsdag', 12, 316, 45, 45, 11, 11, 4, 'NOV. 2019', 'f', 't', 'herfst', '');
insert into time_dimension values (3, STR_TO_DATE('2019-05-12 09:35:18', '%Y-%m-%d %h:%i:%s'), 'Donderdag', 05, 339, 48, 48, 12, 12, 4, 'DEC. 2019', 't', 't', 'herfst', '');
insert into time_dimension values (4, STR_TO_DATE('2019-05-12 09:40:19', '%Y-%m-%d %h:%i:%s'), 'Donderdag', 05, 339, 48, 48, 12, 12, 4, 'DEC. 2019', 't', 't', 'herfst', '');
insert into time_dimension values (5, STR_TO_DATE('2019-04-12 09:40:19', '%Y-%m-%d %h:%i:%s'), 'Woensdag', 04, 338, 48, 48, 12, 12, 4, 'DEC. 2019', 'f', 't', 'herfst', '');

create table store_dimension (
	store_key		integer primary key,
	name			varchar(100),
	city			varchar(100),
	state			varchar(100),
	zip_code		varchar(100),
	date_opened		date,
	date_remodeled		date,
	-- 'small', 'medium', 'large', or 'super'
	store_size		varchar(100)
);
INSERT INTO store_dimension VALUES (16, 'Albert Heijn Sarphatistraat', 'Amsterdam', 'Noord-Holland', '1018 AV', '2019-01-01', '2019-04-04', 'large');
INSERT INTO store_dimension VALUES (17, 'Albert Heijn Bilthoven', 'Bilthoven', 'Utrecht', '3722 AR', '2019-01-01', '2019-04-04', 'small');

create table sale_fact (
	time_key	integer not null ,
	product_id	integer,
	store_key	integer not null,
	unit_sales	integer,
	dollar_sales	DECIMAL(10,2),
	foreign key (time_key) references time_dimension (time_key),
	foreign key (store_key) references store_dimension (store_key)
);
insert into sale_fact values (1, 219, 17, 1, 0.40);
insert into sale_fact values (1, 219, 16, 4, 11);
insert into sale_fact values (2, 219, 17, 1, 0.40);
insert into sale_fact values (3, 567, 17, 1, 2.75);
insert into sale_fact values (4, 567, 17, 1, 2.75);
insert into sale_fact values (5, 219, 16, 2000, 5500);
