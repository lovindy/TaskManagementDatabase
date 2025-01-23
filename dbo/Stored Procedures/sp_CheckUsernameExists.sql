
-- Check Username Exists
CREATE PROCEDURE sp_CheckUsernameExists
    @Username VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT COUNT(1)
    FROM Users
    WHERE Username = @Username;
END;
