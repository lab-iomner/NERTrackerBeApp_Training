use master
go

if EXISTS(select * from sys.databases where name='NER_NCCI_001DB')
	drop database NER_NCCI_001DB
go

create database NER_NCCI_001DB
go

USE NER_NCCI_001DB
GO



CREATE TABLE tbl_Region(
	regionID varchar(5),
	region varchar(100),
	constraint pk_tbl_region primary key(regionID)
)
GO

CREATE TABLE tbl_Departement(
	IDdepartement int identity(1,1),
	Designation varchar(255) not null, 
	regionID varchar(5), -- Foreign key
	constraint pk_tbl_departement primary key(IDdepartement),
	constraint fk_Departement_Region foreign key(regionID) references tbl_Region(regionID)
)
GO

CREATE TABLE tbl_Commune(
	IDCommune int identity(1,1),
	Designation varchar(255) not null, 
	IDdepartement int,
	constraint pk_tbl_Commune primary key(IDCommune),
	constraint fk_tbl_departement_comm foreign key(IDdepartement) references tbl_Departement(IDdepartement)
)
GO


CREATE TABLE tbl_Objective(
	objectiveID int identity(1,1),
	fCode varchar(100) NOT NULL,
	objective varchar(500) NOT NULL,
	constraint pk_tbl_Objective primary key(objectiveID)
)
GO


CREATE TABLE tbl_ServiceType(
	id int identity(1,1),
	serviceTypeID varchar(100) NOT NULL,
	serviceTypeName varchar(255) NOT NULL,
	constraint pk_tbl_serviceType primary key(id)
)
GO

CREATE TABLE tbl_GrantData(
	grantID int identity(1,1),
	grantNumber varchar(255),
	grantTitle varchar(500) NOT NULL,
	grantSummary varchar(1000),
	objectiveID int not null, --foreign key
	regionID varchar(5) not null, --foreign key
	serviceTypeID int not null, --foreign key
	grantStatus varchar(50), --A ajouter dans la DLL

	constraint pk_tbl_grantData primary key(grantNumber),
	constraint fk_tbls_grantdata_objective foreign key(objectiveID) references tbl_Objective(objectiveID),
	constraint fk_tbls_grantdata_region foreign key(regionID) references tbl_Region(regionID),
	constraint fk_tbl_serviceType_grantdata foreign key(serviceTypeID) references tbl_ServiceType(id)
)
GO


-- Table for Beneficiairies tracker
CREATE TABLE tbl_BenefTracker(
	benefTrackID int identity(1,1),
	grantNumber varchar(255), --foreign key
	d_homme18_349 int not null DEFAULT (0),
	d_homme35_plus int not null DEFAULT (0),
	d_femme18_349 int not null DEFAULT (0),
	d_femme35_plus int not null DEFAULT (0),
	i_homme18_349 int not null DEFAULT (0),
	i_homme35_plus int not null DEFAULT (0),
	i_femme18_349 int not null DEFAULT (0),
	i_femme35_plus int not null DEFAULT (0),
	synchronized_on datetime DEFAULT GETDATE(),
	constraint pk_tbl_BenefTracker primary key(benefTrackID),
	constraint fk_tbl_BenefTrack_grantdata foreign key(grantNumber) references tbl_GrantData(grantNumber)
)
GO

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- CREATION DES UTILISATEURS
-- Table UTILISATEUR

CREATE TABLE tbl_staff
(
	staffID varchar(7) NOT NULL,
	staffName varchar(100) NOT NULL,
	staffFunction varchar(255) NOT NULL,
	constraint pk_tbl_staff PRIMARY KEY (staffID),
	constraint uk_staffName unique (staffName)
)
GO

-- Table Agent
INSERT INTO tbl_staff values ('NER753','Michelo','IM Officer'),('NER1000','Coline Celerier','Reporting Officer'),('NER721','Elise Riquier','ME Officer')

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Insertion dans les tables 

-- Table Region
INSERT INTO tbl_Region values ('TAH','Tahoua'),('NIA','Niamey'),('TIL','Tillaberi'),('DIF','Diffa'),('MAR','Maradi'),('AGA','Agadez'),('DOS','Dosso'),('ZIN','Zinder')

-- Table tbl_Commune

INSERT INTO tbl_Departement(Designation,regionID) Values ('ADERBISSINAT','AGA');
INSERT INTO tbl_Departement(Designation,regionID) Values ('ARLIT','AGA');
INSERT INTO tbl_Departement(Designation,regionID) Values ('BILMA','AGA');
INSERT INTO tbl_Departement(Designation,regionID) Values ('IFEROUANE','AGA');
INSERT INTO tbl_Departement(Designation,regionID) Values ('INGALL','AGA');
INSERT INTO tbl_Departement(Designation,regionID) Values ('TCHIROZERINE','AGA');
INSERT INTO tbl_Departement(Designation,regionID) Values ('BOSSO','DIF');
INSERT INTO tbl_Departement(Designation,regionID) Values ('DIFFA','DIF');
INSERT INTO tbl_Departement(Designation,regionID) Values ('GOUDOUMARIA','DIF');
INSERT INTO tbl_Departement(Designation,regionID) Values ('MAINE-SOROA','DIF');
INSERT INTO tbl_Departement(Designation,regionID) Values ('N''GOURTI','DIF');
INSERT INTO tbl_Departement(Designation,regionID) Values ('N''GUIGMI','DIF');
INSERT INTO tbl_Departement(Designation,regionID) Values ('BOBOYE','DOS');
INSERT INTO tbl_Departement(Designation,regionID) Values ('DIOUNDIOU','DIF');
INSERT INTO tbl_Departement(Designation,regionID) Values ('DOGONDOUTCHI','DOS');
INSERT INTO tbl_Departement(Designation,regionID) Values ('DOSSO','DOS');
INSERT INTO tbl_Departement(Designation,regionID) Values ('FALMEY','DOS');
INSERT INTO tbl_Departement(Designation,regionID) Values ('GAYA','DOS');
INSERT INTO tbl_Departement(Designation,regionID) Values ('LOGA','DOS');
INSERT INTO tbl_Departement(Designation,regionID) Values ('TIBIRI (DOUTCHI)','DOS');
INSERT INTO tbl_Departement(Designation,regionID) Values ('AGUIE','MAR');
INSERT INTO tbl_Departement(Designation,regionID) Values ('BERMO','MAR');
INSERT INTO tbl_Departement(Designation,regionID) Values ('DAKORO','MAR');
INSERT INTO tbl_Departement(Designation,regionID) Values ('GAZAOUA','MAR');
INSERT INTO tbl_Departement(Designation,regionID) Values ('GUIDAN-ROUMDJI','MAR');
INSERT INTO tbl_Departement(Designation,regionID) Values ('MADAROUNFA','MAR');
INSERT INTO tbl_Departement(Designation,regionID) Values ('MAYAHI','MAR');
INSERT INTO tbl_Departement(Designation,regionID) Values ('TESSAOUA','MAR');
INSERT INTO tbl_Departement(Designation,regionID) Values ('VILLE DE MARADI','MAR');
INSERT INTO tbl_Departement(Designation,regionID) Values ('ABALAK','TAH');
INSERT INTO tbl_Departement(Designation,regionID) Values ('BAGAROUA','TAH');
INSERT INTO tbl_Departement(Designation,regionID) Values ('BIRNI N''KONNI','TAH');
INSERT INTO tbl_Departement(Designation,regionID) Values ('BOUZA','TAH');
INSERT INTO tbl_Departement(Designation,regionID) Values ('ILLELA','TAH');
INSERT INTO tbl_Departement(Designation,regionID) Values ('KEITA','TAH');
INSERT INTO tbl_Departement(Designation,regionID) Values ('MADAOUA','TAH');
INSERT INTO tbl_Departement(Designation,regionID) Values ('MALBAZA','TAH');
INSERT INTO tbl_Departement(Designation,regionID) Values ('TAHOUA','TAH');
INSERT INTO tbl_Departement(Designation,regionID) Values ('TASSARA','TAH');
INSERT INTO tbl_Departement(Designation,regionID) Values ('TCHINTABARADEN','TAH');
INSERT INTO tbl_Departement(Designation,regionID) Values ('TILLIA','TAH');
INSERT INTO tbl_Departement(Designation,regionID) Values ('VILLE DE TAHOUA','TAH');
INSERT INTO tbl_Departement(Designation,regionID) Values ('ABALA','TIL');
INSERT INTO tbl_Departement(Designation,regionID) Values ('AYEROU','TIL');
INSERT INTO tbl_Departement(Designation,regionID) Values ('BALLEYARA','TIL');
INSERT INTO tbl_Departement(Designation,regionID) Values ('BANIBANGOU','TIL');
INSERT INTO tbl_Departement(Designation,regionID) Values ('BANKILARE','TIL');
INSERT INTO tbl_Departement(Designation,regionID) Values ('FILINGUE','TIL');
INSERT INTO tbl_Departement(Designation,regionID) Values ('GOTHEYE','TIL');
INSERT INTO tbl_Departement(Designation,regionID) Values ('KOLLO','TIL');
INSERT INTO tbl_Departement(Designation,regionID) Values ('OUALLAM','TIL');
INSERT INTO tbl_Departement(Designation,regionID) Values ('SAY','TIL');
INSERT INTO tbl_Departement(Designation,regionID) Values ('TERA','TIL');
INSERT INTO tbl_Departement(Designation,regionID) Values ('TILLABERI','TIL');
INSERT INTO tbl_Departement(Designation,regionID) Values ('TORODI','TIL');
INSERT INTO tbl_Departement(Designation,regionID) Values ('BELBEDJI','ZIN');
INSERT INTO tbl_Departement(Designation,regionID) Values ('DAMAGARAM TAKAYA','ZIN');
INSERT INTO tbl_Departement(Designation,regionID) Values ('DUNGASS','ZIN');
INSERT INTO tbl_Departement(Designation,regionID) Values ('GOURE','ZIN');
INSERT INTO tbl_Departement(Designation,regionID) Values ('KANTCHE','ZIN');
INSERT INTO tbl_Departement(Designation,regionID) Values ('MAGARIA','ZIN');
INSERT INTO tbl_Departement(Designation,regionID) Values ('MIRRIAH','ZIN');
INSERT INTO tbl_Departement(Designation,regionID) Values ('TAKEITA','ZIN');
INSERT INTO tbl_Departement(Designation,regionID) Values ('TANOUT','ZIN');
INSERT INTO tbl_Departement(Designation,regionID) Values ('TESKER','ZIN');
INSERT INTO tbl_Departement(Designation,regionID) Values ('VILLE DE ZINDER','ZIN');
INSERT INTO tbl_Departement(Designation,regionID) Values ('VILLE DE NIAMEY','NIA');

-- Table tbl_Commune

INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('NIAMEY ARRONDISSEMENT 1',67);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('NIAMEY ARRONDISSEMENT 2',67);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('NIAMEY ARRONDISSEMENT 3',67);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('NIAMEY ARRONDISSEMENT 4',67);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('NIAMEY ARRONDISSEMENT 5',67);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ZINDER ARRONDISSEMENT 1',66);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ZINDER ARRONDISSEMENT 2',66);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ZINDER ARRONDISSEMENT 3',66);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ZINDER ARRONDISSEMENT 4',66);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ZINDER ARRONDISSEMENT 5',66);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TESKER',65);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('FALENKO',64);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GANGARA (TANOUT)',64);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('OLLELEWA',64);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TANOUT',64);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TENHYA',64);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DAKOUSSA',63);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GARAGOUMSA',63);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TIRMINI',63);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DOGO',62);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DROUM',62);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GAFFATI',62);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GOUNA',62);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('HAMDARA',62);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KOLLERAM',62);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MIRRIAH',62);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ZERMOU',62);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BANDE',61);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DANTCHIAO',61);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KWAYA',61);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MAGARIA',61);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SASSOUMBROUM',61);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('WACHA',61);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('YEKOUA',61);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DAN BARTO',60);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DAOUCHE',60);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DOUNGOU',60);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ICHIRNAWA',60);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KANTCHE',60);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KOURNI',60);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MATAMEY',60);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TSAOUNI',60);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('YAOURI',60);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ALAKOSS',59);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BOUNE',59);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GAMOU',59);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GOURE',59);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GUIDIGUIR',59);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KELLE',59);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DOGO-DOGO',58);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DUNGASS',58);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GOUCHI',58);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MALAWA',58);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ALBARKARAM',57);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DAMAGARAM TAKAYA',57);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GUIDIMOUNI',57);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MAZAMNI',57);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MOA',57);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('WAME',57);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TARKA',56);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MAKALONDI',55);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TORODI',55);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ANZOUROU',54);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BIBIYERGOU',54);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DESSA',54);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KOURTEYE',54);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SAKOIRA',54);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SINDER',54);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TILLABERI',54);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DIAGOUROU',53);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GOROUOL',53);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KOKOROU',53);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MEHANA',53);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TERA',53);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('OURO GUELADJO',52);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SAY',52);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TAMOU',52);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DINGAZI',51);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('OUALLAM',51);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SIMIRI',51);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TONDIKIWINDI',51);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BITINKODJI',50);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DIANTCHANDOU',50);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('HAMDALLAYE',50);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KARMA',50);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KIRTACHI',50);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KOLLO',50);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KOURE',50);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('LIBORE',50);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('NAMARO',50);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('N''DOUNGA',50);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('YOURI',50);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DARGOL',49);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GOTHEYE',49);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('FILINGUE',48);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('IMANAN',48);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KOURFEYE CENTRE',48);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TONDIKANDIA',48);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BANKILARE',47);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BANIBANGOU',46);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TAGAZAR',45);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('AYEROU',44);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('INATES',44);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SANAM',43);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ABALA',43);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TAHOUA ARRONDISSEMENT 1',42);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TAHOUA ARRONDISSEMENT 2',42);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TILLIA',41);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TCHINTABARADEN',40);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KAO',40);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TASSARA',39);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('AFFALA',38);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BAMBEYE',38);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BARMOU',38);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KALFOU',38);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TAKANAMAT',38);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TEBARAM',38);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DOGUERAWA',37);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MALBAZA',37);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('AZARORI',36);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BANGUI',36);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GALMA KOUDAWATCHE',36);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MADAOUA',36);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('OURNO',36);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SABON GUIDA',36);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TAMASKE',35);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KEITA',35);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('IBOHAMANE',35);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GARHANGA',35);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TAJAE',34);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ILLELA',34);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BADAGUICHIRI',34);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TAMA',33);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TABOTAKI',33);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KAROFANE',33);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DEOULE',33);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BABANKATAMI',33);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ALLAKAYE',33);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TSERNAOUA',32);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BIRNI N''KONNI',32);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BAZAGA',32);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ALLELA',32);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BAGAROUA',31);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TAMAYA',30);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TABALAK',30);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('AZEYE',30);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('AKOUBOUNOU',30);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ABALAK',30);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MARADI ARRONDISSEMENT 1',29);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MARADI ARRONDISSEMENT 2',29);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MARADI ARRONDISSEMENT 3',29);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TESSAOUA',28);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('OURAFANE',28);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MAIJIRGUI',28);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KORGOM',28);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KOONA',28);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('HAWANDAWAKI',28);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BAOUDETTA',28);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TCHAKE',27);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SARKIN HAOUSSA',27);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MAYAHI',27);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KANAN-BAKACHE',27);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ISSAWANE',27);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GUIDAN AMOUMOUNE',27);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('EL ALLASSANE MAIREYREY',27);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ATTANTANE',27);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SARKIN YAMMA',26);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SAFO',26);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MADAROUNFA',26);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GABI',26);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DJIRATAWA',26);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DAN-ISSA',26);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TIBIRI (MARADI)',25);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SAE SABOUA',25);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GUIDAN SORI',25);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GUIDAN ROUMDJI',25);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('CHADAKORI',25);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GAZAOUA',24);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GANGARA (AGUIE)',24);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TAGRISS',23);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SABON MACHI',23);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ROUMBOU I',23);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MAIYARA',23);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KORNAKA',23);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KORAHANE',23);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DAN-GOULBI',23);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DAKORO',23);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BIRNI LALLE',23);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BADER GOULA',23);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('AZAGOR',23);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ADJEKORIA',23);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GADABEDJI',22);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BERMO',22);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TCHADOUA',21);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('AGUIE',21);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TIBIRI (DOUTCHI)',20);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KORE MAIROUA',20);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GUECHEME',20);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DOUMEGA',20);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SOKORBE',19);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('LOGA',19);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('FALWEL',19);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('YELOU',18);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TOUNOUGA',18);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TANDA',18);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GAYA',18);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BENGOU',18);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BANA',18);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GUILLADJE',17);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('FALMEY',17);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TOMBOKOIREY II',16);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TOMBOKOIREY I',16);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TESSA',16);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SAMBERA',16);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MOKKO',16);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KARGUIBANGOU',16);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GOROUBANKASSAM',16);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GOLLE',16);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GARANKEDEY',16);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('FAREY',16);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DOSSO',16);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('SOUCOUCOUTANE',15);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MATANKARI',15);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KIECHE',15);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DOGONKIRIA',15);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DOGONDOUTCHI',15);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DAN-KASSARI',15);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ZABORI',14);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KARAKARA',14);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('D''IOUNDIOU',14);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('N''GONGA',13);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KOYGOLO',13);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KIOTA',13);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KANKANDI',13);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('HARIKANASSOU',13);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('FAKARA',13);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('FABIDJI',13);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BIRNI N''GAOURE',13);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('N''GUIGMI',12);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('KABLEWA',12);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('N''GOURTI',11);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('N''GUELBELY',10);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('MAINE SOROA',10);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('FOULATARI',10);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GOUDOUMARIA',9);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GUESKEROU',8);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DIFFA',8);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('CHETIMARI',8);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TOUMOUR',7);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BOSSO',7);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TCHIROZERINE',6);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TABELOT',6);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DABAGA',6);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('AGADEZ',6);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('INGALL',5);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('TIMIA',4);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('IFEROUANE',4);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DJADO',3);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('GOUGARAM',2);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DANNET',2);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ARLIT',2);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('ADERBISSINAT',1);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BILMA',3);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('DIRKOU',3);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('FACHI',3);
INSERT INTO tbl_Commune(Designation,IDdepartement) Values ('BOUZA',33);
