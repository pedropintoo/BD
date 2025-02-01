-- Testar inser��o de um novo departamento com um gestor que j� � gestor de outro departamento
INSERT INTO department (Dname, Dnumber, Mgr_ssn, Mgr_start_date)
VALUES ('Fisica', 6, 21312332, GETDATE() );  -- 21312332 j� � gestor do departamento 'Investigacao' com Dnumber=1

-- Testar atualiza��o de um departamento para definir um gestor que j� � gestor de outro departamento
UPDATE department
SET Mgr_ssn = 21312332  -- 21312332 j� � gestor do departamento 'Investigacao' com Dnumber=1
WHERE Dnumber = 2;

SELECT * FROM department