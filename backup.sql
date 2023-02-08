-- MariaDB dump 10.19  Distrib 10.6.11-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: qniverse
-- ------------------------------------------------------
-- Server version	10.6.11-MariaDB-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Game`
--

DROP TABLE IF EXISTS `Game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Game` (
  `id_user` int(11) NOT NULL,
  `id_lobby` int(11) NOT NULL,
  `id_question` int(11) NOT NULL,
  `time` varchar(100) DEFAULT NULL,
  `success` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_user`,`id_lobby`,`id_question`),
  KEY `id_lobby` (`id_lobby`),
  KEY `id_question` (`id_question`),
  CONSTRAINT `Game_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `User` (`id`),
  CONSTRAINT `Game_ibfk_2` FOREIGN KEY (`id_lobby`) REFERENCES `Lobby` (`id`),
  CONSTRAINT `Game_ibfk_3` FOREIGN KEY (`id_question`) REFERENCES `Question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Game`
--

LOCK TABLES `Game` WRITE;
/*!40000 ALTER TABLE `Game` DISABLE KEYS */;
/*!40000 ALTER TABLE `Game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `League`
--

DROP TABLE IF EXISTS `League`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `League` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  `minElo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `League`
--

LOCK TABLES `League` WRITE;
/*!40000 ALTER TABLE `League` DISABLE KEYS */;
INSERT INTO `League` VALUES (1,'Mercury',1000),(2,'Venus',2000),(3,'Earth',3000),(4,'Mars',4000),(5,'Jupiter',5000),(6,'Saturn',6000),(7,'Uranus',7000),(8,'Neptune',8000);
/*!40000 ALTER TABLE `League` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lobby`
--

DROP TABLE IF EXISTS `Lobby`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Lobby` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creationDate` varchar(100) DEFAULT NULL,
  `privateCode` text DEFAULT NULL,
  `visibility` int(11) DEFAULT NULL,
  `id_user` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `Lobby_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `User` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lobby`
--

LOCK TABLES `Lobby` WRITE;
/*!40000 ALTER TABLE `Lobby` DISABLE KEYS */;
INSERT INTO `Lobby` VALUES (124,'2023/02/07 - 19:21:13','235792',0,4),(125,'2023/02/07 - 19:21:56','897604',0,4),(126,'2023/02/07 - 19:30:12','646125',0,4),(127,'2023/02/07 - 19:30:32','921196',0,4),(128,'2023/02/07 - 19:30:40','748153',0,4),(129,'2023/02/07 - 19:31:20','177665',0,4),(130,'2023/02/07 - 19:35:47','951424',0,4),(131,'2023/02/07 - 19:36:18','699678',0,4),(132,'2023/02/07 - 19:37:26','225975',0,4),(133,'2023/02/07 - 19:38:00','884591',0,4),(134,'2023/02/07 - 19:38:11','904043',0,4),(135,'2023/02/08 - 07:48:12','244309',0,38),(136,'2023/02/08 - 07:48:27','283285',0,38),(137,'2023/02/08 - 07:49:18','877921',0,38),(138,'2023/02/08 - 07:49:53','857486',0,38),(139,'2023/02/08 - 07:50:33','255146',0,38),(140,'2023/02/08 - 07:51:37','688884',0,38),(141,'2023/02/08 - 07:51:39','718987',0,38),(142,'2023/02/08 - 07:52:21','604818',0,38),(143,'2023/02/08 - 07:53:02','947628',1,38);
/*!40000 ALTER TABLE `Lobby` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Question`
--

DROP TABLE IF EXISTS `Question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `answer1` varchar(50) DEFAULT NULL,
  `answer2` varchar(50) DEFAULT NULL,
  `answer3` varchar(50) DEFAULT NULL,
  `answer4` varchar(50) DEFAULT NULL,
  `correctAnswer` int(11) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `upVotes` int(11) DEFAULT NULL,
  `downVotes` int(11) DEFAULT NULL,
  `activatedInGame` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `Question_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `User` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Question`
--

LOCK TABLES `Question` WRITE;
/*!40000 ALTER TABLE `Question` DISABLE KEYS */;
INSERT INTO `Question` VALUES (1,1,'Cuánto es 5+5','10','5','15','20',1,NULL,0,3,0),(2,2,'Qué hecho histórico corresponde al día D?','Desembarco de Normandía','Liberarión de París','Rendición de los Nazis','Bombardeo sobre Londres',1,NULL,8,2,1),(3,3,'Qué líquido suele ser utilizado para purificar cañerías tapadas?','Alcohol etílico','Ácido Hialuronico','Manaos','Soda cáustica',3,NULL,0,2,0),(4,4,'Qué celebran los cristianos el 25 de diciembre?','La muerte de Jesús','El nacimiento de Jesús','La resurreción de Jesús','La crucifixión de Jesús',2,NULL,3,1,0),(5,4,'PRUEBA?','Opcion1','Opcion2','Opcion3','Opcion4',3,'',1,0,0),(6,4,'De que color es el cielo?','Azul','Rojo','Verde','Que es eso?, se come xd',1,NULL,1,0,0),(7,4,'De que color es el cielo?','Azul','Rojo','Verde','Que es eso? se come xd',1,NULL,0,1,0),(8,4,'De que color es el cielo?','Azul','Rojo','Verde','Que es eso? se come xd',1,NULL,2,0,0),(9,4,'De que color es el cielo?','Azul','Rojo','Verde','Que es eso? se come xd',1,NULL,1,1,0),(10,4,'De que color es el cielo?','Azul','Rojo','Verde','Que es eso? se come xd',1,'ruta_de_image.png',NULL,NULL,NULL),(11,4,'De que color es el cielo?','Azul','Rojo','Verde','Que es eso? se come xd',1,NULL,3,3,0),(12,31,'What\'s the capital of Norway?','Asgaard','Trondheim','Valhalla','Oslo',3,'',0,1,0),(15,31,'Who is this?','Al Pacino','Robert de Niro','Tom Hanks','Tom Cruise',2,'https://upload.wikimedia.org/wikipedia/commons/5/58/Robert_De_Niro_Cannes_2016.jpg',0,1,0),(17,31,'What is a lion?','a car','a flower','a house','A big cat',4,'',1,1,0),(18,29,'En qué isla vivía Otelo?','Chipre','Creta','Sicilia','Corfú',3,NULL,5,5,0),(19,29,'Cuál es el nombre del primer gran poema épico de la literatura inglesa?','The Battle of Maldon','Beowulf','Finnesburg Fragment','Judith',2,NULL,5,5,0),(20,29,'Quién pintó \'Mujer mirando por la ventana\'?','Pablo Picasso','Salvador Dalí','Joan Miró','René Magritte',2,NULL,0,1,0),(21,29,'En qué ciudad nació el pintor y escultor Joan Miro?','Barcelona','Madrid','Valencia','Sevilla',1,NULL,1,0,0),(22,29,'De qué género es la obra \'Luces de Bohemia\'?','Novela','Poema','Pintura','Teatro',4,NULL,5,5,0),(23,29,'Cuál de los siguientes personajes no aparece en la portada del álbum Sgt. Pepper\'s Lonely Hearts Club Band, de la banda británica The Beatles?','Bob Marley','Alfred Hitchcock','Mae West','Edgar Allan Poe',1,NULL,0,1,0),(24,29,'Cuál es el baile popular de Aragón?','Bulerías','Jota','Sardana','Rumba',2,NULL,0,1,0),(25,29,'En qué año se suicidó Van Gogh?','1900','1880','1895','1890',4,NULL,5,5,0),(26,29,'Cuál es el baile típico de Galicia?','Sardana','Muiñeira','Jota','Sevillanas',2,NULL,5,5,0),(27,29,'Quién escribió La Divina Comedia?','Dante Alighieri','Francesco Petrarca','Giovanni Boccaccio','Torquato Tasso',1,NULL,5,5,0),(28,29,'Cuántas cuerdas suele tener un bajo eléctrico?','Seis','Ocho','Cuatro','Diez',3,NULL,5,5,0),(29,29,'Quién escribió \'El Ejército Negro\'?','Santiago García-Clairac','Manuel Aznar Soler','José María Pemán','Federico García Lorca',1,NULL,0,1,0),(30,29,'Cuál de las siguientes obras fue escrita por Wolfgang Amadeus Mozart?','El Noveno Sinfonía','Réquiem','La Sinfonía 40','La Sinfonía 41',2,NULL,5,5,0),(31,29,'Para qué sirve la paleta?','Para mezclar pinturas','Para medir la técnica de un pintor','Para sujetar las pinturas','Para limpiar pinceles',1,NULL,5,5,0),(32,29,'Quién escribió \'Azazel\'?','Isaac Asimov','Isaac Bashevis Singer','Isaac Newton','Frank Herbert',1,NULL,0,1,0),(33,29,'Cuál es esta bandera?','Corea del Sur','Taiwán','Libia','Japón',4,'https://img.asmedia.epimg.net/resizer/ECKwX3vbXra-iCyYPDamcEE_UrQ=/1952x1098/cloudfront-eu-central-1.images.arcpublishing.com/diarioas/T3W5EEBTBBDWXMFBH7XV7JYPDM.jpg',5,5,0),(34,29,'De qué marca de coche es este logo?','Mercedes','Audi','BMW','Porsche',3,'https://m.media-amazon.com/images/I/41-4E5M6wSL._AC_SX355_.jpg',5,5,0),(35,29,'Quién es esta persona?','Will Smith','Eto\'o','Ronaldinho','Donato',2,'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Samuel_2011.jpg/640px-Samuel_2011.jpg',1,0,0),(36,29,'Quién es este actor?','Tom Cruise','James McAvoy','Zac Efron','Brad Pitt',1,'https://images.mubicdn.net/images/cast_member/2184/cache-2992-1547409411/image-w856.jpg',5,5,0),(37,29,'Quién dirigió esta pelicula?','Kate Capshaw','Steven Spielberg','George Lucas','Martin Scorsese',2,'https://i.blogs.es/b7822d/jurassic-park-poster/1366_2000.jpg',0,1,0),(38,29,'Quién dirigió esta pelicula?','Kate Capshaw','Steven Spielberg','George Lucas','Martin Scorsese',4,'https://m.media-amazon.com/images/I/71GrEFp3ywL._SL1102_.jpg',5,5,0),(39,29,'Dónde está tomada esta fotografía?','Tokyo','París','Las Vegas','Madrid',3,'https://imgcap.capturetheatlas.com/wp-content/uploads/2021/08/paris-eiffel-tower-las-vegas-eiffel-tower-restaurant.jpg',5,5,0),(40,30,'Dónde está tomada esta fotografía?','Tokyo','París','Las Vegas','Bucarest',4,'https://www.larumania.es/wp-content/uploads/2016/10/arco_triunfo_bucarest.jpg',5,5,0),(41,30,'Dónde está tomada esta fotografía?','Tokyo','París','Las Vegas','Bucarest',2,'https://farm7.staticflickr.com/6096/6261727676_277bd5bc9d_o.jpg',5,5,0),(42,30,'¿A qué edad alcanzan la madurez las crías de elefante?','8-10 años','16-18 años','10-12 años','12-15 años',4,NULL,6,5,1),(43,30,'¿Cuál es el nombre de la montaña más alta de la Tierra?','Monte Everest','Monte Fuji','Monte Kilimanjaro','Monte Blanc',1,NULL,6,5,1);
/*!40000 ALTER TABLE `Question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_league` int(11) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `pass` varchar(100) DEFAULT NULL,
  `tokenPass` varchar(100) DEFAULT NULL,
  `tokenSession` varchar(100) DEFAULT NULL,
  `elo` int(11) DEFAULT NULL,
  `creationDate` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_league` (`id_league`),
  CONSTRAINT `User_ibfk_1` FOREIGN KEY (`id_league`) REFERENCES `League` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,3,'q-angel','aandrade@email.com','qniverse','1234','1234',3000,'17/01/2023'),(2,3,'q-cesar','cesar@cesar.com','qniverse','1234','test',3000,'17/01/2023'),(3,3,'q-pablo','pablo@pablo.pablo','qniverse','1234','1234',3000,'17/01/2023'),(4,3,'q-adrian','','qniverse','1234','prueba',3000,'17/01/2023'),(12,1,'testAngel100','','1234','147074','tokenPrueba7',0,'2023/01/23 - 08:51:52'),(13,1,'SuperAngel99','aandradeb@fpcoruna.afundacion.org','$2b$12$SOG19YGSbAJSLzH412TpOu.9zXapXj6eudrm2.7VMjljLD3rXrYym','653682','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxM30.ZDVJavzm1H1CQDKGt2k0VN0u5_ACXbydaWW_VkRqsEw',0,'2023/01/23 - 08:53:21'),(15,6,'tilas','erivasf@fpcoruna.afundacion.org','$2b$12$IzWdJIhnWxM8AYR6k7hlWumefqmHVqxaES4o9rhU3NGAxx.s2STxS','0','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNX0.9pgnPgfLK7DVBPQefXc3Wf9U0ZOEzfbx1H0dQF3i4eY',0,'17/01/2023'),(16,1,'adrianBack','tilas@adriannn.com','$2b$12$xtBNQAZIKDNHuZFnFlP8WO9oO6KHILQDFX4/Jc5r5IkdUsO/m0r2K',NULL,'tokenPrueba3',0,'2023/01/23 - 12:03:48'),(18,1,'pepe1','mdiazh@fpcoruna.afundacion.org','$2b$12$/6.5gQAi9bRVF7eQAC9dC.g38RXG/.V/CCpERuGtSJzlJ1LFYEYs6','0','tokenPrueba4',0,'2023/01/24 - 07:31:40'),(27,3,'testlogin2','test','$2b$12$ZqXgsKajDQOHgG./hUslJeKT.mwpPD.Cx3NZqrAco90QcQDW.9e3.',NULL,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyN30.44p7dv1TRGdwWcLXr_o5hdoTCxS4Q8LBkSAeN0IjntI',3000,'2023/01/26 - 11:14:35'),(29,1,'testCesar','ccarvalhalt22@fpcoruna.afundacion.org','$2b$12$IBO0W3Gw3r.vv6ykiAqiDeNrBx89oeb3hKyK70DFJRsAh65/qW3Ju','424323','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyOX0.O3zwbo0N0F4ctHqMEYcSGjuwjC0wvEq04uv1ko79WZs',0,'2023/01/27 - 12:23:08'),(30,1,'testAngel20','pruebaX2@pruebaX2.com','$2b$12$IqqLi0XMlvOoyTvcl8K3qu8NRqcTcOnRYTWAJm0DeyyoAJoNpdpIG',NULL,NULL,0,'2023/01/27 - 12:32:12'),(31,1,'testpablo','testpablo@test.com','$2b$12$sVNjHTmpgdpLxdc8LAeMUOeCRZUfEKEG89wB.xM4FyUXnElHp7tCi',NULL,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozMX0.O3x8eSYcz-plA9vO6El2BL-AhVBaYlmMuEPpGC0B7Wo',0,'2023/02/01 - 10:12:34'),(32,1,'SuperPablo','superpablo@email.com','$2b$12$hVA/xAIXKoVfoLPjD3llWOqjKIh56GQyJE445jDTa1wS96xNqK9rG',NULL,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozMn0.tdfczUUveuBuT9HkVgUhfie8W49Ks-F6CJpEVRjFXEo',0,'2023/02/02 - 09:52:45'),(33,1,'testCesar1','testCesar123@testCesar123.com','$2b$12$/U.o3NWIIkCA13Ig61qju.y0f276KBYSWuxkcABnpt1uWE3WUiqOG',NULL,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozM30.Z9EI4WevtZcufy4HwLQjjIG8Av8uV_S005TRSdq8NEU',0,'2023/02/02 - 09:54:13'),(34,1,'superPepe','superPepe@email.com','$2b$12$kf3aMCLCmcEOr.47814Mye9hFDOhqmM2at7xFrmxgS5xQ/El00ap.',NULL,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozNH0.TMFF2se9fJIyHNlswZcAGqgkpXGs8bdI0oD0HrHNezU',0,'2023/02/02 - 09:55:38'),(35,1,'test1','test1@test1.com','$2b$12$gP9i4DD5HyL2fmKTZIKMSOBqTA82K4BpTd/XnLgNcAKKJbc9hMg9G',NULL,NULL,0,'2023/02/02 - 10:42:43'),(36,1,'test2','test2@test2.com','$2b$12$e1.xZO42C2otQbfiTY6YAOCo1x3DBYRwkSyR28OsOHEtSagey5plG',NULL,NULL,0,'2023/02/02 - 10:43:01'),(37,1,'test3','test3@test3.com','$2b$12$brirO9IiLC1cqEWrR5QDk.aPNrhK0J.xp5kCZxO5n9YipxB7JWVhq',NULL,NULL,0,'2023/02/02 - 10:43:14'),(38,1,'borrageiros','adrianborrageirosmourelos@gmail.com','$2b$12$j/sBfUGGrVh76VIogsckMueczRkGCtLy7rJQ9dIpqH5Lh/JT3Kg8W',NULL,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOH0.iSaT3_T2rLWh4Y7QbRHWBDeUNOA_EfWFz9eTe7eD-kM',0,'2023/02/03 - 15:48:21'),(39,1,'test04','test04@email.com','$2b$12$QG9LmXU1lgcvBPT35IbsX.v7UaDgdzdIwwGlqWIs5n1RUgEZf8mxy',NULL,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOX0.NdlcTsyd5ElJcof2L16TS7tsrF9M0PKUwZ6sjCHkkZk',0,'2023/02/04 - 17:28:49'),(40,1,'pepito99','pepito@email.com','$2b$12$xF8GVNQII0JFXlbRDbstJuV6gzfpXvXLDzwHwKwrue/P2TO5ICzk2',NULL,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0MH0.b26ylj2nGomsLqyqwZyM_24h2X92XEEy8ETsycfYUNk',0,'2023/02/04 - 19:11:38');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add usuario',7,'add_usuario'),(26,'Can change usuario',7,'change_usuario'),(27,'Can delete usuario',7,'delete_usuario'),(28,'Can view usuario',7,'view_usuario'),(29,'Can add lobby',8,'add_lobby'),(30,'Can change lobby',8,'change_lobby'),(31,'Can delete lobby',8,'delete_lobby'),(32,'Can view lobby',8,'view_lobby'),(33,'Can add game answer',9,'add_gameanswer'),(34,'Can change game answer',9,'change_gameanswer'),(35,'Can delete game answer',9,'delete_gameanswer'),(36,'Can view game answer',9,'view_gameanswer'),(37,'Can add question',10,'add_question'),(38,'Can change question',10,'change_question'),(39,'Can delete question',10,'delete_question'),(40,'Can view question',10,'view_question');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(9,'rest_api','gameanswer'),(8,'rest_api','lobby'),(10,'rest_api','question'),(7,'rest_api','usuario'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-01-19 12:58:49.529241'),(2,'auth','0001_initial','2023-01-19 12:58:49.686908'),(3,'admin','0001_initial','2023-01-19 12:58:49.729623'),(4,'admin','0002_logentry_remove_auto_add','2023-01-19 12:58:49.741128'),(5,'admin','0003_logentry_add_action_flag_choices','2023-01-19 12:58:49.752051'),(6,'contenttypes','0002_remove_content_type_name','2023-01-19 12:58:49.797646'),(7,'auth','0002_alter_permission_name_max_length','2023-01-19 12:58:49.823531'),(8,'auth','0003_alter_user_email_max_length','2023-01-19 12:58:49.850455'),(9,'auth','0004_alter_user_username_opts','2023-01-19 12:58:49.863212'),(10,'auth','0005_alter_user_last_login_null','2023-01-19 12:58:49.886327'),(11,'auth','0006_require_contenttypes_0002','2023-01-19 12:58:49.889640'),(12,'auth','0007_alter_validators_add_error_messages','2023-01-19 12:58:49.901639'),(13,'auth','0008_alter_user_username_max_length','2023-01-19 12:58:49.919370'),(14,'auth','0009_alter_user_last_name_max_length','2023-01-19 12:58:49.939424'),(15,'auth','0010_alter_group_name_max_length','2023-01-19 12:58:49.957411'),(16,'auth','0011_update_proxy_permissions','2023-01-19 12:58:49.970791'),(17,'auth','0012_alter_user_first_name_max_length','2023-01-19 12:58:49.992809'),(18,'sessions','0001_initial','2023-01-19 12:58:50.011234'),(19,'rest_api','0001_initial','2023-02-03 08:40:51.146993');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rateQuestion`
--

DROP TABLE IF EXISTS `rateQuestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rateQuestion` (
  `id_user` int(11) NOT NULL,
  `id_question` int(11) NOT NULL,
  `rating` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_user`,`id_question`),
  KEY `id_question` (`id_question`),
  CONSTRAINT `rateQuestion_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `User` (`id`),
  CONSTRAINT `rateQuestion_ibfk_2` FOREIGN KEY (`id_question`) REFERENCES `Question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rateQuestion`
--

LOCK TABLES `rateQuestion` WRITE;
/*!40000 ALTER TABLE `rateQuestion` DISABLE KEYS */;
INSERT INTO `rateQuestion` VALUES (2,1,0),(2,2,1),(2,3,0),(2,4,1),(2,8,1),(2,11,1),(4,1,0),(4,2,1),(4,3,0),(4,4,1),(4,6,1),(4,7,0),(4,8,1),(4,11,0),(4,17,1),(12,2,0),(12,11,0),(13,1,0),(13,4,1),(13,5,1),(13,9,0),(13,12,0),(13,15,0),(13,17,0),(13,20,0),(13,21,1),(13,23,0),(13,24,0),(13,29,0),(13,32,0),(13,35,1),(13,37,0),(15,2,1),(16,2,1),(16,4,0),(16,9,1),(16,11,1),(18,2,1),(18,11,0);
/*!40000 ALTER TABLE `rateQuestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rest_api_gameanswer`
--

DROP TABLE IF EXISTS `rest_api_gameanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rest_api_gameanswer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_correct` tinyint(1) NOT NULL,
  `lobby_id` bigint(20) NOT NULL,
  `question_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rest_api_gameanswer_lobby_id_475af98c_fk_rest_api_lobby_id` (`lobby_id`),
  KEY `rest_api_gameanswer_question_id_48601030_fk_rest_api_question_id` (`question_id`),
  KEY `rest_api_gameanswer_user_id_d00011ad_fk_rest_api_usuario_id` (`user_id`),
  CONSTRAINT `rest_api_gameanswer_lobby_id_475af98c_fk_rest_api_lobby_id` FOREIGN KEY (`lobby_id`) REFERENCES `rest_api_lobby` (`id`),
  CONSTRAINT `rest_api_gameanswer_question_id_48601030_fk_rest_api_question_id` FOREIGN KEY (`question_id`) REFERENCES `rest_api_question` (`id`),
  CONSTRAINT `rest_api_gameanswer_user_id_d00011ad_fk_rest_api_usuario_id` FOREIGN KEY (`user_id`) REFERENCES `rest_api_usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rest_api_gameanswer`
--

LOCK TABLES `rest_api_gameanswer` WRITE;
/*!40000 ALTER TABLE `rest_api_gameanswer` DISABLE KEYS */;
/*!40000 ALTER TABLE `rest_api_gameanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rest_api_lobby`
--

DROP TABLE IF EXISTS `rest_api_lobby`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rest_api_lobby` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `creator_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `rest_api_lobby_creator_id_e278ca0d_fk_rest_api_usuario_id` (`creator_id`),
  CONSTRAINT `rest_api_lobby_creator_id_e278ca0d_fk_rest_api_usuario_id` FOREIGN KEY (`creator_id`) REFERENCES `rest_api_usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rest_api_lobby`
--

LOCK TABLES `rest_api_lobby` WRITE;
/*!40000 ALTER TABLE `rest_api_lobby` DISABLE KEYS */;
/*!40000 ALTER TABLE `rest_api_lobby` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rest_api_question`
--

DROP TABLE IF EXISTS `rest_api_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rest_api_question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rest_api_question`
--

LOCK TABLES `rest_api_question` WRITE;
/*!40000 ALTER TABLE `rest_api_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `rest_api_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rest_api_usuario`
--

DROP TABLE IF EXISTS `rest_api_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rest_api_usuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rest_api_usuario`
--

LOCK TABLES `rest_api_usuario` WRITE;
/*!40000 ALTER TABLE `rest_api_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `rest_api_usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-08  8:58:47
