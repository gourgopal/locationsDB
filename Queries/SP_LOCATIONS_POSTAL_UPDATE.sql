CREATE PROCEDURE [LOC].[locations_postal_UPDATE]
(
@ID int,
@City_ID int,
@postal_code numeric(6,0)
)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION loc_in;

	BEGIN TRY
		UPDATE [loc].[locations_postal]
			SET [City_ID] = @City_ID,
				[postal_code] = @postal_code
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

