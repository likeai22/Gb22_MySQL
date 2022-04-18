# Выведите список товаров products и разделов catalogs, который соответствует товару.

USE shop;

SELECT
	p.id,
	p.`name`,
	p.price,
	c.`name` catalog
FROM
	products p
	LEFT JOIN catalogs c ON c.id = p.catalog_id;

SELECT
	id,
	`name`,
	price,
	( SELECT `name` FROM catalogs WHERE id = p.catalog_id ) catalog
FROM
	products p;