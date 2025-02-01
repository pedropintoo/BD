GO
ALTER Trigger TriggerEx1c ON Employee
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
GO