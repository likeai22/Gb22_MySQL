# Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

USE vk;

SET @age = 10;
SELECT
	COUNT( likes.media_id ) count
FROM
	likes
WHERE
	media_id IN (
	SELECT
		id
	FROM
		media m
		JOIN `profiles` p ON p.user_id = m.user_id
	WHERE
	TIMESTAMPDIFF( YEAR, birthday, NOW( ) ) < @age );