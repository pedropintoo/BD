CREATE DATABASE Medicines_Management;
GO
USE Medicines_Management;
GO

CREATE TABLE Farmacia(
    nif                 VARCHAR NOT NULL,
    telefone            VARCHAR NOT NULL,
    endereco            VARCHAR NOT NULL,
    nome                VARCHAR NOT NULL,
    PRIMARY KEY (nif),
);   

CREATE TABLE Medico(
    num_id_SNS          INT NOT NULL,
    nome                VARCHAR NOT NULL,
    especialidade       VARCHAR NOT NULL,
    PRIMARY KEY (num_id_SNS)
);

CREATE TABLE Paciente(
    num_utente          INT NOT NULL,
    endereco            VARCHAR NOT NULL,
    nome                VARCHAR NOT NULL,
    data_nascimento     VARCHAR NOT NULL,
    num_id_SNS          INT NOT NULL,
    PRIMARY KEY (num_utente),
    FOREIGN KEY (num_id_SNS) REFERENCES Medico(num_id_SNS)
);

CREATE TABLE Preescricao(
    numero_prescricao   INT NOT NULL,
    [data]              VARCHAR NOT NULL,
    nif                 VARCHAR NOT NULL,
    num_utente          INT NOT NULL,
    num_id_SNS          INT NOT NULL,
    PRIMARY KEY (numero_prescricao),
    FOREIGN KEY (nif) REFERENCES Farmacia(nif),
    FOREIGN KEY (num_utente) REFERENCES Paciente(num_utente)
);

CREATE TABLE Farmaceutica(
    numero_registo_nacional   INT NOT NULL,
    nome                      VARCHAR NOT NULL,
    endereco                  VARCHAR NOT NULL,
    telefone                  VARCHAR NOT NULL,
    PRIMARY KEY (numero_registo_nacional)
); 

CREATE TABLE Farmaco(
    numero_registo_nacional   INT NOT NULL,
    nome                      VARCHAR NOT NULL,
    formula                   VARCHAR NOT NULL,
    PRIMARY KEY (numero_registo_nacional,nome),
    FOREIGN KEY (numero_registo_nacional) REFERENCES Farmaceutica(numero_registo_nacional)
); 

CREATE TABLE Vende(
    nif                       VARCHAR NOT NULL,
    numero_registo_nacional   INT NOT NULL,
    nome                      VARCHAR NOT NULL,
    PRIMARY KEY (nif,numero_registo_nacional,nome),
    FOREIGN KEY (nif) REFERENCES Farmacia(nif),
    FOREIGN KEY (numero_registo_nacional) REFERENCES Farmaceutica(numero_registo_nacional),
    FOREIGN KEY (numero_registo_nacional,nome) REFERENCES Farmaco(numero_registo_nacional,nome)
); 

CREATE TABLE Constituida_por(
    numero_prescricao         INT NOT NULL,
    numero_registo_nacional   INT NOT NULL,
    nome                      VARCHAR NOT NULL,
    PRIMARY KEY (numero_prescricao,numero_registo_nacional,nome),
    FOREIGN KEY (numero_prescricao) REFERENCES Preescricao(numero_prescricao),
    FOREIGN KEY (numero_registo_nacional) REFERENCES Farmaceutica(numero_registo_nacional),
    FOREIGN KEY (numero_registo_nacional,nome) REFERENCES Farmaco(numero_registo_nacional,nome)
); 

CREATE TABLE Pertence(
    numero_registo_nacional   INT NOT NULL,
    nome                      VARCHAR NOT NULL,
    PRIMARY KEY (numero_registo_nacional,nome),
    FOREIGN KEY (numero_registo_nacional) REFERENCES Farmaceutica(numero_registo_nacional),
    FOREIGN KEY (numero_registo_nacional,nome) REFERENCES Farmaco(numero_registo_nacional,nome)
); 