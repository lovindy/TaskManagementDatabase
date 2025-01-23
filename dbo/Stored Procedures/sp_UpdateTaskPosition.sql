CREATE PROCEDURE sp_UpdateTaskPosition
    @TaskId UNIQUEIDENTIFIER,
    @ListId UNIQUEIDENTIFIER,
    @NewPosition INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRANSACTION;
    
    BEGIN TRY
        -- First verify the target list exists
        IF NOT EXISTS (SELECT 1 FROM Lists WHERE ListId = @ListId)
        BEGIN
            THROW 50001, 'Target list not found', 1;
        END

        DECLARE @CurrentListId UNIQUEIDENTIFIER;
        DECLARE @CurrentPosition INT;
        
        -- Get the current position and list ID of the task
        SELECT 
            @CurrentPosition = Position,
            @CurrentListId = ListId
        FROM Tasks 
        WHERE TaskId = @TaskId;
        
        IF @CurrentPosition IS NULL
            THROW 50000, 'Task not found', 1;
        
        -- If moving to a different list
        IF @CurrentListId != @ListId
        BEGIN
            -- Get the maximum position in the target list
            DECLARE @MaxPosition INT;
            SELECT @MaxPosition = ISNULL(MAX(Position), 0)
            FROM Tasks
            WHERE ListId = @ListId;

            -- If the new position is greater than the maximum position, adjust it
            IF @NewPosition > @MaxPosition + 1
                SET @NewPosition = @MaxPosition + 1;

            -- Decrement positions in the old list
            UPDATE Tasks
            SET 
                Position = Position - 1,
                UpdatedAt = GETDATE()
            WHERE 
                ListId = @CurrentListId
                AND Position > @CurrentPosition;
            
            -- Increment positions in the new list
            UPDATE Tasks
            SET 
                Position = Position + 1,
                UpdatedAt = GETDATE()
            WHERE 
                ListId = @ListId
                AND Position >= @NewPosition;
            
            -- Update the task with new list and position
            UPDATE Tasks
            SET 
                ListId = @ListId,
                Position = @NewPosition,
                UpdatedAt = GETDATE()
            WHERE TaskId = @TaskId;
        END
        ELSE -- Moving within the same list
        BEGIN
            IF @CurrentPosition > @NewPosition
            BEGIN
                -- Moving up
                UPDATE Tasks
                SET 
                    Position = Position + 1,
                    UpdatedAt = GETDATE()
                WHERE 
                    ListId = @ListId
                    AND Position >= @NewPosition 
                    AND Position < @CurrentPosition;
            END
            ELSE IF @CurrentPosition < @NewPosition
            BEGIN
                -- Moving down
                UPDATE Tasks
                SET 
                    Position = Position - 1,
                    UpdatedAt = GETDATE()
                WHERE 
                    ListId = @ListId
                    AND Position > @CurrentPosition 
                    AND Position <= @NewPosition;
            END
            
            -- Update the position of the target task
            UPDATE Tasks
            SET 
                Position = @NewPosition,
                UpdatedAt = GETDATE()
            WHERE TaskId = @TaskId;
        END
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END