CREATE TABLE [dbo].[BoardMembers] (
    [BoardId]  UNIQUEIDENTIFIER NOT NULL,
    [UserId]   UNIQUEIDENTIFIER NOT NULL,
    [Role]     VARCHAR (50)     NOT NULL,
    [JoinedAt] DATETIME         DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([BoardId] ASC, [UserId] ASC),
    FOREIGN KEY ([BoardId]) REFERENCES [dbo].[Boards] ([BoardId]),
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [UQ_BoardMembers_BoardId_UserId] UNIQUE NONCLUSTERED ([BoardId] ASC, [UserId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_BoardMembers_UserId]
    ON [dbo].[BoardMembers]([UserId] ASC);

