
-- Get User By Id
CREATE PROCEDURE sp_GetUserById
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT UserId, Username, IsActive, CreatedAt, UpdatedAt
    FROM Users
    WHERE UserId = @UserId;
END;
