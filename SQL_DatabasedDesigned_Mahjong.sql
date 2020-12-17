-- ====================================================================================
-- Developer: YI-HSIN LEE
-- ====================================================================================

-- ====================================================================================
-- this statement will prevent messages of "(1 row(s) affected)"
SET NOCOUNT ON

-- ====================================================================================
-- drop foreign keys
-- ====================================================================================
IF OBJECT_ID('FK_tb_Round_tb_Player') IS NOT NULL
ALTER TABLE tb_Round DROP CONSTRAINT FK_tb_Round_tb_Player

IF OBJECT_ID('FK_tb_Round_tb_Location') IS NOT NULL
ALTER TABLE tb_Round DROP CONSTRAINT FK_tb_Round_tb_Location

IF OBJECT_ID('FK_TablePosition_PlayGroup') IS NOT NULL
ALTER TABLE tb_TablePosition DROP CONSTRAINT FK_TablePosition_PlayGroup

IF OBJECT_ID('FK_TablePosition_Player') IS NOT NULL
ALTER TABLE tb_TablePosition DROP CONSTRAINT FK_TablePosition_Player

IF OBJECT_ID('FK_DifficultyLevel_Tileset') IS NOT NULL
ALTER TABLE tb_DifficultyLevel DROP CONSTRAINT FK_DifficultyLevel_Tileset

IF OBJECT_ID('FK_DifficultyLevel_Player') IS NOT NULL
ALTER TABLE tb_DifficultyLevel DROP CONSTRAINT FK_DifficultyLevel_Player

-- ====================================================================================
-- drop tables
-- ====================================================================================
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tb_Player') AND type in (N'U'))
DROP TABLE tb_Player

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tb_Round') AND type in (N'U'))
DROP TABLE tb_Round

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tb_Location') AND type in (N'U'))
DROP TABLE tb_Location

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tb_PlayGroup') AND type in (N'U'))
DROP TABLE tb_PlayGroup

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tb_TablePosition') AND type in (N'U'))
DROP TABLE tb_TablePosition

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tb_FinalTileSet') AND type in (N'U'))
DROP TABLE tb_FinalTileSet

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tb_DifficultyLevel') AND type in (N'U'))
DROP TABLE tb_DifficultyLevel
-- ====================================================================================
-- create tables
-- ====================================================================================
CREATE TABLE tb_Player
(
PlayerID INT IDENTITY(1, 1) NOT NULL ,
FirstName VARCHAR(25) NOT NULL ,
LastName VARCHAR(50) NOT NULL ,
DOB SMALLDATETIME NOT NULL ,
Experience INT NULL ,
CONSTRAINT PK_tb_Player PRIMARY KEY CLUSTERED ( PlayerID ASC )
)

CREATE TABLE tb_Round
(
RoundID INT IDENTITY(1, 1) NOT NULL ,
PlayDate SMALLDATETIME NOT NULL ,
PlayLength INT NOT NULL ,
LocationID INT NOT NULL,
PlayerID INT NOT NULL,
CONSTRAINT PK_tb_Round PRIMARY KEY CLUSTERED ( RoundID ASC )
)

CREATE TABLE tb_Location
(
LocationID INT IDENTITY(1, 1) NOT NULL ,
LocDesc VARCHAR(50) NOT NULL ,
CONSTRAINT PK_tb_Location PRIMARY KEY CLUSTERED ( LocationID ASC )
)

CREATE TABLE tb_TablePosition
(
PlayerID INT NOT NULL ,
PlayerGroupID INT NOT NULL ,
Position VARCHAR(10) NOT NULL ,
CONSTRAINT PK_tb_TablePosition PRIMARY KEY CLUSTERED ( PlayerID ASC, PlayerGroupID ASC )
)

CREATE TABLE tb_PlayGroup
(
PlayerGroupID INT IDENTITY(1, 1) NOT NULL ,
GroupDesc VARCHAR(50) NOT NULL ,
CONSTRAINT PK_tb_PlayGroup PRIMARY KEY CLUSTERED ( PlayerGroupID ASC )
)

CREATE TABLE tb_FinalTileSet
(
TilesetID INT IDENTITY(1, 1) NOT NULL ,
TileType VARCHAR(25) NOT NULL ,
Score INT NOT NULL ,
CONSTRAINT PK_tb_FinalTileSet PRIMARY KEY CLUSTERED ( TilesetID ASC )
)

CREATE TABLE tb_DifficultyLevel
(
TilesetID INT NOT NULL ,
PlayerID INT NOT NULL ,
DiffLevel INT NOT NULL ,
CONSTRAINT PK_tb_DifficultyLevel PRIMARY KEY CLUSTERED ( TilesetID ASC, PlayerID ASC )
)
-- ====================================================================================
-- create foreign keys
-- ====================================================================================
ALTER TABLE tb_Round
ADD CONSTRAINT FK_tb_Round_tb_Player
FOREIGN KEY(PlayerID)
REFERENCES tb_Player (PlayerID)

ALTER TABLE tb_Round
ADD CONSTRAINT FK_tb_Round_tb_Location
FOREIGN KEY(LocationID)
REFERENCES tb_Location (LocationID)

ALTER TABLE tb_TablePosition
ADD CONSTRAINT FK_TablePosition_PlayGroup
FOREIGN KEY(PlayerGroupID)
REFERENCES tb_PlayGroup (PlayerGroupID)

ALTER TABLE tb_TablePosition
ADD CONSTRAINT FK_TablePosition_Player
FOREIGN KEY(PlayerID)
REFERENCES tb_Player (PlayerID)

ALTER TABLE tb_DifficultyLevel
ADD CONSTRAINT FK_DifficultyLevel_Tileset
FOREIGN KEY(TilesetID)
REFERENCES tb_FinalTileSet (TilesetID)

ALTER TABLE tb_DifficultyLevel
ADD CONSTRAINT FK_DifficultyLevel_Player
FOREIGN KEY(PlayerID)
REFERENCES tb_Player (PlayerID)

-- ====================================================================================
-- insert data
-- ====================================================================================
-- tb_FinalTileSet
INSERT INTO tb_FinalTileSet (TileType, Score) VALUES ('All in triplets',4)
INSERT INTO tb_FinalTileSet (TileType, Score) VALUES ('All of one suit',8)
INSERT INTO tb_FinalTileSet (TileType, Score) VALUES ('Dealer',1 )
INSERT INTO tb_FinalTileSet (TileType, Score) VALUES ('Clear',1)
INSERT INTO tb_FinalTileSet (TileType, Score) VALUES ('Clear with self-draw',9)
INSERT INTO tb_FinalTileSet (TileType, Score) VALUES ('Self-draw',3)
INSERT INTO tb_FinalTileSet (TileType, Score) VALUES ('Great dragon',9)
INSERT INTO tb_FinalTileSet (TileType, Score) VALUES ('Heavenly hand',8)
INSERT INTO tb_FinalTileSet (TileType, Score) VALUES ('Common hand',2)

-- tb_Location
INSERT INTO tb_Location (LocDesc) VALUES ('CHICAGO')
INSERT INTO tb_Location (LocDesc) VALUES ('TAIPEI')
INSERT INTO tb_Location (LocDesc) VALUES ('NEWYORK')
INSERT INTO tb_Location (LocDesc) VALUES ('LA')
INSERT INTO tb_Location (LocDesc) VALUES ('BOSTON')
INSERT INTO tb_Location (LocDesc) VALUES ('MILWAUKEE')

-- tb_Player
INSERT INTO tb_Player (FirstName, LastName, DOB, Experience) VALUES ('Will', 'Smith', '01/01/1952', 15)
INSERT INTO tb_Player (FirstName, LastName, DOB, Experience) VALUES ('Lisa', 'Liu', '11/4/1999', 2)
INSERT INTO tb_Player (FirstName, LastName, DOB, Experience) VALUES ('Jay', 'Chou', '10/29/1965', 20)
INSERT INTO tb_Player (FirstName, LastName, DOB, Experience) VALUES ('Kevin', 'Lee', '05/29/1992', 5)
INSERT INTO tb_Player (FirstName, LastName, DOB, Experience) VALUES ('Allen', 'Yu', '03/05/1995', 3)
-- tb_Round
INSERT INTO tb_Round (PlayDate, PlayLength, LocationID, PlayerID) VALUES ('02/24/2020', 14, 2, 2)
INSERT INTO tb_Round (PlayDate, PlayLength, LocationID, PlayerID) VALUES ('01/24/2020', 10, 1, 2)
INSERT INTO tb_Round (PlayDate, PlayLength, LocationID, PlayerID) VALUES ('04/24/2019', 4, 1, 2)
INSERT INTO tb_Round (PlayDate, PlayLength, LocationID, PlayerID) VALUES ('02/04/2020', 5, 3, 1)
INSERT INTO tb_Round (PlayDate, PlayLength, LocationID, PlayerID) VALUES ('03/24/2019', 3, 1, 5)
INSERT INTO tb_Round (PlayDate, PlayLength, LocationID, PlayerID) VALUES ('07/24/2019', 6, 4, 1)
INSERT INTO tb_Round (PlayDate, PlayLength, LocationID, PlayerID) VALUES ('08/24/2019', 7, 1, 1)
INSERT INTO tb_Round (PlayDate, PlayLength, LocationID, PlayerID) VALUES ('05/24/2019', 7, 5, 1)
INSERT INTO tb_Round (PlayDate, PlayLength, LocationID, PlayerID) VALUES ('05/18/2019', 5, 1, 1)
INSERT INTO tb_Round (PlayDate, PlayLength, LocationID, PlayerID) VALUES ('04/09/2019', 9, 6, 4)

-- tb_PlayGroup
INSERT INTO tb_PlayGroup (GroupDesc) VALUES ('LowIncome')
INSERT INTO tb_PlayGroup (GroupDesc) VALUES ('MedIncome')
INSERT INTO tb_PlayGroup (GroupDesc) VALUES ('HighIncome')

-- tb_TablePosition
INSERT INTO tb_TablePosition (PlayerID, PlayerGroupID, Position) VALUES (1, 3, 'east')
INSERT INTO tb_TablePosition (PlayerID, PlayerGroupID, Position) VALUES (2, 2, 'west')
INSERT INTO tb_TablePosition (PlayerID, PlayerGroupID, Position) VALUES (3, 3, 'south')
INSERT INTO tb_TablePosition (PlayerID, PlayerGroupID, Position) VALUES (4, 2, 'east')
INSERT INTO tb_TablePosition (PlayerID, PlayerGroupID, Position) VALUES (5, 2, 'south')


--tb_DifficultyLevel

INSERT INTO tb_DifficultyLevel (PlayerID, TilesetID, DiffLevel) VALUES (1, 1, 4)
INSERT INTO tb_DifficultyLevel (PlayerID, TilesetID, DiffLevel) VALUES (2, 2, 3)
INSERT INTO tb_DifficultyLevel (PlayerID, TilesetID, DiffLevel) VALUES (3, 3, 2)
INSERT INTO tb_DifficultyLevel (PlayerID, TilesetID, DiffLevel) VALUES (4, 4, 1)
INSERT INTO tb_DifficultyLevel (PlayerID, TilesetID, DiffLevel) VALUES (5, 6, 4)
INSERT INTO tb_DifficultyLevel (PlayerID, TilesetID, DiffLevel) VALUES (1, 7, 5)
INSERT INTO tb_DifficultyLevel (PlayerID, TilesetID, DiffLevel) VALUES (2, 1, 5)
INSERT INTO tb_DifficultyLevel (PlayerID, TilesetID, DiffLevel) VALUES (3, 2, 6)
INSERT INTO tb_DifficultyLevel (PlayerID, TilesetID, DiffLevel) VALUES (4, 3, 1)

-- tb_HWDepartment - setup department chairs...
-- this section only needed if you need to update data after inserting...


-- ====================================================================================
-- Select all the data from all the tables...
-- ====================================================================================
SELECT * FROM dbo.tb_Player
SELECT * FROM dbo.tb_FinalTileSet
SELECT * FROM dbo.tb_Location
SELECT * FROM dbo.tb_Round
SELECT * FROM dbo.tb_PlayGroup
SELECT * FROM dbo.tb_DifficultyLevel
SELECT * FROM dbo.tb_TablePosition

-- ====================================================================================
-- END CreateTablesForHomeworks
-- ====================================================================================