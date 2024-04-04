# BD: Guião 6

## Problema 6.1

### *a)* Todos os tuplos da tabela autores (authors);

```
SELECT * FROM authors;
```

### *b)* O primeiro nome, o último nome e o telefone dos autores;

```
SELECT au_fname,au_lname,phone FROM authors;
```

### *c)* Consulta definida em b) mas ordenada pelo primeiro nome (ascendente) e depois o último nome (ascendente); 

```
SELECT au_fname,au_lname,phone FROM authors
ORDER BY au_fname,au_lname;
```

### *d)* Consulta definida em c) mas renomeando os atributos para (first_name, last_name, telephone); 

```
SELECT au_fname as first_name, au_lname as last_name, phone as telephone FROM authors
ORDER BY au_fname,au_lname;
```

### *e)* Consulta definida em d) mas só os autores da Califórnia (CA) cujo último nome é diferente de ‘Ringer’; 

```
SELECT au_fname as first_name, au_lname as last_name, phone as telephone FROM authors
WHERE state='CA' AND au_lname!='Ringer'
ORDER BY au_fname,au_lname;
```

### *f)* Todas as editoras (publishers) que tenham ‘Bo’ em qualquer parte do nome; 

```
SELECT * FROM publishers
WHERE pub_name LIKE '%Bo%';
```

### *g)* Nome das editoras que têm pelo menos uma publicação do tipo ‘Business’; 

```
SELECT DISTINCT publishers.pub_name 
FROM publishers Inner Join titles on publishers.pub_id = titles.pub_id 
WHERE [type]='Business';
```

### *h)* Número total de vendas de cada editora; 

```
SELECT publishers.pub_name, COUNT(sales.qty) AS Numero_vendas
FROM ( (publishers Inner Join titles on publishers.pub_id = titles.pub_id) Inner Join sales on titles.title_id = sales.title_id )
GROUP BY publishers.pub_name;
```

### *i)* Número total de vendas de cada editora agrupado por título; 

```
SELECT publishers.pub_name, titles.title, COUNT(sales.qty) AS Numero_vendas
FROM ( (publishers Inner Join titles on publishers.pub_id = titles.pub_id) Inner Join sales on titles.title_id = sales.title_id )
GROUP BY publishers.pub_name, titles.title;
```

### *j)* Nome dos títulos vendidos pela loja ‘Bookbeat’; 

```
SELECT stores.stor_name, titles.title
FROM ( (stores Inner Join sales on stores.stor_id = sales.stor_id) Inner Join titles on sales.title_id = titles.title_id )
WHERE stores.stor_name = 'Bookbeat'
```

### *k)* Nome de autores que tenham publicações de tipos diferentes; 

```
SELECT au_fname as 'First name', au_lname as 'Last name', COUNT(titles.type) AS 'Numero Tipo de Publicacoes'
FROM ( titles Inner Join titleauthor on titles.title_id=titleauthor.title_id) Inner Join authors on titleauthor.au_id = authors.au_id 
GROUP BY authors.au_fname, authors.au_lname
HAVING COUNT(titles.type) > 1;
```

### *l)* Para os títulos, obter o preço médio e o número total de vendas agrupado por tipo (type) e editora (pub_id);

```
... Write here your answer ...
```

### *m)* Obter o(s) tipo(s) de título(s) para o(s) qual(is) o máximo de dinheiro “à cabeça” (advance) é uma vez e meia superior à média do grupo (tipo);

```
... Write here your answer ...
```

### *n)* Obter, para cada título, nome dos autores e valor arrecadado por estes com a sua venda;

```
... Write here your answer ...
```

### *o)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, a faturação total, o valor da faturação relativa aos autores e o valor da faturação relativa à editora;

```
... Write here your answer ...
```

### *p)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, o nome de cada autor, o valor da faturação de cada autor e o valor da faturação relativa à editora;

```
... Write here your answer ...
```

### *q)* Lista de lojas que venderam pelo menos um exemplar de todos os livros;

```
... Write here your answer ...
```

### *r)* Lista de lojas que venderam mais livros do que a média de todas as lojas;

```
... Write here your answer ...
```

### *s)* Nome dos títulos que nunca foram vendidos na loja “Bookbeat”;

```
... Write here your answer ...
```

### *t)* Para cada editora, a lista de todas as lojas que nunca venderam títulos dessa editora; 

```
... Write here your answer ...
```

## Problema 6.2

### ​5.1

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_1_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_1_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
SELECT employee.Ssn, employee.Fname, employee.Minit, employee.Lname, project.Pname
FROM 
	employee JOIN works_on ON employee.Ssn=works_on.Essn
		  			JOIN project ON works_on.Pno=project.Pnumber
```

##### *b)* 

```
SELECT employee.Fname, employee.Minit, employee.Lname
FROM 
	employee JOIN 
				(SELECT employee.Ssn AS Ssn_carlos
					FROM employee
					WHERE employee.Fname='Carlos' AND employee.Minit='D' AND Lname='Gomes') AS T
    ON employee.Super_ssn=T.Ssn_carlos
```

##### *c)* 

```
SELECT P.Pname, T.Sum_hours
FROM project AS P JOIN (SELECT works_on.Pno , SUM(Hours) as Sum_hours 
												FROM works_on
												GROUP BY works_on.Pno) AS T
			ON P.Pnumber = T.Pno
```

##### *d)* 

```
SELECT employee.Fname, employee.Minit, employee.Lname
FROM 
	employee JOIN works_on 
	ON employee.Ssn=works_on.Essn
WHERE employee.Dno=3 AND works_on.Hours>20
```

##### *e)* 

```
... Write here your answer ...
```

##### *f)* 

```
... Write here your answer ...
```

##### *g)* 

```
... Write here your answer ...
```

##### *h)* 

```
... Write here your answer ...
```

##### *i)* 

```
... Write here your answer ...
```

### 5.2

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_2_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_2_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
... Write here your answer ...
```

##### *b)* 

```
... Write here your answer ...
```


##### *c)* 

```
... Write here your answer ...
```


##### *d)* 

```
... Write here your answer ...
```

### 5.3

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_3_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_3_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
... Write here your answer ...
```

##### *b)* 

```
... Write here your answer ...
```


##### *c)* 

```
... Write here your answer ...
```


##### *d)* 

```
... Write here your answer ...
```

##### *e)* 

```
... Write here your answer ...
```

##### *f)* 

```
... Write here your answer ...
```
