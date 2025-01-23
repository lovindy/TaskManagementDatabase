CREATE TABLE [dbo].[Users] (
    [UserId]       UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Username]     VARCHAR (255)    NOT NULL,
    [PasswordHash] VARCHAR (MAX)    NOT NULL,
    [IsActive]     BIT              DEFAULT ((1)) NOT NULL,
    [CreatedAt]    DATETIME         DEFAULT (getdate()) NULL,
    [UpdatedAt]    DATETIME         DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC),
    UNIQUE NONCLUSTERED ([Username] ASC)
);

