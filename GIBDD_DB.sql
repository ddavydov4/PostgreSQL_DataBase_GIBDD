-- Создание таблиц
-- Таблица Инспектор
drop table Inspector cascade
CREATE TABLE Inspector
(
  ID_number integer PRIMARY KEY UNIQUE,
  _Rank varchar(255),
  Full_name varchar(255)
);
Select * from Inspector;

-- Таблица Камера видеофиксации
drop table Video_Recording_Camera cascade
CREATE TABLE Video_Recording_Camera
(
  Camera_number integer PRIMARY KEY UNIQUE,
  Cam_Loc varchar(255)
);
Select * from Video_Recording_Camera;

-- Таблица Транспортное средство
drop table Vehicle cascade
CREATE TABLE Vehicle
(
  State_number_ID varchar(255) NOT NULL PRIMARY KEY UNIQUE,
  Brand varchar(255) NOT NULL,
  Year_of_issue date NOT NULL
);
Select * from Vehicle;

-- Таблица Нарушитель ПДД
drop table Violator_of_traffic_rules cascade
CREATE TABLE Violator_of_traffic_rules
(
  Passport_ID bigint NOT NULL PRIMARY KEY UNIQUE,
  Full_name varchar(255) NOT NULL,
  INN bigint NOT NULL,
  Year_of_birth date NOT NULL,
  contact_number varchar(255) NOT NULL
);
Select * from Violator_of_traffic_rules;

-- Таблица Нарушения ПДД
drop table Traffic_violations cascade
CREATE TABLE Traffic_violations
(
  Violation_code_ID serial NOT NULL PRIMARY KEY UNIQUE,
  _Time time NOT NULL,
  _date date NOT NULL,
  _View varchar(255) NOT NULL,
  _location varchar(255) NOT NULL
);
Select * from Traffic_violations;

-- Таблица Владелец
drop table _Owner cascade
CREATE TABLE _Owner
(
  Passport bigint NOT NULL PRIMARY KEY UNIQUE,
  Full_name varchar(255) NOT NULL,
  contact_number varchar(255) NOT NULL,
  INN bigint NOT NULL,
  Year_of_birth date NOT NULL
);
Select * from _Owner;

-- Таблица Протокол
drop table Protocol cascade
CREATE TABLE Protocol
(
  ID_Protocol serial NOT NULL PRIMARY KEY UNIQUE,
  Protocol_date date NOT NULL,
  Protocol_Time time NOT NULL,
  ID_number_Inspector integer REFERENCES Inspector(ID_number),
  Camera_number integer REFERENCES Video_Recording_Camera(Camera_number),
  State_number_ID varchar(255) NOT NULL REFERENCES Vehicle(State_number_ID),
  Passport_ID bigint NOT NULL REFERENCES violator_of_traffic_rules(Passport_ID),
  Violation_code_ID serial NOT NULL REFERENCES Traffic_violations(Violation_code_ID),
  Passport bigint NOT NULL REFERENCES _Owner(Passport)
);
Select * from Protocol;
/* Проверка вывода протоколов составленных инспекторами при помощи inner join */
Select * from Protocol
inner join Inspector on Inspector.ID_number = Protocol.ID_number_Inspector
inner join Vehicle on Vehicle.State_number_ID = Protocol.State_number_ID
inner join violator_of_traffic_rules on violator_of_traffic_rules.Passport_ID = Protocol.Passport_ID
inner join Traffic_violations on Traffic_violations.Violation_code_ID = Protocol.Violation_code_ID
inner join _Owner on _Owner.Passport = Protocol.Passport;

/* Проверка вывода протоколов составленных камерами видеофиксации при помощи inner join */
Select * from Protocol
inner join Video_Recording_Camera on Video_Recording_Camera.Camera_number = Protocol.Camera_number
inner join Vehicle on Vehicle.State_number_ID = Protocol.State_number_ID
inner join violator_of_traffic_rules on violator_of_traffic_rules.Passport_ID = Protocol.Passport_ID
inner join Traffic_violations on Traffic_violations.Violation_code_ID = Protocol.Violation_code_ID
inner join _Owner on _Owner.Passport = Protocol.Passport;


-- Таблица Информационный отдел
drop table information_department cascade
CREATE TABLE information_department
(
  information_department_id serial NOT NULL PRIMARY KEY UNIQUE,
  information_department_number serial NOT NULL,
  Received_Protocol_id serial NOT NULL REFERENCES Protocol(ID_Protocol)
);
Select * from information_department;

-- Таблица Отдел ГИБДД
drop table Department_of_traffic_police cascade
CREATE TABLE Department_of_traffic_police
(
  Department_code_ID serial NOT NULL PRIMARY KEY UNIQUE,
  information_department serial NOT NULL REFERENCES information_department(information_department_id),
  The_address varchar(255) NOT NULL
);
Select * from Department_of_traffic_police;

-- Таблица Штрафы
drop table Fines cascade
CREATE TABLE Fines
( 
  Fines_ID serial NOT NULL PRIMARY KEY UNIQUE,
  Status varchar(255) NOT NULL,
  Value_ numeric NOT NULL,
  ID_Protocol serial NOT NULL REFERENCES Protocol(ID_Protocol),
  Department_code_ID serial NOT NULL REFERENCES Department_of_traffic_police(Department_code_ID)
);
Select * from Fines
/* Проверка вывода выписанных штрафов при помощи left join */
Select * from Fines
left join Protocol 
on Fines.ID_Protocol = Protocol.ID_Protocol
left join Department_of_traffic_police 
on Department_of_traffic_police.Department_code_ID = Fines.Department_code_ID;

-- Заполнение таблиц
--Заполнение таблицы Инспектор

INSERT INTO Inspector (ID_number,_Rank,Full_name) VALUES(1,'Рядовой','Жуков Никифор Максович');
INSERT INTO Inspector (ID_number,_Rank,Full_name) VALUES(2,'Мл.Сержант','Колобов Ким Никитевич');
INSERT INTO Inspector (ID_number,_Rank,Full_name) VALUES(3,'Лейтенант','Авдеев Авраам Макарович');
INSERT INTO Inspector (ID_number,_Rank,Full_name) VALUES(4,'Рядовой','Корнилов Тимур Валерьянович');
INSERT INTO Inspector (ID_number,_Rank,Full_name) VALUES(5,'Рядовой','Михайлов Лавр Иванович');

--Заполнение таблицы Камера видеовиксации

INSERT INTO Video_Recording_Camera (Camera_number,Cam_Loc) VALUES(1,'Вавилова 5');
INSERT INTO Video_Recording_Camera (Camera_number,Cam_Loc) VALUES(2,'Валдайская 13');
INSERT INTO Video_Recording_Camera (Camera_number,Cam_Loc) VALUES(3,'Варшавская 3');
INSERT INTO Video_Recording_Camera (Camera_number,Cam_Loc) VALUES(4,'Абаканская 2');
INSERT INTO Video_Recording_Camera (Camera_number,Cam_Loc) VALUES(5,'Газонная 6');
INSERT INTO Video_Recording_Camera (Camera_number,Cam_Loc) VALUES(6,'Еловая 7');
INSERT INTO Video_Recording_Camera (Camera_number,Cam_Loc) VALUES(7,'Иванова 9');
INSERT INTO Video_Recording_Camera (Camera_number,Cam_Loc) VALUES(8,'Кавалерийская 20');
INSERT INTO Video_Recording_Camera (Camera_number,Cam_Loc) VALUES(9,'Лаврова 3');
INSERT INTO Video_Recording_Camera (Camera_number,Cam_Loc) VALUES(10,'Кавалькадная 4');

--Заполнение таблицы Транспортное средство

INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('Н266СС','Audi','2018-06-08');
INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('Е688МА','BMW','2013-12-16');
INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('О726ТК','Ford','2007-11-23');
INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('Т130ВВ','Honda','2007-11-07');
INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('К384АН','Audi','2021-10-01');
INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('Т629ВС','Ford','2008-06-15');
INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('Т387ХУ','Honda','2019-05-14');
INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('Х564УН','BMW','2012-07-27');
INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('К790АТ','Kia','2022-04-19');
INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('А321ХР','Honda','2021-11-30');
INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('В908ВК','Audi','2022-10-24');
INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('К261СН','Hyundai','2008-06-02');
INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('У725РТ','Mazda','2005-09-27');
INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('А295ОВ','BMW','2008-03-18');
INSERT INTO Vehicle (State_number_ID,Brand,Year_of_issue) VALUES('О237АС','Hyundai','2020-07-11');

--Заполнение таблицы Нарушитель ПДД
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4155890594','Ершов Арсен Русланович','740582412774','1997-12-13','7(993)484-52-09');
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4492477874','Игнатьев Исаак Игнатьевич','221163977392','1988-07-15','7(983)462-66-22');
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4366651794','Галкин Лукьян Юрьевич','260500263114','1998-05-08','7(931)041-24-28');
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4014292813','Архипов Нелли Владиславович','117864632278','1992-03-18','7(958)180-98-99');
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4631541292','Медведев Виктор Денисович','857134425629','1991-10-30','7(962)097-03-74');
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4094674342','Иванков Нелли Александрович','516937481696','1988-09-11','7(997)757-73-08');
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4443242125','Громов Вениамин Львович','029320251490','1988-01-28','7(916)853-91-63');
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4840999710','Королёв Мартын Максимович','728461960577','1980-12-29','7(967)840-52-46');
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4633695848','Морозов Николай Николаевич','146608769053','1998-12-26','7(987)000-35-60');
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4378852670','Ковалёв Георгий Тимофеевич','741679248907','1984-05-11','7(917)784-79-51');
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4317651359','Капустин Антон Мэлорович','623762662822','1984-10-29','7(905)305-26-54');
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4685502897','Ширяев Болеслав Дмитрьевич','383464956009','1981-11-22','7(933)515-85-91');
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4758272295','Рожков Кондратий Юрьевич','779018519358','1986-05-28','7(931)677-41-84');
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4890325460','Кошелев Игнатий Эльдарович','583198765293','1990-01-19','7(980)769-43-19');
INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
VALUES('4082218270','Никонов Иосиф Кириллович','183996398536','1995-07-23','7(966)722-88-18');

--Заполнение таблицы Нарушения ПДД

INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(1,'19:17:52','2022-12-14','Превышение скорости','Вавилова 5');
INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(2,'20:39:04','2022-12-19','Превышение скорости','Валдайская 13');
INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(3,'08:45:49','2022-12-14','Превышение скорости','Варшавская 3');
INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(4,'19:27:25','2022-12-14','Превышение скорости','Абаканская 2');
INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(5,'01:56:48','2022-12-14','Превышение скорости','Газонная 6');
INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(6,'07:28:25','2022-12-13','Превышение скорости','Еловая 7');
INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(7,'19:20:15','2022-12-20','Превышение скорости','Иванова 9');
INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(8,'07:44:01','2022-12-20','Превышение скорости','Кавалерийская 20');
INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(9,'08:26:43','2022-12-16','Превышение скорости','Лаврова 3');
INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(10,'20:48:32','2022-12-19','Превышение скорости','Кавалькадная 4');
INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(11,'08:35:53','2022-12-13','Превышение скорости','Южная 9');
INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(12,'02:22:39','2022-12-15','Превышение скорости','Юбилейная 19');
INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(13,'23:28:59','2022-12-19','Превышение скорости','Экваторная 16');
INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(14,'14:59:10','2022-12-13','Превышение скорости','Экономическая 20');
INSERT INTO Traffic_violations (Violation_code_ID,_Time,_date,_View,_location) 
VALUES(15,'12:40:08','2022-12-19','Превышение скорости','Щетинкина 16');

--Заполнение таблицы Владелец

INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth) 
VALUES('4155890594','Ершов Арсен Русланович','7(993)484-52-09','740582412774','1997-12-13');
INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth) 
VALUES('4492477874','Игнатьев Исаак Игнатьевич','7(983)462-66-22','221163977392','1988-07-15');
INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth) 
VALUES('4366651794','Галкин Лукьян Юрьевич','7(931)041-24-28','260500263114','1998-05-08');
INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth) 
VALUES('4014292813','Архипов Нелли Владиславович','7(958)180-98-99','117864632278','1992-03-18');
INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth)
VALUES('4631541292','Медведев Виктор Денисович','7(962)097-03-74','857134425629','1991-10-30');
INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth) 
VALUES('4094674342','Иванков Нелли Александрович','7(997)757-73-08','516937481696','1988-09-11');
INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth) 
VALUES('4443242125','Громов Вениамин Львович','7(916)853-91-63','029320251490','1988-01-28');
INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth) 
VALUES('4840999710','Королёв Мартын Максимович','7(967)840-52-46','728461960577','1980-12-29');
INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth) 
VALUES('4633695848','Морозов Николай Николаевич','7(987)000-35-60','146608769053','1998-12-26');
INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth) 
VALUES('4378852670','Ковалёв Георгий Тимофеевич','7(917)784-79-51','741679248907','1984-05-11');
INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth) 
VALUES('4317651359','Капустин Антон Мэлорович','7(905)305-26-54','623762662822','1984-10-29');
INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth) 
VALUES('4685502897','Ширяев Болеслав Дмитрьевич','7(933)515-85-91','383464956009','1981-11-22');
INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth) 
VALUES('4758272295','Рожков Кондратий Юрьевич','7(931)677-41-84','779018519358','1986-05-28');
INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth) 
VALUES('4890325460','Кошелев Игнатий Эльдарович','7(980)769-43-19','583198765293','1990-01-19');
INSERT INTO _Owner (Passport,Full_name,contact_number,INN,Year_of_birth) 
VALUES('4082218270','Никонов Иосиф Кириллович','7(966)722-88-18','183996398536','1995-07-23');

--Заполнение таблицы Протокол

INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(1,'2022-12-18','15:26:27',1,NULL,'Н266СС','4155890594',1,'4155890594');
INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(2,'2022-12-15','06:14:12',1,NULL,'Е688МА','4492477874',2,'4492477874');
INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(3,'2022-12-19','16:32:16',1,NULL,'О726ТК','4366651794',3,'4366651794');
INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(4,'2022-12-19','03:17:13',2,NULL,'Т130ВВ','4014292813',4,'4014292813');
INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(5,'2022-12-17','20:46:51',2,NULL,'К384АН','4631541292',5,'4631541292');
INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(6,'2022-12-16','15:12:55',2,NULL,'Т629ВС','4094674342',6,'4094674342');
INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(7,'2022-12-17','11:37:51',NULL,10,'Т387ХУ','4443242125',7,'4443242125');
INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(8,'2022-12-16','21:58:20',NULL,9,'Х564УН','4840999710',8,'4840999710');
INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(9,'2022-12-16','04:36:34',NULL,8,'К790АТ','4633695848',9,'4633695848');
INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(10,'2022-12-16','05:32:03',NULL,7,'А321ХР','4378852670',10,'4378852670');
INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(11,'2022-12-15','13:10:07',NULL,1,'В908ВК','4317651359',11,'4317651359');
INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(12,'2022-12-17','08:30:23',NULL,2,'К261СН','4685502897',12,'4685502897');
INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(13,'2022-12-15','04:50:34',NULL,3,'У725РТ','4758272295',13,'4758272295');
INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(14,'2022-12-18','20:23:35',NULL,4,'А295ОВ','4890325460',14,'4890325460');
INSERT INTO Protocol (ID_Protocol,Protocol_date,Protocol_Time,ID_number_Inspector,Camera_number,State_number_ID,
Passport_ID,Violation_code_ID,Passport)
VALUES(15,'2022-12-18','17:13:36',NULL,5,'О237АС','4082218270',15,'4082218270');

--Заполнение таблицы Информационный отдел

INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(1,1,1);
INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(2,2,2);
INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(3,3,3);
INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(4,1,4);
INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(5,2,5);
INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(6,3,6);
INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(7,1,7);
INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(8,2,8);
INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(9,3,9);
INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(10,3,10);
INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(11,2,11);
INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(12,1,12);
INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(13,3,13);
INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(14,2,14);
INSERT INTO information_department (information_department_id,information_department_number,Received_Protocol_id)
VALUES(15,1,15);

--Заполнение таблицы Отдел ГИБДД

INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address)
VALUES(1,1,'Эстакадная 13');
INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address) 
VALUES(2,2,'Цветной проезд 2');
INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address) 
VALUES(3,3,'Гайдара 71');
INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address) 
VALUES(4,4,'Давыдовского 5');
INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address) 
VALUES(5,5,'Цветной проезд 2');
INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address) 
VALUES(6,6,'Цветной проезд 2');
INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address) 
VALUES(7,7,'Гайдара 71');
INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address) 
VALUES(8,8,'Эстакадная 13');
INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address) 
VALUES(9,9,'Давыдовского 5');
INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address) 
VALUES(10,10,'Давыдовского 5');
INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address) 
VALUES(11,11,'Гайдара 71');
INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address) 
VALUES(12,12,'Давыдовского 5');
INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address) 
VALUES(13,13,'Эстакадная 13');
INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address) 
VALUES(14,14,'Цветной проезд 2');
INSERT INTO Department_of_traffic_police (Department_code_ID,information_department,The_address) 
VALUES(15,15,'Гайдара 71');

--Заполнение таблицы Штрафы

INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(1,'Не оплачен',1000,1);
INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(2,'Оплачен',500,2);
INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(3,'Не оплачен',1000,3);
INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(4,'Оплачен',500,4);
INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(5,'Не оплачен',500,5);
INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(6,'Оплачен',1000,6);
INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(7,'Не оплачен',500,7);
INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(8,'Оплачен',1000,8);
INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(9,'Не оплачен',1000,9);
INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(10,'Оплачен',500,10);
INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(11,'Не оплачен',1000,11);
INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(12,'Оплачен',500,12);
INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(13,'Не оплачен',500,13);
INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(14,'Оплачен',1000,14);
INSERT INTO Fines (Fines_ID,Status,Value_,ID_Protocol) VALUES(15,'Не оплачен',500,15);

/*
Формирование отчёта о протоколах составленных инспектором
*/
DROP VIEW Protocol_Inspector CASCADE;
CREATE VIEW Protocol_Inspector
AS 
SELECT
	Protocol.ID_Protocol,
    Protocol.Protocol_date,
    Protocol.Protocol_Time,
	Inspector.ID_number,
    Vehicle.State_number_ID,
    violator_of_traffic_rules.Passport_ID,
    Traffic_violations.Violation_code_ID,
    _Owner.Passport
From
	Protocol
	inner join Inspector on Inspector.ID_number = Protocol.ID_number_Inspector
    inner join Vehicle on Vehicle.State_number_ID = Protocol.State_number_ID
    inner join violator_of_traffic_rules on violator_of_traffic_rules.Passport_ID = Protocol.Passport_ID
    inner join Traffic_violations on Traffic_violations.Violation_code_ID = Protocol.Violation_code_ID
    inner join _Owner on _Owner.Passport = Protocol.Passport;
SELECT * FROM Protocol_Inspector;

/*
Формирование отчёта о протоколах составленных камерами видеофиксации
*/
DROP VIEW Protocol_Camera CASCADE;
CREATE VIEW Protocol_Camera
AS 
SELECT
	Protocol.ID_Protocol,
    Protocol.Protocol_date,
    Protocol.Protocol_Time,
	Video_Recording_Camera.Camera_number,
    Vehicle.State_number_ID,
    violator_of_traffic_rules.Passport_ID,
    Traffic_violations.Violation_code_ID,
    _Owner.Passport
From
	Protocol
	inner join Video_Recording_Camera on Video_Recording_Camera.Camera_number = Protocol.Camera_number
    inner join Vehicle on Vehicle.State_number_ID = Protocol.State_number_ID
    inner join violator_of_traffic_rules on violator_of_traffic_rules.Passport_ID = Protocol.Passport_ID
    inner join Traffic_violations on Traffic_violations.Violation_code_ID = Protocol.Violation_code_ID
    inner join _Owner on _Owner.Passport = Protocol.Passport;
SELECT * FROM Protocol_Camera;

/*
Формирование отчёта о выписанных штрафах при помощи Left Join
*/
	
DROP VIEW DOC_Fines CASCADE;
CREATE VIEW DOC_Fines
AS 
SELECT
	Fines.Fines_ID,
    Fines.Status,
    Fines.Value_,
	Protocol.ID_Protocol,
    Department_of_traffic_police.Department_code_ID
From
	Fines
	left join Protocol 
         on Fines.ID_Protocol = Protocol.ID_Protocol
    left join Department_of_traffic_police 
         on Department_of_traffic_police.Department_code_ID = Fines.Department_code_ID;
SELECT * FROM DOC_Fines;
	
--Выявление мелких штрафов
	Select Value_,
		Case 
		when Value_ < 1000 then 'Мелкий штраф' 
		else 'Большой штраф'
	end
From Fines
	
--Средняя цена штрафов
		
		CREATE VIEW Cu_SUM
AS	
SELECT AVG(Value_) FROM Fines;

		select * from Cu_SUM
--Общая сумма штрафов
		
		CREATE VIEW Fines_SUM
AS	
SELECT SUM(Value_) FROM Fines;		
		
		Select * from Fines_SUM
	
	
-- Отчет о существующих видах нарушений

drop view Traffic_violations_View
		CREATE VIEW Traffic_violations_View
AS 
SELECT 
	Traffic_violations._View, count (Traffic_violations._View) AS Violations_View
From
	Traffic_violations
	Group by Traffic_violations._View
Order by Violations_View;
	
	Select * from Traffic_violations_View
	
	
-- Добавление в Violator_of_traffic_rules новую строку
drop FUNCTION Violator_of_traffic_rules_INSERTION;
CREATE FUNCTION Violator_of_traffic_rules_INSERTION
    (	
		Passport_ID bigint,
        Full_name varchar(255),
        INN bigint,
        Year_of_birth date,
        contact_number varchar(255)
	)
    RETURNS integer
    LANGUAGE 'sql'
    AS
    $$
    INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
    VALUES('4155899994','Ершов Артём Романович','740582999774','1999-12-13','7(999)484-99-99');
	select $1
    $$;
	
	Select * from Violator_of_traffic_rules;
	
	
-- Добавление в Violator_of_traffic_rules новую строку при помощи процедуры

DROP PROCEDURE IF EXISTS Violator_of_traffic_rules_Insertation_Procedure;
CREATE OR REPLACE PROCEDURE Violator_of_traffic_rules_Insertation_Procedure
	(
		Passport_ID bigint,
        Full_name varchar(255),
        INN bigint,
        Year_of_birth date,
        contact_number varchar(255)
	)
LANGUAGE plpgsql
AS
$$
BEGIN
	INSERT INTO Violator_of_traffic_rules (Passport_ID,Full_name,INN,Year_of_birth,contact_number) 
	VALUES ($1, $2, $3, $4, $5);
END;
$$;
CALL Violator_of_traffic_rules_Insertation_Procedure ('9999999994','Коломеец Егор Андреевич','740999999774','2002-10-12','7(999)999-99-99');
SELECT * FROM Violator_of_traffic_rules;

-- Добавление в Inspector новую строку	
	CREATE FUNCTION Inspector_INSERTION
    (	ID_number integer,
        _Rank varchar(255),
        Full_name varchar(255)
		)
    RETURNS integer
    LANGUAGE 'sql'
    AS
    $$
    INSERT INTO Inspector (ID_number,_Rank,Full_name) VALUES(6,'Рядовой','Бекетов Иван Владимирович');
	select $1
    $$;
	
	Select * from Inspector;
	
	
/*
Формирование отчёта о Нарушителе при помощи функции
*/
DROP FUNCTION IF EXISTS Violator_of_traffic_rules_info;
CREATE OR REPLACE FUNCTION Violator_of_traffic_rules_info
	(Full_name_Violator varchar(255))  
RETURNS TABLE 
	(
	 Passport_ID bigint,
     Full_name varchar(255),
     INN bigint,
     Year_of_birth date,
     contact_number varchar(255)
	)
LANGUAGE 'plpgsql' 
AS 
$$ 
BEGIN 
RETURN QUERY SELECT
	Violator_of_traffic_rules.Passport_ID,
	Violator_of_traffic_rules.Full_name,
	Violator_of_traffic_rules.INN,
	Violator_of_traffic_rules.Year_of_birth,
	Violator_of_traffic_rules.contact_number
From
	Violator_of_traffic_rules
WHERE  Violator_of_traffic_rules.Full_name LIKE Full_name_Violator;
END; 
$$;
SELECT * FROM Violator_of_traffic_rules_info ('Никонов Иосиф Кириллович');


	/*
Формирование отчёта о Владельце при помощи функции,
а также раздление столбцов при помощи CAST
*/
DROP FUNCTION IF EXISTS Owner_info;
CREATE OR REPLACE FUNCTION Owner_info
	(Full_name_Owner varchar(255))  
RETURNS TABLE 
	(
	 Passport bigint,
     Name_Owner varchar(255),
	 MidlleName_Owner varchar(255),
	 SurName_Owner varchar(255),
     INN bigint,
     Year_of_birth date,
     contact_number varchar(255)
	)
LANGUAGE 'plpgsql' 
AS 
$$ 
BEGIN 
RETURN QUERY SELECT
	_Owner.Passport,
	Cast(split_part(_Owner.Full_name,' ', 1) as varchar(255)),
  Cast(split_part(_Owner.Full_name,' ', 2) as varchar(255)),
  Cast(split_part(_Owner.Full_name,' ', 3) as varchar(255)),
	_Owner.INN,
	_Owner.Year_of_birth,
	_Owner.contact_number
From
	_Owner
WHERE  _Owner.Full_name LIKE Full_name_Owner;
END; 
$$;
SELECT * FROM Owner_info ('Игнатьев Исаак Игнатьевич');