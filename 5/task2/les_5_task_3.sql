# Подсчитайте произведение чисел в столбце таблицы
# https://stackoverflow.com/questions/5416169/multiplication-aggregate-operator-in-sql

USE shop;
DROP TABLE
IF
	EXISTS mul;
CREATE TABLE mul ( item INT );
INSERT INTO mul ( item )
VALUES
	( 1 ),
	( 2 ),
	( 3 ),
	( 5 );
SELECT
	ROUND(
		EXP(
			SUM(
			LOG( item )))) multiplication
FROM
	mul;
SELECT
	ROUND(
		POW(
			2,
			SUM(
			LOG( 2, item )))) multiplication
FROM
	mul;