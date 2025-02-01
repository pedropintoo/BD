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
CREATE FUNCTION dbo.GetEmployeeProjects (@Ssn INT)
RETURNS TABLE
AS
RETURN (
    SELECT 
        p.Pname AS ProjectName, 
        p.Plocation AS ProjectLocation
    FROM 
        works_on w
    INNER JOIN 
        project p ON w.Pno = p.Pnumber
    WHERE 
        w.Essn = @Ssn
);
GO
```

### *f)* 

```
CREATE FUNCTION dbo.GetEmployeesAboveAverageSalary (@Dno INT)
RETURNS TABLE
AS
RETURN (
    WITH AverageSalary AS (
        SELECT AVG(Salary) AS AvgSalary
        FROM employee
        WHERE Dno = @Dno
    )
    SELECT 
        e.Fname,
        e.Minit,
        e.Lname,
        e.Salary,
        e.Dno
    FROM 
        employee e
    CROSS JOIN 
        AverageSalary a
    WHERE 
        e.Dno = @Dno AND e.Salary > a.AvgSalary
);
GO
```

### *g)* 

```
CREATE FUNCTION dbo.GetProjectBudgets (@Dnum INT)
RETURNS @ProjectBudget TABLE (
    pname VARCHAR(50),
    pnumber INT,
    plocation VARCHAR(50),
    dnum INT,
    budget DECIMAL(10, 2),
    totalbudget DECIMAL(10, 2)
)
AS
BEGIN
    DECLARE 
        @pname VARCHAR(50),
        @pnumber INT,
        @plocation VARCHAR(50),
        @budget DECIMAL(10, 2),
        @totalbudget DECIMAL(10, 2) = 0;

    -- Cursor to iterate over the department's projects
    DECLARE project_cursor CURSOR FOR
    SELECT 
        p.Pname, 
        p.Pnumber, 
        p.Plocation
    FROM 
        project p
    WHERE 
        p.Dnum = @Dnum;

    OPEN project_cursor;
    FETCH NEXT FROM project_cursor INTO @pname, @pnumber, @plocation;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Calculate the monthly labor budget for the project
        SELECT @budget = SUM((e.Salary / 160.0) * w.Hours * 4) 
        FROM 
            works_on w
        JOIN 
            employee e ON w.Essn = e.Ssn
        WHERE 
            w.Pno = @pnumber;

        -- Accumulate the budget amount
        SET @totalbudget = @totalbudget + @budget;

        -- Insert the result into the return table
        INSERT INTO @ProjectBudget (pname, pnumber, plocation, dnum, budget, totalbudget)
        VALUES (@pname, @pnumber, @plocation, @Dnum, @budget, @totalbudget);

        FETCH NEXT FROM project_cursor INTO @pname, @pnumber, @plocation;
    END

    CLOSE project_cursor;
    DEALLOCATE project_cursor;

    RETURN;
END;
GO
```

### *h)* 

```

-- Creation of INSTEAD OF DELETE trigger
CREATE TRIGGER trg_InsteadOfDeleteDepartment
ON department
INSTEAD OF DELETE
AS
BEGIN
    -- Check if the department_deleted table exists
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES  
                   WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'department_deleted')
    BEGIN
        -- Create the department_deleted table if it does not exist
        EXEC('CREATE TABLE dbo.department_deleted (
            Dname VARCHAR(16),
            Dnumber INT NOT NULL,
            Mgr_ssn INT,
            Mgr_start_date DATE,
            PRIMARY KEY (Dnumber),
            UNIQUE(Dname)
        )');
    END;

    -- Insert the records that would be deleted into the department_deleted table, if they do not exist
    INSERT INTO department_deleted (Dname, Dnumber, Mgr_ssn, Mgr_start_date)
    SELECT Dname, Dnumber, Mgr_ssn, Mgr_start_date
    FROM deleted
    WHERE NOT EXISTS (SELECT 1 FROM department_deleted WHERE Dnumber = deleted.Dnumber);

    -- Delete the related records in the works_on table
    DELETE FROM works_on
    WHERE Pno IN (SELECT Pnumber FROM project WHERE Dnum IN (SELECT Dnumber FROM deleted));

    -- Delete the related records in the project table
    DELETE FROM project
    WHERE Dnum IN (SELECT Dnumber FROM deleted);

    -- Delete the related records in the dept_locations table
    DELETE FROM dept_locations
    WHERE Dnumber IN (SELECT Dnumber FROM deleted);

    -- Delete the related records in the employee table
    UPDATE employee
    SET Dno = NULL
    WHERE Dno IN (SELECT Dnumber FROM deleted);

    -- Execute the DELETE operation on the department table
    DELETE FROM department
    WHERE Dnumber IN (SELECT Dnumber FROM deleted);
END;
GO

-- Exemplo de teste para a trigger
DELETE FROM department WHERE Dnumber = 3;

---------------------------------------------------------------------------


-- Creation of AFTER DELETE trigger
CREATE TRIGGER trg_AfterDeleteDepartment
ON department
AFTER DELETE
AS
BEGIN
    -- Check if the department_deleted table exists
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES  
                   WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'department_deleted')
    BEGIN
        -- Create the department_deleted table if it does not exist
        EXEC('CREATE TABLE dbo.department_deleted (
            Dname VARCHAR(16),
            Dnumber INT NOT NULL,
            Mgr_ssn INT,
            Mgr_start_date DATE,
            PRIMARY KEY (Dnumber),
            UNIQUE(Dname)
        )');
    END;

    -- Insert the records that would be deleted into the department_deleted table, if they do not exist
    INSERT INTO department_deleted (Dname, Dnumber, Mgr_ssn, Mgr_start_date)
    SELECT Dname, Dnumber, Mgr_ssn, Mgr_start_date
    FROM deleted
    WHERE NOT EXISTS (SELECT 1 FROM department_deleted WHERE Dnumber = deleted.Dnumber);

END;
GO


-- Step 1: Delete related records in the works_on table
DELETE FROM works_on
WHERE Pno IN (SELECT Pnumber FROM project WHERE Dnum = 3);

-- Step 2: Delete related records in the project table
DELETE FROM project
WHERE Dnum = 3;

-- Step 3: Delete related records in the dept_locations table
DELETE FROM dept_locations
WHERE Dnumber = 3;

-- Step 4: Update related records in the employee table
UPDATE employee
SET Dno = NULL
WHERE Dno = 3;

-- Step 5: Delete the department
DELETE FROM department WHERE Dnumber = 3;


Conclusões: 
O trigger INSTEAD OF DELETE substitui a execução da instrução DELETE na tabela alvo, permitindo executar uma lógica personalizada no lugar da operação.
A trigger AFTER DELETE é executada automaticamente após a execução de uma instrução DELETE na tabela alvo.
Como a operação DELETE já ocorreu antes da execução do trigger, a lógica adicional para manipulação de registos relacionados foi realizada fora do trigger. 
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
