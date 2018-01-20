USE [XYZ]
GO

INSERT INTO [loc].[locations] ([place_name] ,[geo]) VALUES ('Sample', (geography::STGeomFromText('LINESTRING(-122.360 47.656, -122.343 47.656 )', 4326)))
GO

select * from [loc].[locations]

