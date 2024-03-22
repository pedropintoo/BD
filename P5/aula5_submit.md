# BD: Guião 5


## ​Problema 5.1
 
### *a)*

```
π Ssn,Fname,Minit,Lname,Pname (employee ⨝ Ssn=Essn (works_on ⨝ Pno=Pnumber (project)))	
```


### *b)* 

```
π Fname,Minit,Lname (employee ⨝ Super_ssn=Ssn_carlos (ρ Ssn_carlos←Ssn (π Ssn (σ Fname='Carlos' ∧ Minit='D' ∧ Lname='Gomes' (employee)))))
```


### *c)* 

```
π Pname, Sum_hours ((γ Pno; sum(Hours) -> Sum_hours (works_on)) ⨝ Pno=Pnumber project)
```


### *d)* 

```
π Fname,Minit,Lname (σ (Dno=3 ∧ Hours>20) (employee ⨝Ssn=Essn works_on))
```


### *e)* 

```
π Fname,Minit,Lname (σ Essn=null (employee ⟕Ssn=Essn works_on))
```


### *f)* 

```
γ Dname;avg(Salary)->salario_medio ( σ Sex='F' (employee ⨝Dno=Dnumber department) )
```


### *g)* 

```
σ dependentes > 2 ( γ Ssn,Fname,Minit,Lname;count(Dependent_name)->dependentes (employee ⨝Ssn=Essn dependent) )
```


### *h)* 

```
π Ssn,Fname,Minit,Lname ( σ dependent.Essn=null ( (employee ⨝Ssn=Mgr_ssn department)⟕Ssn=Essn dependent ) )


```


### *i)* 

```
π Fname,Minit,Lname,Address (σ Dlocation≠'Aveiro' ∧ Plocation='Aveiro' (  ( project ⨝Pnumber=Pno (employee ⨝Ssn=Essn works_on) ) ⨝Dno=Dnumber (π department.Dnumber,Dname,Dlocation (department ⨝department.Dnumber=dept_location.Dnumber dept_location)) ))
```


## ​Problema 5.2

### *a)*

```
π nif,nome (σ numero=NULL ((encomenda) ⟖ fornecedor=nif (fornecedor)))
```

### *b)* 

```
π nome, avg_units ((γ codProd; avg(unidades ) -> avg_units (item)) ⨝ codProd=codigo (produto))
```


### *c)* 

```
γ avg(count_products) -> avg_products (γ numEnc; count(numEnc)->count_products (item))
```


### *d)* 

```
π fornecedor.nome, produto.nome, count_products ((γ nif, nome,codProd; count(codProd)->count_products (fornecedor ⨝ nif=fornecedor (item ⨝ numEnc=numero encomenda))) ⨝ codProd=codigo (produto))
```


## ​Problema 5.3

### *a)*

```
π nome (σ numPresc=NULL ((paciente) ⟕ paciente.numUtente=prescricao.numUtente (prescricao)))
```

### *b)* 

```
γ especialidade; count(numPresc)->count_numPresc ((medico) ⨝ numSNS=numMedico (prescricao))
```


### *c)* 

```
γ nome; count(numPresc)->numero_prescricoes ( farmacia ⨝nome=farmacia prescricao )
```


### *d)* 

```
( π nome (σ numRegFarm=906 (farmaco)) ) - ( π nomeFarmaco ( σ numRegFarm=906 presc_farmaco ) ) 
```

### *e)* 

```
γ farmacia.nome, farmaceutica.nome ; count(farmaceutica.nome)->vendas ( (π presc_farmaco.numPresc, farmaceutica.nome, nomeFarmaco, farmacia.nome (farmaceutica ⨝numReg=numRegFarm (π presc_farmaco.numPresc, numRegFarm, nomeFarmaco, farmacia.nome ( presc_farmaco ⨝presc_farmaco.numPresc=prescricao.numPresc (prescricao ⨝farmacia=nome farmacia) )) )) )
```

### *f)* 

```
... Write here your answer ...
```
