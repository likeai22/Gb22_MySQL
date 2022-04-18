# Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

USE shop;

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(64),
  `to` VARCHAR(64)
);

INSERT INTO flights (`from`, `to`) VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(64),
  name VARCHAR(64)
);

INSERT INTO cities (label, name) VALUES
  ('moscow', 'Москва'),
  ('novgorod', 'Новгород'),
  ('irkutsk', 'Иркутск'),
  ('omsk', 'Омск'),
  ('kazan', 'Казань');

SELECT
	id,
	( SELECT c1.`name` FROM cities c1 WHERE c1.label = f.`from` ) `from`,
	( SELECT c2.`name` FROM cities c2 WHERE c2.label = f.`to` ) `to`
FROM
	flights f;

SELECT
	f.id,
	c.`name` `from`,
	c_to.`name` `to`
FROM
	flights f
	JOIN cities c ON f.`from` = c.label
	JOIN cities c_to ON f.`to` = c_to.label
ORDER BY
	f.id