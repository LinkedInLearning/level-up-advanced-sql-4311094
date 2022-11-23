CREATE TABLE sales (
salesId INTEGER PRIMARY KEY,
inventoryId int,
customerId int,
employeeId int,
salesAmount decimal(6,2),
soldDate datetime
);

INSERT INTO sales (inventoryId, customerId, employeeId, salesAmount, soldDate) values (14,1,3,10000.99,'2022-01-17');
INSERT INTO sales (inventoryId, customerId, employeeId, salesAmount, soldDate) values (13,45,5,21459.99,'2022-01-17');
INSERT INTO sales (inventoryId, customerId, employeeId, salesAmount, soldDate) values (10,33,6,34000.99,'2022-01-17');
INSERT INTO sales (inventoryId, customerId, employeeId, salesAmount, soldDate) values (9,17,11,15550.99,'2022-01-17');
INSERT INTO sales (inventoryId, customerId, employeeId, salesAmount, soldDate) values (23,7,12,9989.99,'2022-01-17');
INSERT INTO sales (inventoryId, customerId, employeeId, salesAmount, soldDate) values (3,23,14,45000.99,'2022-03-01');
INSERT INTO sales (inventoryId, customerId, employeeId, salesAmount, soldDate) values (24,24,15,16599.99,'2022-03-17');
INSERT INTO sales (inventoryId, customerId, employeeId, salesAmount, soldDate) values (19,2,19,14999.99,'2022-03-15');
INSERT INTO sales (inventoryId, customerId, employeeId, salesAmount, soldDate) values (11,49,21,25550.99,'2022-02-01');
INSERT INTO sales (inventoryId, customerId, employeeId, salesAmount, soldDate) values (12,47,21,10550.99,'2022-03-01');
