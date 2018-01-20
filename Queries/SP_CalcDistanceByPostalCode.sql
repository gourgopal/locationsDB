ALTER PROC loc.CalcDistanceByPostalCode
(
@From VARCHAR(10),
@To VARCHAR(10)
)
AS
BEGIN
	DECLARE @data table(From_Place VARCHAR(200), From_Region VARCHAR(200), "To_Place" VARCHAR(200), To_Region VARCHAR(200), Distance decimal(8,2))
	DECLARE @postal1 table(ID int IDENTITY(1,1), place_name VARCHAR(200), region_name VARCHAR(200), latitude decimal(12,9), longitude decimal(12,9))
	DECLARE @postal2 table(ID int IDENTITY(1,1), place_name VARCHAR(200), region_name VARCHAR(200), latitude decimal(12,9), longitude decimal(12,9)) 

	INSERT INTO @postal1 SELECT distinct l.place_name, l.region_name, l.latitude, l.longitude from loc.locations l cross join loc.locations_postal lp where postal_code like @From and lp.city_id = l.ID
	INSERT INTO @postal2 SELECT distinct l.place_name, l.region_name, l.latitude, l.longitude from loc.locations l cross join loc.locations_postal lp where postal_code like @To and lp.city_id = l.ID

	INSERT INTO @data 
	SELECT
		t1.place_name,	t1.region_name, t2.place_name, t2.region_name,
		loc.FN_CalcAerialDistance(t1.latitude, t1.longitude, t2.latitude, t2.longitude) -- Function calculates Distance
	FROM @postal1 as t1
	CROSS JOIN @postal2 as t2
	WHERE t1.latitude <> t2.latitude and t1.longitude <> t2.longitude

	DECLARE @Distance decimal(8,2) = 0
	select * from @data order by Distance desc
	SELECT @Distance = Distance from @data
	return @Distance;
END