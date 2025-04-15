

USE Group13_iFINANCEDB;
GO

DROP TABLE IF EXISTS TransactionLine;
DROP TABLE IF EXISTS FinanceTransaction;
DROP TABLE IF EXISTS Administrator;
DROP TABLE IF EXISTS NonAdminUser;
DROP TABLE IF EXISTS UserPassword;
DROP TABLE IF EXISTS iFINANCEUser;
DROP TABLE IF EXISTS MasterAccount;
DROP TABLE IF EXISTS GroupTable;
DROP TABLE IF EXISTS AccountCategory;

CREATE TABLE iFINANCEUser(
	ID VARCHAR(50) PRIMARY KEY,
	UsersName VARCHAR(100)
);  

CREATE TABLE UserPassword(
	ID VARCHAR(50) PRIMARY KEY,
	userName VARCHAR(50),
	encryptedPassword VARCHAR (200),
	passwordExpiryTime INT,
	userAccountExpiryDate DATE,
	FOREIGN KEY (ID) REFERENCES iFINANCEUser (ID)
);

CREATE TABLE Administrator(
	ID VARCHAR(50) PRIMARY KEY,
	dateHired DATE,
	dateFinished DATE,
	FOREIGN KEY (ID) REFERENCES iFINANCEUser (ID)
);

CREATE TABLE NonAdminUser(
	ID VARCHAR(50) PRIMARY KEY,
	StreetAddress VARCHAR(150),
	Email VARCHAR(150),
	FOREIGN KEY (ID) REFERENCES iFINANCEUser (ID)
);

CREATE TABLE AccountCategory(
	ID VARCHAR(50) PRIMARY KEY,
	accountName VARCHAR(50),
	accountType VARCHAR(50)
);

CREATE TABLE GroupTable(
	ID VARCHAR(50) PRIMARY KEY,
	groupName VARCHAR(100),
	parent VARCHAR(50), --The nested subgroup (can create hierarchy)
	element VARCHAR(50), --Defines the financial category via AccountCategory (liability, asset, etc.)
	FOREIGN KEY (parent) REFERENCES GroupTable (ID),
	FOREIGN KEY (element) REFERENCES AccountCategory (ID)
);

CREATE TABLE MasterAccount(
	ID VARCHAR(50) PRIMARY KEY,
	name VARCHAR(100),
	openingAmount FLOAT,
	closingAmount FLOAT,
	accountGroup VARCHAR(50),
	FOREIGN KEY (accountGroup) REFERENCES GroupTable (ID)
);

CREATE TABLE FinanceTransaction(
	ID VARCHAR(50) PRIMARY KEY,
	TransactionDate DATE,
	TransactionDescription VARCHAR(250),
	authorID VARCHAR(50),
	FOREIGN KEY (authorID) REFERENCES NonAdminUser (ID)
);

CREATE TABLE TransactionLine(
	ID VARCHAR(50) PRIMARY KEY,
	creditedAmount FLOAT,
	debitAmount FLOAT,
	comment VARCHAR(250),
	transactionID VARCHAR(50),
	firstMasterAccount VARCHAR(50),
	secondMasterAccount VARCHAR(50),
	FOREIGN KEY (transactionID) REFERENCES FinanceTransaction(ID),
	FOREIGN KEY (firstMasterAccount) REFERENCES MasterAccount(ID),
	FOREIGN KEY (secondMasterAccount) REFERENCES MasterAccount(ID)
);





