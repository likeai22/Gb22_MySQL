-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

SET @age = 10;
SELECT
	COUNT( * ) AS count
FROM
	likes
WHERE
	media_id = (
	SELECT
		id
	FROM
		media
	WHERE
		media.id = likes.media_id
	AND ( SELECT TIMESTAMPDIFF( YEAR, birthday, NOW( ) ) FROM PROFILES WHERE PROFILES.user_id = media.user_id ) < @age
	);