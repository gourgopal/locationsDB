CREATE PROCEDURE locations_postal_INSERT
(
@ID int output,
@City_ID int,
@postal_code numeric(6,0)
)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION loc_in;
	BEGIN TRY
		INSERT INTO [loc].[locations_postal]
			(City_ID, postal_code)
		VALUES
			(@City_ID, @postal_code)
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