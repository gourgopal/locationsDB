/****** Script for SelectTopNRows command from SSMS  ******/
SELECT * FROM [XYZ].[loc].[locations_postal] lp
INNER JOIN [loc].[locations] l ON lp.City_ID = l.ID
where l.place_name = 'Delhi'

SELECT l.place_name, COUNT(postal_code) "total pin code" FROM [XYZ].[loc].[locations_postal] lp
INNER JOIN [loc].[locations] l ON lp.City_ID = l.ID
GROUP BY l.place_name
having COUNT(postal_code) > 1
