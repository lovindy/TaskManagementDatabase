CREATE PROCEDURE sp_GetTaskById
    @TaskId UNIQUEIDENTIFIER
AS
BEGIN
    SELECT 
        TaskId,
        ListId,
        Title,
        Description,
        DueDate,
        Priority,
        CreatedBy,
        CreatedAt,
        UpdatedAt
    FROM Tasks
    WHERE TaskId = @TaskId;
END;
