-------------
-- CLIENTE --
-------------

INSERT INTO DWCFB.dbo.Cliente
SELECT 
    NEWID(), 
    c.ID_cliente, 
    c.nome,
	GETDATE() as data_inicio,
	NULL as data_fim
FROM DBCFB.dbo.Cliente c;


-----------------
-- MEDICAMENTO --
-----------------

INSERT INTO DWCFB.dbo.Medicamento
SELECT 
	NEWID(), 
	m.ID_medicamento,
	m.nome,
	m.preco,
	GETDATE() as data_inicio,
	NULL as data_fim
FROM DBCFB.dbo.Medicamento m


---------------
-- CATEGORIA --
---------------

INSERT INTO DWCFB.dbo.Categoria
SELECT 
	NEWID(), 
	cat.ID_categoria,
	cat.nome,
	GETDATE() as data_inicio,
	NULL as data_fim
FROM DBCFB.dbo.Categoria cat


----------------
-- FORNECEDOR --
----------------

INSERT INTO DWCFB.dbo.Fornecedor
SELECT 
	NEWID(), 
	f.ID_fornecedor,
	f.nome,
	GETDATE() as data_inicio,
	NULL as data_fim
FROM DBCFB.dbo.Fornecedor f


--------------
-- Endereco --
-------------- 

INSERT INTO DWCFB.dbo.Endereco
SELECT 
	NEWID(), 
	e.cep,
	e.logradouro,
	e.numero,
	e.bairro,
	e.uf,
	e.cidade,
	NULL,
	GETDATE(),
	NULL
FROM DBCFB.dbo.Endereco e


---------
-- Dia --
---------

INSERT INTO DWCFB.dbo.Dia
SELECT 
	NEWID(), 
	-- id dia?
	p.data,
	DATENAME(dw, p.data) as 'DiaSemana',
	DAY(p.data) as 'DiaMes',
	MONTH(p.data) as 'Mes',
	YEAR(p.data) as 'Ano'
FROM DBCFB.dbo.Pedido p


-------------
-- Receita --
-------------

SELECT 
	ped.ID_pedido,
	SUM(db_med.preco * iem.quantidade) as 'Valor',
	SUM(iem.quantidade) as 'UnidadesVendidas',
	dw_f.ChaveFornecedor
FROM DBCFB.dbo.Pedido ped
	JOIN DBCFB.dbo.incluido_em iem
		ON ped.ID_pedido = iem.ID_pedido
	JOIN DBCFB.dbo.Medicamento db_med
		ON db_med.ID_medicamento = iem.ID_medicamento
	JOIN DBCFB.dbo.Fornecedor db_f
		ON db_f.ID_fornecedor = db_med.ID_fornecedor
	JOIN DWCFB.dbo.Fornecedor dw_f
		ON dw_f.IDFornecedor = db_f.ID_fornecedor
GROUP BY ped.ID_pedido
