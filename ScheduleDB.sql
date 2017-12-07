create database ScheduleDB

use ScheduleDB

--Белинский
create table Subject_table(
id int IDENTITY(1,1) not null primary key,
SubjectName nvarchar(50) not null)
insert into Subject_table
Values 
('Программирование'),
('Философия'),
('Математический анализ')

--Белинский
create table TypeWeek_table(
id int IDENTITY(1,1) not null primary key,
TypeWeek nvarchar(50) not null)
insert into TypeWeek_table
Values 
('Четная'),
('Нечетная')

--Белинский
create table Day_table(
id int IDENTITY(1,1) not null primary key,
NameOfDay nvarchar(50) not null)
insert into Day_table
Values 
('Понедельник'),
('Вторник'),
('Среда'),
('Четверг'),
('Пятница'),
('Суббота'),
('Воскресенье')

--Белинский
create table AcademicTitle_table(
id int IDENTITY(1,1) not null primary key,
AcademicTitle nvarchar(50) not null)
insert into AcademicTitle_table
Values 
('Преподаватель'),
('Старший преподаватель'),
('Профессор'),
('Доцент')

--Ющенко
create table UniversityHousing_table (
id int IDENTITY (1,1) NOT NUll primary key,
--NameUniversityHousing nvarchar(500) NOT NULL,--поменяли
AddressStreet nvarchar(200) NOT NULL,
AddressNumber int NOT NULL)
insert into UniversityHousing_table
Values 
('Дворянская',2),
('Французький Бульвар',24)

--Ющенко
create table UniversityTime_table(
id int IDENTITY (1,1) NOT NULL primary key,
NumberCouple int NOT NULL,
StartCouple time(0) NOT NULL,
EndCouple time(0) NOT NULL,
id_UniversityHousing int foreign key references UniversityHousing_table(id))--дописать

INSERT INTO UniversityTime_table
Values 
(1,'8:00','9:20',1),
(2,'9:40','11:00',2),
(3,'11:10','12:30',1)


--Карташов
create table UniversityFaculty_table(
id int IDENTITY(1,1) not null primary key,
NameFaculty nvarchar(300) NOT NULL,
id_UniversityHousing int foreign key references UniversityHousing_table(id))
insert into UniversityFaculty_table
Values 
('Исторический факультет',2),
('Факультет журналистики, рекламы и издательского дела',2),
('Факультет романо-германской филологии',2),
('Институт математики, экономики и механики',1)

--Карташов
create table LectureHall_table(--Поменяли
id int IDENTITY (1,1) NOT NULL primary key,
id_UniversityHousing int foreign key references UniversityHousing_table(id),
NumberLectureHall nvarchar(10) NOT NULL,
Storey int NOT NULL)
insert into LectureHall_table
Values 
(1,'50',1),
(1,'44',1),
(1,'96',2)

--Ющенко
create table UniversityPulpit_table(
id int IDENTITY (1,1) NOT NULL primary key,
NamePulpit nvarchar (50) NOT NULL,
id_Housing int foreign key references UniversityHousing_table(id),
id_Faculty int foreign key references UniversityFaculty_table(id))
insert into UniversityPulpit_table
Values 
('Кафедра истории древнего мира и средних веков',2,1),
('Кафедра французской филологии',2,3),
('Кафедра теоретической механики',1,3)

--Ющенко
create table UniversityTeachers_table(
id int IDENTITY (1,1) NOT NULL primary key,
TeachersSurname nvarchar (50) NOT NULL,
TeachersName nvarchar (20) NOT NULL,
TeachersPatronymic nvarchar (20) NULL,
id_AcademicDegree int foreign key references  AcademicTitle_table(id),
id_UniversityPulpit int foreign key references UniversityPulpit_table(id))
insert into UniversityTeachers_table
Values 
('Косой','Михаил','Брониславович',1,3),
('Котовский','Григорий','Иванович',1,2),
('Троцкий','Лев','Давидович',1,1)

--Карташов
create table Group_table(--name--потоки--переделать--подгруппы 
id int IDENTITY (1,1) NOT NULL primary key,
NameOfGroup nvarchar(50) NOT NULL,
id_UniversityTeachers int foreign key references UniversityTeachers_table(id),
YearStart int NOT NULL,
YearFinish int NOT NULL,
id_UniversityPulpit int foreign key references UniversityPulpit_table(id),
Subgroup nvarchar(1) NULL,
id_Faculty int foreign key references UniversityFaculty_table(id))
insert into Group_table
Values 
('Механики',1,2014,2018,3,1,4),
('Компьютерные инженеры',2,2015,2019,1,2,1),
('Прикладные математики',1,2016,2020,2,NULL,3)

create table TypeOfSubject_table(
id int IDENTITY (1,1) NOT NULL primary key,
NameOfSubjectType  nvarchar(15) NOT NULL,
)

insert into TypeOfSubject_table
Values 
('Лекция'),
('Практика'),
('Семинар')

create table Schedule_table(
id int IDENTITY (1,1) NOT NULL primary key,
id_Subject int foreign key references Subject_table(id),
id_Group int foreign key references Group_table(id),
id_UniversityTeachers int foreign key references UniversityTeachers_table(id),
id_LectureHall int foreign key references LectureHall_table(id),
id_Day int foreign key references Day_table(id),
id_UniversityTime int foreign key references UniversityTime_table(id) NULL,
id_TypeWeek int foreign key references TypeWeek_table(id) NULL,
id_TypeOfSubject int foreign key references TypeOfSubject_table(id),
isFlow bit NOT NULL
)

insert into Schedule_table
Values 
(1,1,1,1,1,1,1,1,1),
(2,2,2,2,2,2,2,2,0),
(3,3,3,3,3,3,1,3,1)

select UniversityTime_table.NumberCouple ,Group_table.NameOfGroup,UniversityFaculty_table.NameFaculty ,Subject_table.SubjectName,UniversityTeachers_table.TeachersSurname,LectureHall_table.NumberLectureHall,Day_table.NameOfDay,
TypeWeek_table.TypeWeek,TypeOfSubject_table.NameOfSubjectType,isFlow, UniversityTime_table.StartCouple,UniversityTime_table.EndCouple from Schedule_table
left join Subject_table on Subject_table.id = Schedule_table.id_Subject
left join Group_table on Group_table.id = Schedule_table.id_Group
left join UniversityTeachers_table on UniversityTeachers_table.id = Schedule_table.id_UniversityTeachers
left join LectureHall_table on LectureHall_table.id = Schedule_table.id_LectureHall
left join Day_table on Day_table.id = Schedule_table.id_Day
left join UniversityTime_table on UniversityTime_table.id = Schedule_table.id_UniversityTime
left join TypeWeek_table on TypeWeek_table.id = Schedule_table.id_TypeWeek
left join TypeOfSubject_table on TypeOfSubject_table.id = Schedule_table.id_TypeOfSubject
left join UniversityFaculty_table on UniversityFaculty_table.id = Group_table.id_Faculty
