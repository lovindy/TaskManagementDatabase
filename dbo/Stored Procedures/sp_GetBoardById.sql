CREATE PROCEDURE sp_GetBoardById
@BoardId UNIQUEIDENTIFIER
AS
BEGIN
    SELECT * 
    FROM dbo.Boards 
    WHERE BoardId = @BoardId;
END
