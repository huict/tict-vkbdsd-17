DROP TABLE IF EXISTS sale;
DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS product_category;
DROP TABLE IF EXISTS manufacturer;
DROP TABLE IF EXISTS city;
drop table if exists product_price;

create table product_category (
	product_category_id	integer primary key,
	product_category_name	varchar(100) not null
);
create table manufacturer (
	manufacturer_id		integer primary key,
	manufacturer_name	varchar(100) not null
);
create table product (
	product_id		integer primary key,
	product_name		varchar(100) not null,
	product_category_id	integer,
	manufacturer_id 	integer,
	foreign key (product_category_id) references product_category (product_category_id),
	foreign key (manufacturer_id) references manufacturer (manufacturer_id)
);
create table city (
	city_id			integer primary key,
	city_name		varchar(100) not null,
	state			varchar(100) not null,
	population		integer not null
);
create table store (
	store_id		integer primary key,
	city_id			integer,
	store_location		varchar(200) not null,
	phone_number		varchar(20),
	foreign key (city_id) references city(city_id)
	
);
create table sale (
	product_id	integer not null,
	store_id	integer not null ,
	quantity_sold	integer not null,
	date_time_of_sale	datetime not null,
	foreign key (product_id) references product (product_id),
	foreign key (store_id) references store (store_id)
);

insert into product_category values (1, 'tandpasta');
insert into product_category values (2, 'frisdrank');
insert into manufacturer values (68, 'Prodent');
insert into manufacturer values (5, 'Coca Cola');
insert into product values (567, 'Woezel en Pip tandpasta', 1, 68);
insert into product values (219, 'Coca Cola mini', 2, 5);
insert into city values (34, 'Amsterdam', 'Noord-Holland', 850000);
insert into city values (58, 'Bilthoven', 'Utrecht', 22000);
insert into store values (16, 34, 'Sarphatistraat', '020 422 1233');
insert into store values (17, 58, 'De Kwinkelier', '030 229 2665');

insert into sale values (567, 17, 1, STR_TO_DATE('2019-11-12 09:35:14', '%Y-%m-%d %h:%i:%s'));
insert into sale values (219, 16, 4, STR_TO_DATE('2019-11-12 09:35:14', '%Y-%m-%d %h:%i:%s'));
insert into sale values (219, 17, 1, STR_TO_DATE('2019-11-12 09:35:17', '%Y-%m-%d %h:%i:%s'));
insert into sale values (567, 17, 1, STR_TO_DATE('2019-12-05 09:35:18', '%Y-%m-%d %h:%i:%s'));
insert into sale values (567, 17, 1, STR_TO_DATE('2019-12-05 09:40:19', '%Y-%m-%d %h:%i:%s'));

insert into sale values (219, 16, 2000, STR_TO_DATE('2019-12-04 09:40:19', '%Y-%m-%d %h:%i:%s'));


DROP TABLE IF EXISTS holiday_map;
create table holiday_map (
holiday_date		date primary key
);
INSERT INTO holiday_map VALUES (STR_TO_DATE('2019-12-05', '%Y-%m-%d'));
INSERT INTO holiday_map VALUES (STR_TO_DATE('2019-12-25', '%Y-%m-%d'));
INSERT INTO holiday_map VALUES (STR_TO_DATE('2019-12-31', '%Y-%m-%d'));
INSERT INTO holiday_map VALUES (STR_TO_DATE('2019-01-01', '%Y-%m-%d'));

create table product_price (
product_id	integer not null ,
from_date	date not null,
price		DECIMAL(10,2) not null,
foreign key (product_id) references product (product_id)
);

insert into product_price values (567,'2019-10-01',2.75);
insert into product_price values (219,'2019-10-01',0.40);

