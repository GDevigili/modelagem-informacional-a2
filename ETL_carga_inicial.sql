
-- CLIENTE --

-- INSERT INTO DWCFB.dbo.Cliente
SELECT 
    NEWID(), 
    c.ID_cliente, 
    c.nome
FROM DBCFB.dbo.Cliente c;


-- MEDICAMENTO --

-- INSERT INTO DWCFB.dbo.Medicamento
SELECT 
	NEWID(), 
	m.ID_medicamento,
	m.nome,
	m.preco
FROM DBCFB.dbo.Medicamento m


-- CATEGORIA --

-- INSERT INTO DWCFB.dbo.Categoria
SELECT 
	NEWID(), 
	cat.ID_categoria,
	cat.nome
FROM DBCFB.dbo.Categoria cat


-- FORNECEDOR --

-- INSERT INTO DWCFB.dbo.Fornecedor
SELECT 
	NEWID(), 
	f.ID_fornecedor,
	f.nome
FROM DBCFB.dbo.Fornecedor f


-- Endereco -- 

-- INSERT INTO DWCFB.dbo.Endereco
SELECT 
	NEWID(), 
	e.ID_endereco,
	e.cep,
	e.logradouro,
	e.numero,
	e.bairro,
	e.uf,
	e.cidade
FROM DBCFB.dbo.Endereco e


-- Dia --

-- INSERT INTO DWCFB.dbo.Dia
SELECT 
	NEWID(), 
	-- id dia?
	p.data,
	DATENAME(dw, p.data) as 'DiaSemana',
	DAY(p.data) as 'DiaMes',
	MONTH(p.data) as 'Mes',
	YEAR(p.data) as 'Ano'
FROM DBCFB.dbo.Pedido p