GO
USE P8;
GO

CREATE TABLE mytemp (
    rid BIGINT /*IDENTITY (1, 1)*/ NOT NULL,
    at1 INT NULL,
    at2 INT NULL,
    at3 INT NULL,
    lixo varchar(100) NULL,
    PRIMARY KEY (rid) -- por defeito cria uma unique clustered index
);

ALTER INDEX ALL ON mytemp REBUILD WITH (FILLFACTOR = 90);

-- ex e) criar índices
CREATE INDEX idxAt1 ON mytemp(at1);
CREATE INDEX idxAt2 ON mytemp(at2);
CREATE INDEX idxAt3 ON mytemp(at3);
CREATE INDEX idxLixo ON mytemp(lixo);