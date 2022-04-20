# Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.

USE shop;

DROP USER IF EXISTS 'shop_reader'@'localhost';
CREATE USER 'shop_reader'@'localhost' IDENTIFIED WITH sha256_password BY 'password';
GRANT SELECT ON shop.* TO 'shop_reader'@'localhost';

INSERT INTO catalogs(name)
VALUES('test');

-- 10:55:20	INSERT INTO catalogs(name) VALUES('test')	Error Code: 1142.
-- INSERT command denied to user 'shop_reader'@'localhost' for table 'catalogs'	0.000 sec

DROP USER IF EXISTS 'shop'@'localhost';
CREATE USER 'shop'@'localhost' IDENTIFIED WITH sha256_password BY 'password';
GRANT ALL ON shop.* TO 'shop'@'localhost';
GRANT GRANT OPTION ON shop.* TO 'shop'@'localhost';

INSERT INTO catalogs(name)
VALUES('test1');

-- 11:00:59	INSERT INTO catalogs(name) VALUES('test1')	1 row(s) affected	0.000 sec

# (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.

USE shop;

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  password VARCHAR(255)
);

INSERT INTO accounts (name, password) VALUES
  ('John Doe', '2647100');


CREATE OR REPLACE VIEW username(id, name) AS
	SELECT id, `name` FROM accounts;


DROP USER IF EXISTS 'shop_reader'@'localhost';
CREATE USER 'shop_reader'@'localhost' IDENTIFIED WITH sha256_password BY 'password';
GRANT SELECT ON shop.username TO 'shop_reader'@'localhost';