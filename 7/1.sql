# Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
use shop;

# наполним таблицу orders
INSERT INTO orders (user_id) VALUES (1), (2), (5);

SELECT
	u.id,
	u.name
FROM
     users u
WHERE u.id IN (SELECT DISTINCT o.user_id FROM orders o);

SELECT DISTINCT
	u.id,
	u.name
FROM
     users u
JOIN
	orders o
ON
	u.id = o.user_id;
