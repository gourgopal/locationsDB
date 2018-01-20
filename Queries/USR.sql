CREATE SCHEMA USR 

CREATE TABLE [USR].[USERS]
(
[ID] int IDENTITY(1,1) PRIMARY KEY,
[USER_ID] VARCHAR(200) UNIQUE,
[PASSWORD] VARCHAR(200),
[STATUS] BIT DEFAULT 1
)

CREATE TABLE [HISTORY].[USERS]
(
[ID] int IDENTITY(1,1) PRIMARY KEY,
[USER_ID] VARCHAR(200),
[history_by] VARCHAR(200) DEFAULT ORIGINAL_LOGIN(),
[history_type] VARCHAR(2),
[history_when] datetime DEFAULT GETDATE()
)

GO
CREATE TRIGGER [USR].[USERS_history_INSERT] on [USR].[USERS] FOR INSERT
AS
INSERT INTO [history].[USERS] ([USER_ID], history_type) VALUES ((select [USER_ID] from INSERTED), 'IN')
GO
CREATE TRIGGER [USR].[USERS_history_UPDATE] on [USR].[USERS] FOR UPDATE
AS
INSERT INTO [history].[USERS] ([USER_ID], history_type) VALUES ((select [USER_ID] from INSERTED), 'UP')
GO
CREATE TRIGGER [USR].[USERS_history_DELETE] on [USR].[USERS] FOR DELETE
AS
INSERT INTO [history].[USERS] ([USER_ID], history_type) VALUES ((select [USER_ID] from deleted), 'DE')
GO

CREATE TABLE [USR].[USERS_DATA]
(
[ID] int IDENTITY(1,1) PRIMARY KEY,
[UID] int,
[F_NAME] VARCHAR(50),
[M_NAME] VARCHAR(50),
[L_NAME] VARCHAR(50),
[EMAIL] VARCHAR(100),
[PHONE] NUMERIC(10,0),
[PID] int
)
CREATE TABLE [HISTORY].[USERS_DATA]
(
[ID] int IDENTITY(1,1) PRIMARY KEY,
[UID] int,
[history_by] VARCHAR(200) DEFAULT ORIGINAL_LOGIN(),
[history_type] VARCHAR(2),
[history_when] datetime DEFAULT GETDATE()
)

GO
CREATE TRIGGER [USR].[USERS_DATA_history_INSERT] on [USR].[USERS] FOR INSERT
AS
INSERT INTO [history].[USERS_DATA] ([UID], history_type) VALUES ((select [UID] from INSERTED), 'IN')
GO
CREATE TRIGGER [USR].[USERS_DATA_history_UPDATE] on [USR].[USERS] FOR UPDATE
AS
INSERT INTO [history].[USERS_DATA] ([UID], history_type) VALUES ((select [UID] from INSERTED), 'UP')
GO
CREATE TRIGGER [USR].[USERS_DATA_history_DELETE] on [USR].[USERS] FOR DELETE
AS
INSERT INTO [history].[USERS_DATA] ([UID], history_type) VALUES ((select [UID] from DELETED), 'DE')
GO

CREATE TABLE [USR].[USERS_MONEY]
(
[ID] int IDENTITY(1,1) PRIMARY KEY,
[UID] int,
[MONEY] money
)
CREATE TABLE [HISTORY].[USERS_MONEY]
(
[ID] int IDENTITY(1,1) PRIMARY KEY,
[UID] int,
[history_by] VARCHAR(200) DEFAULT ORIGINAL_LOGIN(),
[history_type] VARCHAR(2),
[history_when] datetime DEFAULT GETDATE()
)

GO
CREATE TRIGGER [USR].[USERS_MONEY_history_INSERT] on [USR].[USERS_MONEY] FOR INSERT
AS
INSERT INTO [history].[USERS_DATA] ([UID], history_type) VALUES ((select [ID] from INSERTED), 'IN')
GO
CREATE TRIGGER [USR].[USERS_MONEY_history_UPDATE] on [USR].[USERS_MONEY] FOR UPDATE
AS
INSERT INTO [history].[USERS_DATA] ([UID], history_type) VALUES ((select [ID] from INSERTED), 'UP')
GO
CREATE TRIGGER [USR].[USERS_MONEY_history_DELETE] on [USR].[USERS_MONEY] FOR DELETE
AS
INSERT INTO [history].[USERS_DATA] ([UID], history_type) VALUES ((select [ID] from DELETED), 'DE')
GO

CREATE TABLE [USR].[TRANSACTIONS]
(
[TID] int IDENTITY(1,1) PRIMARY KEY,
[UID] int NOT NULL,
[AMOUNT] money,
[TYPE] VARCHAR(2) CHECK ([TYPE] = 'CR' OR [TYPE] = 'DR'),
[TIME] DATETIME DEFAULT GETDATE(),
[STATUS] CHAR DEFAULT 'P' CHECK ([STATUS] = 'S' OR [STATUS] = 'F' OR [STATUS] = 'P') --SUCCESS/FAIL/PENDING
)