USE DWCFB;

---------------
-- CATEGORIA --
---------------

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name = N'categoria',
@role_name = NULL,
@supports_net_changes = 1;

DROP TABLE IF EXISTS DWCFB.dbo.staging_dbo_categoria;

declare @S binary(10);
declare @E binary(10);
SET @S = sys.fn_cdc_get_min_lsn('dbo_categoria');
SET @E = sys.fn_cdc_get_max_lsn();
SELECT * INTO DWCFB.dbo.staging_dbo_categoria FROM [cdc].[fn_cdc_get_net_changes_dbo_categoria]
(
@S, @E, 'all'
);


INSERT INTO DWCFB.dbo.Categoria
SELECT 
	NEWID(), 
	cat.ID_categoria,
	cat.nome,
	GETDATE() as data_inicio,
	NULL as data_fim
FROM DWCFB.dbo.staging_dbo_categoria cat;



-------------
-- CLIENTE --
-------------

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name = N'cliente',
@role_name = NULL,
@supports_net_changes = 1;

declare @S binary(10);
declare @E binary(10);
SET @S = sys.fn_cdc_get_min_lsn('dbo_cliente');
SET @E = sys.fn_cdc_get_max_lsn();
SELECT *
INTO DWCFB.dbo.staging_dbo_cliente
FROM
[cdc].[fn_cdc_get_net_changes_dbo_cliente]
(
@S, @E, 'all'
);

INSERT INTO DWCFB.dbo.Cliente
SELECT 
    NEWID(), 
    c.ID_cliente, 
    c.nome,
	GETDATE() as data_inicio,
	NULL as data_fim
FROM DWCFB.dbo.staging_dbo_cliente c;



-----------------
-- MEDICAMENTO --
-----------------

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name = N'medicamento',
@role_name = NULL,
@supports_net_changes = 1;

declare @S binary(10);
declare @E binary(10);
SET @S = sys.fn_cdc_get_min_lsn('dbo_medicamento');
SET @E = sys.fn_cdc_get_max_lsn();
SELECT *
INTO DWCFB.dbo.staging_dbo_medicamento
FROM
[cdc].[fn_cdc_get_net_changes_dbo_medicamento]
(
@S, @E, 'all'
);

INSERT INTO DWCFB.dbo.Medicamento
SELECT 
	NEWID(), 
	m.ID_medicamento,
	m.nome,
	m.preco,
	GETDATE() as data_inicio,
	NULL as data_fim
FROM DWCFB.dbo.staging_dbo_medicamento m;



----------------
-- FORNECEDOR --
----------------

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name = N'fornecedor',
@role_name = NULL,
@supports_net_changes = 1;

declare @S binary(10);
declare @E binary(10);
SET @S = sys.fn_cdc_get_min_lsn('dbo_fornecedor');
SET @E = sys.fn_cdc_get_max_lsn();
SELECT *
INTO DWCFB.dbo.staging_dbo_fornecedor
FROM
[cdc].[fn_cdc_get_net_changes_dbo_fornecedor]
(
@S, @E, 'all'
);

INSERT INTO DWCFB.dbo.Fornecedor
SELECT 
	NEWID(), 
	f.ID_fornecedor,
	f.nome,
	GETDATE() as data_inicio,
	NULL as data_fim
FROM DWCFB.dbo.staging_dbo_fornecedor f



--------------
-- Endereco --
-------------- 

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name = N'endereco',
@role_name = NULL,
@supports_net_changes = 1;

declare @S binary(10);
declare @E binary(10);
SET @S = sys.fn_cdc_get_min_lsn('dbo_endereco');
SET @E = sys.fn_cdc_get_max_lsn();
SELECT *
INTO DWCFB.dbo.staging_dbo_endereco
FROM
[cdc].[fn_cdc_get_net_changes_dbo_endereco]
(
@S, @E, 'all'
);

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
	NULL,
	e.ID_Endereco
FROM DWCFB.dbo.staging_dbo_endereco e



---------
-- Dia --
---------

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name = N'dia',
@role_name = NULL,
@supports_net_changes = 1;

declare @S binary(10);
declare @E binary(10);
SET @S = sys.fn_cdc_get_min_lsn('dbo_dia');
SET @E = sys.fn_cdc_get_max_lsn();
SELECT *
INTO DWCFB.dbo.staging_dbo_dia
FROM
[cdc].[fn_cdc_get_net_changes_dbo_dia]
(
@S, @E, 'all'
);

INSERT INTO DWCFB.dbo.Dia
SELECT 
	NEWID(), 
	p.data,
	DATENAME(dw, p.data) as 'DiaSemana',
	DAY(p.data) as 'DiaMes',
	MONTH(p.data) as 'Mes',
	YEAR(p.data) as 'Ano'
FROM DWCFB.dbo.staging_dbo_dia p



-------------
-- Receita --
-------------

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name = N'pedido',
@role_name = NULL,
@supports_net_changes = 1;

declare @S binary(10);
declare @E binary(10);
SET @S = sys.fn_cdc_get_min_lsn('dbo_pedido');
SET @E = sys.fn_cdc_get_max_lsn();
SELECT *
INTO DWCFB.dbo.staging_dbo_pedido
FROM
[cdc].[fn_cdc_get_net_changes_dbo_pedido]
(
@S, @E, 'all'
);

INSERT INTO DWCFB.dbo.Receita
SELECT 
	NEWID(),
	SUM(dw_m.preco * iem.quantidade) as 'Valor',
	SUM(iem.quantidade) as 'UnidadesVendidas',
	dw_f.ChaveFornecedor,
	dw_e.ChaveEndereco,
	dw_d.ChaveDia,
	dw_cat.ChaveCategoria,
	dw_m.ChaveMedicamento,
	dw_c.ChaveCliente
FROM DWCFB.dbo.staging_dbo_pedido ped
	-- Incluído em
	JOIN DBCFB.dbo.incluido_em iem
		ON ped.ID_pedido = iem.ID_pedido
	-- Medicamento
	JOIN DBCFB.dbo.Medicamento db_m
		ON db_m.ID_medicamento = iem.ID_medicamento
	JOIN DWCFB.dbo.Medicamento dw_m
		ON dw_m.ID_Medicamento = iem.ID_medicamento
	-- Fornecedor
	JOIN DBCFB.dbo.Fornecedor db_f
		ON db_f.ID_fornecedor = db_m.ID_fornecedor
	JOIN DWCFB.dbo.Fornecedor dw_f
		ON dw_f.ID_Fornecedor = db_f.ID_fornecedor
	-- Cliente
	JOIN DWCFB.dbo.Cliente dw_c
		ON dw_c.ID_Cliente = ped.ID_cliente
	-- Endereco
	JOIN DBCFB.dbo.Endereco db_e
		ON dw_c.ID_Cliente = db_e.ID_cliente
	JOIN DWCFB.dbo.Endereco dw_e
		ON dw_e.CEP = db_e.cep
	-- Dia
	JOIN DWCFB.dbo.Dia dw_d
		ON dw_d.DataCompleta = ped.data
	-- Categoria
	JOIN DWCFB.dbo.Categoria dw_cat
		ON dw_cat.ID_Categoria = db_m.ID_categoria
GROUP BY 
	ped.ID_pedido, 
	dw_f.ChaveFornecedor,
	dw_e.ChaveEndereco,
	dw_d.ChaveDia,
	dw_cat.ChaveCategoria,
	dw_m.ChaveMedicamento,
	dw_c.ChaveCliente


--------------------
-- Receita_detail --
--------------------

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name = N'pedido',
@role_name = NULL,
@supports_net_changes = 1;

declare @S binary(10);
declare @E binary(10);
SET @S = sys.fn_cdc_get_min_lsn('dbo_pedido');
SET @E = sys.fn_cdc_get_max_lsn();
SELECT *
INTO DWCFB.dbo.staging_dbo_pedido
FROM
[cdc].[fn_cdc_get_net_changes_dbo_pedido]
(
@S, @E, 'all'
);

INSERT INTO DWCFB.dbo.Receita
SELECT 
	NEWID(),
	SUM(dw_m.preco * iem.quantidade) as 'Valor',
	SUM(iem.quantidade) as 'UnidadesVendidas',
    DATEPART(hour, GETDATE()) as 'Hora',
	dw_f.ChaveFornecedor,
	dw_e.ChaveEndereco,
	dw_d.ChaveDia,
	dw_cat.ChaveCategoria,
	dw_m.ChaveMedicamento,
	dw_c.ChaveCliente
FROM DWCFB.dbo.staging_dbo_pedido ped
	-- Incluído em
	JOIN DBCFB.dbo.incluido_em iem
		ON ped.ID_pedido = iem.ID_pedido
	-- Medicamento
	JOIN DBCFB.dbo.Medicamento db_m
		ON db_m.ID_medicamento = iem.ID_medicamento
	JOIN DWCFB.dbo.Medicamento dw_m
		ON dw_m.ID_Medicamento = iem.ID_medicamento
	-- Fornecedor
	JOIN DBCFB.dbo.Fornecedor db_f
		ON db_f.ID_fornecedor = db_m.ID_fornecedor
	JOIN DWCFB.dbo.Fornecedor dw_f
		ON dw_f.ID_Fornecedor = db_f.ID_fornecedor
	-- Cliente
	JOIN DWCFB.dbo.Cliente dw_c
		ON dw_c.ID_Cliente = ped.ID_cliente
	-- Endereco
	JOIN DBCFB.dbo.Endereco db_e
		ON dw_c.ID_Cliente = db_e.ID_cliente
	JOIN DWCFB.dbo.Endereco dw_e
		ON dw_e.CEP = db_e.cep
	-- Dia
	JOIN DWCFB.dbo.Dia dw_d
		ON dw_d.DataCompleta = ped.data
	-- Categoria
	JOIN DWCFB.dbo.Categoria dw_cat
		ON dw_cat.ID_Categoria = db_m.ID_categoria
GROUP BY 
	ped.ID_pedido, 
	dw_f.ChaveFornecedor,
	dw_e.ChaveEndereco,
	dw_d.ChaveDia,
	dw_cat.ChaveCategoria,
	dw_m.ChaveMedicamento,
	dw_c.ChaveCliente