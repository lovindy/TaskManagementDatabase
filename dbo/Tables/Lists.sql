CREATE TABLE [dbo].[Lists] (
    [ListId]    UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [BoardId]   UNIQUEIDENTIFIER NOT NULL,
    [Title]     VARCHAR (100)    NOT NULL,
    [Position]  INT              NOT NULL,
    [CreatedAt] DATETIME         DEFAULT (getdate()) NULL,
    [UpdatedAt] DATETIME         DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([ListId] ASC),
    FOREIGN KEY ([BoardId]) REFERENCES [dbo].[Boards] ([BoardId])
);


GO
CREATE NONCLUSTERED INDEX [IX_Lists_BoardId]
    ON [dbo].[Lists]([BoardId] ASC);

