-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

SET @to_user_id = 1;
SELECT
	CONCAT( u.firstname, ' ', u.lastname ) AS username,
	m.from_user_id,
	m.to_user_id,
	count( * ) AS total_message
FROM
	users u
	INNER JOIN messages m ON u.id = m.from_user_id
	AND m.to_user_id = @to_user_id
GROUP BY
	m.from_user_id
ORDER BY
	total_message DESC
	LIMIT 1
