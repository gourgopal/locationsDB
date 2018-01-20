CREATE PROCEDURE [LOC].[Location_INSERT]
(
@ID int output,
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
		INSERT INTO [loc].[locations]
			([place_name],
			[region_name],
			[latitude],
			[longitude])
		VALUES
			(@place_name,
			@region,
			@latitute,
			@longitute)
		Set @ID = SCOPE_IDENTITY();
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

