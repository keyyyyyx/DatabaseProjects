CREATE DATABASE AnimalShelter

USE AnimalShelter

CREATE TABLE tblSHELTER
(ShelterID INT IDENTITY(1,1) PRIMARY KEY,
ShelterName VARCHAR(30) NOT NULL,
StreetAddress VARCHAR(50) NULL,
ShelterCity VARCHAR(30) NULL,
ShelterState VARCHAR(20) NULL,
ShelterZip VARCHAR(20) NULL)

CREATE TABLE tblPOSITION_TYPE
(PositionTypeID INT IDENTITY(1,1) PRIMARY KEY,
PositionTypeName VARCHAR(30) NOT NULL,
PositionTypeDescr VARCHAR(500) NULL)

CREATE TABLE tblPOSITION
(PositionID INT IDENTITY(1,1) PRIMARY KEY,
PositionName VARCHAR(30) NOT NULL,
PositionTypeID INT FOREIGN KEY REFERENCES tblPOSITION_TYPE(PositionTypeID) NOT NULL,
ShelterID INT FOREIGN KEY REFERENCES tblSHELTER(ShelterID) NOT NULL,
PositionDescr VARCHAR(500) NULL)

CREATE TABLE tblEMPLOYEE
(EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
EmployeeFname VARCHAR(30) NOT NULL,
EmployeeLname VARCHAR(30) NOT NULL,
EmployeeBirth DATE NOT NULL,
EmployeeStreetAddress VARCHAR(50) NULL,
EmployeeCity VARCHAR(30) NULL,
EmployeeState VARCHAR(20) NULL,
EmployeeZip VARCHAR(20) NULL,
Email VARCHAR(30) NULL)

CREATE TABLE tblEMPLOYEE_POSITION
(EmployeePositionID INT IDENTITY(1,1) PRIMARY KEY,
PositionID INT FOREIGN KEY REFERENCES tblPOSITION(PositionID) NOT NULL,
EmployeeID INT FOREIGN KEY REFERENCES tblEMPLOYEE(EmployeeID) NOT NULL,
DateBegin Date NOT NULL,
DateEnd Date NULL)

CREATE TABLE tblSHIFT
(ShiftID INT IDENTITY(1,1) PRIMARY KEY,
ShiftName VARCHAR(30) NOT NULL,
ShiftDescr VARCHAR(300) NULL,
StartTime TIME NOT NULL,
EndTime TIME NOT NULL)

CREATE TABLE tblEMPLOYEE_SHIFT
(EmpShiftID INT IDENTITY(1,1) PRIMARY KEY,
ShiftID INT FOREIGN KEY REFERENCES tblSHIFT(ShiftID) NOT NULL,
EmployeeID INT FOREIGN KEY REFERENCES tblEMPLOYEE(EmployeeID) NOT NULL,
ShiftDate DATE NOT NULL)

CREATE TABLE tblANIMAL_TYPE
(AnimalTypeID INT IDENTITY(1,1) PRIMARY KEY,
AnimalTypeName VARCHAR(30) NOT NULL,
AnimalTypeDescr VARCHAR(300) NULL)

CREATE TABLE tblANIMAL
(AnimalID INT IDENTITY(1,1) PRIMARY KEY,
AnimalName VARCHAR(30) NOT NULL,
AnimalTypeID INT FOREIGN KEY REFERENCES tblANIMAL_TYPE(AnimalTypeID) NOT NULL,
AnimalBirth DATE NOT NULL)

CREATE TABLE tblEVENT_TYPE
(EventTypeID INT IDENTITY(1,1) PRIMARY KEY,
EventTypeName VARCHAR(30) NOT NULL,
EventTypeDescr VARCHAR(500) NULL)

CREATE TABLE tblEVENT
(EventID INT IDENTITY(1,1) PRIMARY KEY,
EventName VARCHAR(50) NOT NULL,
EventTypeID INT FOREIGN KEY REFERENCES tblEVENT_TYPE(EventTypeID) NOT NULL,
ShelterID INT FOREIGN KEY REFERENCES tblSHELTER(ShelterID) NOT NULL,
EventDate DATE NOT NULL)

CREATE TABLE tblANIMAL_EVENT
(AnimalEventID INT IDENTITY(1,1) PRIMARY KEY,
AnimalEventName VARCHAR(50) NOT NULL,
AnimalID INT FOREIGN KEY REFERENCES tblANIMAL(AnimalID) NOT NULL,
EventID INT FOREIGN KEY REFERENCES tblEVENT(EventID) NOT NULL)

CREATE TABLE tblADOPTER
(AdopterID INT IDENTITY(1,1) PRIMARY KEY,
AdopterFname VARCHAR(30) NOT NULL,
AdopterLname VARCHAR(30) NOT NULL,
AdopterBirth DATE NOT NULL,
StreetAddress VARCHAR(50) NULL,
AdopterCity VARCHAR(30) NULL,
AdopterState VARCHAR(20) NULL,
AdopterZip VARCHAR(20) NULL,
Email VARCHAR(30) NULL)

CREATE TABLE tblADOPTER_EVENT
(AdopterEventID INT IDENTITY(1,1) PRIMARY KEY,
AdopterID INT FOREIGN KEY REFERENCES tblADOPTER(AdopterID) NOT NULL,
EventID INT FOREIGN KEY REFERENCES tblEVENT(EventID) NOT NULL)

CREATE TABLE tblPURCHASE_ORDER
(PurchaseOrderID INT IDENTITY(1,1) PRIMARY KEY,
ShelterID INT FOREIGN KEY REFERENCES tblSHELTER(ShelterID) NOT NULL,
OrderDate DATE NOT NULL)

CREATE TABLE tblSUPPLY_TYPE
(SupplyTypeID INT IDENTITY(1,1) PRIMARY KEY,
SupplyTypeName VARCHAR(30) NOT NULL,
SupplyTypeDescr VARCHAR(300) NULL)

CREATE TABLE tblBRAND
(BrandID INT IDENTITY(1,1) PRIMARY KEY,
BrandName VARCHAR(30) NOT NULL,
BrandDescr VARCHAR(300) NULL)

CREATE TABLE tblSUPPLY
(SupplyID INT IDENTITY(1,1) PRIMARY KEY,
SupplyName VARCHAR(30) NOT NULL,
SupplyTypeID INT FOREIGN KEY REFERENCES tblSUPPLY_TYPE(SupplyTypeID) NOT NULL,
BrandID INT FOREIGN KEY REFERENCES tblBRAND(BrandID) NOT NULL,
Price NUMERIC(6, 2) NOT NULL)

CREATE TABLE tblPRICE_HISTORY
(PriceHistoryID INT IDENTITY(1,1) PRIMARY KEY,
SupplyID INT FOREIGN KEY REFERENCES tblSUPPLY(SupplyID) NOT NULL,
Price NUMERIC(6,2) NOT NULL,
BeginDate DATE NOT NULL)

CREATE TABLE tblLINE_ITEM
(LineItemID INT IDENTITY(1,1) PRIMARY KEY,
SupplyID INT FOREIGN KEY REFERENCES tblSUPPLY(SupplyID) NOT NULL,
PurchaseOrderID INT FOREIGN KEY REFERENCES tblPURCHASE_ORDER(PurchaseOrderID) NOT NULL,
Quantity INT NOT NULL)

GO

/*
Two (2) stored procedures to populate transactional tables
Definition of two business rules
Two (2) user-defined function to enforce the business rule defined above 
Two (2) user-defined function to enable a computed column
Two (2) view generating a 'complex' query (includes multiple JOINs, GROUP BY/HAVING statements, and aggregate function)
*/

/* STORE PROCEDURES */

-- Nikki --
/* tblEMPLOYEE_SHIFT */
CREATE PROCEDURE AddEmployeeShift
@Fname varchar(25),
@Lname varchar(25),
@DOB Date,
@ShiftStart Time,
@ShiftEnd Time,
@Sname VARCHAR(50),
@SDate DATE
AS
    DECLARE @Shift_ID INT = (SELECT ES.ShiftID
   					 FROM tblEMPLOYEE_SHIFT ES
					 JOIN tblSHIFT S ON ES.ShiftID = S.ShiftID
   					 WHERE S.StartTime = @ShiftStart
   					 AND S.EndTime = @ShiftEnd
                     AND S.ShiftName = @Sname
					 )
    DECLARE @Employee_ID INT = (SELECT ES.EmployeeID
   					 FROM tblEMPLOYEE_SHIFT ES
					 JOIN tblEMPLOYEE E ON ES.EmployeeID = E.EmployeeID
   					 WHERE E.EmployeeFname = @Fname
					 AND E.EmployeeLname = @Lname
					 AND E.EmployeeBirth = @DOB
					 )
    BEGIN TRANSACTION
   	 INSERT INTO tblEMPLOYEE_SHIFT(ShiftID, EmployeeID, ShiftDate)
   	 VALUES (@Shift_ID, @Employee_ID, @SDate)
    COMMIT TRANSACTION
GO

/* tblEVENT */
CREATE PROCEDURE AddEvent
@Shel_Name varchar(50),
@Shel_Address varchar(50),
@EvType_Name varchar(50),
@EvName VARCHAR(50),
@EvDate DATE
AS
    DECLARE @EvType_ID INT = (SELECT E.EventTypeID
					FROM tblEVENT E
					JOIN tblEVENT_TYPE ET ON E.EventTypeID = ET.EventTypeID
					WHERE ET.EventTypeName = @EvType_Name
					)
    DECLARE @Sh_ID INT = (SELECT E.ShelterID
   					 FROM tblEVENT E
					 JOIN tblSHELTER S ON E.ShelterID = S.ShelterID
   					 WHERE S.ShelterName = @Shel_Name
					 AND S.StreetAddress = @Shel_Address
					 )
 
    BEGIN TRANSACTION
   	INSERT INTO tblEVENT(EventTypeID, ShelterID, EventName, EventDate)
   	VALUES (@EvType_ID, @Sh_ID, @EvName, @EvDate)
    COMMIT TRANSACTION
GO


-- Meesha --
/* tblADOPTER */
CREATE PROCEDURE addAdopterInfo
@Fname VARCHAR(30),
@Lname VARCHAR(30),
@Birth DATE,
@Address VARCHAR(50),
@Email VARCHAR(50),
@City VARCHAR(30),
@State VARCHAR(30),
@Zip VARCHAR(20)
AS
BEGIN TRAN addNewAdopter
    INSERT INTO tblADOPTER (AdopterFname, AdopterLname, AdopterBirth, StreetAddress, AdopterCity, AdopterState, AdopterZip, Email)
    VALUES (@Fname, @Lname, @Birth, @Address, @City, @State, @Zip, @Email) 
COMMIT TRAN

GO

/* tblPOSITION */
CREATE PROCEDURE addNewPosition
@Pname VARCHAR(50),
@PDescr VARCHAR(500),
@Sname VARCHAR(50),
@PTname VARCHAR(50)
AS
DECLARE @PT_ID INT
DECLARE @S_ID INT

SET @PT_ID = (SELECT PositionTypeID
            FROM tblPOSITION_TYPE
            WHERE PositionTypeName = @PTname)

SET @S_ID = (SELECT ShelterID
            FROM tblSHELTER
            WHERE ShelterName = @Sname)

BEGIN TRAN addToPosition
    INSERT INTO tblPOSITION (PositionName, PositionDescr, PositionTypeID, ShelterID)
    VALUES (@Pname, @PDescr, @PT_ID, @S_ID)
COMMIT TRAN addToPosition

GO

/* tblEMPLOYEE_POSITION */
CREATE PROCEDURE uspHireNewEmployee
@EmployeeFName VARCHAR(50),
@EmployeeLName VARCHAR(50),
@EmpDOB DATE,
@PositionName VARCHAR(50),
@BDate DATE,
@EDate DATE
AS
DECLARE @Employee_ID INT
DECLARE @Position_ID INT

SET @Employee_ID = (SELECT EmployeeID 
                    FROM tblEMPLOYEE 
                    WHERE EmployeeFName = @EmployeeFName 
                    AND EmployeeLName = @EmployeeLName
                    AND EmployeeBirth = @EmpDOB)

SET @Position_ID = (SELECT PositionID 
                    FROM tblPOSITION 
                    WHERE PositionName = @PositionName)

BEGIN TRAN addNewEmployee
    INSERT INTO tblEMPLOYEE_POSITION(EmployeeID, PositionID, DateBegin, DateEnd)
    VALUES (@Employee_ID, @Position_ID, @BDate, @EDate) 
COMMIT TRAN addEmployee

GO

-- Sarah --
/* tblANIMAL */
CREATE PROCEDURE AddAnimal
@AnimalName varchar(50),
@AnimalTypeName varchar(50),
@AnimalDOB Date
AS
    DECLARE @AT_ID INT = (SELECT ANT.AnimalTypeID
                        FROM tblANIMAL_TYPE ANT
                        WHERE ANT.AnimalTypeName = @AnimalTypeName)
    BEGIN TRANSACTION
        INSERT INTO tblANIMAL(AnimalName, AnimalTypeID, AnimalBirth)
        VALUES (@AnimalName, @AT_ID, @AnimalDOB)
    COMMIT TRANSACTION
GO

/* tblADOPTER_EVENT */
CREATE PROCEDURE AddAdoptionEvent
@AdopterFName varchar(50),
@AdopterLName varchar(50),
@AdopterDOB Date,
@EventName varchar(50)
AS
    DECLARE @A_ID INT = (SELECT A.AdopterID
   					 FROM tblADOPTER A
   					 WHERE A.AdopterFname = @AdopterFName
   					 AND A.AdopterLname = @AdopterLName
   					 AND A.AdopterBirth = @AdopterDOB)
    DECLARE @E_ID INT = (SELECT E.EventID
   					 FROM tblEVENT E
   					 WHERE E.EventName = @EventName)
    BEGIN TRANSACTION
   	 INSERT INTO tblADOPTER_EVENT(AdopterID, EventID)
   	 VALUES (@A_ID, @E_ID)
    COMMIT TRANSACTION
GO

-- Yueqi --
/* tblSUPPLY */
CREATE PROCEDURE addSupply
@Sname VARCHAR(50),
@STname VARCHAR(50),
@Bname VARCHAR(30),
@Price NUMERIC(6,2)
AS
DECLARE @ST_ID INT
DECLARE @B_ID INT

SET @ST_ID = (SELECT SupplyTypeID
            FROM tblSUPPLY_TYPE
            WHERE SupplyTypeName = @STname)

SET @B_ID = (SELECT BrandID
            FROM tblBRAND
            WHERE BrandName = @Bname)

BEGIN TRAN addToSupply
    INSERT INTO tblSUPPLY (SupplyName, SupplyTypeID, BrandID, Price)
    VALUES (@Sname, @ST_ID, @B_ID, @Price)
COMMIT TRAN addToSupply

GO

/* tblANIMAL_EVENT */
CREATE PROCEDURE addAnimalEvent
@Aname VARCHAR(30),
@Ename VARCHAR(50),
@EDate DATE,
@ATname VARCHAR(30)
AS
DECLARE @AT_ID INT
DECLARE @A_ID INT
DECLARE @E_ID INT

SET @AT_ID = (SELECT AnimalTypeID
            FROM tblANIMAL_TYPE
            WHERE AnimalTypeName = @ATname)

SET @A_ID = (SELECT AnimalID
            FROM tblANIMAL
            WHERE AnimalName = @Aname
            AND AnimalTypeID = @AT_ID)

SET @E_ID = (SELECT EventID
            FROM tblEVENT
            WHERE EventName = @Ename
            AND EventDate = @EDate)

BEGIN TRAN addToAnimalEvent
    INSERT INTO tblANIMAL_EVENT (AnimalID, EventID)
    VALUES (@A_ID, @E_ID)
COMMIT TRAN addToAnimalEvent

GO

/* BUSINESS RULES and functions to enforce the business rules */

-- Nikki --
/*
    Adopter must be at least 18 years of age in order to adopt an animal
*/
CREATE FUNCTION fn_Under18CantAdopt()
RETURNS INT
AS
BEGIN
    DECLARE @RET INT = 0
    IF EXISTS (SELECT * 
                FROM tblADOPTER A
                JOIN tblADOPTER_EVENT AE ON A.AdopterID = AE.AdopterID
                JOIN tblEVENT E ON AE.EventID = E.EventID
                JOIN tblEVENT_TYPE ET ON E.EventTypeID = ET.EventTypeID
                WHERE ET.EventTypeName = 'Adoption'
                AND A.AdopterBirth > (SELECT DATEADD(YEAR, -18, GETDATE()))
                )
        BEGIN
            SET @RET = 1
        END
    RETURN @RET
END

GO

ALTER TABLE tblADOPTER_EVENT
ADD CONSTRAINT ck_OnlyAdultsAdopt
CHECK(dbo.fn_Under18CantAdopt() = 0)

GO

/*
    Full time Employees must be at least 18 years of age, but employees of type “volunteer” must be 15 years of age or older
*/
CREATE FUNCTION fn_EmploymentAgeRestriction()
RETURNS INT
AS
BEGIN
    DECLARE @RET INT = 0
    IF EXISTS (SELECT E.EmployeeFname, E.EmployeeLname
                FROM tblEMPLOYEE E
                JOIN tblEMPLOYEE_POSITION EP ON E.EmployeeID = EP.EmployeeID
                JOIN tblPOSITION P ON EP.PositionID = P.PositionID
                JOIN tblPOSITION_TYPE PT ON P.PositionTypeID = PT.PositionTypeID
                WHERE (EmployeeBirth > (SELECT DATEADD(YEAR, -15, GETDATE()))
                AND EmployeePositionID = 'Volunteer')
                OR (PositionTypeName = 'Full Time'
                AND EmployeeBirth > (SELECT DATEADD(YEAR, -18, GETDATE())))
                )
        BEGIN
            SET @RET = 1
        END
    RETURN @RET
END

GO

ALTER TABLE tblEMPLOYEE_POSITION
ADD CONSTRAINT ck_EmploymentAge
CHECK(dbo.fn_EmploymentAgeRestriction() = 0)

GO

-- Meesha --
/*
    Total amount  spent on supplies should not exceed $100 per month
*/
CREATE FUNCTION fn_NoSuppliesOver100()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS (SELECT SH.ShelterID, SUM(S.Price)  AS TotalPricePerMonth
        FROM tblSHELTER SH
        JOIN tblPURCHASE_ORDER PO ON SH.ShelterID = PO.ShelterID
        JOIN tblLINE_ITEM LI ON PO.PurchaseOrderID = LI.PurchaseOrderID
        JOIN tblSUPPLY S ON LI.SupplyID = S.SupplyID
        WHERE MONTH(PO.OrderDate) = MONTH(GETDATE())
        GROUP BY SH.ShelterID
        HAVING SUM(S.Price) > 100)
    BEGIN
        SET @Ret = 1
    END 
    RETURN @Ret
END

GO

ALTER TABLE tblPURCHASE_ORDER
ADD CONSTRAINT ck_noExpensiveSupplies
CHECK (dbo.fn_NoSuppliesOver100() = 0)

GO

/*
    Adopter can not adopt more than 3 animals within a span of one month
*/
CREATE FUNCTION fn_NoHoardingAnimals()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS(SELECT COUNT(*)
                FROM tblADOPTER A
                JOIN tblADOPTER_EVENT AE ON A.AdopterID = AE.AdopterID
                JOIN tblEVENT E ON AE.EventID = E.EventID
                JOIN tblEVENT_TYPE ET ON E.EventTypeID = ET.EventTypeID
                WHERE MONTH(E.EventDate) = MONTH(GetDate())
                AND ET.EventTypeName = 'Adoption'
                HAVING COUNT(*) > 3)
    BEGIN
        SET @Ret = 1
    END
    RETURN @Ret
END 

GO

ALTER TABLE tblADOPTER_EVENT
ADD CONSTRAINT ck_noMoreThan3AnimalsPerMonth
CHECK (dbo.fn_NoHoardingAnimals() = 0)

GO

-- Sarah --
/*
    Adopter can not adopt an animal of age group “puppy/kitty” during the month of December
*/
CREATE FUNCTION fn_NoChristmasPets()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS(SELECT *
   		 FROM tblEVENT E
   		 JOIN tblANIMAL_EVENT ANE ON E.EventID = ANE.EventID
   		 JOIN tblANIMAL AN ON ANE.AnimalID = AN.AnimalName
   		 JOIN tblEVENT_TYPE ET ON E.EventTypeID = ET.EventTypeID
   		 WHERE MONTH(E.EventDate) = 12
   		 AND ET.EventTypeName = 'Adoption'
   		 AND AN.AnimalBirth > DateAdd(Month, -6, GETDATE()))
    BEGIN
   	    SET @Ret = 1
    END
RETURN @RET
END
GO
 
ALTER TABLE tblEVENT
ADD CONSTRAINT ck_NoChristmasPets
CHECK(dbo.fn_NoChristmasPets() = 0)
GO

/*
    An employee of position ‘Shift Supervisor’ cannot order more than $1000 worth of supply type ‘Food’ in 
    one calendar year (starting from today’s date).
*/
CREATE FUNCTION fn_NoShiftSuperBuys1000YearFood()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS(SELECT *
   		 FROM tblPURCHASE_ORDER PO
   		 JOIN tblLINE_ITEM LI ON PO.PurchaseOrderID = LI.LineItemID
   		 JOIN tblSHELTER S ON PO.ShelterID = S.ShelterID
   		 JOIN tblPOSITION P ON S.ShelterID = P.PositionID
   		 JOIN tblSUPPLY SU ON LI.SupplyID = SU.SupplyID
   		 JOIN tblSUPPLY_TYPE ST ON SU.SupplyTypeID = ST.SupplyTypeID
   		 WHERE P.PositionName = 'Shift Supervisor'
   		 AND YEAR(PO.OrderDate) = YEAR(GETDATE())
   		 AND ST.SupplyTypeName = 'Food'
   		 HAVING SUM(LI.TotalPrice) > 1000)
    BEGIN
   	 SET @Ret = 1
    END
RETURN @Ret
END
GO

ALTER TABLE tblPURCHASE_ORDER
ADD CONSTRAINT ck_NoShiftSuperBuys1000YearFood
CHECK (dbo.fn_NoShiftSuperBuys1000YearFood() = 0)
GO


-- Yueqi --
/* 
    Part-time employees younger than 18 years old may not work over 15 hours a week during the months of September to June. 
*/
CREATE FUNCTION fn_noMinorsOver15Hours()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS (SELECT SUM(DATEDIFF(HOUR, S.StartTime, S.EndTime)) AS TotalHourPerWeek
                FROM tblEMPLOYEE E
                JOIN tblEMPLOYEE_SHIFT ES ON E.EmployeeID = ES.EmployeeID
                JOIN tblSHIFT S ON ES.ShiftID = S.ShiftID
                WHERE ES.ShiftDate > (SELECT DATEADD(DAY, -7, GETDATE()))
                AND E.EmployeeBirth > (SELECT DATEADD(YEAR, -18, GETDATE()))
                AND (MONTH(ES.ShiftDate) <= 6 OR MONTH(ES.ShiftDate) >= 9)
                HAVING SUM(DATEDIFF(HOUR, S.StartTime, S.EndTime)) > 15)
    BEGIN
        SET @Ret = 1
    END
    RETURN @Ret
END

GO

ALTER TABLE tblEMPLOYEE_SHIFT
ADD CONSTRAINT ck_noMinorsOver15Hour
CHECK (dbo.fn_noMinorsOver15Hours() = 0)

GO

/*
    An employee of type assistant manager must have been employed for 3 years in order to be promoted to General Manager. 
*/
CREATE FUNCTION fn_AssiManaOver3Years()
RETURNS INT
AS 
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS (SELECT E.EmployeeID 
                FROM tblEMPLOYEE E
                JOIN tblEMPLOYEE_POSITION EP ON E.EmployeeID = EP.EmployeeID
                JOIN tblPOSITION P ON EP.PositionID = P.PositionID
                JOIN (SELECT E.EmployeeID 
                    FROM tblEMPLOYEE E
                    JOIN tblEMPLOYEE_POSITION EP ON E.EmployeeID = EP.EmployeeID
                    JOIN tblPOSITION P ON EP.PositionID = P.PositionID
                    WHERE P.PositionName = 'Assistant Manager'
                    AND DATEDIFF(YEAR, EP.DateBegin, EP.DateEnd) < 3) sub1 ON E.EmployeeID = sub1.EmployeeID
                WHERE P.PositionName = 'General Manager')
    BEGIN
        SET @Ret = 1
    END
    RETURN @Ret
END

GO

ALTER TABLE tblEMPLOYEE_POSITION
ADD CONSTRAINT ck_AssiManaOver3Years
CHECK (dbo.fn_AssiManaOver3Years() = 0)

GO

-- computed columns

-- Nikki --
/*
    Computed column named ‘Age’ or ‘Age Group’ use Date of Birth in tblANIMAL for this, alter table tblANIMAL. 
    (Puppy/Kitten: 0-6 months; Young: 6-24 months; Adult: 2-8 years (dog), 2-10 years (cats); Senior: >8 years (dog), >10 years (cat))
*/
CREATE FUNCTION fn_AgeGrouper(@PK_ID INT)
RETURNS VARCHAR(30)
AS
BEGIN
    DECLARE @Ret VARCHAR(30)
    DECLARE @AT VARCHAR(10) = (SELECT ANT.AnimalTypeName
                                FROM tblANIMAL A
                                JOIN tblANIMAL_TYPE ANT ON A.AnimalTypeID = ANT.AnimalTypeID
                                WHERE A.AnimalID = @PK_ID)
    DECLARE @Age INT = (SELECT DateDiff(MONTH, A.AnimalBirth, GETDATE())
                        FROM tblANIMAL A
                        WHERE A.AnimalID = @PK_ID
    )

    IF @Age BETWEEN 0 AND 6
    BEGIN
        SET @Ret = 'Puppy/Kitten'
    END
    ELSE IF @Age BETWEEN 6 AND 24
    BEGIN
        SET @Ret = 'Young'
    END
    ELSE IF (@AT = 'Dog' AND @Age BETWEEN 24 AND 96) OR (@AT = 'Cat' AND @Age BETWEEN 24 AND 120)
    BEGIN
        SET @Ret = 'Adult'
    END
    ELSE
    BEGIN
        SET @Ret = 'Senior'
    END
    
    RETURN @Ret
END
GO
ALTER TABLE tblANIMAL
ADD AgeGroup
AS (dbo.fn_AgeGrouper(AnimalID))
GO

/*
    Computed column named “Total minor employees” alter table tblSHELTER, use EmployeeBirth in tblEMPLOYEE to calculate
*/
CREATE FUNCTION fn_CountYoungEmployees(@PK_ID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = (SELECT COUNT(*)
                        FROM tblEMPLOYEE E
                        JOIN tblEMPLOYEE_POSITION EP ON E.EmployeeID = EP.EmployeeID
                        JOIN tblPOSITION P ON EP.PositionID = P.PositionID
                        JOIN tblPOSITION_TYPE PT ON P.PositionTypeID = PT.PositionTypeID
                        WHERE E.EmployeeBirth > (SELECT DATEADD(YEAR, -18, GETDATE()))
                        AND PT.PositionTypeName = 'Employee'
                        )
    
    RETURN @Ret
END
GO
ALTER TABLE tblSHELTER
ADD NumberOfMinors
AS (dbo.fn_CountYoungEmployees(ShelterID))
GO

-- Meesha --
/*
    Computed column named “Total Adoptions This Past Year” use ShelterID, alter table tblSHELTER
*/
CREATE FUNCTION fn_calcTotalAdoptionsInCurrentYear(@PK_ID INT)
RETURNS INT
AS
BEGIN
DECLARE @Ret INT = (SELECT COUNT(*)
    FROM tblSHELTER S
    JOIN tblEVENT E ON S.ShelterID = E.ShelterID
    JOIN tblEVENT_TYPE ET ON E.EventTypeID = ET.EventTypeID
    WHERE S.ShelterID = @PK_ID
    AND ET.EventTypeName = 'Adoption'
    AND E.EventDate > DateAdd(Year, -1, GetDate()))
    RETURN @Ret
END

GO

ALTER TABLE tblSHELTER
ADD CALC_TotalNumAdoptions 
AS (dbo.fn_calcTotalAdoptionsInCurrentYear(ShelterID))

GO

/*
    Computed column named “Total Volunteers” use ShelterID, alter table tblSHELTER
*/
CREATE FUNCTION fn_TotalNumOfVolunteers(@PK_ID INT)
RETURNS INT
AS
BEGIN
DECLARE @Ret INT = (SELECT COUNT(*)
                FROM tblEMPLOYEE E
                JOIN tblEMPLOYEE_POSITION EP ON E.EmployeeID = EP.EmployeeID
                JOIN tblPOSITION P ON EP.PositionID = P.PositionID
                JOIN tblPOSITION_TYPE PT ON P.PositionTypeID = PT.PositionTypeID
                JOIN tblSHELTER S ON P.ShelterID = S.ShelterID
                WHERE S.ShelterID = @PK_ID
                AND PT.PositionTypeName = 'Volunteer')
    RETURN @Ret
END
GO
ALTER TABLE tblSHELTER
ADD CALC_TotalNumVolunteer 
AS (dbo.fn_TotalNumOfVolunteers(ShelterID))

GO
-- Sarah --
/*
     Computed column named “TotalPrice”, alter table tblLINE_ITEM
*/
CREATE FUNCTION fn_TotalPriceForNumItems(@PK_ID INT)
RETURNS numeric(7,2)
AS
BEGIN
    DECLARE @Ret numeric(7,2) = ((SELECT SU.Price
   							 FROM tblSUPPLY SU
   							 JOIN tblLINE_ITEM LI ON SU.SupplyID = LI.SupplyID
   							 WHERE LI.LineItemID = @PK_ID)
   							 *
   							 (SELECT LI.Quantity
   							 FROM tblLINE_ITEM LI
   							 WHERE LI.LineItemID = @PK_ID))
RETURN @Ret
END
GO
 
ALTER TABLE tblLINE_ITEM
ADD TotalPrice
AS (dbo.fn_TotalPriceForNumItems(LineItemID))
GO

/*
    Computed column named “Total Hours This Week” alter table tblEMPLOYEE, use EmployeeID
*/
CREATE FUNCTION fn_TotalShiftsPerEmployee(@PK_ID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = (SELECT SUM(DateDiff(HOUR, SH.StartTime, SH.EndTime))
   					 FROM tblSHIFT SH
   					 JOIN tblEMPLOYEE_SHIFT ES ON SH.ShiftID = ES.ShiftID
   					 JOIN tblEMPLOYEE E ON ES.EmployeeID = E.EmployeeID
   					 WHERE E.EmployeeID = @PK_ID
   					 AND ES.ShiftDate > DateAdd(DAY, -7, GETDATE()))
RETURN @Ret
END
GO
 
ALTER TABLE tblEMPLOYEE
ADD TotalHoursThisWeek
AS (dbo.fn_TotalShiftsPerEmployee(EmployeeID))
GO

-- Yueqi --
/*
    Computed column named “Line extended” using info from tblLINE_ITEM and alter table tblPURCHASE_ORDER
*/
CREATE FUNCTION fn_calcOrderTotal(@PKID INT)
RETURNS NUMERIC(7, 2)
AS
BEGIN
    DECLARE @Ret NUMERIC(7, 2) = (SELECT SUM(LI.TotalPrice)
                                FROM tblPURCHASE_ORDER PO
                                JOIN tblLINE_ITEM LI ON PO.PurchaseOrderID = LI.PurchaseOrderID
                                WHERE PO.PurchaseOrderID = @PKID) 
    RETURN @Ret
END

GO

ALTER TABLE tblPURCHASE_ORDER
ADD OrderTotal
AS (dbo.fn_calcOrderTotal(PurchaseOrderID))

GO

/*
    Computed column named “TotalAdoptions” calculating total number to animals adopted by an adopter, alter table tblADOPTER
*/
CREATE FUNCTION fn_calcTotalAdoptions(@PKID INT)
RETURNS INT
AS 
BEGIN
    DECLARE @Ret INT = (SELECT COUNT(*)
                        FROM tblADOPTER A
                        JOIN tblADOPTER_EVENT AE ON A.AdopterID = AE.AdopterID
                        JOIN tblEVENT E ON AE.EventID = E.EventID
                        WHERE A.AdopterID = @PKID
                        AND E.EventName = 'Adoption')
    RETURN @Ret
END

GO

ALTER TABLE tblADOPTER
ADD TotalAdoptions
AS (dbo.fn_calcTotalAdoptions(AdopterID))

GO

-- view generating a 'complex' query

-- Nikki --
/*
    A  query to see the 5 best selling items of brand ‘Meow’ costing more than $10 within the past 2 years
*/
SELECT TOP 5 S.SupplyID, S.SupplyName, COUNT(*) AS QuantSold
FROM tblLINE_ITEM LI
JOIN tblPURCHASE_ORDER PO ON LI.PurchaseOrderID = PO.PurchaseOrderID
JOIN tblSUPPLY S ON LI.SupplyID = S.SupplyID
JOIN tblBRAND B ON S.BrandID = B.BrandID
WHERE S.Price > 10.00
AND B.BrandName = 'Meow'
AND PO.OrderDate >= (SELECT DATEADD(YEAR, -2, GETDATE()))
GROUP BY S.SupplyID, S.SupplyName
ORDER BY QuantSold DESC

/*
    A query to see the number of pets of type ‘Dog’ adopted per person between the years of 2005 to 2015
*/
SELECT AD.AdopterID, AD.AdopterFname, AD.AdopterLname, COUNT(*) AS AverageAdoptions
FROM tblADOPTER_EVENT AE
JOIN tblADOPTER AD ON AE.AdopterID = AD.AdopterID
JOIN tblEVENT E ON AE.EventID = E.EventID
JOIN tblANIMAL_EVENT AV ON E.EventID = AV.EventID
JOIN tblANIMAL A ON AV.AnimalID = A.AnimalID
JOIN tblANIMAL_TYPE ANT ON A.AnimalTypeID = ANT.AnimalTypeID
WHERE ANT.AnimalTypeName = 'Dog'
AND E.EventDate BETWEEN '01-01-2005' AND '12-31-2015'
GROUP BY AD.AdopterID, AD.AdopterFname, AD.AdopterLname


-- Meesha --
/*
    A query to determine how many employees with the first name “John” and last name “Smith”  worked in the past 8.5 years in 
    a part-time position.
*/
SELECT COUNT(*) AS TotalJohnSmithPast8Years
FROM tblEMPLOYEE E
JOIN tblEMPLOYEE_POSITION EP ON E.EmployeeID = EP.EmployeeID
JOIN tblPOSITION P ON EP.PositionID = P.PositionID
JOIN tblPOSITION_TYPE PT ON P.PositionTypeID = PT.PositionTypeID
WHERE EP.DateBegin >= DateAdd(Year, -8.5, GetDate())
AND E.EmployeeFName = 'John'
AND E.EmployeeLName = 'Smith'
AND PT.PositionTypeName = 'part-time'

/*
    A query to determine the average age of type ‘Adult Cat’ that have been adopted in the month of December in 2018.
*/
SELECT AVG(DATEDIFF(YEAR, A.AnimalBirth, GETDATE())) AS AverageAgeofKittens
FROM tblEVENT E
JOIN tblANIMAL_EVENT AE ON E.EventTypeID = AE.EventID
JOIN tblANIMAL A ON AE.AnimalID = A.AnimalID 
JOIN tblANIMAL_TYPE ANT ON A.AnimalTypeID = ANT.AnimalTypeID
WHERE YEAR(E.EventDate) = 2018
AND MONTH(E.EventDate) = 12
AND ANT.AnimalTypeName = 'Cat'
AND A.AgeGroup = 'Adult'


-- Sarah --
/*
    A query to determine the total number of adoptions of animals in age group "young" in descending order by state in the year 2019
*/
SELECT A.AdopterState, COUNT(ADE.AdopterEventID) as NUMADOPTIONS
FROM tblADOPTER_EVENT ADE
JOIN tblADOPTER A ON ADE.AdopterID = A.AdopterID
JOIN tblEVENT E ON ADE.EventID = E.EventID
JOIN tblANIMAL_EVENT ANE ON E.EventID = ANE.EventID
JOIN tblANIMAL AN ON ANE.AnimalID = AN.AnimalID
JOIN tblEVENT_TYPE ET ON ET.EventTypeID = E.EventTypeID
WHERE ET.EventTypeName = 'Adoption'
AND AN.AnimalBirth BETWEEN DateAdd(Month, -6, GETDATE()) AND DateAdd(Year, -2, GETDATE())
AND YEAR(E.EventDate) = '2019'
GROUP BY A.AdopterState
ORDER BY NUMADOPTIONS DESC

/*
    A query to determine the shelters with at least 20 volunteers that spent more than $500 on supply type "Toys" in the year 2017 
    that also had at least 100 events of type "Cuddle" involving animals of type dog in the year 2018
*/
SELECT S.ShelterID, SUM(LI.TotalPrice) AS MoneySpentOnTOYS
FROM tblSHELTER S
JOIN tblPURCHASE_ORDER PO ON S.ShelterID = PO.ShelterID
JOIN tblLINE_ITEM LI ON PO.PurchaseOrderID = LI.PurchaseOrderID
JOIN tblSUPPLY SU ON LI.SupplyID = SU.SupplyID
JOIN tblSUPPLY_TYPE ST ON SU.SupplyTypeID = ST.SupplyTypeID
JOIN (SELECT S.ShelterID, COUNT(ANE.AnimalEventID) AS NUMCUDDLES
    FROM tblSHELTER S
    JOIN tblEVENT E ON S.ShelterID = E.EventID
    JOIN tblANIMAL_EVENT ANE ON E.EventID = ANE.EventID
    JOIN tblEVENT_TYPE ET ON E.EventTypeID = ET.EventTypeID
    JOIN tblANIMAL A ON ANE.AnimalID = A.AnimalID
    JOIN tblANIMAL_TYPE ANT ON A.AnimalTypeID = ANT.AnimalTypeID
    WHERE ET.EventTypeName = 'Cuddle'
    AND YEAR(E.EventDate) = '2018'
    AND ANT.AnimalTypeName = 'Dog'
    GROUP BY S.ShelterID
    HAVING COUNT(ANE.AnimalEventID) >= 100) AS subQ1 ON S.ShelterID = subQ1.ShelterID
WHERE ST.SupplyTypeName = 'Toys'
AND YEAR(PO.OrderDate) = '2017'
AND S.CALC_TotalNumVolunteer > 20
GROUP BY S.ShelterID
HAVING SUM(LI.TotalPrice) > 500


-- Yueqi --
/*
    A query to determine which shelter has placed more than 5 orders of supplies with supply type 'Food' and brand 'Meow' in 1 year, 
    where each order has a quantity greater than 100
*/
SELECT S.ShelterID, S.ShelterName, COUNT(*) AS NumOrders
FROM tblSHELTER S
JOIN tblPURCHASE_ORDER PO ON S.ShelterID = PO.ShelterID
JOIN tblLINE_ITEM LI ON PO.PurchaseOrderID = LI.PurchaseOrderID
JOIN tblSUPPLY SU ON LI.SupplyID = SU.SupplyID
JOIN tblBRAND B ON SU.BrandID = B.BrandID
JOIN tblSUPPLY_TYPE ST ON SU.SupplyTypeID = ST.SupplyTypeID
WHERE ST.SupplyTypeName = 'Food'
AND B.BrandName = 'Meow'
AND PO.OrderDate >= (SELECT DATEADD(YEAR, -1, GETDATE()))
GROUP BY S.ShelterID, S.ShelterName
HAVING COUNT(*) > 5

/*
    A query to determine which adopter older than 30 that has adopted at least 3 animals, has also participate at least 10 events 
    of type 'Cuddle' in past 2 years
*/
SELECT A.AdopterID, A.AdopterFname, A.AdopterLname, COUNT(*) AS TotoalCuddleEvent
FROM tblADOPTER A
JOIN tblADOPTER_EVENT AE ON A.AdopterID = AE.AdopterID
JOIN tblEVENT E ON AE.EventID = E.EventID
JOIN tblEVENT_TYPE ET ON E.EventTypeID = ET.EventTypeID
WHERE A.AdopterBirth < (SELECT DATEADD(YEAR, -30, GETDATE()))
AND A.TotalAdoptions >= 3
AND E.EventDate > (SELECT DATEADD(YEAR, -2, GETDATE()))
AND E.EventName = 'Cuddle'
GROUP BY A.AdopterID, A.AdopterFname, A.AdopterLname
HAVING COUNT(*) >= 10










SELECT * FROM tblEMPLOYEE

INSERT INTO tblEMPLOYEE (EmployeeFname, EmployeeLname, EmployeeBirth, EmployeeStreetAddress, EmployeeCity, EmployeeState, EmployeeZip, Email)
VALUES ('Jackson', 'Wong', '1995-04-13', '3367 Random Street', 'NewYork', 'NewYork', '76543', 'JW0413@gmail.com') 

SELECT * FROM tblADOPTER

INSERT INTO tblADOPTER (AdopterBirth, AdopterCity, AdopterFname, AdopterLname, AdopterState, AdopterZip, StreetAddress, Email)
VALUES ('1995-02-28', 'Boston', 'Justin', 'Siena', 'Massachusetts', '02101', '2950 Nomanland street', 'js@gmial.com')

INSERT INTO tblANIMAL_TYPE (AnimalTypeName, AnimalTypeDescr)
VALUES ('Dog', 'Member of the genus Canis')

SELECT * FROM tblANIMAL

INSERT INTO tblANIMAL (AnimalTypeID, AnimalName, AnimalBirth)
VALUES (2, 'Guard', '2019-01-03')

SELECT * FROM tblEVENT_TYPE

INSERT INTO tblEVENT_TYPE (EventTypeName, EventTypeDescr)
VALUES ('Cleaning', 'Clean animal')

SELECT * FROM tblSHELTER

INSERT INTO tblSHELTER (ShelterName, StreetAddress, ShelterCity, ShelterState, ShelterZip)
VALUES ('Berkley Animal Shelter', '8765 9th Avenue', 'Berkley', 'California', '36591')

SELECT * FROM tblEVENT

INSERT INTO tblEVENT (EventName, EventTypeID, ShelterID, EventDate)
VALUES ('Meow adopted by Anyone', 2, 5, '2019-03-16')

SELECT * FROM tblANIMAL_EVENT

INSERT INTO tblANIMAL_EVENT (AnimalID, EventID)
VALUES (3, 5)

SELECT * FROM tblADOPTER_EVENT

INSERT INTO tblADOPTER_EVENT (AdopterID, EventID)
VALUES (3, 9)

SELECT * FROM tblPOSITION_TYPE

INSERT INTO tblPOSITION_TYPE (PositionTypeName, PositionTypeDescr)
VALUES ('Full-time', 'Occupying or using the whole of someones available working time, typically 40 hours in a week')

SELECT * FROM tblPOSITION

INSERT INTO tblPOSITION (PositionName, PositionDescr, PositionTypeID, ShelterID)
VALUES ('Adoption Console Assistant', 'Help with adoption console', 2, 5)

SELECT * FROM tblEMPLOYEE_POSITION

EXECUTE uspHireNewEmployee
@EmployeeFName = 'Noone',
@EmployeeLName = 'Nothing',
@EmpDOB = '1990-12-25',
@PositionName = 'Animal Caregiver',
@BDate = '2017-07-26',
@EDate = NULL

SELECT * FROM tblSHIFT

INSERT INTO tblSHIFT (ShiftName, ShiftDescr, StartTime, EndTime)
VALUES ('2nd shift', 'Shifts that immediately following the first shift', '17:00', '23:59')

SELECT * FROM tblEMPLOYEE_SHIFT

INSERT INTO tblEMPLOYEE_SHIFT (ShiftID, EmployeeID, ShiftDate)
VALUES (9, 1, '2020-03-05')

SELECT * FROM tblSUPPLY_TYPE

INSERT INTO tblSUPPLY_TYPE (SupplyTypeName, SupplyTypeDescr)
VALUES ('Cleaning supplies', 'Things to clean the shelter and animals')

SELECT * FROM tblBRAND

INSERT INTO tblBRAND (BrandName, BrandDescr)
VALUES ('Meow', 'Super Cheap')

SELECT * FROM tblSUPPLY

INSERT INTO tblSUPPLY (SupplyName, SupplyTypeID, BrandID, Price)
VALUES ('Meow Original Dry Cat Food', 1, 6, 3.98)

SELECT * FROM tblPURCHASE_ORDER

INSERT INTO tblPURCHASE_ORDER (ShelterID, OrderDate)
VALUES (5, '2020-01-29')

SELECT * FROM tblLINE_ITEM

INSERT INTO tblLINE_ITEM (SupplyID, PurchaseOrderID, Quantity)
VALUES (10, 10, 10)

SELECT * FROM tblPRICE_HISTORY

INSERT INTO tblPRICE_HISTORY (SupplyID, Price, BeginDate)
VALUES (12, 3.98, '2016-01-01')