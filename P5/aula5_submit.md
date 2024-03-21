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
... Write here your answer ...
π Fname,Minit,Lname (σ (Dno=3 ∧ Hours>20) (employee ⨝Ssn=Essn works_on))
```


### *e)* 

```
... Write here your answer ...
π Fname,Minit,Lname (σ Essn=null (employee ⟕Ssn=Essn works_on))
```


### *f)* 

```
... Write here your answer ...
```


### *g)* 

```
... Write here your answer ...
```


### *h)* 

```
... Write here your answer ...
```


### *i)* 

```
... Write here your answer ...
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
... Write here your answer ...
```


### *d)* 

```
... Write here your answer ...
```

### *e)* 

```
... Write here your answer ...
```

### *f)* 

```
... Write here your answer ...
```
