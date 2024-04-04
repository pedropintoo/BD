-- a)
/*
SELECT employee.Ssn, employee.Fname, employee.Minit, employee.Lname, project.Pname
FROM 
	employee JOIN works_on ON employee.Ssn=works_on.Essn
		  			JOIN project ON works_on.Pno=project.Pnumber
*/

-- b)
/*
SELECT employee.Fname, employee.Minit, employee.Lname
FROM 
	employee JOIN 
				(SELECT employee.Ssn AS Ssn_carlos
					FROM employee
					WHERE employee.Fname='Carlos' AND employee.Minit='D' AND Lname='Gomes') AS T
	ON employee.Super_ssn=T.Ssn_carlos
*/

-- c)
/*
SELECT P.Pname, T.Sum_hours
FROM project AS P JOIN (SELECT works_on.Pno , SUM(Hours) as Sum_hours 
												FROM works_on
												GROUP BY works_on.Pno) AS T
			ON P.Pnumber = T.Pno
*/

-- d)
/*
SELECT employee.Fname, employee.Minit, employee.Lname
FROM 
	employee JOIN works_on 
	ON employee.Ssn=works_on.Essn
WHERE employee.Dno=3 AND works_on.Hours>20
*/

-- e)
/*
SELECT employee.Fname,	employee.Minit, employee.Lname
FROM 
	employee LEFT JOIN works_on
	ON employee.Ssn=works_on.Essn
WHERE works_on.Essn IS NULL
*/

-- f)
/*
SELECT T.Dname, avg(T.Salary) AS Avg_salary
FROM (SELECT *
			FROM 
				employee JOIN department
				ON employee.Dno = department.Dnumber
			WHERE employee.Sex='F') as T
GROUP BY T.Dname
*/

-- g)


SELECT employee.Ssn, employee.Fname, employee.Minit, employee.Lname, COUNT(employee.Ssn) AS cont
FROM 
	employee JOIN dependent
	ON employee.Ssn=dependent.Essn
GROUP BY employee.Ssn, employee.Fname, employee.Minit, employee.Lname
HAVING count(employee.Ssn) > 2
