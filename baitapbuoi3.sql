CREATE TABLE user (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

CREATE TABLE order_detail (
    id INT PRIMARY KEY,
    user_id INT,
    food_id INT,
    amount INT,
    arr_sub_id VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (food_id) REFERENCES food(id)
);

CREATE TABLE food (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    price FLOAT,
    image VARCHAR(255),
    des VARCHAR(800),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES type_food(id)
);

CREATE TABLE sub_food (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    food_id INT,
    FOREIGN KEY (food_id) REFERENCES food(id)
);

CREATE TABLE restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES type_food(id)
);

CREATE TABLE like_res (
    user_id INT,
    res_id INT,
    date_like DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (res_id) REFERENCES restaurant(id)
);

CREATE TABLE rate_res (
    user_id INT,
    res_id INT,
    rate_res DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (res_id) REFERENCES restaurant(id)
);

CREATE TABLE type_food (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);


INSERT INTO user (id, name, email, password) VALUES
(1, 'John Doe', 'john@example.com', 'password123'),
(2, 'Jane Smith', 'jane@example.com', 'pass456'),
(3, 'Alice Johnson', 'alice@example.com', 'secret'),
(4, 'Alice', 'alice@example.com', 'password123'),
(5, 'Bob', 'bob@example.com', 'pass456'),
(6, 'Charlie', 'charlie@example.com', 'secret789');

INSERT INTO food (id, name, price, image, des, type_id) VALUES
(1, 'Hamburger', 5.99, 'hamburger.jpg', 'Delicious hamburger with lettuce, tomato, and cheese', 1),
(2, 'Pizza', 8.99, 'pizza.jpg', 'Classic pizza with pepperoni and melted cheese', 1),
(3, 'Sushi', 12.99, 'sushi.jpg', 'Fresh sushi rolls with assorted fish and rice', 2),
(4, 'Pho', 6.99, 'pho.jpg', 'Traditional Vietnamese noodle soup with beef or chicken', 2),
(5, 'Sushi Roll', 9.99, 'sushi_roll.jpg', 'Assorted sushi rolls with fresh fish and rice', 2),
(6, 'Pasta', 12.99, 'pasta.jpg', 'Classic Italian pasta with marinara sauce and parmesan cheese', 1);

INSERT INTO sub_food (id, name, food_id) VALUES
(1, 'Cheeseburger', 1),
(2, 'Vegetarian Pizza', 2),
(3, 'California Roll', 3),
(4, 'Beef Pho', 1),
(5, 'California Roll', 2),
(6, 'Spaghetti Carbonara', 3);

INSERT INTO restaurant (id, name, address, type_id) VALUES
(1, 'Burger Palace', '123 Main St', 1),
(2, 'Pizza World', '456 Elm St', 1),
(3, 'Sushi Bar', '789 Oak St', 2);
(4, 'Pho House', '123 Pho St', 2),
(5, 'Sushi Express', '456 Sushi St', 2),
(6, 'Pasta Palace', '789 Pasta St', 1);


INSERT INTO like_res (user_id, res_id, date_like) VALUES
(1, 1, '2024-04-10 08:30:00'),
(2, 2, '2024-04-11 12:45:00'),
(3, 3, '2024-04-12 17:15:00'),
(4, 4, '2024-04-10 08:30:00'),
(5, 5, '2024-04-11 12:45:00'),

INSERT INTO rate_res (user_id, res_id, rate_res) VALUES
(1, 1, '2024-04-10 08:45:00'),
(2, 2, '2024-04-11 13:00:00'),
(3, 3, '2024-04-12 17:30:00'),
(4, 4, '2024-04-10 08:45:00'),
(5, 5, '2024-04-11 13:00:00'),

INSERT INTO type_food (id, name) VALUES
(1, 'Fast Food'),
(2, 'Asian Cuisine'),
(3, 'Italian Cuisine'),
(4, 'Vietnamese Cuisine'),
(5, 'Japanese Cuisine');

INSERT INTO order_detail (id, user_id, food_id, amount, arr_sub_id) VALUES
(1, 1, 1, 2, '1,2'),
(2, 2, 3, 1, '3'),
(3, 3, 2, 3, '2'),
(4, 1, 1, 2, '1'),
(5, 2, 2, 3, '2'),


-- Tìm 5 người đã like nhà hàng nhiều nhất.
SELECT user.id AS user_id, user.name, COUNT(*) AS num_likes
FROM user
JOIN like_res ON user.id = like_res.user_id
GROUP BY user.id, user.name
ORDER BY num_likes DESC
LIMIT 5;

-- Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT res_id, restaurant.name, COUNT(*) AS num_likes
FROM like_res
JOIN restaurant ON like_res.res_id = restaurant.id
GROUP BY res_id, restaurant.name
ORDER BY num_likes DESC
LIMIT 2;

-- Tìm người đã đặt hàng nhiều nhất.
SELECT user_id, user.name, COUNT(*) AS num_orders
FROM order_detail
JOIN user ON order_detail.user_id = user.id
GROUP BY user_id
ORDER BY num_orders DESC
LIMIT 1;

--Tìm người dùng không hoạt động trong hệ thống 
SELECT *
FROM user
WHERE id NOT IN (
    SELECT user_id FROM order_detail
    UNION
    SELECT user_id FROM like_res
    UNION
    SELECT user_id FROM rate_res
);


