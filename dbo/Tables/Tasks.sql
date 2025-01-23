CREATE TABLE [dbo].[Tasks] (
    [TaskId]      UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [ListId]      UNIQUEIDENTIFIER NOT NULL,
    [Title]       VARCHAR (255)    NOT NULL,
    [Description] VARCHAR (MAX)    NULL,
    [DueDate]     DATETIME         NULL,
    [Priority]    INT              NULL,
    [Position]    INT              NOT NULL,
    [CreatedBy]   UNIQUEIDENTIFIER NOT NULL,
    [CreatedAt]   DATETIME         DEFAULT (getdate()) NULL,
    [UpdatedAt]   DATETIME         DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([TaskId] ASC),
    FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[Users] ([UserId]),
    FOREIGN KEY ([ListId]) REFERENCES [dbo].[Lists] ([ListId]),
    CONSTRAINT [FK_Tasks_ListId] FOREIGN KEY ([ListId]) REFERENCES [dbo].[Lists] ([ListId]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_Tasks_ListId]
    ON [dbo].[Tasks]([ListId] ASC);

