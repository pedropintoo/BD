-- Testar inserção de um novo departamento com um gestor que já é gestor de outro departamento
INSERT INTO department (Dname, Dnumber, Mgr_ssn, Mgr_start_date)
VALUES ('Fisica', 6, 21312332, GETDATE() );  -- 21312332 já é gestor do departamento 'Investigacao' com Dnumber=1

-- Testar atualização de um departamento para definir um gestor que já é gestor de outro departamento
UPDATE department
SET Mgr_ssn = 21312332  -- 21312332 já é gestor do departamento 'Investigacao' com Dnumber=1
WHERE Dnumber = 2;

SELECT * FROM department