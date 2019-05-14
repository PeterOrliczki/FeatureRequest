/*
    Database initialization script that runs on every web-application redeployment.
*/
drop table IF EXISTS coupons_shops;
drop table IF EXISTS coupons;
drop table IF EXISTS shops;
drop table IF EXISTS users;

create TABLE users (
    id SERIAL PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
	CONSTRAINT email_not_empty CHECK (email <> ''),
	CONSTRAINT password_not_empty CHECK (password <> '')
);

create TABLE shops (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
	CONSTRAINT name_not_empty CHECK (name <> '')
);

create TABLE coupons (
    id SERIAL PRIMARY KEY,
    user_id INTEGER,
    name TEXT NOT NULL,
    percentage INTEGER NOT NULL,
    CONSTRAINT name_not_empty CHECK (name <> ''),
	CONSTRAINT percentage_between_bounds CHECK (percentage >= 0 AND percentage <= 100),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

create TABLE coupons_shops (
    coupon_id INTEGER,
    shop_id INTEGER,
    PRIMARY KEY (coupon_id, shop_id),
    FOREIGN KEY (coupon_id) REFERENCES coupons(id),
    FOREIGN KEY (shop_id) REFERENCES shops(id)
);

insert into users (email, password) values
	('user1@user1', 'user1'), -- 1
	('user2@user2', 'user2'), -- 2
	('user2@user3', 'user3'); -- 3

insert into shops (name) values
	('SPAR'),   -- 1
	('Tesco'),  -- 2
	('Auchan'), -- 3
	('LIDL'),   -- 4
	('ALDI');   -- 5

insert into coupons (name, percentage, user_id) values
	('Sausage discount', 10, 1),           -- 1
	('Bread super-sale', 50, 2),           -- 2
	('Bread super-sale', 40, 1),           -- 3
	('20% off from EVERYTHING!', 20, 3),   -- 4
	('1 product for FREE!', 100, 1);       -- 5

insert into coupons_shops (coupon_id, shop_id) values
    (1, 1), -- 1
    (1, 2),
    (1, 3),
    (2, 1), -- 2
    (2, 2),
    (2, 3),
    (2, 5),
    (3, 1), -- 3
    (3, 2),
    (3, 5),
    (4, 3), -- 4
    (5, 2), -- 5
    (5, 5);
