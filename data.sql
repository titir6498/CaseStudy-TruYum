-- Initial Setup
USE TruYumDB;

INSERT INTO MenuItems VALUES(
1,'Sandwich',99.0,'Yes','20170315','Main Course','Yes'),
(2,'Burger',129.0,'Yes','20171223','Main Course','No'),
(3,'Pizza',149.0,'Yes','20170821','Main Course','No'),
(4,'French Fries',57.0,'No','20170702','Starters','Yes'),
(5,'Chocolate Brownie',32.0,'Yes','20221102','Dessert','Yes');
SELECT * FROM MenuItems;

INSERT INTO Users VALUES(101,'Amy'),(276,'Rick');
SELECT * FROM Users;

--View menu items (Admin)
SELECT [Name],Price,Active,DateOfLaunch,Category,FreeDelivery FROM MenuItems;

-- View menu items (Customer)
SELECT [Name], FreeDelivery, Price, Category FROM MenuItems
WHERE Active='Yes' AND (DATEDIFF(SECOND,DateOfLaunch,GETDATE()) > 0);

-- Edit menu items (Admin)
DECLARE @somePrice AS MONEY;
SET @somePrice=100.00; -- dummy value
UPDATE MenuItems SET Price=@somePrice WHERE MenuItemId=1;

-- Add item to cart (Customer)
DECLARE @ItemId AS INT,@UserOne INT;
SET @ItemId = 1;
SET @UserOne = 276;
INSERT INTO Cart VALUES(1001,@ItemId, @UserOne, 'Sandwich','Yes',99.0);
SET @ItemId = 2;
INSERT INTO Cart VALUES(1002,@ItemId,@UserOne,'Burger','No',129.0);
SET @ItemId = 3;
INSERT INTO Cart VALUES(1003,@ItemId,@UserOne,'Pizza','No',149.0);

-- View cart (Customer)
DECLARE @UserView AS INT;
SET @UserView = 276;
SELECT * FROM Cart WHERE UserId=@UserView;
SELECT SUM(Price) AS TotalCost FROM Cart WHERE UserId=@UserView;

-- Remove from cart (Customer)
DECLARE @UserDel AS INT, @CartItem AS INT;
SET @CartItem = 1001;
SET @UserDel = 276;
DELETE FROM Cart WHERE UserId=@UserDel AND CartItemId=@CartItem;