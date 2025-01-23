
CREATE PROCEDURE sp_AddBoardMember
    @BoardId UNIQUEIDENTIFIER,
    @UserId UNIQUEIDENTIFIER,
    @Role VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the user is already a member
    IF NOT EXISTS (
        SELECT 1 
        FROM BoardMembers 
        WHERE BoardId = @BoardId AND UserId = @UserId
    )
    BEGIN
        INSERT INTO BoardMembers (BoardId, UserId, Role)
        VALUES (@BoardId, @UserId, @Role);
    END
END
