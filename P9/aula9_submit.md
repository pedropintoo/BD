# BD: Guião 9


## ​9.1
 
### *a)*

```
... Write here your answer ...
```

### *b)* 

```
CREATE PROCEDURE GetManagersAndOldestManager
AS
BEGIN
    -- Record-set with the department managers and their years as managers
    SELECT 
        e.Fname, 
        e.Minit, 
        e.Lname, 
        e.Ssn, 
        e.Sex, 
        e.Salary, 
        e.Dno,
        DATEDIFF(YEAR, d.Mgr_start_date, GETDATE()) AS YearsAsManager
    FROM 
        employee e
    INNER JOIN 
        department d ON e.Ssn = d.Mgr_ssn;

    -- Record-set with the longest-serving employee as manager
    SELECT TOP 1 
        e.Fname, 
        e.Minit, 
        e.Lname, 
        e.Ssn,
		e.Sex, 
        e.Salary, 
        e.Dno,
        DATEDIFF(YEAR, d.Mgr_start_date, GETDATE()) AS YearsAsManager
    FROM 
        employee e
    INNER JOIN 
        department d ON e.Ssn = d.Mgr_ssn
    ORDER BY 
        d.Mgr_start_date ASC;
END;
GO


EXEC GetManagersAndOldestManager;
```

### *c)* 

```
CREATE TRIGGER trg_CheckManagerAfterInsertUpdate
ON department
AFTER INSERT, UPDATE
AS
BEGIN
    -- Check if any employee is a manager of more than one department
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN department d ON i.Mgr_ssn = d.Mgr_ssn
        GROUP BY i.Mgr_ssn
        HAVING COUNT(d.Dnumber) > 1
    )
    BEGIN
        RAISERROR (''An employee cannot be the manager of more than one department.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
```

### *d)* 

```
... Write here your answer ...
```

### *e)* 

```
... Write here your answer ...
```

### *f)* 

```
... Write here your answer ...
```

### *g)* 

```
... Write here your answer ...
```

### *h)* 

```
... Write here your answer ...
```

### *i)* 

```
... Write here your answer ...
```
