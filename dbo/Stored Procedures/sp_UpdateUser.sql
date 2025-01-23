
-- Update User
CREATE PROCEDURE sp_UpdateUser
    @UserId UNIQUEIDENTIFIER,
    @Username VARCHAR(255),
    @IsActive BIT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Users
    SET 
        Username = @Username,
        IsActive = @IsActive,
        UpdatedAt = GETDATE()
    WHERE UserId = @UserId;
END;
