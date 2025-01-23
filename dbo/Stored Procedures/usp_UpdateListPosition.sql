CREATE PROCEDURE usp_UpdateListPosition
    @ListId UNIQUEIDENTIFIER,
    @NewPosition INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRANSACTION;
    
    BEGIN TRY
        DECLARE @BoardId UNIQUEIDENTIFIER;
        DECLARE @CurrentPosition INT;
        
        -- Get the current position and board ID of the list
        SELECT 
            @CurrentPosition = Position,
            @BoardId = BoardId
        FROM Lists 
        WHERE ListId = @ListId;
        
        IF @CurrentPosition IS NULL
            THROW 50000, 'List not found', 1;
            
        IF @CurrentPosition > @NewPosition
        BEGIN
            -- Moving up - increment positions of lists in between
            UPDATE Lists
            SET 
                Position = Position + 1,
                UpdatedAt = GETDATE()
            WHERE 
                BoardId = @BoardId
                AND Position >= @NewPosition 
                AND Position < @CurrentPosition;
        END
        ELSE IF @CurrentPosition < @NewPosition
        BEGIN
            -- Moving down - decrement positions of lists in between
            UPDATE Lists
            SET 
                Position = Position - 1,
                UpdatedAt = GETDATE()
            WHERE 
                BoardId = @BoardId
                AND Position > @CurrentPosition 
                AND Position <= @NewPosition;
        END
        
        -- Update the position of the target list
        UPDATE Lists
        SET 
            Position = @NewPosition,
            UpdatedAt = GETDATE()
        WHERE ListId = @ListId;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END