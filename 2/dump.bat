set MYSQL_HOST=127.0.0.1
set MYSQL_USER=root
set MYSQL_PASSWORD=password

set DUMP_DATABASE_NAME=example
set NEW_DATABASE_NAME=sample

set DATABASE_NAME=mysql
set TABLE=help_keyword

:: Создадим дамп базы данных example
mysqldump --user=%MYSQL_USER% --password=%MYSQL_PASSWORD% -h %MYSQL_HOST% %DUMP_DATABASE_NAME% > data\%DUMP_DATABASE_NAME%.sql

:: Развернем содержимое дампа в новую базу данных sample
mysql --user=%MYSQL_USER% --password=%MYSQL_PASSWORD% %NEW_DATABASE_NAME% < data\%DUMP_DATABASE_NAME%.sql

:: Создадим дамп таблицы help_keyword базы данных mysql, только первые 100 строк таблицы
mysqldump --user=%MYSQL_USER% --password=%MYSQL_PASSWORD% -h %MYSQL_HOST% --where="1 limit 100" %DATABASE_NAME% %TABLE% > data\%DATABASE_NAME%-%TABLE%.sql

