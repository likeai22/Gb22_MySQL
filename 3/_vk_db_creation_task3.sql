DROP TABLE IF EXISTS services;
CREATE TABLE services (
	id SERIAL,
    name VARCHAR(255) UNIQUE,
    cost INT,
    created_at DATETIME DEFAULT NOW()
);

DROP TABLE IF EXISTS user_services;
CREATE TABLE user_services (
    id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
	service_id  BIGINT UNSIGNED,
	requested_at DATETIME DEFAULT NOW(),
	received_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	cost_of_service INT,
    FOREIGN KEY (service_id) REFERENCES services(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS payment_methods;
CREATE TABLE payment_methods(
	id SERIAL,
	name ENUM('MasterCard', 'Visa', 'ЮMoney')
);

DROP TABLE IF EXISTS payment_statuses;
CREATE TABLE payment_statuses(
	id SERIAL,
	name ENUM('Completed', 'Canceled', 'Disputed'),
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS user_payment_methods;
CREATE TABLE user_payment_methods(
	id SERIAL,
	user_id BIGINT UNSIGNED,
	payment_method_id  BIGINT UNSIGNED,
	card_number BIGINT UNSIGNED UNIQUE,
	card_expire_data CHAR(5),
	FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS payments;
CREATE TABLE payments(
	id SERIAL,
	payment_service_id  BIGINT UNSIGNED,
	payment_method_id  BIGINT UNSIGNED,
	payment_status_id  BIGINT UNSIGNED,
	FOREIGN KEY (payment_service_id) references user_services(id),
	FOREIGN KEY (payment_method_id) references user_payment_methods(id),
	FOREIGN KEY (payment_status_id) references payment_statuses(id)
);




