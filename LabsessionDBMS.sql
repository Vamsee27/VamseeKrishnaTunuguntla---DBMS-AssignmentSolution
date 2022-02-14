create database Ecommerce;

/*1)Table creation*/

create table Ecommerce.Supplier(
SUPP_ID int,
SUPP_NAME varchar(255),
SUPP_CITY varchar(255),
SUPP_PHONE bigint,
PRIMARY KEY (SUPP_ID));

create table Ecommerce.Customer(
CUS_ID int,
CUS_NAME varchar(255),
CUS_PHONE bigint,
CUS_CITY varchar(255),
CUS_GENDER varchar(255),
PRIMARY KEY (CUS_ID));

create table Ecommerce.Category(
CAT_ID int,
CAT_NAME varchar(255),
PRIMARY KEY (CAT_ID));

create table Ecommerce.Product(
PRO_ID int,
PRO_NAME varchar(255),
PRO_DESC varchar(255),
CAT_ID int,
PRIMARY KEY (PRO_ID),
FOREIGN KEY (CAT_ID) REFERENCES Ecommerce.Category(CAT_ID));

create table Ecommerce.ProductDetails(
PROD_ID int,
PRO_ID int,
SUPP_ID int,
PRICE bigint,
PRIMARY KEY (PROD_ID),
FOREIGN KEY (PRO_ID) REFERENCES Ecommerce.Product(PRO_ID),
FOREIGN KEY (SUPP_ID) REFERENCES Ecommerce.Supplier(SUPP_ID));

create table Ecommerce.Order(
ORD_ID int,
ORD_AMOUNT bigint,
ORD_DATE date,
CUS_ID int,
PROD_ID int,
PRIMARY KEY (ORD_ID),
FOREIGN KEY (CUS_ID) REFERENCES Ecommerce.Customer(CUS_ID),
FOREIGN KEY (PROD_ID) REFERENCES Ecommerce.ProductDetails(PROD_ID));

create table Ecommerce.Rating(
RAT_ID int,
CUS_ID int,
SUPP_ID int,
RAT_RATSTARS int,
PRIMARY KEY (RAT_ID),
FOREIGN KEY (CUS_ID) REFERENCES Ecommerce.Customer(CUS_ID),
FOREIGN KEY (SUPP_ID) REFERENCES Ecommerce.Supplier(SUPP_ID));

/*2)Inserting data to respective table*/

Insert into Ecommerce.Supplier values(1,'Rajesh Retails','Delhi',1234567890);
Insert into Ecommerce.Supplier values(2,'Appario Ltd.','Mumbai',2589631470);
Insert into Ecommerce.Supplier values(3,'Knome products','Banglore',9785462315);
Insert into Ecommerce.Supplier values(4,'Bansal Retails','Kochi',8975463285);
Insert into Ecommerce.Supplier values(5,'Mittal Ltd.','Lucknow',7898456532);

commit;

Insert into Ecommerce.Customer values(1,'AAKASH',9999999999,'DELHI','M');
Insert into Ecommerce.Customer values(2,'AMAN',9785463215,'NOIDA','M');
Insert into Ecommerce.Customer values(3,'NEHA',9999999999,'MUMBAI','F');
Insert into Ecommerce.Customer values(4,'MEGHA',9994562399,'KOLKATA','F');
Insert into Ecommerce.Customer values(5,'PULKIT',7895999999,'LUCKNOW','M');

commit;

Insert into Ecommerce.Category values(1,'BOOKS');
Insert into Ecommerce.Category values(2,'GAMES');
Insert into Ecommerce.Category values(3,'GROCERIES');
Insert into Ecommerce.Category values(4,'ELECTRONICS');
Insert into Ecommerce.Category values(5,'CLOTHES');

commit;

Insert into Ecommerce.Product values(1,'GTA V','DFJDJFDJFDJFDJFJF',2);
Insert into Ecommerce.Product values(2,'TSHIRT','DFDFJDFJDKFD',5);
Insert into Ecommerce.Product values(3,'ROG LAPTOP','DFNTTNTNTERND',4);
Insert into Ecommerce.Product values(4,'OATS','REURENTBTOTH',3);
Insert into Ecommerce.Product values(5,'HARRY POTTER','NBEMCTHTJTH',1);

commit;

Insert into Ecommerce.ProductDetails values(1,1,2,1500);
Insert into Ecommerce.ProductDetails values(2,3,5,30000);
Insert into Ecommerce.ProductDetails values(3,5,1,3000);
Insert into Ecommerce.ProductDetails values(4,2,3,2500);
Insert into Ecommerce.ProductDetails values(5,4,1,1000);

commit;

Insert into Ecommerce.Order values(20,1500,'2021-10-12',3,5);
Insert into Ecommerce.Order values(25,30500,'2021-09-16',5,2);
Insert into Ecommerce.Order values(26,2000,'2021-10-05',1,1);
Insert into Ecommerce.Order values(30,3500,'2021-08-16',4,3);
Insert into Ecommerce.Order values(50,2000,'2021-10-06',2,1);

commit;

Insert into Ecommerce.Rating values(1,2,2,4);
Insert into Ecommerce.Rating values(2,3,4,3);
Insert into Ecommerce.Rating values(3,5,1,5);
Insert into Ecommerce.Rating values(4,1,3,2);
Insert into Ecommerce.Rating values(5,4,5,4);

commit;

/*3)Display the number of the customer group by their genders who have placed any order of amount greater than or equal to Rs.3000.*/

select count(ord.cus_id), cust.CUS_GENDER
from Ecommerce.Order ord join Ecommerce.Customer cust on
cust.CUS_ID = ord.CUS_ID where
ord.ord_amount >= 3000
group by cust.CUS_GENDER;

/*4)Display all the orders along with the product name ordered by a customer having Customer_Id=2.*/

select ord.cus_id, cust.cus_name, ord.ord_id, prd.pro_desc from 
Ecommerce.Order ord, Ecommerce.Product prd, Ecommerce.ProductDetails prdd, Ecommerce.Customer cust where
prdd.prod_id = ord.prod_id and
ord.cus_id = cust.cus_id and
prdd.pro_id = prd.pro_id and
ord.CUS_ID = 2;

/*5)Display the Supplier details who can supply more than one product.*/

select sup.* from Ecommerce.ProductDetails prdd, Ecommerce.Supplier sup where
prdd.supp_id = sup.supp_id
group by prdd.supp_id having count(prdd.supp_id)>1;

/*6)Find the category of the product whose order amount is minimum.*/

select cat.* from 
Ecommerce.Order ord, Ecommerce.ProductDetails prdd, Ecommerce.Product prd, Ecommerce.Category cat
where ord.ord_amount in (
select min(ord_amount) from Ecommerce.Order) and
ord.prod_id = prdd.prod_id and
prdd.pro_id = prd.pro_id and
prd.cat_id = cat.cat_id;

/*7)Display the Id and Name of the Product ordered after “2021-10-05”.*/

select prd.pro_id, prd.pro_name from 
Ecommerce.Order ord, Ecommerce.ProductDetails prdd, Ecommerce.Product prd  
where 
ord.ord_date > '2021-10-05' and
ord.prod_id = prdd.prod_id and
prdd.pro_id = prd.pro_id;

/*8)Display customer name and gender whose names start or end with character 'A'.*/

select CUS_NAME,CUS_GENDER from Ecommerce.Customer where 
left(CUS_NAME,1) = 'A' or right(CUS_NAME,1) = 'A';

/*9)Create a stored procedure to display the Rating for a Supplier if any along with the Verdict on that rating if any like if rating >4 then “Genuine.*/
/* Kindly place below procedure in Stored procedure and apply the changes*/ 

drop procedure if exists Ecommerce.rateSupplier;
CREATE PROCEDURE `rateSupplier`(SUPP_ID int)
BEGIN
declare v_supp_id int default 0;
set v_supp_id = SUPP_ID;
	select rate.supp_id, rate. rat_ratstars,
	case 
	when rate.rat_ratstars > 4 then 'Genuine Supplier'
	when rate.rat_ratstars > 2 then 'Average Supplier'
	else 'Supplier should not be considered'
	end as verdict 
    from Ecommerce.Rating rate 
	where rate.SUPP_ID = SUPP_ID;
END;

/*calling procedure*/
call rateSupplier(1);
call rateSupplier(2);
call rateSupplier(3);
call rateSupplier(4);
call rateSupplier(5);





