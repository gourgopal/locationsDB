SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION loc.FN_CalcAerialDistance
(
	@latitude1 decimal(12,9),
	@longitude1 decimal(12,9),
	@latitude2 decimal(12,9),
	@longitude2 decimal(12,9)
)
RETURNS decimal(8,2)
AS
BEGIN
	DECLARE @DistanceInKilometres decimal(8,2) = 0
	declare @DegToRad decimal(12,9)
	declare @Ans decimal(12,9)
	Declare @dLat Float(18); 
	Declare @dLon Float(18); 
	set @Ans = 0
	if @latitude1 is null or @latitude1 = 0 or @longitude1 is null or @longitude1 = 0 or @latitude2 is
	null or @latitude2 = 0 or @longitude2 is null or @longitude2 = 0
	begin
		return ( @DistanceInKilometres )
	end

	Set @dLat = Radians(@latitude2 - @latitude1);
    Set @dLon = Radians(@longitude2 - @longitude1);
    Set @Ans = Sin(@dLat / 2)  
                 * Sin(@dLat / 2)  
                 + Cos(Radians(@latitude1)) 
                 * Cos(Radians(@latitude2))
                 * Sin(@dLon / 2)  
                 * Sin(@dLon / 2); 
      Set @Ans = 2 * Asin(Min(Sqrt(@Ans))); 

      Set @DistanceInKilometres = 6367.45 * @Ans;

	-- Return the result of the function
	RETURN @DistanceInKilometres

END
GO

