CREATE PROCEDURE [LOC].[Location_UPDATE]
(
@ID int,
@place_name VARCHAR(200),
@region VARCHAR(200),
@latitute DECIMAL(12,9),
@longitute DECIMAL(12,9)
)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION loc_in;

	BEGIN TRY
		UPDATE [loc].[locations]
			SET [place_name] = @place_name,
				[region_name] = @region,
				[latitude] = @latitute,
				[longitude] = @longitute
			WHERE
				[ID] = @ID
	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION loc_in;
		END
	END CATCH
	COMMIT TRANSACTION
END;
GO

