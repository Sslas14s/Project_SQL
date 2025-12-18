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
('Александр Иванов', 'alex.ivanov01@example.com', '79001000001', 'Админ', '2023-01-10'),
('Марина Петрова', 'marina.petrova02@example.com', '79001000002', 'Учитель', '2022-02-14'),
('Дмитрий Смирнов', 'dmitry.smirnov03@example.com', '79001000003', 'Студент', '2024-03-05'),
('Екатерина Козлова', 'ekaterina.kozlova04@example.com', '79001000004', 'Учитель', '2021-04-20'),
('Игорь Лебедев', 'igor.lebedev05@example.com', '79001000005', 'Студент', '2020-05-11'),
('Ольга Морозова', 'olga.morozova06@example.com', '79001000006', 'Учитель', '2019-06-22'),
('Сергей Попов', 'sergey.popov07@example.com', '79001000007', 'Студент', '2023-07-30'),
('Наталья Соколова', 'natalia.sokolova08@example.com', '79001000008', 'Учитель', '2022-08-18'),
('Владимир Васильев', 'vladimir.vasiliev09@example.com', '79001000009', 'Студент', '2024-09-01'),
('Ксения Новикова', 'kseniya.novikova10@example.com', '79001000010', 'Студент', '2021-10-12'),
('Роман Михайлов', 'roman.mikhailov11@example.com', '79001000011', 'Студент', '2020-11-03'),
('Алина Фролова', 'alina.frolova12@example.com', '79001000012', 'Учитель', '2019-12-25'),
('Павел Орлов', 'pavel.orlov13@example.com', '79001000013', 'Студент', '2023-02-08'),
('Маргарита Куликова', 'margarita.kulikova14@example.com', '79001000014', 'Учитель', '2022-03-16'),
('Юрий Громов', 'yuri.gromov15@example.com', '79001000015', 'Студент', '2024-04-04'),
('Татьяна Беляева', 'tatyana.belyaeva16@example.com', '79001000016', 'Студент', '2021-05-19'),
('Максим Зайцев', 'maxim.zaitsev17@example.com', '79001000017', 'Студент', '2020-06-27'),
('Вера Медведева', 'vera.medvedeva18@example.com', '79001000018', 'Учитель', '2019-07-09'),
('Андрей Сидоров', 'andrey.sidorov19@example.com', '79001000019', 'Студент', '2023-08-21'),
('Людмила Романова', 'lyudmila.romanova20@example.com', '79001000020', 'Учитель', '2022-09-30'),
('Илья Крылов', 'ilya.krylov21@example.com', '79001000021', 'Студент', '2024-10-05'),
('Светлана Денисова', 'svetlana.denisova22@example.com', '79001000022', 'Учитель', '2021-11-11'),
('Григорий Павлов', 'grigory.pavlov23@example.com', '79001000023', 'Студент', '2020-12-02'),
('Анна Тихомирова', 'anna.tikhomirova24@example.com', '79001000024', 'Студент', '2019-01-15'),
('Константин Яковлев', 'konstantin.yakovlev25@example.com', '79001000025', 'Студент', '2023-03-29'),
('Юлия Рожкова', 'yulia.rozhkova26@example.com', '79001000026', 'Учитель', '2022-04-07'),
('Олег Никитин', 'oleg.nikitin27@example.com', '79001000027', 'Студент', '2024-05-13'),
('Ирина Лазарева', 'irina.lazareva28@example.com', '79001000028', 'Учитель', '2021-06-01'),
('Богдан Сорокин', 'bogdan.sorokin29@example.com', '79001000029', 'Студент', '2020-07-17'),
('Евгения Воронова', 'evgenia.voronova30@example.com', '79001000030', 'Студент', '2019-08-24'),
('Фёдор Макаров', 'fedor.makarov31@example.com', '79001000031', 'Учитель', '2023-09-06'),
('Любовь Киселева', 'lyubov.kiseleva32@example.com', '79001000032', 'Студент', '2022-10-19'),
('Никита Прохоров', 'nikita.prokhorov33@example.com', '79001000033', 'Студент', '2024-11-28'),
('Елизавета Сергеева', 'elizaveta.sergeeva34@example.com', '79001000034', 'Учитель', '2021-12-08'),
('Василий Горбунов', 'vasily.gorbunov35@example.com', '79001000035', 'Студент', '2020-01-20'),
('Мария Шестакова', 'maria.shestakova36@example.com', '79001000036', 'Студент', '2019-02-14'),
('Степан Руденко', 'stepan.rudenko37@example.com', '79001000037', 'Студент', '2023-04-02'),
('Полина Захарова', 'polina.zakharova38@example.com', '79001000038', 'Учитель', '2022-05-25'),
('Денис Чернов', 'denis.chernov39@example.com', '79001000039', 'Студент', '2024-06-30'),
('Надежда Ермолаева', 'nadezhda.ermolaeva40@example.com', '79001000040', 'Учитель', '2021-07-12'),
('Аркадий Виноградов', 'arkady.vinogradov41@example.com', '79001000041', 'Студент', '2020-08-23'),
('Зоя Кондратьева', 'zoya.kondrateva42@example.com', '79001000042', 'Студент', '2019-09-03'),
('Лев Молчанов', 'lev.molchanov43@example.com', '79001000043', 'Студент', '2023-10-10'),
('Клара Николаева', 'klara.nikolaeva44@example.com', '79001000044', 'Учитель', '2022-11-05'),
('Пётр Савин', 'petr.savin45@example.com', '79001000045', 'Студент', '2024-12-12'),
('Ирина Белова', 'irina.belova46@example.com', '79001000046', 'Студент', '2021-01-07'),
('Станислав Гаврилов', 'stanislav.gavrilov47@example.com', '79001000047', 'Учитель', '2020-02-18'),
('Тамара Лебедева', 'tamara.lebedeva48@example.com', '79001000048', 'Студент', '2019-03-29'),
('Виталий Кравцов', 'vitaly.kravtsov49@example.com', '79001000049', 'Студент', '2023-05-16'),
('Оксана Миронова', 'oksana.mironova50@example.com', '79001000050', 'Учитель', '2022-06-21');