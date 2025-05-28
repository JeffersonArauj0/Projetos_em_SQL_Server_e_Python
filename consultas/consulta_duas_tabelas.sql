SELECT P.Pedido AS Pedido, P.DT_Data, P.Livro AS Livro, C.Nome AS Nome,
    P.ValTotal, P.Vago7
FROM PedidoDemo P
LEFT JOIN ClienteDemo C ON P.CGCCPF = C.CGC2
WHERE (P.DT_Data BETWEEN '20240101' AND '20241231') AND P.Situacao = '2'