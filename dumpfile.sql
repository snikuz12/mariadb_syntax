-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

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
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'admin',
  `birth_day` date DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `post_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(1,'abc','abc@ttest.com',NULL,NULL,25,'user',NULL,'2024-05-20 00:00:00',2),
(2,'update','water@test.com',NULL,NULL,27,'user',NULL,'2024-04-11 00:00:00',0),
(3,'qwe','hello@test.com',NULL,NULL,27,'user',NULL,NULL,0),
(4,'test33','test@tttt.com',NULL,NULL,28,'user',NULL,NULL,0),
(5,'asds','hello@world.com',NULL,NULL,26,'admin','1998-04-11',NULL,0),
(6,'wqesd','test@test.com',NULL,NULL,28,'admin',NULL,'2024-03-21 00:00:00',0),
(7,'snickers','snickers@test.com',NULL,NULL,24,'user',NULL,NULL,0),
(8,'wdsfd',NULL,NULL,NULL,23,'admin',NULL,'2024-05-20 14:36:49',0),
(9,'rdfvfb',NULL,NULL,NULL,24,'admin',NULL,'2024-05-21 00:00:00',0),
(10,'ascx',NULL,NULL,NULL,23,'admin',NULL,'2024-05-21 00:00:00',0);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `user_id` char(36) NOT NULL DEFAULT uuid(),
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(10,'hello',NULL,1,3000.000,'2024-05-17 12:33:13','03710eb2-141f-11ef-a067-f4b301d51767'),
(11,'yohan','yohan@test.com',2,4000.000,'2024-05-17 12:33:13','03710f67-141f-11ef-a067-f4b301d51767'),
(12,'hello',NULL,5,2000.000,'2024-05-17 12:33:13','03710f9a-141f-11ef-a067-f4b301d51767'),
(22,'study','study@test.com',5,5000.000,'2024-05-17 12:33:13','03710fbf-141f-11ef-a067-f4b301d51767'),
(33,'kancho','kancho@test.com',5,8000.000,'2024-05-17 12:33:13','03711009-141f-11ef-a067-f4b301d51767'),
(44,'labtop','labtop@test.com',5,1000.000,'2024-05-17 12:33:13','0371102b-141f-11ef-a067-f4b301d51767'),
(55,'bottle','bottle@test.com',7,2000.000,'2000-01-01 00:00:00','03711140-141f-11ef-a067-f4b301d51767'),
(66,'bottle','bottle@test.com',8,1000.000,'2024-05-17 12:33:13','03711164-141f-11ef-a067-f4b301d51767'),
(77,'asd','contents',9,4000.000,'2024-05-17 00:00:00','03711187-141f-11ef-a067-f4b301d51767'),
(78,'hello world java',NULL,10,2000.000,'2024-05-20 14:34:28','a0b2d0f8-166a-11ef-a067-f4b301d51767'),
(79,'hello world java',NULL,7,1000.000,'2024-05-20 14:37:16','04b6d25c-166b-11ef-a067-f4b301d51767'),
(80,'hello world java',NULL,6,7000.000,'2024-05-20 14:38:24','2d7210b9-166b-11ef-a067-f4b301d51767'),
(81,'hello world java',NULL,1,3000.000,'2024-05-20 15:01:30','672edd16-166e-11ef-a067-f4b301d51767');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22 16:27:46
