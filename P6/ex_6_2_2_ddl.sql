CREATE DATABASE Stock_Management;
GO
USE Stock_Management;
GO

CREATE TABLE Produto(
    codigo              INT NOT NULL,
    nome                VARCHAR(20) NOT NULL,
    preco               VARCHAR(4) NOT NULL,
    iva                 VARCHAR(4) NOT NULL,
    PRIMARY KEY (codigo),
    UNIQUE (nome)
);  


CREATE TABLE Fornecedor(
    nif                 VARCHAR(20) NOT NULL,
    nome                VARCHAR(20) NOT NULL,
    addr                VARCHAR(20) NOT NULL,
    fax                 VARCHAR(20) NOT NULL,
    cond_pagamento      VARCHAR(20) NOT NULL,
    codigo              INT NOT NULL,
    PRIMARY KEY (nif),
    FOREIGN KEY (codigo) REFERENCES Produto(codigo),
    UNIQUE (nome)
);    


CREATE TABLE Encomenda(
    num                INT NOT NULL,
    [data]             VARCHAR(6) NOT NULL,
    nif                VARCHAR(20) NOT NULL,
    PRIMARY KEY (num),
    FOREIGN KEY (nif) REFERENCES Fornecedor(nif)
);    

CREATE TABLE TipoFornecedor(
    codigo              INT NOT NULL,
    nome                VARCHAR(20) NOT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE Contem(
    num_encomenda             INT NOT NULL,
    codigo                    INT NOT NULL,
    num_unidades              INT NOT NULL,
    PRIMARY KEY (num_encomenda,codigo),
    FOREIGN KEY (num_encomenda) REFERENCES Encomenda(num),
    FOREIGN KEY (codigo) REFERENCES Produto(codigo),
);