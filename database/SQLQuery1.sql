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

CREATE TABLE Board_Columns (
	id varchar(100) NOT NULL,
	column_name varchar(100) NOT NULL,

	CONSTRAINT pk_Columns_id PRIMARY KEY (id)
);


COMMIT TRANSACTION;