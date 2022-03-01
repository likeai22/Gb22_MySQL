# Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
# https://ciox.ru/date-time-generator
# https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_curtime

USE shop;
DROP TABLE
IF
	EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	NAME VARCHAR ( 255 ) COMMENT 'Имя покупателя',
	birthday_at DATE COMMENT 'Дата рождения',
	created_at VARCHAR ( 255 ),
	updated_at VARCHAR ( 255 )
) COMMENT = 'Покупатели';
INSERT INTO users ( NAME, birthday_at, created_at, updated_at )
VALUES
	( 'Геннадий', '1990-10-05', '20.10.2017 8:10', '23.11.2017 01:13' ),
	( 'Наталья', '1984-11-12', '24.03.2017 12:40', '11.12.2017 08:44' ),
	( 'Александр', '1985-05-20', '17.12.2017 17:41', '02.05.2018 06:44' ),
	( 'Сергей', '1988-02-14', '28.09.2018 12:02', '24.11.2018 06:45' ),
	( 'Иван', '1998-01-12', '18.03.2019 14:59', '14.05.2019 17:29' ),
	( 'Мария', '1992-08-29', '12.09.2019 23:58', '20.11.2019 14:01' );
UPDATE users
SET created_at = STR_TO_DATE( created_at, '%d.%m.%Y %H:%i' ),
updated_at = STR_TO_DATE( updated_at, '%d.%m.%Y %H:%i' );
ALTER TABLE users CHANGE created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users CHANGE updated_at updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP;
