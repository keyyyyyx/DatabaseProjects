USE Proj_A8

CREATE TABLE tblPATIENT_TYPE
(PatientTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
PatientTypeName VARCHAR(50) NOT NULL,
PatientTypeDescr VARCHAR(500) NULL)

CREATE TABLE tblPATIENT
(PatientID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
PatientFname VARCHAR(50) NOT NULL,
PatientLname VARCHAR(50) NOT NULL,
PatientDOB DATE NOT NULL,
StreetAddress VARCHAR(200) NOT NULL,
PatientCity VARCHAR(100) NOT NULL,
PatientState VARCHAR(50) NOT NULL,
PatientZip VARCHAR(20) NOT NULL,
Email VARCHAR(50) NOT NULL,
Phone VARCHAR(20) NOT NULL)

CREATE TABLE tblPATIENT_PATIENT_TYPE
(PatientPatientTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
PatientTypeID INT FOREIGN KEY REFERENCES tblPATIENT_TYPE(PatientTypeID) NOT NULL,
PatientID INT FOREIGN KEY REFERENCES tblPATIENT(PatientID) NOT NULL,
BeginDate DATE NOT NULL)

CREATE TABLE tblSTATUS
(StatusID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
StatusName VARCHAR(50) NOT NULL,
StatusDescr VARCHAR(500) NULL)

CREATE TABLE tblPATIENT_STATUS
(PatientStatusID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
StatusID INT FOREIGN KEY REFERENCES tblSTATUS(StatusID) NOT NULL,
PatientID INT FOREIGN KEY REFERENCES tblPATIENT(PatientID) NOT NULL,
BeginDateTime DATETIME NOT NULL)

CREATE TABLE tblBUILDING
(BuildingID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
BuldingName VARCHAR(50) NOT NULL,
BuildingDescr VARCHAR(500) NULL)

CREATE TABLE tblROOM_TYPE
(RoomTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
RoomTypeName VARCHAR(50) NOT NULL,
RoomTypeDescr VARCHAR(500) NULL)

CREATE TABLE tblROOM
(RoomID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
RoomName VARCHAR(50) NOT NULL,
RoomTypeID INT FOREIGN KEY REFERENCES tblROOM_TYPE(RoomTypeID) NOT NULL,
BuildingID INT FOREIGN KEY REFERENCES tblBUILDING(BuildingID) NOT NULL,
RoomDescr VARCHAR(500) NULL)

CREATE TABLE tblEVENT_TYPE
(EventTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
EventTypeName VARCHAR(50) NOT NULL,
EventDescr VARCHAR(500) NULL)

CREATE TABLE tblDETAIL
(DetailID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
DetailDescr VARCHAR(500) NOT NULL)

CREATE TABLE tblSUPPLIER 
(SupplierID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
SupplierName VARCHAR(50) NOT NULL,
SupplierDescr VARCHAR(500) NULL)

CREATE TABLE tblPRODUCT_TYPE
(ProductTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
ProductTypeName VARCHAR(50) NOT NULL,
ProductTypeDescr VARCHAR(500) NULL)

CREATE TABLE tblPRODUCT
(ProductID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
ProductName VARCHAR(100) NOT NULL,
ProductTypeID INT FOREIGN KEY REFERENCES tblPRODUCT_TYPE(ProductTypeID) NOT NULL,
ProductDescr VARCHAR(500) NULL)

CREATE TABLE tblPRODUCT_SUPPLIER
(ProductSupplierID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
SupplierID INT FOREIGN KEY REFERENCES tblSUPPLIER(SupplierID) NOT NULL,
ProductID INT FOREIGN KEY REFERENCES tblPRODUCT(ProductID) NOT NULL)

CREATE TABLE tblPRODUCT_DETAILS
(ProductDetailID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
ProductSupplierID INT FOREIGN KEY REFERENCES tblPRODUCT_SUPPLIER(ProductSupplierID) NOT NULL,
DetailID INT FOREIGN KEY REFERENCES tblDETAIL(DetailID) NOT NULL)

CREATE TABLE tblPURCHASE_ORDER
(PurchaseOrderID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
StaffPositionID INT FOREIGN KEY REFERENCES tblSTAFF_POSITION(StaffPositionID) NOT NULL,
PODateTime DATETIME NOT NULL)

CREATE TABLE tblLINE_ITEM
(LineItemID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
PurchaseOrderID INT FOREIGN KEY REFERENCES tblPURCHASE_ORDER(PurchaseOrderID) NOT NULL,
ProductSupplierID INT FOREIGN KEY REFERENCES tblPRODUCT_SUPPLIER(ProductSupplierID) NOT NULL,
Quantity INT NOT NULL)

INSERT INTO tblROOM_TYPE (RoomTypeName, RoomTypeDescr)
VALUES ('casualty', 'an emergency room in a hospital'),
('consulting room', 'a room where a doctor examines a patient and discusses their medical problems with them'),
('day room', 'a room in a hospital where patients can go during the day to watch television, read, or talk'),
('delivery room', 'a room in a hospital where women give birth'),
('dispensary', 'a place in a hospital where you can get medicines and drugs'),
('emergency room', 'the part of a hospital where you take someone who needs immediate care, for example someone who has had an accident'),
('ICU', 'an intensive care unit in a hospital'),
('operating room', 'a room in a hospital where doctors perform medical operations'),
('operating theater', 'an operating room, especially one with a separate part where medical students sit and watch'),
('padded cell', 'a room in a hospital for mentally ill people, with soft material on the walls so that they cannot hurt themselves'),
('pharmacy', 'the part of a store or hospital where medicines are prepared'),
('sickroom', 'a room where someone who is sick rests or gets medical treatment'),
('ward', 'a large room in a hospital with beds for people to stay in')

INSERT INTO tblSUPPLIER (SupplierName, SupplierDescr)
VALUES ('Medtronic plc', 'a global leader in medical technology, services, and solutions'),
('Abbott Laboratories', 'Abbott Laboratories is an American multinational medical devices and health care company with headquarters in Abbott Park, Illinois, United States.'),
('Siemens AG', 'Siemens AG is a German multinational conglomerate company headquartered in Munich and the largest industrial manufacturing company in Europe with branch offices abroad.'),
('Cardinal Health, Inc.', 'Cardinal Health, Inc. is an American multinational health care services company, and the 14th highest revenue generating company in the United States. Its headquarters are based in Dublin, Ohio and Dublin, Ireland.'),
('Baxter International Inc.', 'Baxter International Inc. is a Fortune 500 American health care company with headquarters in Deerfield, Illinois. The company primarily focuses on products to treat hemophilia, kidney disease, immune disorders and other chronic and acute medical conditions.'),
('Boston Scientific Corporation', 'Boston Scientific Corporation, doing business as Boston Scientific, is a manufacturer of medical devices used in interventional medical specialties.'),
('3M Company', 'The 3M Company is an American multinational conglomerate corporation operating in the fields of industry, worker safety, US health care, and consumer goods.'),
('Intuitive Surgical, Inc.', 'Intuitive Surgical, Inc. is an American corporation that develops, manufactures, and markets robotic products designed to improve clinical outcomes of patients through minimally invasive surgery, most notably with the da Vinci Surgical System.'),
('Varian Medical Systems, Inc.', 'Varian Medical Systems of Palo Alto, California, USA, is a radiation oncology treatments and software maker. Their medical devices include linear accelerators and software for treating cancer and other medical conditions with radiotherapy, radiosurgery, proton therapy, and brachytherapy.'),
('IDEXX Laboratories, Inc.', 'IDEXX Laboratories, Inc. is an American multinational corporation engaged in the development, manufacture, and distribution of products and services for the companion animal veterinary, livestock and poultry, water testing, and dairy markets.')

INSERT INTO tblPATIENT (PatientFname, PatientLname, PatientDOB, StreetAddress, PatientCity, PatientState, PatientZip, Email, Phone)
SELECT CustomerFname, CustomerLname, DateOfBirth, CustomerAddress, CustomerCity, CustomerState, CustomerZIP, Email, PhoneNum FROM PEEPS..tblCUSTOMER
WHERE CustomerID BETWEEN 2700 AND 3700

GO

-- tblPOSITION (with getPositionTypeID and getDeptID)
CREATE PROCEDURE getPositionTypeID
@PosiTypeName VARCHAR(100),
@PosiTypeID INT OUTPUT
AS
SET @PosiTypeID = (SELECT PositionTypeID 
                FROM tblPOSITION_TYPE
                WHERE PositionTypeName = @PosiTypeName)

GO

CREATE PROCEDURE getDeptID
@DepartmentName VARCHAR(100),
@DepartmentID INT OUTPUT
AS
SET @DepartmentID = (SELECT DeptID
            FROM tblDEPARTMENT
            WHERE DeptName = @DepartmentName)

GO

CREATE PROCEDURE newPosition
@PosiName VARCHAR(100),
@PTname VARCHAR(100),
@Dname VARCHAR(100),
@PDescr VARCHAR(500)
AS
DECLARE @PT_ID INT, @D_ID INT

EXECUTE getPositionTypeID
@PosiTypeName = @PTname,
@PosiTypeID = @PT_ID OUTPUT

IF @PT_ID IS NULL
    BEGIN
    PRINT '@PT_ID is NULL'
    RAISERROR ('@PT_ID cannot be NULL; check spelling', 11, 1)
    RETURN
    END

EXECUTE getDeptID
@DepartmentName = @Dname,
@DepartmentID = @D_ID OUTPUT

IF @D_ID IS NULL
    BEGIN
    PRINT '@D_ID is NULL'
    RAISERROR ('@D_ID cannot be NULL; check spelling', 11, 1)
    RETURN
    END

BEGIN TRAN T1
INSERT INTO tblPOSITION (PositionName, PositionTypeID, DeptID, PositionDescr)
VALUES (@PosiName, @PT_ID, @D_ID, @PDescr)
IF @@ERROR <> 0
    BEGIN
        PRINT ('TRAN T1 is terminating due to some error')
        ROLLBACK TRAN T1
    END
ELSE
    COMMIT TRAN T1

GO

-- 2) tblSTAFF_POSITION (with getStaffID and getPositionID)
CREATE PROCEDURE getStaffID
@StfFname VARCHAR(50),
@StfLname VARCHAR(50),
@StfDOB DATE,
@StfID INT OUTPUT
AS
SET @StfID = (SELECT StaffID
            FROM tblSTAFF
            WHERE StaffFname = @StfFname
            AND StaffLname = @StfLname
            AND StaffDOB = @StfDOB)

GO

CREATE PROCEDURE getPositionID
@PosiName VARCHAR(100),
@PosiID INT OUTPUT
AS
SET @PosiName = (SELECT PositionID
                FROM tblPOSITION
                WHERE PositionName = @PosiName)

GO

CREATE PROCEDURE newStaffPosition
@SFname VARCHAR(50),
@SLname VARCHAR(50),
@SDOB DATE,
@Pname VARCHAR(100),
@BDATE DATE,
@EDATE DATE
AS
DECLARE @S_ID INT, @P_ID INT

EXECUTE getStaffID
@StfFname = @SFname,
@StfLname = @SLname,
@StfDOB = @SDOB,
@StfID = @S_ID OUTPUT

IF @S_ID IS NULL
    BEGIN
    PRINT '@S_ID is NULL'
    RAISERROR ('@S_ID cannot be NULL; check spelling', 11, 1)
    RETURN
    END

EXECUTE getPositionID
@PosiName = @Pname,
@PosiID = @P_ID OUTPUT

IF @P_ID IS NULL
    BEGIN
    PRINT '@P_ID is NULL'
    RAISERROR ('@P_ID cannot be NULL; check spelling', 11, 1)
    RETURN
    END

BEGIN TRAN T1
INSERT INTO tblSTAFF_POSITION (StaffID, PositionID, BeginDate, EndDate)
VALUES (@S_ID, @P_ID, @BDATE, @EDATE)
IF @@ERROR <> 0
    BEGIN
        PRINT ('TRAN T1 is terminating due to some error')
        ROLLBACK TRAN T1
    END
ELSE
    COMMIT TRAN T1

GO

-- 1) A staff with position type Doctor cannot participate in more than 2 events of type Surgery within 24 hours
ALTER FUNCTION fn_noOver2SurgiesADay()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS (SELECT S.StaffID, COUNT(E.EventID) AS TotalSugeriesToday
            FROM tblSTAFF S
            JOIN tblSTAFF_POSITION SP ON S.StaffID = SP.StaffID
            JOIN tblPOSITION P ON SP.PositionID = P.PositionID
            JOIN tblPOSITION_TYPE PT ON P.PositionTypeID = PT.PositionTypeID
            JOIN tblSTAFF_POS_EVENT SPE ON SP.StaffPositionID = SPE.StaffPositionID
            JOIN tblEVENT E ON SPE.EventID = E.EventID
            JOIN tblEVENT_TYPE ET ON E.EventTypeID = ET.EventTypeID
            WHERE PT.PositionTypeName = 'Doctor'
            AND ET.EventTypeName = 'Surgery'
            AND E.BeginDateTime > DATEADD(hour, -24, GETDATE())
            GROUP BY S.StaffID
            HAVING COUNT(E.EventID) > 2)
    BEGIN
        SET @Ret = 1
    END
    RETURN @Ret
END

GO

ALTER TABLE tblSTAFF_POS_EVENT
ADD CONSTRAINT ck_noOver2SurgiesADay
CHECK (dbo.fn_noOver2SurgiesADay() = 0)

GO

-- 2) A patient cannot have more than 1 toradol Injection within 24 hours
CREATE FUNCTION fn_noToradolOverdose()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS (SELECT P.PatientID, COUNT(E.EventID) AS TotalToradolInjectionToday
            FROM tblPATIENT P
            JOIN tblPATIENT_STATUS PS ON P.PatientID = PS.PatientID
            JOIN tblEVENT E ON PS.PatientStatusID = E.PatientStatusID
            JOIN tblEVENT_TYPE ET ON E.EventTypeID = ET.EventTypeID
            JOIN tblPRODUCT_EVENT PE ON E.EventID = PE.EventID
            JOIN tblPRODUCT PD ON PE.ProductID = PD.ProductID
            WHERE ET.EventTypeName = 'Injection'
            AND (PD.ProductName LIKE '%toradol%' OR PD.ProductName LIKE '%Toradol%')
            AND E.BeginDateTime > DATEADD(hour, -24, GETDATE())
            GROUP BY P.PatientID
            HAVING COUNT(E.EventID) > 1)
    BEGIN
        SET @Ret = 1
    END
    RETURN @Ret
END

GO

ALTER TABLE tblEVENT
ADD CONSTRAINT ck_noToradolOverdose
CHECK (dbo.fn_noToradolOverdose() = 0)

GO

-- 1) Quantity in tblPRODUCT
CREATE FUNCTION fn_calcProductQuantity(@PK INT)
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = (SELECT SUM(LI.Quantity) - SUM(PE.QuantityUsed)
                        FROM tblLINE_ITEM LI
                        JOIN tblPRODUCT_SUPPLIER PS ON LI.ProductSupplierID = PS.ProductSupplierID
                        JOIN tblPRODUCT P ON PS.ProductID = P.ProductID
                        JOIN tblPRODUCT_EVENT PE ON P.ProductID = PE.ProductID
                        WHERE P.ProductID = @PK)
    RETURN @Ret
END

GO

ALTER TABLE tblPRODUCT
ADD Quantity
AS (dbo.fn_calcProductQuantity(ProductID))

GO

-- 2) TotalEvents in tblPATIENT
CREATE FUNCTION fn_calcTotalPatientEvent(@PK INT)
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = (SELECT COUNT(E.EventID)
                        FROM tblEVENT E
                        JOIN tblPATIENT_STATUS PS ON E.PatientStatusID = PS.PatientStatusID
                        JOIN tblPATIENT P ON PS.PatientID = P.PatientID
                        WHERE P.PatientID = @PK)
    RETURN @Ret
END

GO

ALTER TABLE tblPATIENT
ADD TotalEvents
AS (dbo.fn_calcTotalPatientEvent(PatientID))

GO

-- 1) Select staff that has spent over 100 hours in events of type Surgery, who has also participated in over 200 events of type Injection.
CREATE VIEW view_getExperiencedStaff AS
SELECT S.StaffID, S.StaffFname, S.StaffLname, sub1.TotalSurgeryHours, COUNT(E.EventID) AS TotalInjections
FROM tblSTAFF S
JOIN tblSTAFF_POSITION SP ON S.StaffID = SP.StaffID
JOIN tblSTAFF_POS_EVENT SPE ON SP.StaffPositionID = SPE.StaffPositionID
JOIN tblEVENT E ON SPE.EventID = E.EventID
JOIN tblEVENT_TYPE ET ON E.EventTypeID = ET.EventTypeID

JOIN (SELECT S.StaffID, SUM(DATEDIFF(HOUR, E.BeginDateTime, E.EndDateTime)) AS TotalSurgeryHours
    FROM tblSTAFF S
    JOIN tblSTAFF_POSITION SP ON S.StaffID = SP.StaffID
    JOIN tblSTAFF_POS_EVENT SPE ON SP.StaffPositionID = SPE.StaffPositionID
    JOIN tblEVENT E ON SPE.EventID = E.EventID
    JOIN tblEVENT_TYPE ET ON E.EventTypeID = ET.EventTypeID
    WHERE ET.EventTypeName = 'Surgery'
    GROUP BY S.StaffID
    HAVING SUM(DATEDIFF(HOUR, E.BeginDateTime, E.EndDateTime)) > 100) AS sub1 ON S.StaffID = sub1.StaffID

WHERE ET.EventTypeName = 'Injection'
GROUP BY S.StaffID, S.StaffFname, S.StaffLname, sub1.TotalSurgeryHours
HAVING COUNT(E.EventID) > 200

GO

-- 2) Select departments that have ordered over 1000 supplies from 3M Company since 2020-01-01, which has also ordered over 500 items from Siemens AG in 2019.
CREATE VIEW view_getHighDemandDepts AS
SELECT D.DeptID, D.DeptName, sub1.Total3MItems, SUM(LI.Quantity) AS TotalSiemensItems
FROM tblDEPARTMENT D
JOIN tblPOSITION P ON D.DeptID = P.DeptID
JOIN tblSTAFF_POSITION SP ON P.PositionID = SP.PositionID
JOIN tblPURCHASE_ORDER PO ON SP.StaffPositionID = PO.StaffPositionID
JOIN tblLINE_ITEM LI ON PO.PurchaseOrderID = LI.PurchaseOrderID
JOIN tblPRODUCT_SUPPLIER PS ON LI.ProductSupplierID = PS.ProductSupplierID
JOIN tblSUPPLIER S ON PS.SupplierID = S.SupplierID

JOIN (SELECT D.DeptID, SUM(LI.Quantity) AS Total3MItems
    FROM tblDEPARTMENT D
    JOIN tblPOSITION P ON D.DeptID = P.DeptID
    JOIN tblSTAFF_POSITION SP ON P.PositionID = SP.PositionID
    JOIN tblPURCHASE_ORDER PO ON SP.StaffPositionID = PO.StaffPositionID
    JOIN tblLINE_ITEM LI ON PO.PurchaseOrderID = LI.PurchaseOrderID
    JOIN tblPRODUCT_SUPPLIER PS ON LI.ProductSupplierID = PS.ProductSupplierID
    JOIN tblSUPPLIER S ON PS.SupplierID = S.SupplierID
    WHERE S.SupplierName = '3M Company'
    AND PO.PODateTime >= '2020-01-01'
    GROUP BY D.DeptID
    HAVING SUM(LI.Quantity) > 1000) AS sub1 ON D.DeptID = sub1.DeptID

WHERE S.SupplierName = 'Siemens AG'
AND PO.PODateTime BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY D.DeptID, D.DeptName, sub1.Total3MItems
HAVING SUM(LI.Quantity) > 500

GO

CREATE PROCEDURE WrapperNewPatientStatus
@RUN INT
AS

DECLARE @PatientRowCount INT = (SELECT COUNT(*) FROM tblPATIENT)
DECLARE @StatusRowCount INT = (SELECT COUNT(*) FROM tblSTATUS)

DECLARE @P_PK INT, @S_PK INT, @F VARCHAR(30), @L VARCHAR(30), @SA VARCHAR(100), @PC VARCHAR(100), @PS VARCHAR(100), @PZ VARCHAR(50), @Email VARCHAR(50), @Phone VARCHAR(50),
 @DOB DATE, @S VARCHAR(50), @SD VARCHAR(500), @BD DATE

WHILE @RUN > 0
BEGIN
SET @P_PK = @RUN
SET @S_PK = (SELECT RAND() * @StatusRowCount + 1)

SET @F = (SELECT PatientFname FROM tblPATIENT WHERE PatientID = @P_PK)
SET @L = (SELECT PatientLname FROM tblPATIENT WHERE PatientID = @P_PK)
SET @DOB = (SELECT PatientDOB FROM tblPATIENT WHERE PatientID = @P_PK)
SET @SA = (SELECT StreetAddress FROM tblPATIENT WHERE PatientID = @P_PK)
SET @PC = (SELECT PatientCity FROM tblPATIENT WHERE PatientID = @P_PK)
SET @PS = (SELECT PatientState FROM tblPATIENT WHERE PatientID = @P_PK)
SET @PZ = (SELECT PatientZip FROM tblPATIENT WHERE PatientID = @P_PK)
SET @Email = (SELECT Email FROM tblPATIENT WHERE PatientID = @P_PK)
SET @Phone = (SELECT Phone FROM tblPATIENT WHERE PatientID = @P_PK)
SET @S = (SELECT StatusName FROM tblSTATUS WHERE StatusID = @S_PK)
SET @SD = (SELECT StatusDescr FROM tblSTATUS WHERE StatusID = @S_PK)

SET @BD = (SELECT GETDATE() - (SELECT RAND() * 300))

EXECUTE insertPatientStatus
   @insertStatusName = @S,
   @insertStatusDescr = @SD,
   @insertPatientFname = @F,
   @insertPatientLname = @L,
   @insertPatientDOB = @DOB,
   @insertStreetAddress = @SA,
   @insertPatientCity = @PC,
   @insertPatientState = @PS,
   @insertPatientZip = @PZ,
   @insertEmail = @Email,
   @insertPhone = @Phone,
   @insertBeginDateTime = @BD

SET @RUN = @RUN - 1
END

EXECUTE WrapperNewPatientStatus 5000

GO

CREATE PROCEDURE getPatientTypeID
@PaTypename VARCHAR(50),
@PaTypeID INT OUTPUT
AS
SET @PaTypeID = (SELECT PatientTypeID
            FROM tblPATIENT_TYPE
            WHERE PatientTypename = @PaTypename)

GO

CREATE PROCEDURE newPatientPatientType
@PFname VARCHAR(50),
@PLname VARCHAR(50),
@PDOB DATE,
@PTname VARCHAR(100),
@BDATE DATE
AS
DECLARE @P_ID INT, @PT_ID INT

EXECUTE getPatientID
   @PatientFname = @PFname,
   @PatientLname = @PLname,
   @PatientDOB = @PDOB,
   @PatientID = @P_ID OUTPUT


IF @P_ID IS NULL
    BEGIN
    PRINT '@P_ID is NULL'
    RAISERROR ('@P_ID cannot be NULL; check spelling', 11, 1)
    RETURN
    END

EXECUTE getPatientTypeID
@PaTypename = @PTname,
@PaTypeID = @PT_ID OUTPUT

IF @PT_ID IS NULL
    BEGIN
    PRINT '@PT_ID is NULL'
    RAISERROR ('@PT_ID cannot be NULL; check spelling', 11, 1)
    RETURN
    END

BEGIN TRAN T1
INSERT INTO tblPATIENT_PATIENT_TYPE (PatientID, PatientTypeID, BeginDate)
VALUES (@P_ID, @PT_ID, @BDATE)
IF @@ERROR <> 0
    BEGIN
        PRINT ('TRAN T1 is terminating due to some error')
        ROLLBACK TRAN T1
    END
ELSE
    COMMIT TRAN T1

GO

CREATE PROCEDURE WrapperNewPatientPatientType
@RUN INT
AS

DECLARE @PatientTypeCount INT = (SELECT COUNT(*) FROM tblPATIENT_TYPE)

DECLARE @P_PK INT, @PT_PK INT, @F VARCHAR(30), @L VARCHAR(30), @DOB DATE, @PT VARCHAR(50), @BD DATE

WHILE @RUN > 0
BEGIN
SET @P_PK = @RUN
SET @PT_PK = (SELECT RAND() * @PatientTypeCount + 1)

SET @F = (SELECT PatientFname FROM tblPATIENT WHERE PatientID = @P_PK)
SET @L = (SELECT PatientLname FROM tblPATIENT WHERE PatientID = @P_PK)
SET @DOB = (SELECT PatientDOB FROM tblPATIENT WHERE PatientID = @P_PK)
SET @PT = (SELECT PatientTypeName FROM tblPATIENT_TYPE WHERE PatientTypeID = @PT_PK)

SET @BD = (SELECT GETDATE() - (SELECT RAND() * 300))

EXECUTE newPatientPatientType
@PFname = @F,
@PLname = @L,
@PDOB = @DOB,
@PTname = @PT,
@BDATE = @BD

SET @RUN = @RUN - 1
END

EXECUTE WrapperNewPatientPatientType 5000

GO

SELECT * FROM tblPATIENT_PATIENT_TYPE

ALTER TABLE tblSTAFF_POSITION
ADD EndDate DATE 

SELECT DATEADD(hour, -24, GETDATE())

