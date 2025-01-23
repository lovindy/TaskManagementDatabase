CREATE TABLE [dbo].[Boards] (
    [BoardId]     UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Title]       VARCHAR (100)    NOT NULL,
    [Description] VARCHAR (MAX)    NULL,
    [CreatedBy]   UNIQUEIDENTIFIER NOT NULL,
    [CreatedAt]   DATETIME         DEFAULT (getdate()) NULL,
    [UpdatedAt]   DATETIME         DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([BoardId] ASC),
    FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[Users] ([UserId])
);

