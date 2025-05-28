IF EXISTS (SELECT Name FROM dbo.sysobjects WHERE type = 'D' AND name LIKE 'DF__PedidoDemo__ColunaDemo%')
BEGIN
    DECLARE @ObjectName NVARCHAR(100)
    SELECT @ObjectName = OBJECT_NAME([default_object_id]) FROM SYS.COLUMNS WHERE [object_id] = OBJECT_ID('PedidoDemo') AND [name] = 'ColunaDemo';
    EXEC('ALTER TABLE PedidoDemo DROP CONSTRAINT ' + @ObjectName)
END

IF EXISTS (SELECT * FROM Syscolumns WHERE id = OBJECT_ID(N'[dbo].[PedidoDemo]') AND name = 'ColunaDemo')
BEGIN 
    ALTER TABLE PedidoDemo DROP COLUMN ColunaDemo;
END