GO
USE Company
GO

ALTER PROC EmployeeEx01 @Ssn int
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
		