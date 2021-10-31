-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-10-31 00:32:23.025

-- tables
-- Table: Categoria
CREATE TABLE Categoria (
    ChaveCategoria int  NOT NULL,
    IDCategoria int  NOT NULL,
    nome varchar(255)  NOT NULL,
    CONSTRAINT Categoria_pk PRIMARY KEY  (ChaveCategoria)
);

-- Table: Cliente
CREATE TABLE Cliente (
    ChaveCliente int  NOT NULL,
    ID_cliente int  NOT NULL,
    NomeCliente varchar(255)  NOT NULL,
    CONSTRAINT Cliente_pk PRIMARY KEY  (ChaveCliente)
);

-- Table: Dia
CREATE TABLE Dia (
    ChaveDia int  NOT NULL,
    IDData int  NOT NULL,
    DataCompleta date  NOT NULL,
    DiaSemana varchar(20)  NOT NULL,
    DiaMes int  NOT NULL,
    Mes int  NOT NULL,
    Ano int  NOT NULL,
    CONSTRAINT Dia_pk PRIMARY KEY  (ChaveDia)
);

-- Table: Endereco
CREATE TABLE Endereco (
    ChaveEndereco int  NOT NULL,
    CEP varchar(8)  NOT NULL,
    logradouro varchar(255)  NOT NULL,
    numero int  NOT NULL,
    bairro varchar(255)  NOT NULL,
    uf varchar(2)  NOT NULL,
    cidade varchar(255)  NOT NULL,
    CONSTRAINT Endereco_pk PRIMARY KEY  (ChaveEndereco)
);

-- Table: Fornecedor
CREATE TABLE Fornecedor (
    ChaveFornecedor int  NOT NULL,
    IDFornecedor int  NOT NULL,
    nome varchar(255)  NOT NULL,
    CONSTRAINT Fornecedor_pk PRIMARY KEY  (ChaveFornecedor)
);

-- Table: Medicamento
CREATE TABLE Medicamento (
    ChaveMedicamento int  NOT NULL,
    IDMedicamento int  NOT NULL,
    nome varchar(255)  NOT NULL,
    preco numeric(5,2)  NOT NULL,
    CONSTRAINT Medicamento_pk PRIMARY KEY  (ChaveMedicamento)
);

-- Table: Receita
CREATE TABLE Receita (
    ChaveCliente int  NOT NULL,
    ChaveCategoria int  NOT NULL,
    ChaveDia int  NOT NULL,
    ChaveFornecedor int  NOT NULL,
    ChaveEndereco int  NOT NULL,
    ChaveMedicamento int  NOT NULL,
    ID_Pedido int  NOT NULL,
    Valor int  NOT NULL,
    UnidadesVendidas int  NOT NULL,
    Fornecedor_ChaveFornecedor int  NOT NULL,
    Endereco_ChaveEndereco int  NOT NULL,
    Dia_ChaveDia int  NOT NULL,
    Categoria_ChaveCategoria int  NOT NULL,
    Medicamento_ChaveMedicamento int  NOT NULL,
    Cliente_ChaveCliente int  NOT NULL,
    CONSTRAINT Receita_pk PRIMARY KEY  (ID_Pedido,ChaveMedicamento)
);

-- Table: Receita_detail
CREATE TABLE Receita_detail (
    ID_Pedido int  NOT NULL,
    Valor int  NOT NULL,
    UnidadesVendidas int  NOT NULL,
    Hora int  NOT NULL,
    Endereco_ChaveEndereco int  NOT NULL,
    Fornecedor_ChaveFornecedor int  NOT NULL,
    Dia_ChaveDia int  NOT NULL,
    Categoria_ChaveCategoria int  NOT NULL,
    Medicamento_ChaveMedicamento int  NOT NULL,
    Cliente_ChaveCliente int  NOT NULL,
    CONSTRAINT Receita_detail_pk PRIMARY KEY  (ID_Pedido)
);

-- foreign keys
-- Reference: Receita_Categoria (table: Receita)
ALTER TABLE Receita ADD CONSTRAINT Receita_Categoria
    FOREIGN KEY (Categoria_ChaveCategoria)
    REFERENCES Categoria (ChaveCategoria);

-- Reference: Receita_Cliente (table: Receita)
ALTER TABLE Receita ADD CONSTRAINT Receita_Cliente
    FOREIGN KEY (Cliente_ChaveCliente)
    REFERENCES Cliente (ChaveCliente);

-- Reference: Receita_Dia (table: Receita)
ALTER TABLE Receita ADD CONSTRAINT Receita_Dia
    FOREIGN KEY (Dia_ChaveDia)
    REFERENCES Dia (ChaveDia);

-- Reference: Receita_Endereco (table: Receita)
ALTER TABLE Receita ADD CONSTRAINT Receita_Endereco
    FOREIGN KEY (Endereco_ChaveEndereco)
    REFERENCES Endereco (ChaveEndereco);

-- Reference: Receita_Fornecedor (table: Receita)
ALTER TABLE Receita ADD CONSTRAINT Receita_Fornecedor
    FOREIGN KEY (Fornecedor_ChaveFornecedor)
    REFERENCES Fornecedor (ChaveFornecedor);

-- Reference: Receita_Medicamento (table: Receita)
ALTER TABLE Receita ADD CONSTRAINT Receita_Medicamento
    FOREIGN KEY (Medicamento_ChaveMedicamento)
    REFERENCES Medicamento (ChaveMedicamento);

-- Reference: Receita_detail_Categoria (table: Receita_detail)
ALTER TABLE Receita_detail ADD CONSTRAINT Receita_detail_Categoria
    FOREIGN KEY (Categoria_ChaveCategoria)
    REFERENCES Categoria (ChaveCategoria);

-- Reference: Receita_detail_Cliente (table: Receita_detail)
ALTER TABLE Receita_detail ADD CONSTRAINT Receita_detail_Cliente
    FOREIGN KEY (Cliente_ChaveCliente)
    REFERENCES Cliente (ChaveCliente);

-- Reference: Receita_detail_Dia (table: Receita_detail)
ALTER TABLE Receita_detail ADD CONSTRAINT Receita_detail_Dia
    FOREIGN KEY (Dia_ChaveDia)
    REFERENCES Dia (ChaveDia);

-- Reference: Receita_detail_Endereco (table: Receita_detail)
ALTER TABLE Receita_detail ADD CONSTRAINT Receita_detail_Endereco
    FOREIGN KEY (Endereco_ChaveEndereco)
    REFERENCES Endereco (ChaveEndereco);

-- Reference: Receita_detail_Fornecedor (table: Receita_detail)
ALTER TABLE Receita_detail ADD CONSTRAINT Receita_detail_Fornecedor
    FOREIGN KEY (Fornecedor_ChaveFornecedor)
    REFERENCES Fornecedor (ChaveFornecedor);

-- Reference: Receita_detail_Medicamento (table: Receita_detail)
ALTER TABLE Receita_detail ADD CONSTRAINT Receita_detail_Medicamento
    FOREIGN KEY (Medicamento_ChaveMedicamento)
    REFERENCES Medicamento (ChaveMedicamento);

-- End of file.

