# Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений). Задачи необходимо решить с использованием объединения таблиц (JOIN)


USE vk;

# вариант с JOIN есть 6 домашнем задании, еще один вариант:
SET @to_user_id = 1;

SELECT
	CONCAT( ( SELECT firstname FROM users WHERE id = from_user_id ), ' ', ( SELECT lastname FROM users WHERE id = from_user_id ) ) username,
	from_user_id,
	to_user_id,
	COUNT( * ) total_message
FROM
	messages
WHERE
	to_user_id = @to_user_id
GROUP BY
	from_user_id
ORDER BY
	total_message DESC
	LIMIT 1;

SELECT
	CONCAT( u.firstname, ' ', u.lastname ) username,
	m.from_user_id,
	m.to_user_id,
	count( * ) total_message
FROM
	users u
	INNER JOIN messages m ON u.id = m.from_user_id
	AND m.to_user_id = @to_user_id
GROUP BY
	m.from_user_id
ORDER BY
	total_message DESC
	LIMIT 1


