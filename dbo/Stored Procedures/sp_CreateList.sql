
-- Procedure to create list
CREATE PROCEDURE sp_CreateList
    @BoardId UNIQUEIDENTIFIER,
    @Title VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Get the next position
    DECLARE @Position INT;
    SELECT @Position = ISNULL(MAX(Position), 0) + 1
    FROM Lists
    WHERE BoardId = @BoardId;

    -- Insert the new list
    INSERT INTO Lists (
        BoardId,
        Title,
        Position
    )
    OUTPUT INSERTED.ListId
    VALUES (
        @BoardId,
        @Title,
        @Position
    );
END;
