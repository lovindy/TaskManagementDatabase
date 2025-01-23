
-- Search Users
CREATE PROCEDURE sp_SearchUsers
    @SearchTerm VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT UserId, Username, IsActive, CreatedAt, UpdatedAt
    FROM Users
    WHERE Username LIKE @SearchTerm
    AND IsActive = 1
    ORDER BY Username;
END;
