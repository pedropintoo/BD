CREATE DataBase Gestao_ATL
GO 
USE Gestao_ATL;
GO
CREATE TABLE Professor(
    num_cc              INT         NOT NULL,
    data_nascimento     VARCHAR,
    nome                VARCHAR     NOT NULL,
    email               VARCHAR     NOT NULL,
    telefone            INT,
    morada              VARCHAR,
    num_functionario    INT         NOT NULL,
    PRIMARY KEY (num_cc),  
    UNIQUE (num_functionario),
    UNIQUE (email)
);
CREATE TABLE Encarregado_educacao(
    num_cc              INT         NOT NULL,
    data_nascimento     VARCHAR,
    nome                VARCHAR     NOT NULL,
    email               VARCHAR     NOT NULL,
    telefone            INT,
    morada              VARCHAR,
    tipoRelacao         VARCHAR,
    PRIMARY KEY (num_cc),  
    UNIQUE (email)
);
CREATE TABLE Turma(
    identificador       INT         NOT NULL,
    ano_letivo          INT,
    designacao          VARCHAR,
    num_max_alunos      INT,
    classe              INT,
    Prof_num_cc         INT,
    PRIMARY KEY (identificador),
    FOREIGN KEY (Prof_num_cc) REFERENCES Professor(num_cc)
);
CREATE TABLE Aluno(
    num_cc              INT         NOT NULL,
    data_nascimento     VARCHAR,
    nome                VARCHAR     NOT NULL,
    morada              VARCHAR,
    Enc_num_cc          INT,
    Turma_identificador INT,
    PRIMARY KEY (num_cc),
    FOREIGN KEY (Enc_num_cc) REFERENCES Encarregado_educacao(num_cc),
    FOREIGN KEY (Turma_identificador) REFERENCES Turma(identificador) 
);
CREATE TABLE Atividade(
    identificador       INT         NOT NULL,
    custo               INT,
    designacao          VARCHAR,
    PRIMARY KEY (identificador)
);
CREATE TABLE Participa_Turma(
    Ativid_ID           INT         NOT NULL,
    Turma_ID            INT         NOT NULL,
    PRIMARY KEY (Ativid_ID, Turma_ID),
    FOREIGN KEY (Ativid_ID) REFERENCES Atividade(identificador),
    FOREIGN KEY (Turma_ID) REFERENCES Turma(identificador)
);
CREATE TABLE Participa_Aluno(
    Ativid_ID           INT         NOT NULL,
    Aluno_num_cc        INT         NOT NULL,
    PRIMARY KEY (Ativid_ID, Aluno_num_cc),
    FOREIGN KEY (Ativid_ID) REFERENCES Atividade(identificador),
    FOREIGN KEY (Aluno_num_cc) REFERENCES Aluno(num_cc)
);
CREATE TABLE ResponsavelEntregarLevantar(
    Enc_num_cc          INT         NOT NULL,
    Aluno_num_cc        INT         NOT NULL,
    PRIMARY KEY (Enc_num_cc),
    FOREIGN KEY (Enc_num_cc) REFERENCES Encarregado_educacao(num_cc),
    FOREIGN KEY (Aluno_num_cc) REFERENCES Aluno(num_cc)
);