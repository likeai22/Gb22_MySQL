-- Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.

DROP DATABASE
IF
	EXISTS example;
CREATE DATABASE
IF
	NOT EXISTS example CHARACTER
	SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE example;
CREATE TABLE `users` ( `id` INT NOT NULL AUTO_INCREMENT, `name` VARCHAR ( 255 ) NOT NULL DEFAULT '', PRIMARY KEY ( `id` ) ) AUTO_INCREMENT = 5 ENGINE = INNODB DEFAULT CHARSET = utf8mb4;
insert into users(name)
values ('Илья Муромец. Святой богатырь'),('Бова Королевич. Лубочный богатырь'),('Алеша Попович. Младшенький'),('Добрыня Никитич. Богатырь со связями');

-- Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.

DROP DATABASE
IF
	EXISTS sample;
CREATE DATABASE
IF
	NOT EXISTS sample CHARACTER
	SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

