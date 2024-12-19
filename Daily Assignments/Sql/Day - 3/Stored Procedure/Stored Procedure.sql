use mydb;
insert into customer values(123,'Krishna','Kerala',28);
insert into customer values(2456,'Kavin','TN',26);
insert into customer values(3478,'Akash','TN',24);

CREATE PROCEDURE 
GetCustomerInf
AS
BEGIN
    SELECT * 
    FROM customer 
    WHERE Age > 25;
END;

GetCustomerInf;


