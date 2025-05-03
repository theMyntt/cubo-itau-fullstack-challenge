-- For Microsoft SQL Server

IF EXISTS (SELECT 1 FROM sys.databases db WHERE db.name = 'CuboItau_FullstackChallenge')
BEGIN
	PRINT 'DB Already Exists'
END
ELSE
BEGIN
	CREATE DATABASE CuboItau_FullstackChallenge;
END;
GO

USE CuboItau_FullstackChallenge;
GO

-- Do Not Use This In Production
IF EXISTS (SELECT 1 FROM sys.tables tb WHERE tb.name = 'Users')
BEGIN
	DROP TABLE Users;
END;
GO

CREATE TABLE Users(
	Id INTEGER IDENTITY(1,1) NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(255) NOT NULL,
	Participation INTEGER NOT NULL,
	Email NVARCHAR(100) NULL,
	[Password] NVARCHAR(100) NULL,
	PRIMARY KEY (Id)
);
GO

SELECT * FROM dbo.Users;
GO

DELETE FROM dbo.Users;
GO