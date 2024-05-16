# BD: Guião 9


## ​9.1
 
### *a)*

```
ALTER PROC EmployeeEx01a @Ssn int
AS	
	DELETE
	FROM works_on
	WHERE works_on.Essn = @Ssn
	
	DELETE
	FROM dependent
	WHERE dependent.Essn = @Ssn
	
	UPDATE Department
	SET Mgr_ssn = NULL
	WHERE Department.Mgr_ssn = @Ssn;

	UPDATE Employee
	SET Super_ssn = NULL
	WHERE Employee.Super_ssn = @Ssn;
	
	DELETE 
	FROM Employee
	WHERE Employee.Ssn = @Ssn
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
CREATE Trigger TriggerEx1c ON Employee
AFTER INSERT, UPDATE
AS	
	DECLARE @counter    INT = 1
	DECLARE @max        INT = 0
	DECLARE @insertedSsn INT
	DECLARE @maxSalary	INT

	DECLARE @wrongRecords TABLE (
			Id			INT IDENTITY,
			insertedSsn		INT,
			insertedSalary	INT,
			maxSalary		INT
			)
	
	-- get wrong records that must be changed
	INSERT INTO @wrongRecords
	SELECT insertedSsn, insertedSalary, maxSalary
	FROM (SELECT inserted.Ssn AS insertedSsn, inserted.Salary AS insertedSalary, Employee.Salary AS maxSalary
	FROM Employee
	INNER JOIN Department ON Employee.Ssn = Mgr_ssn
	INNER JOIN (SELECT * FROM EMPLOYEE) AS inserted ON inserted.Dno = department.Dnumber) AS T
	WHERE T.insertedSalary >= T.maxSalary
	
	-- iterate throughout the wrong records
	SELECT @max = COUNT(ID) FROM @wrongRecords
	WHILE @counter <= @max
	  BEGIN
		-- select record maxSalary and corresponding ssn
		SELECT @maxSalary=maxSalary, @insertedSsn=insertedSsn FROM @wrongRecords WHERE ID = @counter

		-- update record in db
		UPDATE Employee 
		SET Salary = @maxSalary - 1
		WHERE Employee.Ssn = @insertedSsn

		SET @counter = @counter + 1
	  END
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
UDFs:
 - retorna um valor (escalar ou tabela)
 - podem ser usados no SELECT / WHERE / HAVING statements
 - um exemplo é por exemplo o MAX() nativo do sql, para este tipo de funcionalidades é muito útil
 - não é bom para transações pois não é atómico, não têm "exception handling"

SPs:
 - retorna (ou não!) um ou mais valores
 - não podem ser usados no SELECT / WHERE / HAVING statements
 - são atómicos e têm "exeption handling"
 - um exemplo de utilização é transações monetárias onde a atomicidade é essencial!
```
