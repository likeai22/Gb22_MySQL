# Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

SELECT
	*
FROM
	users
WHERE
	DATE_FORMAT( birthday_at, '%M' ) IN ( 'may', 'august' );

SELECT
	*
FROM
	users
WHERE
	lower(
	monthname( birthday_at )) IN ( 'may', 'august' );