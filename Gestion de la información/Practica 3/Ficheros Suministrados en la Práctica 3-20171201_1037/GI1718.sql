USE [master]
GO
DROP DATABASE GI1718
GO
CREATE DATABASE GI1718
GO
USE GI1718
GO

/****** Object:  Table [dbo].[tPais]    Script Date: 04/11/2015 11:13:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tPantalla]    Script Date: 04/11/2015 11:13:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tPantalla](
	[pantalla] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tPantalla] PRIMARY KEY CLUSTERED 
(
	[pantalla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tPermiso]    Script Date: 04/11/2015 11:13:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tPermiso](
	[rolName] [varchar](50) NOT NULL,
	[pantalla] [varchar](50) NOT NULL,
	[acceso] [bit] NOT NULL,
	[modificacion] [bit] NOT NULL,
 CONSTRAINT [PK_tPermiso] PRIMARY KEY CLUSTERED 
(
	[rolName] ASC,
	[pantalla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tRol]    Script Date: 04/11/2015 11:13:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tRol](
	[rolName] [varchar](50) NOT NULL,
	[rolDes] [varchar](255) NULL,
	[admin] [bit] NOT NULL,
 CONSTRAINT [PK_tRol] PRIMARY KEY CLUSTERED 
(
	[rolName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tUsuario]    Script Date: 04/11/2015 11:13:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tUsuario](
	[nombre] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[rolName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tUsuario] PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[tPermiso]  WITH CHECK ADD  CONSTRAINT [FK_tPermiso_tPantalla] FOREIGN KEY([pantalla])
REFERENCES [dbo].[tPantalla] ([pantalla])
GO
ALTER TABLE [dbo].[tPermiso] CHECK CONSTRAINT [FK_tPermiso_tPantalla]
GO
ALTER TABLE [dbo].[tPermiso]  WITH CHECK ADD  CONSTRAINT [FK_tPermiso_tRol] FOREIGN KEY([rolName])
REFERENCES [dbo].[tRol] ([rolName])
GO
ALTER TABLE [dbo].[tPermiso] CHECK CONSTRAINT [FK_tPermiso_tRol]
GO
ALTER TABLE [dbo].[tUsuario]  WITH CHECK ADD  CONSTRAINT [FK_tUsuario_tRol] FOREIGN KEY([rolName])
REFERENCES [dbo].[tRol] ([rolName])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tUsuario] CHECK CONSTRAINT [FK_tUsuario_tRol]
GO

/****** Object:  Table [dbo].[tCancion]    Script Date: 09/11/2017 10:57:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tCancion](
	[ID_CANCION] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](50) NOT NULL,
	[ID_Grupo] [int] NOT NULL,
 CONSTRAINT [PK_Cancion] PRIMARY KEY CLUSTERED 
(
	[ID_CANCION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tGrupo]    Script Date: 09/11/2017 10:57:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tGrupo](
	[ID_Grupo] [int] NOT NULL,
	[NOMBRE] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tGrupo] PRIMARY KEY CLUSTERED 
(
	[ID_Grupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[tCancion]  WITH CHECK ADD  CONSTRAINT [FK_Cancion_tGrupo] FOREIGN KEY([ID_Grupo])
REFERENCES [dbo].[tGrupo] ([ID_Grupo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tCancion] CHECK CONSTRAINT [FK_Cancion_tGrupo]
GO


DELETE tPantalla;
GO
INSERT INTO tPantalla VALUES('LOGIN');
INSERT INTO tPantalla VALUES('USUARIOS');
INSERT INTO tPantalla VALUES('GRUPOS');
INSERT INTO tPantalla VALUES('CANCIONES');
GO

DELETE tRol;
INSERT INTO tRol VALUES('administrador', 'administrador',1);
INSERT INTO tRol VALUES('grupo', 'grupo',0);
INSERT INTO tRol VALUES('usuario', 'usuario',0);
INSERT INTO tRol VALUES('discografica', 'discografica',0);
GO

DELETE tUsuario;
GO
INSERT INTO tUsuario VALUES('admin', 'admin','administrador');
INSERT INTO tUsuario VALUES('james', 'metallica','grupo');
INSERT INTO tUsuario VALUES('jose', 'jose','usuario');
INSERT INTO tUsuario VALUES('Megaforce Records', 'mega','discografica');
GO

DELETE tPermiso;
GO
INSERT INTO tPermiso VALUES('administrador','LOGIN',1,1);
INSERT INTO tPermiso VALUES('administrador','USUARIOS',1,1);
INSERT INTO tPermiso VALUES('administrador','GRUPOS',1,1);
INSERT INTO tPermiso VALUES('administrador','CANCIONES',1,1);

INSERT INTO tPermiso VALUES('grupo','LOGIN',1,1);
INSERT INTO tPermiso VALUES('grupo','USUARIOS',0,0);
INSERT INTO tPermiso VALUES('grupo','GRUPOS',1,1);
INSERT INTO tPermiso VALUES('grupo','CANCIONES',1,0);

INSERT INTO tPermiso VALUES('usuario','LOGIN',1,1);
INSERT INTO tPermiso VALUES('usuario','USUARIOS',0,0);
INSERT INTO tPermiso VALUES('usuario','GRUPOS',1,0);
INSERT INTO tPermiso VALUES('usuario','CANCIONES',1,0);

INSERT INTO tPermiso VALUES('discografica','LOGIN',1,1);
INSERT INTO tPermiso VALUES('discografica','USUARIOS',0,0);
INSERT INTO tPermiso VALUES('discografica','GRUPOS',1,0);
INSERT INTO tPermiso VALUES('discografica','CANCIONES',1,1);

GO

DELETE tGrupo;
GO
INSERT INTO tGrupo VALUES(1,'AC/DC');
GO
INSERT INTO tGrupo VALUES(2,'ADAMS BRYAN');
GO
INSERT INTO tGrupo VALUES(3,'AEROSMITH');
GO
INSERT INTO tGrupo VALUES(4,'AIRBOURNE');
GO
INSERT INTO tGrupo VALUES(5,'ALICE COOPER');
GO
INSERT INTO tGrupo VALUES(6,'ALICE IN CHAINS');
GO
INSERT INTO tGrupo VALUES(7,'AMERICA');
GO
INSERT INTO tGrupo VALUES(8,'ANIMALS THE');
GO
INSERT INTO tGrupo VALUES(9,'ASFALTO');
GO
INSERT INTO tGrupo VALUES(10,'BAD COMPANY');
GO
INSERT INTO tGrupo VALUES(11,'BARRICADA');
GO
INSERT INTO tGrupo VALUES(12,'BAR�N ROJO');
GO
INSERT INTO tGrupo VALUES(13,'BEACH BOYS THE');
GO
INSERT INTO tGrupo VALUES(14,'BEATLES THE');
GO
INSERT INTO tGrupo VALUES(15,'BERRY CHUCK');
GO
INSERT INTO tGrupo VALUES(16,'BILLY JOEL');
GO
INSERT INTO tGrupo VALUES(17,'BLACK CROWES THE');
GO
INSERT INTO tGrupo VALUES(18,'BLACK SABBATH');
GO
INSERT INTO tGrupo VALUES(19,'BLONDIE');
GO
INSERT INTO tGrupo VALUES(20,'BOB DYLAN');
GO
INSERT INTO tGrupo VALUES(21,'BON JOVI');
GO
INSERT INTO tGrupo VALUES(22,'BOSTON');
GO
INSERT INTO tGrupo VALUES(23,'BROWNE JACKSON');
GO
INSERT INTO tGrupo VALUES(24,'BRUCE SPRINGSTEEN');
GO
INSERT INTO tGrupo VALUES(25,'BUFFALO SPRINGFIELD');
GO
INSERT INTO tGrupo VALUES(26,'BURNING');
GO
INSERT INTO tGrupo VALUES(27,'CLASH THE');
GO
INSERT INTO tGrupo VALUES(28,'COCKER JOE');
GO
INSERT INTO tGrupo VALUES(29,'COLDPLAY');
GO
INSERT INTO tGrupo VALUES(30,'COOPER ALICE');
GO
INSERT INTO tGrupo VALUES(31,'COUNTING CROWS');
GO
INSERT INTO tGrupo VALUES(32,'CREAM');
GO
INSERT INTO tGrupo VALUES(33,'CREEDENCE CLEARWATER');
GO
INSERT INTO tGrupo VALUES(34,'CREEDENCE CLEARWATER REVIVAL');
GO
INSERT INTO tGrupo VALUES(35,'CURE THE');
GO
INSERT INTO tGrupo VALUES(36,'DAVID BOWIE');
GO
INSERT INTO tGrupo VALUES(37,'DEEP PURPLE');
GO
INSERT INTO tGrupo VALUES(38,'DEF LEPPARD');
GO
INSERT INTO tGrupo VALUES(39,'DEREK & THE DOMINOS');
GO
INSERT INTO tGrupo VALUES(40,'DIO');
GO
INSERT INTO tGrupo VALUES(41,'DIRE STRAITS');
GO
INSERT INTO tGrupo VALUES(42,'DON MCLEAN');
GO
INSERT INTO tGrupo VALUES(43,'DOORS THE');
GO
INSERT INTO tGrupo VALUES(44,'DOVER');
GO
INSERT INTO tGrupo VALUES(45,'EAGLES THE');
GO
INSERT INTO tGrupo VALUES(46,'ELVIS PRESLEY');
GO
INSERT INTO tGrupo VALUES(47,'EUROPE');
GO
INSERT INTO tGrupo VALUES(48,'EXTREME');
GO
INSERT INTO tGrupo VALUES(49,'FACES');
GO
INSERT INTO tGrupo VALUES(50,'FITO Y FITIPALDIS');
GO
INSERT INTO tGrupo VALUES(51,'FLEETWOOD MAC');
GO
INSERT INTO tGrupo VALUES(52,'FOGERTY JOHN');
GO
INSERT INTO tGrupo VALUES(53,'FOO FIGHTERS');
GO
INSERT INTO tGrupo VALUES(54,'FREE');
GO
INSERT INTO tGrupo VALUES(55,'GARY MOORE');
GO
INSERT INTO tGrupo VALUES(56,'GENESIS');
GO
INSERT INTO tGrupo VALUES(57,'GRAND FUNK RAILROAD');
GO
INSERT INTO tGrupo VALUES(58,'GREEN DAY');
GO
INSERT INTO tGrupo VALUES(59,'GUNS AND ROSES');
GO
INSERT INTO tGrupo VALUES(60,'GUNS N` ROSES');
GO
INSERT INTO tGrupo VALUES(61,'HEROES DEL SILENCIO');
GO
INSERT INTO tGrupo VALUES(62,'IRON MAIDEN');
GO
INSERT INTO tGrupo VALUES(63,'J.GEILS BAND');
GO
INSERT INTO tGrupo VALUES(64,'JANIS JOPLIN');
GO
INSERT INTO tGrupo VALUES(65,'JEFFERSON AIRPLANE');
GO
INSERT INTO tGrupo VALUES(66,'JERRY LEE LEWIS');
GO
INSERT INTO tGrupo VALUES(67,'JETHRO TULL');
GO
INSERT INTO tGrupo VALUES(68,'JEt JOAN & THE BLACKHEARTS');
GO
INSERT INTO tGrupo VALUES(69,'JIMI HENDRIX');
GO
INSERT INTO tGrupo VALUES(70,'JJ CALE');
GO
INSERT INTO tGrupo VALUES(71,'JOURNEY');
GO
INSERT INTO tGrupo VALUES(72,'JUDAS PRIEST');
GO
INSERT INTO tGrupo VALUES(73,'KINKS THE');
GO
INSERT INTO tGrupo VALUES(74,'KISS');
GO
INSERT INTO tGrupo VALUES(75,'KROEGER CHAD');
GO
INSERT INTO tGrupo VALUES(76,'LED ZEPPELIN');
GO
INSERT INTO tGrupo VALUES(77,'LE�O/ROSENDO');
GO
INSERT INTO tGrupo VALUES(78,'LItLE RICHARD');
GO
INSERT INTO tGrupo VALUES(79,'LOQUILLO Y LOS TROGLODITAS');
GO
INSERT INTO tGrupo VALUES(80,'LOU REED');
GO
INSERT INTO tGrupo VALUES(81,'LYNYRD SKYNYRD');
GO
INSERT INTO tGrupo VALUES(82,'M-CLAN');
GO
INSERT INTO tGrupo VALUES(83,'MAMAS & THE PAPAS');
GO
INSERT INTO tGrupo VALUES(84,'MARILYN MANSON');
GO
INSERT INTO tGrupo VALUES(85,'MC5');
GO
INSERT INTO tGrupo VALUES(86,'MEGADETH');
GO
INSERT INTO tGrupo VALUES(87,'METALLICA');
GO
INSERT INTO tGrupo VALUES(88,'MILLER STEVE BAND');
GO
INSERT INTO tGrupo VALUES(89,'MOT�RHEAD');
GO
INSERT INTO tGrupo VALUES(90,'MOUNTAIN');
GO
INSERT INTO tGrupo VALUES(91,'MR. BIG');
GO
INSERT INTO tGrupo VALUES(92,'NEIL YOUNG');
GO
INSERT INTO tGrupo VALUES(93,'NIRVANA');
GO
INSERT INTO tGrupo VALUES(94,'NO DOUBT');
GO
INSERT INTO tGrupo VALUES(95,'OASIS');
GO
INSERT INTO tGrupo VALUES(96,'OFFSPRING THE');
GO
INSERT INTO tGrupo VALUES(97,'OZZY OSBOURNE');
GO
INSERT INTO tGrupo VALUES(98,'PEARL JAM');
GO
INSERT INTO tGrupo VALUES(99,'PINK FLOYD');
GO
INSERT INTO tGrupo VALUES(100,'PIXIES');
GO
INSERT INTO tGrupo VALUES(101,'PLATERO Y T�');
GO
INSERT INTO tGrupo VALUES(102,'POLICE THE');
GO
INSERT INTO tGrupo VALUES(103,'PRESLEY ELVIS');
GO
INSERT INTO tGrupo VALUES(104,'PRIMAL SCREAM');
GO
INSERT INTO tGrupo VALUES(105,'QUEEN');
GO
INSERT INTO tGrupo VALUES(106,'QUEENS OF THE STONE AGE');
GO
INSERT INTO tGrupo VALUES(107,'R.E.M.');
GO
INSERT INTO tGrupo VALUES(108,'RADIOHEAD');
GO
INSERT INTO tGrupo VALUES(109,'RAGE AGAINST THE MACHINE');
GO
INSERT INTO tGrupo VALUES(110,'RAINBOW');
GO
INSERT INTO tGrupo VALUES(111,'RAMONES');
GO
INSERT INTO tGrupo VALUES(112,'RED HOT CHILI PEPPERS');
GO
INSERT INTO tGrupo VALUES(113,'ROD STEWART');
GO
INSERT INTO tGrupo VALUES(114,'ROLLING STONES THE');
GO
INSERT INTO tGrupo VALUES(115,'ROMANTICS THE');
GO
INSERT INTO tGrupo VALUES(116,'ROSENDO');
GO
INSERT INTO tGrupo VALUES(117,'SABINA JOAQU�N');
GO
INSERT INTO tGrupo VALUES(118,'SANTANA');
GO
INSERT INTO tGrupo VALUES(119,'SANTANA & THOMAS ROB');
GO
INSERT INTO tGrupo VALUES(120,'SCORPIONS');
GO
INSERT INTO tGrupo VALUES(121,'SKID ROW');
GO
INSERT INTO tGrupo VALUES(122,'SMASHING PUMPKINS');
GO
INSERT INTO tGrupo VALUES(123,'SPENCER DAVIES GROUP');
GO
INSERT INTO tGrupo VALUES(124,'SPRINGSTEEN BRUCE');
GO
INSERT INTO tGrupo VALUES(125,'STATUS QUO');
GO
INSERT INTO tGrupo VALUES(126,'STEPPENWOLF');
GO
INSERT INTO tGrupo VALUES(127,'STEVE MILLER BAND');
GO
INSERT INTO tGrupo VALUES(128,'STEVIE WONDER');
GO
INSERT INTO tGrupo VALUES(129,'STRANGLERS THE');
GO
INSERT INTO tGrupo VALUES(130,'STROKES THE');
GO
INSERT INTO tGrupo VALUES(131,'SURVIVOR');
GO
INSERT INTO tGrupo VALUES(132,'SYSTEM OF A DOWN');
GO
INSERT INTO tGrupo VALUES(133,'S�BER');
GO
INSERT INTO tGrupo VALUES(134,'T REX');
GO
INSERT INTO tGrupo VALUES(135,'TED NUGENT');
GO
INSERT INTO tGrupo VALUES(136,'THE BAND');
GO
INSERT INTO tGrupo VALUES(137,'THE BEATLES');
GO
INSERT INTO tGrupo VALUES(138,'THE BOX TOPS');
GO
INSERT INTO tGrupo VALUES(139,'THE GUESS WHO');
GO
INSERT INTO tGrupo VALUES(140,'THE RUNAWAYS');
GO
INSERT INTO tGrupo VALUES(141,'THE STROKES');
GO
INSERT INTO tGrupo VALUES(142,'THE TRASHMEN');
GO
INSERT INTO tGrupo VALUES(143,'THE TROGGS');
GO
INSERT INTO tGrupo VALUES(144,'THE WHITE STRIPES');
GO
INSERT INTO tGrupo VALUES(145,'THIN LIZZY');
GO
INSERT INTO tGrupo VALUES(146,'TOM PEtY');
GO
INSERT INTO tGrupo VALUES(147,'TOTO');
GO
INSERT INTO tGrupo VALUES(148,'TWISTED SISTER');
GO
INSERT INTO tGrupo VALUES(149,'U2');
GO
INSERT INTO tGrupo VALUES(150,'VAN HALEN');
GO
INSERT INTO tGrupo VALUES(151,'VAN MORRISON');
GO
INSERT INTO tGrupo VALUES(152,'VAN MORRISON / THEM');
GO
INSERT INTO tGrupo VALUES(153,'VELVET UNDERGROUND THE');
GO
INSERT INTO tGrupo VALUES(154,'WHITESNAKE');
GO
INSERT INTO tGrupo VALUES(155,'WHO THE');
GO
INSERT INTO tGrupo VALUES(156,'ZZ TOP');
GO

DELETE tCancion;
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HIGHWAY TO HELL',1);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('YOU SHOOK ME ALL NIGHT LONG',1);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LET THERE BE ROCK',1);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('THUNDERSTRUCK',1);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BACK IN BLACK',1);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WHO MADE WHO',1);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LET`S GET IT UP',1);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WHOLE LOtA ROSIE',1);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HARD AS A ROCK',1);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('T.N.T.',1);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SUMMER OF `69',2);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('RUN TO YOU',2);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('I DON`T WANT TO MISS A THING',3);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LIVING ON THE EDGE',3);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('JANIE`S GOT A GUN',3);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('AMAZING',3);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('STAND UP FOR ROCK AND ROLL',4);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SCHOOL`S OUT',5);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('MAN IN THE BOX',6);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('A HORSE WITH NO NAME',7);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SISTER GOLDEN HAIR',7);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('THE HOUSE OF THE RISING SUN',8);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('D�AS DE ESCUELA',9);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CAN`T GET ENOUGH',10);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('EN BLANCO Y NEGRO',11);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LOS ROCKEROS VAN AL INFIERNO',12);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SURFIN USA',13);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HEY JUDE',14);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('A HARD DAY`S NIGHT',14);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HELTER SKELTER',14);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('REVOLUTION',14);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LUCY IN THE SKY WITH DIAMONDS',14);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('JOHNNY B. GOODE',15);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('YOU NEVER CAN TELL',15);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('PIANO MAN',16);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HARD TO HANDLE',17);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('REMEDY',17);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CONSPIRACY',17);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('PARANOID',18);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HEAVEN AND HELL',18);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CALL ME',19);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LIKE A ROLLING STONE',20);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('KNOCKIN` ON HEAVEN`S DOOR',20);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BLOWIN` IN THE WIND',20);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LIVIN` ON A PRAYER',21);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BAD MEDICINE',21);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('RUNAWAY',21);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BLAZE OF GLORY',21);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BORN TO BE MY BABY',21);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BED OF ROSES',21);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('I`LL BE THERE FOR YOU',21);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WANTED DEAD OR ALIVE',21);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('MORE THAN A FEELING',22);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('STAY',23);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('GLORY DAYS',24);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('DANCING IN THE DARK',24);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('FOR WHAT IT�S WORTH',25);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('QU� HACE UNA CHICA COMO Tڅ',26);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LONDON CALLING',27);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SHOULD I STAY OR SHOULD I GO',27);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SUMMER IN THE CITY',28);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WITH A LItLE HELP OF MY FRIENDS',28);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CLOCKS',29);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HEY STUPID',30);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('MR. JONES',31);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CLAPTON ERIC',32);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('FORTUNATE SON',33);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HAVE YOU EVER SEEN THE RAIN',33);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('PROUD MARY',34);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('TRAVELIN` BAND',34);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LULLABY',35);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HEROES',36);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SMOKE ON THE WATER',37);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HIGHWAY STAR',37);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BLACK NIGHT',37);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('POUR SOME SUGAR ON ME',38);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LAYLA (ORIGINAL)',39);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WE ROCK',40);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SULTANS OF SWING',41);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SO FAR AWAY',41);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('THE BUG',41);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('MONEY FOR NOTHING',41);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WALK OF LIFE',41);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('AMERICAN PIE',42);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BREAK ON THROUGH',43);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LIGHT MY FIRE',43);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('L.A. WOMAN',43);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('RIDERS ON THE STORM',43);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('KING GEORGE',44);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SERENADE',44);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HOTEL CALIFORNIA',45);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('JAILHOUSE ROCK',46);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ROCK THE NIGHT',47);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('MORE THAN WORDS',48);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('STAY WITH ME',49);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('QUIERO BEBER HASTA PERDER EL CONTROL',50);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SOLDADITO MARINERO',50);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LA CASA POR EL TEJADO',50);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('DON`T STOP',51);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ROCKIN` ALL OVER THE WORLD',52);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('EVERLONG',53);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ALL MY LIFE',53);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ALLRIGHT NOW',54);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('STILL GOT THE BLUES',55);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WALKING BY MYSELF',55);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('DANCING WITH THE MOONLIT KNIGHT',56);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WE`RE AN AMERICAN BAND',57);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BASKET CASE',58);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HOLIDAY',58);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('AMERICAN IDIOT',58);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('NOVEMBER RAIN',59);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SINCE I DON`T HAVE YOU',59);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WELCOME TO THE JUNGLE',59);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('YOU COULD BE MINE',59);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('YESTERDAYS',59);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SWEET CHILD OF MINE',60);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CIVIL WAR',60);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ENTRE DOS TIERRAS',61);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('RUN TO THE HILLS',62);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('2 MINUTES TO MIDNIGHT',62);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('THE NUMBER OF THE BEAST',62);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CENTERFOLD',63);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CRY BABY',64);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('PIECE OF MY HEART',64);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SOMEBODY TO LOVE',65);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('GREAT BALLS OF FIRE',66);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('AQUALUNG',67);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('THICK AS A BRICK (EXTRACT)',67);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('I LOVE ROCK & ROLL',68);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HEY JOE',69);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('PURPLE HAZE',69);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('COCAINE',70);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('DON`T STOP BELIEVING',71);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ANY WAY YOU WANT IT',71);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LIVING AFTER MIDNIGHT',72);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('UNITED',72);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('YOU REALLY GOT ME',73);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('I WAS MADE FOR LOVING YOU',74);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ROCK AND ROLL ALL NITE',74);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('NICKELBACK',75);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('STAIRWAY TO HEAVEN',76);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ROCK AND ROLL',76);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('MANERAS DE VIVIR',77);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('FLOJOS DE PANTAL�N',77);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('TUtI - FRUtI',78);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CADILLAC SOLITARIO',79);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WALK ON THE WILD SIDE',80);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SWEET HOME ALABAMA',81);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SIMPLE MAN',81);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('QU�DATE A DORMIR',82);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CALIFORNIA DREAMIN`',83);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SWEET DREAMS (ARE MADE OF THIS)',84);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('KICK OUT THE JAMS',85);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SYMPHONY OF DESTRUCTION',86);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('A TOUT LE MONDE',86);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('NOTHING ELSE MATTERS',87);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ONE',87);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('MASTER OF PUPPETS',87);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('FOR WHOM THE BELL TOLLS',87);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ENTER SANDMAN',87);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('THE MEMORY REMAINS',87);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ABRACADABRA',88);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ACE OF SPADES',89);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BORN TO RAISE HELL',89);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('MISSISSIPPI QUEEN',90);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WILD WORLD',91);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ROCKIN IN THE FREE WORLD',92);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HEART OF GOLD',92);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SMELLS LIKE TEEN SPIRIT',93);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('COME AS YOU ARE',93);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ABOUT A GIRL',93);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('THE MAN WHO SOLD THE WORLD (Live)',93);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LITHIUM',93);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('JUST A GIRL',94);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WONDERWALL',95);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('DON`T LOOK BACK IN ANGER',95);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('KIDS AREN`T ALLRIGHT',96);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WHY DON`T YOU GET A JOB',96);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CRAZY TRAIN',97);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('MAMA I`M COMING HOME',97);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ALIVE',98);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('REARVIEWMIRROR',98);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('EVEN FLOW',98);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WISH YOU WERE HERE',99);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ANOTHER BRICK ON THE WALL',99);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('COMFORTABLY NUMB',99);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('MONEY',99);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HERE COMES YOUR MAN',100);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HAY POCO ROCK AND ROLL',101);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SO LONELY',102);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CAN`T STAND LOSING YOU',102);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ROXANNE',102);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('DON`T STAND SO CLOSE TO ME',102);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HOUND DOG',103);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ROCKS',104);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BOHEMIAN RHAPSODY',105);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('INNUENDO',105);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('THE SHOW MUST GO ON',105);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('I WANT IT ALL',105);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('FAT BOtOMED GIRLS',105);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SOMEBODY TO LOVE',105);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BREAKTHRU',105);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WE ARE THE CHAMPIONS',105);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('DON`T STOP ME NOW',105);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('TIE YOUR MOTHER DOWN',105);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('NO ONE KNOWS',106);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LOSING MY RELIGION',107);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CREEP',108);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('KILLING IN THE NAME',109);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('DIO',110);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ROCK AND ROLL RADIO',111);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SHEENA IS A PUNK ROCKER',111);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BLITZKRIEG BOP',111);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('UNDER THE BRIDGE',112);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CALIFORNICATION',112);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SCAR TISSUE',112);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('MAGGIE MAY',113);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SATISFACTION (I CAN`T GET NO)',114);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SYMPATHY FOR THE DEVIL',114);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('GIMME SHELTER',114);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('JUMPIN` JACK FLASH',114);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('START ME UP',114);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('PAINT IT BLACK',114);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('IT` S ONLY ROCK & ROLL (BUT I LIKE IT)',114);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BROWN SUGAR',114);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LOVE IS STRONG',114);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WHAT I LIKE ABOUT YOU',115);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LE�O',116);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LA DEL PIRATA COJO',117);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BLACK MAGIC WOMAN',118);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SANTANA',119);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('STILL LOVING YOU',120);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WIND OF CHANGE',120);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BIG CITY NIGHTS',120);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ROCK YOU LIKE A HURRICANE',120);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('YOUTH GONE WILD',121);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('1979',122);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('GIMME SOME LOVIN`',123);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BORN TO RUN',124);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BORN IN THE USA',124);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('THUNDER ROAD',124);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('THE RIVER',124);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HUNGRY HEART',124);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LUCKY TOWN',124);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BADLANDS',124);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WHATEVER YOU WANT',125);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('DOWN DOWN',125);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BORN TO BE WILD',126);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SERENADE FROM THE STARS',127);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SUPERSTITION',128);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('KINKS THE',129);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LAST NIGHT',130);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BURNING HEART',131);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CHOP SUEY',132);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BYOB',132);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('DIEZ A�OS',133);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('GET IT ON',134);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('20TH CENTURY BOY',134);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LAND OF A THOUSAND DANCES',135);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('THE WEIGHT',136);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('TWIST AND SHOUT',137);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HELP',137);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('THE LEtER',138);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('AMERICAN WOMAN',139);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CHERRY BOMB',140);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LAST NIGHT',141);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SURFIN�BIRD',142);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WILD THING',143);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SEVEN NATION ARMY',144);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('THE BOYS ARE BACK IN TOWN',145);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WHISKEY IN THE JAR',145);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('AMERICAN GIRL',146);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('AFRICA',147);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WE`RE NOT GONNA TAKE IT',148);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WITH OR WITHOUT YOU',149);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SUNDAY BLOODY SUNDAY',149);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('PRIDE (IN THE NAME OF LOVE)',149);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('ANGEL OF HARLEM',149);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HOLD ME,THRILL ME, KISS ME, KILL ME',149);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('VERTIGO',149);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BEAUTIFUL DAY',149);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('I STILL HAVEN`T FOUND WHAT I`M LOOKING FOR',149);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('JUMP',150);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('PANAMA',150);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('AIN`T TALKIN`ABOUT LOVE',150);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('BRIGHT SIDE OF THE ROAD',151);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('CARAVAN',151);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('GLORIA',152);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('SWEET JANE',153);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('HERE I GO AGAIN',154);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('FOOL FOR YOUR LOVIN`',154);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('STILL OF THE NIGHT',154);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('MY GENERATION',155);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('WON`T GET FOOLED AGAIN',155);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('PINBALL WIZARD',155);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('LA GRANGE',156);
GO
INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES('VIVA LAS VEGAS',156);
GO
