-- a)
/*
SELECT employee.Ssn, employee.Fname, employee.Minit, employee.Lname, project.Pname
FROM 
	employee JOIN works_on ON employee.Ssn=works_on.Essn
		  			JOIN project ON works_on.Pno=project.Pnumber
*/

-- b)
SELECT employee.Fname, employee.Minit, employee.Lname
FROM 
	employee JOIN 
				(SELECT employee.Ssn AS Ssn_carlos
					FROM employee
					WHERE employee.Fname='Carlos' AND employee.Minit='D' AND Lname='Gomes') AS T
	ON employee.Super_ssn=T.Ssn_carlos



