-- Switch to the system (aka master) database
USE master;
GO

-- Delete the TicketingSystem database (IF EXISTS)
DROP DATABASE IF EXISTS TicketingSystem;
GO

-- Create a new TicketingSystem database
CREATE DATABASE TicketingSystem;
GO

-- Switch to the TicketingSystem database
USE TicketingSystem
GO

BEGIN TRANSACTION;

-- Define Columns and PK of tables
CREATE TABLE Users (
	id varchar(100) NOT NULL,
	first_name varchar(100) NOT NULL,
	last_name varchar(100) NOT NULL,
	email varchar(100) NOT NULL,
	password_hash varchar(200) NOT NULL,
	salt varchar(200) NOT NULL,

    CONSTRAINT pk_Users_id PRIMARY KEY (id)
);

CREATE TABLE Boards (
	id varchar(100) NOT NULL,
	board_name varchar(100) NOT NULL,
	board_owner_id varchar(100) NOT NULL,
	is_public bit DEFAULT 0,

	CONSTRAINT pk_Boards_id PRIMARY KEY (id)
)

CREATE TABLE Users_Boards (
	user_id varchar(100) NOT NULL,
	board_id varchar(100) NOT NULL,
	permission varchar(100) NOT NULL,

	CONSTRAINT pk_Users_Boards_user_id_board_id PRIMARY KEY (user_id, board_id),
	CONSTRAINT ck_Users_Boards_permission CHECK (permission in ('viewer', 'commenter', 'editor'))
);

CREATE TABLE Board_Columns (
	id int Identity NOT NULL,
	column_name varchar(100) NOT NULL,

	CONSTRAINT pk_Board_Columns_id PRIMARY KEY (id)
);

CREATE TABLE Cards (
	id varchar(100) NOT NULL,
	board_id varchar(100) NOT NULL,
	column_id varchar(100) NOT NULL,
	assignee varchar(100) ,
	title varchar(150) NOT NULL,
	content varchar(2000),

	CONSTRAINT pk_Cards_id PRIMARY KEY (id)
);


CREATE TABLE Comments (  -- Note, needs time stamp or some other way of ordering comments
	id varchar(100) NOT NULL,
	card_id varchar(100) NOT NULL,
	content varchar(2000) NOT NULL,
	creator_id varchar(100) NOT NULL,

	CONSTRAINT pk_Comments_id PRIMARY KEY (id)
);

CREATE TABLE Card_events (
	id varchar(100) NOT NULL,
	time_stamp datetime NOT NULL,
	card_id varchar(100) NOT NULL,
	user_id varchar(100) NOT NULL,
	column_from varchar(100) NOT NULL,
	column_to varchar(100) NOT NULL,

	CONSTRAINT pk_Card_events_id PRIMARY KEY (id)
);

-- Adding seed data

INSERT INTO Users (id , first_name, last_name, email, password_hash, salt) 
	VALUES ('9be5c977-f96a-4db4-8737-8bc108c0496e',	'Aaron', 'Adelson', 'aaron@aaron.com', '5C3f+YD3kx3mH8TQPRPqRqyqLjo=', 'MW6lnSChV1Q=');  -- password is  1
INSERT INTO Users (id , first_name, last_name, email, password_hash, salt) 
	VALUES ('e836a84f-807b-4a03-afe2-6c36cd704a85',	'Bob', 'Builder', 'bob@bob.com', '0CZpWyZKkTABMliwA/0W1jaYUJE=', 'hYqPM95MXwY='); -- password is  2
INSERT INTO Users (id , first_name, last_name, email, password_hash, salt) 
	VALUES ('81142827-1d4a-48d5-9850-60004acf5a97',	'Carl', 'Clark', 'carl@carl.com', 'BXW4iJxq0+ZTB+ZTx66yTQpQebc=', 'FXhaCioadlQ='); -- password is  3
INSERT INTO Users (id , first_name, last_name, email, password_hash, salt) 
	VALUES ('a8039a5f-1504-46b5-b1ae-22401fe2e14c',	'Doug', 'Digadome', 'doug@doug.com', 'cfpq6XHgRcvX+ckKCgRQX0q6/1s=', '4ZAkChsb+5Q='); -- password is  4

INSERT INTO Boards (id, board_name, board_owner_id) Values ('e2805066-3563-4061-842d-15590c93078c', 'Test Project', '9be5c977-f96a-4db4-8737-8bc108c0496e');
INSERT INTO Boards (id, board_name, board_owner_id, is_public) Values ('665ac248-55e5-4a4f-8701-1d72ec4732ea', 'Test Public', 'e836a84f-807b-4a03-afe2-6c36cd704a85', 1);

INSERT INTO Users_Boards (user_id, board_id, permission ) Values ('e836a84f-807b-4a03-afe2-6c36cd704a85',  'e2805066-3563-4061-842d-15590c93078c', 'editor');
INSERT INTO Users_Boards (user_id, board_id, permission ) Values ('81142827-1d4a-48d5-9850-60004acf5a97',  'e2805066-3563-4061-842d-15590c93078c', 'commenter');
INSERT INTO Users_Boards (user_id, board_id, permission ) Values ('a8039a5f-1504-46b5-b1ae-22401fe2e14c',  'e2805066-3563-4061-842d-15590c93078c', 'viewer');


SET IDENTITY_INSERT Board_Columns ON

INSERT INTO Board_Columns (id, column_name) Values (1, 'Backlog');
INSERT INTO Board_Columns (id, column_name) Values (2, 'Current Sprint');
INSERT INTO Board_Columns (id, column_name) Values (3, 'In Progress');
INSERT INTO Board_Columns (id, column_name) Values (4, 'Ready For Approval');
INSERT INTO Board_Columns (id, column_name) Values (5, 'Completed');

SET IDENTITY_INSERT Board_Columns OFF

INSERT INTO Cards (id, board_id, column_id, assignee, title, content) 
	VALUES ('6a83c782-00e3-47f7-bcde-769d07420298', 'e2805066-3563-4061-842d-15590c93078c', 1, 'Rex', 'Build a backlog', 'do it');
INSERT INTO Cards (id, board_id, column_id,  title) 
	VALUES ('d4fe2e1a-80c4-4109-a0da-f2cc70429857', 'e2805066-3563-4061-842d-15590c93078c', 2, 'Connect API to front end');

INSERT INTO Comments (id, card_id, content, creator_id) 
	VALUES ('4c02d573-4c2e-408b-9c82-7f2f0188ee8c', '6a83c782-00e3-47f7-bcde-769d07420298', 'That sounds like a swell idea', 'a8039a5f-1504-46b5-b1ae-22401fe2e14c');

-- Adding foreign keys

ALTER TABLE Boards 
ADD FOREIGN KEY (board_owner_id)
REFERENCES Users(id);

ALTER TABLE Users_Boards 
ADD FOREIGN KEY (user_id)
REFERENCES Users(id);

ALTER TABLE Users_Boards 
ADD FOREIGN KEY (board_id)
REFERENCES Boards(id)

ALTER TABLE Cards 
ADD FOREIGN KEY (board_id)
REFERENCES Boards(id)

ALTER TABLE Cards 
ADD FOREIGN KEY (column_id)
REFERENCES Board_Columns(id)

ALTER TABLE Comments 
ADD FOREIGN KEY (card_id)
REFERENCES Cards(id)

ALTER TABLE Comments 
ADD FOREIGN KEY (creator_id)
REFERENCES Users(id);

ALTER TABLE Card_events 
ADD FOREIGN KEY (card_id)
REFERENCES Cards(id)

ALTER TABLE Card_events 
ADD FOREIGN KEY (user_id)
REFERENCES Users(id);

COMMIT TRANSACTION;