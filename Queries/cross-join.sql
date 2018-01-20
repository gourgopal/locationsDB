SELECT dbo.fn_calcaerialdistance (x.latitude
                                 ,x.longitude
                                 ,y.latitude
                                 ,y.longitude)
FROM loc.locations as x
CROSS JOIN loc.locations y
WHERE x.place_name = 'Delhi'
  AND y.place_name = 'Mumbai' ;