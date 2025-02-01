CREATE DATABASE Stock_Management;
GO
USE Stock_Management;
GO

CREATE TABLE Produto(
    codigo              INT NOT NULL,
    nome                VARCHAR NOT NULL,
    preco               VARCHAR NOT NULL,
    iva                 VARCHAR NOT NULL,
    PRIMARY KEY (codigo),
    UNIQUE (codigo)
);  


CREATE TABLE Fornecedor(
    nif                 VARCHAR NOT NULL,
    nome                VARCHAR NOT NULL,
    addr                VARCHAR NOT NULL,
    fax                 VARCHAR NOT NULL,
    cond_pagamento      VARCHAR NOT NULL,
    codigo              INT NOT NULL,
    PRIMARY KEY (nif),
    FOREIGN KEY (codigo) REFERENCES Produto(codigo),
    UNIQUE (nif)
);    


CREATE TABLE Encomenda(
    num                INT NOT NULL,
    [data]             VARCHAR NOT NULL,
    nif                VARCHAR NOT NULL,
    PRIMARY KEY (num),
    FOREIGN KEY (nif) REFERENCES Fornecedor(nif),
    UNIQUE (num)
);    

CREATE TABLE TipoFornecedor(
    codigo              INT NOT NULL,
    nome                VARCHAR NOT NULL,
    PRIMARY KEY (codigo),
    UNIQUE (codigo)
);

CREATE TABLE Contem(
    num_encomenda             INT NOT NULL,
    codigo                    INT NOT NULL,
    num_unidades              INT NOT NULL,
    PRIMARY KEY (num_encomenda,codigo),
    FOREIGN KEY (num_encomenda) REFERENCES Encomenda(num),
    FOREIGN KEY (codigo) REFERENCES Produto(codigo),
    UNIQUE (num_encomenda,codigo)
);