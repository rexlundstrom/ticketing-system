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
	id varchar(100) NOT NULL,
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


CREATE TABLE Comments (
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

	CONSTRAINT pk_Comments_id PRIMARY KEY (id)
);


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