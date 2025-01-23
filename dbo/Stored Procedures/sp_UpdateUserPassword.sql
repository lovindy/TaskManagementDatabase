
-- Update User Password
CREATE PROCEDURE sp_UpdateUserPassword
    @UserId UNIQUEIDENTIFIER,
    @PasswordHash VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Users
    SET 
        PasswordHash = @PasswordHash,
        UpdatedAt = GETDATE()
    WHERE UserId = @UserId;
END;
