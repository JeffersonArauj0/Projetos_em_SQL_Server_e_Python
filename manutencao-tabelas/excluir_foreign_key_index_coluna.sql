IF EXISTS (SELECT * FROM sys.indexes WHERE name LIKE 'IDX_PedidoDemo_Coluna%' AND object_id = OBJECT_ID('[dbo].[PedidoDemo]'))
BEGIN
    DROP INDEX IDX_PedidoDemo_Coluna ON PedidoDemo
END