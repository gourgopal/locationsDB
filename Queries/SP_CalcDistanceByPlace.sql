CREATE PROC loc.CalcDistanceByPlace
(
@From VARCHAR(200),
@To VARCHAR(200)
)
AS
BEGIN
	DECLARE
		@p1 DECIMAL(12, 9),
		@p2 DECIMAL(12, 9),
		@p3 DECIMAL(12, 9),
		@p4 DECIMAL(12, 9),
		@cnt1 int,
		@cnt2 int,
		@int1 int = 1,
		@int2 int = 1,
		@pn1 VARCHAR(200),
		@pn2 VARCHAR(200),
		@rn1 VARCHAR(200),
		@rn2 VARCHAR(200)

	DECLARE @data table(From_Place VARCHAR(200), From_Region VARCHAR(200), "To_Place" VARCHAR(200), To_Region VARCHAR(200), Distance decimal(8,2))
	DECLARE @pl1 table(ID int IDENTITY(1,1), place_name VARCHAR(200), region_name VARCHAR(200), latitude decimal(12,9), longitude decimal(12,9))
	DECLARE @pl2 table(ID int IDENTITY(1,1), place_name VARCHAR(200), region_name VARCHAR(200), latitude decimal(12,9), longitude decimal(12,9)) 

	INSERT INTO @pl1 SELECT l.place_name, l.region_name, l.latitude, l.longitude from loc.locations l where place_name like @From
	INSERT INTO @pl2 SELECT l.place_name, l.region_name, l.latitude, l.longitude from loc.locations l where place_name like @To

	SET @cnt1 = (SELECT COUNT (*) from @pl1)
	SET @cnt2 = (SELECT COUNT (*) from @pl2)

	WHILE(@int1 <= @cnt1)
		BEGIN
			SET @int2 = 1
			WHILE(@int2 <= @cnt2)
				BEGIN
					SELECT @rn1 = region_name, @pn1 = place_name, @p1 = latitude, @p2 = longitude FROM @pl1 WHERE ID = @int1;
					SELECT @rn2 = region_name, @pn2 = place_name, @p3 = latitude, @p4 = longitude FROM @pl2 WHERE ID = @int2;
					IF (@p1 <> @p3 and @p2 <> @p4)
					BEGIN
						INSERT INTO @data select @pn1 as "From_Place", @rn1 as "From_Region", @pn2 as "To_Place", @rn2 as "To_Region", loc.FN_CalcAerialDistance(@p1, @p2, @p3, @p4) as "Distance"
					END
					set @int2 = @int2 + 1;
				END
			set @int1 = @int1 + 1
		END
		DECLARE @Distance decimal(8,2) = 0
		if (select COUNT(*) from @data) <> 0
		begin
			select distinct * from @data order by Distance
			SELECT @Distance = Distance from @data
		end
		else
		begin
			select @Distance as "Distance"
		end
		return @Distance;
END