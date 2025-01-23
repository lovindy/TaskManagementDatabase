CREATE PROCEDURE sp_CreateTask
    @ListId UNIQUEIDENTIFIER,
    @Title VARCHAR(255),
    @Description VARCHAR(MAX),
    @DueDate DATETIME,
    @Priority INT,
    @CreatedBy UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Get the next position
    DECLARE @Position INT;
    SELECT @Position = ISNULL(MAX(Position), 0) + 1
    FROM Tasks
    WHERE ListId = @ListId;

    INSERT INTO Tasks (
        ListId, Title, Description, 
        DueDate, Priority, CreatedBy, Position
    )
    OUTPUT INSERTED.TaskId
    VALUES (
        @ListId, @Title, @Description, 
        @DueDate, @Priority, @CreatedBy, @Position
    );
END;