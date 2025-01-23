
-- Get User By Username
CREATE PROCEDURE sp_GetUserByUsername
    @Username VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT UserId, Username, PasswordHash, IsActive, CreatedAt, UpdatedAt
    FROM Users
    WHERE Username = @Username;
END;
