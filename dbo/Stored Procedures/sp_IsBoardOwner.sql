CREATE PROCEDURE sp_IsBoardOwner
    @BoardId UNIQUEIDENTIFIER,
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    SELECT COUNT(1)
    FROM BoardMembers
    WHERE BoardId = @BoardId 
    AND UserId = @UserId 
    AND Role = 'Owner';
END;
