CREATE PROCEDURE sp_UpdateTask
    @TaskId UNIQUEIDENTIFIER,
    @Title NVARCHAR(255),
    @Description NVARCHAR(MAX),
    @DueDate DATETIME,
    @Priority INT
AS
BEGIN
    UPDATE Tasks
    SET 
        Title = @Title,
        Description = @Description,
        DueDate = @DueDate,
        Priority = @Priority
    WHERE TaskId = @TaskId;
END;
