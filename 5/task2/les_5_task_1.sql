# Подсчитайте средний возраст пользователей в таблице users.
SELECT name, birthday_at, CURDATE() as today,
TIMESTAMPDIFF(YEAR,birthday_at,CURDATE()) AS age
FROM users ORDER BY name;

SELECT
	ROUND( AVG( TIMESTAMPDIFF( YEAR, birthday_at, CURDATE()) ) ) average_age
FROM
	users;
