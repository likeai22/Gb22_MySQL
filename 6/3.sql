-- Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT
CASE
	WHEN
		profiles.gender = 'm' THEN
			'male'
			WHEN profiles.gender = 'f' THEN
			'female'
		END AS gender,
		COUNT( * ) AS cnt
	FROM
		profiles,
		likes
	WHERE
		profiles.user_id = likes.user_id
	GROUP BY
		gender
	ORDER BY gender
LIMIT 1;
