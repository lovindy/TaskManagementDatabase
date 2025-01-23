
-- Deactivate User
CREATE PROCEDURE sp_DeactivateUser
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Users
    SET 
        IsActive = 0,
        UpdatedAt = GETDATE()
    WHERE UserId = @UserId;
END;
