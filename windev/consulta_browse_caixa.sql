-- Raiz da Consulta para carregamento de um Browse Registro de Caixa
Select CaixaDemo.Numero, Deposito, DT_Data, DT_DataVen,DT_DataPrev,Movimento,CGCCPF
, (Select Nome From ClienteDemo Where CGC2 = CGCCPF) as NomeCliFor
, Historico, ValorCob, 0, (Select [dbo].[FC_110_JaPago](CaixaDemo.Numero)) as JaPago
, CaixaDemo.Marcado, CaixaDemo.Tipo, CaixaDemo.Svago5, ''
, (Select DescResumida From tipo Where tipo.TIPO = CaixaDemo.Tipo) as TipoPGTO
, CaixaDemo.Estimado, CaixaDemo.Livro
, (Select Mora From Livro Where ContaDemo.Livro = CaixaDemo.Livro) as Mora
, (Select Multa From Livro Where ContaDemo.Livro = CaixaDemo.Livro) as Multa
, (Select DT_DataComp From CHEQ Where CHEQ.NCaixa = CaixaDemo.Numero) as DT_DataComp
, (Select Devol2 From CHEQ Where CHEQ.NCaixa = CaixaDemo.Numero) as Devol2
, (Select DT_Devol2 From CHEQ Where CHEQ.NCaixa = CaixaDemo.Numero) as DT_Devol2  
From CaixaDemo  

-- Filtros: Registros Marcados p/ Remessa p/ Banco
	Where (CaixaDemo.ValorCob > 0 and CaixaDemo.ValorPag = 0) 
	And CaixaDemo.Situacao = 1  
	And CaixaDemo.DT_DataDoc between '20240814' and '20240819' 
	And CaixaDemo.Tipo = 3

-- Filtros: Todos
	Where CaixaDemo.Numero > 0

-- Filtros: A Receber
	Where (CaixaDemo.ValorCob > 0 	and CaixaDemo.ValorPag = 0) 
	And CaixaDemo.Situacao = 1  And CaixaDemo.DT_DataDoc 
	between '20240801' and '20240903' And CaixaDemo.Tipo = 3