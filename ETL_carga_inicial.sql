-- Cliente --

-- INSERT INTO DwCFB.dbo.Cliente
SELECT 
    NEWID(), 
    c.ID_cliente, 
    c.nome
FROM DBCFB.dbo.Cliente c;

-- Medicamento --

-- INSERT INTO DwCFB.dbo.Medicamento
SELECT 
	NEWID(), 
	m.ID_medicamento,
	m.nome,
	m.preco
FROM DBCFB.dbo.Medicamento m

-- Categoria --

-- INSERT INTO DwCFB.dbo.Categoria
SELECT 
	NEWID(), 
	cat.ID_categoria,
	cat.nome
FROM DBCFB.dbo.Categoria cat

