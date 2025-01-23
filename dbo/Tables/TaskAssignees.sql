CREATE TABLE [dbo].[TaskAssignees] (
    [TaskId]     UNIQUEIDENTIFIER NOT NULL,
    [UserId]     UNIQUEIDENTIFIER NOT NULL,
    [AssignedAt] DATETIME         DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([TaskId] ASC, [UserId] ASC),
    FOREIGN KEY ([TaskId]) REFERENCES [dbo].[Tasks] ([TaskId]),
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);

