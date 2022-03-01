# Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения
# https://oracleplsql.ru/mysql-function-extract.html

SELECT
	GROUP_CONCAT( `name` SEPARATOR ', ' ) AS people,
	DAYNAME(
	STR_TO_DATE( CONCAT( EXTRACT( YEAR FROM CURDATE()), '-', EXTRACT( MONTH FROM birthday_at ), '-', EXTRACT( DAY FROM birthday_at )), '%Y-%m-%d' )) AS birthday,
	COUNT(*) quantity
FROM
	users
GROUP BY
	birthday;