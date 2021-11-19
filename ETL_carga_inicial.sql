
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

