USE shop;

# Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  created_at DATETIME DEFAULT NOW(),
  table_name VARCHAR(255),
  pk BIGINT(20) UNSIGNED NOT NULL,
  value_name VARCHAR(255)
  ) ENGINE ARCHIVE;

DROP PROCEDURE IF EXISTS insert_to_logs;
delimiter $$
CREATE PROCEDURE insert_to_logs (t_name VARCHAR(255), id BIGINT(20), v_name VARCHAR(255))
BEGIN
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET @error = 'Ошибка вставки значения';
	INSERT INTO logs (table_name, pk, value_name) VALUES (t_name, id, v_name);
END $$
delimiter ;

DROP TRIGGER IF EXISTS trigger_insert_to_users;
delimiter $$
CREATE TRIGGER trigger_insert_to_users
AFTER INSERT ON users
FOR EACH ROW
BEGIN
	CALL insert_to_logs('users', NEW.id, NEW.name);
END $$
delimiter ;

DROP TRIGGER IF EXISTS trigger_insert_to_catalogs;
delimiter $$
CREATE TRIGGER trigger_insert_to_catalogs
AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	CALL insert_to_logs('catalogs', NEW.id, NEW.name);
END $$
delimiter ;

DROP TRIGGER IF EXISTS trigger_insert_to_products;
delimiter $$
CREATE TRIGGER trigger_insert_to_products
AFTER INSERT ON products
FOR EACH ROW
BEGIN
	CALL insert_to_logs('products', NEW.id, NEW.name);
END $$
delimiter ;

# (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

SET SESSION cte_max_recursion_depth = 1000000;
DROP TABLE IF EXISTS person_data;
CREATE TABLE person_data AS
WITH RECURSIVE tmp(id, username, date) as (
    SELECT 1, 'Иван', '1970-01-01'
    UNION ALL
    SELECT
        tmp.id + 1 as id,
				(select `name` from users where id = 5) as username,
        date + INTERVAL 1 DAY as date
    from tmp
    limit 1000000
)
select id, username, date from tmp;

