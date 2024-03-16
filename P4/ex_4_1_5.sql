CREATE DataBase Gestao_conferencias
GO 
USE Gestao_conferencias;
GO
CREATE TABLE Conferencia (
    nome            VARCHAR     NOT NULL,
    PRIMARY KEY (nome)
);
CREATE TABLE Instituicao (
    nome            VARCHAR     NOT NULL,
    endereco        VARCHAR,
    PRIMARY KEY (nome)
);
CREATE TABLE Autor (
    nome            VARCHAR     NOT NULL,
    email           VARCHAR,
    Inst_nome       VARCHAR,
    PRIMARY KEY (nome),
    FOREIGN KEY (Inst_nome) REFERENCES Instituicao(nome)
);
CREATE TABLE Artigo (
    num_registo     INT         NOT NULL,
    titulo          VARCHAR     NOT NULL,
    PRIMARY KEY (num_registo)
);
CREATE TABLE Tem_Autor (
    Art_num_registo INT         NOT NULL,
    Aut_nome        VARCHAR     NOT NULL,
    PRIMARY KEY (Art_num_registo, Aut_nome),
    FOREIGN KEY (Art_num_registo) REFERENCES Artigo(num_registo),
    FOREIGN KEY (Aut_nome) REFERENCES Autor(nome)
);
CREATE TABLE Apresenta (
    Conf_nome       VARCHAR     NOT NULL,
    Art_num_registo VARCHAR     NOT NULL,
    PRIMARY KEY (Conf_nome, Art_num_re),
    FOREIGN KEY (Conf_nome) REFERENCES Conferencia(nome),
    FOREIGN KEY (Art_num_registo) REFERENCES Artigo(num_registo)
);
CREATE TABLE Pessoa (
    nome            VARCHAR     NOT NULL,
    email           VARCHAR,
    PRIMARY KEY (nome)
);
CREATE TABLE Participante (
    Pess_nome       VARCHAR     NOT NULL,
    morada          VARCHAR,
    data_inscricao  VARCHAR,
    Inst_nome       VARCHAR,    
    PRIMARY KEY (Pess_nome),
    FOREIGN KEY (Pess_nome) REFERENCES Pessoa(nome),
    FOREIGN KEY (Inst_nome) REFERENCES Instituicao(nome)
);
CREATE TABLE Tem_Participante (
    Conf_nome       VARCHAR     NOT NULL,
    Part_nome       VARCHAR     NOT NULL,
    PRIMARY KEY (Conf_nome, Part_nome),
    FOREIGN KEY (Conf_nome) REFERENCES Conferencia(nome),
    FOREIGN KEY (Part_nome) REFERENCES Participante(nome)
);
CREATE TABLE NaoEstudante (
    Part_nome       VARCHAR     NOT NULL,
    ref_transacao   VARCHAR     NOT NULL,
    PRIMARY KEY (Part_nome),
    FOREIGN KEY (Part_nome) REFERENCES Participante(nome),
    UNIQUE (ref_transacao)
);
CREATE TABLE Estudante (
    Part_nome       VARCHAR     NOT NULL,
    PRIMARY KEY (Part_nome),
    FOREIGN KEY (Part_nome) REFERENCES Participante(nome),
);
CREATE TABLE ComprovativoEnsino (
    localizacao     VARCHAR     NOT NULL,
    Estud_nome      VARCHAR     NOT NULL,
    Inst_nome       VARCHAR,
    PRIMARY KEY (localizacao, Estud_nome),
    FOREIGN KEY (Estud_nome) REFERENCES Estudante(nome),
    FOREIGN KEY (Inst_nome) REFERENCES Instituicao(nome),
);