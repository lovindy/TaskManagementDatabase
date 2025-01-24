CREATE PROCEDURE sp_GetTasksByList
    @ListId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        t.TaskId,
        t.ListId,
        t.Title,
        t.Description,
        t.DueDate,
        t.Priority,
        t.Position,
        t.CreatedAt,
        t.UpdatedAt,
        (
            SELECT
                ta.UserId,
                u.Username
            FROM TaskAssignees ta
            JOIN Users u ON ta.UserId = u.UserId
            WHERE ta.TaskId = t.TaskId
            FOR JSON PATH
        ) AS Assignees
    FROM Tasks t
    WHERE t.ListId = @ListId
    ORDER BY t.Position;
END;