CREATE TABLE [loc].[locations]
(
[ID] int IDENTITY(1,1) PRIMARY KEY NONCLUSTERED,
[place_name] VARCHAR(200) NOT NULL,
[region_name] VARCHAR(200),
[latitude] DECIMAL(12,9),
[longitude] DECIMAL(12,9)
)

CREATE UNIQUE NONCLUSTERED INDEX IX_locations_name
 ON [loc].[locations] ([place_name], [region_name]);

 CREATE UNIQUE NONCLUSTERED INDEX IX_locations_ll
 ON [loc].[locations] ([latitude], [longitude]);

CREATE TABLE [loc].[locations_postal]
(
[ID] int IDENTITY(1,1) PRIMARY KEY,
[City_ID] int,
[postal_code] NUMERIC(6,0)
)

CREATE UNIQUE NONCLUSTERED INDEX IX_locations_postal
 ON [loc].[locations_postal] ([City_ID], [postal_code]);

CREATE TABLE [history].[locations]
(
[ID] int,
[history_by] VARCHAR(200) DEFAULT ORIGINAL_LOGIN(),
[history_type] VARCHAR(2),
[history_when] datetime DEFAULT GETDATE()
)

CREATE TRIGGER [loc].[locations_history_INSERT] on [loc].[locations] FOR INSERT
AS
INSERT INTO history.locations (ID, history_type) VALUES ((select ID from INSERTED), 'IN')
GO
CREATE TRIGGER [loc].[locations_history_UPDATE] on [loc].[locations] FOR UPDATE
AS
INSERT INTO history.locations (ID, history_type) VALUES ((select ID from INSERTED), 'UP')
GO
CREATE TRIGGER [loc].[locations_history_DELETE] on [loc].[locations] FOR DELETE
AS
INSERT INTO history.locations (ID, history_type) VALUES ((select ID from deleted), 'DE')
GO