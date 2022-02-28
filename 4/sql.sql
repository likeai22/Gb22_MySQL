# i.
# сделано в предыдущем дз

# ii.
USE vk;
SELECT DISTINCT
	firstname
FROM
	users
ORDER BY
	firstname;

# iii.
# добавим в таблицу нужное поле
ALTER TABLE PROFILES ADD COLUMN is_active TINYINT ( 1 ) DEFAULT TRUE;
# изменим таблицу
UPDATE PROFILES
	SET is_active = 0
WHERE
	YEAR ( curdate( ) ) - YEAR ( birthday ) < 18;
# выборка с условием
SELECT
	users.firstname,
	`profiles`.birthday
FROM
	`profiles`,
	users
WHERE
	users.id = `profiles`.user_id
	AND YEAR ( curdate( ) ) - YEAR ( birthday ) < 18;

# iv.
SELECT
	COUNT( * )
FROM
	messages;
# 100 длина таблицы
DELETE
FROM
	messages
WHERE
	created_at >= CURDATE( );
# 100 осталось столько же строк, сообщений с датой больше сегодняшней не было
