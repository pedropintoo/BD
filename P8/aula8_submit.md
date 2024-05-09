# BD: Guião 8


## ​8.1. Complete a seguinte tabela.
Complete the following table.

| #    | Query                                                                                                      | Rows  | Cost  | Pag. Reads | Time (ms) | Index used | Index Op.            | Discussion |
| :--- | :--------------------------------------------------------------------------------------------------------- | :---- | :---- | :--------- | :-------- | :--------- | :------------------- | :--------- |
| 1    | SELECT * from Production.WorkOrder                                                                         | 72591 | 0.484 | 531        | 1171      | …          | Clustered Index Scan |            |
| 2    | SELECT * from Production.WorkOrder where WorkOrderID=1234                                                  |       |       |            |           |            |                      |            |
| 3.1  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 10000 and 10010                               |       |       |            |           |            |                      |            |
| 3.2  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 1 and 72591                                   |       |       |            |           |            |                      |            |
| 4    | SELECT * FROM Production.WorkOrder WHERE StartDate = '2007-06-25'                                          |       |       |            |           |            |                      |            |
| 5    | SELECT * FROM Production.WorkOrder WHERE ProductID = 757                                                   |       |       |            |           |            |                      |            |
| 6.1  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 757                              |       |       |            |           |            |                      |            |
| 6.2  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945                              |       |       |            |           |            |                      |            |
| 6.3  | SELECT WorkOrderID FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04'            |       |       |            |           |            |                      |            |
| 7    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04' |       |       |            |           |            |                      |            |
| 8    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04' |       |       |            |           |            |                      |            |

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
... Write here your answer ...
```
