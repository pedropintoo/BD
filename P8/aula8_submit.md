# BD: Guião 8


## ​8.1. Complete a seguinte tabela.
Complete the following table.

| #    | Query                                                                                                      | Rows  | Cost  | Pag. Reads | Time (ms) | Index used | Index Op.            | Discussion |
| :--- | :--------------------------------------------------------------------------------------------------------- | :---- | :---- | :--------- | :-------- | :--------- | :------------------- | :--------- |
| 1    | SELECT * from Production.WorkOrder                                                                         | 72591 | 0.484 | 531        | 1171      | …          | Clustered Index Scan |            |
| 2    | SELECT * from Production.WorkOrder where WorkOrderID=1234                                                  |   1       | 0.0032831       |       26      |   73        |    WorkOrderID (PK)        |    Clustered Index Seek   |            |
| 3.1  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 10000 and 10010                               |   11    | 0.0032952     |     26       |     121      |     WorkOrderID (PK)       |    Clustered Index Seek   |            |
| 3.2  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 1 and 72591                                   |   72591    |  0.473502     |     744       |     7602      |   WorkOrderID (PK)         |        Clustered Index Seek              |            |
| 4    | SELECT * FROM Production.WorkOrder WHERE StartDate = '2007-06-25'                                          |   72591    |   0.473502    |     748       |      307     |    WorkOrderID (PK)        |        Clustered Index Scan              |            |
| 5    | SELECT * FROM Production.WorkOrder WHERE ProductID = 757                                                   |   9    |   0.0340146    |     238       |     180      |     ProductID       |          Key Lookup            |            |
| 6.1  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 757                              |   9    |   0.0340146    |     238       |     103      |     ProductID Covered (StartDate)       |        Key Lookup              |            |
| 6.2  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945                              |  1105     |   0.473502    |     748       |     135      |   ProductID Covered (StartDate)  |      Clustered Index Scan      |            |
| 6.3  | SELECT WorkOrderID FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04'            |   1    |   0.473502    |      556      |      20     |    ProductID Covered (StartDate)        |   Clustered Index Scan     |            |
| 7    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04' |   1    |   0.473502    |      750      |     27      |     ProductID and StartDate       |       Clustered Index Scan  |            |
| 8    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04' |   1    |   0.473502    |      750      |     27      |     Composite (ProductID, StartDate)       |        Clustered Index Scan       |            |

## ​8.2.

### a)

```
... Write here your answer ...
```

### b)

```
... Write here your answer ...
```

### c)

```
... Write here your answer ...
```

### d)

```
... Write here your answer ...
```

### e)

```
... Write here your answer ...
```

## ​8.3.

```
1. 
2. CREATE INDEX ixEmployeeFLname ON EMPLOYEE (Fname, Lname);
3. CREATE INDEX ixEmployeeDno ON EMPLOYEE (Dno);
4. CREATE INDEX ixWorksOnPno on WORKS_ON (Pno);
5.
6. CREATE INDEX ixProjectDnum ON PROJECT (Dnum);

```
