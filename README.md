## Домашнє завдання 4

### DML та DDL команди. Складні SQL вирази.

---

## Опис роботи

У цьому домашньому завданні було створено базу даних для керування бібліотекою книг за допомогою DDL-команд.

Також було заповнено таблиці тестовими даними за допомогою DML-команд та виконано складні SQL-запити з використанням декількох операторів `JOIN`.

---

## Завдання 1

Створено базу даних `LibraryManagement` та таблиці для керування бібліотекою книг.

DROP DATABASE IF EXISTS LibraryManagement;
CREATE DATABASE LibraryManagement;
USE LibraryManagement;

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year YEAR,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO authors (author_name) VALUES
('George Orwell'),
('Jane Austen');

INSERT INTO genres (genre_name) VALUES
('Dystopian'),
('Romance');

INSERT INTO books (title, publication_year, author_id, genre_id) VALUES
('1984', 1949, 1, 1),
('Modern Romance', 2001, 2, 2);

INSERT INTO users (username, email) VALUES
('arianna', 'arianna@example.com'),
('nikolas', 'nikolas@example.com');

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES
(1, 1, '2024-05-01', '2024-05-15'),
(2, 2, '2024-05-03', '2024-05-20');


---

## Завдання 2

Таблиці були заповнені тестовими даними.

Для перевірки кількості доданих рядків було використано запит:

SELECT 'authors' AS table_name, COUNT(*) AS rows_count FROM authors
UNION ALL
SELECT 'genres', COUNT(*) FROM genres
UNION ALL
SELECT 'books', COUNT(*) FROM books
UNION ALL
SELECT 'users', COUNT(*) FROM users
UNION ALL
SELECT 'borrowed_books', COUNT(*) FROM borrowed_books;

---

## Завдання 3

Було виконано запит з використанням `INNER JOIN`, який об’єднує всі таблиці, імпортовані в темі 3:


Запит:

SELECT 
od.id AS order_detail_id,
o.id AS order_id,
c.name AS customer_name,
p.name AS product_name,
cat.name AS category_name,
e.first_name AS employee_first_name,
e.last_name AS employee_last_name,
s.name AS shipper_name,
sup.name AS supplier_name,
od.quantity,
p.price
FROM order_details od
INNER JOIN orders o ON od.order_id = o.id
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers s ON o.shipper_id = s.id
INNER JOIN suppliers sup ON p.supplier_id = sup.id;

---

## Завдання 4.1

Було визначено кількість рядків, отриманих після об’єднання таблиць за допомогою `INNER JOIN`.

Запит:

SELECT COUNT(*) AS total_rows
FROM order_details od
INNER JOIN orders o ON od.order_id = o.id
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers s ON o.shipper_id = s.id
INNER JOIN suppliers sup ON p.supplier_id = sup.id;

Результат:

- `total_rows = 518`

---

## Завдання 4.2

Було змінено оператори `INNER JOIN` на `LEFT JOIN` та перевірено кількість рядків.

Запит:

SELECT COUNT(*) AS total_rows_left_join
FROM order_details od
LEFT JOIN orders o ON od.order_id = o.id
LEFT JOIN customers c ON o.customer_id = c.id
LEFT JOIN products p ON od.product_id = p.id
LEFT JOIN categories cat ON p.category_id = cat.id
LEFT JOIN employees e ON o.employee_id = e.employee_id
LEFT JOIN shippers s ON o.shipper_id = s.id
LEFT JOIN suppliers sup ON p.supplier_id = sup.id;

Результат:

- `total_rows_left_join = 518`


---

## Завдання 4.3

На основі запиту з пункту 3 було обрано тільки ті рядки, де `employee_id > 3` та `employee_id <= 10`.

Запит:

SELECT 
od.id AS order_detail_id,
o.id AS order_id,
c.name AS customer_name,
p.name AS product_name,
cat.name AS category_name,
e.first_name AS employee_first_name,
e.last_name AS employee_last_name,
s.name AS shipper_name,
sup.name AS supplier_name,
od.quantity,
p.price
FROM order_details od
INNER JOIN orders o ON od.order_id = o.id
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers s ON o.shipper_id = s.id
INNER JOIN suppliers sup ON p.supplier_id = sup.id
WHERE e.employee_id > 3
AND e.employee_id <= 10;

---

## Завдання 4.4

Було виконано групування за назвою категорії, підраховано кількість рядків у групі та середню кількість товару з таблиці `order_details`.

Запит:

SELECT 
cat.name AS category_name,
COUNT(*) AS rows_count,
AVG(od.quantity) AS average_quantity
FROM order_details od
INNER JOIN orders o ON od.order_id = o.id
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers s ON o.shipper_id = s.id
INNER JOIN suppliers sup ON p.supplier_id = sup.id
WHERE e.employee_id > 3
AND e.employee_id <= 10
GROUP BY cat.name;

---

## Завдання 4.5

Було відфільтровано групи, де середня кількість товару більша за 21.

Запит:

SELECT 
cat.name AS category_name,
COUNT(*) AS rows_count,
AVG(od.quantity) AS average_quantity
FROM order_details od
INNER JOIN orders o ON od.order_id = o.id
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers s ON o.shipper_id = s.id
INNER JOIN suppliers sup ON p.supplier_id = sup.id
WHERE e.employee_id > 3
AND e.employee_id <= 10
GROUP BY cat.name
HAVING AVG(od.quantity) > 21;

---

## Завдання 4.6

Було відсортовано рядки за спаданням кількості рядків.

Запит:

SELECT 
cat.name AS category_name,
COUNT(*) AS rows_count,
AVG(od.quantity) AS average_quantity
FROM order_details od
INNER JOIN orders o ON od.order_id = o.id
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers s ON o.shipper_id = s.id
INNER JOIN suppliers sup ON p.supplier_id = sup.id
WHERE e.employee_id > 3
AND e.employee_id <= 10
GROUP BY cat.name
HAVING AVG(od.quantity) > 21
ORDER BY rows_count DESC;

---

## Завдання 4.7

Було виведено чотири рядки з пропущеним першим рядком за допомогою `LIMIT` та `OFFSET`.

Запит:

SELECT 
cat.name AS category_name,
COUNT(*) AS rows_count,
AVG(od.quantity) AS average_quantity
FROM order_details od
INNER JOIN orders o ON od.order_id = o.id
INNER JOIN customers c ON o.customer_id = c.id
INNER JOIN products p ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers s ON o.shipper_id = s.id
INNER JOIN suppliers sup ON p.supplier_id = sup.id
WHERE e.employee_id > 3
AND e.employee_id <= 10
GROUP BY cat.name
HAVING AVG(od.quantity) > 21
ORDER BY rows_count DESC
LIMIT 4 OFFSET 1;

---

## Скріншоти

У репозиторії додано скріншоти виконаних SQL-запитів та результатів їх роботи.


- `p1_library_tables.png`
- `p2_inserted_test_data_count.png`
- `p3_inner_join_all_tables.png`
- `p4_1_count_inner_join.png`
- `p4_2_left_join_count.png`
- `p4_3_employee_filter.png`
- `p4_4_group_by_category.png`
- `p4_5_having_avg_quantity.png`
- `p4_6_order_by_rows_count.png`
- `p4_7_limit_offset.png`

---

## Файли репозиторію

- `hw4.sql`
- `README.md`
- скріншоти з результатами виконання запитів
