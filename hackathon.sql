create database shopDb;
use shopDb;

create table customers (
    id int primary key auto_increment,
    name varchar(255) not null,
    email varchar(255) not null
);

create table orders (
    order_id int primary key auto_increment,
    customer_id int,
    order_amount decimal(10, 2),
    order_date date,
    foreign key (customer_id) references customers(id)
);

insert into customers(name, email) values 
('alice smith', 'alice@gmail.com'),
('bob jones', 'bobjones@gmail.com');

insert into orders(customer_id, order_amount, order_date) values
(1, 100.5, now()),
(1, 200.75, now()),
(2, 150, now());