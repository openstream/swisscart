-- MySQL dump 10.13  Distrib 5.1.51, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: swisscart_demo2008
-- ------------------------------------------------------
-- Server version	5.1.51-0.dotdeb.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address_book`
--

DROP TABLE IF EXISTS `address_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_book` (
  `address_book_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT '0',
  `entry_gender` char(1) NOT NULL,
  `entry_company` varchar(64) DEFAULT NULL,
  `entry_firstname` varchar(32) NOT NULL,
  `entry_lastname` varchar(32) NOT NULL,
  `entry_street_address` varchar(64) NOT NULL,
  `entry_suburb` varchar(32) DEFAULT NULL,
  `entry_postcode` varchar(10) NOT NULL,
  `entry_city` varchar(32) NOT NULL,
  `entry_state` varchar(32) DEFAULT NULL,
  `entry_country_id` int(11) NOT NULL DEFAULT '0',
  `entry_zone_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`address_book_id`),
  KEY `idx_address_book_customers_id` (`customers_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_book`
--

LOCK TABLES `address_book` WRITE;
/*!40000 ALTER TABLE `address_book` DISABLE KEYS */;
INSERT INTO `address_book` VALUES (2,2,'m','Openstream Internet Solutions','Nick','Weisser','Wieslergasse 6','','8049','Z?rch','',204,129),(3,2,'m','Openstream Internet Solutions','Nick','Weisser','Waldkircher Str. 14','','78054','Villingen-Schwenningen','',81,80),(5,4,'m','','Peter','Keller','Teststrasse 5',NULL,'1234','Zug',NULL,204,0),(7,6,'f','','Olivia','Pfister','Dulezi 14M',NULL,'7166','Trun',NULL,204,0),(22,21,'m','','Test','Test','Teststrasse',NULL,'12345','Test',NULL,204,0),(11,10,'m','stooni.ch','Martin','Steiner','Hätzerlgasse 26',NULL,'8048','Zürich',NULL,204,0),(23,22,'m','test','Test','test','testtestest',NULL,'test','test',NULL,204,0),(13,12,'m','','Amar','Dravid','In den Ziegelhöfen 149',NULL,'4054','Basel',NULL,204,0),(21,20,'m','','Adriaan','Spierings','Fichtenstrasse 11',NULL,'9230','Flawil',NULL,204,0),(24,23,'m','','safsadf','gdfghfgh','sadflkj',NULL,'8000','zurigo',NULL,204,0),(25,24,'m','','dadaddsa','dsasdad','fsdaads',NULL,'dsdsadsa','2312',NULL,204,0),(26,25,'m','','Fritz','Müller','Osterweg 5',NULL,'4000','Bern',NULL,204,0),(27,26,'m','','Tom','Burri','Seestrasse',NULL,'8080','Zürich',NULL,204,0),(28,27,'m','gh','wertz','asdf','kjhgzuiopü',NULL,'9444','¨üpoiuztr',NULL,204,0),(29,28,'m','Openstream Internet Solutions','Claudio Hideki','Imai','Wieslergasse 6',NULL,'8049','Zürich',NULL,204,0),(30,29,'f','','Barbara','Berger','Musterstrasse',NULL,'3000','Bern',NULL,204,0),(31,30,'m','','Reto','Marti','Schwerzistr. 40',NULL,'8606','Nänikon',NULL,204,0),(32,31,'m','','aw','sw','dwhhf',NULL,'fw67','gwtz',NULL,204,0);
/*!40000 ALTER TABLE `address_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address_format`
--

DROP TABLE IF EXISTS `address_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_format` (
  `address_format_id` int(11) NOT NULL AUTO_INCREMENT,
  `address_format` varchar(128) NOT NULL,
  `address_summary` varchar(48) NOT NULL,
  PRIMARY KEY (`address_format_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_format`
--

LOCK TABLES `address_format` WRITE;
/*!40000 ALTER TABLE `address_format` DISABLE KEYS */;
INSERT INTO `address_format` VALUES (1,'$firstname $lastname$cr$streets$cr$city, $postcode$cr$statecomma$country','$city / $country'),(2,'$firstname $lastname$cr$streets$cr$city, $state    $postcode$cr$country','$city, $state / $country'),(3,'$firstname $lastname$cr$streets$cr$city$cr$postcode - $statecomma$country','$state / $country'),(4,'$firstname $lastname$cr$streets$cr$city ($postcode)$cr$country','$postcode / $country'),(5,'$firstname $lastname$cr$streets$cr$postcode $city$cr$country','$city / $country');
/*!40000 ALTER TABLE `address_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banners`
--

DROP TABLE IF EXISTS `banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banners` (
  `banners_id` int(11) NOT NULL AUTO_INCREMENT,
  `banners_title` varchar(64) NOT NULL,
  `banners_url` varchar(255) NOT NULL,
  `banners_image` varchar(64) NOT NULL,
  `banners_group` varchar(10) NOT NULL,
  `banners_html_text` text,
  `expires_impressions` int(7) DEFAULT '0',
  `expires_date` datetime DEFAULT NULL,
  `date_scheduled` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_status_change` datetime DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`banners_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banners`
--

LOCK TABLES `banners` WRITE;
/*!40000 ALTER TABLE `banners` DISABLE KEYS */;
INSERT INTO `banners` VALUES (1,'osCommerce','http://www.oscommerce.com','banners/oscommerce.gif','468x50','',0,NULL,NULL,'2007-06-12 22:50:01','2007-07-05 15:50:01',0),(2,'Zahlungsmöglichkeiten','','','468x50','<h2>Zahlungsmöglichkeiten</h2>\r\n<p style=\"text-align: left; padding-left: 5px; \">swisscart&reg; bitete Ihnen eine grosse Anzahl von Zahlungsmodulen, speziell für Schweizer Online-Shops!</p><img src=\"images/credit-card-logos.gif\" border=\"0\" alt=\"Zahlungsmöglichkeiten\" title=\"Zahlungsmöglichkeiten\">',0,NULL,NULL,'2008-04-06 15:13:28',NULL,1);
/*!40000 ALTER TABLE `banners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banners_history`
--

DROP TABLE IF EXISTS `banners_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banners_history` (
  `banners_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `banners_id` int(11) NOT NULL DEFAULT '0',
  `banners_shown` int(5) NOT NULL DEFAULT '0',
  `banners_clicked` int(5) NOT NULL DEFAULT '0',
  `banners_history_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`banners_history_id`)
) ENGINE=MyISAM AUTO_INCREMENT=443 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banners_history`
--

LOCK TABLES `banners_history` WRITE;
/*!40000 ALTER TABLE `banners_history` DISABLE KEYS */;
INSERT INTO `banners_history` VALUES (1,1,21,0,'2007-06-12 22:50:09'),(2,1,176,0,'2007-06-13 02:03:37'),(3,1,196,0,'2007-07-05 00:43:57'),(4,2,47,0,'2008-04-06 15:13:31'),(5,2,51,0,'2008-04-07 00:26:23'),(6,2,37,0,'2008-04-08 00:43:39'),(7,2,98,0,'2008-04-09 06:52:10'),(8,2,154,0,'2008-04-10 00:11:45'),(9,2,92,0,'2008-04-11 00:46:07'),(10,2,191,0,'2008-04-12 00:46:32'),(11,2,108,0,'2008-04-13 00:00:59'),(12,2,149,0,'2008-04-14 00:18:11'),(13,2,163,0,'2008-04-15 00:08:15'),(14,2,316,0,'2008-04-16 00:19:10'),(15,2,109,0,'2008-04-17 00:02:47'),(16,2,188,0,'2008-04-18 00:24:47'),(17,2,206,0,'2008-04-19 00:50:39'),(18,2,222,0,'2008-04-20 00:00:54'),(19,2,186,0,'2008-04-21 00:14:38'),(20,2,49,0,'2008-04-22 00:03:25'),(21,2,107,0,'2008-04-23 00:00:07'),(22,2,208,0,'2008-04-24 00:21:53'),(23,2,142,0,'2008-04-25 00:11:01'),(24,2,167,0,'2008-04-26 00:46:36'),(25,2,122,0,'2008-04-27 00:45:24'),(26,2,148,0,'2008-04-28 00:12:09'),(27,2,180,0,'2008-04-29 00:09:35'),(28,2,217,0,'2008-04-30 00:00:24'),(29,2,208,0,'2008-05-01 00:01:30'),(30,2,210,0,'2008-05-02 00:05:40'),(31,2,297,0,'2008-05-03 00:10:05'),(32,2,164,0,'2008-05-04 00:05:19'),(33,2,281,0,'2008-05-05 00:12:53'),(34,2,166,0,'2008-05-06 00:00:50'),(35,2,278,0,'2008-05-07 00:08:45'),(36,2,220,0,'2008-05-08 00:02:03'),(37,2,87,0,'2008-05-09 01:06:44'),(38,2,193,0,'2008-05-10 00:02:31'),(39,2,230,0,'2008-05-11 00:00:27'),(40,2,160,0,'2008-05-12 00:00:24'),(41,2,184,0,'2008-05-13 00:04:22'),(42,2,219,0,'2008-05-14 00:14:02'),(43,2,231,0,'2008-05-15 00:08:27'),(44,2,137,0,'2008-05-16 00:00:39'),(45,2,247,0,'2008-05-17 00:02:36'),(46,2,294,0,'2008-05-18 00:03:42'),(47,2,166,0,'2008-05-19 00:01:14'),(48,2,261,0,'2008-05-20 00:08:41'),(49,2,307,0,'2008-05-21 00:08:16'),(50,2,203,0,'2008-05-22 00:08:06'),(51,2,322,0,'2008-05-23 00:09:50'),(52,2,305,0,'2008-05-24 00:06:02'),(53,2,695,0,'2008-05-25 00:02:04'),(54,2,105,0,'2008-05-26 00:10:06'),(55,2,129,0,'2008-05-27 00:13:33'),(56,2,138,0,'2008-05-28 00:02:00'),(57,2,141,0,'2008-05-29 01:07:09'),(58,2,258,0,'2008-05-30 00:07:59'),(59,2,176,0,'2008-05-31 00:02:27'),(60,2,263,0,'2008-06-01 01:02:20'),(61,2,258,0,'2008-06-02 00:11:33'),(62,2,66,0,'2008-06-03 00:43:13'),(63,2,88,0,'2008-06-04 02:51:37'),(64,2,92,0,'2008-06-05 00:09:30'),(65,2,441,0,'2008-06-06 02:11:09'),(66,2,110,0,'2008-06-07 01:28:41'),(67,2,168,0,'2008-06-08 01:02:55'),(68,2,781,0,'2008-06-09 01:15:01'),(69,2,95,0,'2008-06-10 00:54:10'),(70,2,171,0,'2008-06-11 00:03:41'),(71,2,133,0,'2008-06-12 00:00:41'),(72,2,113,0,'2008-06-13 01:15:10'),(73,2,486,0,'2008-06-14 00:25:29'),(74,2,184,0,'2008-06-15 00:19:29'),(75,2,284,0,'2008-06-16 00:04:59'),(76,2,139,0,'2008-06-17 00:19:41'),(77,2,153,0,'2008-06-18 00:03:46'),(78,2,105,0,'2008-06-19 00:03:49'),(79,2,58,0,'2008-06-20 00:03:56'),(80,2,387,0,'2008-06-21 00:07:00'),(81,2,114,0,'2008-06-22 00:07:34'),(82,2,164,0,'2008-06-23 02:15:39'),(83,2,175,0,'2008-06-24 00:32:08'),(84,2,84,0,'2008-06-25 00:21:50'),(85,2,123,0,'2008-06-26 00:09:19'),(86,2,110,0,'2008-06-27 01:15:22'),(87,2,370,0,'2008-06-28 00:12:48'),(88,2,164,0,'2008-06-29 00:09:45'),(89,2,43,0,'2008-06-30 00:00:22'),(90,2,24,0,'2008-07-03 17:24:27'),(91,2,124,0,'2008-11-06 10:34:53'),(92,2,214,0,'2008-11-07 00:01:09'),(93,2,258,0,'2008-11-08 00:06:10'),(94,2,626,0,'2008-11-09 00:08:57'),(95,2,155,0,'2008-11-10 00:01:09'),(96,2,441,0,'2008-11-11 00:00:51'),(97,2,170,0,'2008-11-12 00:19:19'),(98,2,551,0,'2008-11-13 00:19:09'),(99,2,217,0,'2008-11-14 00:03:57'),(100,2,278,0,'2008-11-15 00:00:00'),(101,2,110,0,'2008-11-16 00:23:39'),(102,2,128,0,'2008-11-17 00:05:19'),(103,2,198,0,'2008-11-18 00:18:31'),(104,2,96,0,'2008-11-19 00:06:59'),(105,2,149,0,'2008-11-20 00:12:33'),(106,2,152,0,'2008-11-21 00:06:10'),(107,2,219,0,'2008-11-22 00:08:29'),(108,2,254,0,'2008-11-23 00:09:49'),(109,2,108,0,'2008-11-24 00:24:05'),(110,2,110,0,'2008-11-25 00:15:08'),(111,2,802,0,'2008-11-26 00:04:26'),(112,2,151,0,'2008-11-27 00:06:45'),(113,2,213,0,'2008-11-28 00:01:33'),(114,2,124,0,'2008-11-29 01:30:57'),(115,2,114,0,'2008-11-30 00:00:53'),(116,2,399,0,'2008-12-01 00:02:05'),(117,2,93,0,'2008-12-02 00:23:26'),(118,2,114,0,'2008-12-03 00:08:38'),(119,2,543,0,'2008-12-04 00:32:24'),(120,2,91,0,'2008-12-05 00:20:13'),(121,2,125,0,'2008-12-06 00:04:51'),(122,2,179,0,'2008-12-07 00:05:14'),(123,2,255,0,'2008-12-08 00:02:11'),(124,2,167,0,'2008-12-09 00:04:43'),(125,2,90,0,'2008-12-10 00:04:30'),(126,2,108,0,'2008-12-11 00:01:27'),(127,2,129,0,'2008-12-12 00:17:49'),(128,2,108,0,'2008-12-13 00:03:17'),(129,2,437,0,'2008-12-14 00:09:39'),(130,2,94,0,'2008-12-15 00:51:01'),(131,2,118,0,'2008-12-16 00:01:11'),(132,2,61,0,'2008-12-17 00:22:42'),(133,2,79,0,'2008-12-18 02:00:06'),(134,2,140,0,'2008-12-19 00:09:53'),(135,2,179,0,'2008-12-20 00:06:28'),(136,2,128,0,'2008-12-21 00:03:02'),(137,2,66,0,'2008-12-22 00:27:42'),(138,2,104,0,'2008-12-23 00:07:04'),(139,2,80,0,'2008-12-24 00:01:54'),(140,2,110,0,'2008-12-25 00:31:43'),(141,2,65,0,'2008-12-26 00:18:48'),(142,2,192,0,'2008-12-27 00:05:29'),(143,2,141,0,'2008-12-28 00:00:53'),(144,2,184,0,'2008-12-29 00:00:21'),(145,2,188,0,'2008-12-30 00:10:54'),(146,2,469,0,'2008-12-31 00:02:55'),(147,2,182,0,'2009-01-01 00:07:21'),(148,2,139,0,'2009-01-02 00:00:46'),(149,2,414,0,'2009-01-03 00:03:07'),(150,2,186,0,'2009-01-04 00:05:16'),(151,2,90,0,'2009-01-05 00:06:00'),(152,2,129,0,'2009-01-06 00:29:45'),(153,2,88,0,'2009-01-07 01:20:22'),(154,2,170,0,'2009-01-08 00:33:43'),(155,2,157,0,'2009-01-09 00:01:49'),(156,2,157,0,'2009-01-10 00:02:13'),(157,2,156,0,'2009-01-11 00:07:48'),(158,2,392,0,'2009-01-12 00:10:20'),(159,2,245,0,'2009-01-13 00:03:01'),(160,2,86,0,'2009-01-14 00:16:26'),(161,2,160,0,'2009-01-15 00:11:31'),(162,2,68,0,'2009-01-16 00:17:14'),(163,2,179,0,'2009-01-17 00:03:29'),(164,2,148,0,'2009-01-18 00:01:20'),(165,2,124,0,'2009-01-19 00:09:58'),(166,2,492,0,'2009-01-20 00:02:01'),(167,2,167,0,'2009-01-21 00:03:52'),(168,2,111,0,'2009-01-22 00:02:29'),(169,2,91,0,'2009-01-23 00:00:51'),(170,2,146,0,'2009-01-24 00:28:26'),(171,2,162,0,'2009-01-25 00:14:16'),(172,2,283,0,'2009-01-26 00:13:11'),(173,2,76,0,'2009-01-27 00:00:13'),(174,2,49,0,'2009-05-06 18:39:39'),(175,2,149,0,'2009-05-07 00:06:53'),(176,2,119,0,'2009-05-08 00:17:52'),(177,2,117,0,'2009-05-09 00:01:49'),(178,2,171,0,'2009-05-10 00:09:22'),(179,2,120,0,'2009-05-11 00:08:09'),(180,2,170,0,'2009-05-12 00:07:35'),(181,2,193,0,'2009-05-13 00:07:53'),(182,2,156,0,'2009-05-14 00:01:29'),(183,2,249,0,'2009-05-15 00:02:48'),(184,2,233,0,'2009-05-16 00:20:11'),(185,2,292,0,'2009-05-17 00:00:29'),(186,2,273,0,'2009-05-18 00:08:53'),(187,2,194,0,'2009-05-19 00:12:40'),(188,2,254,0,'2009-05-20 00:01:25'),(189,2,218,0,'2009-05-21 00:00:35'),(190,2,207,0,'2009-05-22 00:09:23'),(191,2,258,0,'2009-05-23 00:00:51'),(192,2,310,0,'2009-05-24 00:01:47'),(193,2,369,0,'2009-05-25 00:21:36'),(194,2,299,0,'2009-05-26 00:06:32'),(195,2,375,0,'2009-05-27 00:01:37'),(196,2,216,0,'2009-05-28 00:06:27'),(197,2,248,0,'2009-05-29 00:01:56'),(198,2,249,0,'2009-05-30 00:01:34'),(199,2,252,0,'2009-05-31 00:04:02'),(200,2,187,0,'2009-06-01 00:06:10'),(201,2,254,0,'2009-06-02 00:03:35'),(202,2,136,0,'2009-06-03 00:02:27'),(203,2,149,0,'2009-06-04 00:07:46'),(204,2,154,0,'2009-06-05 00:12:42'),(205,2,213,0,'2009-06-06 00:23:45'),(206,2,190,0,'2009-06-07 00:38:29'),(207,2,251,0,'2009-06-08 00:08:05'),(208,2,277,0,'2009-06-09 00:08:13'),(209,2,281,0,'2009-06-10 00:13:28'),(210,2,139,0,'2009-06-11 00:19:42'),(211,2,92,0,'2009-07-28 14:34:07'),(212,2,253,0,'2009-07-29 00:03:39'),(213,2,310,0,'2009-07-30 00:05:13'),(214,2,506,0,'2009-07-31 00:12:52'),(215,2,181,0,'2009-08-01 00:38:42'),(216,2,135,0,'2009-08-02 00:04:20'),(217,2,137,0,'2009-08-03 00:03:42'),(218,2,218,0,'2009-08-04 00:06:37'),(219,2,160,0,'2009-08-05 00:02:20'),(220,2,202,0,'2009-08-06 00:08:48'),(221,2,168,0,'2009-08-07 00:28:35'),(222,2,236,0,'2009-08-08 01:08:31'),(223,2,181,0,'2009-08-09 00:41:50'),(224,2,225,0,'2009-08-10 00:01:03'),(225,2,145,0,'2009-08-11 00:00:46'),(226,2,134,0,'2009-08-12 00:01:23'),(227,2,180,0,'2009-08-13 00:08:16'),(228,2,194,0,'2009-08-14 00:03:05'),(229,2,156,0,'2009-08-15 00:13:30'),(230,2,196,0,'2009-08-16 00:00:22'),(231,2,156,0,'2009-08-17 00:06:11'),(232,2,170,0,'2009-08-18 00:03:34'),(233,2,103,0,'2009-08-19 00:08:50'),(234,2,146,0,'2009-08-20 00:22:53'),(235,2,125,0,'2009-08-21 00:08:44'),(236,2,212,0,'2009-08-22 00:19:57'),(237,2,193,0,'2009-08-23 00:10:08'),(238,2,195,0,'2009-08-24 00:01:07'),(239,2,183,0,'2009-08-25 00:40:16'),(240,2,238,0,'2009-08-26 00:03:19'),(241,2,143,0,'2009-08-27 00:12:31'),(242,2,149,0,'2009-08-28 00:03:57'),(243,2,222,0,'2009-08-29 00:03:04'),(244,2,189,0,'2009-08-30 00:00:22'),(245,2,273,0,'2009-08-31 00:15:59'),(246,2,211,0,'2009-09-01 00:00:19'),(247,2,296,0,'2009-09-02 00:01:58'),(248,2,276,0,'2009-09-03 00:05:16'),(249,2,220,0,'2009-09-04 00:02:34'),(250,2,290,0,'2009-09-05 00:10:20'),(251,2,200,0,'2009-09-06 00:23:41'),(252,2,220,0,'2009-09-07 00:13:25'),(253,2,463,0,'2009-09-08 00:00:37'),(254,2,384,0,'2009-09-09 00:00:58'),(255,2,470,0,'2009-09-10 00:01:11'),(256,2,465,0,'2009-09-11 00:00:11'),(257,2,363,0,'2009-09-12 00:01:50'),(258,2,429,0,'2009-09-13 00:00:40'),(259,2,588,0,'2009-09-14 00:06:34'),(260,2,720,0,'2009-09-15 00:05:47'),(261,2,516,0,'2009-09-16 00:00:38'),(262,2,537,0,'2009-09-17 00:01:54'),(263,2,356,0,'2009-09-18 00:00:40'),(264,2,382,0,'2009-09-19 00:09:35'),(265,2,332,0,'2009-09-20 00:05:28'),(266,2,409,0,'2009-09-21 00:57:10'),(267,2,218,0,'2009-09-22 00:03:13'),(268,2,340,0,'2009-09-23 00:03:16'),(269,2,220,0,'2009-09-24 00:06:16'),(270,2,257,0,'2009-09-25 00:25:00'),(271,2,232,0,'2009-09-26 01:03:15'),(272,2,388,0,'2009-09-27 00:09:49'),(273,2,269,0,'2009-09-28 00:25:11'),(274,2,235,0,'2009-09-29 00:02:32'),(275,2,265,0,'2009-09-30 00:03:25'),(276,2,163,0,'2009-10-01 00:38:53'),(277,2,318,0,'2009-10-02 00:04:21'),(278,2,283,0,'2009-10-03 00:09:04'),(279,2,270,0,'2009-10-04 00:01:20'),(280,2,411,0,'2009-10-05 00:00:17'),(281,2,367,0,'2009-10-06 00:08:54'),(282,2,330,0,'2009-10-07 00:11:22'),(283,2,415,0,'2009-10-08 00:00:13'),(284,2,453,0,'2009-10-09 00:35:42'),(285,2,193,0,'2009-10-10 00:00:13'),(286,2,394,0,'2009-10-11 00:24:32'),(287,2,114,0,'2009-10-12 00:03:10'),(288,2,431,0,'2009-10-13 00:15:27'),(289,2,144,0,'2009-10-14 00:04:46'),(290,2,418,0,'2009-10-15 00:00:16'),(291,2,493,0,'2009-10-16 00:06:05'),(292,2,211,0,'2009-10-17 00:24:11'),(293,2,454,0,'2009-10-18 00:04:21'),(294,2,426,0,'2009-10-19 00:08:32'),(295,2,110,0,'2009-10-20 00:31:13'),(296,2,642,0,'2009-10-21 00:13:45'),(297,2,429,0,'2009-10-22 00:00:43'),(298,2,390,0,'2009-10-23 00:00:05'),(299,2,226,0,'2009-10-24 00:00:56'),(300,2,529,0,'2009-10-25 00:18:04'),(301,2,494,0,'2009-10-26 00:06:53'),(302,2,341,0,'2009-10-27 00:01:00'),(303,2,350,0,'2009-10-28 00:01:07'),(304,2,448,0,'2009-10-29 00:04:40'),(305,2,319,0,'2009-10-30 00:02:58'),(306,2,413,0,'2009-10-31 00:00:28'),(307,2,276,0,'2009-11-01 00:01:40'),(308,2,429,0,'2009-11-02 03:25:33'),(309,2,362,0,'2009-11-03 00:01:36'),(310,2,403,0,'2009-11-04 00:26:40'),(311,2,273,0,'2009-11-05 00:06:58'),(312,2,427,0,'2009-11-06 00:03:56'),(313,2,596,0,'2009-11-07 00:01:19'),(314,2,152,0,'2009-11-08 00:05:15'),(315,2,648,0,'2009-11-09 00:01:03'),(316,2,595,0,'2009-11-10 00:16:50'),(317,2,630,0,'2009-11-11 00:10:01'),(318,2,674,0,'2009-11-12 00:03:09'),(319,2,818,0,'2009-11-13 00:03:58'),(320,2,301,0,'2009-11-14 00:04:58'),(321,2,937,0,'2009-11-15 00:01:34'),(322,2,1109,0,'2009-11-16 00:02:26'),(323,2,873,0,'2009-11-17 00:24:23'),(324,2,1124,0,'2009-11-18 00:00:29'),(325,2,1061,0,'2009-11-19 00:00:31'),(326,2,1108,0,'2009-11-20 00:01:55'),(327,2,1022,0,'2009-11-21 00:01:15'),(328,2,967,0,'2009-11-22 00:00:01'),(329,2,821,0,'2009-11-23 00:00:40'),(330,2,487,0,'2009-11-24 00:00:41'),(331,2,667,0,'2009-11-25 00:19:05'),(332,2,91,0,'2009-11-26 00:17:18'),(333,2,100,0,'2009-11-27 00:00:55'),(334,2,717,0,'2009-11-28 00:21:01'),(335,2,426,0,'2009-11-29 00:17:59'),(336,2,755,0,'2009-11-30 00:01:44'),(337,2,427,0,'2009-12-01 00:02:01'),(338,2,797,0,'2009-12-02 00:02:57'),(339,2,956,0,'2009-12-03 00:00:45'),(340,2,636,0,'2009-12-04 00:00:20'),(341,2,350,0,'2009-12-05 00:03:32'),(342,2,691,0,'2009-12-06 00:00:15'),(343,2,597,0,'2009-12-07 00:25:49'),(344,2,535,0,'2009-12-08 00:02:36'),(345,2,588,0,'2009-12-09 00:00:18'),(346,2,641,0,'2009-12-10 00:06:10'),(347,2,145,0,'2009-12-11 00:02:22'),(348,2,803,0,'2009-12-12 00:04:59'),(349,2,114,0,'2009-12-13 00:12:40'),(350,2,1099,0,'2009-12-14 00:07:13'),(351,2,337,0,'2009-12-15 00:01:46'),(352,2,1105,0,'2009-12-16 00:00:28'),(353,2,642,0,'2009-12-17 00:11:56'),(354,2,438,0,'2009-12-18 00:02:13'),(355,2,655,0,'2009-12-19 00:02:02'),(356,2,295,0,'2009-12-20 00:19:41'),(357,2,706,0,'2009-12-21 00:01:02'),(358,2,302,0,'2009-12-22 00:07:26'),(359,2,681,0,'2009-12-23 00:00:32'),(360,2,897,0,'2009-12-24 00:21:55'),(361,2,180,0,'2009-12-25 00:00:50'),(362,2,900,0,'2009-12-26 00:00:13'),(363,2,669,0,'2009-12-27 00:08:07'),(364,2,581,0,'2009-12-28 00:01:52'),(365,2,758,0,'2009-12-29 00:00:28'),(366,2,700,0,'2009-12-30 00:17:41'),(367,2,440,0,'2009-12-31 00:00:40'),(368,2,730,0,'2010-01-01 00:00:20'),(369,2,769,0,'2010-01-02 00:02:04'),(370,2,553,0,'2010-01-03 00:00:26'),(371,2,693,0,'2010-01-04 00:01:56'),(372,2,242,0,'2010-01-05 00:00:59'),(373,2,585,0,'2010-01-06 00:06:33'),(374,2,376,0,'2010-01-07 00:01:02'),(375,2,763,0,'2010-01-08 00:00:30'),(376,2,1046,0,'2010-01-09 00:05:46'),(377,2,739,0,'2010-01-10 00:00:44'),(378,2,803,0,'2010-01-11 00:02:14'),(379,2,1235,0,'2010-01-12 00:07:55'),(380,2,778,0,'2010-01-13 00:00:23'),(381,2,1178,0,'2010-01-14 00:03:36'),(382,2,756,0,'2010-01-15 00:02:42'),(383,2,50,0,'2010-04-13 23:26:17'),(384,2,19,0,'2010-04-14 00:03:19'),(385,2,103,0,'2010-05-27 10:09:29'),(386,2,140,0,'2010-05-28 00:23:28'),(387,2,80,0,'2010-05-29 00:00:38'),(388,2,209,0,'2010-05-30 00:00:28'),(389,2,216,0,'2010-05-31 00:03:04'),(390,2,110,0,'2010-06-01 00:15:42'),(391,2,151,0,'2010-06-02 00:12:58'),(392,2,153,0,'2010-06-03 00:12:16'),(393,2,120,0,'2010-06-04 00:03:10'),(394,2,162,0,'2010-06-05 00:07:49'),(395,2,129,0,'2010-06-06 00:06:58'),(396,2,108,0,'2010-06-07 00:11:57'),(397,2,117,0,'2010-06-08 00:08:15'),(398,2,124,0,'2010-06-09 00:09:35'),(399,2,124,0,'2010-06-10 00:12:24'),(400,2,84,0,'2010-06-11 00:28:54'),(401,2,98,0,'2010-06-12 00:16:27'),(402,2,190,0,'2010-06-13 00:10:14'),(403,2,68,0,'2010-06-14 00:09:23'),(404,2,61,0,'2010-06-15 00:27:21'),(405,2,48,0,'2010-06-16 00:26:20'),(406,2,72,0,'2010-06-17 00:47:43'),(407,2,41,0,'2010-06-18 01:40:59'),(408,2,63,0,'2010-06-19 00:37:34'),(409,2,66,0,'2010-06-20 00:16:45'),(410,2,76,0,'2010-06-21 01:25:59'),(411,2,78,0,'2010-06-22 00:21:34'),(412,2,68,0,'2010-06-23 00:11:16'),(413,2,67,0,'2010-06-24 01:48:45'),(414,2,55,0,'2010-06-25 00:26:01'),(415,2,69,0,'2010-06-26 00:26:25'),(416,2,59,0,'2010-06-27 00:54:16'),(417,2,68,0,'2010-06-28 01:10:03'),(418,2,55,0,'2010-06-29 00:09:30'),(419,2,77,0,'2010-06-30 00:54:39'),(420,2,89,0,'2010-07-01 00:14:21'),(421,2,88,0,'2010-07-02 00:00:34'),(422,2,128,0,'2010-07-03 00:18:28'),(423,2,108,0,'2010-07-04 00:00:57'),(424,2,94,0,'2010-07-05 00:04:55'),(425,2,106,0,'2010-07-06 00:28:22'),(426,2,183,0,'2010-07-07 00:02:49'),(427,2,115,0,'2010-07-08 00:14:50'),(428,2,138,0,'2010-07-09 00:18:07'),(429,2,91,0,'2010-07-10 00:16:17'),(430,2,110,0,'2010-07-11 00:04:04'),(431,2,128,0,'2010-07-12 00:02:11'),(432,2,86,0,'2010-07-13 00:13:19'),(433,2,87,0,'2010-07-14 00:00:29'),(434,2,59,0,'2010-07-15 00:03:15'),(435,2,90,0,'2010-07-16 00:05:22'),(436,2,96,0,'2010-07-17 00:01:35'),(437,2,88,0,'2010-07-18 00:11:15'),(438,2,118,0,'2010-07-19 00:09:25'),(439,2,100,0,'2010-07-20 00:35:23'),(440,2,115,0,'2010-07-21 00:05:00'),(441,2,64,0,'2010-07-22 00:04:21'),(442,2,3,0,'2010-10-06 12:14:33');
/*!40000 ALTER TABLE `banners_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `cache_id` varchar(32) NOT NULL,
  `cache_language_id` tinyint(1) NOT NULL DEFAULT '0',
  `cache_name` varchar(255) NOT NULL,
  `cache_data` mediumtext NOT NULL,
  `cache_global` tinyint(1) NOT NULL DEFAULT '1',
  `cache_gzip` tinyint(1) NOT NULL DEFAULT '1',
  `cache_method` varchar(20) NOT NULL DEFAULT 'RETURN',
  `cache_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cache_expires` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`cache_id`,`cache_language_id`),
  KEY `cache_id` (`cache_id`),
  KEY `cache_language_id` (`cache_language_id`),
  KEY `cache_global` (`cache_global`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('a93b9170a03ff54d81e95917742ea01b',3,'seo_urls_v2_categories','S0lNy8xL1VB3dgxxdfcPioz3c/R1jTdU11FQT0styktPLS5JLU0tKknVTSwtyS9W17TmSsGqxQikJTk/r7g0N7VINzUnNbmkKD8vMxmPFmOQFtwmmsCkAQ==',1,1,'EVAL','2009-05-07 00:48:45','2009-06-06 00:48:45'),('ca34fbe5f9a075091ad59abf02c259a7',3,'seo_urls_v2_products','dc87D8IgFIbh3V/hhiaeRIjawcmoo5cYnRugtCUNnHqgXv69ZZf9eb/kq0xtvZmx6+1yeOzv5Xl3OpacLaaMNKihab7Qqg+8BZtvJ9U/LBJ26EM0BJEG3YGyTY0Ys8kqJQH9uF1Rq3kWrhPU6Hr5BFHwZQ8eo1GIXTbZpOQlLUIwZE0AZzVhlheJj1c7GaWTJH2SPw==',1,1,'EVAL','2009-05-07 00:48:45','2009-06-06 00:48:45'),('eed8a5b35a2f51f214b1c6b119528c9f',5,'seo_urls_v2_information','dc49DsIwDIbhnVOwBSQY+B+YGKjUgXKEKsImWEptlLiI41MPLJCOlp73kwHvxDhzdVNd2+Z0Obcrt5i6B3ogDkoa0c2PE/hja2OKbw0JUQf7xJSFfSzzzRhPGCUIl6vtbxV6zFq2u6/tPI3M7Y1EeiVPw6vlmYOZmzCQknBeQq8UKXu7rPgA',1,1,'EVAL','2009-05-06 19:54:56','2009-06-05 19:54:56'),('4404c1df54fdb1291c8dd9bb259f32a9',5,'seo_urls_v2_manufacturers','S0lNy8xL1VD3dfQLdXN0DgkNcg2K93P0dY03VNdRUM9KzM0vKUpMSVXXtOZKwanWCKS2KjU1Bb8yE5Cy4vy8SvzKTEHKMlLLc1JLSgoSk7MTi8DmAgA=',1,1,'EVAL','2009-05-06 19:54:56','2009-06-05 19:54:56'),('a93b9170a03ff54d81e95917742ea01b',5,'seo_urls_v2_categories','S0lNy8xL1VB3dgxxdfcPioz3c/R1jTdU11FQT0styktPLS5JLU0tKknVTSwtyS9W17TmSsGqxQikJTk/r7g0N7VINzUnNbmkKD8vMxmPFmOwlsTiwtJU3OaagBSBpAE=',1,1,'EVAL','2009-05-06 19:54:56','2009-06-05 19:54:56'),('ca34fbe5f9a075091ad59abf02c259a7',5,'seo_urls_v2_products','dc87D8IgFIbh3V/hhiaeRIjawcmoo5cYnRugtCUNnHqgXv69ZZf9eb/kq0xtvZmx6+1yeOzv5Xl3OpacLaaMNKihab7Qqg+8BZtvJ9U/LBJ26EM0BJEG3YGyTY0Ys8kqJQH9uF1Rq3kWrhPU6Hr5BFHwZQ8eo1GIXTbZpOQlLUIwZE0AZzVhlheJj1c7GaWTJH2SPw==',1,1,'EVAL','2009-05-06 19:54:56','2009-06-05 19:54:56'),('eed8a5b35a2f51f214b1c6b119528c9f',1,'seo_urls_v2_information','S0lNy8xL1VD39HPzj/dz9HWNN1TXUVDPSE1MycxLL8ksyUlV17TmSsFQZgRSVpJaUZJelJpaAlRbkFpUnJ+XmINduTEu5UWpOfnp+XnYdZmg60ovTS0uwa7WFKY2NzETh3FmICXFGZkFBUD3YjfFHKQkOT8vJbMkMz+vWDc/Tbe0GBwEAA==',1,1,'EVAL','2009-05-06 19:18:18','2009-06-05 19:18:18'),('4404c1df54fdb1291c8dd9bb259f32a9',1,'seo_urls_v2_manufacturers','S0lNy8xL1VD3dfQLdXN0DgkNcg2K93P0dY03VNdRUM9KzM0vKUpMSVXXtOZKwanWCKS2KjU1Bb8yE5Cy4vy8SvzKTEHKMlLLc1JLSgoSk7MTi8DmAgA=',1,1,'EVAL','2009-05-06 19:18:18','2009-06-05 19:18:18'),('a93b9170a03ff54d81e95917742ea01b',1,'seo_urls_v2_categories','S0lNy8xL1VB3dgxxdfcPioz3c/R1jTdU11FQL0rNzS9J1U1OLCpW17TmSsGq0gikMjk/r7g0N7VINzUnNbmkKD8vMxmPFmOQlozUnNzUEjyqTECqQPYCAA==',1,1,'EVAL','2009-05-06 19:18:18','2009-06-05 19:18:18'),('ca34fbe5f9a075091ad59abf02c259a7',1,'seo_urls_v2_products','dc87D8IgFIbh3V/hhiaeRIjawcmoo5cYnRugtCUNnHqgXv69ZZf9eb/kq0xtvZmx6+1yeOzv5Xl3OpacLaaMNKihab7Qqg+8BZtvJ9U/LBJ26EM0BJEG3YGyTY0Ys8kqJQH9uF1Rq3kWrhPU6Hr5BFHwZQ8eo1GIXTbZpOQlLUIwZE0AZzVhlheJj1c7GaWTJH2SPw==',1,1,'EVAL','2009-05-06 19:18:18','2009-06-05 19:18:18'),('eed8a5b35a2f51f214b1c6b119528c9f',4,'seo_urls_v2_information','dc+9CgIxEATg3qewi4IW/hdWFgoWno9wBDPGhbh7JHsgPr0GsdGk/2aGcbgSY2SOzeHcNrvTvp2ZydDcYB2xV9IAM94O3B+bZ6Z4qI+Avm2HmIRtKPNFjUcE8cLl1PI35XskLdvV194tVerWmaQOjp4kXDm2yegi/EE0DX2SvPgC',1,1,'EVAL','2009-05-06 19:00:23','2009-06-05 19:00:23'),('4404c1df54fdb1291c8dd9bb259f32a9',4,'seo_urls_v2_manufacturers','S0lNy8xL1VD3dfQLdXN0DgkNcg2K93P0dY03VNdRUM9KzM0vKUpMSVXXtOZKwanWCKS2KjU1Bb8yE5Cy4vy8SvzKTEHKMlLLc1JLSgoSk7MTi8DmAgA=',1,1,'EVAL','2009-05-06 19:00:23','2009-06-05 19:00:23'),('a93b9170a03ff54d81e95917742ea01b',4,'seo_urls_v2_categories','S0lNy8xL1VB3dgxxdfcPioz3c/R1jTdU11FQT0styktPLS5JLU0tKknVTSwtyS9W17TmSsGqxQikJTk/r7g0N7VINzUnNbmkKD8vMxmPFmOwlsTi5IxM3OaagBSBpAE=',1,1,'EVAL','2009-05-06 19:00:23','2009-06-05 19:00:23'),('ca34fbe5f9a075091ad59abf02c259a7',4,'seo_urls_v2_products','dc87D8IgFIbh3V/hhiaeRIjawcmoo5cYnRugtCUNnHqgXv69ZZf9eb/kq0xtvZmx6+1yeOzv5Xl3OpacLaaMNKihab7Qqg+8BZtvJ9U/LBJ26EM0BJEG3YGyTY0Ys8kqJQH9uF1Rq3kWrhPU6Hr5BFHwZQ8eo1GIXTbZpOQlLUIwZE0AZzVhlheJj1c7GaWTJH2SPw==',1,1,'EVAL','2009-05-06 19:00:23','2009-06-05 19:00:23'),('eed8a5b35a2f51f214b1c6b119528c9f',2,'seo_urls_v2_information','dc47DsIwEIThnlPQGSQoeBdUFERKQThCtMjDYslZI3uDOD5xQQNO//2jsbg7wczUTXVtm9Pl3K7MYmoeIOuE1amHmR8n9o+tM1O8lSOgg30ipiDky3wzxiN84CDlavtbcY+kZbv72o7cyNw+k9fwk8SWRw5Z9JIQsSS+paw+',1,1,'EVAL','2009-05-06 18:39:39','2009-06-05 18:39:39'),('4404c1df54fdb1291c8dd9bb259f32a9',2,'seo_urls_v2_manufacturers','S0lNy8xL1VD3dfQLdXN0DgkNcg2K93P0dY03VNdRUM9KzM0vKUpMSVXXtOZKwanWCKS2KjU1Bb8yE5Cy4vy8SvzKTEHKMlLLc1JLSgoSk7MTi8DmAgA=',1,1,'EVAL','2009-05-06 18:39:39','2009-06-05 18:39:39'),('a93b9170a03ff54d81e95917742ea01b',2,'seo_urls_v2_categories','S0lNy8xL1VB3dgxxdfcPioz3c/R1jTdU11FQT0styktPLS5JLU0tKknVTSwtyS9W17TmSsGqxQikJTk/r7g0N7VINzUnNbmkKD8vMxmPFmOQlozUnNxU3MaagNSklKWAVAAA',1,1,'EVAL','2009-05-06 18:39:39','2009-06-05 18:39:39'),('ca34fbe5f9a075091ad59abf02c259a7',2,'seo_urls_v2_products','dc87D8IgFIbh3V/hhiaeRIjawcmoo5cYnRugtCUNnHqgXv69ZZf9eb/kq0xtvZmx6+1yeOzv5Xl3OpacLaaMNKihab7Qqg+8BZtvJ9U/LBJ26EM0BJEG3YGyTY0Ys8kqJQH9uF1Rq3kWrhPU6Hr5BFHwZQ8eo1GIXTbZpOQlLUIwZE0AZzVhlheJj1c7GaWTJH2SPw==',1,1,'EVAL','2009-05-06 18:39:39','2009-06-05 18:39:39'),('4404c1df54fdb1291c8dd9bb259f32a9',3,'seo_urls_v2_manufacturers','S0lNy8xL1VD3dfQLdXN0DgkNcg2K93P0dY03VNdRUM9KzM0vKUpMSVXXtOZKwanWCKS2KjU1Bb8yE5Cy4vy8SvzKTEHKMlLLc1JLSgoSk7MTi8DmAgA=',1,1,'EVAL','2009-05-07 00:48:45','2009-06-06 00:48:45'),('eed8a5b35a2f51f214b1c6b119528c9f',3,'seo_urls_v2_information','dcw7DsIwEIThnlPQGSRS8C6oKIhEQThCZMWDWcnsRvYGcXxwQQNOPd/8DjdizMy5qa9tc7yc2qVZTM0d1hF7JQ0w88PE/bFVZoqX+gjox/aISdiGMl+P8YggXrj82vy+/ICkZbv92oelkdwuE/BTUjmxz3sn7KgjYaTKoRqSZPwG',1,1,'EVAL','2009-05-07 00:48:45','2009-06-06 00:48:45'),('ca34fbe5f9a075091ad59abf02c259a7',0,'seo_urls_v2_products','S0lNy8xL1VAPCPJ3CXUOifdz9HWNN1TXUVBX17TmSsEma4RX1gSvrCleWTO8suYwWQA=',1,1,'EVAL','2009-05-21 15:37:43','2009-06-20 15:37:43'),('a93b9170a03ff54d81e95917742ea01b',0,'seo_urls_v2_categories','AwA=',1,1,'EVAL','2009-05-21 15:37:43','2009-06-20 15:37:43'),('4404c1df54fdb1291c8dd9bb259f32a9',0,'seo_urls_v2_manufacturers','S0lNy8xL1VD3dfQLdXN0DgkNcg2K93P0dY03VNdRUM9KzM0vKUpMSVXXtOZKwanWCKS2KjU1Bb8yE5Cy4vy8SvzKTEHKMlLLc1JLSgoSk7MTi8DmAgA=',1,1,'EVAL','2009-05-21 15:37:43','2009-06-20 15:37:43'),('eed8a5b35a2f51f214b1c6b119528c9f',0,'seo_urls_v2_information','AwA=',1,1,'EVAL','2009-05-21 15:37:43','2009-06-20 15:37:43');
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cao_log`
--

DROP TABLE IF EXISTS `cao_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cao_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user` varchar(64) NOT NULL,
  `pw` varchar(64) NOT NULL,
  `method` varchar(64) NOT NULL,
  `action` varchar(64) NOT NULL,
  `post_data` mediumtext,
  `get_data` mediumtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cao_log`
--

LOCK TABLES `cao_log` WRITE;
/*!40000 ALTER TABLE `cao_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cao_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `categories_id` int(11) NOT NULL AUTO_INCREMENT,
  `categories_image` varchar(64) DEFAULT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(3) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `categories_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0=disabled; 1=enabled',
  PRIMARY KEY (`categories_id`),
  KEY `idx_categories_parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'',0,1,'2007-11-04 13:57:31','2010-07-16 16:41:56',1),(2,'',0,0,'2007-11-04 13:57:51','2010-07-22 10:10:27',1);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_description`
--

DROP TABLE IF EXISTS `categories_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories_description` (
  `categories_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL DEFAULT '1',
  `categories_name` varchar(32) NOT NULL,
  `categories_description` text NOT NULL,
  `categories_seo_url` varchar(100) NOT NULL,
  `categories_htc_title_tag` varchar(80) DEFAULT NULL,
  `categories_htc_desc_tag` longtext,
  `categories_htc_keywords_tag` longtext,
  PRIMARY KEY (`categories_id`,`language_id`),
  KEY `idx_categories_name` (`categories_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_description`
--

LOCK TABLES `categories_description` WRITE;
/*!40000 ALTER TABLE `categories_description` DISABLE KEYS */;
INSERT INTO `categories_description` VALUES (1,2,'Ferngesteuerte Autos','','','Ferngesteuerte Autos','Ferngesteuerte Autos','Ferngesteuerte Autos'),(1,1,'Remote Cars','','','R/C Modellbau','R/C Modellbau','R/C Modellbau'),(1,5,'Ferngesteuerte Autos','','','R/C Modellbau','R/C Modellbau','R/C Modellbau'),(1,4,'Ferngesteuerte Autos','','','R/C Modellbau','R/C Modellbau','R/C Modellbau'),(1,3,'Ferngesteuerte Autos','','','R/C Modellbau','R/C Modellbau','R/C Modellbau'),(2,2,'Consumer Electronics','<p>Unterhaltungselektronik ist ein Sammelbegriff f&uuml;r Elektroger&auml;te, die der Unterhaltung des Benutzers dienen.</p>\r\n<p>Im Jargon des Fachhandels wird sie Braune Ware genannt, da Fernseh- und Rundfunkger&auml;te fr&uuml;her h&auml;ufig furnierte Holzgeh&auml;use hatten. Der Begriff unterscheidet sich von der Gebrauchselektronik (auch Wei&szlig;e Ware), die dem Benutzer m&uuml;hsame T&auml;tigkeiten abnimmt.</p>','','Consumer Electronics','Consumer Electronics','Consumer Electronics'),(2,1,'Consumer Electronics','<p>Consumer electronics include electronic equipment intended for everyday use. Consumer electronics are most often used in entertainment, communications and office productivity. Some products classed as consumer electronics include personal computers, telephones, MP3 players, audio equipment, televisions, calculators, GPS automotive navigation systems, digital cameras and playback and recording of video media such as DVDs, VHSs or camcorders.</p>\r\n<p>Currently, the global consumer electronics industry is mainly dominated by Japanese and South Korean companies.</p>','','Consumer Electronics','Consumer Electronics','Consumer Electronics'),(2,5,'Consumer Electronics','','','Consumer Electronics','Consumer Electronics','Consumer Electronics'),(2,4,'Consumer Electronics','<p>L\'elettronica di consumo &egrave; una branca dell\'industria elettronica, che produce apparecchi usati per l\'intrattenimento, la comunicazione e il lavoro in ufficio. I suoi prodotti sono radio, televisori, fotocamere digitali, videocamere, lettori VHS, DVD, Blu-ray ed mp3, personal computer, console per videogiochi, telefoni cellulari, navigatori satellitari e sistemi GPS.</p>\r\n<p>Le maggiori aziende del settore si trovano soprattutto in Estremo Oriente (Sony, Panasonic, Sharp, Hitachi e Toshiba in Giappone, LG e Samsung in Corea del Sud, Haier e Lenovo in Cina, Acer ed Asus a Taiwan), ma anche negli Stati Uniti (Hewlett-Packard, Dell, Apple, Motorola) e in Europa (Nokia, Philips).</p>','','Consumer Electronics','Consumer Electronics','Consumer Electronics'),(2,3,'Consumer Electronics','<p>La Electr&oacute;nica de consumo engloba todos los equipos el&eacute;ctricos utilizados cotidianamente y generalmente se utiliza en el entretenimiento, la comunicaci&oacute;n y la oficina. Dentro de los productos clasificados bajo la categor&iacute;a de electr&oacute;nica de consumo encontramos el computador personal, los tel&eacute;fonos, los MP3, los equipos de audio, televisores, calculadoras, GPS Sistema de navegaci&oacute;n para autom&oacute;viles, reproductores y grabadores de videos, como por ejemplo el DVD, VHS o videoc&aacute;maras.</p>\r\n<p>Las compa&ntilde;&iacute;as Norte americanas, japonesas y coreanas son l&iacute;deres mundiales en la comercializaci&oacute;n de la electr&oacute;nica de consumo. Algunas de las marcas m&aacute;s conocidas son: Samsung, Sony, Panasonic, Toshiba, LG, Apple y otras.</p>','','Consumer Electronics','Consumer Electronics','Consumer Electronics');
/*!40000 ALTER TABLE `categories_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuration` (
  `configuration_id` int(11) NOT NULL AUTO_INCREMENT,
  `configuration_title` varchar(64) NOT NULL,
  `configuration_key` varchar(64) NOT NULL,
  `configuration_value` varchar(512) NOT NULL,
  `configuration_description` varchar(255) NOT NULL,
  `configuration_group_id` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(5) DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `use_function` varchar(255) DEFAULT NULL,
  `set_function` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`configuration_id`)
) ENGINE=MyISAM AUTO_INCREMENT=637 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuration`
--

LOCK TABLES `configuration` WRITE;
/*!40000 ALTER TABLE `configuration` DISABLE KEYS */;
INSERT INTO `configuration` VALUES (1,'Store Name','STORE_NAME','swisscart® Demo Shop','The name of my store',1,1,'2008-11-06 10:11:26','2007-06-12 22:50:01',NULL,NULL),(2,'Store Owner','STORE_OWNER','swisscart® Demo Shop','The name of my store owner',1,2,'2008-11-06 10:11:34','2007-06-12 22:50:01',NULL,NULL),(3,'E-Mail Address','STORE_OWNER_EMAIL_ADDRESS','info@openstream.ch','The e-mail address of my store owner',1,3,'2009-09-10 15:53:34','2007-06-12 22:50:01',NULL,NULL),(4,'E-Mail From','EMAIL_FROM','Dies ist nur ein Demo-Shop <info@openstream.ch>','The e-mail address used in (sent) e-mails',1,4,'2009-09-10 15:54:03','2007-06-12 22:50:01',NULL,NULL),(5,'Country','STORE_COUNTRY','204','The country my store is located in <br><br><b>Note: Please remember to update the store zone.</b>',1,6,'2007-06-13 02:02:21','2007-06-12 22:50:01','tep_get_country_name','tep_cfg_pull_down_country_list('),(6,'Zone','STORE_ZONE','129','The zone my store is located in',1,7,'2007-06-13 02:02:30','2007-06-12 22:50:01','tep_cfg_get_zone_name','tep_cfg_pull_down_zone_list('),(7,'Expected Sort Order','EXPECTED_PRODUCTS_SORT','desc','This is the sort order used in the expected products box.',1,8,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'asc\', \'desc\'),'),(8,'Expected Sort Field','EXPECTED_PRODUCTS_FIELD','date_expected','The column to sort by in the expected products box.',1,9,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'products_name\', \'date_expected\'),'),(9,'Switch To Default Language Currency','USE_DEFAULT_LANGUAGE_CURRENCY','false','Automatically switch to the language\'s currency when it is changed',1,10,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(10,'Send Extra Order Emails To','SEND_EXTRA_ORDER_EMAILS_TO','info@openstream.ch','Send extra order emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;',1,11,'2009-09-10 15:54:19','2007-06-12 22:50:01',NULL,NULL),(11,'Use Search-Engine Safe URLs (still in development)','SEARCH_ENGINE_FRIENDLY_URLS','false','Use search-engine safe urls for all site links',1,12,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(12,'Display Cart After Adding Product','DISPLAY_CART','true','Display the shopping cart after adding a product (or return back to their origin)',1,14,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(13,'Allow Guest To Tell A Friend','ALLOW_GUEST_TO_TELL_A_FRIEND','false','Allow guests to tell a friend about a product',1,15,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(14,'Default Search Operator','ADVANCED_SEARCH_DEFAULT_OPERATOR','and','Default search operators',1,17,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'and\', \'or\'),'),(15,'Store Address and Phone','STORE_NAME_ADDRESS','Openstream Internet Solutions\nWieslergasse 6\n8049 Zürich\n+41 44 500 78 78\ninfo@swisscart.com','This is the Store Name, Address and Phone used on printable documents and displayed online',1,18,'2008-03-25 22:44:40','2007-06-12 22:50:01',NULL,'tep_cfg_textarea('),(16,'Show Category Counts','SHOW_COUNTS','false','Count recursively how many products are in each category',1,19,'2007-08-13 20:02:16','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(17,'Tax Decimal Places','TAX_DECIMAL_PLACES','0','Pad the tax value this amount of decimal places',1,20,NULL,'2007-06-12 22:50:01',NULL,NULL),(18,'Display Prices with Tax','DISPLAY_PRICE_WITH_TAX','true','Display prices with tax included (true) or add the tax at the end (false)',1,21,'2007-11-04 14:12:51','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(19,'First Name','ENTRY_FIRST_NAME_MIN_LENGTH','2','Minimum length of first name',2,1,NULL,'2007-06-12 22:50:01',NULL,NULL),(20,'Last Name','ENTRY_LAST_NAME_MIN_LENGTH','2','Minimum length of last name',2,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(21,'Date of Birth','ENTRY_DOB_MIN_LENGTH','10','Minimum length of date of birth',2,3,NULL,'2007-06-12 22:50:01',NULL,NULL),(22,'E-Mail Address','ENTRY_EMAIL_ADDRESS_MIN_LENGTH','6','Minimum length of e-mail address',2,4,NULL,'2007-06-12 22:50:01',NULL,NULL),(23,'Street Address','ENTRY_STREET_ADDRESS_MIN_LENGTH','5','Minimum length of street address',2,5,NULL,'2007-06-12 22:50:01',NULL,NULL),(24,'Company','ENTRY_COMPANY_MIN_LENGTH','2','Minimum length of company name',2,6,NULL,'2007-06-12 22:50:01',NULL,NULL),(25,'Post Code','ENTRY_POSTCODE_MIN_LENGTH','4','Minimum length of post code',2,7,NULL,'2007-06-12 22:50:01',NULL,NULL),(26,'City','ENTRY_CITY_MIN_LENGTH','3','Minimum length of city',2,8,NULL,'2007-06-12 22:50:01',NULL,NULL),(27,'State','ENTRY_STATE_MIN_LENGTH','2','Minimum length of state',2,9,NULL,'2007-06-12 22:50:01',NULL,NULL),(28,'Telephone Number','ENTRY_TELEPHONE_MIN_LENGTH','3','Minimum length of telephone number',2,10,NULL,'2007-06-12 22:50:01',NULL,NULL),(29,'Password','ENTRY_PASSWORD_MIN_LENGTH','5','Minimum length of password',2,11,NULL,'2007-06-12 22:50:01',NULL,NULL),(30,'Credit Card Owner Name','CC_OWNER_MIN_LENGTH','3','Minimum length of credit card owner name',2,12,NULL,'2007-06-12 22:50:01',NULL,NULL),(31,'Credit Card Number','CC_NUMBER_MIN_LENGTH','10','Minimum length of credit card number',2,13,NULL,'2007-06-12 22:50:01',NULL,NULL),(32,'Review Text','REVIEW_TEXT_MIN_LENGTH','50','Minimum length of review text',2,14,NULL,'2007-06-12 22:50:01',NULL,NULL),(33,'Best Sellers','MIN_DISPLAY_BESTSELLERS','1','Minimum number of best sellers to display',2,15,NULL,'2007-06-12 22:50:01',NULL,NULL),(34,'Also Purchased','MIN_DISPLAY_ALSO_PURCHASED','1','Minimum number of products to display in the \'This Customer Also Purchased\' box',2,16,NULL,'2007-06-12 22:50:01',NULL,NULL),(35,'Address Book Entries','MAX_ADDRESS_BOOK_ENTRIES','5','Maximum address book entries a customer is allowed to have',3,1,NULL,'2007-06-12 22:50:01',NULL,NULL),(36,'Search Results','MAX_DISPLAY_SEARCH_RESULTS','20','Amount of products to list',3,2,'2008-11-06 10:12:43','2007-06-12 22:50:01',NULL,NULL),(37,'Page Links','MAX_DISPLAY_PAGE_LINKS','5','Number of \'number\' links use for page-sets',3,3,NULL,'2007-06-12 22:50:01',NULL,NULL),(38,'Special Products','MAX_DISPLAY_SPECIAL_PRODUCTS','9','Maximum number of products on special to display',3,4,NULL,'2007-06-12 22:50:01',NULL,NULL),(39,'New Products Module','MAX_DISPLAY_NEW_PRODUCTS','3','Maximum number of new products to display in a category',3,5,'2008-03-12 15:43:05','2007-06-12 22:50:01',NULL,NULL),(40,'Products Expected','MAX_DISPLAY_UPCOMING_PRODUCTS','10','Maximum number of products expected to display',3,6,NULL,'2007-06-12 22:50:01',NULL,NULL),(41,'Manufacturers List','MAX_DISPLAY_MANUFACTURERS_IN_A_LIST','0','Used in manufacturers box; when the number of manufacturers exceeds this number, a drop-down list will be displayed instead of the default list',3,7,NULL,'2007-06-12 22:50:01',NULL,NULL),(42,'Manufacturers Select Size','MAX_MANUFACTURERS_LIST','1','Used in manufacturers box; when this value is \'1\' the classic drop-down list will be used for the manufacturers box. Otherwise, a list-box with the specified number of rows will be displayed.',3,7,NULL,'2007-06-12 22:50:01',NULL,NULL),(43,'Length of Manufacturers Name','MAX_DISPLAY_MANUFACTURER_NAME_LEN','15','Used in manufacturers box; maximum length of manufacturers name to display',3,8,NULL,'2007-06-12 22:50:01',NULL,NULL),(44,'New Reviews','MAX_DISPLAY_NEW_REVIEWS','6','Maximum number of new reviews to display',3,9,NULL,'2007-06-12 22:50:01',NULL,NULL),(45,'Selection of Random Reviews','MAX_RANDOM_SELECT_REVIEWS','10','How many records to select from to choose one random product review',3,10,NULL,'2007-06-12 22:50:01',NULL,NULL),(46,'Selection of Random New Products','MAX_RANDOM_SELECT_NEW','10','How many records to select from to choose one random new product to display',3,11,NULL,'2007-06-12 22:50:01',NULL,NULL),(47,'Selection of Products on Special','MAX_RANDOM_SELECT_SPECIALS','10','How many records to select from to choose one random product special to display',3,12,NULL,'2007-06-12 22:50:01',NULL,NULL),(48,'Categories To List Per Row','MAX_DISPLAY_CATEGORIES_PER_ROW','3','How many categories to list per row',3,13,NULL,'2007-06-12 22:50:01',NULL,NULL),(49,'New Products Listing','MAX_DISPLAY_PRODUCTS_NEW','10','Maximum number of new products to display in new products page',3,14,NULL,'2007-06-12 22:50:01',NULL,NULL),(50,'Best Sellers','MAX_DISPLAY_BESTSELLERS','10','Maximum number of best sellers to display',3,15,NULL,'2007-06-12 22:50:01',NULL,NULL),(51,'Also Purchased','MAX_DISPLAY_ALSO_PURCHASED','6','Maximum number of products to display in the \'This Customer Also Purchased\' box',3,16,NULL,'2007-06-12 22:50:01',NULL,NULL),(52,'Customer Order History Box','MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX','6','Maximum number of products to display in the customer order history box',3,17,NULL,'2007-06-12 22:50:01',NULL,NULL),(53,'Order History','MAX_DISPLAY_ORDER_HISTORY','10','Maximum number of orders to display in the order history page',3,18,NULL,'2007-06-12 22:50:01',NULL,NULL),(54,'Small Image Width','SMALL_IMAGE_WIDTH','100','The pixel width of small images',4,1,NULL,'2007-06-12 22:50:01',NULL,NULL),(55,'Small Image Height','SMALL_IMAGE_HEIGHT','','The pixel height of small images',4,2,'2007-08-05 01:51:34','2007-06-12 22:50:01',NULL,NULL),(56,'Heading Image Width','HEADING_IMAGE_WIDTH','57','The pixel width of heading images',4,3,'2007-08-14 23:41:05','2007-06-12 22:50:01',NULL,NULL),(57,'Heading Image Height','HEADING_IMAGE_HEIGHT','','The pixel height of heading images',4,4,'2007-08-01 22:32:43','2007-06-12 22:50:01',NULL,NULL),(58,'Subcategory Image Width','SUBCATEGORY_IMAGE_WIDTH','100','The pixel width of subcategory images',4,5,NULL,'2007-06-12 22:50:01',NULL,NULL),(59,'Subcategory Image Height','SUBCATEGORY_IMAGE_HEIGHT','','The pixel height of subcategory images',4,6,'2007-08-01 22:32:53','2007-06-12 22:50:01',NULL,NULL),(60,'Calculate Image Size','CONFIG_CALCULATE_IMAGE_SIZE','true','Calculate the size of images?',4,7,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(61,'Image Required','IMAGE_REQUIRED','true','Enable to display broken images. Good for development.',4,8,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(62,'Gender','ACCOUNT_GENDER','true','Display gender in the customers account',5,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(63,'Date of Birth','ACCOUNT_DOB','false','Display date of birth in the customers account',5,2,'2007-12-13 14:32:25','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(64,'Company','ACCOUNT_COMPANY','true','Display company in the customers account',5,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(65,'Suburb','ACCOUNT_SUBURB','false','Display suburb in the customers account',5,4,'2007-12-13 14:32:33','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(66,'State','ACCOUNT_STATE','false','Display state in the customers account',5,5,'2007-12-13 14:32:38','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(67,'Installed Modules','MODULE_PAYMENT_INSTALLED','cod.php;invoice.php;moneyorder.php;paypal_standard.php;postfinance.php;saferpaygw.php','List of payment module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: cc.php;cod.php;paypal.php)',6,0,'2010-05-31 09:36:45','2007-06-12 22:50:01',NULL,NULL),(68,'Installed Modules','MODULE_ORDER_TOTAL_INSTALLED','ot_subtotal.php;ot_shipping.php;ot_tax.php;ot_coupon.php;ot_total.php','List of order_total module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)',6,0,'2009-07-28 17:49:38','2007-06-12 22:50:01',NULL,NULL),(69,'Installed Modules','MODULE_SHIPPING_INSTALLED','chp.php','List of shipping module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ups.php;flat.php;item.php)',6,0,'2010-04-01 12:40:24','2007-06-12 22:50:01',NULL,NULL),(503,'Order Status','MODULE_PAYMENT_INVOICE_ORDER_STATUS_ID','1','Festlegung des Status für Bestellungen, welche mit dieser Zahlungsweise durchgeführt werden.',6,0,NULL,'2008-06-27 14:13:16','tep_get_order_status_name','tep_cfg_pull_down_order_statuses('),(502,'Reihenfolge der Anzeige','MODULE_PAYMENT_INVOICE_SORT_ORDER','0','Niedrigste wird zuerst angezeigt.',6,0,NULL,'2008-06-27 14:13:16',NULL,NULL),(495,'Enable Check/Money Order Module','MODULE_PAYMENT_MONEYORDER_STATUS','True','Do you want to accept Check/Money Order payments?',6,1,NULL,'2008-06-27 14:08:07',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(436,'TinyMCE Advanced Image Manager','TINYMCE_IMAGEMANAGER_ENABLED','true','If you want to enable the image manager you need to <a href=\"http://tinymce.moxiecode.com/paypal/item_imagemanager.php\" target=\"_blank\" class=\"underline\">purchase a license</a>!',17,2,'2007-12-28 20:32:42','2007-12-28 20:20:39',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(84,'Default Currency','DEFAULT_CURRENCY','CHF','Default Currency',6,0,NULL,'2007-06-12 22:50:01',NULL,NULL),(85,'Default Language','DEFAULT_LANGUAGE','en','Default Language',6,0,NULL,'2007-06-12 22:50:01',NULL,NULL),(86,'Default Order Status For New Orders','DEFAULT_ORDERS_STATUS_ID','1','When a new order is created, this order status will be assigned to it.',6,0,NULL,'2007-06-12 22:50:01',NULL,NULL),(87,'Display Shipping','MODULE_ORDER_TOTAL_SHIPPING_STATUS','true','Do you want to display the order shipping cost?',6,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(88,'Sort Order','MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER','2','Sort order of display.',6,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(89,'Allow Free Shipping','MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING','false','Do you want to allow free shipping?',6,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(90,'Free Shipping For Orders Over','MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER','50','Provide free shipping for orders over the set amount.',6,4,NULL,'2007-06-12 22:50:01','currencies->format',NULL),(91,'Provide Free Shipping For Orders Made','MODULE_ORDER_TOTAL_SHIPPING_DESTINATION','national','Provide free shipping for orders sent to the set destination.',6,5,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'national\', \'international\', \'both\'),'),(92,'Display Sub-Total','MODULE_ORDER_TOTAL_SUBTOTAL_STATUS','true','Do you want to display the order sub-total cost?',6,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(93,'Sort Order','MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER','1','Sort order of display.',6,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(94,'Display Tax','MODULE_ORDER_TOTAL_TAX_STATUS','true','Do you want to display the order tax value?',6,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(95,'Sort Order','MODULE_ORDER_TOTAL_TAX_SORT_ORDER','3','Sort order of display.',6,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(96,'Display Total','MODULE_ORDER_TOTAL_TOTAL_STATUS','true','Do you want to display the total order value?',6,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(97,'Sort Order','MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER','5','Sort order of display.',6,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(98,'Country of Origin','SHIPPING_ORIGIN_COUNTRY','204','Select the country of origin to be used in shipping quotes.',7,1,'2007-08-07 22:06:02','2007-06-12 22:50:01','tep_get_country_name','tep_cfg_pull_down_country_list('),(99,'Postal Code','SHIPPING_ORIGIN_ZIP','8049','Enter the Postal Code (ZIP) of the Store to be used in shipping quotes.',7,2,'2007-08-07 22:06:07','2007-06-12 22:50:01',NULL,NULL),(100,'Enter the Maximum Package Weight you will ship','SHIPPING_MAX_WEIGHT','30','Carriers have a max weight limit for a single package. This is a common one for all.',7,3,'2007-08-07 22:06:20','2007-06-12 22:50:01',NULL,NULL),(101,'Package Tare weight.','SHIPPING_BOX_WEIGHT','0','What is the weight of typical packaging of small to medium packages?',7,4,'2007-08-07 22:05:49','2007-06-12 22:50:01',NULL,NULL),(102,'Larger packages - percentage increase.','SHIPPING_BOX_PADDING','0','For 10% enter 10',7,5,'2007-08-07 22:05:53','2007-06-12 22:50:01',NULL,NULL),(103,'Display Product Image','PRODUCT_LIST_IMAGE','1','Do you want to display the Product Image?',8,1,NULL,'2007-06-12 22:50:01',NULL,NULL),(104,'Display Product Manufaturer Name','PRODUCT_LIST_MANUFACTURER','0','Do you want to display the Product Manufacturer Name?',8,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(105,'Display Product Model','PRODUCT_LIST_MODEL','0','Do you want to display the Product Model?',8,3,NULL,'2007-06-12 22:50:01',NULL,NULL),(106,'Display Product Name','PRODUCT_LIST_NAME','2','Do you want to display the Product Name?',8,4,NULL,'2007-06-12 22:50:01',NULL,NULL),(107,'Display Product Price','PRODUCT_LIST_PRICE','3','Do you want to display the Product Price',8,5,NULL,'2007-06-12 22:50:01',NULL,NULL),(108,'Display Product Quantity','PRODUCT_LIST_QUANTITY','0','Do you want to display the Product Quantity?',8,6,NULL,'2007-06-12 22:50:01',NULL,NULL),(109,'Display Product Weight','PRODUCT_LIST_WEIGHT','0','Do you want to display the Product Weight?',8,7,NULL,'2007-06-12 22:50:01',NULL,NULL),(110,'Display Buy Now column','PRODUCT_LIST_BUY_NOW','4','Do you want to display the Buy Now column?',8,8,NULL,'2007-06-12 22:50:01',NULL,NULL),(111,'Display Category/Manufacturer Filter (0=disable; 1=enable)','PRODUCT_LIST_FILTER','1','Do you want to display the Category/Manufacturer Filter?',8,9,NULL,'2007-06-12 22:50:01',NULL,NULL),(112,'Location of Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)','PREV_NEXT_BAR_LOCATION','2','Sets the location of the Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)',8,10,NULL,'2007-06-12 22:50:01',NULL,NULL),(113,'Check stock level','STOCK_CHECK','false','Check to see if sufficent stock is available',9,1,'2008-03-25 22:44:06','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(114,'Subtract stock','STOCK_LIMITED','true','Subtract product in stock by product orders',9,2,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(115,'Allow Checkout','STOCK_ALLOW_CHECKOUT','true','Allow customer to checkout even if there is insufficient stock',9,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(116,'Mark product out of stock','STOCK_MARK_PRODUCT_OUT_OF_STOCK','***','Display something on screen so customer can see which product has insufficient stock',9,4,NULL,'2007-06-12 22:50:01',NULL,NULL),(117,'Stock Re-order level','STOCK_REORDER_LEVEL','5','Define when stock needs to be re-ordered',9,5,NULL,'2007-06-12 22:50:01',NULL,NULL),(118,'Store Page Parse Time','STORE_PAGE_PARSE_TIME','false','Store the time it takes to parse a page',10,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(119,'Log Destination','STORE_PAGE_PARSE_TIME_LOG','/var/log/www/tep/page_parse_time.log','Directory and filename of the page parse time log',10,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(120,'Log Date Format','STORE_PARSE_DATE_TIME_FORMAT','%d/%m/%Y %H:%M:%S','The date format',10,3,NULL,'2007-06-12 22:50:01',NULL,NULL),(121,'Display The Page Parse Time','DISPLAY_PAGE_PARSE_TIME','true','Display the page parse time (store page parse time must be enabled)',10,4,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(122,'Store Database Queries','STORE_DB_TRANSACTIONS','false','Store the database queries in the page parse time log (PHP4 only)',10,5,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(123,'Use Cache','USE_CACHE','false','Use caching features',11,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(124,'Cache Directory','DIR_FS_CACHE','/tmp/','The directory where the cached files are saved',11,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(125,'E-Mail Transport Method','EMAIL_TRANSPORT','sendmail','Defines if this server uses a local connection to sendmail or uses an SMTP connection via TCP/IP. Servers running on Windows and MacOS should change this setting to SMTP.',12,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'sendmail\', \'smtp\'),'),(126,'E-Mail Linefeeds','EMAIL_LINEFEED','LF','Defines the character sequence used to separate mail headers.',12,2,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'LF\', \'CRLF\'),'),(127,'Use MIME HTML When Sending Emails','EMAIL_USE_HTML','false','Send e-mails in HTML format',12,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(128,'Verify E-Mail Addresses Through DNS','ENTRY_EMAIL_ADDRESS_CHECK','false','Verify e-mail address through a DNS server',12,4,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(129,'Send E-Mails','SEND_EMAILS','true','Send out e-mails',12,5,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(130,'Enable download','DOWNLOAD_ENABLED','false','Enable the products download functions.',13,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(131,'Download by redirect','DOWNLOAD_BY_REDIRECT','false','Use browser redirection for download. Disable on non-Unix systems.',13,2,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(132,'Expiry delay (days)','DOWNLOAD_MAX_DAYS','7','Set number of days before the download link expires. 0 means no limit.',13,3,NULL,'2007-06-12 22:50:01',NULL,''),(133,'Maximum number of downloads','DOWNLOAD_MAX_COUNT','5','Set the maximum number of downloads. 0 means no download authorized.',13,4,NULL,'2007-06-12 22:50:01',NULL,''),(134,'Enable GZip Compression','GZIP_COMPRESSION','false','Enable HTTP GZip compression.',14,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(135,'Compression Level','GZIP_LEVEL','5','Use this compression level 0-9 (0 = minimum, 9 = maximum).',14,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(136,'Session Directory','SESSION_WRITE_DIRECTORY','/tmp','If sessions are file based, store them in this directory.',15,1,'2008-03-20 00:08:06','2007-06-12 22:50:01',NULL,NULL),(137,'Force Cookie Use','SESSION_FORCE_COOKIE_USE','False','Force the use of sessions when cookies are only enabled.',15,2,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(138,'Check SSL Session ID','SESSION_CHECK_SSL_SESSION_ID','False','Validate the SSL_SESSION_ID on every secure HTTPS page request.',15,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(139,'Check User Agent','SESSION_CHECK_USER_AGENT','False','Validate the clients browser user agent on every page request.',15,4,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(140,'Check IP Address','SESSION_CHECK_IP_ADDRESS','False','Validate the clients IP address on every page request.',15,5,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(141,'Prevent Spider Sessions','SESSION_BLOCK_SPIDERS','True','Prevent known spiders from starting a session.',15,6,'2007-11-27 19:38:31','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(142,'Recreate Session','SESSION_RECREATE','False','Recreate the session to generate a new session ID when the customer logs on or creates an account (PHP >=4.1 needed).',15,7,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(617,'Select caching system.','SEO_URLS_CACHE_SYSTEM','FileSystem','Filesystem:<br>Zero queries after cache load.<br>Database:<br>One query after cache load<br>Memcached:<br>Requires memcached in apache and php.ini.',335,99,'2010-04-13 23:29:59','2010-04-13 23:29:59','','tep_cfg_select_option(array(\'FileSystem\', \'Database\', \'Memcached\'), '),(615,'Reset SEO URLs Cache','SEO_URLS_CACHE_RESET','false','This will reset the cache data for SEO',335,99,'2010-04-13 23:40:39','2010-04-13 23:29:59','tep_reset_cache_data_seo_urls','tep_cfg_select_option(array(\'reset\', \'false\'), '),(616,'Turn degug reporting on/off.','SEO_URLS_OUPUT_PERFORMANCE','false','<span style=\"color: red;\">Debug reporting should <b>NOT</b> be set to ON on a live site</span><br>It is for dev reporting re: performance and queries.\"',335,99,'2010-04-13 23:29:59','2010-04-13 23:29:59','','tep_cfg_select_option(array(\'true\', \'false\'), '),(612,'Enter special character conversions','SEO_CHAR_CONVERT_SET','','This setting will convert characters.<br><br>The format <b>MUST</b> be in the form: <b>char=>conv,char2=>conv2</b>',335,99,'2010-04-13 23:39:10','2010-04-13 23:29:59','',''),(613,'Remove all non-alphanumeric characters?','SEO_REMOVE_ALL_SPEC_CHARS','false','This will remove all non-letters and non-numbers.  This should be handy to remove all special characters with 1 setting.',335,99,'2010-04-13 23:29:59','2010-04-13 23:29:59','','tep_cfg_select_option(array(\'true\', \'false\'), '),(614,'Set the number of days to store the cache.','SEO_URLS_CACHE_DAYS','7','Set the number of days you wish to retain cached data, after this the cache will auto reset.',335,99,'2010-04-13 23:29:59','2010-04-13 23:29:59','',''),(608,'Add category parent to beginning of URLs?','SEO_ADD_CAT_PARENT','true','This setting will add the category parent name to the beginning of the category URLs (i.e. - parent-category-c-1.html).',335,99,'2010-04-13 23:29:59','2010-04-13 23:29:59','','tep_cfg_select_option(array(\'true\', \'false\'), '),(609,'Filter Short Words','SEO_URLS_FILTER_SHORT_WORDS','3','This setting will filter words less than or equal to the value from the URL.',335,99,'2010-04-13 23:29:59','2010-04-13 23:29:59','',''),(610,'Output W3C valid URLs?','SEO_URLS_USE_W3C_VALID','true','This setting will output W3C valid URLs.',335,99,'2010-04-13 23:29:59','2010-04-13 23:29:59','','tep_cfg_select_option(array(\'true\', \'false\'), '),(611,'Choose URL Rewrite Type','SEO_URLS_TYPE','rewrite','Choose SEO URL format:<br><b>rewrite</b><br>mysite.com/great-product-p-3.html<br><b>standard</b><br>mysite.com/product_info.php/great-product-p-3<p><i>Note: mod_rewrite has to be enabled for the rewrite option and AllowOveride set to all.</i></p>',335,99,'2010-04-13 23:32:04','2010-04-13 23:29:59','','tep_cfg_select_option(array(\'rewrite\', \'standard\'), '),(606,'Enable SEO URLs?','SEO_URLS_ENABLED','true','Turn Seo Urls on',335,99,'2010-04-13 23:31:45','2010-04-13 23:29:59','','tep_cfg_select_option(array(\'true\', \'false\'), '),(607,'Add cPath to product URLs?','SEO_ADD_CPATH_TO_PRODUCT_URLS','false','This setting will append the cPath to the end of product URLs (i.e. - some-product-p-1.html?cPath=xx).',335,99,'2010-04-13 23:29:59','2010-04-13 23:29:59','','tep_cfg_select_option(array(\'true\', \'false\'), '),(160,'Installed Modules','MODULE_STS_INSTALLED','sts_default.php;sts_product_info.php','This is automatically updated. No need to edit.',6,0,'2007-11-07 21:06:16','2007-06-13 16:11:39',NULL,NULL),(169,'Code for debug output','MODULE_STS_DEBUG_CODE','debug','Code to enable debug output from URL (ex: index.php?sts_debug=debug',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL),(170,'Files for normal template','MODULE_STS_DEFAULT_NORMAL','sts_user_code.php;headertags.php','Files to include for a normal template, separated by semicolon',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL),(171,'Base folder','MODULE_STS_TEMPLATES_FOLDER','includes/sts_templates/','Base folder where the templates folders are located. Relative to your catalog folder. Should end with a slash',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL),(172,'Template folder','MODULE_STS_TEMPLATE_FOLDER','swisscart2008','This is the template folder in use, located inside the previous parameter. Do not start nor end with a slash',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL),(173,'Default template file','MODULE_STS_TEMPLATE_FILE','sts_template.html','Name of the default template file',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL),(174,'Use template for infoboxes','MODULE_STS_INFOBOX_STATUS','true','Do you want to use templates for infoboxes?',6,1,NULL,'2007-06-13 16:12:04',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(168,'Use Templates?','MODULE_STS_DEFAULT_STATUS','true','Do you want to use Simple Template System?',6,1,NULL,'2007-06-13 16:12:04',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(185,'Use template for product info page','MODULE_STS_PRODUCT_INFO_STATUS','false','Do you want to use templates for product info pages?',6,1,NULL,'2007-07-07 03:33:35',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(189,'Lightbox Popup Images','LIGHTBOX_ENABLE','true','Lightbox is a simple, unobtrusive script used to overlay images on the product detail page.',4,10,'2007-12-11 02:20:47','2007-07-07 03:59:26',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(188,'Files for content template','MODULE_STS_PRODUCT_INFO_CONTENT','sts_user_code.php;product_info.php;headertags.php','Files to include for a content template, separated by semicolon',6,3,NULL,'2007-07-07 03:33:35',NULL,NULL),(186,'Enable STS3 compatibility mode','MODULE_STS_PRODUCT_V3COMPAT','false','Do you want to enable the STS v3 compatibility mode (only for product info templates made with STS v2 and v3)?',6,1,NULL,'2007-07-07 03:33:35',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(187,'Files for normal template','MODULE_STS_PRODUCT_INFO_NORMAL','sts_user_code.php;headertags.php','Files to include for a normal template, separated by semicolon',6,2,NULL,'2007-07-07 03:33:35',NULL,NULL),(190,'Info-Seiten-ID der AGBs','CONDITIONS_INFOID','7','Setzen Sie hier die Seiten-ID der Allgemeinen Gesch?ftsbedingungen im Info-Manager ein. Der Text wird dann im Checkout automatisch eingebunden.',1,30,NULL,'2007-07-28 06:07:18',NULL,NULL),(191,'Product Information Image Width','PRODUCT_INFO_IMAGE_WIDTH','350','The pixel width of images shown on your product information page',4,100,'2007-11-05 04:51:30','2005-01-06 20:24:30',NULL,''),(192,'Product Information Image Height','PRODUCT_INFO_IMAGE_HEIGHT','','The pixel height of images shown on your product information page',4,101,'2007-08-01 22:33:11','2005-01-06 20:24:30',NULL,''),(193,'Image Magic Master Switch','CFG_MASTER_SWITCH','On','Switch OSC Image Magic on or off',333,3,'2007-08-01 19:15:53','2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'On\', \'Off\'),'),(194,'Apply security features to registered customers','CFG_REGISTERED_WATERMARKS','Yes','If this option is set to no, all image security features will be disabled when a registered customer is browsing your site',333,4,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(440,'Anzeige der empfohlenen Produkte','FEATURED_PRODUCTS_DISPLAY','true','Sollen \"Empfohlene Produkte\" angezeigt werden?',17,50,'2008-03-12 11:47:10','2008-03-12 11:47:10',NULL,NULL),(441,'Featured Products Module','MAX_DISPLAY_FEATURED_PRODUCTS','6','Das ist die maximal sichtbare Anzahl der empfohlenen Produkte.',3,51,'2008-03-12 11:49:15','2008-03-12 11:49:15',NULL,NULL),(196,'Process Store\'s Graphics','CFG_PROCESS_GRAPHICS','False','If this is set to true, ALL store graphics will be processed and cached, including buttons, clip art etc. The default, recommended setting for this is False',333,6,'2008-01-23 22:45:43','2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(197,'Auto Clean Cache','CFG_CACHE_AUTO_CLEAN','True','If selected, the cache will automatically be cleared of un-needed items. Set to true if you want to sacrifice a small amount of performance for server disk space saving',333,9,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(198,'Encrypt Image Filenames','CFG_ENCRYPT_FILENAMES','False','If you select this option all of your filenames will be encrypted. This option will prevent visitors from discovering your image filenames. Use it in combination with image watermarking to prevent theft of your images.',333,12,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(199,'Filename Encryption Key','CFG_ENCRYPTION_KEY','changeme','If you have switched on image filename encryption, then enter a string here to be used as the encryption key',333,15,NULL,'2005-01-06 20:24:30',NULL,''),(200,'Apply Internet Explorer PNG Transparency work-around?','CFG_PNG_BUG','False','This option will switch on a work-around so that PNG alpha transparency images will display correctly in Internet Explorer<br><b>Note:</b> Two files need to be modified to enable this - See readme.',333,18,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(201,'Use Resampling','CFG_USE_RESAMPLING','True','If selected, thumbnails will be resampled rather than resized. Resampling creates much higher quality thumbnails.',333,21,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(202,'Create Truecolour Thumbnails','CFG_CREATE_TRUECOLOR','True','Create True color Thumbnails? Better quality overall but set to false if you have GD version < 2.01 or if creating transparent thumbnails.',333,24,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(203,'Output GIFs as JPEGs','CFG_GIFS_AS_JPEGS','False','Set this option true if you have GD version > 1.6 and want to output GIFs as JPGs. Note that transparencies will not be retained (set matte colour below). If you have GD Library < 1.6 with GIF create support, GIFs will be output as GIFs.',333,27,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(204,'\'GIF as JPEG\' Matte colour (HEX)','CFG_MATTE_COLOR','FFFFFF','Enter the HEX colour value that transparent backgrounds will be converted to if GIFs output as JPGs',333,28,NULL,'2005-01-06 20:24:30',NULL,''),(205,'Cache Thumbnails on the Server','CFG_TN_SERVER_CACHE','True','Set to true if you want to cache previously processed thumbnails on disk. This will add to disk space but will save your processor from having to create a new thumbnail for every visitor. (recommended)',333,30,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(206,'Cache Thumbnails in user\'s browser','CFG_TN_BROWSER_CACHE','True','Set to true if you want browsers to be able to cache viewed thumbnails in their own cache. This will save bandwidth for every visitor that views the same thumbnail again. (recommended)',333,31,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(207,'Thumbnail Cache directory','CFG_TN_CACHE_DIRECTORY','images/thumbnails','Directory where cached thumbnails will be stored. <br><b>Note:</b> This directory should be automatically created, if not, do so manually and chmod it to 777',333,33,'2007-08-01 18:38:19','2005-01-06 20:24:30',NULL,''),(208,'Use 404 Response if image not found?','CFG_USE_404','True','If set to true a 404 (not found) response will be sent (broken image), otherwise a small error picture will be shown',333,36,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(209,'Allow thumbnails larger than original','CFG_ALLOW_LARGER','False','Set to true if you want to allow scaling UP of source image files.',333,45,'2008-01-23 23:20:20','2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(210,'Center if thumbnail larger than original','CFG_CENTER_THUMB','False','If your source is smaller than the thumbnail, should it be centered on the larger thumbnail rather than resized?<br><b>Note:</b> \'Allow thumbnails larger than original\' (above) must be set to true',333,46,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(211,'JPEG Quality - Pop-up Images','POPUP_JPEG_QUALITY','100','The output quality of JPEG pop-up images.',333,48,NULL,'2005-01-06 20:24:30',NULL,NULL),(212,'JPEG Quality - Product Information Thumbnails','PRODUCT_JPEG_QUALITY','100','The output quality of JPEG thumbnails displayed on your product information page',333,51,NULL,'2005-01-06 20:24:30',NULL,NULL),(213,'JPEG Quality - Category Thumbnails','CATEGORY_JPEG_QUALITY','100','The output quality of category JPEG thumbnails',333,52,NULL,'2005-01-06 20:24:30',NULL,NULL),(214,'JPEG Quality - Heading Thumbnails','HEADING_JPEG_QUALITY','100','The output quality of heading JPEG thumbnails',333,53,NULL,'2005-01-06 20:24:30',NULL,NULL),(215,'JPEG Quality - Small Thumbnails','SMALL_JPEG_QUALITY','100','The output quality of your small sized JPEG thumbnails',333,55,NULL,'2005-01-06 20:24:30',NULL,NULL),(216,'Graphic Watermark in Pop-up Images','USE_WATERMARK_IMAGE_POPUP','No','Do you wish to use a watermark image in your pop-up product image?<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images',333,57,'2007-08-01 19:43:12','2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(217,'Graphic Watermark in Product Information Thumbnails','USE_WATERMARK_IMAGE_PRODUCT','No','Do you wish to use a watermark image in your product information thumbnails?<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images',333,58,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(218,'Graphic Watermark in Category Thumbnails','USE_WATERMARK_IMAGE_CATEGORY','No','Do you wish to use a watermark image in your category thumbnails?<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images',333,59,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(219,'Graphic Watermark in Heading Thumbnails','USE_WATERMARK_IMAGE_HEADING','Yes','Do you wish to use a watermark image in your heading thumbnails?<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images',333,60,'2008-05-14 07:45:10','2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(220,'Graphic Watermark in Small Thumbnails','USE_WATERMARK_IMAGE_SMALL','No','Do you wish to use a watermark image in your small thumbnails<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images?',333,61,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(221,'Watermark Image File','WATERMARK_IMAGE','logo.png','Select which watermark image you wish to use<br><br>New watermark images may be installed in your:<br><b>/catalog/includes/imagemagic/watermarks/</b><br>directory<br>',333,66,'2007-08-01 19:41:04','2005-01-06 20:24:30',NULL,'tep_cfg_pull_down_installed_watermarks('),(222,'Image Watermark Transparency','WATERMARK_IMAGE_OPACITY','80','Enter a value of 0 to 100 to set the opacity value of your watermark image (0=transparent, 100=opaque)',333,69,'2007-12-11 03:58:22','2005-01-06 20:24:30',NULL,''),(223,'Image Watermark Position','WATERMARK_IMAGE_POSITION','Top','Select where you would like your watermark image to be positioned on your thumbnail',333,71,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_pull_down_watermark_alignment('),(224,'Image Watermark Margin','WATERMARK_IMAGE_MARGIN','0','Enter the offset in pixels where you would like your watermark image to be positioned',333,72,NULL,'2005-01-06 20:24:30',NULL,''),(225,'Resize Watermark Image','CFG_RESIZE_WATERMARK','True','If selected, your watermark image will be resized in the same ratio as your source image, otherwise the watermark image will always be added full-sized',333,73,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(226,'Text Watermark in Pop-up Images','USE_WATERMARK_TEXT_POPUP','Yes','Do you wish to use watermark text in your pop-up product images?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,75,'2007-08-01 19:36:36','2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(227,'Text Watermark in Product Information Thumbnails','USE_WATERMARK_TEXT_PRODUCT','No','Do you wish to use watermark text in your product information thumbnails?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,76,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(228,'Text Watermark in Category Thumbnails','USE_WATERMARK_TEXT_CATEGORY','No','Do you wish to use watermark text in your category thumbnails?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,77,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(229,'Text Watermark in Heading Thumbnails','USE_WATERMARK_TEXT_HEADING','No','Do you wish to use watermark text in your heading thumbnails?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,78,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(230,'Text Watermark in Small Thumbnails','USE_WATERMARK_TEXT_SMALL','No','Do you wish to use watermark text in your small thumbnails?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,79,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(231,'Watermark Text','WATERMARK_TEXT','SWISSCART','Enter the text you wish to appear in your thumbnails as a watermark',333,84,'2007-12-11 04:07:40','2005-01-06 20:24:30',NULL,''),(232,'Text Watermark Font Name','WATERMARK_TEXT_FONT','arial.ttf','Select the font filename you wish to use for watermark text<br><br>New TTF fonts may be installed in your:<br><b>/catalog/includes/imagemagic/fonts/</b><br>directory<br>',333,87,'2007-12-11 04:05:55','2005-01-06 20:24:30',NULL,'tep_cfg_pull_down_installed_fonts('),(233,'Text Watermark Size','WATERMARK_TEXT_SIZE','30','Enter the font point size of your text watermark',333,90,'2007-12-11 04:07:02','2005-01-06 20:24:30',NULL,''),(234,'Text Watermark Colour (HEX)','WATERMARK_TEXT_COLOR','000000','Enter the hex value for the colour of your text watermark',333,93,NULL,'2005-01-06 20:24:30',NULL,''),(235,'Text Watermark Transparency','WATERMARK_TEXT_OPACITY','7','Enter a value of 0 to 100 to set the transparency value of your watermark text (0=transparent, 100=opaque)',333,96,'2007-12-11 04:07:12','2005-01-06 20:24:30',NULL,''),(236,'Text Watermark Position','WATERMARK_TEXT_POSITION','Bottom Left','Select where you would like your watermark text to be positioned on your thumbnails',333,99,'2007-12-11 04:05:29','2005-01-06 20:24:30',NULL,'tep_cfg_pull_down_watermark_alignment('),(237,'Text Watermark Margin','WATERMARK_TEXT_MARGIN','0','Enter the offset in pixels where you would like your watermark text to be positioned',333,102,NULL,'2005-01-06 20:24:30',NULL,''),(238,'Text Watermark Angle','WATERMARK_TEXT_ANGLE','90','Enter the counter-clockwise angle of the text watermark',333,105,'2007-12-11 04:04:54','2005-01-06 20:24:30',NULL,''),(239,'Auto Adjust Brightness','BRIGHTNESS_ADJUST','0','Enter an amount between -255 and 255 which your thumbnail brightness will be adjusted by<br><b>Note:</b> This will not work with GIF images',333,108,NULL,'2005-01-06 20:24:30',NULL,''),(240,'Auto Adjust Contrast','CONTRAST_ADJUST','0','Enter an amount between -255 and 255 which your thumbnail contrast will be adjusted by<br><b>Note:</b> This will not work with GIF images',333,111,NULL,'2005-01-06 20:24:30',NULL,''),(241,'Frame Pop-up Images','FRAME_POPUP','No','Do you want to include a frame around your pop-up product images?',333,114,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(242,'Frame Product Information Thumbnails','FRAME_PRODUCT','No','Do you want to include a frame around your product information thumbnails?',333,115,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(243,'Frame Category Thumbnails','FRAME_CATEGORY','No','Do you want to include a frame around your category thumbnails?',333,116,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(244,'Frame Heading Thumbnails','FRAME_HEADING','No','Do you want to include a frame around your heading thumbnails?',333,117,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(245,'Frame Small Thumbnails','FRAME_SMALL','No','Do you want to include a frame around your small thumbnails?',333,118,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(246,'Frame Width','FRAME_WIDTH','4','Enter the width in pixels of the thumbnail frame',333,120,NULL,'2005-01-06 20:24:30',NULL,''),(247,'Frame Depth','FRAME_EDGE_WIDTH','4','Enter the 3D depth of the frame in pixels',333,123,NULL,'2005-01-06 20:24:30',NULL,''),(248,'Frame Colour (HEX)','FRAME_COLOR','CCCCCC','Enter the HEX colour of the thumbnail frame',333,126,NULL,'2005-01-06 20:24:30',NULL,''),(249,'Frame Inside 3D Highlight Colour (HEX)','FRAME_INSIDE_COLOR1','FFFFFF','Enter the colour (in hex) you wish the frame\'s inside higlight colour to be',333,129,NULL,'2005-01-06 20:24:30',NULL,''),(250,'Frame Inside 3D Shadow Colour (HEX)','FRAME_INSIDE_COLOR2','000000','Enter the colour (in hex) you wish the frame\'s inside shadow colour to be',333,132,NULL,'2005-01-06 20:24:30',NULL,''),(251,'Buttonize Pop-up Images','BEVEL_POPUP','No','Do you want to add a 3D button effect to your pop-up images?',333,133,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(252,'Buttonize Product Information Thumbnails','BEVEL_PRODUCT','No','Do you want to add a 3D button effect to your product information thumbnails?',333,134,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(253,'Buttonize Category Thumbnails','BEVEL_CATEGORY','No','Do you want to add a 3D button effect to your category thumbnails?',333,135,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(254,'Buttonize Heading Thumbnails','BEVEL_HEADING','No','Do you want to add a 3D button effect to your heading thumbnails?',333,136,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(255,'Buttonize Small Thumbnails','BEVEL_SMALL','No','Do you want to add a 3D button effect to your small thumbnails?',333,137,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(256,'Button Height','BEVEL_HEIGHT','4','Enter the height in pixels of the 3D button effect',333,144,NULL,'2005-01-06 20:24:30',NULL,''),(257,'Button Highlight Colour (HEX)','BEVEL_HIGHLIGHT','CCCCCC','Enter the colour (in hex) you wish the button\'s higlight colour to be',333,147,NULL,'2005-01-06 20:24:30',NULL,''),(258,'Button Shadow Colour (HEX)','BEVEL_SHADOW','000000','Enter the colour (in hex) you wish the button\'s shadow colour to be',333,150,NULL,'2005-01-06 20:24:30',NULL,''),(259,'Last Hash (System Use - Read Only)','LAST_HASH','8b72fd33a0b752bf19fadad6d4d04305','Stores the last hash value of the thumbnail configuration settings.  This will allow the script to detect when they have changed and maintain the cache.',333,153,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_readonly('),(412,'TinyMCE Theme (Display Mode)','TINYMCE_THEME','advanced','Simple will only give a couple of features for the text area fields, advanced will give a whole lot more of them, but will also take longer to load',17,1,'2007-12-28 20:32:37','2007-08-09 19:02:22',NULL,'tep_cfg_select_option(array(\'simple\', \'advanced\'),'),(411,'Heading Image Enabled','HEADING_IMAGE_ENABLED','false','Show the small image on the top right of every shop page?',4,3,'2007-08-15 00:02:40','2007-08-14 23:45:44',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(604,'Tariftabelle für Zone 5 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_7','2:65,3:83,4:101,5:119,6:136,7:153,8:170,9:187,10:204,11:219,12:234,13:249,14:264,15:279,16:294,17:309,18:324,19:339,20:354,21:367,22:380,23:393,24:406,25:419,26:432,27:445,28:458,29:471,30:484','Tarif Tabelle für die Zone 5, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(603,'Tariftabelle für Zone 5 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_7','2:47,3:55,4:63,5:71,6:79,7:87,8:95,9:103,10:111,11:118,12:125,13:132,14:139,15:146,16:152,17:160,18:166,19:172,20:178,21:184,22:190,23:196,24:202,25:206,26:211,27:216,28:221,29:226,30:231','Tarif Tabelle für die Zone 5, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(602,'Tarifzone 5 Länder','MODULE_SHIPPING_CHP_COUNTRIES_7','AR,AW,AU,BO,BR,BN,CL,CO,CK,EC,FK,FJ,GF,PF,GY,ID,KI,NR,AN,NC,NZ,NF,PG,PY,PE,PH,PN,WS,SB,SR,TP,TO,TT,TV,UY,VU,VE,WF','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 5 sind.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(601,'Tariftabelle für Zone 4 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_6','0.5:83,1:96,1.5:108,2:121,2.5:133,3:145,3.5:158,4:170,4.5:182,5:195,6:214,7:234,8:253,9:273,10:293,11:311,12:330,13:348,14:367,15:385,16:404,17:422,18:441,19:459,20:478,21:495,22:513,23:530,24:548,25:565,26:583,27:600,28:618,29:636,30:653','Tarif Tabelle für die Zone 4, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(600,'Tariftabelle für Zone 4 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_6','2:53,3:67,4:80,5:94,6:107,7:120,8:133,9:146,10:159,11:167,12:177,13:187,14:197,15:207,16:215,17:223,18:231,19:239,20:247,21:255,22:263,23:271,24:279,25:287,26:295,27:303,28:311,29:319,30:327','Tarif Tabelle für die Zone 4, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(599,'Tariftabelle für Zone 4 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_6','2:43,3:50,4:57,5:64,6:71,7:78,8:85,9:92,10:99,11:104,12:109,13:114,14:119,15:124,16:129,17:134,18:139,19:144,20:149,21:153,22:157,23:161,24:165,25:169,26:173,27:177,28:181,29:185,30:189','Tarif Tabelle für die Zone 4, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(598,'Tarifzone 4 Länder','MODULE_SHIPPING_CHP_COUNTRIES_6','LR,MO,MG,MW,MY,MV,ML,MQ,MR,MU,YT,MX,MN,MS,MZ,MM,NA,NP,NI,NE,NG,OM,PK,PA,QA,RE,RW,KN,LC,VC,SH,ZM,SM,ST,SA,SN,SC,SL,SG,SO,ZA,LK,SD,SZ,TW,TJ,TZ,TH,TG,TM,TC,UG,AE,UZ,VN,VG,VI,ZW','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 4 sind.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(596,'Tariftabelle für Zone 4 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_5','2:53,3:67,4:80,5:94,6:107,7:120,8:133,9:146,10:159,11:167,12:177,13:187,14:197,15:207,16:215,17:223,18:231,19:239,20:247,21:255,22:263,23:271,24:279,25:287,26:295,27:303,28:311,29:319,30:327','Tarif Tabelle für die Zone 4, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(597,'Tariftabelle für Zone 4 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_5','0.5:83,1:96,1.5:108,2:121,2.5:133,3:145,3.5:158,4:170,4.5:182,5:195,6:214,7:234,8:253,9:273,10:293,11:311,12:330,13:348,14:367,15:385,16:404,17:422,18:441,19:459,20:478,21:495,22:513,23:530,24:548,25:565,26:583,27:600,28:618,29:636,30:653','Tarif Tabelle für die Zone 4, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(595,'Tariftabelle für Zone 4 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_5','2:43,3:50,4:57,5:64,6:71,7:78,8:85,9:92,10:99,11:104,12:109,13:114,14:119,15:124,16:129,17:134,18:139,19:144,20:149,21:153,22:157,23:161,24:165,25:169,26:173,27:177,28:181,29:185,30:189','Tarif Tabelle für die Zone 4, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(594,'Tarifzone 4 Länder','MODULE_SHIPPING_CHP_COUNTRIES_5','AF,AO,AI,AG,AM,AZ,BS,BH,BD,BB,BZ,BJ,BM,BT,BW,BF,BI,KY,KH,CM,CV,CF,TD,CN,KM,CG,CR,CI,CU,DJ,DM,DO,SV,GQ,ER,ET,GA,GM,GE,GH,GD,GP,GT,GN,GW,HT,HN,HK,IN,IR,IQ,JM,JP,YE,KZ,KE,KP,KR,KW,KG,LA,LS','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 4 sind.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(593,'Tariftabelle für Zone 3 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_4','0.5:65,1:72,1.5:79,2:87,2.5:94,3:101,3.5:108,4:115,4.5:123,5:130,6:141,7:152,8:164,9:175,10:186,11:198,12:209,13:220,14:232,15:243,16:254,17:266,18:277,19:288,20:300,21:309,22:318,23:328,24:337,25:346,26:355,27:365,28:374,29:383,30:392','Tarif Tabelle für die Zone 3, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(592,'Tariftabelle für Zone 3 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_4','2:46,3:55,4:66,5:77,6:86,7:95,8:104,9:113,10:122,11:130,12:138,13:146,14:154,15:162,16:170,17:178,18:186,19:194,20:202,21:209,22:216,23:223,24:230,25:237,26:244,27:251,28:258,29:265,30:272','Tarif Tabelle für die Zone 3, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(591,'Tariftabelle für Zone 3 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_4','2:38,3:44,4:50,5:56,6:62,7:68,8:74,9:80,10:86,11:92,12:98,13:104,14:110,15:116,16:121,17:126,18:131,19:136,20:141,21:145,22:149,23:153,24:157,25:161,26:165,27:169,28:173,29:177,30:181','Tarif Tabelle für die Zone 3, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(590,'Tarifzone 3 Länder','MODULE_SHIPPING_CHP_COUNTRIES_4','DZ,BY,CA,CY,EG,IL,JO,LB,LY,MD,MA,RU,PM,SY,TN,TR,UA,US','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 3 sind.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(589,'Tariftabelle für Zone 2 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_3','0.5:57,1:63,1.5:68,2:73,2.5:78,3:84,3.5:90,4:95,4.5:100,5:106,6:114,7:124,8:132,9:141,10:149,11:158,12:165,13:172,14:180,15:187,16:196,17:203,18:210,19:218,20:226,21:234,22:241,23:248,24:256,25:264,26:272,27:279,28:286,29:295,30:302','Tarif Tabelle für die Zone 2, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(588,'Tariftabelle für Zone 2 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_3','2:38,3:43,4:48,5:53,6:58,7:62,8:66,9:68,10:71,11:75,12:78,13:81,14:84,15:87,16:90,17:91,18:92,19:93,20:94,21:95,22:96,23:97,24:98,25:99,26:100,27:101,28:102,29:103,30:104','Tarif Tabelle für die Zone 2, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(587,'Tariftabelle für Zone 2 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_3','2:34,3:38,4:42,5:46,6:49,7:52,8:55,9:58,10:61,11:63,12:65,13:67,14:69,15:71,16:72,17:73,18:74,19:75,20:76,21:77,22:78,23:79,24:80,25:81,26:82,27:83,28:84,29:85,30:86','Tarif Tabelle für die Zone 2, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(586,'Tarifzone 2 Länder','MODULE_SHIPPING_CHP_COUNTRIES_3','AL,BA,BG,HR,CZ,DK,EE,FI,GI,GR,HU,IS,IE,LV,LT,MK,MT,MH,NO,PL,PT,RO,SK,SI,ES,SE,GB,YU','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 2 sind.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(584,'Tariftabelle für Zone 1 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_2','2:41,5:51,10:59,15:70,20:75,25:74,30:86','Tarif Tabelle für die Zone 1, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(585,'Tariftabelle für Zone 1 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_2','0.5:65,1:72,1.5:77,2:82,2.5:88,3:94,3.5:102,4:109,4.5:116,5:123,6:129,7:134,8:140,9:146,10:152,11:160,12:168,13:177,14:185,15:193,16:202,17:210,18:219,19:228,20:236,21:245,22:253,23:263,24:271,25:279,26:288,27:297,28:306,29:315,30:324','Tarif Tabelle für die Zone 1, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(435,'Product description teaser length','PRODUCT_LIST_TEASER_LENGTH','100','Product description teaser length',8,31,'2007-12-28 18:36:07','2007-12-28 18:23:37',NULL,NULL),(433,'Store Logo','STORE_LOGO','swisscart.gif','Bitte laden Sie das Logo mit dem Datei-Manager (Hilfsprogramme) in den images-Ordner',1,2,NULL,'2007-12-13 16:56:51',NULL,NULL),(434,'Enable product description teaser','PRODUCT_LIST_TEASER_ENABLED','true','Show product description in product listing view',8,30,'2007-12-28 18:29:36','2007-12-28 18:20:37',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(564,'Mod','MODULE_PAYMENT_POSTFINANCE_MOD','1','Mod (1=TEST / ELSE=PRODUCTION)',6,1,NULL,'2009-06-11 14:43:30',NULL,'tep_cfg_select_option(array(\'1\', \'0\'), '),(565,'Debug E-Mail Address','MODULE_PAYMENT_POSTFINANCE_DEBUG_EMAIL','','',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(563,'Payment Zone','MODULE_PAYMENT_POSTFINANCE_ZONE','0','If a zone is selected, only enable this payment method for that zone.',6,2,NULL,'2009-06-11 14:43:30','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes('),(562,'State of order','MODULE_PAYMENT_POSTFINANCE_ORDER_STATUS_ID','0','Set the status of orders made with this payment module to this value.',6,0,NULL,'2009-06-11 14:43:30','tep_get_order_status_name','tep_cfg_pull_down_order_statuses('),(430,'Popup Image Height','POPUP_IMAGE_HEIGHT','','Maximum height of the popup image',4,201,'2007-12-11 03:55:22','2007-12-11 01:54:15',NULL,NULL),(429,'Popup Image Width','POPUP_IMAGE_WIDTH','700','Maximum width of the popup image',4,200,'2007-12-11 03:56:32','2007-12-11 01:53:39',NULL,NULL),(569,'Artikelnummer anzeigen?','DISPLAY_PRODUCTS_MODEL','true','Artikelnummer auf Produktdetailseite unter der Artikelbezeichnung anzeigen.',8,32,'2010-06-05 23:08:25','2008-04-04 00:00:00',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(568,'Reihenfolge','MODULE_ORDER_TOTAL_COUPON_SORT_ORDER','4','Reihenfolge der Anzeige<br><br><center><span style=\"border:1px solid #000;\">&nbsp; &copy; <a href=\"http://forums.oscommerce.de/index.php?showuser=36\" target=\"_blank\"><b>Ingo</b></a> &nbsp;</span></center>',6,0,NULL,'2009-07-28 17:49:32',NULL,NULL),(582,'Tarifzone 1 Länder','MODULE_SHIPPING_CHP_COUNTRIES_2','AD,AT,BE,FR,DE,VA,IT,LU,MC,NL','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 1 sind.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(583,'Tariftabelle für Zone 1 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_2','2:37,5:45,10:43,15:48,20:53,25:58,26:59,30:63','Tarif Tabelle für die Zone 1, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(581,'Tariftabelle für Zone 0 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_1','2:8.00,5:10.00,10:13.00,20:19.00,30:26.00','Tarif Tabelle für die Inlandszone, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(579,'Tarifzone 0 Länder','MODULE_SHIPPING_CHP_COUNTRIES_1','CH,LI','Inlandszone',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(580,'Tariftabelle für Zone 0 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_1','2:6.00,5:8.00,10:11.00,20:16.00,30:23.00','Tarif Tabelle für die Inlandszone, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(578,'Reihenfolge der Anzeige','MODULE_SHIPPING_CHP_SORT_ORDER','0','Niedrigste wird zuerst angezeigt.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(577,'Versand Zone','MODULE_SHIPPING_CHP_ZONE','0','Wenn Sie eine Zone auswählen, wird diese Versandart nur in dieser Zone angeboten.',6,0,NULL,'2010-04-01 12:40:24','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes('),(575,'Handling Fee','MODULE_SHIPPING_CHP_HANDLING','0','Bearbeitungsgebühr für diese Versandart in CHF',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(576,'Steuersatz','MODULE_SHIPPING_CHP_TAX_CLASS','0','Wählen Sie den MwSt.-Satz für diese Versandart aus.',6,0,NULL,'2010-04-01 12:40:24','tep_get_tax_class_title','tep_cfg_pull_down_tax_classes('),(574,'Schweizerische Post','MODULE_SHIPPING_CHP_STATUS','True','Wollen Sie den Versand über die schweizerische Post anbieten?',6,0,NULL,'2010-04-01 12:40:24',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(437,'E-Mail-Signatur','EMAIL_SIGNATURE','Mit freundlichen Grüssen\nNick Weisser\n\nOpenstream Internet Solutions\nZürich, Switzerland\n\nPhone  +41 44 500 78 78\nFax    +41 44 500 78 79\nSkype  nick.weisser\n\nhttp://www.swisscart.com','Diese Signatur wird an alle Mails angehängt, die vom System verschickt werden, d.h. Registrationsbestätigung, Bestellbestätigung, Statusänderungen, etc.',1,18,'2008-03-25 22:44:32','2008-01-18 20:55:19','','tep_cfg_textarea('),(438,'Einkaufen ohne Konto','PURCHASE_WITHOUT_ACCOUNT','ja','D&uuml;rfen Kunden ohne Konto einkaufen?',5,10,'2010-06-05 18:46:53','2008-01-23 02:22:22',NULL,'tep_cfg_select_option(array(\'ja\', \'nein\'),'),(439,'Einkaufen ohne Konto Versandadresse','PURCHASE_WITHOUT_ACCOUNT_SEPARATE_SHIPPING','ja','D&uuml;rfen Kunden ohne Konto eine separate Versandadresse anlegen?',5,11,NULL,'2008-01-23 02:22:22',NULL,'tep_cfg_select_option(array(\'ja\', \'nein\'),'),(442,'Enable Debugging','DEBUGGING_ENABLED','false','Will display the GLOBALS array at the bottom of the page',10,20,'2008-03-19 17:13:50','2008-03-14 00:00:00',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(443,'Product option type Select','PRODUCTS_OPTIONS_TYPE_SELECT','0','The number representing the Select type of product option.',6,NULL,'2008-04-02 16:55:06','2008-04-02 16:55:06',NULL,NULL),(444,'Text product option type','PRODUCTS_OPTIONS_TYPE_TEXT','1','Numeric value of the text product option type',6,NULL,'2008-04-02 16:55:06','2008-04-02 16:55:06',NULL,NULL),(445,'Radio button product option type','PRODUCTS_OPTIONS_TYPE_RADIO','2','Numeric value of the radio button product option type',6,NULL,'2008-04-02 16:55:06','2008-04-02 16:55:06',NULL,NULL),(446,'Check box product option type','PRODUCTS_OPTIONS_TYPE_CHECKBOX','3','Numeric value of the check box product option type',6,NULL,'2008-04-02 16:55:06','2008-04-02 16:55:06',NULL,NULL),(447,'Textarea option type','PRODUCTS_OPTIONS_TYPE_TEXTAREA','4','Numeric value of the textarea product option type',6,NULL,'2008-04-02 16:55:06','2008-04-02 16:55:06',NULL,NULL),(448,'File product option type','PRODUCTS_OPTIONS_TYPE_FILE','5','Numeric value of the file product option type',6,NULL,'2008-04-02 16:55:06','2008-04-02 16:55:06',NULL,NULL),(449,'ID for text and file oroducts options values','PRODUCTS_OPTIONS_VALUE_TEXT_ID','0','Numeric value of the products_options_values_id used by the text and file attributes.',6,NULL,'2008-04-02 16:55:06','2008-04-02 16:55:06',NULL,NULL),(450,'Upload prefix','UPLOAD_PREFIX','upload_','Prefix used to differentiate between upload options and other options',6,NULL,'2008-04-02 16:55:06','2008-04-02 16:55:06',NULL,NULL),(451,'Text prefix','TEXT_PREFIX','txt_','Prefix used to differentiate between text option values and other option values',6,NULL,'2008-04-02 16:55:06','2008-04-02 16:55:06',NULL,NULL),(552,'Accept Url','MODULE_PAYMENT_POSTFINANCE_ACCEPTURL','http://demo.swisscart.com/checkout_process.php','URL of the web page to display to the customer when the payment has been authorized or is waiting to be accepted.',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(553,'Decline Url','MODULE_PAYMENT_POSTFINANCE_DECLINEURL','http://demo.swisscart.com/checkout_process.php','URL of the web page to show the customer when the acquirer declines the authorization more than the maximum permissible number of times.',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(551,'Font family','MODULE_PAYMENT_POSTFINANCE_FONTTYPE','','Font family',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(549,'Button background color','MODULE_PAYMENT_POSTFINANCE_BUTTONBGCOLOR','','Button background color',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(550,'Button text color','MODULE_PAYMENT_POSTFINANCE_BUTTONTXTCOLOR','','Button text color',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(547,'Table background color','MODULE_PAYMENT_POSTFINANCE_TBLBGCOLOR','','Table background color',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(548,'Table text color','MODULE_PAYMENT_POSTFINANCE_TBLTXTCOLOR','','Table text color',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(545,'Background color','MODULE_PAYMENT_POSTFINANCE_BGCOLOR','','Background color',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(546,'Text color','MODULE_PAYMENT_POSTFINANCE_TXTCOLOR','','Text color',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(544,'Title and header of the page','MODULE_PAYMENT_POSTFINANCE_TITLE','','Title and header of the page.',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(543,'SHA-1 Signature','MODULE_PAYMENT_POSTFINANCE_SHA1_SIGNATURE','3DP6AmNaWu-3DP6AmNaWu','The additional string to use when building the SHA-1 signature of the transaction. (optional; 3.2)',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(542,'Merchant/User Password','MODULE_PAYMENT_POSTFINANCE_PASSWORD','','The password to use with the merchant or user ID when connecting to the gateway.',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(541,'User ID (optional)','MODULE_PAYMENT_POSTFINANCE_USER_ID','','The user ID to perform transactions under. (optional).',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(540,'Merchant ID (PSPID)','MODULE_PAYMENT_POSTFINANCE_MERCHANT_ID','openstreamDEMO','The merchant ID (PSPID) to connect to the gateway with.',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(539,'Activate PostFinance module','MODULE_PAYMENT_POSTFINANCE_STATUS','True','Do you wanna accept payments over Postcard?',6,1,NULL,'2009-06-11 14:43:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(468,'','PRODUCT_LIST_SORT_ORDER','6','',0,0,NULL,'2008-05-06 22:20:14',NULL,NULL),(561,'Set Preparing Order Status','MODULE_PAYMENT_POSTFINANCE_PREPARE_ORDER_STATUS_ID','5','Set the status of prepared orders made with this payment module to this value',6,0,NULL,'2009-06-11 14:43:30','tep_get_order_status_name','tep_cfg_pull_down_order_statuses('),(559,'Sort','MODULE_PAYMENT_POSTFINANCE_SORT_ORDER','0','Sort order of display. (Lowest is displayed first)',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(560,'Default Transaction Currency','MODULE_PAYMENT_POSTFINANCE_CURRENCY','CHF','The default currency to use for transactions (ex: CHF forces to use CHF for payment / empty if Navigation currency is udes)',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(558,'Logo URL','MODULE_PAYMENT_POSTFINANCE_LOGO','','URL/filename of the logo you want to display at the top of the payment page next to the title. The URL must be absolute (contain the full path),it cannot be relative.',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(557,'Home Url','MODULE_PAYMENT_POSTFINANCE_HOMEURL','http://demo.swisscart.com','Site home Url.',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(556,'Catalog Url','MODULE_PAYMENT_POSTFINANCE_CATALOGURL','http://demo.swisscart.com','Catalog Url.',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(555,'Cancel Url','MODULE_PAYMENT_POSTFINANCE_CANCELURL','http://demo.swisscart.com/checkout_process.php','URL of the web page to display to the customer when he cancels the payment.',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(501,'Zone für diese Zahlungsweise','MODULE_PAYMENT_INVOICE_ZONE','1','Wenn Sie eine Zone auswählen, wird diese Zahlungsweise nur in dieser Zone angeboten.',6,0,NULL,'2008-06-27 14:13:16','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes('),(499,'Set Order Status','MODULE_PAYMENT_MONEYORDER_ORDER_STATUS_ID','1','Set the status of orders made with this payment module to this value',6,0,NULL,'2008-06-27 14:08:07','tep_get_order_status_name','tep_cfg_pull_down_order_statuses('),(500,'Rechnung','MODULE_PAYMENT_INVOICE_STATUS','True','Wollen Sie Zahlungen per Rechnung anbieten?',6,0,NULL,'2008-06-27 14:13:16',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(496,'Make Payable to:','MODULE_PAYMENT_MONEYORDER_PAYTO','','Who should payments be made payable to?',6,1,NULL,'2008-06-27 14:08:07',NULL,NULL),(497,'Sort order of display.','MODULE_PAYMENT_MONEYORDER_SORT_ORDER','0','Sort order of display. Lowest is displayed first.',6,0,NULL,'2008-06-27 14:08:07',NULL,NULL),(498,'Payment Zone','MODULE_PAYMENT_MONEYORDER_ZONE','1','If a zone is selected, only enable this payment method for that zone.',6,2,NULL,'2008-06-27 14:08:07','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes('),(485,'Installed Modules','','','This is automatically updated. No need to edit.',6,0,NULL,'2008-06-27 14:00:03',NULL,NULL),(504,'Stammkunden','MODULE_PAYMENT_INVOICE_FROM_ORDER','3','Rechnung ab x-ter Bestellung möglich',6,0,NULL,'2008-06-27 14:13:16',NULL,NULL),(505,'Bankverbindung','BANKDETAILS','Kontoinhaber:\r\n  Openstream Internet Solutions\r\n  Wieslergasse 6\r\n  8049 Zürich\r\n\r\nFinanzinstitut:\r\n  UBS Zürich\r\n  Konto: 267 846.393.01P\r\n  Clearing 267\r\n\r\nIhre Bestellung wird versendet sobald wir Ihre Zahlung erhalten haben.','Bankverbindung für Vorauskasse Modul',1,18,'2008-11-06 10:19:38','2008-11-06 10:01:44','','tep_cfg_textarea('),(506,'Saferpay Modul aktivieren','MODULE_PAYMENT_SAFERPAYGW_STATUS','true','M&ouml;chten Sie Zahlungen per Saferpay akzeptieren?',6,1,NULL,'2009-05-12 11:40:58','tep_get_cfg_truefalse','tep_cfg_pull_down_truefalse('),(507,'Erlaubte Zonen','MODULE_PAYMENT_SAFERPAYGW_ALLOWED','','Geben Sie <b>einzeln</b> die Zonen an, welche f&uuml;r dieses Modul erlaubt sein sollen. (z.B. AT,DE (wenn leer, werden alle Zonen erlaubt))',6,0,NULL,'2009-05-12 11:40:58',NULL,NULL),(508,'Saferpay-Konto','MODULE_PAYMENT_SAFERPAYGW_ACCOUNT_ID','99867-94913159','ACCOUNTID des Saferpay Terminals',6,5,NULL,'2009-05-12 11:40:58',NULL,NULL),(509,'PayInit URL','MODULE_PAYMENT_SAFERPAYGW_PAYINIT_URL','https://www.saferpay.com/hosting/CreatePayInit.asp','URL für die Initialisierung der Zahlung',6,6,NULL,'2009-05-12 11:40:58',NULL,NULL),(510,'PayConfirm URL','MODULE_PAYMENT_SAFERPAYGW_CONFIRM_URL','https://www.saferpay.com/hosting/VerifyPayConfirm.asp','URL für die Bestätigung der Zahlung',6,7,NULL,'2009-05-12 11:40:58',NULL,NULL),(511,'PayComplete URL','MODULE_PAYMENT_SAFERPAYGW_COMPLETE_URL','https://www.saferpay.com/hosting/PayComplete.asp','URL für das Abschließen der Zahlung',6,8,NULL,'2009-05-12 11:40:58',NULL,NULL),(512,'Transaktion verbuchen','MODULE_PAYMENT_SAFERPAYGW_COMPLETE','false','Sofortige Verbuchung der Saferpay Transaktion',6,9,NULL,'2009-05-12 11:40:58','tep_get_cfg_truefalse','tep_cfg_pull_down_truefalse('),(513,'CVC Eingabe','MODULE_PAYMENT_SAFERPAYGW_CCCVC','true','Abfrage der Kartenprüfnummer',6,10,NULL,'2009-05-12 11:40:58','tep_get_cfg_truefalse','tep_cfg_pull_down_truefalse('),(514,'Karteninhaber','MODULE_PAYMENT_SAFERPAYGW_CCNAME','true','Abfrage des Karteninhabernamens',6,11,NULL,'2009-05-12 11:40:58','tep_get_cfg_truefalse','tep_cfg_pull_down_truefalse('),(515,'Transaktionswährung','MODULE_PAYMENT_SAFERPAYGW_CURRENCY','CHF','Währung für die Zahlungsanfragen',6,9,NULL,'2009-05-12 11:40:58','tep_get_currency_name','tep_cfg_pull_down_currencies('),(516,'<hr size=1><br>MENUCOLOR','MODULE_PAYMENT_SAFERPAYGW_MENUCOLOR','#93B1CF','Farbe inaktiver Reiter.&nbsp;<a href=\"images/saferpaygw_styling.jpg\" target=_blank><img src=\"images/icons/unknown.jpg\" width=\"15\" border=\"0\" alt=\"Hilfe\"></a>',6,10,NULL,'2009-05-12 11:40:58',NULL,NULL),(517,'MENUFONTCOLOR','MODULE_PAYMENT_SAFERPAYGW_MENUFONTCOLOR','#000000','Schriftfarbe des Menüs.',6,10,NULL,'2009-05-12 11:40:58',NULL,NULL),(518,'BODYFONTCOLOR','MODULE_PAYMENT_SAFERPAYGW_BODYFONTCOLOR','#000000','Schriftfarbe des Eingabebereichs.',6,10,NULL,'2009-05-12 11:40:58',NULL,NULL),(519,'BODYCOLOR','MODULE_PAYMENT_SAFERPAYGW_BODYCOLOR','#E5E7E8','Hintergrundfarbe des Saferpay VT.',6,10,NULL,'2009-05-12 11:40:58',NULL,NULL),(520,'HEADFONTCOLOR','MODULE_PAYMENT_SAFERPAYGW_HEADFONTCOLOR','#000000','Schriftfarbe der Reiter.',6,10,NULL,'2009-05-12 11:40:58',NULL,NULL),(521,'HEADCOLOR','MODULE_PAYMENT_SAFERPAYGW_HEADCOLOR','#134B83','Hintergrundfarbe des oberen Bereichs.',6,10,NULL,'2009-05-12 11:40:58',NULL,NULL),(522,'HEADLINECOLOR','MODULE_PAYMENT_SAFERPAYGW_HEADLINECOLOR','#93B1CF','Farbe der Trennlinie oben links.',6,10,NULL,'2009-05-12 11:40:58',NULL,NULL),(523,'LINKCOLOR','MODULE_PAYMENT_SAFERPAYGW_LINKCOLOR','#134B83','Schriftfarbe der Links.',6,10,NULL,'2009-05-12 11:40:58',NULL,NULL),(524,'Anzeigereihenfolge','MODULE_PAYMENT_SAFERPAYGW_SORT_ORDER','0','Reihenfolge der Anzeige. Kleinste Ziffer wird zuerst angezeigt.',6,10,NULL,'2009-05-12 11:40:58',NULL,NULL),(525,'<hr><br />Zahlungszone','MODULE_PAYMENT_SAFERPAYGW_ZONE','0','Wenn eine Zone ausgew&auml;hlt ist, gilt die Zahlungsmethode nur f&uuml;r diese Zone.',6,11,NULL,'2009-05-12 11:40:58','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes('),(526,'Bestellstatus festlegen','MODULE_PAYMENT_SAFERPAYGW_ORDER_STATUS_ID','0','Mit Saferpay bezahlte Bestellungen, auf diesen Status setzen',6,12,NULL,'2009-05-12 11:40:58','tep_get_order_status_name','tep_cfg_pull_down_order_statuses('),(554,'Exception Url','MODULE_PAYMENT_POSTFINANCE_EXCEPTIONURL','http://demo.swisscart.com/checkout_process.php','URL of the web page to display to the customer when the payment result is uncertain.',6,0,NULL,'2009-06-11 14:43:30',NULL,NULL),(566,'','MODULE_ORDER_TOTAL_COUPON_CODE_LENGTH','8','',6,NULL,NULL,'2009-07-28 14:40:14',NULL,NULL),(567,'','MODULE_ORDER_TOTAL_COUPON_CODE_CHARS','mixed','',6,NULL,NULL,'2009-07-28 14:40:14',NULL,NULL),(570,'Enable Cash On Delivery Module','MODULE_PAYMENT_COD_STATUS','True','Do you want to accept Cash On Delevery payments?',6,1,NULL,'2010-01-14 17:05:09',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(571,'Payment Zone','MODULE_PAYMENT_COD_ZONE','0','If a zone is selected, only enable this payment method for that zone.',6,2,NULL,'2010-01-14 17:05:09','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes('),(572,'Sort order of display.','MODULE_PAYMENT_COD_SORT_ORDER','0','Sort order of display. Lowest is displayed first.',6,0,NULL,'2010-01-14 17:05:09',NULL,NULL),(573,'Set Order Status','MODULE_PAYMENT_COD_ORDER_STATUS_ID','0','Set the status of orders made with this payment module to this value',6,0,NULL,'2010-01-14 17:05:09','tep_get_order_status_name','tep_cfg_pull_down_order_statuses('),(605,'Tariftabelle für Zone 5 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_7','0.5:92,1:106,1.5:121,2:135,2.5:149,3:164,3.5:178,4:193,4.5:207,5:221,6:241,7:261,8:280,9:300,10:319,11:338,12:356,13:375,14:393,15:412,16:431,17:449,18:468,19:486,20:505,21:522,22:540,23:557,24:575,25:592,26:610,27:627,28:645,29:662,30:680','Tarif Tabelle für die Zone 5, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2010-04-01 12:40:24',NULL,NULL),(618,'Enable PayPal Website Payments Standard','MODULE_PAYMENT_PAYPAL_STANDARD_STATUS','True','Do you want to accept PayPal Website Payments Standard payments?',6,3,NULL,'2010-05-31 09:36:45',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(619,'E-Mail Address','MODULE_PAYMENT_PAYPAL_STANDARD_ID','claudi_1242572312_biz@gmail.com','The PayPal seller e-mail address to accept payments for',6,4,NULL,'2010-05-31 09:36:45',NULL,NULL),(620,'Sort order of display.','MODULE_PAYMENT_PAYPAL_STANDARD_SORT_ORDER','0','Sort order of display. Lowest is displayed first.',6,0,NULL,'2010-05-31 09:36:45',NULL,NULL),(621,'Payment Zone','MODULE_PAYMENT_PAYPAL_STANDARD_ZONE','0','If a zone is selected, only enable this payment method for that zone.',6,2,NULL,'2010-05-31 09:36:45','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes('),(622,'Set Preparing Order Status','MODULE_PAYMENT_PAYPAL_STANDARD_PREPARE_ORDER_STATUS_ID','6','Set the status of prepared orders made with this payment module to this value',6,0,NULL,'2010-05-31 09:36:45','tep_get_order_status_name','tep_cfg_pull_down_order_statuses('),(623,'Set PayPal Acknowledged Order Status','MODULE_PAYMENT_PAYPAL_STANDARD_ORDER_STATUS_ID','0','Set the status of orders made with this payment module to this value',6,0,NULL,'2010-05-31 09:36:45','tep_get_order_status_name','tep_cfg_pull_down_order_statuses('),(624,'Gateway Server','MODULE_PAYMENT_PAYPAL_STANDARD_GATEWAY_SERVER','Sandbox','Use the testing (sandbox) or live gateway server for transactions?',6,6,NULL,'2010-05-31 09:36:45',NULL,'tep_cfg_select_option(array(\'Live\', \'Sandbox\'), '),(625,'Transaction Method','MODULE_PAYMENT_PAYPAL_STANDARD_TRANSACTION_METHOD','Sale','The processing method to use for each transaction.',6,0,NULL,'2010-05-31 09:36:45',NULL,'tep_cfg_select_option(array(\'Authorization\', \'Sale\'), '),(626,'Page Style','MODULE_PAYMENT_PAYPAL_STANDARD_PAGE_STYLE','','The page style to use for the transaction procedure (defined at your PayPal Profile page)',6,4,NULL,'2010-05-31 09:36:45',NULL,NULL),(627,'Debug E-Mail Address','MODULE_PAYMENT_PAYPAL_STANDARD_DEBUG_EMAIL','','All parameters of an Invalid IPN notification will be sent to this email address if one is entered.',6,4,NULL,'2010-05-31 09:36:45',NULL,NULL),(628,'Enable Encrypted Web Payments','MODULE_PAYMENT_PAYPAL_STANDARD_EWP_STATUS','False','Do you want to enable Encrypted Web Payments?',6,3,NULL,'2010-05-31 09:36:45',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(629,'Your Private Key','MODULE_PAYMENT_PAYPAL_STANDARD_EWP_PRIVATE_KEY','','The location of your Private Key to use for signing the data. (*.pem)',6,4,NULL,'2010-05-31 09:36:45',NULL,NULL),(630,'Your Public Certificate','MODULE_PAYMENT_PAYPAL_STANDARD_EWP_PUBLIC_KEY','','The location of your Public Certificate to use for signing the data. (*.pem)',6,4,NULL,'2010-05-31 09:36:45',NULL,NULL),(631,'PayPals Public Certificate','MODULE_PAYMENT_PAYPAL_STANDARD_EWP_PAYPAL_KEY','','The location of the PayPal Public Certificate for encrypting the data.',6,4,NULL,'2010-05-31 09:36:45',NULL,NULL),(632,'Your PayPal Public Certificate ID','MODULE_PAYMENT_PAYPAL_STANDARD_EWP_CERT_ID','','The Certificate ID to use from your PayPal Encrypted Payment Settings Profile.',6,4,NULL,'2010-05-31 09:36:45',NULL,NULL),(633,'Working Directory','MODULE_PAYMENT_PAYPAL_STANDARD_EWP_WORKING_DIRECTORY','','The working directory to use for temporary files. (trailing slash needed)',6,4,NULL,'2010-05-31 09:36:45',NULL,NULL),(634,'OpenSSL Location','MODULE_PAYMENT_PAYPAL_STANDARD_EWP_OPENSSL','/usr/bin/openssl','The location of the openssl binary file.',6,4,NULL,'2010-05-31 09:36:45',NULL,NULL),(635,'Phone# required?','ENTRY_TELEPHONE_REQUIRED','no','Telephone number is a required info? (yes / no)',5,12,'2010-06-17 05:46:36','2010-06-17 05:42:02',NULL,'tep_cfg_select_option(array(\"yes\", \"no\"),'),(636,'Enable CleverReach','CR_ENABLED','false','',336,1,NULL,'0000-00-00 00:00:00',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
/*!40000 ALTER TABLE `configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuration_group`
--

DROP TABLE IF EXISTS `configuration_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuration_group` (
  `configuration_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `configuration_group_title` varchar(64) NOT NULL,
  `configuration_group_description` varchar(255) NOT NULL,
  `sort_order` int(5) DEFAULT NULL,
  `visible` int(1) DEFAULT '1',
  PRIMARY KEY (`configuration_group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=337 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuration_group`
--

LOCK TABLES `configuration_group` WRITE;
/*!40000 ALTER TABLE `configuration_group` DISABLE KEYS */;
INSERT INTO `configuration_group` VALUES (1,'My Store','General information about my store',1,1),(2,'Minimum Values','The minimum values for functions / data',2,1),(3,'Maximum Values','The maximum values for functions / data',3,1),(4,'Images','Image parameters',4,1),(5,'Customer Details','Customer account configuration',5,1),(6,'Module Options','Hidden from configuration',6,0),(7,'Shipping/Packaging','Shipping options available at my store',7,1),(8,'Product Listing','Product Listing    configuration options',8,1),(9,'Stock','Stock configuration options',9,1),(10,'Logging','Logging configuration options',10,1),(11,'Cache','Caching configuration options',11,1),(12,'E-Mail Options','General setting for E-Mail transport and HTML E-Mails',12,1),(13,'Download','Downloadable products options',13,1),(14,'GZip Compression','GZip compression options',14,1),(15,'Sessions','Session options',15,1),(335,'Seo Urls 5','Options for ULTIMATE Seo Urls 5 by FWR Media',99,1),(333,'Image Magic','Configuration options for the OSC Image Magic contribution',17,1),(17,'Miscellaneous','Various configuration settings',17,1),(336,'CleverReach','',7,1);
/*!40000 ALTER TABLE `configuration_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counter`
--

DROP TABLE IF EXISTS `counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counter` (
  `startdate` char(8) DEFAULT NULL,
  `counter` int(12) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counter`
--

LOCK TABLES `counter` WRITE;
/*!40000 ALTER TABLE `counter` DISABLE KEYS */;
INSERT INTO `counter` VALUES ('20070612',127850);
/*!40000 ALTER TABLE `counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counter_history`
--

DROP TABLE IF EXISTS `counter_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counter_history` (
  `month` char(8) DEFAULT NULL,
  `counter` int(12) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counter_history`
--

LOCK TABLES `counter_history` WRITE;
/*!40000 ALTER TABLE `counter_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `counter_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `countries_id` int(11) NOT NULL AUTO_INCREMENT,
  `countries_name` varchar(64) NOT NULL,
  `countries_iso_code_2` char(2) NOT NULL,
  `countries_iso_code_3` char(3) NOT NULL,
  `address_format_id` int(11) NOT NULL DEFAULT '0',
  `sorting` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`countries_id`),
  KEY `IDX_COUNTRIES_NAME` (`countries_name`)
) ENGINE=MyISAM AUTO_INCREMENT=240 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Afghanistan','AF','AFG',1,0),(2,'Albania','AL','ALB',1,0),(3,'Algeria','DZ','DZA',1,0),(4,'American Samoa','AS','ASM',1,0),(5,'Andorra','AD','AND',1,0),(6,'Angola','AO','AGO',1,0),(7,'Anguilla','AI','AIA',1,0),(8,'Antarctica','AQ','ATA',1,0),(9,'Antigua and Barbuda','AG','ATG',1,0),(10,'Argentina','AR','ARG',1,0),(11,'Armenia','AM','ARM',1,0),(12,'Aruba','AW','ABW',1,0),(13,'Australia','AU','AUS',1,0),(14,'Austria','AT','AUT',5,-6),(15,'Azerbaijan','AZ','AZE',1,0),(16,'Bahamas','BS','BHS',1,0),(17,'Bahrain','BH','BHR',1,0),(18,'Bangladesh','BD','BGD',1,0),(19,'Barbados','BB','BRB',1,0),(20,'Belarus','BY','BLR',1,0),(21,'Belgium','BE','BEL',1,0),(22,'Belize','BZ','BLZ',1,0),(23,'Benin','BJ','BEN',1,0),(24,'Bermuda','BM','BMU',1,0),(25,'Bhutan','BT','BTN',1,0),(26,'Bolivia','BO','BOL',1,0),(27,'Bosnia and Herzegowina','BA','BIH',1,0),(28,'Botswana','BW','BWA',1,0),(29,'Bouvet Island','BV','BVT',1,0),(30,'Brazil','BR','BRA',1,0),(31,'British Indian Ocean Territory','IO','IOT',1,0),(32,'Brunei Darussalam','BN','BRN',1,0),(33,'Bulgaria','BG','BGR',1,0),(34,'Burkina Faso','BF','BFA',1,0),(35,'Burundi','BI','BDI',1,0),(36,'Cambodia','KH','KHM',1,0),(37,'Cameroon','CM','CMR',1,0),(38,'Canada','CA','CAN',1,0),(39,'Cape Verde','CV','CPV',1,0),(40,'Cayman Islands','KY','CYM',1,0),(41,'Central African Republic','CF','CAF',1,0),(42,'Chad','TD','TCD',1,0),(43,'Chile','CL','CHL',1,0),(44,'China','CN','CHN',1,0),(45,'Christmas Island','CX','CXR',1,0),(46,'Cocos (Keeling) Islands','CC','CCK',1,0),(47,'Colombia','CO','COL',1,0),(48,'Comoros','KM','COM',1,0),(49,'Congo','CG','COG',1,0),(50,'Cook Islands','CK','COK',1,0),(51,'Costa Rica','CR','CRI',1,0),(52,'Cote D\'Ivoire','CI','CIV',1,0),(53,'Croatia','HR','HRV',1,0),(54,'Cuba','CU','CUB',1,0),(55,'Cyprus','CY','CYP',1,0),(56,'Czech Republic','CZ','CZE',1,0),(57,'Denmark','DK','DNK',1,0),(58,'Djibouti','DJ','DJI',1,0),(59,'Dominica','DM','DMA',1,0),(60,'Dominican Republic','DO','DOM',1,0),(61,'East Timor','TP','TMP',1,0),(62,'Ecuador','EC','ECU',1,0),(63,'Egypt','EG','EGY',1,0),(64,'El Salvador','SV','SLV',1,0),(65,'Equatorial Guinea','GQ','GNQ',1,0),(66,'Eritrea','ER','ERI',1,0),(67,'Estonia','EE','EST',1,0),(68,'Ethiopia','ET','ETH',1,0),(69,'Falkland Islands (Malvinas)','FK','FLK',1,0),(70,'Faroe Islands','FO','FRO',1,0),(71,'Fiji','FJ','FJI',1,0),(72,'Finland','FI','FIN',1,0),(73,'France','FR','FRA',1,-4),(74,'France, Metropolitan','FX','FXX',1,0),(75,'French Guiana','GF','GUF',1,0),(76,'French Polynesia','PF','PYF',1,0),(77,'French Southern Territories','TF','ATF',1,0),(78,'Gabon','GA','GAB',1,0),(79,'Gambia','GM','GMB',1,0),(80,'Georgia','GE','GEO',1,0),(81,'Germany','DE','DEU',5,-8),(82,'Ghana','GH','GHA',1,0),(83,'Gibraltar','GI','GIB',1,0),(84,'Greece','GR','GRC',1,0),(85,'Greenland','GL','GRL',1,0),(86,'Grenada','GD','GRD',1,0),(87,'Guadeloupe','GP','GLP',1,0),(88,'Guam','GU','GUM',1,0),(89,'Guatemala','GT','GTM',1,0),(90,'Guinea','GN','GIN',1,0),(91,'Guinea-bissau','GW','GNB',1,0),(92,'Guyana','GY','GUY',1,0),(93,'Haiti','HT','HTI',1,0),(94,'Heard and Mc Donald Islands','HM','HMD',1,0),(95,'Honduras','HN','HND',1,0),(96,'Hong Kong','HK','HKG',1,0),(97,'Hungary','HU','HUN',1,0),(98,'Iceland','IS','ISL',1,0),(99,'India','IN','IND',1,0),(100,'Indonesia','ID','IDN',1,0),(101,'Iran (Islamic Republic of)','IR','IRN',1,0),(102,'Iraq','IQ','IRQ',1,0),(103,'Ireland','IE','IRL',1,0),(104,'Israel','IL','ISR',1,0),(105,'Italy','IT','ITA',1,-2),(106,'Jamaica','JM','JAM',1,0),(107,'Japan','JP','JPN',1,0),(108,'Jordan','JO','JOR',1,0),(109,'Kazakhstan','KZ','KAZ',1,0),(110,'Kenya','KE','KEN',1,0),(111,'Kiribati','KI','KIR',1,0),(112,'Korea, Democratic People\'s Republic of','KP','PRK',1,0),(113,'Korea, Republic of','KR','KOR',1,0),(114,'Kuwait','KW','KWT',1,0),(115,'Kyrgyzstan','KG','KGZ',1,0),(116,'Lao People\'s Democratic Republic','LA','LAO',1,0),(117,'Latvia','LV','LVA',1,0),(118,'Lebanon','LB','LBN',1,0),(119,'Lesotho','LS','LSO',1,0),(120,'Liberia','LR','LBR',1,0),(121,'Libyan Arab Jamahiriya','LY','LBY',1,0),(122,'Liechtenstein','LI','LIE',5,0),(123,'Lithuania','LT','LTU',1,0),(124,'Luxembourg','LU','LUX',1,0),(125,'Macau','MO','MAC',1,0),(126,'Macedonia, The Former Yugoslav Republic of','MK','MKD',1,0),(127,'Madagascar','MG','MDG',1,0),(128,'Malawi','MW','MWI',1,0),(129,'Malaysia','MY','MYS',1,0),(130,'Maldives','MV','MDV',1,0),(131,'Mali','ML','MLI',1,0),(132,'Malta','MT','MLT',1,0),(133,'Marshall Islands','MH','MHL',1,0),(134,'Martinique','MQ','MTQ',1,0),(135,'Mauritania','MR','MRT',1,0),(136,'Mauritius','MU','MUS',1,0),(137,'Mayotte','YT','MYT',1,0),(138,'Mexico','MX','MEX',1,0),(139,'Micronesia, Federated States of','FM','FSM',1,0),(140,'Moldova, Republic of','MD','MDA',1,0),(141,'Monaco','MC','MCO',1,0),(142,'Mongolia','MN','MNG',1,0),(143,'Montserrat','MS','MSR',1,0),(144,'Morocco','MA','MAR',1,0),(145,'Mozambique','MZ','MOZ',1,0),(146,'Myanmar','MM','MMR',1,0),(147,'Namibia','NA','NAM',1,0),(148,'Nauru','NR','NRU',1,0),(149,'Nepal','NP','NPL',1,0),(150,'Netherlands','NL','NLD',1,0),(151,'Netherlands Antilles','AN','ANT',1,0),(152,'New Caledonia','NC','NCL',1,0),(153,'New Zealand','NZ','NZL',1,0),(154,'Nicaragua','NI','NIC',1,0),(155,'Niger','NE','NER',1,0),(156,'Nigeria','NG','NGA',1,0),(157,'Niue','NU','NIU',1,0),(158,'Norfolk Island','NF','NFK',1,0),(159,'Northern Mariana Islands','MP','MNP',1,0),(160,'Norway','NO','NOR',1,0),(161,'Oman','OM','OMN',1,0),(162,'Pakistan','PK','PAK',1,0),(163,'Palau','PW','PLW',1,0),(164,'Panama','PA','PAN',1,0),(165,'Papua New Guinea','PG','PNG',1,0),(166,'Paraguay','PY','PRY',1,0),(167,'Peru','PE','PER',1,0),(168,'Philippines','PH','PHL',1,0),(169,'Pitcairn','PN','PCN',1,0),(170,'Poland','PL','POL',1,0),(171,'Portugal','PT','PRT',1,0),(172,'Puerto Rico','PR','PRI',1,0),(173,'Qatar','QA','QAT',1,0),(174,'Reunion','RE','REU',1,0),(175,'Romania','RO','ROM',1,0),(176,'Russian Federation','RU','RUS',1,0),(177,'Rwanda','RW','RWA',1,0),(178,'Saint Kitts and Nevis','KN','KNA',1,0),(179,'Saint Lucia','LC','LCA',1,0),(180,'Saint Vincent and the Grenadines','VC','VCT',1,0),(181,'Samoa','WS','WSM',1,0),(182,'San Marino','SM','SMR',1,0),(183,'Sao Tome and Principe','ST','STP',1,0),(184,'Saudi Arabia','SA','SAU',1,0),(185,'Senegal','SN','SEN',1,0),(186,'Seychelles','SC','SYC',1,0),(187,'Sierra Leone','SL','SLE',1,0),(188,'Singapore','SG','SGP',4,0),(189,'Slovakia (Slovak Republic)','SK','SVK',1,0),(190,'Slovenia','SI','SVN',1,0),(191,'Solomon Islands','SB','SLB',1,0),(192,'Somalia','SO','SOM',1,0),(193,'South Africa','ZA','ZAF',1,0),(194,'South Georgia and the South Sandwich Islands','GS','SGS',1,0),(195,'Spain','ES','ESP',3,0),(196,'Sri Lanka','LK','LKA',1,0),(197,'St. Helena','SH','SHN',1,0),(198,'St. Pierre and Miquelon','PM','SPM',1,0),(199,'Sudan','SD','SDN',1,0),(200,'Suriname','SR','SUR',1,0),(201,'Svalbard and Jan Mayen Islands','SJ','SJM',1,0),(202,'Swaziland','SZ','SWZ',1,0),(203,'Sweden','SE','SWE',1,0),(204,'Switzerland','CH','CHE',5,-10),(205,'Syrian Arab Republic','SY','SYR',1,0),(206,'Taiwan','TW','TWN',1,0),(207,'Tajikistan','TJ','TJK',1,0),(208,'Tanzania, United Republic of','TZ','TZA',1,0),(209,'Thailand','TH','THA',1,0),(210,'Togo','TG','TGO',1,0),(211,'Tokelau','TK','TKL',1,0),(212,'Tonga','TO','TON',1,0),(213,'Trinidad and Tobago','TT','TTO',1,0),(214,'Tunisia','TN','TUN',1,0),(215,'Turkey','TR','TUR',1,0),(216,'Turkmenistan','TM','TKM',1,0),(217,'Turks and Caicos Islands','TC','TCA',1,0),(218,'Tuvalu','TV','TUV',1,0),(219,'Uganda','UG','UGA',1,0),(220,'Ukraine','UA','UKR',1,0),(221,'United Arab Emirates','AE','ARE',1,0),(222,'United Kingdom','GB','GBR',1,0),(223,'United States','US','USA',2,0),(224,'United States Minor Outlying Islands','UM','UMI',1,0),(225,'Uruguay','UY','URY',1,0),(226,'Uzbekistan','UZ','UZB',1,0),(227,'Vanuatu','VU','VUT',1,0),(228,'Vatican City State (Holy See)','VA','VAT',1,0),(229,'Venezuela','VE','VEN',1,0),(230,'Viet Nam','VN','VNM',1,0),(231,'Virgin Islands (British)','VG','VGB',1,0),(232,'Virgin Islands (U.S.)','VI','VIR',1,0),(233,'Wallis and Futuna Islands','WF','WLF',1,0),(234,'Western Sahara','EH','ESH',1,0),(235,'Yemen','YE','YEM',1,0),(236,'Yugoslavia','YU','YUG',1,0),(237,'Zaire','ZR','ZAR',1,0),(238,'Zambia','ZM','ZMB',1,0),(239,'Zimbabwe','ZW','ZWE',1,0);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coupons` (
  `coupons_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `coupons_code` varchar(32) NOT NULL,
  `coupons_value` decimal(15,4) NOT NULL,
  `coupons_notice` varchar(250) NOT NULL,
  `coupons_min_order` int(11) NOT NULL DEFAULT '0',
  `coupons_date` date DEFAULT NULL,
  PRIMARY KEY (`coupons_id`),
  KEY `idx_code` (`coupons_code`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (1,'test123','25.0000','',50,'2009-07-28'),(2,'Test1','800.0000','CHF 10.-',50,'2010-05-01');
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons_sales`
--

DROP TABLE IF EXISTS `coupons_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coupons_sales` (
  `coupons_sales_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `coupons_code` varchar(32) NOT NULL,
  `customers_id` int(10) unsigned NOT NULL,
  `orders_id` int(10) unsigned NOT NULL,
  `date_purchased` date NOT NULL,
  PRIMARY KEY (`coupons_sales_id`),
  KEY `redeem_idx` (`coupons_code`,`customers_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons_sales`
--

LOCK TABLES `coupons_sales` WRITE;
/*!40000 ALTER TABLE `coupons_sales` DISABLE KEYS */;
INSERT INTO `coupons_sales` VALUES (1,'test123',2,15,'2009-07-28'),(2,'Test1',26,25,'2010-01-14');
/*!40000 ALTER TABLE `coupons_sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencies` (
  `currencies_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `code` char(3) NOT NULL,
  `symbol_left` varchar(12) DEFAULT NULL,
  `symbol_right` varchar(12) DEFAULT NULL,
  `decimal_point` char(1) DEFAULT NULL,
  `thousands_point` char(1) DEFAULT NULL,
  `decimal_places` char(1) DEFAULT NULL,
  `value` float(13,8) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`currencies_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES (1,'US Dollar','USD','$','','.',',','2',0.80669999,'2007-06-13 02:03:21'),(2,'Euro','EUR','','EUR','.',',','2',0.60439998,'2007-06-13 02:03:22'),(3,'Schweizer Franken','CHF','CHF','','.','\'','2',1.00000000,'2007-06-13 02:03:23');
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `customers_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_gender` char(1) NOT NULL,
  `customers_firstname` varchar(32) NOT NULL,
  `customers_lastname` varchar(32) NOT NULL,
  `customers_dob` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `customers_email_address` varchar(96) NOT NULL,
  `customers_default_address_id` int(11) DEFAULT NULL,
  `customers_telephone` varchar(32) NOT NULL,
  `customers_fax` varchar(32) DEFAULT NULL,
  `customers_password` varchar(40) NOT NULL,
  `customers_newsletter` char(1) DEFAULT NULL,
  PRIMARY KEY (`customers_id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (2,'m','Nick','Weisser','1970-05-21 00:00:00','nick@openstream.ch',2,'0445007878','','4b0bb070a6ffa89de54e062da0c29936:d9','1'),(4,'m','Peter','Keller','0000-00-00 00:00:00','dancer_pk@hotmail.com',5,'+413998284','','87b69224bea44bc87a6606495444907a:9f',''),(6,'f','Olivia','Pfister','0000-00-00 00:00:00','olivia.pfister@bluewin.ch',7,'081 943 33 16','','f41a32175d5dead9ce4091c8739227fa:99',''),(21,'m','Test','Test','0000-00-00 00:00:00','test@test.ch',22,'12345678','','52753b52516063ae6190cdcee049f753:44',''),(10,'m','Martin','Steiner','0000-00-00 00:00:00','martin@stooni.ch',11,'+41 76 441 61 41','','5cb530c7a47d472fef184e15b2bcabdd:ec',''),(22,'m','Test','test','0000-00-00 00:00:00','stephane.rosset@bluewin.ch',23,'026 666 666','','a922a1f6c01ccd6bf4bfbe20deacc0d9:7d',''),(12,'m','Amar','Dravid','0000-00-00 00:00:00','alba1297@yahoo.com',13,'00613011726','','befac03398bc9f05e4b9427d8cc76fdd:1d',''),(20,'m','Adriaan','Spierings','0000-00-00 00:00:00','adriaan.spierings@postmail.ch',21,'071 2901389','','ff331e369fd618977c4648c5b638c80b:90',''),(23,'m','safsadf','gdfghfgh','0000-00-00 00:00:00','test@test.com',24,'044098292','','910926a9687d188d09042559b14418cb:0c',''),(24,'m','dadaddsa','dsasdad','0000-00-00 00:00:00','dadas@fddskdsf.ch',25,'32483821932','','005a359cd27f06bbe2ece6395f944248:96',''),(25,'m','Fritz','Müller','0000-00-00 00:00:00','fritz@mueller.ch',26,'033 334455','','2d150ba92051ecb8aacc51f3e0b41fe0:e9',''),(26,'m','Tom','Burri','0000-00-00 00:00:00','burrito.tom@gmail.com',27,'000','','7049921b003e5e69fdf73647e0a618e1:c9',''),(27,'m','wertz','asdf','0000-00-00 00:00:00','blu-port@bluewin.ch',28,'12787890','','91d3411ce3ccda96d97d692115b34db1:69','0'),(28,'m','Claudio Hideki','Imai','0000-00-00 00:00:00','claudio@openstream.ch',29,'41 (0)44 500 78 78','','42067b3821f64fd93915d5716f06e0a0:b6',''),(29,'f','Barbara','Berger','0000-00-00 00:00:00','barbara_berger@hispeed.ch',30,'031 000 00 00','','aa9353ca9b79622bfd32f96cb71b4959:ca','1'),(30,'m','Reto','Marti','0000-00-00 00:00:00','rm_marti@hotmail.com',31,'+41449417313','','40bc794e25e80747f9a88746e2aaf72f:38',''),(31,'m','aw','sw','0000-00-00 00:00:00','dw@test.ch',32,'357894','','444fdf917c4d2fea1d52c3371d69809a:3c','');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers_basket`
--

DROP TABLE IF EXISTS `customers_basket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers_basket` (
  `customers_basket_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT '0',
  `products_id` tinytext NOT NULL,
  `customers_basket_quantity` int(2) NOT NULL DEFAULT '0',
  `final_price` decimal(15,4) DEFAULT NULL,
  `customers_basket_date_added` varchar(8) DEFAULT NULL,
  `clickandbuy_TransactionID` varchar(11) NOT NULL,
  `clickandbuy_externalBDRID` varchar(11) NOT NULL,
  PRIMARY KEY (`customers_basket_id`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers_basket`
--

LOCK TABLES `customers_basket` WRITE;
/*!40000 ALTER TABLE `customers_basket` DISABLE KEYS */;
INSERT INTO `customers_basket` VALUES (4,4,'5{3}10{2}3{1}1',1,NULL,'20080325','',''),(12,10,'5{2}3{3}10{1}1',1,NULL,'20080627','',''),(30,21,'1{txt_4}',2,NULL,'20090925','',''),(29,20,'1{txt_4}{txt_5}',1,NULL,'20090905','',''),(34,23,'7',1,NULL,'20091125','',''),(35,24,'1',1,NULL,'20091208','',''),(36,24,'7',1,NULL,'20091208','',''),(37,25,'1',1,NULL,'20091217','',''),(42,26,'1',1,NULL,'20100114','',''),(47,29,'7',1,NULL,'20100531','',''),(48,30,'1',1,NULL,'20100603','',''),(50,2,'5{3}9{2}3{1}1',1,NULL,'20100615','',''),(51,31,'4',1,NULL,'20100707','','');
/*!40000 ALTER TABLE `customers_basket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers_basket_attributes`
--

DROP TABLE IF EXISTS `customers_basket_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers_basket_attributes` (
  `customers_basket_attributes_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT '0',
  `products_id` tinytext NOT NULL,
  `products_options_id` int(11) NOT NULL DEFAULT '0',
  `products_options_value_id` int(11) NOT NULL DEFAULT '0',
  `products_options_value_text` text,
  PRIMARY KEY (`customers_basket_attributes_id`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers_basket_attributes`
--

LOCK TABLES `customers_basket_attributes` WRITE;
/*!40000 ALTER TABLE `customers_basket_attributes` DISABLE KEYS */;
INSERT INTO `customers_basket_attributes` VALUES (1,4,'5{3}10{2}3{1}1',3,10,''),(2,4,'5{3}10{2}3{1}1',2,3,''),(3,4,'5{3}10{2}3{1}1',1,1,''),(19,10,'5{2}3{3}10{1}1',2,3,''),(20,10,'5{2}3{3}10{1}1',3,10,''),(21,10,'5{2}3{3}10{1}1',1,1,''),(51,2,'5{3}9{2}3{1}1',3,9,''),(52,2,'5{3}9{2}3{1}1',2,3,''),(53,2,'5{3}9{2}3{1}1',1,1,'');
/*!40000 ALTER TABLE `customers_basket_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers_info`
--

DROP TABLE IF EXISTS `customers_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers_info` (
  `customers_info_id` int(11) NOT NULL DEFAULT '0',
  `customers_info_date_of_last_logon` datetime DEFAULT NULL,
  `customers_info_number_of_logons` int(5) DEFAULT NULL,
  `customers_info_date_account_created` datetime DEFAULT NULL,
  `customers_info_date_account_last_modified` datetime DEFAULT NULL,
  `global_product_notifications` int(1) DEFAULT '0',
  PRIMARY KEY (`customers_info_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers_info`
--

LOCK TABLES `customers_info` WRITE;
/*!40000 ALTER TABLE `customers_info` DISABLE KEYS */;
INSERT INTO `customers_info` VALUES (2,'2010-06-15 15:30:56',39,'2007-07-05 01:00:50',NULL,0),(4,NULL,0,'2008-03-25 12:36:32',NULL,0),(6,'2008-03-31 17:09:33',1,'2008-03-31 11:44:58',NULL,0),(21,NULL,0,'2009-09-25 10:40:51',NULL,0),(10,NULL,0,'2008-06-27 13:17:46',NULL,0),(22,NULL,0,'2009-10-07 18:06:08',NULL,0),(12,'2008-12-16 14:48:24',1,'2008-11-28 15:57:17',NULL,0),(20,'2009-09-10 12:29:07',3,'2009-09-05 11:08:43',NULL,0),(23,NULL,0,'2009-11-25 17:07:33',NULL,0),(24,NULL,0,'2009-12-08 08:28:56',NULL,0),(25,NULL,0,'2009-12-17 14:57:31',NULL,0),(26,NULL,0,'2010-01-14 16:51:59',NULL,0),(27,NULL,0,'2010-01-15 21:22:27','2010-06-17 05:46:55',0),(28,NULL,0,'2010-05-31 09:47:47',NULL,0),(29,'2010-06-12 23:35:09',3,'2010-05-31 20:00:10',NULL,0),(30,NULL,0,'2010-06-03 12:35:18',NULL,0),(31,NULL,0,'2010-07-07 15:35:27',NULL,0);
/*!40000 ALTER TABLE `customers_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `featured`
--

DROP TABLE IF EXISTS `featured`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `featured` (
  `featured_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT '0',
  `featured_date_added` datetime DEFAULT NULL,
  `featured_last_modified` datetime DEFAULT NULL,
  `expires_date` datetime DEFAULT NULL,
  `date_status_change` datetime DEFAULT NULL,
  `status` int(1) DEFAULT '1',
  PRIMARY KEY (`featured_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `featured`
--

LOCK TABLES `featured` WRITE;
/*!40000 ALTER TABLE `featured` DISABLE KEYS */;
INSERT INTO `featured` VALUES (1,4,'2008-03-12 15:00:01',NULL,NULL,NULL,1),(2,5,'2008-03-12 15:41:13',NULL,'0000-00-00 00:00:00',NULL,1),(5,1,'2009-10-16 11:24:03',NULL,'0000-00-00 00:00:00',NULL,1);
/*!40000 ALTER TABLE `featured` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files_uploaded`
--

DROP TABLE IF EXISTS `files_uploaded`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files_uploaded` (
  `files_uploaded_id` int(11) NOT NULL AUTO_INCREMENT,
  `sesskey` varchar(32) DEFAULT NULL,
  `customers_id` int(11) DEFAULT NULL,
  `files_uploaded_name` varchar(64) NOT NULL,
  PRIMARY KEY (`files_uploaded_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files_uploaded`
--

LOCK TABLES `files_uploaded` WRITE;
/*!40000 ALTER TABLE `files_uploaded` DISABLE KEYS */;
INSERT INTO `files_uploaded` VALUES (1,'eb7e320d374627d09013f6fcbe7fa2f2',NULL,'tux.png');
/*!40000 ALTER TABLE `files_uploaded` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_zones`
--

DROP TABLE IF EXISTS `geo_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_zones` (
  `geo_zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `geo_zone_name` varchar(32) NOT NULL,
  `geo_zone_description` varchar(255) NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`geo_zone_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geo_zones`
--

LOCK TABLES `geo_zones` WRITE;
/*!40000 ALTER TABLE `geo_zones` DISABLE KEYS */;
INSERT INTO `geo_zones` VALUES (1,'Schweiz','Steuerzone Schweiz','2007-08-07 22:42:21','2007-06-12 22:50:01');
/*!40000 ALTER TABLE `geo_zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `information`
--

DROP TABLE IF EXISTS `information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `information` (
  `information_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `information_group_id` int(11) unsigned NOT NULL DEFAULT '0',
  `information_title` varchar(255) NOT NULL,
  `information_description` text NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `visible` enum('1','0') NOT NULL DEFAULT '1',
  `language_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`information_id`,`language_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `information`
--

LOCK TABLES `information` WRITE;
/*!40000 ALTER TABLE `information` DISABLE KEYS */;
INSERT INTO `information` VALUES (1,2,'HEADING_TITLE','Welcome to the swisscart&reg; demo store',0,1,'1',1),(2,2,'TEXT_GREETING_PERSONAL','Welcome back! Would you like to see which <a href=\"/products_new.php\"><u>new products</u></a> are available to purchase?',0,2,'1',1),(3,2,'TEXT_GREETING_PERSONAL_RELOGON','If you are not %s, please <a href=\"/login.php\"><u>log yourself in</u></a> with your account information.',0,3,'1',1),(4,2,'TEXT_GREETING_GUEST','Would you like to <a href=\"/login.php\"><u>log yourself in</u></a>? Or would you prefer to <a href=\"/create_account.php\"><u>create an account</u></a>?',0,4,'1',1),(5,2,'TEXT_MAIN','<p><strong>Dies ist ein Demo Shop! Ihre Bestellungen werden nicht ausgef&uuml;hrt, d.h. Sie erhalten keine Lieferung!</strong></p>\r\n<p>This is a default text. This can be changed in the admin panel\'s info manager.</p>',0,5,'1',1),(1,2,'HEADING_TITLE','Willkommen im Demo Shop von swisscart&reg;',0,1,'1',2),(2,2,'TEXT_GREETING_PERSONAL','Sch&ouml;n das Sie wieder da sind! M&ouml;chten Sie die <a href=\"/products_new.php\"><u>neuen Produkte</u></a> ansehen?',0,2,'1',2),(3,2,'TEXT_GREETING_PERSONAL_RELOGON','Wenn Sie nicht %s sind, melden Sie sich bitte <a href=\"/login.php\"><u>hier</u></a> mit Ihrem Kundenkonto an.',0,3,'1',2),(4,2,'TEXT_GREETING_GUEST','Bestehende Kunden k&ouml;nnen sich hier <a href=\"/login.php\"><u>einloggen</u></a>. Neukunden bitten wir, bei einer Bestellung ein <a href=\"/create_account.php\"><u>Kundenkonto</u></a> zu er&ouml;ffnen, um jederzeit den Bestellstatus online abrufen zu k&ouml;nnen.',0,4,'1',2),(5,2,'TEXT_MAIN','<p><strong>Dies ist ein Demo Shop! Ihre Bestellungen werden nicht ausgef&uuml;hrt, d.h. Sie erhalten keine Lieferung!</strong></p>\r\n<p>Diesen Text k&ouml;nnen Sie im Admin unter Info-Manager &auml;ndern.</p>',0,5,'1',2),(1,2,'HEADING_TITLE','A ver que tenemos aqui',0,1,'1',3),(2,2,'TEXT_GREETING_PERSONAL','Bienvenido de nuevo! &iquest;Le gustaria ver que <a href=\"/products_new.php\"><u>nuevos productos</u></a> hay disponibles?',0,2,'1',3),(3,2,'TEXT_GREETING_PERSONAL_RELOGON','Si no es %s, por favor <a href=\"/login.php\"><u>entre aqui</u></a> e introduzca sus datos.',0,3,'1',3),(4,2,'TEXT_GREETING_GUEST','Bienvenido <span class=\"greetUser\">Invitado!</span> &iquest;Le gustaria <a href=\"/login.php\"><u>entrar en su cuenta</u></a> o preferiria <a href=\"/create_account.php\"><u>crear una cuenta nueva</u></a>?',0,4,'1',3),(5,2,'TEXT_MAIN','<p><strong>Dies ist ein Demo Shop! Ihre Bestellungen werden nicht ausgef&uuml;hrt, d.h. Sie erhalten keine Lieferung!</strong></p>\r\n<p>Este text se puede cambiar en el info manager de la administracion.</p>',0,5,'1',3),(1,2,'HEADING_TITLE','Vediamo cose c\'&egrave; qui',0,1,'1',4),(2,2,'TEXT_GREETING_PERSONAL','Bentornato! Vuoi vedere i <a href=\"/products_new.php\"><u>nouvi prodotti</u></a> che sono disponibili?',0,2,'1',4),(3,2,'TEXT_GREETING_PERSONAL_RELOGON','Se tu non sei %s, <a href=\"/login.php\"><u>effettua il log-in</u></a> con i dati del tuo accout.',0,3,'1',4),(4,2,'TEXT_GREETING_GUEST','Benvenuto <span class=\"greetUser\">!</span> Puoi effettuare qui <a href=\"/login.php\"><u>il log-in</u></a>? Oppure puoi creare qui <a href=\"/create_account.php\"><u>un account</u></a>?',0,4,'1',4),(5,2,'TEXT_MAIN','<p><strong>Dies ist ein Demo Shop! Ihre Bestellungen werden nicht ausgef&uuml;hrt, d.h. Sie erhalten keine Lieferung!</strong></p>\r\n<p>This is a default text. This can be changed in the admim panel\'s info manager.</p>',0,5,'1',4),(1,2,'HEADING_TITLE','Voyons ce que nous avons-l&agrave;',0,1,'1',5),(2,2,'TEXT_GREETING_PERSONAL','Bienvenue &agrave; nouveau! Voudriez-vous voir quels <a href=\"/products_new.php\"><u>nouveaux produits</u></a> sont disponibles&nbsp;?',0,2,'1',5),(3,2,'TEXT_GREETING_PERSONAL_RELOGON','Si vous n\'&ecirc;tes pas %s, veuillez <a href=\"/login.php\"><u>vous indentifier</u></a> avec vos param&egrave;tres de compte.',0,3,'1',5),(4,2,'TEXT_GREETING_GUEST','Bienvenue <span class=\"greetUser\">cher visiteur&nbsp;!</span> Voulez-vous <a href=\"/login.php\"><u>vous identifier</u></a>? Ou pr&eacute;f&eacute;rez-vous <a href=\"/create_account.php\"><u>cr&eacute;er un compte</u></a>&nbsp;?',0,4,'1',5),(5,2,'TEXT_MAIN','<p><strong>Dies ist ein Demo Shop! Ihre Bestellungen werden nicht ausgef&uuml;hrt, d.h. Sie erhalten keine Lieferung!</strong></p>\r\n<p>Ce text peut ?tre chang? avec le info manager dans l\'administration</p>',0,5,'1',5),(6,1,'Versand','<p>F&uuml;gen Sie hier Ihre Informationen &uuml;ber Liefer- und Versandkosten ein.</p>',0,1,'1',2),(6,1,'Shipping','<p>Put here your Shipping &amp; Returns information.</p>',0,1,'1',1),(6,1,'Livraison','<p>Mettez ici vous informations sur les livraison &amp; retour.</p>',0,1,'1',5),(6,1,'Spedizione','<p>Inserisci qui le tue informazioni sulla spedizione e consegna.</p>',0,1,'1',4),(6,1,'Env?os','<p>Ponga aqui informacion sobre los Envios y Devoluciones</p>',0,1,'1',3),(7,1,'Unsere AGBs','F&uuml;gen Sie hier Ihre allgemeinen Gesch&auml;ftsbedingungen ein. Diesen Text k&ouml;nnen Sie im Admin-Bereich unter <strong>Info-Manager/Infobox</strong> bearbeiten.',0,2,'1',2),(7,1,'Conditions of Use','Put here your Conditions of Use information. This text can be modified in the admin section under <strong>Info Manager/Infobox</strong>.',0,2,'1',1),(7,1,'Conditions d\'utilisation','Mettez ici les informations concernant vos conditions d\'utilisation.',0,2,'1',5),(7,1,'Condizioni per l\'uso','Inserisci qui le condizioni di informazione sull\' uso.',0,2,'1',4),(7,1,'Condiciones de Uso','Ponga aqui sus condiciones de uso.',0,2,'1',3),(8,1,'Test','',7,3,'1',2),(8,1,'','',7,3,'1',1),(8,1,'','',7,3,'1',5),(8,1,'','',7,3,'1',4),(8,1,'','',7,3,'1',3);
/*!40000 ALTER TABLE `information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `information_group`
--

DROP TABLE IF EXISTS `information_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `information_group` (
  `information_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `information_group_title` varchar(64) NOT NULL,
  `information_group_description` varchar(255) NOT NULL,
  `sort_order` int(5) DEFAULT NULL,
  `visible` int(1) DEFAULT '1',
  `locked` varchar(255) NOT NULL,
  PRIMARY KEY (`information_group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `information_group`
--

LOCK TABLES `information_group` WRITE;
/*!40000 ALTER TABLE `information_group` DISABLE KEYS */;
INSERT INTO `information_group` VALUES (1,'Infobox','Diese Seiten werden in der Infobox angezeigt',2,1,''),(2,'Startseite','Zum ändern des Text auf der Startseite Ihres Shops',1,1,''),(3,'Landing Pages','',3,1,'');
/*!40000 ALTER TABLE `information_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `languages_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `code` char(2) NOT NULL,
  `image` varchar(64) DEFAULT NULL,
  `directory` varchar(32) DEFAULT NULL,
  `sort_order` int(3) DEFAULT NULL,
  PRIMARY KEY (`languages_id`),
  KEY `IDX_LANGUAGES_NAME` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'English','en','icon.gif','english',10),(2,'Deutsch','de','icon.gif','german',5),(3,'Español','es','icon.gif','espanol',25),(4,'Italiano','it','icon.gif','italian',20),(5,'Français','fr','icon.gif','french',15);
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturers`
--

DROP TABLE IF EXISTS `manufacturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manufacturers` (
  `manufacturers_id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturers_name` varchar(32) NOT NULL,
  `manufacturers_image` varchar(64) DEFAULT NULL,
  `manufacturers_image_1` varchar(64) DEFAULT NULL,
  `manufacturers_image_2` varchar(64) DEFAULT NULL,
  `manufacturers_image_3` varchar(64) DEFAULT NULL,
  `manufacturers_image_4` varchar(64) DEFAULT NULL,
  `manufacturers_region` varchar(255) DEFAULT NULL,
  `manufacturers_country` varchar(255) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`manufacturers_id`),
  KEY `IDX_MANUFACTURERS_NAME` (`manufacturers_name`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturers`
--

LOCK TABLES `manufacturers` WRITE;
/*!40000 ALTER TABLE `manufacturers` DISABLE KEYS */;
INSERT INTO `manufacturers` VALUES (1,'JamoTrade','jamotrade.jpg',NULL,NULL,NULL,NULL,NULL,NULL,'2007-11-04 14:42:14',NULL),(2,'Zeed','zeed.gif',NULL,NULL,NULL,NULL,NULL,NULL,'2007-11-04 15:02:43',NULL),(4,'Sony','sony-logo.jpg',NULL,NULL,NULL,NULL,NULL,NULL,'2007-11-05 02:36:16',NULL),(5,'Hewlett-Packard','hp-logo.gif',NULL,NULL,NULL,NULL,'','','2007-11-05 02:57:47','2010-05-31 19:57:43');
/*!40000 ALTER TABLE `manufacturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturers_info`
--

DROP TABLE IF EXISTS `manufacturers_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manufacturers_info` (
  `manufacturers_id` int(11) NOT NULL DEFAULT '0',
  `languages_id` int(11) NOT NULL DEFAULT '0',
  `manufacturers_url` varchar(255) NOT NULL,
  `url_clicked` int(5) NOT NULL DEFAULT '0',
  `date_last_click` datetime DEFAULT NULL,
  `manufacturers_htc_title_tag` varchar(80) DEFAULT NULL,
  `manufacturers_htc_desc_tag` longtext,
  `manufacturers_htc_keywords_tag` longtext,
  `manufacturers_htc_description` longtext,
  `manufacturers_description` longtext,
  PRIMARY KEY (`manufacturers_id`,`languages_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturers_info`
--

LOCK TABLES `manufacturers_info` WRITE;
/*!40000 ALTER TABLE `manufacturers_info` DISABLE KEYS */;
INSERT INTO `manufacturers_info` VALUES (1,2,'www.jamotrade.ch',11,'2010-06-03 14:01:23','JamoTrade','JamoTrade','JamoTrade','',NULL),(1,1,'www.jamotrade.ch',41,'2010-07-16 03:56:51','JamoTrade','JamoTrade','JamoTrade','',NULL),(1,5,'www.jamotrade.ch',2,'2008-12-27 07:19:49','JamoTrade','JamoTrade','JamoTrade','',NULL),(1,4,'www.jamotrade.ch',2,'2009-11-30 21:36:51','JamoTrade','JamoTrade','JamoTrade','',NULL),(1,3,'www.jamotrade.ch',4,'2009-10-21 12:41:10','JamoTrade','JamoTrade','JamoTrade','',NULL),(2,2,'http://www.zeed.ch',6,'2010-07-17 23:31:00','Zeed','Zeed','Zeed','',NULL),(2,1,'http://www.zeed.ch',32,'2010-06-23 21:58:47','Zeed','Zeed','Zeed','',NULL),(2,5,'http://www.zeed.ch',2,'2009-11-30 21:42:34','Zeed','Zeed','Zeed','',NULL),(2,4,'http://www.zeed.ch',0,NULL,'Zeed','Zeed','Zeed','',NULL),(2,3,'http://www.zeed.ch',2,'2009-10-21 12:44:11','Zeed','Zeed','Zeed','',NULL),(4,2,'http://www.sony.com/',1,'2008-03-28 22:36:19','Sony','Sony','Sony','',NULL),(4,1,'http://www.sony.com/',42,'2010-07-13 03:07:14','Sony','Sony','Sony','',NULL),(4,5,'http://www.sony.com/',1,'2009-12-01 01:01:04','Sony','Sony','Sony','',NULL),(4,4,'http://www.sony.com/',1,'2008-06-01 13:21:04','Sony','Sony','Sony','',NULL),(4,3,'http://www.sony.com/',4,'2009-10-21 12:36:45','Sony','Sony','Sony','',NULL),(5,2,'http://www.hp.com',3,'2008-11-13 12:02:03','Hewlett-Packard','Hewlett-Packard','Hewlett-Packard','','<p>Dies ist eine Testbeschreibung zu Hewlett-Packard.</p>'),(5,1,'http://www.hp.com',40,'2010-07-10 22:35:09','Hewlett-Packard','Hewlett-Packard','Hewlett-Packard','',''),(5,5,'http://www.hp.com',3,'2009-12-01 00:58:07','Hewlett-Packard','Hewlett-Packard','Hewlett-Packard','',''),(5,4,'http://www.hp.com',1,'2008-06-01 15:36:54','Hewlett-Packard','Hewlett-Packard','Hewlett-Packard','',''),(5,3,'http://www.hp.com',5,'2009-10-21 12:42:07','Hewlett-Packard','Hewlett-Packard','Hewlett-Packard','','');
/*!40000 ALTER TABLE `manufacturers_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletters`
--

DROP TABLE IF EXISTS `newsletters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletters` (
  `newsletters_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `module` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_sent` datetime DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `locked` int(1) DEFAULT '0',
  PRIMARY KEY (`newsletters_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsletters`
--

LOCK TABLES `newsletters` WRITE;
/*!40000 ALTER TABLE `newsletters` DISABLE KEYS */;
INSERT INTO `newsletters` VALUES (1,'test','test','newsletter','2008-05-22 17:39:24',NULL,0,0);
/*!40000 ALTER TABLE `newsletters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `orders_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT '0',
  `customers_name` varchar(64) NOT NULL,
  `customers_company` varchar(32) DEFAULT NULL,
  `customers_street_address` varchar(64) NOT NULL,
  `customers_suburb` varchar(32) DEFAULT NULL,
  `customers_city` varchar(32) NOT NULL,
  `customers_postcode` varchar(10) NOT NULL,
  `customers_state` varchar(32) DEFAULT NULL,
  `customers_country` varchar(32) NOT NULL,
  `customers_telephone` varchar(32) NOT NULL,
  `customers_email_address` varchar(96) NOT NULL,
  `customers_address_format_id` int(5) NOT NULL DEFAULT '0',
  `delivery_name` varchar(64) NOT NULL,
  `delivery_firstname` varchar(32) NOT NULL,
  `delivery_lastname` varchar(32) NOT NULL,
  `delivery_company` varchar(32) DEFAULT NULL,
  `delivery_street_address` varchar(64) NOT NULL,
  `delivery_suburb` varchar(32) DEFAULT NULL,
  `delivery_city` varchar(32) NOT NULL,
  `delivery_postcode` varchar(10) NOT NULL,
  `delivery_state` varchar(32) DEFAULT NULL,
  `delivery_country` varchar(32) NOT NULL,
  `delivery_country_iso_code_2` char(2) NOT NULL,
  `delivery_address_format_id` int(5) NOT NULL DEFAULT '0',
  `billing_name` varchar(64) NOT NULL,
  `billing_firstname` varchar(32) NOT NULL,
  `billing_lastname` varchar(32) NOT NULL,
  `billing_company` varchar(32) DEFAULT NULL,
  `billing_street_address` varchar(64) NOT NULL,
  `billing_suburb` varchar(32) DEFAULT NULL,
  `billing_city` varchar(32) NOT NULL,
  `billing_postcode` varchar(10) NOT NULL,
  `billing_state` varchar(32) DEFAULT NULL,
  `billing_country` varchar(32) NOT NULL,
  `billing_country_iso_code_2` char(2) NOT NULL,
  `billing_address_format_id` int(5) NOT NULL DEFAULT '0',
  `payment_method` varchar(255) NOT NULL,
  `cc_type` varchar(20) DEFAULT NULL,
  `cc_owner` varchar(64) DEFAULT NULL,
  `cc_number` varchar(32) DEFAULT NULL,
  `cc_expires` varchar(4) DEFAULT NULL,
  `cc_cvv2` varchar(4) DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_purchased` datetime DEFAULT NULL,
  `orders_status` int(5) NOT NULL DEFAULT '0',
  `orders_date_finished` datetime DEFAULT NULL,
  `currency` char(3) DEFAULT NULL,
  `currency_value` decimal(14,6) DEFAULT NULL,
  `payment_class` varchar(32) NOT NULL,
  `shipping_method` varchar(255) NOT NULL,
  `shipping_class` varchar(32) NOT NULL,
  `shipping_module` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`orders_id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,2,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Z?rich','Switzerland','0445007878','nick@openstream.ch',1,'Nick Weisser','','','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Z?rich','Switzerland','',1,'Nick Weisser','','','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Z?rich','Switzerland','',1,'Nachnahme','','','','','',NULL,'2007-12-13 17:27:27',1,NULL,'CHF','1.000000','','','',NULL),(2,0,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rich','8049','','Switzerland','044-5007878','info@openstream.ch',1,'Nick Weisser','','','Openstream Internet Solutions','Wieslergasse 6','','Z?rich','8049','','Switzerland','',1,'Nick Weisser','','','Openstream Internet Solutions','Wieslergasse 6','','Z?rich','8049','','Switzerland','',1,'Nachnahme','','','','','','2008-01-23 18:42:34','2008-01-23 18:22:55',2,NULL,'CHF','1.000000','','','',NULL),(3,0,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rich','8049','','Switzerland','044-5007878','nick.weisser@gmail.com',1,'Nick Weisser','','','Openstream Internet Solutions','Friedhofstrasse 36','','Wahlwies','78333','','Germany','',5,'Nick Weisser','','','Openstream Internet Solutions','Wieslergasse 6','','Z?rich','8049','','Switzerland','',1,'Nachnahme','','','','','',NULL,'2008-01-23 21:32:07',1,NULL,'CHF','1.000000','','','',NULL),(4,2,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Z?rich','Switzerland','0445007878','nick@openstream.ch',1,'Nick Weisser','Nick','Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Z?rich','Switzerland','CH',1,'Nick Weisser','Nick','Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Z?rich','Switzerland','CH',1,'Nachnahme','','','','','',NULL,'2008-04-02 17:00:49',1,NULL,'CHF','1.000000','cod','Paketversand (1 x 3.5 kg) (Economy)','chp',NULL),(15,2,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','0445007878','nick@openstream.ch',1,'Nick Weisser','Nick','Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','CH',1,'Nick Weisser','Nick','Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','CH',1,'Vorauskasse (Überweisung)','','','','','',NULL,'2009-07-28 17:50:00',1,NULL,'CHF','1.000000','moneyorder','Paketversand (1 x 9.68 kg) (Economy)','chp','chp_ECO'),(8,2,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Z?rich','Switzerland','0445007878','nick@openstream.ch',1,'Nick Weisser','Nick','Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Z?rich','Switzerland','CH',1,'Nick Weisser','Nick','Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Z?rich','Switzerland','CH',1,'Vorauskasse (Überweisung)','','','','','',NULL,'2008-07-03 18:21:28',1,NULL,'CHF','1.000000','moneyorder','Paketversand (1 x 1.68 kg) (Economy)','chp','chp_ECO'),(11,2,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','0445007878','nick@openstream.ch',1,'Nick Weisser','Nick','Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','CH',1,'Nick Weisser','Nick','Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','CH',1,'Vorauskasse (Überweisung)','','','','','',NULL,'2009-05-11 22:01:58',1,NULL,'CHF','1.000000','moneyorder','Paketversand (1 x 2.18 kg) (Economy)','chp','chp_ECO'),(12,2,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','0445007878','nick@openstream.ch',1,'Nick Weisser','','','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','',1,'Nick Weisser','','','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','',1,'PostFinance (Postcard und E-Finance)','','','','',NULL,NULL,'2009-05-26 20:07:07',1,NULL,'CHF','1.000000','','','',NULL),(24,2,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','0445007878','nick@openstream.ch',5,'Nick Weisser','Nick','Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','CH',5,'Nick Weisser','Nick','Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','CH',5,'Vorauskasse (Überweisung)','','','','','','2009-11-10 14:32:28','2009-10-17 12:32:31',3,NULL,'CHF','1.000000','moneyorder','Paketversand (1 x 5.18 kg) (Economy)','chp','chp_ECO'),(25,26,'Tom Burri','','Seestrasse','','Zürich','8080','Aargau','Switzerland','000','burrito.tom@gmail.com',5,'Tom Burri','Tom','Burri','','Seestrasse','','Zürich','8080','Aargau','Switzerland','CH',5,'Tom Burri','Tom','Burri','','Seestrasse','','Zürich','8080','Aargau','Switzerland','CH',5,'Vorauskasse (Überweisung)','','','','','','2010-01-14 17:12:58','2010-01-14 17:06:47',3,NULL,'CHF','1.000000','moneyorder','Paketversand (1 x 0 kg) (Economy)','chp','chp_ECO'),(26,26,'Tom Burri','','Seestrasse','','Zürich','8080','','Switzerland','000','burrito.tom@gmail.com',5,'Tom Burri','','','','Seestrasse','','Zürich','8080','','Switzerland','',5,'Tom Burri','','','','Seestrasse','','Zürich','8080','','Switzerland','',5,'PostFinance (Postcard und E-Finance)','','','','',NULL,NULL,'2010-01-14 17:16:03',5,NULL,'CHF','1.000000','','','',NULL),(27,27,'wertz asdf','gh','kjhgzuiopü','','¨üpoiuztr','9444','','Switzerland','12787890','blu-port@bluewin.ch',5,'wertz asdf','','','gh','kjhgzuiopü','','¨üpoiuztr','9444','','Switzerland','',5,'wertz asdf','','','gh','kjhgzuiopü','','¨üpoiuztr','9444','','Switzerland','',5,'PostFinance (Postcard und E-Finance)','','','','',NULL,'2010-01-15 21:23:19','2010-01-15 21:22:53',1,NULL,'CHF','1.000000','','','',NULL),(29,28,'Claudio Hideki Imai','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','41 (0)44 500 78 78','claudio@openstream.ch',5,'Claudio Hideki Imai','','','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','',5,'Claudio Hideki Imai','','','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','',5,'PayPal Website Payments Standard','','','','',NULL,'2010-05-31 09:55:17','2010-05-31 09:50:07',1,NULL,'CHF','1.000000','','','',NULL),(31,28,'Claudio Hideki Imai','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','41 (0)44 500 78 78','claudio@openstream.ch',5,'Claudio Hideki Imai','','','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','',5,'Claudio Hideki Imai','','','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','',5,'PayPal Website Payments Standard','','','','',NULL,'2010-05-31 10:17:51','2010-05-31 10:17:06',1,NULL,'CHF','1.000000','','','',NULL),(32,28,'Claudio Hideki Imai','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','41 (0)44 500 78 78','claudio@openstream.ch',5,'Claudio Hideki Imai','','','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','',5,'Claudio Hideki Imai','','','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','',5,'PayPal Website Payments Standard','','','','',NULL,'2010-05-31 10:20:49','2010-05-31 10:20:12',1,NULL,'CHF','1.000000','','','',NULL),(33,29,'Barbara Berger','','Musterstrasse','','Bern','3000','Aargau','Switzerland','031 000 00 00','barbara_berger@hispeed.ch',5,'Barbara Berger','','','','Musterstrasse','','Bern','3000','Aargau','Switzerland','',5,'Barbara Berger','','','','Musterstrasse','','Bern','3000','Aargau','Switzerland','',5,'PostFinance (Postcard und E-Finance)','','','','',NULL,'2010-06-05 23:25:47','2010-05-31 20:02:40',7,NULL,'CHF','1.000000','','','',NULL),(34,30,'Reto Marti','','Schwerzistr. 40','','Nänikon','8606','','Switzerland','+41449417313','rm_marti@hotmail.com',5,'Reto Marti','','','','Schwerzistr. 40','','Nänikon','8606','','Switzerland','',5,'Reto Marti','','','','Schwerzistr. 40','','Nänikon','8606','','Switzerland','',5,'PayPal Website Payments Standard','','','','',NULL,NULL,'2010-06-03 12:35:56',6,NULL,'CHF','1.000000','','','',NULL),(36,2,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','0445007878','nick@openstream.ch',5,'Nick Weisser','','','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','',5,'Nick Weisser','','','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','',5,'PostFinance (Postcard und E-Finance)','','','','',NULL,'2010-06-09 19:00:15','2010-06-09 18:59:58',1,NULL,'CHF','1.000000','','','',NULL),(37,0,'Claudio Hideki Imai','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','41 (0)44 500 78 78','suporte@ecartgt.com.br',5,'Claudio Hideki Imai','Claudio Hideki','Imai','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','CH',5,'Claudio Hideki Imai','Claudio Hideki','Imai','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','CH',5,'Cash on Delivery','','','','','',NULL,'2010-06-10 06:43:26',1,NULL,'CHF','1.000000','cod','Swiss Post - Parcel (1 x 1.68 kg) (Economy)','chp','chp_ECO'),(38,2,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','0445007878','nick@openstream.ch',5,'Nick Weisser','','','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','',5,'Nick Weisser','','','Openstream Internet Solutions','Wieslergasse 6','','Z?rch','8049','Zürich','Switzerland','',5,'PostFinance (Postcard und E-Finance)','','','','',NULL,NULL,'2010-06-15 15:31:38',5,NULL,'CHF','1.000000','','','',NULL),(39,0,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','0445007878','info@openstream.ch',5,'Nick Weisser','Nick','Weisser','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','CH',5,'Nick Weisser','Nick','Weisser','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','CH',5,'Vorauskasse (Überweisung)','','','','','',NULL,'2010-06-24 09:32:38',1,NULL,'CHF','1.000000','moneyorder','Paketversand (1 x 3.5 kg) (Economy)','chp','chp_ECO');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products`
--

DROP TABLE IF EXISTS `orders_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_products` (
  `orders_products_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT '0',
  `products_id` int(11) NOT NULL DEFAULT '0',
  `products_model` varchar(12) DEFAULT NULL,
  `products_name` varchar(64) NOT NULL,
  `products_price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `final_price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `products_tax` decimal(7,4) NOT NULL DEFAULT '0.0000',
  `products_quantity` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`orders_products_id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_products`
--

LOCK TABLES `orders_products` WRITE;
/*!40000 ALTER TABLE `orders_products` DISABLE KEYS */;
INSERT INTO `orders_products` VALUES (1,1,4,'80004','Sony HDR-HC1','4033.4572','4033.4572','7.6000',1),(2,2,2,'80002','Monster Truck BigFoot','1013.0112','1013.0112','7.6000',1),(3,3,1,'','R/C Buggy HBX W2','157.0632','157.0632','7.6000',1),(4,4,1,'','R/C Buggy HBX W2','157.0632','157.0632','7.6000',1),(22,15,1,'','R/C Buggy HBX W2','157.0632','157.0632','7.6000',1),(23,15,5,'80005','HP Compaq 2710p Notebook','1719.3309','1719.3309','7.6000',1),(9,8,5,'80005','HP Compaq 2710p Notebook','1719.3309','1719.3309','7.6000',1),(24,15,7,'80007','R/C Katamaran','74.2565','74.2565','7.6000',1),(12,11,5,'80005','HP Compaq 2710p Notebook','1719.3309','1719.3309','7.6000',1),(13,11,4,'80004','Sony HDR-HC1','4033.4572','4033.4572','7.6000',2),(14,12,1,'','R/C Buggy HBX W2','157.0632','157.0632','7.6000',1),(15,12,5,'80005','HP Compaq 2710p Notebook','1719.3309','1719.3309','7.6000',1),(21,14,7,'80007','R/C Katamaran','74.2565','74.2565','7.6000',1),(20,14,5,'80005','HP Compaq 2710p Notebook','1719.3309','1719.3309','7.6000',1),(19,14,1,'','R/C Buggy HBX W2','157.0632','157.0632','7.6000',1),(33,24,5,'80005','HP Compaq 2710p Notebook','1719.3309','1719.3309','7.6000',1),(34,24,1,'','R/C Buggy HBX W2','157.0632','157.0632','7.6000',1),(35,25,12,'A-3450.88','3G (Artikelname)','148.6989','148.6989','7.6000',1),(36,25,12,'A-3450.88','','148.6989','148.6989','7.6000',1),(37,26,1,'80001','R/C Buggy HBX W2','157.0600','157.0600','7.6000',1),(38,27,5,'80005','HP Compaq 2710p Notebook','1719.3300','1719.3300','7.6000',1),(40,29,1,'','R/C Buggy HBX W2','157.0632','157.0632','7.6000',1),(42,31,7,'80007','R/C Katamaran','74.2565','74.2565','7.6000',1),(43,32,7,'80007','R/C Katamaran','74.2565','74.2565','7.6000',1),(44,33,7,'80007','R/C Katamaran','74.2565','74.2565','7.6000',1),(45,34,1,'','R/C Buggy HBX W2','157.0632','157.0632','7.6000',1),(47,36,2,'80002','Monster Truck BigFoot','1013.0112','1013.0112','7.6000',1),(48,37,5,'80005','HP Compaq 2710p Notebook','1719.3309','1719.3309','7.6000',1),(49,38,5,'80005','HP Compaq 2710p Notebook','1719.3309','1719.3309','7.6000',1),(50,39,1,'','R/C Buggy HBX W2','157.0632','157.0632','7.6000',1);
/*!40000 ALTER TABLE `orders_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products_attributes`
--

DROP TABLE IF EXISTS `orders_products_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_products_attributes` (
  `orders_products_attributes_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT '0',
  `orders_products_id` int(11) NOT NULL DEFAULT '0',
  `products_options` varchar(32) NOT NULL,
  `products_options_values` varchar(32) NOT NULL,
  `options_values_price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `price_prefix` char(1) NOT NULL,
  PRIMARY KEY (`orders_products_attributes_id`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_products_attributes`
--

LOCK TABLES `orders_products_attributes` WRITE;
/*!40000 ALTER TABLE `orders_products_attributes` DISABLE KEYS */;
INSERT INTO `orders_products_attributes` VALUES (1,4,4,'Name','Hans Mustermann','0.0000','+'),(2,4,4,'Bilddatei','1tux.png','0.0000','+'),(23,15,23,'Betriebssystem','Bitte wählen','0.0000','+'),(22,15,23,'Festplatte','60 GB 4200 rpm SMART PATA','0.0000','+'),(21,15,23,'RAM','1 GB 667 MHz DDR2 SDRAM','0.0000','+'),(6,8,9,'Festplatte','60 GB 4200 rpm SMART PATA','0.0000','+'),(7,8,9,'Betriebssystem','Bitte w?hlen','0.0000','+'),(8,8,9,'RAM','1 GB 667 MHz DDR2 SDRAM','0.0000','+'),(9,11,12,'Betriebssystem','Bitte w?hlen','0.0000','+'),(10,11,12,'Festplatte','60 GB 4200 rpm SMART PATA','0.0000','+'),(11,11,12,'RAM','1 GB 667 MHz DDR2 SDRAM','0.0000','+'),(12,12,15,'RAM','1 GB 667 MHz DDR2 SDRAM','0.0000','+'),(13,12,15,'Festplatte','60 GB 4200 rpm SMART PATA','0.0000','+'),(14,12,15,'Betriebssystem','Bitte wählen','0.0000','+'),(20,14,20,'Betriebssystem','Bitte wählen','0.0000','+'),(19,14,20,'Festplatte','60 GB 4200 rpm SMART PATA','0.0000','+'),(18,14,20,'RAM','1 GB 667 MHz DDR2 SDRAM','0.0000','+'),(39,24,33,'Betriebssystem','Bitte wählen','0.0000','+'),(40,24,33,'Festplatte','60 GB 4200 rpm SMART PATA','0.0000','+'),(41,24,33,'RAM','1 GB 667 MHz DDR2 SDRAM','0.0000','+'),(42,25,35,'Farbe','21 Black','0.0000','+'),(43,25,35,'Modell','3GS','0.0000','+'),(44,25,36,'Modell','3GS','0.0000','+'),(45,25,36,'Farbe','33 Weiss','0.0000','+'),(46,27,38,'Festplatte','60 GB 4200 rpm SMART PATA','0.0000','+'),(47,27,38,'Betriebssystem','Bitte wählen','0.0000','+'),(48,27,38,'RAM','1 GB 667 MHz DDR2 SDRAM','0.0000','+'),(49,37,48,'Hard Disk','60 GB 4200 rpm SMART PATA','0.0000','+'),(50,37,48,'Operating System','Please choose','0.0000','+'),(51,37,48,'RAM','1 GB 667 MHz DDR2 SDRAM','0.0000','+'),(52,38,49,'Betriebssystem','Linux Ubuntu Gibbon 7.10','0.0000','+'),(53,38,49,'Festplatte','60 GB 4200 rpm SMART PATA','0.0000','+'),(54,38,49,'RAM','1 GB 667 MHz DDR2 SDRAM','0.0000','+');
/*!40000 ALTER TABLE `orders_products_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products_download`
--

DROP TABLE IF EXISTS `orders_products_download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_products_download` (
  `orders_products_download_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT '0',
  `orders_products_id` int(11) NOT NULL DEFAULT '0',
  `orders_products_filename` varchar(255) NOT NULL,
  `download_maxdays` int(2) NOT NULL DEFAULT '0',
  `download_count` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`orders_products_download_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_products_download`
--

LOCK TABLES `orders_products_download` WRITE;
/*!40000 ALTER TABLE `orders_products_download` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_products_download` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_status`
--

DROP TABLE IF EXISTS `orders_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_status` (
  `orders_status_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL DEFAULT '1',
  `orders_status_name` varchar(32) NOT NULL,
  PRIMARY KEY (`orders_status_id`,`language_id`),
  KEY `idx_orders_status_name` (`orders_status_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_status`
--

LOCK TABLES `orders_status` WRITE;
/*!40000 ALTER TABLE `orders_status` DISABLE KEYS */;
INSERT INTO `orders_status` VALUES (1,1,'Pending'),(1,2,'Offen'),(1,3,'Pendiente'),(2,1,'Processing'),(2,2,'In Bearbeitung'),(2,3,'Proceso'),(3,1,'Delivered'),(3,2,'Versendet'),(3,3,'Entregado'),(1,4,'Offen'),(2,4,'In Bearbeitung'),(3,4,'Versendet'),(1,5,'Offen'),(2,5,'In Bearbeitung'),(3,5,'Versendet'),(4,2,'Storniert'),(4,1,'Cancelled'),(4,5,'Cancelled'),(4,4,'Cancelled'),(4,3,'Cancelled'),(5,2,'Preparing [PostFinance]'),(5,1,'Preparing [PostFinance]'),(5,5,'Preparing [PostFinance]'),(5,4,'Preparing [PostFinance]'),(5,3,'Preparing [PostFinance]'),(6,2,'Preparing [PayPal Standard]'),(6,1,'Preparing [PayPal Standard]'),(6,5,'Preparing [PayPal Standard]'),(6,4,'Preparing [PayPal Standard]'),(6,3,'Preparing [PayPal Standard]'),(7,2,'Warten auf Zahlungseingang'),(7,1,''),(7,5,''),(7,4,''),(7,3,'');
/*!40000 ALTER TABLE `orders_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_status_history`
--

DROP TABLE IF EXISTS `orders_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_status_history` (
  `orders_status_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT '0',
  `orders_status_id` int(5) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `customer_notified` int(1) DEFAULT '0',
  `comments` text,
  PRIMARY KEY (`orders_status_history_id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_status_history`
--

LOCK TABLES `orders_status_history` WRITE;
/*!40000 ALTER TABLE `orders_status_history` DISABLE KEYS */;
INSERT INTO `orders_status_history` VALUES (1,1,1,'2007-12-13 17:27:27',1,''),(2,2,1,'2008-01-23 18:22:55',1,'test'),(3,2,2,'2008-01-23 18:42:35',1,'Test Aktualisierung des Status.'),(4,3,1,'2008-01-23 21:32:07',1,''),(5,4,1,'2008-04-02 17:00:49',1,'Test File-Upload'),(14,15,1,'2009-07-28 17:50:00',1,'test'),(7,8,1,'2008-07-03 18:21:28',1,'Testbestellung!'),(11,11,1,'2009-05-11 22:01:58',1,''),(12,14,5,'2009-06-11 14:48:23',0,''),(13,14,1,'2009-06-11 14:48:23',1,'Post Fianance IPN Invalid [Declined]'),(18,24,2,'2009-10-17 12:33:36',1,'Vielen Dank für Ihre Bestellung!\r\n\r\nSie erhalten die Ware innerhalb der nächsten 1-2 Tage per Post.\r\n\r\nMfG, Nick Weisser'),(17,24,1,'2009-10-17 12:32:31',1,''),(19,24,3,'2009-10-17 12:34:20',1,''),(20,24,3,'2009-11-10 14:32:28',1,'test'),(21,25,1,'2010-01-14 17:06:47',1,'Anmerkungen zur Bestellung - Test - Vorauskasse'),(22,25,1,'2010-01-14 17:12:05',1,'Bestellung geändert wie besprochen'),(23,25,3,'2010-01-14 17:12:58',1,''),(24,27,5,'2010-01-15 21:23:19',0,'nicht ausführen'),(25,27,5,'2010-01-15 21:23:19',0,'nicht ausführen'),(26,27,1,'2010-01-15 21:23:19',1,'Post Finance IPN Verified [Payment has been authorized]'),(27,27,1,'2010-01-15 21:23:19',1,'Post Finance IPN Verified [Payment has been authorized]'),(28,29,6,'2010-05-31 09:50:53',0,''),(29,29,1,'2010-05-31 09:50:53',0,'PayPal IPN Verified [Pending (Verified; CHF177.00); multi_currency]'),(30,29,1,'2010-05-31 09:51:55',1,''),(31,29,1,'2010-05-31 09:55:17',1,''),(32,31,6,'2010-05-31 10:17:44',0,''),(33,31,1,'2010-05-31 10:17:44',0,'PayPal IPN Verified [Pending (Verified; CHF87.90); multi_currency]'),(34,31,1,'2010-05-31 10:17:51',1,''),(35,32,6,'2010-05-31 10:20:48',0,''),(36,32,1,'2010-05-31 10:20:48',0,'PayPal IPN Verified [Pending (Verified; CHF87.90); multi_currency]'),(37,32,1,'2010-05-31 10:20:49',1,''),(38,33,3,'2010-06-05 18:14:02',1,''),(39,33,7,'2010-06-05 23:25:47',0,''),(40,36,5,'2010-06-09 19:00:15',0,''),(41,36,1,'2010-06-09 19:00:15',1,'Post Finance IPN Verified [Payment has been authorized]'),(42,37,1,'2010-06-10 06:43:26',1,'testing pwa'),(43,39,1,'2010-06-24 09:32:38',1,'');
/*!40000 ALTER TABLE `orders_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_total`
--

DROP TABLE IF EXISTS `orders_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_total` (
  `orders_total_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `text` varchar(255) NOT NULL,
  `value` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `class` varchar(32) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`orders_total_id`),
  KEY `idx_orders_total_orders_id` (`orders_id`)
) ENGINE=MyISAM AUTO_INCREMENT=167 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_total`
--

LOCK TABLES `orders_total` WRITE;
/*!40000 ALTER TABLE `orders_total` DISABLE KEYS */;
INSERT INTO `orders_total` VALUES (1,1,'Zwischensumme:','CHF 4,340.00','4340.0000','ot_subtotal',1),(2,1,'Paketversand (1 x 0.25 kg) (Priority):','CHF 8.00','8.0000','ot_shipping',2),(3,1,'7.6% MwSt.:','CHF 306.54','306.5428','ot_tax',3),(4,1,'<b>Summe</b>:','<b>CHF 4,348.00</b>','4348.0000','ot_total',4),(5,2,'Zwischensumme:','CHF 1,090.00','1090.0000','ot_subtotal',1),(6,2,'Paketversand (1 x 5.8 kg) (Economy):','CHF 11.00','11.0000','ot_shipping',2),(7,2,'7.6% MwSt.:','CHF 76.99','76.9888','ot_tax',3),(8,2,'<b>Summe</b>:','<b>CHF 1,101.00</b>','1101.0000','ot_total',4),(9,3,'Zwischensumme:','CHF 169.00','169.0000','ot_subtotal',1),(10,3,'Paketversand (1 x 3.5 kg) (Economy):','CHF 35.00','35.0000','ot_shipping',2),(11,3,'7.6% MwSt.:','CHF 11.94','11.9368','ot_tax',3),(12,3,'<b>Summe</b>:','<b>CHF 204.00</b>','204.0000','ot_total',4),(13,4,'Zwischensumme:','CHF 169.00','169.0000','ot_subtotal',1),(14,4,'Paketversand (1 x 3.5 kg) (Economy):','CHF 8.00','8.0000','ot_shipping',2),(15,4,'7.6% MwSt.:','CHF 11.94','11.9368','ot_tax',3),(16,4,'<b>Summe</b>:','<b>CHF 177.00</b>','177.0000','ot_total',4),(59,15,'Coupon (<i>test123</i>):','CHF -25.00','-25.0000','ot_coupon',4),(58,15,'7.6% MwSt.:','CHF 148.25','148.2494','ot_tax',3),(56,15,'Zwischensumme:','CHF 2,098.90','2098.9000','ot_subtotal',1),(57,15,'Paketversand (1 x 9.68 kg) (Economy):','CHF 11.00','11.0000','ot_shipping',2),(60,15,'<b>Summe</b>:','<b>CHF 2,084.90</b>','2084.9000','ot_total',5),(28,8,'Zwischensumme:','CHF 1,850.00','1850.0000','ot_subtotal',1),(29,8,'Paketversand (1 x 1.68 kg) (Economy):','CHF 6.00','6.0000','ot_shipping',2),(30,8,'7.6% MwSt.:','CHF 130.67','130.6691','ot_tax',3),(31,8,'<b>Summe</b>:','<b>CHF 1,856.00</b>','1856.0000','ot_total',4),(40,11,'Zwischensumme:','CHF 10,530.00','10530.0000','ot_subtotal',1),(41,11,'Paketversand (1 x 2.18 kg) (Economy):','CHF 8.00','8.0000','ot_shipping',2),(42,11,'7.6% MwSt.:','CHF 743.75','743.7546','ot_tax',3),(43,11,'<b>Summe</b>:','<b>CHF 10,538.00</b>','10538.0000','ot_total',4),(44,12,'Zwischensumme:','CHF 2,019.00','2019.0000','ot_subtotal',1),(45,12,'Paketversand (1 x 5.18 kg) (Economy):','CHF 11.00','11.0000','ot_shipping',2),(46,12,'7.6% MwSt.:','CHF 142.61','142.6059','ot_tax',3),(47,12,'<b>Summe</b>:','<b>CHF 2,030.00</b>','2030.0000','ot_total',4),(54,14,'7.6% MwSt.:','CHF 148.25','148.2494','ot_tax',3),(53,14,'Paketversand (1 x 9.68 kg) (Economy):','CHF 11.00','11.0000','ot_shipping',2),(52,14,'Zwischensumme:','CHF 2,098.90','2098.9000','ot_subtotal',1),(55,14,'<b>Summe</b>:','<b>CHF 2,109.90</b>','2109.9000','ot_total',4),(93,24,'Zwischensumme:','CHF 2,019.00','2019.0000','ot_subtotal',1),(94,24,'Paketversand (1 x 5.18 kg) (Economy):','CHF 11.00','11.0000','ot_shipping',2),(95,24,'7.6% MwSt.:','CHF 142.61','142.6059','ot_tax',3),(96,24,'<b>Summe</b>:','<b>CHF 2,030.00</b>','2030.0000','ot_total',5),(105,25,'Coupon (<i>Test1</i>):','CHF-800.00','-800.0000','ot_coupon',4),(104,25,'7.6% MwSt.:','CHF22.60','22.6022','ot_tax',3),(103,25,'Paketversand (1 x 0 kg) (Economy):','CHF6.00','6.0000','ot_shipping',2),(102,25,'Zwischensumme:','CHF320.00','320.0000','ot_subtotal',1),(106,25,'<b>Summe</b>:','<b>CHF326.00</b>','326.0000','ot_total',5),(107,26,'Zwischensumme:','CHF 169.00','169.0000','ot_subtotal',1),(108,26,'Paketversand (1 x 3.5 kg) (Economy):','CHF 8.00','8.0000','ot_shipping',2),(109,26,'7.6% MwSt.:','CHF 11.94','11.9368','ot_tax',3),(110,26,'<b>Summe</b>:','<b>CHF 177.00</b>','177.0000','ot_total',5),(111,27,'Zwischensumme:','CHF 1,850.00','1850.0000','ot_subtotal',1),(112,27,'Paketversand (1 x 1.68 kg) (Economy):','CHF 6.00','6.0000','ot_shipping',2),(113,27,'7.6% MwSt.:','CHF 130.67','130.6691','ot_tax',3),(114,27,'<b>Summe</b>:','<b>CHF 1,856.00</b>','1856.0000','ot_total',5),(121,29,'7.6% MwSt.:','CHF 11.94','11.9368','ot_tax',3),(120,29,'Swiss Post - Parcel (1 x 3.5 kg) (Economy):','CHF 8.00','8.0000','ot_shipping',2),(119,29,'Sub-Total:','CHF 169.00','169.0000','ot_subtotal',1),(122,29,'Total:','<b>CHF 177.00</b>','177.0000','ot_total',5),(129,31,'7.6% MwSt.:','CHF 5.64','5.6435','ot_tax',3),(128,31,'Swiss Post - Parcel (1 x 4.5 kg) (Economy):','CHF 8.00','8.0000','ot_shipping',2),(127,31,'Sub-Total:','CHF 79.90','79.9000','ot_subtotal',1),(130,31,'Total:','<b>CHF 87.90</b>','87.9000','ot_total',5),(131,32,'Sub-Total:','CHF 79.90','79.9000','ot_subtotal',1),(132,32,'Swiss Post - Parcel (1 x 4.5 kg) (Economy):','CHF 8.00','8.0000','ot_shipping',2),(133,32,'7.6% MwSt.:','CHF 5.64','5.6435','ot_tax',3),(134,32,'Total:','<b>CHF 87.90</b>','87.9000','ot_total',5),(145,33,'7.6% MwSt.:','CHF5.64','5.6435','ot_tax',3),(144,33,'Paketversand (1 x 4.5 kg) (Economy):','CHF8.00','8.0000','ot_shipping',2),(143,33,'Zwischensumme:','CHF79.90','79.9000','ot_subtotal',1),(139,34,'Sub-Total:','CHF 169.00','169.0000','ot_subtotal',1),(140,34,'Swiss Post - Parcel (1 x 3.5 kg) (Priority):','CHF 10.00','10.0000','ot_shipping',2),(141,34,'7.6% MwSt.:','CHF 11.94','11.9368','ot_tax',3),(142,34,'Total:','<b>CHF 179.00</b>','179.0000','ot_total',5),(146,33,'<b>Summe</b>:','<b>CHF87.90</b>','87.9000','ot_total',4),(153,36,'7.6% MwSt.:','CHF 76.99','76.9888','ot_tax',3),(152,36,'Paketversand (1 x 5.8 kg) (Economy):','CHF 11.00','11.0000','ot_shipping',2),(151,36,'Zwischensumme:','CHF 1\'090.00','1090.0000','ot_subtotal',1),(154,36,'<b>Summe</b>:','<b>CHF 1\'101.00</b>','1101.0000','ot_total',5),(155,37,'Sub-Total:','CHF 1\'850.00','1850.0000','ot_subtotal',1),(156,37,'Swiss Post - Parcel (1 x 1.68 kg) (Economy):','CHF 6.00','6.0000','ot_shipping',2),(157,37,'7.6% MwSt.:','CHF 130.67','130.6691','ot_tax',3),(158,37,'Total:','<b>CHF 1\'856.00</b>','1856.0000','ot_total',5),(159,38,'Zwischensumme:','CHF 1\'850.00','1850.0000','ot_subtotal',1),(160,38,'Paketversand (1 x 1.68 kg) (Economy):','CHF 6.00','6.0000','ot_shipping',2),(161,38,'7.6% MwSt.:','CHF 130.67','130.6691','ot_tax',3),(162,38,'<b>Summe</b>:','<b>CHF 1\'856.00</b>','1856.0000','ot_total',5),(163,39,'Zwischensumme:','CHF 169.00','169.0000','ot_subtotal',1),(164,39,'Paketversand (1 x 3.5 kg) (Economy):','CHF 8.00','8.0000','ot_shipping',2),(165,39,'7.6% MwSt.:','CHF 11.94','11.9368','ot_tax',3),(166,39,'<b>Summe</b>:','<b>CHF 177.00</b>','177.0000','ot_total',5);
/*!40000 ALTER TABLE `orders_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `products_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_quantity` int(4) NOT NULL DEFAULT '0',
  `products_model` varchar(12) DEFAULT NULL,
  `products_image` varchar(64) DEFAULT NULL,
  `products_image2` varchar(64) NOT NULL,
  `products_image3` varchar(64) NOT NULL,
  `products_image4` varchar(64) NOT NULL,
  `products_price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `products_date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `products_last_modified` datetime DEFAULT NULL,
  `products_date_available` datetime DEFAULT NULL,
  `products_weight` decimal(5,2) NOT NULL DEFAULT '0.00',
  `products_status` tinyint(1) NOT NULL DEFAULT '0',
  `products_tax_class_id` int(11) NOT NULL DEFAULT '0',
  `manufacturers_id` int(11) DEFAULT NULL,
  `products_ordered` int(11) NOT NULL DEFAULT '0',
  `products_sort_order` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`products_id`),
  KEY `idx_products_date_added` (`products_date_added`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,-7,'','buggy-hbx.jpg','buggy-hbx-02.jpg','buggy-hbx-03.jpg','buggy-hbx-04.jpg','157.0632','2007-11-04 14:11:17','2007-11-04 14:42:50',NULL,'3.50',1,1,1,7,0),(2,8,'80002','131059.jpg','136620.jpg','145363.jpg','145260.jpg','1013.0112','2007-11-04 15:01:18','2008-05-29 13:59:50',NULL,'5.80',1,1,2,2,0),(4,7,'80004','sony-hdr.jpg','sony-hdr-02.jpg','sony-hdr-03.jpg','','4033.4572','2007-11-05 02:33:13','2007-11-05 02:36:50',NULL,'0.25',1,1,4,3,0),(5,5,'80005','hp-2710p.jpg','hp-2710p-02.jpg','','','1719.3309','2007-11-05 03:03:14','2010-07-14 15:14:01',NULL,'1.68',1,1,5,5,0),(6,10,'80006','vaio-micro-pc.jpg','vaio-micro-pc-02.jpg','vaio-micro-pc-03.jpg','','2137.5465','2007-11-05 03:18:00','2010-04-13 23:33:00',NULL,'0.50',1,1,4,0,0),(7,4,'80007','katamaran.jpg','katamaran-02.jpg','katamaran-03.jpg','PRB3300_md.jpg.png','74.2565','2007-11-05 03:34:24','2010-06-02 17:53:14',NULL,'4.50',1,1,1,6,0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_attributes`
--

DROP TABLE IF EXISTS `products_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_attributes` (
  `products_attributes_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT '0',
  `options_id` int(11) NOT NULL DEFAULT '0',
  `options_values_id` int(11) NOT NULL DEFAULT '0',
  `options_values_price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `price_prefix` char(1) NOT NULL,
  `products_options_sort_order` int(3) NOT NULL DEFAULT '0',
  `products_attributes_weight` decimal(5,2) NOT NULL DEFAULT '0.00',
  `products_attributes_weight_prefix` char(1) NOT NULL,
  PRIMARY KEY (`products_attributes_id`)
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_attributes`
--

LOCK TABLES `products_attributes` WRITE;
/*!40000 ALTER TABLE `products_attributes` DISABLE KEYS */;
INSERT INTO `products_attributes` VALUES (66,5,3,6,'0.0000','+',4,'0.00','+'),(65,5,3,7,'0.0000','+',5,'0.00','+'),(64,5,3,8,'0.0000','+',2,'0.00','+'),(63,5,3,9,'0.0000','+',1,'0.00','+'),(62,5,3,10,'0.0000','+',-1,'0.00','+'),(61,5,3,11,'0.0000','+',3,'0.00','+'),(60,5,2,3,'0.0000','+',1,'0.00','+'),(59,5,2,4,'46.4684','+',2,'0.00','+'),(58,5,2,5,'92.9368','+',3,'0.00','+'),(57,5,1,1,'0.0000','+',0,'0.00','+'),(56,5,1,2,'157.9925','+',0,'0.00','+');
/*!40000 ALTER TABLE `products_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_attributes_download`
--

DROP TABLE IF EXISTS `products_attributes_download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_attributes_download` (
  `products_attributes_id` int(11) NOT NULL DEFAULT '0',
  `products_attributes_filename` varchar(255) NOT NULL,
  `products_attributes_maxdays` int(2) DEFAULT '0',
  `products_attributes_maxcount` int(2) DEFAULT '0',
  PRIMARY KEY (`products_attributes_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_attributes_download`
--

LOCK TABLES `products_attributes_download` WRITE;
/*!40000 ALTER TABLE `products_attributes_download` DISABLE KEYS */;
/*!40000 ALTER TABLE `products_attributes_download` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_description`
--

DROP TABLE IF EXISTS `products_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_description` (
  `products_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL DEFAULT '1',
  `products_name` varchar(64) NOT NULL,
  `products_description` text,
  `products_url` varchar(255) DEFAULT NULL,
  `products_viewed` int(5) DEFAULT '0',
  `products_seo_url` varchar(100) NOT NULL,
  `products_head_title_tag` varchar(80) DEFAULT NULL,
  `products_head_desc_tag` longtext,
  `products_head_keywords_tag` longtext,
  PRIMARY KEY (`products_id`,`language_id`),
  KEY `products_name` (`products_name`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_description`
--

LOCK TABLES `products_description` WRITE;
/*!40000 ALTER TABLE `products_description` DISABLE KEYS */;
INSERT INTO `products_description` VALUES (1,2,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p><ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul><p><br /><strong>Beschreibung:</strong></p><ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul><p><br /><strong>Lieferumfang:</strong></p><ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',669,'','R/C Buggy HBX W2','Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;Technische Daten:Mode: RC Buggy HBX W2Ma&szlig;stab: 1:10Mottorart: Elektromotor Luftgek&uuml;hltmax. Geschwindigkeit: ca.60km/hStromversorgung: 7,2V 1800mAh Ni-Cd AkkuKarosserie: aus LexanRadstand: ca.260mmAbmessungen (LxBxH): 400mm/260mm/180mmGewicht: ca.1380g (fahrbereit)Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rtsdosierbare Regelung der GeschwindigkeitFrequenz: 27 Mhz auswechselbarer Quarz.Durchmesser der R&auml;der: 8,5 cmBeschreibung:F&auml;hrt bis zu ca. 60 Km/h!4x4 Allradantrieb!spitzen BeschleunigungEinzelradaufh&auml;ngungEinzelradfederungMa&szlig;stab 1:10luftgek&uuml;hlter starker elktro- RippenmotorVersiegeltes Getriebeelektronischer FahrtenreglerServolenkungChassis des Buggys ist &uuml;berwiegen aus Metall hergestelltWechselbares Cover strapazierf&auml;hig aus PolycarbonatLuftgef&uuml;llte noppen GummireifenFahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)Der Buggy ist fertig montiert und sofort startklarProfi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!Starker Akkupack 1800mAh 7,2VSchnellladeger&auml;t Ladedauer nur 5 Stundenmit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.Buggy wird in verschiedenen Farben geliefert.Lieferumfang:RC Buggy HBX W2Profi Pistolenfernbedienung proportionalHochleistungs- AkkupackLadeger&auml;tBatterien f&uuml;r FernsteuerungAusf&uuml;hrliches Anleitung mit Bildern','R/C Buggy HBX W2'),(1,1,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p> <ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul> <p><br /><strong>Beschreibung:</strong></p> <ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul> <p><br /><strong>Lieferumfang:</strong></p> <ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',942,'','R/C Buggy HBX W2','R/C Buggy HBX W2','R/C Buggy HBX W2'),(1,5,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p> <ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul> <p><br /><strong>Beschreibung:</strong></p> <ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul> <p><br /><strong>Lieferumfang:</strong></p> <ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',190,'','R/C Buggy HBX W2','R/C Buggy HBX W2','R/C Buggy HBX W2'),(1,4,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p> <ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul> <p><br /><strong>Beschreibung:</strong></p> <ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul> <p><br /><strong>Lieferumfang:</strong></p> <ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',185,'','R/C Buggy HBX W2','R/C Buggy HBX W2','R/C Buggy HBX W2'),(1,3,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p> <ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul> <p><br /><strong>Beschreibung:</strong></p> <ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul> <p><br /><strong>Lieferumfang:</strong></p> <ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',235,'','R/C Buggy HBX W2','R/C Buggy HBX W2','R/C Buggy HBX W2'),(2,2,'Monster Truck BigFoot','<p class=\"\\&quot;bodytext\\&quot;\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"\\&quot;bodytext\\&quot;\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"\\&quot;bodytext\\&quot;\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"\\&quot;bodytext\\&quot;\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"\\&quot;bodytext\\&quot;\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"\\&quot;bodytext\\&quot;\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"\\&quot;bodytext\\&quot;\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"\\&quot;bodytext\\&quot;\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"\\&quot;bodytext\\&quot;\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',636,'','Monster Truck BigFoot','THE BIGGEST BY ZEED!  BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um!  Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert.  Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los!  Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet.  Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t.  Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn.  Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten.  Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke.  Chassis:  L&auml;nge gesamt 700mm H&ouml;he 350mm Breite: Vorne 490mm / Hinten 510mm Spurweite: Vorne 380mm / Hinten 410mm Radstand 485mm Bodenfreiheit 92mm Gewicht 9,9kg 4mm Aluminiumchassis bel&uuml;ftete Doppelscheibenbremse Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use  Motor:  2 Takt Benzinmotor Luftk&uuml;hlung 23ccm Hubraum Maximale Leistung: 2,2PS Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) 700ccm Treibstofftank Seilzugstarter  Fernsteuerung:  2 Kanal FM Fernsteuerung Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft ','Monster Truck BigFoot'),(2,1,'Monster Truck BigFoot','<p class=\"\\&quot;bodytext\\&quot;\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"\\&quot;bodytext\\&quot;\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"\\&quot;bodytext\\&quot;\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"\\&quot;bodytext\\&quot;\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"\\&quot;bodytext\\&quot;\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"\\&quot;bodytext\\&quot;\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"\\&quot;bodytext\\&quot;\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"\\&quot;bodytext\\&quot;\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"\\&quot;bodytext\\&quot;\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',758,'','Monster Truck BigFoot','Monster Truck BigFoot','Monster Truck BigFoot'),(2,5,'Monster Truck BigFoot','<p class=\"\\&quot;bodytext\\&quot;\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"\\&quot;bodytext\\&quot;\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"\\&quot;bodytext\\&quot;\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"\\&quot;bodytext\\&quot;\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"\\&quot;bodytext\\&quot;\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"\\&quot;bodytext\\&quot;\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"\\&quot;bodytext\\&quot;\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"\\&quot;bodytext\\&quot;\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"\\&quot;bodytext\\&quot;\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',199,'','Monster Truck BigFoot','Monster Truck BigFoot','Monster Truck BigFoot'),(2,4,'Monster Truck BigFoot','<p class=\"\\&quot;bodytext\\&quot;\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"\\&quot;bodytext\\&quot;\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"\\&quot;bodytext\\&quot;\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"\\&quot;bodytext\\&quot;\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"\\&quot;bodytext\\&quot;\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"\\&quot;bodytext\\&quot;\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"\\&quot;bodytext\\&quot;\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"\\&quot;bodytext\\&quot;\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"\\&quot;bodytext\\&quot;\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',172,'','Monster Truck BigFoot','Monster Truck BigFoot','Monster Truck BigFoot'),(2,3,'Monster Truck BigFoot','<p class=\"\\&quot;bodytext\\&quot;\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"\\&quot;bodytext\\&quot;\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"\\&quot;bodytext\\&quot;\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"\\&quot;bodytext\\&quot;\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"\\&quot;bodytext\\&quot;\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"\\&quot;bodytext\\&quot;\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"\\&quot;bodytext\\&quot;\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"\\&quot;bodytext\\&quot;\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"\\&quot;bodytext\\&quot;\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"\\&quot;bodytext\\&quot;\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',188,'','Monster Truck BigFoot','Monster Truck BigFoot','Monster Truck BigFoot'),(4,2,'Sony HDR-HC1','<ul><li>10fach optischer Zoom</li><li>3 Megapixel CMOS-Sensor</li><li>14 bit HD DXP Analog/Digital-Wandler</li><li>2,7 Zoll Hybrid LCD-Monitor</li><li>123.000 Pixel</li><li>Steady Shot Bildstabilisator</li><li>Fotofunktion Fotos mit 1920 x 1440 Pixel</li><li>Speicherm&ouml;glichkeit auf Memory Stick Duo</li><li>Anschl&uuml;sse i.LlNK Ein- und Ausgang</li><li>USB</li><li>Komponenten-Ausgang</li><li>Audio/Video- und S-Video-Ausgang</li><li>Abmessungen 71 x 94 x 188 mm</li><li>Gewicht 670 g</li></ul>','',290,'','Sony HDR-HC1','10fach optischer Zoom3 Megapixel CMOS-Sensor14 bit HD DXP Analog/Digital-Wandler2,7 Zoll Hybrid LCD-Monitor123.000 PixelSteady Shot BildstabilisatorFotofunktion Fotos mit 1920 x 1440 PixelSpeicherm&ouml;glichkeit auf Memory Stick DuoAnschl&uuml;sse i.LlNK Ein- und AusgangUSBKomponenten-AusgangAudio/Video- und S-Video-AusgangAbmessungen 71 x 94 x 188 mmGewicht 670 g','Sony HDR-HC1'),(4,1,'Sony HDR-HC1','The Sony Handycam HDR-HC1\'s real draw is its ability to record 1080i HD video on standard MiniDV cassettes; it uses the recently implemented HDV format, which employs MPEG-2 compression rather than DV. Not much software currently supports HDV for digitizing, and the packages that do tend to be expensive products such as Adobe Premiere Pro 1.5 and Apple Final Cut Pro 5.0. So the HC1 also provides HD-to-DV downconversion for editing or playback on a standard-def (SD) TV. Like its big brother, the HDR-FX1, it incorporates Sony\'s Cinematic mode for simulating the appearance of 24fps film. It can also record standard DV. The camcorder supports component-video output and supplies the necessary cables, but if you have a FireWire port on your TV, you\'ll get the best playback quality that way.<br /><br />For the HC1\'s sensor, Sony uses a 1/3-inch, 3-megapixel CMOS chip with an RGB filter array. That provides an effective 2.0 megapixels for HD shooting and stills, 1.5 megapixels for SD video, and 2.8 megapixels for 4:3 photos. Its Zeiss T* 10X zoom lens won\'t win any spec wars, but it\'s perfectly sufficient for most shots, and Sony boosts the zoom effectiveness with its Super SteadyShot electronic stabilization.<br /><br />The rest of the HC1\'s features compete respectably with those of most camcorders in the same price bracket. You can select among automatic, manual, or spot focus. The Expanded Focus button enlarges the center of the scene for easier manual focusing, and the Tele Macro button will defocus the background to bring out the subject. In addition to using automatic adjustment and a handful of exposure presets, you can manually adjust the exposure or select the shutter speed. Same goes for the white balance, which includes a manual color-bias slider within the menu system. A zebra-stripe overexposure display and a live histogram supplement your exposure options, and for low-light shooting, you can turn to Sony\'s infrared NightShot mode and Super NightShot, which uses infrared and the built-in video light. An on-camera flash works for still photography, and Sony\'s Active Interface Shoe allows for more accessories. You can adjust the audio levels manually, and the HC1 includes connectors for an external microphone and headphones.','',564,'','Sony HDR-HC1','Sony HDR-HC1','Sony HDR-HC1'),(4,5,'Sony HDR-HC1','<ul><li>10fach optischer Zoom</li><li>3 Megapixel CMOS-Sensor</li><li>14 bit HD DXP Analog/Digital-Wandler</li><li>2,7 Zoll Hybrid LCD-Monitor</li><li>123.000 Pixel</li><li>Steady Shot Bildstabilisator</li><li>Fotofunktion Fotos mit 1920 x 1440 Pixel</li><li>Speicherm&ouml;glichkeit auf Memory Stick Duo</li><li>Anschl&uuml;sse i.LlNK Ein- und Ausgang</li><li>USB</li><li>Komponenten-Ausgang</li><li>Audio/Video- und S-Video-Ausgang</li><li>Abmessungen 71 x 94 x 188 mm</li><li>Gewicht 670 g</li></ul>','',159,'','Sony HDR-HC1','Sony HDR-HC1','Sony HDR-HC1'),(4,4,'Sony HDR-HC1','<ul><li>10fach optischer Zoom</li><li>3 Megapixel CMOS-Sensor</li><li>14 bit HD DXP Analog/Digital-Wandler</li><li>2,7 Zoll Hybrid LCD-Monitor</li><li>123.000 Pixel</li><li>Steady Shot Bildstabilisator</li><li>Fotofunktion Fotos mit 1920 x 1440 Pixel</li><li>Speicherm&ouml;glichkeit auf Memory Stick Duo</li><li>Anschl&uuml;sse i.LlNK Ein- und Ausgang</li><li>USB</li><li>Komponenten-Ausgang</li><li>Audio/Video- und S-Video-Ausgang</li><li>Abmessungen 71 x 94 x 188 mm</li><li>Gewicht 670 g</li></ul>','',190,'','Sony HDR-HC1','Sony HDR-HC1','Sony HDR-HC1'),(4,3,'Sony HDR-HC1','<ul><li>10fach optischer Zoom</li><li>3 Megapixel CMOS-Sensor</li><li>14 bit HD DXP Analog/Digital-Wandler</li><li>2,7 Zoll Hybrid LCD-Monitor</li><li>123.000 Pixel</li><li>Steady Shot Bildstabilisator</li><li>Fotofunktion Fotos mit 1920 x 1440 Pixel</li><li>Speicherm&ouml;glichkeit auf Memory Stick Duo</li><li>Anschl&uuml;sse i.LlNK Ein- und Ausgang</li><li>USB</li><li>Komponenten-Ausgang</li><li>Audio/Video- und S-Video-Ausgang</li><li>Abmessungen 71 x 94 x 188 mm</li><li>Gewicht 670 g</li></ul>','',218,'','Sony HDR-HC1','Sony HDR-HC1','Sony HDR-HC1'),(5,2,'HP Compaq 2710p Notebook','<ul>\r\n<li>Genuine Windows Vista&reg; Business</li>\r\n<li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li>\r\n<li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li>\r\n<li>1 GB 667 MHz DDR2 SDRAM</li>\r\n<li>60 GB 4200 rpm SMART PATA</li>\r\n<li>Intel 802.11a/b/g<br> Bluetooth 2.0</li>\r\n<li>100 GB 4200 rpm SMART PATA</li>\r\n</ul>','',548,'','HP Compaq 2710p Notebook','Genuine Windows Vista&reg; BusinessIntel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer1 GB 667 MHz DDR2 SDRAM60 GB 4200 rpm SMART PATAIntel 802.11a/b/g Bluetooth 2.0100 GB 4200 rpm SMART PATA','HP Compaq 2710p Notebook'),(5,1,'HP Compaq 2710p Notebook','<ul>\r\n<li>Genuine Windows Vista&reg; Business</li>\r\n<li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li>\r\n<li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li>\r\n<li>1 GB 667 MHz DDR2 SDRAM</li>\r\n<li>60 GB 4200 rpm SMART PATA</li>\r\n<li>Intel 802.11a/b/g<br> Bluetooth 2.0</li>\r\n<li>100 GB 4200 rpm SMART PATA</li>\r\n</ul>','',874,'','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook'),(5,5,'HP Compaq 2710p Notebook','<ul>\r\n<li>Genuine Windows Vista&reg; Business</li>\r\n<li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li>\r\n<li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li>\r\n<li>1 GB 667 MHz DDR2 SDRAM</li>\r\n<li>60 GB 4200 rpm SMART PATA</li>\r\n<li>Intel 802.11a/b/g<br> Bluetooth 2.0</li>\r\n<li>100 GB 4200 rpm SMART PATA</li>\r\n</ul>','',256,'','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook'),(5,4,'HP Compaq 2710p Notebook','<ul>\r\n<li>Genuine Windows Vista&reg; Business</li>\r\n<li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li>\r\n<li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li>\r\n<li>1 GB 667 MHz DDR2 SDRAM</li>\r\n<li>60 GB 4200 rpm SMART PATA</li>\r\n<li>Intel 802.11a/b/g<br> Bluetooth 2.0</li>\r\n<li>100 GB 4200 rpm SMART PATA</li>\r\n</ul>','',285,'','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook'),(5,3,'HP Compaq 2710p Notebook','<ul>\r\n<li>Genuine Windows Vista&reg; Business</li>\r\n<li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li>\r\n<li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li>\r\n<li>1 GB 667 MHz DDR2 SDRAM</li>\r\n<li>60 GB 4200 rpm SMART PATA</li>\r\n<li>Intel 802.11a/b/g<br> Bluetooth 2.0</li>\r\n<li>100 GB 4200 rpm SMART PATA</li>\r\n</ul>','',279,'','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook'),(6,2,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5\" wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.</p>\r\n<p><strong>Ultra-portable design.</strong><br>The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.</p>\r\n<p><strong>A truly mobile wireless companion.</strong><br>True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.</p>\r\n<p><strong>Communication on the go.</strong><br>The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.</p>\r\n<p><strong>Ingenious design.</strong><br>An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',321,'','VAIO? UX Series Micro PC','Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5&quot; wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.Ultra-portable design.The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.A truly mobile wireless companion.True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.Communication on the go.The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.Ingenious design.An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.','VAIO? UX Series Micro PC'),(6,1,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5\" wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.</p>\r\n<p><strong>Ultra-portable design.</strong><br> The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.</p>\r\n<p><strong>A truly mobile wireless companion.</strong><br> True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.</p>\r\n<p><strong>Communication on the go.</strong><br> The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.</p>\r\n<p><strong>Ingenious design.</strong><br> An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',514,'','VAIO? UX Series Micro PC','VAIO? UX Series Micro PC','VAIO? UX Series Micro PC'),(6,5,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5\" wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.</p>\r\n<p><strong>Ultra-portable design.</strong><br> The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.</p>\r\n<p><strong>A truly mobile wireless companion.</strong><br> True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.</p>\r\n<p><strong>Communication on the go.</strong><br> The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.</p>\r\n<p><strong>Ingenious design.</strong><br> An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',112,'','VAIO? UX Series Micro PC','VAIO? UX Series Micro PC','VAIO? UX Series Micro PC'),(6,4,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5\" wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.</p>\r\n<p><strong>Ultra-portable design.</strong><br> The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.</p>\r\n<p><strong>A truly mobile wireless companion.</strong><br> True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.</p>\r\n<p><strong>Communication on the go.</strong><br> The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.</p>\r\n<p><strong>Ingenious design.</strong><br> An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',120,'','VAIO? UX Series Micro PC','VAIO? UX Series Micro PC','VAIO? UX Series Micro PC'),(6,3,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5\" wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.</p>\r\n<p><strong>Ultra-portable design.</strong><br> The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.</p>\r\n<p><strong>A truly mobile wireless companion.</strong><br> True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.</p>\r\n<p><strong>Communication on the go.</strong><br> The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.</p>\r\n<p><strong>Ingenious design.</strong><br> An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',139,'','VAIO? UX Series Micro PC','VAIO? UX Series Micro PC','VAIO? UX Series Micro PC'),(7,2,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /><br />Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /><br />Dieses Speed Boot liegt super auf dem Wasser.<br /><br />Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /><br /><strong>Dynamic:</strong><br />Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /><br /><strong>Power:</strong><br />Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /><br /><strong>Energy:</strong><br />Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /><br /><strong>Controller:</strong><br />R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /><br /><strong>Lieferumfang:</strong><br />R/C Speed Boot Katamaran<br />Powerakku, Ni-cd 1700mAh 7.2V<br />6 x AA f&uuml;r die Fernsteuerung.<br />Ladeger&auml;t f&uuml;r den Akku<br />Fernsteuerung','',308,'','R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.Dieses Speed Boot liegt super auf dem Wasser.Ein echter Hingucker gegen&uuml;ber den normalen BootenDynamic:Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.Power:Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!Energy:Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.Controller:R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.Lieferumfang:R/C Speed Boot KatamaranPowerakku, Ni-cd 1700mAh 7.2V6 x AA f&uuml;r die Fernsteuerung.Ladeger&auml;t f&uuml;r den AkkuFernsteuerung','R/C Katamaran'),(7,1,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /> <br /> Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /> <br /> Dieses Speed Boot liegt super auf dem Wasser.<br /> <br /> Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /> <br /> <strong>Dynamic:</strong><br /> Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /> <br /> <strong>Power:</strong><br /> Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /> <br /> <strong>Energy:</strong><br /> Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /> <br /> <strong>Controller:</strong><br /> R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /> <br /> <strong>Lieferumfang:</strong><br /> R/C Speed Boot Katamaran<br /> Powerakku, Ni-cd 1700mAh 7.2V<br /> 6 x AA f&uuml;r die Fernsteuerung.<br /> Ladeger&auml;t f&uuml;r den Akku<br /> Fernsteuerung','',624,'','R/C Katamaran','R/C Katamaran','R/C Katamaran'),(7,5,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /> <br /> Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /> <br /> Dieses Speed Boot liegt super auf dem Wasser.<br /> <br /> Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /> <br /> <strong>Dynamic:</strong><br /> Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /> <br /> <strong>Power:</strong><br /> Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /> <br /> <strong>Energy:</strong><br /> Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /> <br /> <strong>Controller:</strong><br /> R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /> <br /> <strong>Lieferumfang:</strong><br /> R/C Speed Boot Katamaran<br /> Powerakku, Ni-cd 1700mAh 7.2V<br /> 6 x AA f&uuml;r die Fernsteuerung.<br /> Ladeger&auml;t f&uuml;r den Akku<br /> Fernsteuerung','',170,'','R/C Katamaran','R/C Katamaran','R/C Katamaran'),(7,4,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /> <br /> Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /> <br /> Dieses Speed Boot liegt super auf dem Wasser.<br /> <br /> Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /> <br /> <strong>Dynamic:</strong><br /> Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /> <br /> <strong>Power:</strong><br /> Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /> <br /> <strong>Energy:</strong><br /> Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /> <br /> <strong>Controller:</strong><br /> R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /> <br /> <strong>Lieferumfang:</strong><br /> R/C Speed Boot Katamaran<br /> Powerakku, Ni-cd 1700mAh 7.2V<br /> 6 x AA f&uuml;r die Fernsteuerung.<br /> Ladeger&auml;t f&uuml;r den Akku<br /> Fernsteuerung','',163,'','R/C Katamaran','R/C Katamaran','R/C Katamaran'),(7,3,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /> <br /> Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /> <br /> Dieses Speed Boot liegt super auf dem Wasser.<br /> <br /> Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /> <br /> <strong>Dynamic:</strong><br /> Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /> <br /> <strong>Power:</strong><br /> Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /> <br /> <strong>Energy:</strong><br /> Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /> <br /> <strong>Controller:</strong><br /> R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /> <br /> <strong>Lieferumfang:</strong><br /> R/C Speed Boot Katamaran<br /> Powerakku, Ni-cd 1700mAh 7.2V<br /> 6 x AA f&uuml;r die Fernsteuerung.<br /> Ladeger&auml;t f&uuml;r den Akku<br /> Fernsteuerung','',165,'','R/C Katamaran','R/C Katamaran','R/C Katamaran');
/*!40000 ALTER TABLE `products_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_notifications`
--

DROP TABLE IF EXISTS `products_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_notifications` (
  `products_id` int(11) NOT NULL DEFAULT '0',
  `customers_id` int(11) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`products_id`,`customers_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_notifications`
--

LOCK TABLES `products_notifications` WRITE;
/*!40000 ALTER TABLE `products_notifications` DISABLE KEYS */;
INSERT INTO `products_notifications` VALUES (0,2,'2007-12-13 17:27:31'),(0,7,'2008-04-10 18:21:34'),(0,22,'2009-10-07 18:07:55'),(12,26,'2010-01-14 17:07:01');
/*!40000 ALTER TABLE `products_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_options`
--

DROP TABLE IF EXISTS `products_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_options` (
  `products_options_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL DEFAULT '1',
  `products_options_name` varchar(32) NOT NULL,
  `products_options_type` int(5) NOT NULL DEFAULT '0',
  `products_options_length` smallint(2) NOT NULL DEFAULT '32',
  `products_options_comment` varchar(128) DEFAULT NULL,
  `products_options_sort_order` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`products_options_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_options`
--

LOCK TABLES `products_options` WRITE;
/*!40000 ALTER TABLE `products_options` DISABLE KEYS */;
INSERT INTO `products_options` VALUES (1,2,'RAM',0,0,'',0),(1,1,'RAM',0,0,'',0),(1,5,'RAM',0,0,'',0),(1,4,'RAM',0,0,'',0),(1,3,'RAM',0,0,'',0),(2,5,'Disc dur',0,0,'',0),(2,1,'Hard Disk',0,0,'',0),(2,2,'Festplatte',0,0,'',0),(2,4,'Hard Disk',0,0,'',0),(2,3,'Hard Disk',0,0,'',0),(3,2,'Betriebssystem',0,0,'',0),(3,1,'Operating System',0,0,'',0),(3,5,'Operating System',0,0,'',0),(3,4,'Operating System',0,0,'',0),(3,3,'Operating System',0,0,'',0),(4,2,'Name',1,30,'personalisiert',0),(4,1,'Name',1,30,'',0),(4,5,'Nom',1,30,'',0),(4,4,'Nome',1,30,'',0),(4,3,'Nombre',1,30,'',0);
/*!40000 ALTER TABLE `products_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_options_types`
--

DROP TABLE IF EXISTS `products_options_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_options_types` (
  `products_options_types_id` int(11) NOT NULL DEFAULT '0',
  `products_options_types_name` varchar(32) DEFAULT NULL,
  `language_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`products_options_types_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_options_types`
--

LOCK TABLES `products_options_types` WRITE;
/*!40000 ALTER TABLE `products_options_types` DISABLE KEYS */;
INSERT INTO `products_options_types` VALUES (0,'Select',1),(1,'Text',1),(2,'Radio',1),(3,'Checkbox',1),(4,'Textarea',1),(5,'File',1),(0,'Select',2),(1,'Text',2),(2,'Radio',2),(3,'Checkbox',2),(4,'Textarea',2),(5,'File',2),(0,'Select',3),(1,'Text',3),(2,'Radio',3),(3,'Checkbox',3),(4,'Textarea',3),(5,'File',3),(0,'Select',4),(1,'Text',4),(2,'Radio',4),(3,'Checkbox',4),(4,'Textarea',4),(5,'File',4),(0,'Select',5),(1,'Text',5),(2,'Radio',5),(3,'Checkbox',5),(4,'Textarea',5),(5,'File',5);
/*!40000 ALTER TABLE `products_options_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_options_values`
--

DROP TABLE IF EXISTS `products_options_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_options_values` (
  `products_options_values_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL DEFAULT '1',
  `products_options_values_name` varchar(64) NOT NULL,
  PRIMARY KEY (`products_options_values_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_options_values`
--

LOCK TABLES `products_options_values` WRITE;
/*!40000 ALTER TABLE `products_options_values` DISABLE KEYS */;
INSERT INTO `products_options_values` VALUES (1,2,'1 GB 667 MHz DDR2 SDRAM'),(1,1,'1 GB 667 MHz DDR2 SDRAM'),(1,5,'1 GB 667 MHz DDR2 SDRAM'),(1,4,'1 GB 667 MHz DDR2 SDRAM'),(1,3,'1 GB 667 MHz DDR2 SDRAM'),(2,2,'2 GB 667 MHz DDR2 SDRAM'),(2,1,'2 GB 667 MHz DDR2 SDRAM'),(2,5,'2 GB 667 MHz DDR2 SDRAM'),(2,4,'2 GB 667 MHz DDR2 SDRAM'),(2,3,'2 GB 667 MHz DDR2 SDRAM'),(3,2,'60 GB 4200 rpm SMART PATA'),(3,1,'60 GB 4200 rpm SMART PATA'),(3,5,'60 GB 4200 rpm SMART PATA'),(3,4,'60 GB 4200 rpm SMART PATA'),(3,3,'60 GB 4200 rpm SMART PATA'),(4,2,'80 GB 4200 rpm SMART PATA'),(4,1,'80 GB 4200 rpm SMART PATA'),(4,5,'80 GB 4200 rpm SMART PATA'),(4,4,'80 GB 4200 rpm SMART PATA'),(4,3,'80 GB 4200 rpm SMART PATA'),(5,2,'100 GB 4200 rpm SMART PATA'),(5,1,'100 GB 4200 rpm SMART PATA'),(5,5,'100 GB 4200 rpm SMART PATA'),(5,4,'100 GB 4200 rpm SMART PATA'),(5,3,'100 GB 4200 rpm SMART PATA'),(6,2,'Windows XP Business'),(6,1,'Windows XP Business'),(6,5,'Windows XP Business'),(6,4,'Windows XP Business'),(6,3,'Windows XP Business'),(7,2,'Windows Vista® Business'),(7,1,'Windows Vista® Business'),(7,5,'Windows Vista® Business'),(7,4,'Windows Vista® Business'),(7,3,'Windows Vista® Business'),(8,2,'Linux openSUSE 10.3'),(8,1,'Linux openSUSE 10.3'),(8,5,'Linux openSUSE 10.3'),(8,4,'Linux openSUSE 10.3'),(8,3,'Linux openSUSE 10.3'),(9,2,'Linux Ubuntu Gibbon 7.10'),(9,1,'Linux Ubuntu Gibbon 7.10'),(9,5,'Linux Ubuntu Gibbon 7.10'),(9,4,'Linux Ubuntu Gibbon 7.10'),(9,3,'Linux Ubuntu Gibbon 7.10'),(10,2,'Bitte wählen'),(10,1,'Please choose'),(10,5,'Veuillez choisir'),(10,4,'Please choose'),(10,3,'Please choose'),(0,1,'TEXT'),(0,2,'TEXT'),(0,3,'TEXT'),(0,4,'TEXT'),(0,5,'TEXT'),(11,2,'Windows 7 Business'),(11,1,'Windows 7 Business'),(11,5,'Windows 7 Business'),(11,4,'Windows 7 Business'),(11,3,'Windows 7 Business');
/*!40000 ALTER TABLE `products_options_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_options_values_to_products_options`
--

DROP TABLE IF EXISTS `products_options_values_to_products_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_options_values_to_products_options` (
  `products_options_values_to_products_options_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_options_id` int(11) NOT NULL DEFAULT '0',
  `products_options_values_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`products_options_values_to_products_options_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_options_values_to_products_options`
--

LOCK TABLES `products_options_values_to_products_options` WRITE;
/*!40000 ALTER TABLE `products_options_values_to_products_options` DISABLE KEYS */;
INSERT INTO `products_options_values_to_products_options` VALUES (1,1,1),(2,1,2),(3,2,3),(4,2,4),(5,2,5),(6,3,6),(7,3,7),(8,3,8),(9,3,9),(10,3,10),(13,4,0),(14,3,11);
/*!40000 ALTER TABLE `products_options_values_to_products_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_to_categories`
--

DROP TABLE IF EXISTS `products_to_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_to_categories` (
  `products_id` int(11) NOT NULL DEFAULT '0',
  `categories_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`products_id`,`categories_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_to_categories`
--

LOCK TABLES `products_to_categories` WRITE;
/*!40000 ALTER TABLE `products_to_categories` DISABLE KEYS */;
INSERT INTO `products_to_categories` VALUES (1,1),(2,1),(4,2),(5,2),(6,2),(7,1);
/*!40000 ALTER TABLE `products_to_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_xsell`
--

DROP TABLE IF EXISTS `products_xsell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_xsell` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `products_id` int(10) unsigned NOT NULL DEFAULT '1',
  `xsell_id` int(10) unsigned NOT NULL DEFAULT '1',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_xsell`
--

LOCK TABLES `products_xsell` WRITE;
/*!40000 ALTER TABLE `products_xsell` DISABLE KEYS */;
INSERT INTO `products_xsell` VALUES (7,1,5,2),(6,1,2,1),(3,4,2,1),(4,4,5,2),(5,4,6,3),(8,1,7,3);
/*!40000 ALTER TABLE `products_xsell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews` (
  `reviews_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT '0',
  `customers_id` int(11) DEFAULT NULL,
  `customers_name` varchar(64) NOT NULL,
  `reviews_rating` int(1) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `reviews_read` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`reviews_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews_description`
--

DROP TABLE IF EXISTS `reviews_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews_description` (
  `reviews_id` int(11) NOT NULL DEFAULT '0',
  `languages_id` int(11) NOT NULL DEFAULT '0',
  `reviews_text` text NOT NULL,
  PRIMARY KEY (`reviews_id`,`languages_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews_description`
--

LOCK TABLES `reviews_description` WRITE;
/*!40000 ALTER TABLE `reviews_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saferpay_transactions`
--

DROP TABLE IF EXISTS `saferpay_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saferpay_transactions` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `customers_id` int(11) NOT NULL DEFAULT '0',
  `orders_id` int(11) NOT NULL DEFAULT '0',
  `saferpay_ID` varchar(96) DEFAULT NULL,
  `saferpay_amount` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `saferpay_currency` varchar(8) NOT NULL,
  `saferpay_provider_id` int(11) DEFAULT '0',
  `saferpay_provider_name` varchar(255) DEFAULT NULL,
  `saferpay_complete` int(1) NOT NULL DEFAULT '0',
  `saferpay_complete_result` varchar(255) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`trans_id`),
  KEY `IDX_CUSTOMERS` (`customers_id`),
  KEY `IDX_ORDER` (`orders_id`),
  KEY `IDX_SAFERPAY_ID` (`saferpay_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saferpay_transactions`
--

LOCK TABLES `saferpay_transactions` WRITE;
/*!40000 ALTER TABLE `saferpay_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `saferpay_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `sesskey` varchar(32) NOT NULL,
  `expiry` int(11) unsigned NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  PRIMARY KEY (`sesskey`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('5b0015ac4c72498bd7bc5d5f8cb23a58',1286361520,'cart|O:12:\"shoppingCart\":5:{s:8:\"contents\";a:0:{}s:5:\"total\";i:0;s:6:\"weight\";i:0;s:6:\"cartID\";N;s:12:\"content_type\";b:0;}language|s:6:\"german\";languages_id|s:1:\"2\";currency|s:3:\"CHF\";navigation|O:17:\"navigationHistory\":2:{s:4:\"path\";a:2:{i:0;a:4:{s:4:\"page\";s:9:\"index.php\";s:4:\"mode\";s:6:\"NONSSL\";s:3:\"get\";a:0:{}s:4:\"post\";a:0:{}}i:1;a:4:{s:4:\"page\";s:9:\"index.php\";s:4:\"mode\";s:6:\"NONSSL\";s:3:\"get\";a:2:{s:5:\"cPath\";s:3:\"5_2\";s:6:\"osCsid\";s:32:\"5b0015ac4c72498bd7bc5d5f8cb23a58\";}s:4:\"post\";a:0:{}}}s:8:\"snapshot\";a:0:{}}'),('143e20f33e7bb340b6682e318c9eae90',1286362086,'language|s:6:\"german\";languages_id|s:1:\"2\";selected_box|s:11:\"information\";'),('3b812f8b90f347f999b79d7d551d996a',1286361974,'cart|O:12:\"shoppingCart\":4:{s:8:\"contents\";a:0:{}s:5:\"total\";i:0;s:6:\"weight\";i:0;s:12:\"content_type\";b:0;}language|s:7:\"english\";languages_id|s:1:\"1\";currency|s:3:\"CHF\";navigation|O:17:\"navigationHistory\":2:{s:4:\"path\";a:1:{i:0;a:4:{s:4:\"page\";s:9:\"index.php\";s:4:\"mode\";s:6:\"NONSSL\";s:3:\"get\";a:1:{s:16:\"manufacturers_id\";s:1:\"1\";}s:4:\"post\";a:0:{}}}s:8:\"snapshot\";a:0:{}}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specials`
--

DROP TABLE IF EXISTS `specials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `specials` (
  `specials_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_id` int(11) NOT NULL DEFAULT '0',
  `specials_new_products_price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `specials_date_added` datetime DEFAULT NULL,
  `specials_last_modified` datetime DEFAULT NULL,
  `expires_date` datetime DEFAULT NULL,
  `date_status_change` datetime DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`specials_id`),
  KEY `IDX_SPECIALS_PRODUCTS_ID` (`products_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specials`
--

LOCK TABLES `specials` WRITE;
/*!40000 ALTER TABLE `specials` DISABLE KEYS */;
INSERT INTO `specials` VALUES (3,12,'148.6989','2010-01-14 16:55:57','2010-01-14 17:00:54','2010-01-16 00:00:00','2010-04-13 23:26:17',0);
/*!40000 ALTER TABLE `specials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_class`
--

DROP TABLE IF EXISTS `tax_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_class` (
  `tax_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `tax_class_title` varchar(32) NOT NULL,
  `tax_class_description` varchar(255) NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`tax_class_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_class`
--

LOCK TABLES `tax_class` WRITE;
/*!40000 ALTER TABLE `tax_class` DISABLE KEYS */;
INSERT INTO `tax_class` VALUES (1,'7.6% MwSt.','7.6% MwSt.','2007-08-07 22:43:29','2007-06-12 22:50:01');
/*!40000 ALTER TABLE `tax_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_rates`
--

DROP TABLE IF EXISTS `tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_rates` (
  `tax_rates_id` int(11) NOT NULL AUTO_INCREMENT,
  `tax_zone_id` int(11) NOT NULL DEFAULT '0',
  `tax_class_id` int(11) NOT NULL DEFAULT '0',
  `tax_priority` int(5) DEFAULT '1',
  `tax_rate` decimal(7,4) NOT NULL DEFAULT '0.0000',
  `tax_description` varchar(255) NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`tax_rates_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_rates`
--

LOCK TABLES `tax_rates` WRITE;
/*!40000 ALTER TABLE `tax_rates` DISABLE KEYS */;
INSERT INTO `tax_rates` VALUES (1,1,1,1,'7.6000','7.6% MwSt.','2007-08-07 22:43:02','2007-06-12 22:50:01');
/*!40000 ALTER TABLE `tax_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usu_cache`
--

DROP TABLE IF EXISTS `usu_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usu_cache` (
  `cache_name` varchar(32) NOT NULL,
  `cache_data` mediumtext NOT NULL,
  `cache_date` datetime NOT NULL,
  PRIMARY KEY (`cache_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usu_cache`
--

LOCK TABLES `usu_cache` WRITE;
/*!40000 ALTER TABLE `usu_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `usu_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `whos_online`
--

DROP TABLE IF EXISTS `whos_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whos_online` (
  `customer_id` int(11) DEFAULT NULL,
  `full_name` varchar(64) NOT NULL,
  `session_id` varchar(128) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `time_entry` varchar(14) NOT NULL,
  `time_last_click` varchar(14) NOT NULL,
  `last_page_url` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `whos_online`
--

LOCK TABLES `whos_online` WRITE;
/*!40000 ALTER TABLE `whos_online` DISABLE KEYS */;
INSERT INTO `whos_online` VALUES (0,'Guest','5b0015ac4c72498bd7bc5d5f8cb23a58','217.224.159.182','1286360073','1286360080','/consumer-electronics-c-5_2.html?osCsid=5b0015ac4c72498bd7bc5d5f8cb23a58'),(0,'Guest','3b812f8b90f347f999b79d7d551d996a','67.195.113.243','1286360534','1286360534','/jamotrade-m-1.html');
/*!40000 ALTER TABLE `whos_online` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zones`
--

DROP TABLE IF EXISTS `zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zones` (
  `zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `zone_country_id` int(11) NOT NULL DEFAULT '0',
  `zone_code` varchar(32) NOT NULL DEFAULT '',
  `zone_name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`zone_id`)
) ENGINE=MyISAM AUTO_INCREMENT=182 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zones`
--

LOCK TABLES `zones` WRITE;
/*!40000 ALTER TABLE `zones` DISABLE KEYS */;
INSERT INTO `zones` VALUES (1,223,'AL','Alabama'),(2,223,'AK','Alaska'),(3,223,'AS','American Samoa'),(4,223,'AZ','Arizona'),(5,223,'AR','Arkansas'),(6,223,'AF','Armed Forces Africa'),(7,223,'AA','Armed Forces Americas'),(8,223,'AC','Armed Forces Canada'),(9,223,'AE','Armed Forces Europe'),(10,223,'AM','Armed Forces Middle East'),(11,223,'AP','Armed Forces Pacific'),(12,223,'CA','California'),(13,223,'CO','Colorado'),(14,223,'CT','Connecticut'),(15,223,'DE','Delaware'),(16,223,'DC','District of Columbia'),(17,223,'FM','Federated States Of Micronesia'),(18,223,'FL','Florida'),(19,223,'GA','Georgia'),(20,223,'GU','Guam'),(21,223,'HI','Hawaii'),(22,223,'ID','Idaho'),(23,223,'IL','Illinois'),(24,223,'IN','Indiana'),(25,223,'IA','Iowa'),(26,223,'KS','Kansas'),(27,223,'KY','Kentucky'),(28,223,'LA','Louisiana'),(29,223,'ME','Maine'),(30,223,'MH','Marshall Islands'),(31,223,'MD','Maryland'),(32,223,'MA','Massachusetts'),(33,223,'MI','Michigan'),(34,223,'MN','Minnesota'),(35,223,'MS','Mississippi'),(36,223,'MO','Missouri'),(37,223,'MT','Montana'),(38,223,'NE','Nebraska'),(39,223,'NV','Nevada'),(40,223,'NH','New Hampshire'),(41,223,'NJ','New Jersey'),(42,223,'NM','New Mexico'),(43,223,'NY','New York'),(44,223,'NC','North Carolina'),(45,223,'ND','North Dakota'),(46,223,'MP','Northern Mariana Islands'),(47,223,'OH','Ohio'),(48,223,'OK','Oklahoma'),(49,223,'OR','Oregon'),(50,223,'PW','Palau'),(51,223,'PA','Pennsylvania'),(52,223,'PR','Puerto Rico'),(53,223,'RI','Rhode Island'),(54,223,'SC','South Carolina'),(55,223,'SD','South Dakota'),(56,223,'TN','Tennessee'),(57,223,'TX','Texas'),(58,223,'UT','Utah'),(59,223,'VT','Vermont'),(60,223,'VI','Virgin Islands'),(61,223,'VA','Virginia'),(62,223,'WA','Washington'),(63,223,'WV','West Virginia'),(64,223,'WI','Wisconsin'),(65,223,'WY','Wyoming'),(66,38,'AB','Alberta'),(67,38,'BC','British Columbia'),(68,38,'MB','Manitoba'),(69,38,'NF','Newfoundland'),(70,38,'NB','New Brunswick'),(71,38,'NS','Nova Scotia'),(72,38,'NT','Northwest Territories'),(73,38,'NU','Nunavut'),(74,38,'ON','Ontario'),(75,38,'PE','Prince Edward Island'),(76,38,'QC','Quebec'),(77,38,'SK','Saskatchewan'),(78,38,'YT','Yukon Territory'),(79,81,'NDS','Niedersachsen'),(80,81,'BAW','Baden-Württemberg'),(81,81,'BAY','Bayern'),(82,81,'BER','Berlin'),(83,81,'BRG','Brandenburg'),(84,81,'BRE','Bremen'),(85,81,'HAM','Hamburg'),(86,81,'HES','Hessen'),(87,81,'MEC','Mecklenburg-Vorpommern'),(88,81,'NRW','Nordrhein-Westfalen'),(89,81,'RHE','Rheinland-Pfalz'),(90,81,'SAR','Saarland'),(91,81,'SAS','Sachsen'),(92,81,'SAC','Sachsen-Anhalt'),(93,81,'SCN','Schleswig-Holstein'),(94,81,'THE','Thüringen'),(95,14,'WI','Wien'),(96,14,'NO','Niederösterreich'),(97,14,'OO','Oberösterreich'),(98,14,'SB','Salzburg'),(99,14,'KN','Kärnten'),(100,14,'ST','Steiermark'),(101,14,'TI','Tirol'),(102,14,'BL','Burgenland'),(103,14,'VB','Voralberg'),(104,204,'AG','Aargau'),(105,204,'AI','Appenzell Innerrhoden'),(106,204,'AR','Appenzell Ausserrhoden'),(107,204,'BE','Bern'),(108,204,'BL','Basel-Landschaft'),(109,204,'BS','Basel-Stadt'),(110,204,'FR','Freiburg'),(111,204,'GE','Genf'),(112,204,'GL','Glarus'),(113,204,'JU','Graubünden'),(114,204,'JU','Jura'),(115,204,'LU','Luzern'),(116,204,'NE','Neuenburg'),(117,204,'NW','Nidwalden'),(118,204,'OW','Obwalden'),(119,204,'SG','St. Gallen'),(120,204,'SH','Schaffhausen'),(121,204,'SO','Solothurn'),(122,204,'SZ','Schwyz'),(123,204,'TG','Thurgau'),(124,204,'TI','Tessin'),(125,204,'UR','Uri'),(126,204,'VD','Waadt'),(127,204,'VS','Wallis'),(128,204,'ZG','Zug'),(129,204,'ZH','Zürich'),(130,195,'A Coruña','A Coruña'),(131,195,'Alava','Alava'),(132,195,'Albacete','Albacete'),(133,195,'Alicante','Alicante'),(134,195,'Almeria','Almeria'),(135,195,'Asturias','Asturias'),(136,195,'Avila','Avila'),(137,195,'Badajoz','Badajoz'),(138,195,'Baleares','Baleares'),(139,195,'Barcelona','Barcelona'),(140,195,'Burgos','Burgos'),(141,195,'Caceres','Caceres'),(142,195,'Cadiz','Cadiz'),(143,195,'Cantabria','Cantabria'),(144,195,'Castellon','Castellon'),(145,195,'Ceuta','Ceuta'),(146,195,'Ciudad Real','Ciudad Real'),(147,195,'Cordoba','Cordoba'),(148,195,'Cuenca','Cuenca'),(149,195,'Girona','Girona'),(150,195,'Granada','Granada'),(151,195,'Guadalajara','Guadalajara'),(152,195,'Guipuzcoa','Guipuzcoa'),(153,195,'Huelva','Huelva'),(154,195,'Huesca','Huesca'),(155,195,'Jaen','Jaen'),(156,195,'La Rioja','La Rioja'),(157,195,'Las Palmas','Las Palmas'),(158,195,'Leon','Leon'),(159,195,'Lleida','Lleida'),(160,195,'Lugo','Lugo'),(161,195,'Madrid','Madrid'),(162,195,'Malaga','Malaga'),(163,195,'Melilla','Melilla'),(164,195,'Murcia','Murcia'),(165,195,'Navarra','Navarra'),(166,195,'Ourense','Ourense'),(167,195,'Palencia','Palencia'),(168,195,'Pontevedra','Pontevedra'),(169,195,'Salamanca','Salamanca'),(170,195,'Santa Cruz de Tenerife','Santa Cruz de Tenerife'),(171,195,'Segovia','Segovia'),(172,195,'Sevilla','Sevilla'),(173,195,'Soria','Soria'),(174,195,'Tarragona','Tarragona'),(175,195,'Teruel','Teruel'),(176,195,'Toledo','Toledo'),(177,195,'Valencia','Valencia'),(178,195,'Valladolid','Valladolid'),(179,195,'Vizcaya','Vizcaya'),(180,195,'Zamora','Zamora'),(181,195,'Zaragoza','Zaragoza');
/*!40000 ALTER TABLE `zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zones_to_geo_zones`
--

DROP TABLE IF EXISTS `zones_to_geo_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zones_to_geo_zones` (
  `association_id` int(11) NOT NULL AUTO_INCREMENT,
  `zone_country_id` int(11) NOT NULL DEFAULT '0',
  `zone_id` int(11) DEFAULT NULL,
  `geo_zone_id` int(11) DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`association_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zones_to_geo_zones`
--

LOCK TABLES `zones_to_geo_zones` WRITE;
/*!40000 ALTER TABLE `zones_to_geo_zones` DISABLE KEYS */;
INSERT INTO `zones_to_geo_zones` VALUES (1,204,NULL,1,'2007-08-07 22:42:29','2007-06-12 22:50:01'),(2,122,0,1,NULL,'2007-08-07 22:42:38');
/*!40000 ALTER TABLE `zones_to_geo_zones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-10-06 12:24:39
