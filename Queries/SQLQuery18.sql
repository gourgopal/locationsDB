SELECT
	DISTINCT [city_name] "place_name"
	,[region_name] "region_name"
	,cast([latitude] as decimal(12,9)) "latitude"
	,cast([longitude] as decimal(12,9)) "longitude"
	,cast([zip_code] as numeric(6,0)) "postal_code"
	  --,COUNT(zip_code) "popularity"
  into #temp
  FROM [XYZ].[dbo].[IP2LOCATION] WHERE country_code = 'IN' AND Zip_code <> '-' AND [city_name] like '%Delhi'
  GROUP BY [zip_code],
		[country_code]
      ,[country_name]
      ,[region_name]
      ,[city_name]
      ,[latitude]
      ,[longitude]
	  order by popularity desc

	  
SET IDENTITY_INSERT loc.locations on;	 


 INSERT into loc.locations (id, place_name, region, lat, long) select id, city_name "place_name", region_name "region", cast(latitude as decimal(12,9)) "lat", cast(longitude as decimal(12,9)) "long" from temp order by popularity desc, place_name

 SELECT *FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='TEMP'

 select postal_code, place_name from #temp group by postal_code, place_name where city_name like 'or%'

 ALTER TABLE #TEMP2
 ADD ID INT IDENTITY(1,1) PRIMARY KEY

 SELECT PLACE_NAME, REGION_NAME, LATITUDE, LONGITUDE 
 into #temp2
 FROM #temp
 group by PLACE_NAME, REGION_NAME, LATITUDE, LONGITUDE
 order by region_name, PLACE_NAME

declare @city_id int = 0
declare @ID int = 0
declare @cnt int
declare @cnt2 int
declare @postal_code numeric(6,0)
set @cnt=(select count(*) from #temp2)
declare @int int=1;
declare @city varchar(200)
declare @reg varchar(200)
declare @lat decimal(12,9)
declare @long decimal(12,9)
 while(@int<=@cnt)
	begin
		set @city = (select place_name from #temp2 where id = @int)
		set @reg = (select region_name from #temp2 where id = @int)
		set @lat = (select latitude from #temp2 where id = @int)
		set @long = (select longitude from #temp2 where id = @int)
		EXEC loc.Location_INSERT @city_id output, @city, @reg, @lat, @long
		select postal_code into #temp_city from #temp where place_name = @city
		ALTER TABLE #temp_city ADD ID INT IDENTITY(1,1) PRIMARY KEY
		set @cnt2=(select COUNT(*) from #temp_city)
		declare @in int=1;
		 while(@in<=@cnt2)
			begin
				set @postal_code = (select postal_code from #temp_city where ID = @in)
				EXEC loc.locations_postal_INSERT @ID OUTPUT, @City_ID, @postal_code
				set @in = @in + 1
			END
		drop table #temp_city
		SET @int = @int + 1
	ENd

 










