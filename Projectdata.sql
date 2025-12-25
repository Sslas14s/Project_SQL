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
    course_id INT NOT NULL,
    comment VARCHAR NOT NULL,
    ratting INT CHECK (ratting >= 0 AND ratting <= 10),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
)

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_course
FOREIGN KEY (course_id) REFERENCES courses(course_id);

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_teacher
FOREIGN KEY (teacher_id) REFERENCES TeacherProfiles(teacher_id);

CREATE TABLE promo(
    promo_id SERIAL PRIMARY KEY,
    user_id INT,
    name VARCHAR(15) NOT NULL,
    bloger VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
)

ALTER TABLE promo 
ADD COLUMN discount_percent DECIMAL(5,2) DEFAULT 10.00
CHECK (discount_percent = 10.00); 

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
('Иван Петров', 'ivan.petrov@mail.ru', '9000000001', 'Учитель', '2024-01-10'),
('Анна Смирнова', 'anna.smirnova@mail.ru', '9000000002', 'Учитель', '2024-01-11'),
('Сергей Иванов', 'sergey.ivanov@mail.ru', '9000000003', 'Учитель', '2024-01-12'),
('Ольга Кузнецова', 'olga.kuz@mail.ru', '9000000004', 'Учитель', '2024-01-13'),
('Дмитрий Соколов', 'd.sokolov@mail.ru', '9000000005', 'Учитель', '2024-01-14'),

('Алексей Морозов', 'a.morozov@mail.ru', '9000000006', 'Студент', '2024-02-01'),
('Мария Волкова', 'm.volkova@mail.ru', '9000000007', 'Студент', '2024-02-02'),
('Кирилл Фёдоров', 'k.fedorov@mail.ru', '9000000008', 'Студент', '2024-02-03'),
('Екатерина Павлова', 'e.pavlova@mail.ru', '9000000009', 'Студент', '2024-02-04'),
('Никита Васильев', 'n.vasiliev@mail.ru', '9000000010', 'Студент', '2024-02-05'),

('Татьяна Романова', 't.romanova@mail.ru', '9000000011', 'Студент', '2024-02-06'),
('Андрей Николаев', 'a.nikolaev@mail.ru', '9000000012', 'Студент', '2024-02-07'),
('Юлия Орлова', 'y.orlova@mail.ru', '9000000013', 'Студент', '2024-02-08'),
('Максим Григорьев', 'm.grigoryev@mail.ru', '9000000014', 'Студент', '2024-02-09'),
('Алина Захарова', 'a.zakharova@mail.ru', '9000000015', 'Студент', '2024-02-10'),

('Роман Беляев', 'r.belyaev@mail.ru', '9000000016', 'Студент', '2024-02-11'),
('Дарья Мельникова', 'd.melnikova@mail.ru', '9000000017', 'Студент', '2024-02-12'),
('Владислав Комаров', 'v.komarov@mail.ru', '9000000018', 'Студент', '2024-02-13'),
('Светлана Сергеева', 's.sergeeva@mail.ru', '9000000019', 'Студент', '2024-02-14'),
('Илья Козлов', 'i.kozlov@mail.ru', '9000000020', 'Студент', '2024-02-15'),

('Администратор Системы', 'admin@mail.ru', '9000000021', 'Админ', '2024-03-01');

INSERT INTO TeacherProfiles (bio, expirience_years, rating_avg, total_reviews) VALUES
('Эксперт по Python и backend', 10, 9, 120),
('Специалист по базам данных', 8, 8, 95),
('Java-разработчик с опытом в enterprise', 12, 9, 140),
('Frontend-разработчик и веб-дизайнер', 6, 8, 80),
('Data Scientist, ML инженер', 15, 10, 200);

INSERT INTO courses (teacher_id, title, distribtion, price) VALUES
(1, 'Python с нуля', 'Онлайн', 12000),
(1, 'Продвинутый Python', 'Онлайн', 15000),
(2, 'SQL для начинающих', 'Онлайн', 10000),
(2, 'PostgreSQL для аналитиков', 'Онлайн', 14000),
(3, 'Java Core', 'Онлайн', 13000),
(3, 'Spring Framework', 'Онлайн', 16000),
(4, 'HTML и CSS', 'Онлайн', 9000),
(4, 'JavaScript разработка', 'Онлайн', 11000),
(5, 'Data Science', 'Онлайн', 20000),
(5, 'Machine Learning', 'Онлайн', 25000);

INSERT INTO promo (user_id, name, bloger) VALUES
(6, 'CODE10', 'it_blog'),
(7, 'DEV10', 'dev_channel'),
(8, 'LEARN10', 'edu_media'),
(9, 'SKILL10', 'skill_blog'),
(10, 'PRO10', 'programming_ru');


INSERT INTO CoursePurchases (course_id, user_id, date, summ, promo_id) VALUES
(1, 6, '2024-04-01', 10800, 1),
(2, 7, '2024-04-02', 13500, 2),
(3, 8, '2024-04-03', 9000, 3),
(4, 9, '2024-04-04', 12600, 4),
(5, 10, '2024-04-05', 11700, 5),
(6, 11, '2024-04-06', 16000, NULL),
(7, 12, '2024-04-07', 9000, NULL),
(8, 13, '2024-04-08', 11000, NULL),
(9, 14, '2024-04-09', 20000, NULL),
(10, 15, '2024-04-10', 25000, NULL);

INSERT INTO reviews (user_id, teacher_id, course_id, comment, ratting) VALUES
(6, 1, 1, 'Материал подан понятно', 9),
(7, 1, 2, 'Отличная практика', 10),
(8, 2, 3, 'Хороший курс для старта', 8),
(9, 2, 4, 'Полезно для работы', 9),
(10, 3, 5, 'Курс понравился', 8),
(11, 3, 6, 'Много примеров', 9),
(12, 4, 7, 'Идеально для новичков', 8),
(13, 4, 8, 'Хорошее объяснение тем', 9),
(14, 5, 9, 'Очень сильный курс', 10),
(15, 5, 10, 'Лучший преподаватель', 10);

INSERT INTO reviews (user_id, teacher_id, course_id, comment, ratting) VALUES
(11, 1, 1, 'Хорошая структура курса', 9),
(12, 1, 1, 'Понятно даже без опыта', 8),
(13, 1, 1, 'Много полезных примеров', 9),
(14, 1, 1, 'Немного быстро, но нормально', 8),
(15, 1, 1, 'Отличный старт в Python', 10);

INSERT INTO reviews (user_id, teacher_id, course_id, comment, ratting) VALUES
(8, 1, 2, 'Сильный курс для практики', 9),
(9, 1, 2, 'Много сложных тем', 8),
(10, 1, 2, 'Хорошо разобрано ООП', 9),
(12, 1, 2, 'Отличные домашние задания', 10);

INSERT INTO reviews (user_id, teacher_id, course_id, comment, ratting) VALUES
(6, 2, 3, 'Отлично объясняются основы', 9),
(14, 2, 3, 'Рекомендую новичкам', 9);

--1 Найти курс у который имеет максимальное количество отзывов

SELECT
    c.course_id,
    c.title,
    COUNT(r.review_id) AS reviews_count
FROM courses c
LEFT JOIN reviews r 
    ON r.course_id = c.course_id
GROUP BY c.course_id, c.title
ORDER BY reviews_count DESC;


--2 Найти пользователей которые купили курсы, вывести id и title Курса, а также цену 
SELECT
    u.user_id,
    c.title AS course_title,
    c.price
FROM CoursePurchases cp
JOIN users u 
    ON u.user_id = cp.user_id
JOIN courses c 
    ON c.course_id = cp.course_id
ORDER BY Price DESC;

--3 Найти всех учителей а именно их id и имя и курсы которые он ведет в виде массива 

SELECT
    tp.teacher_id,
    u.name AS teacher_name,
    c.title AS course_title
FROM TeacherProfiles tp
JOIN users u
    ON u.user_id = tp.user_id
LEFT JOIN courses c
    ON c.teacher_id = tp.teacher_id
ORDER BY tp.teacher_id;

