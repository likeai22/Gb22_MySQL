# Определить кто больше поставил лайков (всего): мужчины или женщины.

USE vk;

SELECT
	gender,
	COUNT( * ) cnt
FROM
	`profiles` p
	JOIN likes l ON p.user_id = l.user_id
GROUP BY
	gender
ORDER BY
	cnt DESC
	LIMIT 1;