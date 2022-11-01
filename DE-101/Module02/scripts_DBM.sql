-- Создание таблицы returns
CREATE TABLE 'returns'
(
 Returned varchar(10) NOT NULL,
 Row_ID   int not null NOT NULL,
 Order_id varchar(20) NOT NULL,
 CONSTRAINT FK_2 FOREIGN KEY ( Row_ID ) REFERENCES orders ( Row_ID )
);

CREATE INDEX FK_1 ON returns
(
 Row_ID
);


-- Создание таблицы people
CREATE TABLE people
(
 Person varchar(17) NOT NULL,
 Region varchar(7) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( Person )
);


-- Создание таблицы orders
CREATE TABLE orders
(
 Row_ID        int not null NOT NULL,
 Order_ID      varchar(14) NOT NULL,
 Person        varchar(17) NOT NULL,
 Order_Date    date NOT NULL,
 Ship_Date     date NOT NULL,
 Ship_Mode     varchar(14) NOT NULL,
 Customer_ID   varchar(8) NOT NULL,
 Customer_Name varchar(22) NOT NULL,
 Segment       varchar(11) NOT NULL,
 Country       varchar(13) NOT NULL,
 City          varchar(17) NOT NULL,
 "State"         varchar(20) NOT NULL,
 Postal_Code   integer NULL,
 Region        varchar(7) NOT NULL,
 Product_ID    varchar(15) NOT NULL,
 Category      varchar(15) NOT NULL,
 SubCategory   varchar(11) NOT NULL,
 Product_Name  varchar(127) NOT NULL,
 Sales         numeric(9,4) NOT NULL,
 Quantity      integer NOT NULL,
 Discount      numeric(4,2) NOT NULL,
 Profit        numeric(21,16) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( Row_ID ),
 CONSTRAINT FK_1 FOREIGN KEY ( Person ) REFERENCES people ( Person )
);

CREATE INDEX FK_2 ON orders
(
 Person
);
