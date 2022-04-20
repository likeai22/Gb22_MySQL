# Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION  hello()
RETURNS TEXT READS SQL DATA
BEGIN
	IF(CURTIME() BETWEEN '06:00:00' AND '12:00:00') THEN
		RETURN 'Доброе утро';
	ELSEIF(CURTIME() BETWEEN '12:00:00' AND '18:00:00') THEN
		RETURN 'Добрый день';
	ELSEIF(CURTIME() BETWEEN '18:00:00' AND '00:00:00') THEN
		RETURN 'Добрый вечер';
	ELSE
		RETURN 'Доброй ночи';
	END IF;
END //
DELIMITER ;

SELECT hello();

# В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

DROP TRIGGER IF EXISTS task3_2;
DELIMITER //
CREATE TRIGGER task3_2 BEFORE INSERT ON products
FOR EACH ROW
    BEGIN
        IF (ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Warning. INSERT has one or more NULL values';
        END IF;
    END//
DELIMITER ;

USE shop;
INSERT INTO products (name, description, price, catalog_id)
VALUES ("product1", NULL, 1000, 1);

INSERT INTO products (name, description, price, catalog_id)
VALUES ("product2", "product2", 1000, 2);

INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, NULL, 1000, 3);

# (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.

DROP FUNCTION IF EXISTS fibonacci_binets;
DELIMITER //

CREATE FUNCTION fibonacci_binets(num INT)
RETURNS INT DETERMINISTIC
BEGIN
  DECLARE sqrt5, fi DOUBLE;
  SET sqrt5 = SQRT(5);
	SET fi = (1 + sqrt5);

  RETURN ( POW(fi, num) - POW(2 - fi, num) ) / ( POW(2, num) * sqrt5 );
END//

SELECT fibonacci_binets(10)//


DROP FUNCTION IF EXISTS fibonacci_lucas;
DELIMITER //

CREATE FUNCTION fibonacci_lucas(num INT)
RETURNS INT DETERMINISTIC
BEGIN
  DECLARE sqrt5, fi DOUBLE;
  SET sqrt5 = SQRT(5);
	SET fi = (1 + sqrt5) / 2;

  RETURN ( POW(fi, num) - POW(-fi, -num) ) / sqrt5;
END//

SELECT fibonacci_lucas(10)//

