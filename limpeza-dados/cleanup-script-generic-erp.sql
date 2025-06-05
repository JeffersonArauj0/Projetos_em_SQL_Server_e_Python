/*
===============================================================================
Script:     Data Cleanup Script – Generic ERP Example
Versão:     1.0
Autor:      Jefferson Araujo
Descrição:  Script de limpeza de dados em tabelas relacionadas, com controle de triggers.
===============================================================================
*/

-- Exclui registros específicos e depois trunca dados principais
DELETE FROM tbl_movimentos WHERE CodRel IN (SELECT CodRel FROM tbl_itens) AND TipoMov = 3;
TRUNCATE TABLE tbl_movimentos;
TRUNCATE TABLE tbl_itens;
TRUNCATE TABLE tbl_historico_pedidos;
TRUNCATE TABLE tbl_parcelas_pedidos;

-- Limpa itens vinculados a pedidos inexistentes
DELETE FROM tbl_itens_caixa WHERE PedidoID IN (SELECT PedidoID FROM tbl_pedidos)
    OR PedidoID NOT IN (SELECT PedidoID FROM tbl_pedidos);

IF NOT EXISTS (SELECT 1 FROM tbl_itens_caixa WHERE ID >= 1)
BEGIN
    TRUNCATE TABLE tbl_itens_caixa;
END;

-- Limpa histórico de caixa vinculado a pedidos inválidos
DELETE FROM tbl_historico_caixa WHERE CaixaID IN (SELECT CaixaID FROM tbl_caixa)
    OR CaixaID NOT IN (SELECT CaixaID FROM tbl_caixa);

IF NOT EXISTS (SELECT 1 FROM tbl_historico_caixa WHERE ID >= 1)
BEGIN
    TRUNCATE TABLE tbl_historico_caixa;
END;

-- Desabilita triggers temporariamente
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'TRG_DeleteCaixaLog')
BEGIN
    DISABLE TRIGGER TRG_DeleteCaixaLog ON tbl_caixa;
END;

IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'TRG_LogCaixa')
BEGIN
    DISABLE TRIGGER TRG_LogCaixa ON tbl_caixa;
END;

-- Limpa registros de caixa inválidos
DELETE FROM tbl_caixa WHERE PedidoID IN (SELECT PedidoID FROM tbl_pedidos)
    OR PedidoID NOT IN (SELECT PedidoID FROM tbl_pedidos);

IF NOT EXISTS (SELECT 1 FROM tbl_caixa WHERE CaixaID >= 1)
BEGIN
    TRUNCATE TABLE tbl_caixa;
END;

-- Reabilita triggers
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'TRG_LogCaixa')
BEGIN
    ENABLE TRIGGER TRG_LogCaixa ON tbl_caixa;
END;

IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'TRG_DeleteCaixaLog')
BEGIN
    ENABLE TRIGGER TRG_DeleteCaixaLog ON tbl_caixa;
END;

-- Limpa tabela de deletados
TRUNCATE TABLE tbl_caixa_deletados;

-- Remove notas fiscais sem pedidos válidos
DELETE FROM tbl_notas_saida WHERE PedidoID IN (SELECT PedidoID FROM tbl_pedidos)
    OR PedidoID NOT IN (SELECT PedidoID FROM tbl_pedidos);

IF NOT EXISTS (SELECT 1 FROM tbl_notas_saida WHERE NotaID >= 1)
BEGIN
    TRUNCATE TABLE tbl_notas_saida;
END;

DELETE FROM tbl_itens_nota_saida WHERE PedidoID IN (SELECT PedidoID FROM tbl_pedidos)
    OR PedidoID NOT IN (SELECT PedidoID FROM tbl_pedidos);

IF NOT EXISTS (SELECT 1 FROM tbl_itens_nota_saida WHERE NotaID >= 1)
BEGIN
    TRUNCATE TABLE tbl_itens_nota_saida;
END;

-- Remove todos os pedidos
DELETE FROM tbl_pedidos;

-- Limpa mensagens e eventos relacionados a notas
DELETE FROM tbl_mensagens_nf WHERE NotaID NOT IN (SELECT NotaID FROM tbl_notas_saida)
    OR NotaID IN (SELECT NotaID FROM tbl_notas_saida);

IF NOT EXISTS (SELECT 1 FROM tbl_mensagens_nf WHERE NotaID >= 1)
BEGIN
    TRUNCATE TABLE tbl_mensagens_nf;
END;

DELETE FROM tbl_eventos_nf WHERE NotaID NOT IN (SELECT NotaID FROM tbl_notas_saida)
    OR NotaID IN (SELECT NotaID FROM tbl_notas_saida);

IF NOT EXISTS (SELECT 1 FROM tbl_eventos_nf WHERE NotaID >= 1)
BEGIN
    TRUNCATE TABLE tbl_eventos_nf;
END;

-- Limpa correções e NF espelhadas
DELETE FROM tbl_correcoes WHERE NotaID NOT IN (SELECT NotaID FROM tbl_notas_saida)
    OR NotaID IN (SELECT NotaID FROM tbl_notas_saida);

IF NOT EXISTS (SELECT 1 FROM tbl_correcoes WHERE ID >= 1)
BEGIN
    TRUNCATE TABLE tbl_correcoes;
END;

DELETE FROM tbl_nf_espelho WHERE NotaID NOT IN (SELECT NotaID FROM tbl_notas_saida)
    OR NotaID IN (SELECT NotaID FROM tbl_notas_saida);

IF NOT EXISTS (SELECT 1 FROM tbl_nf_espelho WHERE ID >= 1)
BEGIN
    TRUNCATE TABLE tbl_nf_espelho;
END;

-- Tabelas auxiliares
TRUNCATE TABLE tbl_fornecedores_produtos;
TRUNCATE TABLE tbl_lotes_produtos;
TRUNCATE TABLE tbl_mov_lotes;
TRUNCATE TABLE tbl_itens_compras;
TRUNCATE TABLE tbl_compras;

-- Tabelas de ordens de produção
TRUNCATE TABLE tbl_ordem_fabricacao;
TRUNCATE TABLE tbl_ordem_entrada;
TRUNCATE TABLE tbl_ordem_saida;
TRUNCATE TABLE tbl_ordem_periodo;

-- Outras tabelas auxiliares
TRUNCATE TABLE tbl_codigos_barras;
TRUNCATE TABLE tbl_alternativas_produto;
TRUNCATE TABLE tbl_complementos_venda;
TRUNCATE TABLE tbl_kits_produtos;

-- Limpa tabela final de produtos
DELETE FROM tbl_produtos;

IF NOT EXISTS (SELECT 1 FROM tbl_produtos WHERE ID >= 1)
BEGIN
    TRUNCATE TABLE tbl_produtos;
END;