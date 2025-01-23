
CREATE PROCEDURE sp_AssignTask
    @TaskId UNIQUEIDENTIFIER,
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    
    IF NOT EXISTS (
        SELECT 1 
        FROM TaskAssignees 
        WHERE TaskId = @TaskId AND UserId = @UserId
    )
    BEGIN
        INSERT INTO TaskAssignees (TaskId, UserId)
        VALUES (@TaskId, @UserId);
    END;
END;
