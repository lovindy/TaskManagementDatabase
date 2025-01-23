CREATE PROCEDURE usp_GetBoardLists
    @BoardId uniqueidentifier
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ListId,
        BoardId,
        Title,
        Position,
        CreatedAt,
        UpdatedAt
    FROM Lists
    WHERE BoardId = @BoardId
    ORDER BY Position;
END