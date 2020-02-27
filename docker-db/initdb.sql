CREATE DATABASE IF NOT EXISTS jmeter_demo;
USE jmeter_demo;
CREATE TABLE IF NOT EXISTS films
(
    id       BIGINT PRIMARY KEY AUTO_INCREMENT,
    name     VARCHAR(100) NOT NULL,
    director VARCHAR(100) NOT NULL
);

insert into films (name, director)
values ('The Lord of the Rings: The Fellowship of the Ring', 'Peter_Jackson'),
       ('The Lord of the Rings: The Two Towers', 'Peter_Jackson'),
       ('The Lord of the Rings: The Return of the King', 'Peter_Jackson'),
       ('The Hobbit: An Unexpected Journey', 'Peter_Jackson'),
       ('The Hobbit: The Desolation of Smaug', 'Peter_Jackson'),
       ('The Hobbit: The Battle of the Five Armies', 'Peter_Jackson');