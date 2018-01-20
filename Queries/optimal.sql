DECLARE
    @p1 DECIMAL(12, 9),
    @p2 DECIMAL(12, 9),
    @p3 DECIMAL(12, 9),
    @p4 DECIMAL(12, 9)

SELECT @p1 = latitude, @p2 = longitude FROM loc.locations WHERE place_name = 'Mumbai';
SELECT @p3 = latitude, @p4 = longitude FROM loc.locations WHERE place_name = 'Delhi';
select dbo.FN_CalcAerialDistance (@p1,  @p2, @p3, @p4)
select latitude, longitude FROM loc.locations WHERE place_name IN ('Delhi', 'Mumbai');
