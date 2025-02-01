# BD: Guião 3


## ​Problema 3.1
 
### *a)*

```
Aluguer (numero (PK), data, duracao, Cli_NIF (FK), Bal_numero (FK), Vei_matricula (FK))
Cliente (nome, NIF (PK), endereco, num_carta)
Balcao (nome, numero (PK), enderco)
Veiculo (matricula (PK), marca, ano, Tipo_codigo (FK))
Tipo_Veiculo (codigo (Pk), designacao, arcondicionado)
Similaridade_Tipo_Veiculo (cod_veiculo_1 (FK), cod_veiculo_2 (FK))
Ligeiro (numlugares, portas, combustivel, codigo (FK))
Pesado (peso, passgeiros, codigo (FK))

```


### *b)* 

```
Chaves candidadatas:
    Aluguer -> {número}
    Cliente -> {NIF}, {num_carta}
    Balcao -> {número}
    Veiculo -> {matrícula}
    Tipo_Veiculo -> {codigo}
    Similaridade_Tipo_Veiculo -> {cod_veiculo_1, cod_veiculo_2}
    Ligeiro -> {codigo}
    Pesado -> {codigo}
Chaves primarias:
    Aluguer -> {número}
    Cliente -> {NIF}
    Balcao -> {número}
    Veiculo -> {matrícula}
    Tipo_Veiculo -> {codigo}
    Similaridade_Tipo_Veiculo -> {cod_veiculo_1, cod_veiculo_2}
    Ligeiro -> {codigo}
    Pesado -> {codigo}
Chaves estrangueiras:
    Aluguer -> {Vei_matricula}, {Bal_numero}, {Cli_NIF}
    Cliente ->
    Balcao -> 
    Veiculo -> {Tipo_codigo}
    Tipo_Veiculo -> 
    Similaridade_Tipo_Veiculo -> {cod_veiculo_1}, {cod_veiculo_2}
    Ligeiro -> {codigo}
    Pesado -> {codigo}

```


### *c)* 

![ex_3_1c!](ex_3_1c.jpg "AnImage")


## ​Problema 3.2

### *a)*

```
Airport (Airport_code (PK), City, State, Name)
Airplane_type (Type_name (PK), Company, Max_seats)
Airplane (Airplane_id (PK), Total_no_of_seats, Type_name (PK) )
Flight (Number (PK), Airline, Weekdays)
Flight_leg (Flight_Number (FK), Leg_no (PK), Airport_code, Scheduled_dep_time
, Scheduled_arr_time)
Fare (Flight_Number (FK), Code (PK), Amount, Restrictions)
Leg_instance (Flight_Number (FK), Leg_no (FK), Date (PK), No_of_avail_seats, Airplane_id, Dep_time, Arr_time, Airport_code)
Seat (Flight_Number (FK), Leg_no (FK), Date (FK), Seat_no (PK), Customer_name, Cphone)
Can_land (Type_name (FK), Airport_code (FK))


```


### *b)* 

```
Chaves candidadatas:
    Airport -> {Airport_code}
    Airplane_type -> {Type_name}
    Airplane -> {Airplane_id}
    Flight -> {Number}
    Flight_leg -> {Leg_no} 
    Fare -> {Code} 
    Leg_instance -> {Date}
    Seat -> {Seat_no}
    Can_land -> {Type_name, Airport_code}

Chaves primárias:
    Airport -> {Airport_code}
    Airplane_type -> {Type_name}
    Airplane -> {Airplane_id, Type_name}
    Flight -> {Number}
    Flight_leg -> {Flight_Number, Leg_no} 
    Fare -> {Flight_Number, Code} 
    Leg_instance -> {Flight_Number, Leg_no, Date}
    Seat -> {Flight_Number, Leg_no, Date, Seat_no}
    Can_land -> {Type_name, Airport_code}

Chaves estrangeiras:
    Airport -> 
    Airplane_type -> 
    Airplane -> {Type_name}
    Flight -> 
    Flight_leg -> {Airport_code, Flight_Number} 
    Fare -> {Flight_Number} 
    Leg_instance -> {Flight_Number, Leg_no, Airport_code}
    Seat -> {Flight_Number, Leg_no, Date}
    Can_land -> {Type_name, Airport_code}
```


### *c)* 

![ex_3_2c!](ex_3_2c.jpg "AnImage")


## ​Problema 3.3


### *a)* 2.1

![ex_3_3_a!](ex_3_3a.jpg "AnImage")

### *b)* 2.2

![ex_3_3_b!](ex_3_3b.jpg "AnImage")

### *c)* 2.3

![ex_3_3_c!](ex_3_3c.jpg "AnImage")

### *d)* 2.4

![ex_3_3_d!](ex_3_3d.jpg "AnImage")