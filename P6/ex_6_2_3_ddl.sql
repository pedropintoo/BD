CREATE DATABASE Medicines_Management;
GO
USE Medicines_Management;
GO

CREATE TABLE Farmacia(
    nome                VARCHAR(30) NOT NULL,
    telefone            INT         NOT NULL,
    endereco            VARCHAR(30) NOT NULL,
    PRIMARY KEY (nome)
);   

CREATE TABLE Medico(
    numSNS              INT         NOT NULL,
    nome                VARCHAR(30) NOT NULL,
    especialidade       VARCHAR(20) NOT NULL,
    PRIMARY KEY (numSNS),
    UNIQUE (nome)
);

CREATE TABLE Paciente(
    numUtente           INT         NOT NULL,
    nome                VARCHAR(30) NOT NULL,
    dataNasc            DATE        NOT NULL,
    endereco            VARCHAR(30) NOT NULL,
    PRIMARY KEY (numUtente),
    UNIQUE (nome)
);

CREATE TABLE Prescricao(
    numPresc            INT         NOT NULL,
    numUtente           INT         NOT NULL,
    numMedico           INT         NOT NULL,
    farmacia            VARCHAR(30),
    [data]              DATE,
    PRIMARY KEY (numPresc),
    FOREIGN KEY (farmacia) REFERENCES Farmacia(nome),
    FOREIGN KEY (numUtente) REFERENCES Paciente(numUtente),
    FOREIGN KEY (numMedico) REFERENCES Medico(numSNS)
);

CREATE TABLE Farmaceutica(
    numReg              INT         NOT NULL,
    nome                VARCHAR(20) NOT NULL,
    endereco            VARCHAR(40) NOT NULL,
    PRIMARY KEY (numReg),
    UNIQUE (nome)
); 

CREATE TABLE Farmaco(
    numRegFarm          INT         NOT NULL,
    nome                VARCHAR(30) NOT NULL,
    formula             VARCHAR(20) NOT NULL,
    PRIMARY KEY (numRegFarm,nome),
    FOREIGN KEY (numRegFarm) REFERENCES Farmaceutica(numReg)
);

CREATE TABLE Presc_farmaco(
    numPresc           INT         NOT NULL,
    numRegFarm         INT         NOT NULL,
    nomeFarmaco        VARCHAR(30) NOT NULL,
    PRIMARY KEY (numPresc,numRegFarm,nomeFarmaco),
    FOREIGN KEY (numPresc) REFERENCES Prescricao(numPresc),
    FOREIGN KEY (numRegFarm,nomeFarmaco) REFERENCES Farmaco(numRegFarm,nome)
); 