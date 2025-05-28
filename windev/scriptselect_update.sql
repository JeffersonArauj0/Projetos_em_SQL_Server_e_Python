IF EXISTS (SELECT 1 FROM SelectProdutosDemo WHERE ID_Browse = 1386)
BEGIN
    UPDATE SelectProdutosDemo
    SET ScriptSelect = REPLACE(CAST(ScriptSelect AS VARCHAR(MAX)), ' AS JaPago', ' AS JaPago, '''' AS Restante')
    WHERE ID_Browse = 1386
END