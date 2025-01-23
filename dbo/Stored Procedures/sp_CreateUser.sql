CREATE   PROCEDURE sp_CreateUser
    @Username VARCHAR(255),
    @PasswordHash VARCHAR(MAX),
    @UserId UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRANSACTION;
    
    BEGIN TRY
        SET @UserId = NEWID();
        
        -- Create user
        INSERT INTO Users (UserId, Username, PasswordHash, IsActive, CreatedAt, UpdatedAt)
        VALUES (@UserId, @Username, @PasswordHash, 1, GETDATE(), GETDATE());
        
        -- Create default board
        DECLARE @BoardId UNIQUEIDENTIFIER = NEWID();
        
        -- Insert the board
        INSERT INTO Boards (
            BoardId,
            Title,
            Description,
            CreatedBy,
            CreatedAt,
            UpdatedAt
        )
        VALUES (
            @BoardId,
            'My Board',
            'My Personal Board',
            @UserId,
            GETDATE(),
            GETDATE()
        );

        -- Insert board membership (making the user an owner)
        INSERT INTO BoardMembers (
            BoardId,
            UserId,
            Role,
            JoinedAt
        )
        VALUES (
            @BoardId,
            @UserId,
            'Owner',
            GETDATE()
        );

        -- Create default lists
        INSERT INTO Lists (
            ListId,
            BoardId,
            Title,
            Position,
            CreatedAt,
            UpdatedAt
        )
        VALUES 
            (NEWID(), @BoardId, 'To Do', 1, GETDATE(), GETDATE()),
            (NEWID(), @BoardId, 'Doing', 2, GETDATE(), GETDATE()),
            (NEWID(), @BoardId, 'Done', 3, GETDATE(), GETDATE());
        
        COMMIT TRANSACTION;
        RETURN 0;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
        RETURN 1;
    END CATCH
END