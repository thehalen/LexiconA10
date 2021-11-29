DROP DATABASE IF EXISTS A10P1;
CREATE DATABASE A10P1;
USE A10P1;

CREATE TABLE player(
	IDNum VARCHAR(12),
	Age INT,
	`Name` VARCHAR(30),
	PRIMARY KEY(IDNum))
    ENGINE=InnoDB;

CREATE TABLE jacket(
	Size INT,
	Material VARCHAR(30),
	Model VARCHAR(30),
	IDNum VARCHAR(12),
	PRIMARY KEY(IDNum, Model),
	FOREIGN KEY(IDNum) REFERENCES player(IDNum)
	ON DELETE CASCADE)
    ENGINE=InnoDB;

CREATE TABLE competition(
	CompName VARCHAR(30),
	DatePlayed DATE,
	PRIMARY KEY(CompName))
    ENGINE=InnoDB;

CREATE TABLE club(
	ClubNumber INT,
	Material VARCHAR(10),
	IDNum VARCHAR(12),
	construction VARCHAR(20),
	PRIMARY KEY(IDNum, ClubNumber),
	FOREIGN KEY(IDNum) REFERENCES player(IDNum)
	ON DELETE CASCADE)
	ENGINE=InnoDB;

CREATE TABLE construction(
	SerialNum INT,
	Hardness INT,
	PRIMARY KEY(SerialNum))
	ENGINE=InnoDB;

CREATE TABLE rain (
	`Type` VARCHAR(20),
	Windspeed INT,
	PRIMARY KEY(`Type`))
	ENGINE=InnoDB;

CREATE TABLE competed(
	IDNum VARCHAR(12),
	CompName VARCHAR(20),
	PRIMARY KEY(IDNum, CompName),
	FOREIGN KEY(IDNum) REFERENCES player(IDNum)
	ON DELETE CASCADE,
	FOREIGN KEY(CompName) REFERENCES competition(CompName)
	ON DELETE CASCADE)
	ENGINE=InnoDB;

CREATE TABLE has(
	`Type` VARCHAR(20),
	CompName VARCHAR(20),
	`Date` DATETIME,
	PRIMARY KEY(`Type`, CompName),
	FOREIGN KEY(`Type`) REFERENCES rain(`Type`)
	ON DELETE CASCADE,
	FOREIGN KEY(CompName) REFERENCES competition(CompName)
	ON DELETE CASCADE)
	ENGINE=InnoDB;

INSERT INTO player (IDNum, Age, `Name`) VALUES ('199607232858', 25, 'Johan Andersson');
INSERT INTO player (IDNum, Age, `Name`) VALUES ('196607235618', 35, 'Nicklas Jansson');
INSERT INTO player (IDNum, Age, `Name`) VALUES ('198301234186', 38, 'Annika Persson');
INSERT INTO competition (CompName, DatePlayed) VALUES ('Big Golf Cup Skövde', '2021-06-10');
INSERT INTO construction (SerialNum, Hardness) VALUES (4353, 10);
INSERT INTO construction (SerialNum, Hardness) VALUES (7756, 5);
INSERT INTO jacket (Size, Model, Material, IDNum) VALUES (51, 'Träningsjacka', 'Fleece', '199607232858');
INSERT INTO jacket (Size, Model, Material, IDNum) VALUES (52, 'Regnjacka', 'Gore-tex', '199607232858'); 
INSERT INTO club (ClubNumber, Material, IDNum, construction) VALUES (45654, 'Trå', '196607235618', 4353);
INSERT INTO club (ClubNumber, Material, IDNum, construction) VALUES (456, 'Trä', '198301234186', 4353);
INSERT INTO club (ClubNumber, Material, IDNum, construction) VALUES (234, 'Järn', '199607232858', 7756);
INSERT INTO competed (IDNum, CompName) VALUES ('199607232858', 'Big Golf Cup Skövde');
INSERT INTO competed (IDNum, CompName) VALUES ('196607235618', 'Big Golf Cup Skövde');
INSERT INTO competed (IDNum, CompName) VALUES ('198301234186', 'Big Golf Cup Skövde');
INSERT INTO rain (`Type`, Windspeed) VALUES ('hagel', 10);
INSERT INTO has (`Type`, CompName, `Date`) VALUES ('hagel', 'Big Golf Cup Skövde', '2021-06-10 12:00:00');


#1
SELECT Age FROM player WHERE `Name`='Johan Andersson';

#2
SELECT DatePlayed FROM competition WHERE CompName= 'Big Golf Cup Skövde';

#3
SELECT Material
FROM club
WHERE IDNum IN (SELECT IDNum
	FROM player
	WHERE `Name`='Johan Andersson');

#4
SELECT Size, Model, Material
FROM jacket
WHERE IDNum IN (SELECT IDNum
	FROM player
	WHERE `Name`='Johan Andersson');

#5
SELECT `Name` FROM competed
	INNER JOIN player ON competed.IDNum=player.IDNum
	INNER JOIN competition AS comp ON competed.CompName=comp.CompName
	WHERE comp.CompName='Big Golf Cup Skövde';

#6
SELECT Windspeed FROM has
	INNER JOIN rain ON has.`Type`=rain.`Type`
	INNER JOIN competition AS comp ON has.CompName=comp.CompName
	WHERE comp.CompName='Big Golf Cup Skövde';

#7
SELECT `Name` FROM player WHERE Age < 30;

#8
DELETE FROM jacket
WHERE IDNum IN (SELECT IDNum
	FROM player
	WHERE `Name`='Johan Andersson');

#9
DELETE FROM player WHERE IDNum='196607235618';

#10
SELECT AVG(Age) FROM player;