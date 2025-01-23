
CREATE PROCEDURE sp_GetBoardMembers
    @BoardId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        bm.BoardId,
        bm.UserId,
        bm.Role,
        bm.JoinedAt,
        u.Username,
        u.IsActive
    FROM BoardMembers bm
    JOIN Users u ON bm.UserId = u.UserId
    WHERE bm.BoardId = @BoardId;
END
