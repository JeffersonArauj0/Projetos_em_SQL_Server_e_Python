-- Atualiza em lotes de 500 registros
WHILE 1 = 1
BEGIN
    UPDATE TOP (500) PedidoDemo
    SET NumeroLojaDemo = 1
    WHERE NumeroLojaDemo = ''

    IF @@ROWCOUNT = 0
        BREAK
END