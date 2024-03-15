Create Database Rentacar;
GO
USE Rentacar;
GO
CREATE TABLE Cliente (
    nome            VARCHAR         NOT NULL,
    nif             INT             NOT NULL,
    endereco        VARCHAR,
    num_carta       INT             NOT NULL,
    PRIMARY KEY (nif),
    UNIQUE (num_carta)
);
CREATE TABLE Balcao (
    nome            VARCHAR      NOT NULL,
    numero          INT          NOT NULL,
    endereco        VARCHAR,
    PRIMARY KEY (numero)
);
CREATE TABLE Tipo_veiculo (
    codigo          INT          NOT NULL,
    designacao      VARCHAR,
    arcondicionado  BIT,
    PRIMARY KEY (codigo)
);
CREATE TABLE Veiculo (
    matricula       VARCHAR      NOT NULL,
    marca           VARCHAR,
    ano             INT,
    tipo_codigo     INT,
    PRIMARY KEY (matricula),
    FOREIGN KEY (tipo_codigo) REFERENCES Tipo_veiculo(codigo)
);
CREATE TABLE Aluguer (
    numero          INT          NOT NULL,
    [data]          VARCHAR      NOT NULL,
    duracao         INT          NOT NULL,
    vei_matricula   VARCHAR      NOT NULL,
    bal_numero      INT          NOT NULL,
    cli_NIF         INT	         NOT NULL,
    PRIMARY KEY (numero),
    FOREIGN KEY (vei_matricula) REFERENCES Veiculo(matricula),
    FOREIGN KEY (bal_numero) REFERENCES Balcao(numero),
    FOREIGN KEY (cli_NIF) REFERENCES Cliente(NIF)
);
CREATE TABLE Similaridade_tipo_veiculo (
    cod_veiculo_1   INT          NOT NULL,  
    cod_veiculo_2   INT          NOT NULL,  
    PRIMARY KEY (cod_veiculo_1, cod_veiculo_2),
    FOREIGN KEY (cod_veiculo_1) REFERENCES Tipo_veiculo(codigo),
    FOREIGN KEY (cod_veiculo_2) REFERENCES Tipo_veiculo(codigo)
);
CREATE TABLE Ligeiro (
    cod			    INT          NOT NULL,
    numlugares      INT,
    portas          INT,
    combustivel     VARCHAR,
    PRIMARY KEY (cod),
    FOREIGN KEY (cod) REFERENCES Tipo_veiculo(codigo)
);
CREATE TABLE Pesado (
    codigo          INT          NOT NULL,
    peso            INT,
    passageiros     INT,
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigo) REFERENCES Tipo_veiculo(codigo)
);
