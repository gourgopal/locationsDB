USE [Location]
GO

SELECT [dbo].[FN_CalcAerialDistance]
	(
	   (select latitude from loc.locations where place_name = 'Delhi'),
	   (select longitude from loc.locations where place_name = 'Delhi'),
	   (select latitude from loc.locations where place_name = 'Mumbai'),
	   (select longitude from loc.locations where place_name = 'Mumbai')
	)
GO

   (select * from loc.locations where place_name = 'Sambalpur')
   (select * from loc.locations where ID = 47)

