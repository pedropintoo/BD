-- stored procedure que retorne um record-set com os funcionários gestores 
-- de departamentos, assim como o ssn e número de anos (como gestor) do funcionário 
-- mais antigo dessa lista. 

GO
CREATE PROCEDURE company.employee
AS 
SELECT employee.Fname, employee.Lname, employee.ssn
FROM company.employee;
GO