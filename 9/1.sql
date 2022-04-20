# В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;
SET @id = 1;
INSERT INTO sample.users
  SELECT * FROM shop.users
  WHERE shop.users.id = @id
;
DELETE FROM shop.users WHERE shop.users.id = @id;
COMMIT;

# Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

CREATE
	OR REPLACE VIEW shop.task1_2 AS SELECT
	p.`name` product,
	c.`name` catalog
FROM
	shop.products p
	JOIN shop.catalogs c
WHERE
	p.catalog_id = c.id;

# по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

USE shop;
DROP TABLE IF EXISTS my_table;
CREATE TABLE my_table (
	created_at DATE
);

INSERT INTO my_table VALUES
	('2018-08-01'),
	('2018-08-04'),
	('2018-08-16'),
	('2018-08-17');

SELECT * FROM my_table mt ORDER BY created_at;

WITH RECURSIVE dates(date) AS (
   SELECT '2018-08-01'
   UNION ALL
   SELECT date + INTERVAL 1 DAY
   FROM dates
   WHERE date < '2018-08-31' )
SELECT dates.date, IF(dates.date = my_table.created_at, 1, 0) day
FROM dates LEFT JOIN my_table ON dates.date = my_table.created_at
GROUP BY dates.date;

# (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

DROP TABLE IF EXISTS my_table;
CREATE TABLE my_table (
	created_at DATE
);
INSERT INTO my_table VALUES
('2022-04-01'),
('2022-04-02'),
('2022-04-03'),
('2022-04-04'),
('2022-04-05'),
('2022-04-06'),
('2022-04-07'),
('2022-04-08'),
('2022-04-09'),
('2022-04-10'),
('2022-04-11');

DELETE FROM my_table
WHERE created_at <= (SELECT MAX(created_at) - 5 FROM (SELECT * FROM my_table) del);
SELECT * FROM my_table ORDER BY created_at DESC;
