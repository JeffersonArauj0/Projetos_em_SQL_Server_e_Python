-- Consulta em todos os bancos SQL Server, exceto os padrões do sistema
-- Realiza um SELECT na tabela fictícia 'TblPermissoes' (schema 'dbo') para bancos que contenham essa tabela

DECLARE @sql NVARCHAR(MAX) = ''
DECLARE @dbname NVARCHAR(255)

-- Tabela e schema fictícios
DECLARE @tabela NVARCHAR(128) = 'TblPermissoes'
DECLARE @schema NVARCHAR(128) = 'dbo'

-- Cursor para percorrer todos os bancos exceto os padrões
DECLARE db_cursor CURSOR FOR
SELECT name 
FROM sys.databases 
WHERE state_desc = 'ONLINE' 
  AND name NOT IN ('master', 'tempdb', 'model', 'msdb')

OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @dbname

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @sql += '
    IF EXISTS (
        SELECT 1 
        FROM ' + QUOTENAME(@dbname) + '.INFORMATION_SCHEMA.TABLES 
        WHERE TABLE_NAME = ''' + @tabela + ''' AND TABLE_SCHEMA = ''' + @schema + '''
    )
    BEGIN
        SELECT 
            ''' + @dbname + ''' AS NomeBanco,
            AcaoRealizada, 
            NomeUsuario, 
            PermitExclisaoItemPed, PermitInclusao, PermitAlteracao, PermitExclusao
        FROM ' + QUOTENAME(@dbname) + '.' + QUOTENAME(@schema) + '.' + QUOTENAME(@tabela) + '
        WHERE ModuloSistema = ''PedidoDeVenda'' AND AcaoRealizada = 1
    END
    '

    FETCH NEXT FROM db_cursor INTO @dbname
END

CLOSE db_cursor
DEALLOCATE db_cursor

-- Executa o SQL final gerado dinamicamente
EXEC sp_executesql @sql
