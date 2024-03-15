CREATE DATABASE Airport_Management;
GO
USE Airport_Management;
GO

CREATE TABLE Airport(
    Airport_code        VARCHAR NOT NULL,
    City                VARCHAR NOT NULL,
    [state]             VARCHAR NOT NULL,
    [name]              VARCHAR NOT NULL,
    PRIMARY KEY (Airport_code)
);

CREATE TABLE Airplane_type(
    [Type_name]           VARCHAR NOT NULL ,
    Company               VARCHAR NOT NULL,
    Max_seats             INT NOT NULL
    PRIMARY KEY ([Type_name])
);

CREATE TABLE Airplane(
    Airplane_id         VARCHAR NOT NULL,
    Total_no_of_seats   INT NOT NULL,
    [Type_name]         VARCHAR NOT NULL,
    PRIMARY KEY (Airplane_id),
    FOREIGN KEY ([Type_name]) REFERENCES Airplane_type([Type_name])
);

CREATE TABLE Flight(
    [Number]              INT NOT NULL,
    Airline               VARCHAR NOT NULL,
    Weekdays              VARCHAR NOT NULL,
    PRIMARY KEY ([Number]) 
);

CREATE TABLE Flight_leg (
    Flight_number         INT NOT NULL,
    Leg_no                INT NOT NULL,
    Airport_code          VARCHAR NOT NULL,
    Scheduled_dep_time    VARCHAR NOT NULL,  
    Scheduled_arr_time    VARCHAR NOT NULL,
    PRIMARY KEY (Flight_number,Leg_no),
    FOREIGN KEY (Flight_number) REFERENCES Flight([Number]),
    FOREIGN KEY (Airport_code) REFERENCES Airport(Airport_code)
);

CREATE TABLE Fare (
    Flight_number         INT NOT NULL,
    Code                  VARCHAR NOT NULL,
    Amount                INT NOT NULL,
    Restrictions          VARCHAR NOT NULL,   
    PRIMARY KEY (Flight_number, Code),
    FOREIGN KEY (Flight_number) REFERENCES Flight([Number])
);

CREATE TABLE Leg_instance (
    Flight_number         INT NOT NULL,
    Leg_no                INT NOT NULL,
    [Date]                VARCHAR NOT NULL,
    No_of_avail_seats     INT NOT NULL,
    Airplane_id           VARCHAR NOT NULL,
    Dep_time              VARCHAR NOT NULL,
    Arr_time              VARCHAR NOT NULL,
    Airport_code          VARCHAR NOT NULL,
    PRIMARY KEY (Flight_number,Leg_no,[Date]),
    FOREIGN KEY (Flight_number) REFERENCES Flight([Number]),
    FOREIGN KEY (Flight_number,Leg_no) REFERENCES Flight_leg(Flight_number,Leg_no),
    FOREIGN KEY (Airplane_id) REFERENCES Airplane(Airplane_id),
    FOREIGN KEY (Airport_code) REFERENCES Airport(Airport_code)
);

CREATE TABLE Seat (
    Flight_number         INT NOT NULL,
    Leg_no                INT NOT NULL,
    [Date]                VARCHAR NOT NULL,
    Seat_no               INT NOT NULL,
    Customer_name         VARCHAR NOT NULL,
    Cphone                VARCHAR NOT NULL,
    PRIMARY KEY (Flight_number,Leg_no,[Date],Seat_no),
    FOREIGN KEY (Flight_number) REFERENCES Flight([Number]),
    FOREIGN KEY (Flight_number,Leg_no) REFERENCES Flight_leg(Flight_number,Leg_no),
	FOREIGN KEY (Flight_number,Leg_no,[Date]) REFERENCES Leg_instance(Flight_number,Leg_no,[Date]),
);

CREATE TABLE Can_land (
    [Type_name]             VARCHAR NOT NULL ,
    Airport_code          VARCHAR NOT NULL,
    PRIMARY KEY ([Type_name], Airport_code),
    FOREIGN KEY ([Type_name]) REFERENCES Airplane_type([Type_name]),
    FOREIGN KEY (Airport_code) REFERENCES Airport(Airport_code)
);