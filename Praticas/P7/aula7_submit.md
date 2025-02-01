# BD: Guião 7


## ​7.2 
 
### *a)*

```
A relação está na 1ªforma normal uma vez que todos os atributos são atómicos e não existem relações dentro de relações. A relação não está na 2FN pois existem dependências parciais. Por exemplo: Nome_Autor -> Afiliacao_Autor.
.
It is possible to <u>underline</u> -> {A, B,.. }
-> R1 (_A_, B, C)
-> R2 (B,F)
```

### *b)* 

```
Colocar na 2FN: A dependência parcial, Nome_Autor -> Afiliacao_Autor, deu origem a uma nova relação Relacao2(_Nome_Autor_, Afiliacao_Autor).
A relacao inicial fica: Livro (_Titulo_Livro_, _Nome_Autor_, Tipo_Livro, Preco, NoPaginas, Editor, Endereco_Editor, Ano_Publicacao)

Colocar na 3FN: As dependências transitivas deram origem a duas novas relações: Relacao3(_Tipo_Livro_, _NoPaginas_, Preco) e Relacao4(_Editor_, Endereco_Editor).
A relacao inicial fica: Livro(_Titulo_Livro_, _Nome_Autor_, Tipo_Livro, NoPaginas, Editor, Ano_Publicacao).
```




## ​7.3
 
### *a)*

```
{A,B}
```


### *b)* 

```
Colocar na 2FN: 
A dependência parcial, A -> D,E, deu origem a uma nova relação R2(_A_, D, E).
A dependência parcial, B -> F, deu origem a uma nova relação R3(_B_, F).
A relacao inicial fica: R(_A_,_B_,C,G,H,I,J) 

```

### *c)* 

```
Colocar na 3FN: As dependências transitivas deram origem a duas novas relações: R4(_F_, G, H) e R5(_D_, I, J).
A relacao inicial fica: R(_A_,_B_,C) 


```


## ​7.4
 
### *a)*

```
A chave de R é {A,B}.
```


### *b)* 

```
Colocar na 3FN: As dependências transitivas deram origem a duas novas relações: R2(_D_, E) e R3(_C_, A).
A relacao inicial fica: R(_A_,_B_, C, D) 
```


### *c)* 

```
Colocar na BCNF: 
R(_B_, _C_, D)
R2(_D_, E)
R3(_C_, A)
```



## ​7.5
 
### *a)*

```
A chave de R é {A,B}.
```

### *b)* 

```
A relação não está na 2FN pois existem dependências parciais. Por exemplo: A -> C.

R(_A_,_B_,D,E)
R2(_A_,C)
```


### *c)* 

```
Colocar na 3FN: A dependência transitiva, C -> D, deu origem a uma nova relação, R3. 
R(_A_,_B_,E)
R2(_A_,C)
R3(_C_,D)
```

### *d)* 

```
Já está na BCNF
```
