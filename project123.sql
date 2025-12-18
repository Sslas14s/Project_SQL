CREATE TYPE role AS ENUM ('Учитель', 'Студент', 'Админ');



CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(11) UNIQUE NOT NULL,
    roli role NOT NULL, 
    registration_date DATE NOT NULL
);

CREATE TABLE TeacherProfiles(
    teacher_id SERIAL PRIMARY KEY,
    bio VARCHAR NOT NULL,
    expirience_years INT,
    rating_avg INT,
    total_reviews INT
)

ALTER TABLE TeacherProfiles
ADD COLUMN user_id INT UNIQUE,
ADD CONSTRAINT fk_teacher_user
FOREIGN KEY (user_id) REFERENCES users(user_id);



CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    teacher_id INT NOT NULL,
    comment VARCHAR NOT NULL,
    ratting INT CHECK (ratting >= 0 AND ratting <= 10),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
)

CREATE TABLE promo(
    promo_id SERIAL PRIMARY KEY,
    user_id INT,
    name VARCHAR(15) NOT NULL,
    bloger VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
)

CREATE TABLE courses(
    course_id SERIAL PRIMARY KEY,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES TeacherProfiles(teacher_id),
    title VARCHAR NOT NULL,
    distribtion VARCHAR NOT NULL,
    price NUMERIC(12,2) NOT NULL
)

CREATE TABLE CoursePurchases(
    purchase_id SERIAL PRIMARY KEY,
    course_id INT,
    user_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    date DATE NOT NULL,
    summ INT NOT NULL,
    promo_id INT,
    FOREIGN KEY (promo_id) REFERENCES promo(promo_id)
)

CREATE TABLE Lessons(
    course_id SERIAL PRIMARY KEY,
    title VARCHAR NOT NULL,
    video_url VARCHAR NOT NULL
)


INSERT INTO users (name, email, phone, roli, registration_date) VALUES
('Иван Петров', 'ivan@mail.com', '9000000001', 'Учитель', '2024-01-10'),
('Анна Смирнова', 'anna@mail.com', '9000000002', 'Учитель', '2024-01-12'),
('Дмитрий Кузнецов', 'dmitry@mail.com', '9000000003', 'Учитель', '2024-01-15'),
('Ольга Иванова', 'olga@mail.com', '9000000004', 'Учитель', '2024-01-18'),
('Алексей Морозов', 'alexey@mail.com', '9000000005', 'Учитель', '2024-01-20'),

('Сергей Волков', 'sergey@mail.com', '9000000011', 'Студент', '2024-02-01'),
('Мария Белова', 'maria@mail.com', '9000000012', 'Студент', '2024-02-03'),
('Екатерина Орлова', 'ekaterina@mail.com', '9000000013', 'Студент', '2024-02-05'),
('Павел Сидоров', 'pavel@mail.com', '9000000014', 'Студент', '2024-02-07'),
('Никита Фролов', 'nikita@mail.com', '9000000015', 'Студент', '2024-02-09'),

('Администратор', 'admin@mail.com', '9000000099', 'Админ', '2024-01-01');

INSERT INTO TeacherProfiles (bio, expirience_years, rating_avg, total_reviews) VALUES
('Backend разработчик, PostgreSQL', 7, 9, 120),
('Data аналитик, SQL и Python', 6, 8, 95),
('Fullstack разработчик', 8, 9, 150),
('DevOps и базы данных', 10, 9, 200),
('Преподаватель алгоритмов', 5, 8, 80);

INSERT INTO courses (teacher_id, title, distribtion, price) VALUES
(1, 'SQL с нуля', 'online', 9900.00),
(1, 'Продвинутый SQL', 'online', 14900.00),
(2, 'SQL для аналитиков', 'online', 11900.00),
(2, 'PostgreSQL и оптимизация', 'offline', 17900.00),
(3, 'Backend разработка', 'online', 19900.00),
(3, 'REST API на практике', 'online', 15900.00),
(4, 'DevOps основы', 'offline', 18900.00),
(4, 'Базы данных в продакшене', 'online', 16900.00),
(5, 'Алгоритмы и структуры данных', 'online', 12900.00),
(5, 'Подготовка к собеседованиям', 'online', 10900.00);


INSERT INTO Lessons (course_id, title, video_url) VALUES
(1, 'Введение в SQL', 'https://example.com/sql/1'),
(2, 'Оптимизация запросов', 'https://example.com/sql/2'),
(3, 'SQL для анализа данных', 'https://example.com/sql/3'),
(4, 'Индексы и EXPLAIN', 'https://example.com/sql/4'),
(5, 'Архитектура backend', 'https://example.com/backend/1'),
(6, 'REST и HTTP', 'https://example.com/backend/2'),
(7, 'CI/CD основы', 'https://example.com/devops/1'),
(8, 'Масштабирование БД', 'https://example.com/db/1'),
(9, 'Алгоритмы сортировки', 'https://example.com/algorithms/1'),
(10, 'Собеседование в IT', 'https://example.com/interview/1');


INSERT INTO promo (user_id, name, bloger) VALUES
(6, 'SALE10', 'TechBlog'),
(7, 'WELCOME', 'CodeLife'),
(8, 'STUDENT5', 'DevChannel');


INSERT INTO CoursePurchases (course_id, user_id, date, summ, promo_id) VALUES
(1, 6, '2024-03-01', 8900, 1),
(2, 6, '2024-03-05', 14900, NULL),
(3, 7, '2024-03-06', 10900, 2),
(5, 8, '2024-03-10', 19900, NULL),
(7, 9, '2024-03-12', 17900, 3),
(9, 10, '2024-03-15', 12900, NULL);


INSERT INTO reviews (user_id, teacher_id, comment, ratting) VALUES
(6, 1, 'Отличный курс, всё понятно', 9),
(7, 2, 'Хороший материал, но сложно', 8),
(8, 3, 'Очень полезно для работы', 9),
(9, 4, 'Много практики', 10),
(10, 5, 'Помог подготовиться к интервью', 9);

SELECT * FROM courses;

UPDATE TeacherProfiles
SET user_id = 1
WHERE teacher_id = 1;

UPDATE TeacherProfiles
SET user_id = 2
WHERE teacher_id = 2;

UPDATE TeacherProfiles
SET user_id = 3
WHERE teacher_id = 3;

UPDATE TeacherProfiles
SET user_id = 4
WHERE teacher_id = 4;

UPDATE TeacherProfiles
SET user_id = 5
WHERE teacher_id = 5; 