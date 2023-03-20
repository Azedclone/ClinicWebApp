-- drop database swp;
create database if not exists swp;
use swp;

-- create account table
create table if not exists accounts (
	accountID serial primary key,
    username char(20) unique not null,
    password char(50),
    email char(100),
    avatar varchar(200) default 'default.png',
    accountName varchar(50) charset utf8mb4,
    phone char(15),
    gender int default 0,
    address varchar(333) charset utf8mb4,
    dob date,
    accountRole tinyint not null, -- 3 role: 0-admin, 1-doctor, 2-patient
    accountStatus tinyint not null -- 2 status: 0-N/A, 1-Available
);

insert into accounts(username, password, email, accountName, accountRole, accountStatus) 
			values("admin", "21232F297A57A5A743894A0E4A801FC3", "thanhlongvu156@gmail.com", "Admin", 0, 1);
            
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('flambersen0', 'A14F10A147EF7A7EF9BB5C000F20DC7C', 'flambersen0@gnu.org', 'Faydra Lambersen', '0886595272', 2, '45905 Trailsway Street', '1989-01-04', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('elynett1', '283498DD579957DC9944672560E5B20D', 'elynett1@linkedin.com', 'Ephrem Lynett', '0302461846', 2, '9306 Vahlen Court', '1994-08-08', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('tbleckly2', '1931492AB16E5F73DF1EA2DF30744D6E', 'tbleckly2@instagram.com', 'Troy Bleckly', '0995914906', 1, '7 Forest Dale Lane', '1996-07-15', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('slingley3', '1D04A003D13A2EFF200E55D947812030', 'slingley3@tuttocitta.it', 'Sharona Lingley', '0802441835', 2, '4 Trailsway Junction', '1986-04-16', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('asuddick4', '5C12ECC6338F8128FAC62A8D093C838E', 'asuddick4@google.pl', 'Arnaldo Suddick', '0857430804', 2, '7458 Schiller Alley', '1985-04-26', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('dhaire5', '17D9801B96F10DECA5F878D623EABA77', 'dhaire5@last.fm', 'Dayna Haire', '0932343952', 1, '41 Bluestem Road', '1987-05-29', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('cbarrs6', 'FD6E2DDBD409B4CAFEE64A4959EF622C', 'cbarrs6@wikia.com', 'Candis Barrs', '0929827734', 1, '563 Atwood Pass', '1989-02-05', 1, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('mplet7', 'A3ED0E1A9628317D1466B24F3DD41137', 'mplet7@samsung.com', 'Marcelline Plet', '0842090079', 0, '9476 Bashford Park', '1981-03-30', 1, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('fglynn8', '3E6F8CEF35B1DFEA572B09130BA67A43', 'fglynn8@unc.edu', 'Frayda Glynn', '0908593959', 0, '3703 Hoepker Alley', '1991-07-28', 1, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('cosbidston9', 'D9705A343EF5DC096ABB1205FCFDF527', 'cosbidston9@loc.gov', 'Charita Osbidston', '0325779806', 2, '544 Jay Court', '1995-10-20', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('emillionsa', '912CC906096F791D1B67B6FD46D9DFD2', 'emillionsa@feedburner.com', 'Elicia Millions', '0975414516', 2, '70 Boyd Junction', '1988-04-21', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('bchipmanb', '5281DCDC2760083E720CFE75F93F3EFA', 'bchipmanb@epa.gov', 'Berkie Chipman', '0895856106', 1, '0610 Summer Ridge Junction', '1983-02-12', 1, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('colooneyc', '2339C46F3CF3E1BB9122E86DB0BB1317', 'colooneyc@wunderground.com', 'Cyrillus O''Looney', '0341888576', 1, '14 Amoth Court', '1984-06-05', 1, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('sgodsald', 'A27505E7E42B6890CD5C044C7D6F9FF7', 'sgodsald@cisco.com', 'Shaylah Godsal', '0374037968', 2, '248 Oneill Drive', '1993-04-23', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('tbedlingtone', 'DA5D29C104AE5055A9F312E7BA0D69E7', 'tbedlingtone@upenn.edu', 'Thornton Bedlington', '0997020387', 2, '4 Prentice Junction', '1983-09-19', 1, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('wnergerf', 'D53BE497E7C41DA17AA3BCFA08A9A6E2', 'wnergerf@dion.ne.jp', 'Wadsworth Nerger', '0939845100', 1, '591 Dawn Point', '1983-05-24', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('jemburyg', 'DC981305D36B5BB986942EAD9E5C782D', 'jemburyg@earthlink.net', 'Josepha Embury', '0393256868', 1, '327 Pond Crossing', '1997-07-20', 1, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('lcurlessh', '7C0B7CA5AEEC9ED25E4E9B97B02FFBA8', 'lcurlessh@go.com', 'Lindy Curless', '0367689226', 1, '75614 Crownhardt Avenue', '1983-09-18', 1, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('arosarioi', '02DB3F8C244597F4447621110A43B2CB', 'arosarioi@vinaora.com', 'Abelard Rosario', '0318470037', 2, '939 Bowman Drive', '1999-10-04', 1, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('obesquej', 'DC2E5B5CFEDB84FDFB40D4A90FBBDF75', 'obesquej@diigo.com', 'Olympie Besque', '0331693615', 2, '6 Eliot Crossing', '1984-11-09', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('statnellk', '930721C30674FE5A5950731E23BB839A', 'statnellk@ucsd.edu', 'Sascha Tatnell', '0887946662', 2, '0 Loomis Crossing', '1988-03-26', 1, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('cwaterworthl', 'A5A4545239D4F400919ACFD79B870B9A', 'cwaterworthl@boston.com', 'Clareta Waterworth', '0802164656', 2, '61 Fallview Center', '1997-04-14', 1, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('dwiltonm', '0F103CABE377ED38D913D177B8E47076', 'dwiltonm@wikipedia.org', 'Derrik Wilton', '0387299328', 1, '49 Packers Circle', '1989-02-13', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('goldhamn', '7ECE28F80141E4E2700624B869FBCAD1', 'goldhamn@usatoday.com', 'Gwyneth Oldham', '0337814820', 0, '803 Hauk Court', '1995-05-10', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('jdurnillo', '18C4C159FC4C203B882C9EBE56163BCF', 'jdurnillo@bigcartel.com', 'June Durnill', '0325209755', 2, '3 Helena Hill', '1998-11-21', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('ljallinp', '5E6BD9755E60689F326BF00E17C00432', 'ljallinp@scribd.com', 'Laurette Jallin', '0804572943', 0, '11772 Lunder Junction', '1995-05-01', 1, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('lbellringerq', '81B3AC568B6A22AC3868EE914B23300C', 'lbellringerq@cornell.edu', 'Lydie Bellringer', '0381466005', 1, '077 Mcguire Court', '1998-06-14', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('ssweedr', '4A94A5095B2B36E6C29F990404A581ED', 'ssweedr@simplemachines.org', 'Sigmund Sweed', '0394627570', 0, '8756 Anniversary Hill', '1996-04-12', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('njorons', 'A588F7F78E9F6DF1AEAFABA3F20C7A29', 'njorons@sohu.com', 'Nev Joron', '0866699825', 0, '10 Stuart Circle', '1983-12-20', 2, 1);
insert into accounts (username, password, email, accountName, phone, gender, address, dob, accountRole, accountStatus) values ('lchamleyt', 'EEF6A6023609984989DBB82F885D3DAE', 'lchamleyt@drupal.org', 'Lexy Chamley', '0377339161', 0, '1 Calypso Park', '1995-11-26', 1, 1);

insert into accounts(username, password, accountName, accountRole, accountStatus)
				values("doc","F9F16D97C90D8C6F2CAB37BB6D1F1992", "Gây mê bỏ trốn", 1, 1); -- pass: doctor
insert into accounts(username, password, accountName, accountRole, accountStatus)
				values("pat","B39024EFBC6DE61976F585C8421C6BBA", "Bệnh nhân may mắn", 2, 1); -- pass: patient
                
delimiter $$
create trigger default_name
before insert on accounts
for each row
begin
	if (new.accountRole = 1) 
    then
		set new.accountName = "Gây mê bỏ trốn";
	elseif (new.accountRole = 2)
    then
		set	new.accountName = "Bệnh nhân may mắn";
	end if;
end$$
delimiter ;                

-- create table slots
create table if not exists slots (
	slotID serial primary key,
    slot varchar(12) unique not null
);
insert into slots(slot) values ("Slot 1"), ("Slot 2"), ("Slot 3"), ("Slot 4"), ("Slot 5"), ("Slot 6");

-- create appointment table
create table if not exists appointments (
	appointmentID serial primary key,
    patientID bigint unsigned references accounts(accountID),
    bookedDate datetime,
    slotID bigint unsigned references slots(slotID),
    doctorID bigint unsigned references accounts(accountID),
    sympton varchar(1000) charset utf8mb4 not null,
    message varchar(1000) charset utf8mb4
);

-- create oncall table
create table if not exists oncall (
	doctorID bigint unsigned references accounts(accountID),
    bookedDate datetime,
    slotID bigint unsigned references slots(slotID)
);

delimiter $$
create trigger insert_appointment
after insert on appointments
for each row
begin
	insert into oncall values (new.doctorID, new.bookedDate, new.slotID);
end$$
delimiter ;

insert into appointments (patientID, bookedDate, slotID, doctorID, sympton) values(33, '2023-03-03', 2, 32, 'Headache');

-- create services table
create table if not exists services (
	serviceID serial primary key,
    serviceName varchar(100) charset utf8mb4 unique not null,
    price double not null,
    status tinyint not null -- 0: Disable, 1: Available
);

insert into services (serviceName, price, status) values ('Laser', 10, 1);
insert into services (serviceName, price, status) values ('X-RAY', 20, 1);
insert into services (serviceName, price, status) values ('Endoscopic', 40, 1);

-- create medicines table
create table if not exists medicines (
	medicineID serial primary key,
    medicineName varchar(100) charset utf8mb4 unique not null,
    brand varchar(100) charset utf8mb4,
    description varchar(100) charset utf8mb4
);

insert into medicines (medicineName, brand, description) values ("Thuốc lắc", "VI", "Uống vào là lắc");

-- create categories table for blog
create table if not exists categories (
	categoryID serial primary key,
    categoryName varchar(20) charset utf8mb4
);

insert into categories (categoryName) values ('Casework');
insert into categories (categoryName) values ('Retaining Wall');
insert into categories (categoryName) values ('HVAC');
insert into categories (categoryName) values ('Framing');
insert into categories (categoryName) values ('Masonry');

-- create blogs table
create table if not exists blogs (
	blogID serial primary key,
    title varchar(500) charset utf8mb4 unique not null,
    thumbnails varchar(200) default "default_thumbnails.jpg",
    content text,
    categoryID bigint unsigned references categories(categoryID),
    createdDate datetime default now(),
    authorID bigint unsigned references accounts(accountID),
    status tinyint not null default 0, -- 2 status: 0-pending, 1-approved
    publishedDate datetime
);

insert into blogs (title, content, categoryID, authorID, status) values ('Tarzan Escapes', 'aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec', 3, 3, 1);
insert into blogs (title, content, categoryID, authorID, status) values ('Privilege', 'nec condimentum neque sapien placerat ante nulla justo aliquam', 5, 11, 1);
insert into blogs (title, content, categoryID, authorID, status) values ('In a Year', 'felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl', 5, 11, 1);
insert into blogs (title, content, categoryID, authorID, status) values ('Tyler Perry''s Temptation', 'nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis', 1, 11, 0);
insert into blogs (title, content, categoryID, authorID, status) values ('Last Chance Harvey', 'quisque id justo sit amet sapien', 5, 8, 1);
insert into blogs (title, content, categoryID, authorID, status) values ('Mark of the Cop', 'consequat varius integer ac leo', 3, 29, 0);
insert into blogs (title, content, categoryID, authorID, status) values ('La montana rusa', 'luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus', 1, 13, 1);
insert into blogs (title, content, categoryID, authorID, status) values ('Tom Jones', 'elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu', 3, 30, 1);
insert into blogs (title, content, categoryID, authorID, status) values ('Motorcycle Diaries, The (Diarios de motocicleta)', 'cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi', 2, 10, 0);
insert into blogs (title, content, categoryID, authorID, status) values ('Hard Man, The', 'ut ultrices vel augue vestibulum ante', 1, 25, 0);
insert into blogs (title, content, categoryID, authorID, status) values ('History Is Made at Night', 'nulla tempus vivamus in felis', 2, 11, 0);
insert into blogs (title, content, categoryID, authorID, status) values ('Snow on Tha Bluff', 'libero non mattis pulvinar nulla', 5, 14, 1);
insert into blogs (title, content, categoryID, authorID, status) values ('Room for Romeo Brass, A', 'ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero', 5, 23, 1);
insert into blogs (title, content, categoryID, authorID, status) values ('Billy Elliot', 'ipsum ac tellus semper interdum', 3, 15, 0);
insert into blogs (title, content, categoryID, authorID, status) values ('Doors, The', 'quam pharetra magna ac consequat', 5, 6, 1);

-- create examination table
create table if not exists examinations (
	examinationID serial primary key,
	patientID bigint unsigned references accounts(accountID),
    serviceID bigint unsigned references services(serviceID),
    doctorID bigint unsigned references accounts(accountID),
    createdDate datetime default now(),
    status tinyint not null, -- 0: Not paid, 1: Paid
    result text
);

-- create prescription table
create table if not exists prescriptions (
	prescriptionID serial primary key,
	patientID bigint unsigned references accounts(accountID),
    medicineID bigint unsigned references medicines(medicineID),
    instruction text,
    createdDate datetime default now(),
    doctorID bigint unsigned references accounts(accountID)
);

insert into prescriptions(patientID, medicineID, instruction, doctorID)
				values(33, 1, "Ngày 2 viên đều đặn 1 tháng uống 8 chục viên", 32);
