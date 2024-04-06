CREATE DATABASE Stock_Management;
GO
USE Stock_Management;
GO

CREATE TABLE Produto(
    codigo              INT NOT NULL,
    nome                VARCHAR(20) NOT NULL,
    preco               VARCHAR(4) NOT NULL,
    iva                 VARCHAR(4) NOT NULL,
    unidades              INT NOT NULL,
    PRIMARY KEY (codigo),
    UNIQUE (nome)
);  


CREATE TABLE Fornecedor(
    nif                 VARCHAR(20) NOT NULL,
    nome                VARCHAR(20) NOT NULL,
    fax                VARCHAR(20) NOT NULL,
    endereco                 VARCHAR(20) NOT NULL,
    condpag      VARCHAR(20) NOT NULL,
    tipo              INT NOT NULL,
    PRIMARY KEY (nif),
    FOREIGN KEY (codigo) REFERENCES Produto(codigo),
    UNIQUE (nome)
);    


CREATE TABLE Encomenda(
    numero                INT NOT NULL,
    [data]             VARCHAR(6) NOT NULL,
    fornecedor                VARCHAR(20) NOT NULL,
    PRIMARY KEY (numero),
    FOREIGN KEY (fornecedor) REFERENCES Fornecedor(nif)
);    

CREATE TABLE TipoFornecedor(
    codigo                    INT NOT NULL,
    designacao                VARCHAR(20) NOT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE item(
    numEnc             INT NOT NULL,
    codProd                    INT NOT NULL,
    num_unidades              INT NOT NULL,
    PRIMARY KEY (numEnc,codProd),
    FOREIGN KEY (numEnc) REFERENCES Encomenda(numero),
    FOREIGN KEY (codProd) REFERENCES Produto(codigo),
);