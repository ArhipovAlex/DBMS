CREATE DATABASE PD_321_SQL /*создаем базу данных*/
ON 
(NAME = logical_filename, 
FILENAME = 'D:\MS SQL Server\DATA\PD_321_SQL.mdf',
SIZE = 8 MB,
MAXSIZE = 256 MB,
FILEGROWTH = 8 MB
)