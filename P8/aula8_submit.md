# BD: Guião 8


## ​8.1. Complete a seguinte tabela.
Complete the following table.

| #    | Query                                                                                                      | Rows  | Cost  | Pag. Reads | Time (ms) | Index used | Index Op.            | Discussion |
| :--- | :--------------------------------------------------------------------------------------------------------- | :---- | :---- | :--------- | :-------- | :--------- | :------------------- | :--------- |
| 1    | SELECT * from Production.WorkOrder                                                                         | 72591 | 0.484 | 531        | 1171      | …          | Clustered Index Scan |    Os tempos são altos pois precisa de ler as linhas todas.        |
| 2    | SELECT * from Production.WorkOrder where WorkOrderID=1234                                                  |   1       | 0.0032831       |       26      |   73        |    WorkOrderID (PK)        |    Clustered Index Seek   |   Foi criado automaticamente um clustered index associado à primary key WorkOrderID. Por essa razão, como a procura foi feita em função de WorkOrderID o "Cost" é baixo.         |
| 3.1  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 10000 and 10010                               |   11    | 0.0032952     |     26       |     121      |     WorkOrderID (PK)       |    Clustered Index Seek   |   O número de rows é 11, que corresponde à dimensão do intervalo pretendido.         |
| 3.2  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 1 and 72591                                   |   72591    |  0.473502     |     744       |     7602      |   WorkOrderID (PK)         |        Clustered Index Seek              |     A query contém todas as páginas. Portanto foi necessário lê-las todas.       |
| 4    | SELECT * FROM Production.WorkOrder WHERE StartDate = '2012-05-14'                                         |   72591    |   0.473502    |     748       |      307     |    WorkOrderID (PK)        |        Clustered Index Scan              |    Não existe um índice associado a StartDate. Portanto, o "Cost" foi alto.        |
| 5    | SELECT * FROM Production.WorkOrder WHERE ProductID = 757                                                   |   9    |   0.0368744    |     238       |     177      |     ProductID       |   Non Clustered Index Seek     |  Criámos um "NONCLUSTERED INDEX" associado a ProductID. Portanto, o "Cost" foi baixo.  |
| 6.1  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 757                              |   9    |   0.0032944    |     220       |     3      |     ProductID Covered (StartDate)       |       Non Clustered Index Seek        |        Criámos um índice que inclui a coluna ProductID como chave do índice e a coluna StartDate como coluna incluída (covered column). Como a procura foi feita em função de ProductID o "Cost" é baixo.      |
| 6.2  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945                              |  1105     |   0.0059894    |    224       |     315     |   ProductID Covered (StartDate)  |       Non Clustered Index Seek      |      Igual ao anterior.     |
| 6.3  | SELECT WorkOrderID FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2011-12-04'    |   1    |   0.0059894    |     226      |      23     |    ProductID Covered (StartDate)        |    Non Clustered Index Seek    |     Igual ao anterior. Como a procura foi feita em função de ProductID e StartDate o "Cost" é baixo.        |
| 7    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder  WHERE ProductID = 945 AND StartDate = '2011-12-04' |   1    |   0.0167608   |      61      |     71      |     ProductID and StartDate       |      Non Clustered Index Seek   |      Criámos um "NONCLUSTERED INDEX" associado a ProductID e outro associado a StartDate. O "Cost" é baixo.       |
| 8    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2011-12-04' |   1    |   0.0032831    |      56    |     5      |     Composite (ProductID, StartDate)       |        Non Clustered Index Seek       |     Criámos um "NONCLUSTERED INDEX" composto associado a (ProductID, StartDate). O "Cost" foi mais baixo que na alínea anterior.       |

## ​8.2.

### a)

```
CREATE TABLE mytemp (
    rid BIGINT /*IDENTITY (1, 1)*/ NOT NULL,
    at1 INT NULL,
    at2 INT NULL,
    at3 INT NULL,
    lixo varchar(100) NULL,
    PRIMARY KEY (rid) -- por defeito cria uma unique clustered index
);
```

### b)

```
Fragmentacao dos índices: 98.97%
Ocupação das páginas: 68.33%
```

### c)

```
65- tempo manteve mas os Reads aumentaram 42s
80- tempo aumentou 46s
90- tempo manteve (optimo!) 42s
```

### d)

```
O Tempo melhorou agora a escrita é sequencial. Embora ainda tenhamos de rebalanciar. 
```

### e)

```
Tempo piorou significativamente. Quantos mais indices mais copias temos de ter ou seja mais tempo de inserção.
```

## ​8.3.

```
1. (Por defeito, a criação de uma chave primária cria automaticamente um unique clustered index)
2. CREATE INDEX ixEmployeeFLname ON EMPLOYEE (Fname, Lname);
3. CREATE INDEX ixEmployeeDno ON EMPLOYEE (Dno);
4. CREATE INDEX ixWorksOnPno on WORKS_ON (Pno);
5. (Por defeito, a criação de uma chave primária cria automaticamente um unique clustered index)
6. CREATE INDEX ixProjectDnum ON PROJECT (Dnum);

```
