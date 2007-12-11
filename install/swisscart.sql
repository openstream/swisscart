-- MySQL dump 10.11
--
-- Host: localhost    Database: swisscart_development
-- ------------------------------------------------------
-- Server version	5.0.41-community-nt

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
CREATE TABLE `address_book` (
  `address_book_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL,
  `entry_gender` char(1) collate latin1_general_ci NOT NULL,
  `entry_company` varchar(64) collate latin1_general_ci default NULL,
  `entry_firstname` varchar(32) collate latin1_general_ci NOT NULL,
  `entry_lastname` varchar(32) collate latin1_general_ci NOT NULL,
  `entry_street_address` varchar(64) collate latin1_general_ci NOT NULL,
  `entry_suburb` varchar(32) collate latin1_general_ci default NULL,
  `entry_postcode` varchar(10) collate latin1_general_ci NOT NULL,
  `entry_city` varchar(32) collate latin1_general_ci NOT NULL,
  `entry_state` varchar(32) collate latin1_general_ci default NULL,
  `entry_country_id` int(11) NOT NULL default '0',
  `entry_zone_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`address_book_id`),
  KEY `idx_address_book_customers_id` (`customers_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `address_book`
--

LOCK TABLES `address_book` WRITE;
/*!40000 ALTER TABLE `address_book` DISABLE KEYS */;
INSERT INTO `address_book` VALUES (2,2,'m','Openstream Internet Solutions','Nick','Weisser','Wieslergasse 6','','8049','Zürch','',204,129),(3,2,'m','Openstream Internet Solutions','Nick','Weisser','Waldkircher Str. 14','','78054','Villingen-Schwenningen','',81,80);
/*!40000 ALTER TABLE `address_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address_format`
--

DROP TABLE IF EXISTS `address_format`;
CREATE TABLE `address_format` (
  `address_format_id` int(11) NOT NULL auto_increment,
  `address_format` varchar(128) collate latin1_general_ci NOT NULL,
  `address_summary` varchar(48) collate latin1_general_ci NOT NULL,
  PRIMARY KEY  (`address_format_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

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
CREATE TABLE `banners` (
  `banners_id` int(11) NOT NULL auto_increment,
  `banners_title` varchar(64) collate latin1_general_ci NOT NULL,
  `banners_url` varchar(255) collate latin1_general_ci NOT NULL,
  `banners_image` varchar(64) collate latin1_general_ci NOT NULL,
  `banners_group` varchar(10) collate latin1_general_ci NOT NULL,
  `banners_html_text` text collate latin1_general_ci,
  `expires_impressions` int(7) default '0',
  `expires_date` datetime default NULL,
  `date_scheduled` datetime default NULL,
  `date_added` datetime NOT NULL,
  `date_status_change` datetime default NULL,
  `status` int(1) NOT NULL default '1',
  PRIMARY KEY  (`banners_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `banners`
--

LOCK TABLES `banners` WRITE;
/*!40000 ALTER TABLE `banners` DISABLE KEYS */;
INSERT INTO `banners` VALUES (1,'osCommerce','http://www.oscommerce.com','banners/oscommerce.gif','468x50','',0,NULL,NULL,'2007-06-12 22:50:01','2007-07-05 15:50:01',0);
/*!40000 ALTER TABLE `banners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banners_history`
--

DROP TABLE IF EXISTS `banners_history`;
CREATE TABLE `banners_history` (
  `banners_history_id` int(11) NOT NULL auto_increment,
  `banners_id` int(11) NOT NULL,
  `banners_shown` int(5) NOT NULL default '0',
  `banners_clicked` int(5) NOT NULL default '0',
  `banners_history_date` datetime NOT NULL,
  PRIMARY KEY  (`banners_history_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `banners_history`
--

LOCK TABLES `banners_history` WRITE;
/*!40000 ALTER TABLE `banners_history` DISABLE KEYS */;
INSERT INTO `banners_history` VALUES (1,1,21,0,'2007-06-12 22:50:09'),(2,1,176,0,'2007-06-13 02:03:37'),(3,1,196,0,'2007-07-05 00:43:57');
/*!40000 ALTER TABLE `banners_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `cache_id` varchar(32) collate latin1_general_ci NOT NULL default '',
  `cache_language_id` tinyint(1) NOT NULL default '0',
  `cache_name` varchar(255) collate latin1_general_ci NOT NULL default '',
  `cache_data` mediumtext collate latin1_general_ci NOT NULL,
  `cache_global` tinyint(1) NOT NULL default '1',
  `cache_gzip` tinyint(1) NOT NULL default '1',
  `cache_method` varchar(20) collate latin1_general_ci NOT NULL default 'RETURN',
  `cache_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `cache_expires` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`cache_id`,`cache_language_id`),
  KEY `cache_id` (`cache_id`),
  KEY `cache_language_id` (`cache_language_id`),
  KEY `cache_global` (`cache_global`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('ca34fbe5f9a075091ad59abf02c259a7',2,'seo_urls_v2_products','dc+9CsIwFIbh3atwi4IHbFE7OBV19AfRuSRp2oaQnHqS+nNTXqPNbvbn/eCrVaOdmrHL9by/727VqTweqowtpowkiKFtP9CJN7xyNt9O6n84j9ii80ERBBqkAaHbBjEkk1VMPLpxu6ZOZkm4jlCi7fkD8iJb9uAwKIFokskmJk+u8QtekVYerJaESV9EP341PHDLibsofw==',1,1,'EVAL','2007-11-08 22:21:13','2007-12-08 22:21:13'),('a93b9170a03ff54d81e95917742ea01b',2,'seo_urls_v2_categories','S0lNy8xL1VB3dgxxdfcPioz3c/R1jTdU11FQT0styktPLS5JLU0tKknVTSwtyS9W17TmSsGqxQikJTk/r7g0N7VINzUnNbmkKD8vMxmsBQA=',1,1,'EVAL','2007-11-08 22:21:13','2007-12-08 22:21:13'),('4404c1df54fdb1291c8dd9bb259f32a9',2,'seo_urls_v2_manufacturers','S0lNy8xL1VD3dfQLdXN0DgkNcg2K93P0dY03VNdRUM9KzM0vKUpMSVXXtOZKwanWCKS2KjU1Bb8yE5Cy4vy8SvzKTEHKMlLLc1JLSgoSk7MTi8DmAgA=',1,1,'EVAL','2007-11-08 22:21:13','2007-12-08 22:21:13'),('eed8a5b35a2f51f214b1c6b119528c9f',2,'seo_urls_v2_information','dc47DsIwEIThnlPQGSQoeBdUFERKQThCtMjDYslZI3uDOD5xQQNO//2jsbg7wczUTXVtm9Pl3K7MYmoeIOuE1amHmR8n9o+tM1O8lSOgg30ipiDky3wzxiN84CDlavtbcY+kZbv72o7cyNw+k9fwk8SWRw5Z9JIQsSS+paw+',1,1,'EVAL','2007-11-08 22:21:13','2007-12-08 22:21:13');
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `categories_id` int(11) NOT NULL auto_increment,
  `categories_image` varchar(64) collate latin1_general_ci default NULL,
  `parent_id` int(11) NOT NULL default '0',
  `sort_order` int(3) default NULL,
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  PRIMARY KEY  (`categories_id`),
  KEY `idx_categories_parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'',0,1,'2007-11-04 13:57:31','2007-11-05 06:23:28'),(2,'',0,0,'2007-11-04 13:57:51',NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_description`
--

DROP TABLE IF EXISTS `categories_description`;
CREATE TABLE `categories_description` (
  `categories_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `categories_name` varchar(32) collate latin1_general_ci NOT NULL,
  `categories_seo_url` varchar(100) collate latin1_general_ci NOT NULL,
  `categories_htc_title_tag` varchar(80) collate latin1_general_ci default NULL,
  `categories_htc_desc_tag` longtext collate latin1_general_ci,
  `categories_htc_keywords_tag` longtext collate latin1_general_ci,
  `categories_htc_description` longtext collate latin1_general_ci,
  PRIMARY KEY  (`categories_id`,`language_id`),
  KEY `idx_categories_name` (`categories_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `categories_description`
--

LOCK TABLES `categories_description` WRITE;
/*!40000 ALTER TABLE `categories_description` DISABLE KEYS */;
INSERT INTO `categories_description` VALUES (1,2,'Ferngesteuerte Autos','','R/C Modellbau','R/C Modellbau','R/C Modellbau',''),(1,1,'Remote Cars','','R/C Modellbau','R/C Modellbau','R/C Modellbau',''),(1,5,'Ferngesteuerte Autos','','R/C Modellbau','R/C Modellbau','R/C Modellbau',''),(1,4,'Ferngesteuerte Autos','','R/C Modellbau','R/C Modellbau','R/C Modellbau',''),(1,3,'Ferngesteuerte Autos','','R/C Modellbau','R/C Modellbau','R/C Modellbau',''),(2,2,'Consumer Electronics','','Consumer Electronics','Consumer Electronics','Consumer Electronics',''),(2,1,'Consumer Electronics','','Consumer Electronics','Consumer Electronics','Consumer Electronics',''),(2,5,'Consumer Electronics','','Consumer Electronics','Consumer Electronics','Consumer Electronics',''),(2,4,'Consumer Electronics','','Consumer Electronics','Consumer Electronics','Consumer Electronics',''),(2,3,'Consumer Electronics','','Consumer Electronics','Consumer Electronics','Consumer Electronics','');
/*!40000 ALTER TABLE `categories_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
CREATE TABLE `configuration` (
  `configuration_id` int(11) NOT NULL auto_increment,
  `configuration_title` varchar(64) collate latin1_general_ci NOT NULL,
  `configuration_key` varchar(64) collate latin1_general_ci NOT NULL,
  `configuration_value` varchar(255) collate latin1_general_ci NOT NULL,
  `configuration_description` varchar(255) collate latin1_general_ci NOT NULL,
  `configuration_group_id` int(11) NOT NULL,
  `sort_order` int(5) default NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  `use_function` varchar(255) collate latin1_general_ci default NULL,
  `set_function` varchar(255) collate latin1_general_ci default NULL,
  PRIMARY KEY  (`configuration_id`)
) ENGINE=MyISAM AUTO_INCREMENT=433 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `configuration`
--

LOCK TABLES `configuration` WRITE;
/*!40000 ALTER TABLE `configuration` DISABLE KEYS */;
INSERT INTO `configuration` VALUES (1,'Store Name','STORE_NAME','swisscart®','The name of my store',1,1,'2007-06-13 03:41:48','2007-06-12 22:50:01',NULL,NULL),(2,'Store Owner','STORE_OWNER','Nick Weisser','The name of my store owner',1,2,'2007-06-13 02:02:45','2007-06-12 22:50:01',NULL,NULL),(3,'E-Mail Address','STORE_OWNER_EMAIL_ADDRESS','root@localhost','The e-mail address of my store owner',1,3,NULL,'2007-06-12 22:50:01',NULL,NULL),(4,'E-Mail From','EMAIL_FROM','osCommerce <root@localhost>','The e-mail address used in (sent) e-mails',1,4,NULL,'2007-06-12 22:50:01',NULL,NULL),(5,'Country','STORE_COUNTRY','204','The country my store is located in <br><br><b>Note: Please remember to update the store zone.</b>',1,6,'2007-06-13 02:02:21','2007-06-12 22:50:01','tep_get_country_name','tep_cfg_pull_down_country_list('),(6,'Zone','STORE_ZONE','129','The zone my store is located in',1,7,'2007-06-13 02:02:30','2007-06-12 22:50:01','tep_cfg_get_zone_name','tep_cfg_pull_down_zone_list('),(7,'Expected Sort Order','EXPECTED_PRODUCTS_SORT','desc','This is the sort order used in the expected products box.',1,8,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'asc\', \'desc\'), '),(8,'Expected Sort Field','EXPECTED_PRODUCTS_FIELD','date_expected','The column to sort by in the expected products box.',1,9,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'products_name\', \'date_expected\'), '),(9,'Switch To Default Language Currency','USE_DEFAULT_LANGUAGE_CURRENCY','false','Automatically switch to the language\'s currency when it is changed',1,10,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(10,'Send Extra Order Emails To','SEND_EXTRA_ORDER_EMAILS_TO','','Send extra order emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;',1,11,NULL,'2007-06-12 22:50:01',NULL,NULL),(11,'Use Search-Engine Safe URLs (still in development)','SEARCH_ENGINE_FRIENDLY_URLS','false','Use search-engine safe urls for all site links',1,12,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(12,'Display Cart After Adding Product','DISPLAY_CART','true','Display the shopping cart after adding a product (or return back to their origin)',1,14,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(13,'Allow Guest To Tell A Friend','ALLOW_GUEST_TO_TELL_A_FRIEND','false','Allow guests to tell a friend about a product',1,15,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(14,'Default Search Operator','ADVANCED_SEARCH_DEFAULT_OPERATOR','and','Default search operators',1,17,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'and\', \'or\'), '),(15,'Store Address and Phone','STORE_NAME_ADDRESS','Store Name\nAddress\nCountry\nPhone','This is the Store Name, Address and Phone used on printable documents and displayed online',1,18,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_textarea('),(16,'Show Category Counts','SHOW_COUNTS','false','Count recursively how many products are in each category',1,19,'2007-08-13 20:02:16','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(17,'Tax Decimal Places','TAX_DECIMAL_PLACES','0','Pad the tax value this amount of decimal places',1,20,NULL,'2007-06-12 22:50:01',NULL,NULL),(18,'Display Prices with Tax','DISPLAY_PRICE_WITH_TAX','true','Display prices with tax included (true) or add the tax at the end (false)',1,21,'2007-11-04 14:12:51','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(19,'First Name','ENTRY_FIRST_NAME_MIN_LENGTH','2','Minimum length of first name',2,1,NULL,'2007-06-12 22:50:01',NULL,NULL),(20,'Last Name','ENTRY_LAST_NAME_MIN_LENGTH','2','Minimum length of last name',2,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(21,'Date of Birth','ENTRY_DOB_MIN_LENGTH','10','Minimum length of date of birth',2,3,NULL,'2007-06-12 22:50:01',NULL,NULL),(22,'E-Mail Address','ENTRY_EMAIL_ADDRESS_MIN_LENGTH','6','Minimum length of e-mail address',2,4,NULL,'2007-06-12 22:50:01',NULL,NULL),(23,'Street Address','ENTRY_STREET_ADDRESS_MIN_LENGTH','5','Minimum length of street address',2,5,NULL,'2007-06-12 22:50:01',NULL,NULL),(24,'Company','ENTRY_COMPANY_MIN_LENGTH','2','Minimum length of company name',2,6,NULL,'2007-06-12 22:50:01',NULL,NULL),(25,'Post Code','ENTRY_POSTCODE_MIN_LENGTH','4','Minimum length of post code',2,7,NULL,'2007-06-12 22:50:01',NULL,NULL),(26,'City','ENTRY_CITY_MIN_LENGTH','3','Minimum length of city',2,8,NULL,'2007-06-12 22:50:01',NULL,NULL),(27,'State','ENTRY_STATE_MIN_LENGTH','2','Minimum length of state',2,9,NULL,'2007-06-12 22:50:01',NULL,NULL),(28,'Telephone Number','ENTRY_TELEPHONE_MIN_LENGTH','3','Minimum length of telephone number',2,10,NULL,'2007-06-12 22:50:01',NULL,NULL),(29,'Password','ENTRY_PASSWORD_MIN_LENGTH','5','Minimum length of password',2,11,NULL,'2007-06-12 22:50:01',NULL,NULL),(30,'Credit Card Owner Name','CC_OWNER_MIN_LENGTH','3','Minimum length of credit card owner name',2,12,NULL,'2007-06-12 22:50:01',NULL,NULL),(31,'Credit Card Number','CC_NUMBER_MIN_LENGTH','10','Minimum length of credit card number',2,13,NULL,'2007-06-12 22:50:01',NULL,NULL),(32,'Review Text','REVIEW_TEXT_MIN_LENGTH','50','Minimum length of review text',2,14,NULL,'2007-06-12 22:50:01',NULL,NULL),(33,'Best Sellers','MIN_DISPLAY_BESTSELLERS','1','Minimum number of best sellers to display',2,15,NULL,'2007-06-12 22:50:01',NULL,NULL),(34,'Also Purchased','MIN_DISPLAY_ALSO_PURCHASED','1','Minimum number of products to display in the \'This Customer Also Purchased\' box',2,16,NULL,'2007-06-12 22:50:01',NULL,NULL),(35,'Address Book Entries','MAX_ADDRESS_BOOK_ENTRIES','5','Maximum address book entries a customer is allowed to have',3,1,NULL,'2007-06-12 22:50:01',NULL,NULL),(36,'Search Results','MAX_DISPLAY_SEARCH_RESULTS','20','Amount of products to list',3,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(37,'Page Links','MAX_DISPLAY_PAGE_LINKS','5','Number of \'number\' links use for page-sets',3,3,NULL,'2007-06-12 22:50:01',NULL,NULL),(38,'Special Products','MAX_DISPLAY_SPECIAL_PRODUCTS','9','Maximum number of products on special to display',3,4,NULL,'2007-06-12 22:50:01',NULL,NULL),(39,'New Products Module','MAX_DISPLAY_NEW_PRODUCTS','9','Maximum number of new products to display in a category',3,5,NULL,'2007-06-12 22:50:01',NULL,NULL),(40,'Products Expected','MAX_DISPLAY_UPCOMING_PRODUCTS','10','Maximum number of products expected to display',3,6,NULL,'2007-06-12 22:50:01',NULL,NULL),(41,'Manufacturers List','MAX_DISPLAY_MANUFACTURERS_IN_A_LIST','0','Used in manufacturers box; when the number of manufacturers exceeds this number, a drop-down list will be displayed instead of the default list',3,7,NULL,'2007-06-12 22:50:01',NULL,NULL),(42,'Manufacturers Select Size','MAX_MANUFACTURERS_LIST','1','Used in manufacturers box; when this value is \'1\' the classic drop-down list will be used for the manufacturers box. Otherwise, a list-box with the specified number of rows will be displayed.',3,7,NULL,'2007-06-12 22:50:01',NULL,NULL),(43,'Length of Manufacturers Name','MAX_DISPLAY_MANUFACTURER_NAME_LEN','15','Used in manufacturers box; maximum length of manufacturers name to display',3,8,NULL,'2007-06-12 22:50:01',NULL,NULL),(44,'New Reviews','MAX_DISPLAY_NEW_REVIEWS','6','Maximum number of new reviews to display',3,9,NULL,'2007-06-12 22:50:01',NULL,NULL),(45,'Selection of Random Reviews','MAX_RANDOM_SELECT_REVIEWS','10','How many records to select from to choose one random product review',3,10,NULL,'2007-06-12 22:50:01',NULL,NULL),(46,'Selection of Random New Products','MAX_RANDOM_SELECT_NEW','10','How many records to select from to choose one random new product to display',3,11,NULL,'2007-06-12 22:50:01',NULL,NULL),(47,'Selection of Products on Special','MAX_RANDOM_SELECT_SPECIALS','10','How many records to select from to choose one random product special to display',3,12,NULL,'2007-06-12 22:50:01',NULL,NULL),(48,'Categories To List Per Row','MAX_DISPLAY_CATEGORIES_PER_ROW','3','How many categories to list per row',3,13,NULL,'2007-06-12 22:50:01',NULL,NULL),(49,'New Products Listing','MAX_DISPLAY_PRODUCTS_NEW','10','Maximum number of new products to display in new products page',3,14,NULL,'2007-06-12 22:50:01',NULL,NULL),(50,'Best Sellers','MAX_DISPLAY_BESTSELLERS','10','Maximum number of best sellers to display',3,15,NULL,'2007-06-12 22:50:01',NULL,NULL),(51,'Also Purchased','MAX_DISPLAY_ALSO_PURCHASED','6','Maximum number of products to display in the \'This Customer Also Purchased\' box',3,16,NULL,'2007-06-12 22:50:01',NULL,NULL),(52,'Customer Order History Box','MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX','6','Maximum number of products to display in the customer order history box',3,17,NULL,'2007-06-12 22:50:01',NULL,NULL),(53,'Order History','MAX_DISPLAY_ORDER_HISTORY','10','Maximum number of orders to display in the order history page',3,18,NULL,'2007-06-12 22:50:01',NULL,NULL),(54,'Small Image Width','SMALL_IMAGE_WIDTH','100','The pixel width of small images',4,1,NULL,'2007-06-12 22:50:01',NULL,NULL),(55,'Small Image Height','SMALL_IMAGE_HEIGHT','','The pixel height of small images',4,2,'2007-08-05 01:51:34','2007-06-12 22:50:01',NULL,NULL),(56,'Heading Image Width','HEADING_IMAGE_WIDTH','57','The pixel width of heading images',4,3,'2007-08-14 23:41:05','2007-06-12 22:50:01',NULL,NULL),(57,'Heading Image Height','HEADING_IMAGE_HEIGHT','','The pixel height of heading images',4,4,'2007-08-01 22:32:43','2007-06-12 22:50:01',NULL,NULL),(58,'Subcategory Image Width','SUBCATEGORY_IMAGE_WIDTH','100','The pixel width of subcategory images',4,5,NULL,'2007-06-12 22:50:01',NULL,NULL),(59,'Subcategory Image Height','SUBCATEGORY_IMAGE_HEIGHT','','The pixel height of subcategory images',4,6,'2007-08-01 22:32:53','2007-06-12 22:50:01',NULL,NULL),(60,'Calculate Image Size','CONFIG_CALCULATE_IMAGE_SIZE','true','Calculate the size of images?',4,7,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(61,'Image Required','IMAGE_REQUIRED','true','Enable to display broken images. Good for development.',4,8,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(62,'Gender','ACCOUNT_GENDER','true','Display gender in the customers account',5,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(63,'Date of Birth','ACCOUNT_DOB','true','Display date of birth in the customers account',5,2,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(64,'Company','ACCOUNT_COMPANY','true','Display company in the customers account',5,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(65,'Suburb','ACCOUNT_SUBURB','true','Display suburb in the customers account',5,4,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(66,'State','ACCOUNT_STATE','true','Display state in the customers account',5,5,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(67,'Installed Modules','MODULE_PAYMENT_INSTALLED','cc.php;cod.php','List of payment module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: cc.php;cod.php;paypal.php)',6,0,'2007-10-22 16:10:53','2007-06-12 22:50:01',NULL,NULL),(68,'Installed Modules','MODULE_ORDER_TOTAL_INSTALLED','ot_subtotal.php;ot_shipping.php;ot_tax.php;ot_total.php','List of order_total module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)',6,0,'2007-12-04 03:38:32','2007-06-12 22:50:01',NULL,NULL),(69,'Installed Modules','MODULE_SHIPPING_INSTALLED','chp.php;chplet.php;chpletinpri.php','List of shipping module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ups.php;flat.php;item.php)',6,0,'2007-08-14 00:22:47','2007-06-12 22:50:01',NULL,NULL),(70,'Enable Cash On Delivery Module','MODULE_PAYMENT_COD_STATUS','True','Do you want to accept Cash On Delevery payments?',6,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(71,'Payment Zone','MODULE_PAYMENT_COD_ZONE','0','If a zone is selected, only enable this payment method for that zone.',6,2,NULL,'2007-06-12 22:50:01','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes('),(72,'Sort order of display.','MODULE_PAYMENT_COD_SORT_ORDER','0','Sort order of display. Lowest is displayed first.',6,0,NULL,'2007-06-12 22:50:01',NULL,NULL),(73,'Set Order Status','MODULE_PAYMENT_COD_ORDER_STATUS_ID','0','Set the status of orders made with this payment module to this value',6,0,NULL,'2007-06-12 22:50:01','tep_get_order_status_name','tep_cfg_pull_down_order_statuses('),(418,'Require CCV2','MODULE_PAYMENT_CC_CVV2','True','Require cvv2 numbers',6,0,NULL,'2007-10-22 16:10:52',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(417,'Set Order Status','MODULE_PAYMENT_CC_ORDER_STATUS_ID','0','Set the status of orders made with this payment module to this value',6,0,NULL,'2007-10-22 16:10:52','tep_get_order_status_name','tep_cfg_pull_down_order_statuses('),(415,'Sort order of display.','MODULE_PAYMENT_CC_SORT_ORDER','0','Sort order of display. Lowest is displayed first.',6,0,NULL,'2007-10-22 16:10:52',NULL,NULL),(416,'Payment Zone','MODULE_PAYMENT_CC_ZONE','0','If a zone is selected, only enable this payment method for that zone.',6,2,NULL,'2007-10-22 16:10:52','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes('),(413,'Enable Credit Card Module','MODULE_PAYMENT_CC_STATUS','True','Do you want to accept credit card payments?',6,0,NULL,'2007-10-22 16:10:52',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(414,'Split Credit Card E-Mail Address','MODULE_PAYMENT_CC_EMAIL','','If an e-mail address is entered, the middle digits of the credit card number will be sent to the e-mail address (the outside digits are stored in the database with the middle digits censored)',6,0,NULL,'2007-10-22 16:10:52',NULL,NULL),(84,'Default Currency','DEFAULT_CURRENCY','CHF','Default Currency',6,0,NULL,'2007-06-12 22:50:01',NULL,NULL),(85,'Default Language','DEFAULT_LANGUAGE','en','Default Language',6,0,NULL,'2007-06-12 22:50:01',NULL,NULL),(86,'Default Order Status For New Orders','DEFAULT_ORDERS_STATUS_ID','1','When a new order is created, this order status will be assigned to it.',6,0,NULL,'2007-06-12 22:50:01',NULL,NULL),(87,'Display Shipping','MODULE_ORDER_TOTAL_SHIPPING_STATUS','true','Do you want to display the order shipping cost?',6,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(88,'Sort Order','MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER','2','Sort order of display.',6,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(89,'Allow Free Shipping','MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING','false','Do you want to allow free shipping?',6,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(90,'Free Shipping For Orders Over','MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER','50','Provide free shipping for orders over the set amount.',6,4,NULL,'2007-06-12 22:50:01','currencies->format',NULL),(91,'Provide Free Shipping For Orders Made','MODULE_ORDER_TOTAL_SHIPPING_DESTINATION','national','Provide free shipping for orders sent to the set destination.',6,5,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'national\', \'international\', \'both\'), '),(92,'Display Sub-Total','MODULE_ORDER_TOTAL_SUBTOTAL_STATUS','true','Do you want to display the order sub-total cost?',6,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(93,'Sort Order','MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER','1','Sort order of display.',6,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(94,'Display Tax','MODULE_ORDER_TOTAL_TAX_STATUS','true','Do you want to display the order tax value?',6,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(95,'Sort Order','MODULE_ORDER_TOTAL_TAX_SORT_ORDER','3','Sort order of display.',6,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(96,'Display Total','MODULE_ORDER_TOTAL_TOTAL_STATUS','true','Do you want to display the total order value?',6,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(97,'Sort Order','MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER','4','Sort order of display.',6,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(98,'Country of Origin','SHIPPING_ORIGIN_COUNTRY','204','Select the country of origin to be used in shipping quotes.',7,1,'2007-08-07 22:06:02','2007-06-12 22:50:01','tep_get_country_name','tep_cfg_pull_down_country_list('),(99,'Postal Code','SHIPPING_ORIGIN_ZIP','8049','Enter the Postal Code (ZIP) of the Store to be used in shipping quotes.',7,2,'2007-08-07 22:06:07','2007-06-12 22:50:01',NULL,NULL),(100,'Enter the Maximum Package Weight you will ship','SHIPPING_MAX_WEIGHT','30','Carriers have a max weight limit for a single package. This is a common one for all.',7,3,'2007-08-07 22:06:20','2007-06-12 22:50:01',NULL,NULL),(101,'Package Tare weight.','SHIPPING_BOX_WEIGHT','0','What is the weight of typical packaging of small to medium packages?',7,4,'2007-08-07 22:05:49','2007-06-12 22:50:01',NULL,NULL),(102,'Larger packages - percentage increase.','SHIPPING_BOX_PADDING','0','For 10% enter 10',7,5,'2007-08-07 22:05:53','2007-06-12 22:50:01',NULL,NULL),(103,'Display Product Image','PRODUCT_LIST_IMAGE','1','Do you want to display the Product Image?',8,1,NULL,'2007-06-12 22:50:01',NULL,NULL),(104,'Display Product Manufaturer Name','PRODUCT_LIST_MANUFACTURER','0','Do you want to display the Product Manufacturer Name?',8,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(105,'Display Product Model','PRODUCT_LIST_MODEL','0','Do you want to display the Product Model?',8,3,NULL,'2007-06-12 22:50:01',NULL,NULL),(106,'Display Product Name','PRODUCT_LIST_NAME','2','Do you want to display the Product Name?',8,4,NULL,'2007-06-12 22:50:01',NULL,NULL),(107,'Display Product Price','PRODUCT_LIST_PRICE','3','Do you want to display the Product Price',8,5,NULL,'2007-06-12 22:50:01',NULL,NULL),(108,'Display Product Quantity','PRODUCT_LIST_QUANTITY','0','Do you want to display the Product Quantity?',8,6,NULL,'2007-06-12 22:50:01',NULL,NULL),(109,'Display Product Weight','PRODUCT_LIST_WEIGHT','0','Do you want to display the Product Weight?',8,7,NULL,'2007-06-12 22:50:01',NULL,NULL),(110,'Display Buy Now column','PRODUCT_LIST_BUY_NOW','4','Do you want to display the Buy Now column?',8,8,NULL,'2007-06-12 22:50:01',NULL,NULL),(111,'Display Category/Manufacturer Filter (0=disable; 1=enable)','PRODUCT_LIST_FILTER','1','Do you want to display the Category/Manufacturer Filter?',8,9,NULL,'2007-06-12 22:50:01',NULL,NULL),(112,'Location of Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)','PREV_NEXT_BAR_LOCATION','2','Sets the location of the Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)',8,10,NULL,'2007-06-12 22:50:01',NULL,NULL),(113,'Check stock level','STOCK_CHECK','true','Check to see if sufficent stock is available',9,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(114,'Subtract stock','STOCK_LIMITED','true','Subtract product in stock by product orders',9,2,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(115,'Allow Checkout','STOCK_ALLOW_CHECKOUT','true','Allow customer to checkout even if there is insufficient stock',9,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(116,'Mark product out of stock','STOCK_MARK_PRODUCT_OUT_OF_STOCK','***','Display something on screen so customer can see which product has insufficient stock',9,4,NULL,'2007-06-12 22:50:01',NULL,NULL),(117,'Stock Re-order level','STOCK_REORDER_LEVEL','5','Define when stock needs to be re-ordered',9,5,NULL,'2007-06-12 22:50:01',NULL,NULL),(118,'Store Page Parse Time','STORE_PAGE_PARSE_TIME','false','Store the time it takes to parse a page',10,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(119,'Log Destination','STORE_PAGE_PARSE_TIME_LOG','/var/log/www/tep/page_parse_time.log','Directory and filename of the page parse time log',10,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(120,'Log Date Format','STORE_PARSE_DATE_TIME_FORMAT','%d/%m/%Y %H:%M:%S','The date format',10,3,NULL,'2007-06-12 22:50:01',NULL,NULL),(121,'Display The Page Parse Time','DISPLAY_PAGE_PARSE_TIME','true','Display the page parse time (store page parse time must be enabled)',10,4,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(122,'Store Database Queries','STORE_DB_TRANSACTIONS','false','Store the database queries in the page parse time log (PHP4 only)',10,5,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(123,'Use Cache','USE_CACHE','false','Use caching features',11,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(124,'Cache Directory','DIR_FS_CACHE','/tmp/','The directory where the cached files are saved',11,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(125,'E-Mail Transport Method','EMAIL_TRANSPORT','sendmail','Defines if this server uses a local connection to sendmail or uses an SMTP connection via TCP/IP. Servers running on Windows and MacOS should change this setting to SMTP.',12,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'sendmail\', \'smtp\'),'),(126,'E-Mail Linefeeds','EMAIL_LINEFEED','LF','Defines the character sequence used to separate mail headers.',12,2,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'LF\', \'CRLF\'),'),(127,'Use MIME HTML When Sending Emails','EMAIL_USE_HTML','false','Send e-mails in HTML format',12,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(128,'Verify E-Mail Addresses Through DNS','ENTRY_EMAIL_ADDRESS_CHECK','false','Verify e-mail address through a DNS server',12,4,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(129,'Send E-Mails','SEND_EMAILS','true','Send out e-mails',12,5,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(130,'Enable download','DOWNLOAD_ENABLED','false','Enable the products download functions.',13,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(131,'Download by redirect','DOWNLOAD_BY_REDIRECT','false','Use browser redirection for download. Disable on non-Unix systems.',13,2,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(132,'Expiry delay (days)','DOWNLOAD_MAX_DAYS','7','Set number of days before the download link expires. 0 means no limit.',13,3,NULL,'2007-06-12 22:50:01',NULL,''),(133,'Maximum number of downloads','DOWNLOAD_MAX_COUNT','5','Set the maximum number of downloads. 0 means no download authorized.',13,4,NULL,'2007-06-12 22:50:01',NULL,''),(134,'Enable GZip Compression','GZIP_COMPRESSION','false','Enable HTTP GZip compression.',14,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(135,'Compression Level','GZIP_LEVEL','5','Use this compression level 0-9 (0 = minimum, 9 = maximum).',14,2,NULL,'2007-06-12 22:50:01',NULL,NULL),(136,'Session Directory','SESSION_WRITE_DIRECTORY','C:\\xampp\\htdocs\\swisscart\\trunk\\temp','If sessions are file based, store them in this directory.',15,1,NULL,'2007-06-12 22:50:01',NULL,NULL),(137,'Force Cookie Use','SESSION_FORCE_COOKIE_USE','False','Force the use of sessions when cookies are only enabled.',15,2,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(138,'Check SSL Session ID','SESSION_CHECK_SSL_SESSION_ID','False','Validate the SSL_SESSION_ID on every secure HTTPS page request.',15,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(139,'Check User Agent','SESSION_CHECK_USER_AGENT','False','Validate the clients browser user agent on every page request.',15,4,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(140,'Check IP Address','SESSION_CHECK_IP_ADDRESS','False','Validate the clients IP address on every page request.',15,5,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(141,'Prevent Spider Sessions','SESSION_BLOCK_SPIDERS','True','Prevent known spiders from starting a session.',15,6,'2007-11-27 19:38:31','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(142,'Recreate Session','SESSION_RECREATE','False','Recreate the session to generate a new session ID when the customer logs on or creates an account (PHP >=4.1 needed).',15,7,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(143,'Enable SEO URLs?','SEO_ENABLED','false','Enable the SEO URLs?  This is a global setting and will turn them off completely.',16,0,'2007-11-08 22:21:23','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(144,'Add cPath to product URLs?','SEO_ADD_CPATH_TO_PRODUCT_URLS','false','This setting will append the cPath to the end of product URLs (i.e. - some-product-p-1.html?cPath=xx).',16,1,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(145,'Add category parent to begining of URLs?','SEO_ADD_CAT_PARENT','true','This setting will add the category parent name to the beginning of the category URLs (i.e. - parent-category-c-1.html).',16,2,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(146,'Filter Short Words','SEO_URLS_FILTER_SHORT_WORDS','3','This setting will filter words less than or equal to the value from the URL.',16,3,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,NULL),(147,'Output W3C valid URLs (parameter string)?','SEO_URLS_USE_W3C_VALID','true','This setting will output W3C valid URLs.',16,4,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(148,'Enable SEO cache to save queries?','USE_SEO_CACHE_GLOBAL','true','This is a global setting and will turn off caching completely.',16,5,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(149,'Enable product cache?','USE_SEO_CACHE_PRODUCTS','true','This will turn off caching for the products.',16,6,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(150,'Enable categories cache?','USE_SEO_CACHE_CATEGORIES','true','This will turn off caching for the categories.',16,7,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(151,'Enable manufacturers cache?','USE_SEO_CACHE_MANUFACTURERS','true','This will turn off caching for the manufacturers.',16,8,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(152,'Enable articles cache?','USE_SEO_CACHE_ARTICLES','true','This will turn off caching for the articles.',16,9,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(153,'Enable topics cache?','USE_SEO_CACHE_TOPICS','true','This will turn off caching for the article topics.',16,10,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(154,'Enable information cache?','USE_SEO_CACHE_INFO_PAGES','true','This will turn off caching for the information pages.',16,11,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(155,'Enable automatic redirects?','USE_SEO_REDIRECT','true','This will activate the automatic redirect code and send 301 headers for old to new URLs.',16,12,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(156,'Choose URL Rewrite Type','SEO_REWRITE_TYPE','Rewrite','Choose which SEO URL format to use.',16,13,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'Rewrite\'),'),(157,'Enter special character conversions','SEO_CHAR_CONVERT_SET','ä=>ae,ö=>oe,ü=>ue,Ä=>Ae,Ö=>Oe,Ü=>Ue,ß=>ss,é=>e,è=>e,à=>a,É=>E','This setting will convert characters.<br><br>The format <b>MUST</b> be in the form: <b>char=>conv,char2=>conv2</b>',16,14,'2007-11-06 19:48:17','2007-06-12 23:21:07',NULL,NULL),(158,'Remove all non-alphanumeric characters?','SEO_REMOVE_ALL_SPEC_CHARS','false','This will remove all non-letters and non-numbers.  This should be handy to remove all special characters with 1 setting.',16,15,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(159,'Reset SEO URLs Cache','SEO_URLS_CACHE_RESET','false','This will reset the cache data for SEO',16,16,'2007-06-12 23:31:15','2007-06-12 23:21:07','tep_reset_cache_data_seo_urls','tep_cfg_select_option(array(\'reset\', \'false\'),'),(160,'Installed Modules','MODULE_STS_INSTALLED','sts_default.php;sts_product_info.php','This is automatically updated. No need to edit.',6,0,'2007-11-07 21:06:16','2007-06-13 16:11:39',NULL,NULL),(169,'Code for debug output','MODULE_STS_DEBUG_CODE','debug','Code to enable debug output from URL (ex: index.php?sts_debug=debug',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL),(170,'Files for normal template','MODULE_STS_DEFAULT_NORMAL','sts_user_code.php;headertags.php','Files to include for a normal template, separated by semicolon',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL),(171,'Base folder','MODULE_STS_TEMPLATES_FOLDER','includes/sts_templates/','Base folder where the templates folders are located. Relative to your catalog folder. Should end with a slash',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL),(172,'Template folder','MODULE_STS_TEMPLATE_FOLDER','swisscart','This is the template folder in use, located inside the previous parameter. Do not start nor end with a slash',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL),(173,'Default template file','MODULE_STS_TEMPLATE_FILE','sts_template.html','Name of the default template file',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL),(174,'Use template for infoboxes','MODULE_STS_INFOBOX_STATUS','true','Do you want to use templates for infoboxes?',6,1,NULL,'2007-06-13 16:12:04',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(168,'Use Templates?','MODULE_STS_DEFAULT_STATUS','true','Do you want to use Simple Template System?',6,1,NULL,'2007-06-13 16:12:04',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(185,'Use template for product info page','MODULE_STS_PRODUCT_INFO_STATUS','false','Do you want to use templates for product info pages?',6,1,NULL,'2007-07-07 03:33:35',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(189,'Lightbox Popup Images','LIGHTBOX_ENABLE','true','Lightbox is a simple, unobtrusive script used to overlay images on the product detail page.',4,10,'2007-12-11 02:20:47','2007-07-07 03:59:26',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(188,'Files for content template','MODULE_STS_PRODUCT_INFO_CONTENT','sts_user_code.php;product_info.php;headertags.php','Files to include for a content template, separated by semicolon',6,3,NULL,'2007-07-07 03:33:35',NULL,NULL),(186,'Enable STS3 compatibility mode','MODULE_STS_PRODUCT_V3COMPAT','false','Do you want to enable the STS v3 compatibility mode (only for product info templates made with STS v2 and v3)?',6,1,NULL,'2007-07-07 03:33:35',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(187,'Files for normal template','MODULE_STS_PRODUCT_INFO_NORMAL','sts_user_code.php;headertags.php','Files to include for a normal template, separated by semicolon',6,2,NULL,'2007-07-07 03:33:35',NULL,NULL),(190,'Info-Seiten-ID der AGBs','CONDITIONS_INFOID','7','Setzen Sie hier die Seiten-ID der Allgemeinen Geschäftsbedingungen im Info-Manager ein. Der Text wird dann im Checkout automatisch eingebunden.',1,30,NULL,'2007-07-28 06:07:18',NULL,NULL),(191,'Product Information Image Width','PRODUCT_INFO_IMAGE_WIDTH','350','The pixel width of images shown on your product information page',4,100,'2007-11-05 04:51:30','2005-01-06 20:24:30',NULL,''),(192,'Product Information Image Height','PRODUCT_INFO_IMAGE_HEIGHT','','The pixel height of images shown on your product information page',4,101,'2007-08-01 22:33:11','2005-01-06 20:24:30',NULL,''),(193,'Image Magic Master Switch','CFG_MASTER_SWITCH','On','Switch OSC Image Magic on or off',333,3,'2007-08-01 19:15:53','2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'On\', \'Off\'),'),(194,'Apply security features to registered customers','CFG_REGISTERED_WATERMARKS','Yes','If this option is set to no, all image security features will be disabled when a registered customer is browsing your site',333,4,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(195,'Help support the OSC Image Magic Project','','Make a donation','Reward the author & support future releases. Please click the button below to make a donation<p><a href=\"http://www.celtware.com/im/donate.php?ref=6350088749406942\"><img src=\"http://www.celtware.com/im/donate.php?ref=img6350088749406942\" border=\"0\"></a>',333,-1,'2005-10-03 03:08:38','1899-12-29 00:00:00','','tep_cfg_readonly('),(196,'Process Store\'s Graphics','CFG_PROCESS_GRAPHICS','False','If this is set to true, ALL store graphics will be processed and cached, including buttons, clip art etc. The default, recommended setting for this is False',333,6,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(197,'Auto Clean Cache','CFG_CACHE_AUTO_CLEAN','True','If selected, the cache will automatically be cleared of un-needed items. Set to true if you want to sacrifice a small amount of performance for server disk space saving',333,9,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(198,'Encrypt Image Filenames','CFG_ENCRYPT_FILENAMES','False','If you select this option all of your filenames will be encrypted. This option will prevent visitors from discovering your image filenames. Use it in combination with image watermarking to prevent theft of your images.',333,12,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(199,'Filename Encryption Key','CFG_ENCRYPTION_KEY','changeme','If you have switched on image filename encryption, then enter a string here to be used as the encryption key',333,15,NULL,'2005-01-06 20:24:30',NULL,''),(200,'Apply Internet Explorer PNG Transparency work-around?','CFG_PNG_BUG','False','This option will switch on a work-around so that PNG alpha transparency images will display correctly in Internet Explorer<br><b>Note:</b> Two files need to be modified to enable this - See readme.',333,18,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(201,'Use Resampling','CFG_USE_RESAMPLING','True','If selected, thumbnails will be resampled rather than resized. Resampling creates much higher quality thumbnails.',333,21,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(202,'Create Truecolour Thumbnails','CFG_CREATE_TRUECOLOR','True','Create True color Thumbnails? Better quality overall but set to false if you have GD version < 2.01 or if creating transparent thumbnails.',333,24,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(203,'Output GIFs as JPEGs','CFG_GIFS_AS_JPEGS','False','Set this option true if you have GD version > 1.6 and want to output GIFs as JPGs. Note that transparencies will not be retained (set matte colour below). If you have GD Library < 1.6 with GIF create support, GIFs will be output as GIFs.',333,27,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(204,'\'GIF as JPEG\' Matte colour (HEX)','CFG_MATTE_COLOR','FFFFFF','Enter the HEX colour value that transparent backgrounds will be converted to if GIFs output as JPGs',333,28,NULL,'2005-01-06 20:24:30',NULL,''),(205,'Cache Thumbnails on the Server','CFG_TN_SERVER_CACHE','True','Set to true if you want to cache previously processed thumbnails on disk. This will add to disk space but will save your processor from having to create a new thumbnail for every visitor. (recommended)',333,30,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(206,'Cache Thumbnails in user\'s browser','CFG_TN_BROWSER_CACHE','True','Set to true if you want browsers to be able to cache viewed thumbnails in their own cache. This will save bandwidth for every visitor that views the same thumbnail again. (recommended)',333,31,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(207,'Thumbnail Cache directory','CFG_TN_CACHE_DIRECTORY','images/thumbnails','Directory where cached thumbnails will be stored. <br><b>Note:</b> This directory should be automatically created, if not, do so manually and chmod it to 777',333,33,'2007-08-01 18:38:19','2005-01-06 20:24:30',NULL,''),(208,'Use 404 Response if image not found?','CFG_USE_404','True','If set to true a 404 (not found) response will be sent (broken image), otherwise a small error picture will be shown',333,36,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(209,'Allow thumbnails larger than original','CFG_ALLOW_LARGER','False','Set to true if you want to allow scaling UP of source image files.',333,45,'2007-11-04 13:41:32','2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(210,'Center if thumbnail larger than original','CFG_CENTER_THUMB','False','If your source is smaller than the thumbnail, should it be centered on the larger thumbnail rather than resized?<br><b>Note:</b> \'Allow thumbnails larger than original\' (above) must be set to true',333,46,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(211,'JPEG Quality - Pop-up Images','POPUP_JPEG_QUALITY','100','The output quality of JPEG pop-up images.',333,48,NULL,'2005-01-06 20:24:30',NULL,NULL),(212,'JPEG Quality - Product Information Thumbnails','PRODUCT_JPEG_QUALITY','100','The output quality of JPEG thumbnails displayed on your product information page',333,51,NULL,'2005-01-06 20:24:30',NULL,NULL),(213,'JPEG Quality - Category Thumbnails','CATEGORY_JPEG_QUALITY','100','The output quality of category JPEG thumbnails',333,52,NULL,'2005-01-06 20:24:30',NULL,NULL),(214,'JPEG Quality - Heading Thumbnails','HEADING_JPEG_QUALITY','100','The output quality of heading JPEG thumbnails',333,53,NULL,'2005-01-06 20:24:30',NULL,NULL),(215,'JPEG Quality - Small Thumbnails','SMALL_JPEG_QUALITY','100','The output quality of your small sized JPEG thumbnails',333,55,NULL,'2005-01-06 20:24:30',NULL,NULL),(216,'Graphic Watermark in Pop-up Images','USE_WATERMARK_IMAGE_POPUP','No','Do you wish to use a watermark image in your pop-up product image?<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images',333,57,'2007-08-01 19:43:12','2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(217,'Graphic Watermark in Product Information Thumbnails','USE_WATERMARK_IMAGE_PRODUCT','No','Do you wish to use a watermark image in your product information thumbnails?<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images',333,58,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(218,'Graphic Watermark in Category Thumbnails','USE_WATERMARK_IMAGE_CATEGORY','No','Do you wish to use a watermark image in your category thumbnails?<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images',333,59,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(219,'Graphic Watermark in Heading Thumbnails','USE_WATERMARK_IMAGE_HEADING','No','Do you wish to use a watermark image in your heading thumbnails?<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images',333,60,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(220,'Graphic Watermark in Small Thumbnails','USE_WATERMARK_IMAGE_SMALL','No','Do you wish to use a watermark image in your small thumbnails<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images?',333,61,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(221,'Watermark Image File','WATERMARK_IMAGE','logo.png','Select which watermark image you wish to use<br><br>New watermark images may be installed in your:<br><b>/catalog/includes/imagemagic/watermarks/</b><br>directory<br>',333,66,'2007-08-01 19:41:04','2005-01-06 20:24:30',NULL,'tep_cfg_pull_down_installed_watermarks('),(222,'Image Watermark Transparency','WATERMARK_IMAGE_OPACITY','80','Enter a value of 0 to 100 to set the opacity value of your watermark image (0=transparent, 100=opaque)',333,69,'2007-12-11 03:58:22','2005-01-06 20:24:30',NULL,''),(223,'Image Watermark Position','WATERMARK_IMAGE_POSITION','Top','Select where you would like your watermark image to be positioned on your thumbnail',333,71,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_pull_down_watermark_alignment('),(224,'Image Watermark Margin','WATERMARK_IMAGE_MARGIN','0','Enter the offset in pixels where you would like your watermark image to be positioned',333,72,NULL,'2005-01-06 20:24:30',NULL,''),(225,'Resize Watermark Image','CFG_RESIZE_WATERMARK','True','If selected, your watermark image will be resized in the same ratio as your source image, otherwise the watermark image will always be added full-sized',333,73,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),'),(226,'Text Watermark in Pop-up Images','USE_WATERMARK_TEXT_POPUP','Yes','Do you wish to use watermark text in your pop-up product images?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,75,'2007-08-01 19:36:36','2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(227,'Text Watermark in Product Information Thumbnails','USE_WATERMARK_TEXT_PRODUCT','No','Do you wish to use watermark text in your product information thumbnails?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,76,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(228,'Text Watermark in Category Thumbnails','USE_WATERMARK_TEXT_CATEGORY','No','Do you wish to use watermark text in your category thumbnails?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,77,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(229,'Text Watermark in Heading Thumbnails','USE_WATERMARK_TEXT_HEADING','No','Do you wish to use watermark text in your heading thumbnails?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,78,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(230,'Text Watermark in Small Thumbnails','USE_WATERMARK_TEXT_SMALL','No','Do you wish to use watermark text in your small thumbnails?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,79,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(231,'Watermark Text','WATERMARK_TEXT','SWISSCART','Enter the text you wish to appear in your thumbnails as a watermark',333,84,'2007-12-11 04:07:40','2005-01-06 20:24:30',NULL,''),(232,'Text Watermark Font Name','WATERMARK_TEXT_FONT','arial.ttf','Select the font filename you wish to use for watermark text<br><br>New TTF fonts may be installed in your:<br><b>/catalog/includes/imagemagic/fonts/</b><br>directory<br>',333,87,'2007-12-11 04:05:55','2005-01-06 20:24:30',NULL,'tep_cfg_pull_down_installed_fonts('),(233,'Text Watermark Size','WATERMARK_TEXT_SIZE','30','Enter the font point size of your text watermark',333,90,'2007-12-11 04:07:02','2005-01-06 20:24:30',NULL,''),(234,'Text Watermark Colour (HEX)','WATERMARK_TEXT_COLOR','000000','Enter the hex value for the colour of your text watermark',333,93,NULL,'2005-01-06 20:24:30',NULL,''),(235,'Text Watermark Transparency','WATERMARK_TEXT_OPACITY','7','Enter a value of 0 to 100 to set the transparency value of your watermark text (0=transparent, 100=opaque)',333,96,'2007-12-11 04:07:12','2005-01-06 20:24:30',NULL,''),(236,'Text Watermark Position','WATERMARK_TEXT_POSITION','Bottom Left','Select where you would like your watermark text to be positioned on your thumbnails',333,99,'2007-12-11 04:05:29','2005-01-06 20:24:30',NULL,'tep_cfg_pull_down_watermark_alignment('),(237,'Text Watermark Margin','WATERMARK_TEXT_MARGIN','0','Enter the offset in pixels where you would like your watermark text to be positioned',333,102,NULL,'2005-01-06 20:24:30',NULL,''),(238,'Text Watermark Angle','WATERMARK_TEXT_ANGLE','90','Enter the counter-clockwise angle of the text watermark',333,105,'2007-12-11 04:04:54','2005-01-06 20:24:30',NULL,''),(239,'Auto Adjust Brightness','BRIGHTNESS_ADJUST','0','Enter an amount between -255 and 255 which your thumbnail brightness will be adjusted by<br><b>Note:</b> This will not work with GIF images',333,108,NULL,'2005-01-06 20:24:30',NULL,''),(240,'Auto Adjust Contrast','CONTRAST_ADJUST','0','Enter an amount between -255 and 255 which your thumbnail contrast will be adjusted by<br><b>Note:</b> This will not work with GIF images',333,111,NULL,'2005-01-06 20:24:30',NULL,''),(241,'Frame Pop-up Images','FRAME_POPUP','No','Do you want to include a frame around your pop-up product images?',333,114,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(242,'Frame Product Information Thumbnails','FRAME_PRODUCT','No','Do you want to include a frame around your product information thumbnails?',333,115,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(243,'Frame Category Thumbnails','FRAME_CATEGORY','No','Do you want to include a frame around your category thumbnails?',333,116,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(244,'Frame Heading Thumbnails','FRAME_HEADING','No','Do you want to include a frame around your heading thumbnails?',333,117,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(245,'Frame Small Thumbnails','FRAME_SMALL','No','Do you want to include a frame around your small thumbnails?',333,118,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(246,'Frame Width','FRAME_WIDTH','4','Enter the width in pixels of the thumbnail frame',333,120,NULL,'2005-01-06 20:24:30',NULL,''),(247,'Frame Depth','FRAME_EDGE_WIDTH','4','Enter the 3D depth of the frame in pixels',333,123,NULL,'2005-01-06 20:24:30',NULL,''),(248,'Frame Colour (HEX)','FRAME_COLOR','CCCCCC','Enter the HEX colour of the thumbnail frame',333,126,NULL,'2005-01-06 20:24:30',NULL,''),(249,'Frame Inside 3D Highlight Colour (HEX)','FRAME_INSIDE_COLOR1','FFFFFF','Enter the colour (in hex) you wish the frame\'s inside higlight colour to be',333,129,NULL,'2005-01-06 20:24:30',NULL,''),(250,'Frame Inside 3D Shadow Colour (HEX)','FRAME_INSIDE_COLOR2','000000','Enter the colour (in hex) you wish the frame\'s inside shadow colour to be',333,132,NULL,'2005-01-06 20:24:30',NULL,''),(251,'Buttonize Pop-up Images','BEVEL_POPUP','No','Do you want to add a 3D button effect to your pop-up images?',333,133,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(252,'Buttonize Product Information Thumbnails','BEVEL_PRODUCT','No','Do you want to add a 3D button effect to your product information thumbnails?',333,134,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(253,'Buttonize Category Thumbnails','BEVEL_CATEGORY','No','Do you want to add a 3D button effect to your category thumbnails?',333,135,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(254,'Buttonize Heading Thumbnails','BEVEL_HEADING','No','Do you want to add a 3D button effect to your heading thumbnails?',333,136,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(255,'Buttonize Small Thumbnails','BEVEL_SMALL','No','Do you want to add a 3D button effect to your small thumbnails?',333,137,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),'),(256,'Button Height','BEVEL_HEIGHT','4','Enter the height in pixels of the 3D button effect',333,144,NULL,'2005-01-06 20:24:30',NULL,''),(257,'Button Highlight Colour (HEX)','BEVEL_HIGHLIGHT','CCCCCC','Enter the colour (in hex) you wish the button\'s higlight colour to be',333,147,NULL,'2005-01-06 20:24:30',NULL,''),(258,'Button Shadow Colour (HEX)','BEVEL_SHADOW','000000','Enter the colour (in hex) you wish the button\'s shadow colour to be',333,150,NULL,'2005-01-06 20:24:30',NULL,''),(259,'Last Hash (System Use - Read Only)','LAST_HASH','bec0f307fef7cc320d37f1e145e453d3','Stores the last hash value of the thumbnail configuration settings.  This will allow the script to detect when they have changed and maintain the cache.',333,153,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_readonly('),(425,'Order Fee For Orders Under','MODULE_ORDER_TOTAL_LOWORDERFEE_ORDER_UNDER','50','Add the low order fee to orders under this amount.',6,4,NULL,'2007-12-04 03:38:38','currencies->format',NULL),(426,'Order Fee','MODULE_ORDER_TOTAL_LOWORDERFEE_FEE','5','Low order fee.',6,5,NULL,'2007-12-04 03:38:38','currencies->format',NULL),(412,'TinyMCE Theme (Display Mode)','TINYMCE_THEME','advanced','Simple will only give a couple of features for the text area fields, advanced will give a whole lot more of them, but will also take longer to load',17,1,'2007-11-07 21:26:16','2007-08-09 19:02:22',NULL,'tep_cfg_select_option(array(\'simple\', \'advanced\'), '),(411,'Heading Image Enabled','HEADING_IMAGE_ENABLED','false','Show the small image on the top right of every shop page?',4,3,'2007-08-15 00:02:40','2007-08-14 23:45:44',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),'),(410,'Tariftabelle für Zone 5 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_7','0.5:92,1:106,1.5:121,2:135,2.5:149,3:164,3.5:178,4:193,4.5:207,5:221,6:241,7:261,8:280,9:300,10:319,11:338,12:356,13:375,14:393,15:412,16:431,17:449,18:468,19:486,20:505,21:522,22:540,23:557,24:575,25:592,26:610,27:627,28:645,29:662,30:680','Tarif Tabelle für die Zone 5, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(409,'Tariftabelle für Zone 5 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_7','2:65,3:83,4:101,5:119,6:136,7:153,8:170,9:187,10:204,11:219,12:234,13:249,14:264,15:279,16:294,17:309,18:324,19:339,20:354,21:367,22:380,23:393,24:406,25:419,26:432,27:445,28:458,29:471,30:484','Tarif Tabelle für die Zone 5, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(408,'Tariftabelle für Zone 5 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_7','2:47,3:55,4:63,5:71,6:79,7:87,8:95,9:103,10:111,11:118,12:125,13:132,14:139,15:146,16:152,17:160,18:166,19:172,20:178,21:184,22:190,23:196,24:202,25:206,26:211,27:216,28:221,29:226,30:231','Tarif Tabelle für die Zone 5, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(407,'Tarifzone 5 Länder','MODULE_SHIPPING_CHP_COUNTRIES_7','AR,AW,AU,BO,BR,BN,CL,CO,CK,EC,FK,FJ,GF,PF,GY,ID,KI,NR,AN,NC,NZ,NF,PG,PY,PE,PH,PN,WS,SB,SR,TP,TO,TT,TV,UY,VU,VE,WF','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 5 sind.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(406,'Tariftabelle für Zone 4 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_6','0.5:83,1:96,1.5:108,2:121,2.5:133,3:145,3.5:158,4:170,4.5:182,5:195,6:214,7:234,8:253,9:273,10:293,11:311,12:330,13:348,14:367,15:385,16:404,17:422,18:441,19:459,20:478,21:495,22:513,23:530,24:548,25:565,26:583,27:600,28:618,29:636,30:653','Tarif Tabelle für die Zone 4, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(404,'Tariftabelle für Zone 4 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_6','2:43,3:50,4:57,5:64,6:71,7:78,8:85,9:92,10:99,11:104,12:109,13:114,14:119,15:124,16:129,17:134,18:139,19:144,20:149,21:153,22:157,23:161,24:165,25:169,26:173,27:177,28:181,29:185,30:189','Tarif Tabelle für die Zone 4, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(405,'Tariftabelle für Zone 4 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_6','2:53,3:67,4:80,5:94,6:107,7:120,8:133,9:146,10:159,11:167,12:177,13:187,14:197,15:207,16:215,17:223,18:231,19:239,20:247,21:255,22:263,23:271,24:279,25:287,26:295,27:303,28:311,29:319,30:327','Tarif Tabelle für die Zone 4, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(403,'Tarifzone 4 Länder','MODULE_SHIPPING_CHP_COUNTRIES_6','LR,MO,MG,MW,MY,MV,ML,MQ,MR,MU,YT,MX,MN,MS,MZ,MM,NA,NP,NI,NE,NG,OM,PK,PA,QA,RE,RW,KN,LC,VC,SH,ZM,SM,ST,SA,SN,SC,SL,SG,SO,ZA,LK,SD,SZ,TW,TJ,TZ,TH,TG,TM,TC,UG,AE,UZ,VN,VG,VI,ZW','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 4 sind.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(402,'Tariftabelle für Zone 4 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_5','0.5:83,1:96,1.5:108,2:121,2.5:133,3:145,3.5:158,4:170,4.5:182,5:195,6:214,7:234,8:253,9:273,10:293,11:311,12:330,13:348,14:367,15:385,16:404,17:422,18:441,19:459,20:478,21:495,22:513,23:530,24:548,25:565,26:583,27:600,28:618,29:636,30:653','Tarif Tabelle für die Zone 4, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(401,'Tariftabelle für Zone 4 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_5','2:53,3:67,4:80,5:94,6:107,7:120,8:133,9:146,10:159,11:167,12:177,13:187,14:197,15:207,16:215,17:223,18:231,19:239,20:247,21:255,22:263,23:271,24:279,25:287,26:295,27:303,28:311,29:319,30:327','Tarif Tabelle für die Zone 4, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(400,'Tariftabelle für Zone 4 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_5','2:43,3:50,4:57,5:64,6:71,7:78,8:85,9:92,10:99,11:104,12:109,13:114,14:119,15:124,16:129,17:134,18:139,19:144,20:149,21:153,22:157,23:161,24:165,25:169,26:173,27:177,28:181,29:185,30:189','Tarif Tabelle für die Zone 4, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(399,'Tarifzone 4 Länder','MODULE_SHIPPING_CHP_COUNTRIES_5','AF,AO,AI,AG,AM,AZ,BS,BH,BD,BB,BZ,BJ,BM,BT,BW,BF,BI,KY,KH,CM,CV,CF,TD,CN,KM,CG,CR,CI,CU,DJ,DM,DO,SV,GQ,ER,ET,GA,GM,GE,GH,GD,GP,GT,GN,GW,HT,HN,HK,IN,IR,IQ,JM,JP,YE,KZ,KE,KP,KR,KW,KG,LA,LS','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 4 sind.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(398,'Tariftabelle für Zone 3 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_4','0.5:65,1:72,1.5:79,2:87,2.5:94,3:101,3.5:108,4:115,4.5:123,5:130,6:141,7:152,8:164,9:175,10:186,11:198,12:209,13:220,14:232,15:243,16:254,17:266,18:277,19:288,20:300,21:309,22:318,23:328,24:337,25:346,26:355,27:365,28:374,29:383,30:392','Tarif Tabelle für die Zone 3, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(397,'Tariftabelle für Zone 3 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_4','2:46,3:55,4:66,5:77,6:86,7:95,8:104,9:113,10:122,11:130,12:138,13:146,14:154,15:162,16:170,17:178,18:186,19:194,20:202,21:209,22:216,23:223,24:230,25:237,26:244,27:251,28:258,29:265,30:272','Tarif Tabelle für die Zone 3, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(396,'Tariftabelle für Zone 3 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_4','2:38,3:44,4:50,5:56,6:62,7:68,8:74,9:80,10:86,11:92,12:98,13:104,14:110,15:116,16:121,17:126,18:131,19:136,20:141,21:145,22:149,23:153,24:157,25:161,26:165,27:169,28:173,29:177,30:181','Tarif Tabelle für die Zone 3, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(395,'Tarifzone 3 Länder','MODULE_SHIPPING_CHP_COUNTRIES_4','DZ,BY,CA,CY,EG,IL,JO,LB,LY,MD,MA,RU,PM,SY,TN,TR,UA,US','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 3 sind.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(394,'Tariftabelle für Zone 2 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_3','0.5:57,1:63,1.5:68,2:73,2.5:78,3:84,3.5:90,4:95,4.5:100,5:106,6:114,7:124,8:132,9:141,10:149,11:158,12:165,13:172,14:180,15:187,16:196,17:203,18:210,19:218,20:226,21:234,22:241,23:248,24:256,25:264,26:272,27:279,28:286,29:295,30:302','Tarif Tabelle für die Zone 2, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(393,'Tariftabelle für Zone 2 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_3','2:38,3:43,4:48,5:53,6:58,7:62,8:66,9:68,10:71,11:75,12:78,13:81,14:84,15:87,16:90,17:91,18:92,19:93,20:94,21:95,22:96,23:97,24:98,25:99,26:100,27:101,28:102,29:103,30:104','Tarif Tabelle für die Zone 2, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(392,'Tariftabelle für Zone 2 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_3','2:34,3:38,4:42,5:46,6:49,7:52,8:55,9:58,10:61,11:63,12:65,13:67,14:69,15:71,16:72,17:73,18:74,19:75,20:76,21:77,22:78,23:79,24:80,25:81,26:82,27:83,28:84,29:85,30:86','Tarif Tabelle für die Zone 2, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(391,'Tarifzone 2 Länder','MODULE_SHIPPING_CHP_COUNTRIES_3','AL,BA,BG,HR,CZ,DK,EE,FI,GI,GR,HU,IS,IE,LV,LT,MK,MT,MH,NO,PL,PT,RO,SK,SI,ES,SE,GB,YU','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 2 sind.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(389,'Tariftabelle für Zone 1 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_2','2:33,3:37,4:41,5:46,6:49,7:51,8:53,9:55,10:57,11:60,12:61,13:62,14:63,15:64,16:65,17:66,18:67,19:68,20:69,21:70,22:71,23:72,24:73,25:74,26:75,27:76,28:77,29:78,30:79','Tarif Tabelle für die Zone 1, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(390,'Tariftabelle für Zone 1 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_2','0.5:51,1:57,1.5:62,2:67,2.5:72,3:78,3.5:83,4:89,4.5:95,5:100,6:107,7:115,8:123,9:130,10:138,11:144,12:151,13:158,14:164,15:171,16:177,17:184,18:191,19:197,20:204,21:210,22:217,23:224,24:230,25:237,26:243,27:250,28:256,29:263,30:269','Tarif Tabelle für die Zone 1, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(324,'Schweizerische Post - Brief Inland','MODULE_SHIPPING_CHPLET_STATUS','True','Wollen Sie die Versandart Brief Inland via Schweizerische Post anbieten?',6,0,NULL,'2007-08-13 22:37:23',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(325,'Handling Fee','MODULE_SHIPPING_CHPLET_HANDLING','0','Bearbeitungsgebühr für diese Versandart in CHF',6,0,NULL,'2007-08-13 22:37:23',NULL,NULL),(326,'Steuersatz','MODULE_SHIPPING_CHPLET_TAX_CLASS','0','Wählen Sie den MwSt.-Satz für diese Versandart aus.',6,0,NULL,'2007-08-13 22:37:23','tep_get_tax_class_title','tep_cfg_pull_down_tax_classes('),(327,'Versand Zone','MODULE_SHIPPING_CHPLET_ZONE','1','Wenn Sie eine Zone auswählen, wird diese Versandart nur in dieser Zone angeboten.',6,0,NULL,'2007-08-13 22:37:23','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes('),(328,'Reihenfolge der Anzeige','MODULE_SHIPPING_CHPLET_SORT_ORDER','5','Niedrigste wird zuerst angezeigt.',6,0,NULL,'2007-08-13 22:37:23',NULL,NULL),(329,'Zone Inland','MODULE_SHIPPING_CHPLET_COUNTRIES_1','CH','Inlandszone',6,0,NULL,'2007-08-13 22:37:23',NULL,NULL),(330,'Zone Tarif Tabelle bis 2 kg','MODULE_SHIPPING_CHPLET_COST_1','0.1:0.85,0.25:1.10,0.5:1.80,1:4.50','Tarif Tabelle für die Inlandszone, Brief bis 2 kg Versandgewicht.',6,0,NULL,'2007-08-13 22:37:23',NULL,NULL),(331,'Schweizerische Post - Brief Inland','MODULE_SHIPPING_CHPLETINPRI_STATUS','True','Wollen Sie die Versandart Brief Inland via Schweizerische Post anbieten?',6,0,NULL,'2007-08-13 23:33:13',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(332,'Handling Fee','MODULE_SHIPPING_CHPLETINPRI_HANDLING','0','Bearbeitungsgebühr für diese Versandart in CHF',6,0,NULL,'2007-08-13 23:33:13',NULL,NULL),(333,'Steuersatz','MODULE_SHIPPING_CHPLETINPRI_TAX_CLASS','0','Wählen Sie den MwSt.-Satz für diese Versandart aus.',6,0,NULL,'2007-08-13 23:33:13','tep_get_tax_class_title','tep_cfg_pull_down_tax_classes('),(334,'Versand Zone','MODULE_SHIPPING_CHPLETINPRI_ZONE','1','Wenn Sie eine Zone auswählen, wird diese Versandart nur in dieser Zone angeboten.',6,0,NULL,'2007-08-13 23:33:13','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes('),(335,'Reihenfolge der Anzeige','MODULE_SHIPPING_CHPLETINPRI_SORT_ORDER','10','Niedrigste wird zuerst angezeigt.',6,0,NULL,'2007-08-13 23:33:13',NULL,NULL),(336,'Zone Inland','MODULE_SHIPPING_CHPLETINPRI_COUNTRIES_1','CH','Inlandszone',6,0,NULL,'2007-08-13 23:33:13',NULL,NULL),(337,'Zone Tarif Tabelle bis 1 kg','MODULE_SHIPPING_CHPLETINPRI_COST_1','0.10:1,0.25:1.30,0.5:2.20,1.0:5.0','Tarif Tabelle für die Inlandszone, Brief bis 1 kg Versandgewicht.',6,0,NULL,'2007-08-13 23:33:13',NULL,NULL),(430,'Popup Image Height','POPUP_IMAGE_HEIGHT','','Maximum height of the popup image',4,201,'2007-12-11 03:55:22','2007-12-11 01:54:15',NULL,NULL),(428,'Tax Class','MODULE_ORDER_TOTAL_LOWORDERFEE_TAX_CLASS','0','Use the following tax class on the low order fee.',6,7,NULL,'2007-12-04 03:38:38','tep_get_tax_class_title','tep_cfg_pull_down_tax_classes('),(429,'Popup Image Width','POPUP_IMAGE_WIDTH','700','Maximum width of the popup image',4,200,'2007-12-11 03:56:32','2007-12-11 01:53:39',NULL,NULL),(427,'Attach Low Order Fee On Orders Made','MODULE_ORDER_TOTAL_LOWORDERFEE_DESTINATION','both','Attach low order fee for orders sent to the set destination.',6,6,NULL,'2007-12-04 03:38:38',NULL,'tep_cfg_select_option(array(\'national\', \'international\', \'both\'), '),(423,'Sort Order','MODULE_ORDER_TOTAL_LOWORDERFEE_SORT_ORDER','4','Sort order of display.',6,2,NULL,'2007-12-04 03:38:38',NULL,NULL),(424,'Allow Low Order Fee','MODULE_ORDER_TOTAL_LOWORDERFEE_LOW_ORDER_FEE','false','Do you want to allow low order fees?',6,3,NULL,'2007-12-04 03:38:38',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(422,'Display Low Order Fee','MODULE_ORDER_TOTAL_LOWORDERFEE_STATUS','true','Do you want to display the low order fee?',6,1,NULL,'2007-12-04 03:38:38',NULL,'tep_cfg_select_option(array(\'true\', \'false\'), '),(388,'Tariftabelle für Zone 1 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_2','2:29,3:32,4:35,5:38,6:39,7:40,8:41,9:42,10:43,11:44,12:45,13:46,14:47,15:48,16:49,17:50,18:51,19:52,20:53,21:54,22:55,23:56,24:57,25:58,26:59,27:60,28:61,29:62,30:63','Tarif Tabelle für die Zone 1, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(379,'Schweizerische Post','MODULE_SHIPPING_CHP_STATUS','True','Wollen Sie den Versand über die schweizerische Post anbieten?',6,0,NULL,'2007-08-14 00:22:47',NULL,'tep_cfg_select_option(array(\'True\', \'False\'), '),(380,'Handling Fee','MODULE_SHIPPING_CHP_HANDLING','0','Bearbeitungsgebühr für diese Versandart in CHF',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(381,'Steuersatz','MODULE_SHIPPING_CHP_TAX_CLASS','0','Wählen Sie den MwSt.-Satz für diese Versandart aus.',6,0,NULL,'2007-08-14 00:22:47','tep_get_tax_class_title','tep_cfg_pull_down_tax_classes('),(382,'Versand Zone','MODULE_SHIPPING_CHP_ZONE','0','Wenn Sie eine Zone auswählen, wird diese Versandart nur in dieser Zone angeboten.',6,0,NULL,'2007-08-14 00:22:47','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes('),(383,'Reihenfolge der Anzeige','MODULE_SHIPPING_CHP_SORT_ORDER','0','Niedrigste wird zuerst angezeigt.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(384,'Tarifzone 0 Länder','MODULE_SHIPPING_CHP_COUNTRIES_1','CH,LI','Inlandszone',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(385,'Tariftabelle für Zone 0 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_1','2:6.00,5:8.00,10:11.00,20:16.00,30:23.00','Tarif Tabelle für die Inlandszone, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(386,'Tariftabelle für Zone 0 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_1','2:8.00,5:10.00,10:13.00,20:19.00,30:26.00','Tarif Tabelle für die Inlandszone, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL),(387,'Tarifzone 1 Länder','MODULE_SHIPPING_CHP_COUNTRIES_2','AD,AT,BE,FR,DE,VA,IT,LU,MC,NL','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 1 sind.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
/*!40000 ALTER TABLE `configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuration_group`
--

DROP TABLE IF EXISTS `configuration_group`;
CREATE TABLE `configuration_group` (
  `configuration_group_id` int(11) NOT NULL auto_increment,
  `configuration_group_title` varchar(64) collate latin1_general_ci NOT NULL,
  `configuration_group_description` varchar(255) collate latin1_general_ci NOT NULL,
  `sort_order` int(5) default NULL,
  `visible` int(1) default '1',
  PRIMARY KEY  (`configuration_group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=334 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `configuration_group`
--

LOCK TABLES `configuration_group` WRITE;
/*!40000 ALTER TABLE `configuration_group` DISABLE KEYS */;
INSERT INTO `configuration_group` VALUES (1,'My Store','General information about my store',1,1),(2,'Minimum Values','The minimum values for functions / data',2,1),(3,'Maximum Values','The maximum values for functions / data',3,1),(4,'Images','Image parameters',4,1),(5,'Customer Details','Customer account configuration',5,1),(6,'Module Options','Hidden from configuration',6,0),(7,'Shipping/Packaging','Shipping options available at my store',7,1),(8,'Product Listing','Product Listing    configuration options',8,1),(9,'Stock','Stock configuration options',9,1),(10,'Logging','Logging configuration options',10,1),(11,'Cache','Caching configuration options',11,1),(12,'E-Mail Options','General setting for E-Mail transport and HTML E-Mails',12,1),(13,'Download','Downloadable products options',13,1),(14,'GZip Compression','GZip compression options',14,1),(15,'Sessions','Session options',15,1),(16,'SEO URLs','Options for Ultimate SEO URLs by Chemo',16,1),(333,'Image Magic','Configuration options for the OSC Image Magic contribution',17,1),(17,'Miscellaneous','Various configuration settings',17,1);
/*!40000 ALTER TABLE `configuration_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counter`
--

DROP TABLE IF EXISTS `counter`;
CREATE TABLE `counter` (
  `startdate` char(8) collate latin1_general_ci default NULL,
  `counter` int(12) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `counter`
--

LOCK TABLES `counter` WRITE;
/*!40000 ALTER TABLE `counter` DISABLE KEYS */;
INSERT INTO `counter` VALUES ('20070612',2530);
/*!40000 ALTER TABLE `counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counter_history`
--

DROP TABLE IF EXISTS `counter_history`;
CREATE TABLE `counter_history` (
  `month` char(8) collate latin1_general_ci default NULL,
  `counter` int(12) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

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
CREATE TABLE `countries` (
  `countries_id` int(11) NOT NULL auto_increment,
  `countries_name` varchar(64) collate latin1_general_ci NOT NULL,
  `countries_iso_code_2` char(2) collate latin1_general_ci NOT NULL,
  `countries_iso_code_3` char(3) collate latin1_general_ci NOT NULL,
  `address_format_id` int(11) NOT NULL,
  `sorting` int(3) NOT NULL,
  PRIMARY KEY  (`countries_id`),
  KEY `IDX_COUNTRIES_NAME` (`countries_name`)
) ENGINE=MyISAM AUTO_INCREMENT=240 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Afghanistan','AF','AFG',1,0),(2,'Albania','AL','ALB',1,0),(3,'Algeria','DZ','DZA',1,0),(4,'American Samoa','AS','ASM',1,0),(5,'Andorra','AD','AND',1,0),(6,'Angola','AO','AGO',1,0),(7,'Anguilla','AI','AIA',1,0),(8,'Antarctica','AQ','ATA',1,0),(9,'Antigua and Barbuda','AG','ATG',1,0),(10,'Argentina','AR','ARG',1,0),(11,'Armenia','AM','ARM',1,0),(12,'Aruba','AW','ABW',1,0),(13,'Australia','AU','AUS',1,0),(14,'Austria','AT','AUT',5,-6),(15,'Azerbaijan','AZ','AZE',1,0),(16,'Bahamas','BS','BHS',1,0),(17,'Bahrain','BH','BHR',1,0),(18,'Bangladesh','BD','BGD',1,0),(19,'Barbados','BB','BRB',1,0),(20,'Belarus','BY','BLR',1,0),(21,'Belgium','BE','BEL',1,0),(22,'Belize','BZ','BLZ',1,0),(23,'Benin','BJ','BEN',1,0),(24,'Bermuda','BM','BMU',1,0),(25,'Bhutan','BT','BTN',1,0),(26,'Bolivia','BO','BOL',1,0),(27,'Bosnia and Herzegowina','BA','BIH',1,0),(28,'Botswana','BW','BWA',1,0),(29,'Bouvet Island','BV','BVT',1,0),(30,'Brazil','BR','BRA',1,0),(31,'British Indian Ocean Territory','IO','IOT',1,0),(32,'Brunei Darussalam','BN','BRN',1,0),(33,'Bulgaria','BG','BGR',1,0),(34,'Burkina Faso','BF','BFA',1,0),(35,'Burundi','BI','BDI',1,0),(36,'Cambodia','KH','KHM',1,0),(37,'Cameroon','CM','CMR',1,0),(38,'Canada','CA','CAN',1,0),(39,'Cape Verde','CV','CPV',1,0),(40,'Cayman Islands','KY','CYM',1,0),(41,'Central African Republic','CF','CAF',1,0),(42,'Chad','TD','TCD',1,0),(43,'Chile','CL','CHL',1,0),(44,'China','CN','CHN',1,0),(45,'Christmas Island','CX','CXR',1,0),(46,'Cocos (Keeling) Islands','CC','CCK',1,0),(47,'Colombia','CO','COL',1,0),(48,'Comoros','KM','COM',1,0),(49,'Congo','CG','COG',1,0),(50,'Cook Islands','CK','COK',1,0),(51,'Costa Rica','CR','CRI',1,0),(52,'Cote D\'Ivoire','CI','CIV',1,0),(53,'Croatia','HR','HRV',1,0),(54,'Cuba','CU','CUB',1,0),(55,'Cyprus','CY','CYP',1,0),(56,'Czech Republic','CZ','CZE',1,0),(57,'Denmark','DK','DNK',1,0),(58,'Djibouti','DJ','DJI',1,0),(59,'Dominica','DM','DMA',1,0),(60,'Dominican Republic','DO','DOM',1,0),(61,'East Timor','TP','TMP',1,0),(62,'Ecuador','EC','ECU',1,0),(63,'Egypt','EG','EGY',1,0),(64,'El Salvador','SV','SLV',1,0),(65,'Equatorial Guinea','GQ','GNQ',1,0),(66,'Eritrea','ER','ERI',1,0),(67,'Estonia','EE','EST',1,0),(68,'Ethiopia','ET','ETH',1,0),(69,'Falkland Islands (Malvinas)','FK','FLK',1,0),(70,'Faroe Islands','FO','FRO',1,0),(71,'Fiji','FJ','FJI',1,0),(72,'Finland','FI','FIN',1,0),(73,'France','FR','FRA',1,-4),(74,'France, Metropolitan','FX','FXX',1,0),(75,'French Guiana','GF','GUF',1,0),(76,'French Polynesia','PF','PYF',1,0),(77,'French Southern Territories','TF','ATF',1,0),(78,'Gabon','GA','GAB',1,0),(79,'Gambia','GM','GMB',1,0),(80,'Georgia','GE','GEO',1,0),(81,'Germany','DE','DEU',5,-8),(82,'Ghana','GH','GHA',1,0),(83,'Gibraltar','GI','GIB',1,0),(84,'Greece','GR','GRC',1,0),(85,'Greenland','GL','GRL',1,0),(86,'Grenada','GD','GRD',1,0),(87,'Guadeloupe','GP','GLP',1,0),(88,'Guam','GU','GUM',1,0),(89,'Guatemala','GT','GTM',1,0),(90,'Guinea','GN','GIN',1,0),(91,'Guinea-bissau','GW','GNB',1,0),(92,'Guyana','GY','GUY',1,0),(93,'Haiti','HT','HTI',1,0),(94,'Heard and Mc Donald Islands','HM','HMD',1,0),(95,'Honduras','HN','HND',1,0),(96,'Hong Kong','HK','HKG',1,0),(97,'Hungary','HU','HUN',1,0),(98,'Iceland','IS','ISL',1,0),(99,'India','IN','IND',1,0),(100,'Indonesia','ID','IDN',1,0),(101,'Iran (Islamic Republic of)','IR','IRN',1,0),(102,'Iraq','IQ','IRQ',1,0),(103,'Ireland','IE','IRL',1,0),(104,'Israel','IL','ISR',1,0),(105,'Italy','IT','ITA',1,-2),(106,'Jamaica','JM','JAM',1,0),(107,'Japan','JP','JPN',1,0),(108,'Jordan','JO','JOR',1,0),(109,'Kazakhstan','KZ','KAZ',1,0),(110,'Kenya','KE','KEN',1,0),(111,'Kiribati','KI','KIR',1,0),(112,'Korea, Democratic People\'s Republic of','KP','PRK',1,0),(113,'Korea, Republic of','KR','KOR',1,0),(114,'Kuwait','KW','KWT',1,0),(115,'Kyrgyzstan','KG','KGZ',1,0),(116,'Lao People\'s Democratic Republic','LA','LAO',1,0),(117,'Latvia','LV','LVA',1,0),(118,'Lebanon','LB','LBN',1,0),(119,'Lesotho','LS','LSO',1,0),(120,'Liberia','LR','LBR',1,0),(121,'Libyan Arab Jamahiriya','LY','LBY',1,0),(122,'Liechtenstein','LI','LIE',1,0),(123,'Lithuania','LT','LTU',1,0),(124,'Luxembourg','LU','LUX',1,0),(125,'Macau','MO','MAC',1,0),(126,'Macedonia, The Former Yugoslav Republic of','MK','MKD',1,0),(127,'Madagascar','MG','MDG',1,0),(128,'Malawi','MW','MWI',1,0),(129,'Malaysia','MY','MYS',1,0),(130,'Maldives','MV','MDV',1,0),(131,'Mali','ML','MLI',1,0),(132,'Malta','MT','MLT',1,0),(133,'Marshall Islands','MH','MHL',1,0),(134,'Martinique','MQ','MTQ',1,0),(135,'Mauritania','MR','MRT',1,0),(136,'Mauritius','MU','MUS',1,0),(137,'Mayotte','YT','MYT',1,0),(138,'Mexico','MX','MEX',1,0),(139,'Micronesia, Federated States of','FM','FSM',1,0),(140,'Moldova, Republic of','MD','MDA',1,0),(141,'Monaco','MC','MCO',1,0),(142,'Mongolia','MN','MNG',1,0),(143,'Montserrat','MS','MSR',1,0),(144,'Morocco','MA','MAR',1,0),(145,'Mozambique','MZ','MOZ',1,0),(146,'Myanmar','MM','MMR',1,0),(147,'Namibia','NA','NAM',1,0),(148,'Nauru','NR','NRU',1,0),(149,'Nepal','NP','NPL',1,0),(150,'Netherlands','NL','NLD',1,0),(151,'Netherlands Antilles','AN','ANT',1,0),(152,'New Caledonia','NC','NCL',1,0),(153,'New Zealand','NZ','NZL',1,0),(154,'Nicaragua','NI','NIC',1,0),(155,'Niger','NE','NER',1,0),(156,'Nigeria','NG','NGA',1,0),(157,'Niue','NU','NIU',1,0),(158,'Norfolk Island','NF','NFK',1,0),(159,'Northern Mariana Islands','MP','MNP',1,0),(160,'Norway','NO','NOR',1,0),(161,'Oman','OM','OMN',1,0),(162,'Pakistan','PK','PAK',1,0),(163,'Palau','PW','PLW',1,0),(164,'Panama','PA','PAN',1,0),(165,'Papua New Guinea','PG','PNG',1,0),(166,'Paraguay','PY','PRY',1,0),(167,'Peru','PE','PER',1,0),(168,'Philippines','PH','PHL',1,0),(169,'Pitcairn','PN','PCN',1,0),(170,'Poland','PL','POL',1,0),(171,'Portugal','PT','PRT',1,0),(172,'Puerto Rico','PR','PRI',1,0),(173,'Qatar','QA','QAT',1,0),(174,'Reunion','RE','REU',1,0),(175,'Romania','RO','ROM',1,0),(176,'Russian Federation','RU','RUS',1,0),(177,'Rwanda','RW','RWA',1,0),(178,'Saint Kitts and Nevis','KN','KNA',1,0),(179,'Saint Lucia','LC','LCA',1,0),(180,'Saint Vincent and the Grenadines','VC','VCT',1,0),(181,'Samoa','WS','WSM',1,0),(182,'San Marino','SM','SMR',1,0),(183,'Sao Tome and Principe','ST','STP',1,0),(184,'Saudi Arabia','SA','SAU',1,0),(185,'Senegal','SN','SEN',1,0),(186,'Seychelles','SC','SYC',1,0),(187,'Sierra Leone','SL','SLE',1,0),(188,'Singapore','SG','SGP',4,0),(189,'Slovakia (Slovak Republic)','SK','SVK',1,0),(190,'Slovenia','SI','SVN',1,0),(191,'Solomon Islands','SB','SLB',1,0),(192,'Somalia','SO','SOM',1,0),(193,'South Africa','ZA','ZAF',1,0),(194,'South Georgia and the South Sandwich Islands','GS','SGS',1,0),(195,'Spain','ES','ESP',3,0),(196,'Sri Lanka','LK','LKA',1,0),(197,'St. Helena','SH','SHN',1,0),(198,'St. Pierre and Miquelon','PM','SPM',1,0),(199,'Sudan','SD','SDN',1,0),(200,'Suriname','SR','SUR',1,0),(201,'Svalbard and Jan Mayen Islands','SJ','SJM',1,0),(202,'Swaziland','SZ','SWZ',1,0),(203,'Sweden','SE','SWE',1,0),(204,'Switzerland','CH','CHE',1,-10),(205,'Syrian Arab Republic','SY','SYR',1,0),(206,'Taiwan','TW','TWN',1,0),(207,'Tajikistan','TJ','TJK',1,0),(208,'Tanzania, United Republic of','TZ','TZA',1,0),(209,'Thailand','TH','THA',1,0),(210,'Togo','TG','TGO',1,0),(211,'Tokelau','TK','TKL',1,0),(212,'Tonga','TO','TON',1,0),(213,'Trinidad and Tobago','TT','TTO',1,0),(214,'Tunisia','TN','TUN',1,0),(215,'Turkey','TR','TUR',1,0),(216,'Turkmenistan','TM','TKM',1,0),(217,'Turks and Caicos Islands','TC','TCA',1,0),(218,'Tuvalu','TV','TUV',1,0),(219,'Uganda','UG','UGA',1,0),(220,'Ukraine','UA','UKR',1,0),(221,'United Arab Emirates','AE','ARE',1,0),(222,'United Kingdom','GB','GBR',1,0),(223,'United States','US','USA',2,0),(224,'United States Minor Outlying Islands','UM','UMI',1,0),(225,'Uruguay','UY','URY',1,0),(226,'Uzbekistan','UZ','UZB',1,0),(227,'Vanuatu','VU','VUT',1,0),(228,'Vatican City State (Holy See)','VA','VAT',1,0),(229,'Venezuela','VE','VEN',1,0),(230,'Viet Nam','VN','VNM',1,0),(231,'Virgin Islands (British)','VG','VGB',1,0),(232,'Virgin Islands (U.S.)','VI','VIR',1,0),(233,'Wallis and Futuna Islands','WF','WLF',1,0),(234,'Western Sahara','EH','ESH',1,0),(235,'Yemen','YE','YEM',1,0),(236,'Yugoslavia','YU','YUG',1,0),(237,'Zaire','ZR','ZAR',1,0),(238,'Zambia','ZM','ZMB',1,0),(239,'Zimbabwe','ZW','ZWE',1,0);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
CREATE TABLE `currencies` (
  `currencies_id` int(11) NOT NULL auto_increment,
  `title` varchar(32) collate latin1_general_ci NOT NULL,
  `code` char(3) collate latin1_general_ci NOT NULL,
  `symbol_left` varchar(12) collate latin1_general_ci default NULL,
  `symbol_right` varchar(12) collate latin1_general_ci default NULL,
  `decimal_point` char(1) collate latin1_general_ci default NULL,
  `thousands_point` char(1) collate latin1_general_ci default NULL,
  `decimal_places` char(1) collate latin1_general_ci default NULL,
  `value` float(13,8) default NULL,
  `last_updated` datetime default NULL,
  PRIMARY KEY  (`currencies_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES (1,'US Dollar','USD','$','','.',',','2',0.80669999,'2007-06-13 02:03:21'),(2,'Euro','EUR','','EUR','.',',','2',0.60439998,'2007-06-13 02:03:22'),(3,'Schweizer Franken','CHF','CHF','','.',',','2',1.00000000,'2007-06-13 02:03:23');
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `customers_id` int(11) NOT NULL auto_increment,
  `customers_gender` char(1) collate latin1_general_ci NOT NULL,
  `customers_firstname` varchar(32) collate latin1_general_ci NOT NULL,
  `customers_lastname` varchar(32) collate latin1_general_ci NOT NULL,
  `customers_dob` datetime NOT NULL default '0000-00-00 00:00:00',
  `customers_email_address` varchar(96) collate latin1_general_ci NOT NULL,
  `customers_default_address_id` int(11) default NULL,
  `customers_telephone` varchar(32) collate latin1_general_ci NOT NULL,
  `customers_fax` varchar(32) collate latin1_general_ci default NULL,
  `customers_password` varchar(40) collate latin1_general_ci NOT NULL,
  `customers_newsletter` char(1) collate latin1_general_ci default NULL,
  PRIMARY KEY  (`customers_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (2,'m','Nick','Weisser','1970-05-21 00:00:00','nick@openstream.ch',2,'0445007878','','4b0bb070a6ffa89de54e062da0c29936:d9','1');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers_basket`
--

DROP TABLE IF EXISTS `customers_basket`;
CREATE TABLE `customers_basket` (
  `customers_basket_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL,
  `products_id` tinytext collate latin1_general_ci NOT NULL,
  `customers_basket_quantity` int(2) NOT NULL,
  `final_price` decimal(15,4) default NULL,
  `customers_basket_date_added` char(8) collate latin1_general_ci default NULL,
  `clickandbuy_TransactionID` varchar(11) collate latin1_general_ci NOT NULL,
  `clickandbuy_externalBDRID` varchar(11) collate latin1_general_ci NOT NULL,
  PRIMARY KEY  (`customers_basket_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `customers_basket`
--

LOCK TABLES `customers_basket` WRITE;
/*!40000 ALTER TABLE `customers_basket` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers_basket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers_basket_attributes`
--

DROP TABLE IF EXISTS `customers_basket_attributes`;
CREATE TABLE `customers_basket_attributes` (
  `customers_basket_attributes_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL,
  `products_id` tinytext collate latin1_general_ci NOT NULL,
  `products_options_id` int(11) NOT NULL,
  `products_options_value_id` int(11) NOT NULL,
  `products_options_value_text` text collate latin1_general_ci,
  PRIMARY KEY  (`customers_basket_attributes_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `customers_basket_attributes`
--

LOCK TABLES `customers_basket_attributes` WRITE;
/*!40000 ALTER TABLE `customers_basket_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers_basket_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers_info`
--

DROP TABLE IF EXISTS `customers_info`;
CREATE TABLE `customers_info` (
  `customers_info_id` int(11) NOT NULL,
  `customers_info_date_of_last_logon` datetime default NULL,
  `customers_info_number_of_logons` int(5) default NULL,
  `customers_info_date_account_created` datetime default NULL,
  `customers_info_date_account_last_modified` datetime default NULL,
  `global_product_notifications` int(1) default '0',
  PRIMARY KEY  (`customers_info_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `customers_info`
--

LOCK TABLES `customers_info` WRITE;
/*!40000 ALTER TABLE `customers_info` DISABLE KEYS */;
INSERT INTO `customers_info` VALUES (2,'2007-10-22 16:15:11',12,'2007-07-05 01:00:50',NULL,0);
/*!40000 ALTER TABLE `customers_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geo_zones`
--

DROP TABLE IF EXISTS `geo_zones`;
CREATE TABLE `geo_zones` (
  `geo_zone_id` int(11) NOT NULL auto_increment,
  `geo_zone_name` varchar(32) collate latin1_general_ci NOT NULL,
  `geo_zone_description` varchar(255) collate latin1_general_ci NOT NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`geo_zone_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

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
CREATE TABLE `information` (
  `information_id` tinyint(3) unsigned NOT NULL auto_increment,
  `information_group_id` int(11) unsigned NOT NULL default '0',
  `information_title` varchar(255) NOT NULL default '',
  `information_description` text NOT NULL,
  `parent_id` int(11) default NULL,
  `sort_order` tinyint(3) unsigned NOT NULL default '0',
  `visible` enum('1','0') NOT NULL default '1',
  `language_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`information_id`,`language_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `information`
--

LOCK TABLES `information` WRITE;
/*!40000 ALTER TABLE `information` DISABLE KEYS */;
INSERT INTO `information` VALUES (1,2,'HEADING_TITLE','What\'s New Here?',0,1,'1',1),(2,2,'TEXT_GREETING_PERSONAL','Welcome back <span class=\"greetUser\">%s!</span> Would you like to see which <a href=\"%s\"><u>new products</u></a> are available to purchase?',0,2,'1',1),(3,2,'TEXT_GREETING_PERSONAL_RELOGON','<small>If you are not %s, please <a href=\"%s\"><u>log yourself in</u></a> with your account information.</small>',0,3,'1',1),(4,2,'TEXT_GREETING_GUEST','Would you like to <a href=\"%s\"><u>log yourself in</u></a>? Or would you prefer to <a href=\"%s\"><u>create an account</u></a>?',0,4,'1',1),(5,2,'TEXT_MAIN','This is a default text. This can be changed in the admin panel\'s info manager.',0,5,'1',1),(1,2,'HEADING_TITLE','Willkommen im Online-Shop',0,1,'1',2),(2,2,'TEXT_GREETING_PERSONAL','Sch&ouml;n das Sie wieder da sind <span class=\"greetUser\">%s!</span> M&ouml;chten Sie die <a href=\"%s\"><u>neue Produkte</u></a> ansehen?',0,2,'1',2),(3,2,'TEXT_GREETING_PERSONAL_RELOGON','<small>Wenn Sie nicht %s sind, melden Sie sich bitte <a href=\"%s\"><u>hier</u></a> mit Ihrem Kundenkonto an.</small>',0,3,'1',2),(4,2,'TEXT_GREETING_GUEST','Bestehende Kunden k&ouml;nnen sich hier <a href=\"%s\"><u>einloggen</u></a>. Neukunden bitten wir, bei einer Bestellung ein <a href=\"%s\"><u>Kundenkonto</u></a> zu er&ouml;ffnen, um jederzeit den Bestellstatus online abrufen zu k&ouml;nnen.',0,4,'1',2),(5,2,'TEXT_MAIN','Diesen Text k&ouml;nnen Sie im Admin unter Info-Manager &auml;ndern.',0,5,'1',2),(1,2,'HEADING_TITLE','A ver que tenemos aqui',0,1,'1',3),(2,2,'TEXT_GREETING_PERSONAL','Bienvenido de nuevo <span class=\"greetUser\">%s!</span> &iquest;Le gustaria ver que <a href=\"%s\"><u>nuevos productos</u></a> hay disponibles?',0,2,'1',3),(3,2,'TEXT_GREETING_PERSONAL_RELOGON','<small>Si no es %s, por favor <a href=\"%s\"><u>entre aqui</u></a> e introduzca sus datos.</small>',0,3,'1',3),(4,2,'TEXT_GREETING_GUEST','Bienvenido <span class=\"greetUser\">Invitado!</span> &iquest;Le gustaria <a href=\"%s\"><u>entrar en su cuenta</u></a> o preferiria <a href=\"%s\"><u>crear una cuenta nueva</u></a>?',0,4,'1',3),(5,2,'TEXT_MAIN','Este text se puede cambiar en el info manager de la administracion.',0,5,'1',3),(1,2,'HEADING_TITLE','Vediamo cose c\'&egrave; qui',0,1,'1',4),(2,2,'TEXT_GREETING_PERSONAL','Bentornato <span class=\"greetUser\">%s!</span> Vuoi vedere i <a href=\"%s\"><u>nouvi prodotti</u></a> che sono disponibili?',0,2,'1',4),(3,2,'TEXT_GREETING_PERSONAL_RELOGON','<small>Se tu non sei %s, <a href=\"%s\"><u>effettua il log-in</u></a> con i dati del tuo accout.</small>',0,3,'1',4),(4,2,'TEXT_GREETING_GUEST','Benvenuto <span class=\"greetUser\">!</span> Puoi effettuare qui <a href=\"%s\"><u>il log-in</u></a>? Oppure puoi creare qui <a href=\"%s\"><u>un account</u></a>?',0,4,'1',4),(5,2,'TEXT_MAIN','This is a default text. This can be changed in the admim panel\'s info manager.',0,5,'1',4),(1,2,'HEADING_TITLE','Voyons ce que nous avons-l&agrave;',0,1,'1',5),(2,2,'TEXT_GREETING_PERSONAL','Bienvenue &agrave; nouveau <span class=\"greetUser\">%s&nbsp;!</span> Voudriez-vous voir quels <a href=\"%s\"><u>nouveaux produits</u></a> sont disponibles&nbsp;?',0,2,'1',5),(3,2,'TEXT_GREETING_PERSONAL_RELOGON','<small>Si vous n\'&ecirc;tes pas %s, veuillez <a href=\"%s\"><u>vous indentifier</u></a> avec vos param&egrave;tres de compte.</small>',0,3,'1',5),(4,2,'TEXT_GREETING_GUEST','Bienvenue <span class=\"greetUser\">cher visiteur&nbsp;!</span> Voulez-vous <a href=\"%s\"><u>vous identifier</u></a>? Ou pr&eacute;f&eacute;rez-vous <a href=\"%s\"><u>cr&eacute;er un compte</u></a>&nbsp;?',0,4,'1',5),(5,2,'TEXT_MAIN','Ce text peut être changé avec le info manager dans l\'administration',0,5,'1',5),(6,1,'Versand','F&uuml;gen Sie hier Ihre Informationen &uuml;ber Liefer- und Versandkosten ein.',0,1,'1',2),(6,1,'Shipping','Put here your Shipping &amp; Returns information.',0,1,'1',1),(6,1,'Livraison','Mettez ici vous informations sur les livraison &amp; retour.',0,1,'1',5),(6,1,'Spedizione','Inserisci qui le tue informazioni sulla spedizione e consegna.',0,1,'1',4),(6,1,'Envíos','Ponga aqui informacion sobre los Envios y Devoluciones',0,1,'1',3),(7,1,'Unsere AGBs','F&uuml;gen Sie hier Ihre allgemeinen Gesch&auml;ftsbedingungen ein. Diesen Text k&ouml;nnen Sie im Admin-Bereich unter <strong>Info-Manager/Infobox</strong> bearbeiten.',0,2,'1',2),(7,1,'Conditions of Use','Put here your Conditions of Use information. This text can be modified in the admin section under <strong>Info Manager/Infobox</strong>.',0,2,'1',1),(7,1,'Conditions d\'utilisation','Mettez ici les informations concernant vos conditions d\'utilisation.',0,2,'1',5),(7,1,'Condizioni per l\'uso','Inserisci qui le condizioni di informazione sull\' uso.',0,2,'1',4),(7,1,'Condiciones de Uso','Ponga aqui sus condiciones de uso.',0,2,'1',3);
/*!40000 ALTER TABLE `information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `information_group`
--

DROP TABLE IF EXISTS `information_group`;
CREATE TABLE `information_group` (
  `information_group_id` int(11) NOT NULL auto_increment,
  `information_group_title` varchar(64) NOT NULL default '',
  `information_group_description` varchar(255) NOT NULL default '',
  `sort_order` int(5) default NULL,
  `visible` int(1) default '1',
  `locked` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`information_group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `information_group`
--

LOCK TABLES `information_group` WRITE;
/*!40000 ALTER TABLE `information_group` DISABLE KEYS */;
INSERT INTO `information_group` VALUES (1,'Infobox','Diese Seiten werden in der Infobox angezeigt',1,1,''),(2,'Startseite','Zum Ändern des Text auf der Startseite Ihres Shops',2,1,'');
/*!40000 ALTER TABLE `information_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
CREATE TABLE `languages` (
  `languages_id` int(11) NOT NULL auto_increment,
  `name` varchar(32) collate latin1_general_ci NOT NULL,
  `code` char(2) collate latin1_general_ci NOT NULL,
  `image` varchar(64) collate latin1_general_ci default NULL,
  `directory` varchar(32) collate latin1_general_ci default NULL,
  `sort_order` int(3) default NULL,
  PRIMARY KEY  (`languages_id`),
  KEY `IDX_LANGUAGES_NAME` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

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
CREATE TABLE `manufacturers` (
  `manufacturers_id` int(11) NOT NULL auto_increment,
  `manufacturers_name` varchar(32) collate latin1_general_ci NOT NULL,
  `manufacturers_image` varchar(64) collate latin1_general_ci default NULL,
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  PRIMARY KEY  (`manufacturers_id`),
  KEY `IDX_MANUFACTURERS_NAME` (`manufacturers_name`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `manufacturers`
--

LOCK TABLES `manufacturers` WRITE;
/*!40000 ALTER TABLE `manufacturers` DISABLE KEYS */;
INSERT INTO `manufacturers` VALUES (1,'JamoTrade','jamotrade.jpg','2007-11-04 14:42:14',NULL),(2,'Zeed','zeed.gif','2007-11-04 15:02:43',NULL),(4,'Sony','sony-logo.jpg','2007-11-05 02:36:16',NULL),(5,'Hewlett-Packard','hp-logo.gif','2007-11-05 02:57:47',NULL);
/*!40000 ALTER TABLE `manufacturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturers_info`
--

DROP TABLE IF EXISTS `manufacturers_info`;
CREATE TABLE `manufacturers_info` (
  `manufacturers_id` int(11) NOT NULL,
  `languages_id` int(11) NOT NULL,
  `manufacturers_url` varchar(255) collate latin1_general_ci NOT NULL,
  `url_clicked` int(5) NOT NULL default '0',
  `date_last_click` datetime default NULL,
  `manufacturers_htc_title_tag` varchar(80) collate latin1_general_ci default NULL,
  `manufacturers_htc_desc_tag` longtext collate latin1_general_ci,
  `manufacturers_htc_keywords_tag` longtext collate latin1_general_ci,
  `manufacturers_htc_description` longtext collate latin1_general_ci,
  PRIMARY KEY  (`manufacturers_id`,`languages_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `manufacturers_info`
--

LOCK TABLES `manufacturers_info` WRITE;
/*!40000 ALTER TABLE `manufacturers_info` DISABLE KEYS */;
INSERT INTO `manufacturers_info` VALUES (1,2,'www.jamotrade.ch',1,'2007-11-04 14:44:47','JamoTrade','JamoTrade','JamoTrade',''),(1,1,'www.jamotrade.ch',0,NULL,'JamoTrade','JamoTrade','JamoTrade',''),(1,5,'www.jamotrade.ch',0,NULL,'JamoTrade','JamoTrade','JamoTrade',''),(1,4,'www.jamotrade.ch',0,NULL,'JamoTrade','JamoTrade','JamoTrade',''),(1,3,'www.jamotrade.ch',0,NULL,'JamoTrade','JamoTrade','JamoTrade',''),(2,2,'http://www.zeed.ch',2,'2007-11-04 15:03:30','Zeed','Zeed','Zeed',''),(2,1,'http://www.zeed.ch',0,NULL,'Zeed','Zeed','Zeed',''),(2,5,'http://www.zeed.ch',0,NULL,'Zeed','Zeed','Zeed',''),(2,4,'http://www.zeed.ch',0,NULL,'Zeed','Zeed','Zeed',''),(2,3,'http://www.zeed.ch',0,NULL,'Zeed','Zeed','Zeed',''),(4,2,'http://www.sony.com/',0,NULL,'Sony','Sony','Sony',''),(4,1,'http://www.sony.com/',0,NULL,'Sony','Sony','Sony',''),(4,5,'http://www.sony.com/',0,NULL,'Sony','Sony','Sony',''),(4,4,'http://www.sony.com/',0,NULL,'Sony','Sony','Sony',''),(4,3,'http://www.sony.com/',0,NULL,'Sony','Sony','Sony',''),(5,2,'http://www.hp.com',0,NULL,'Hewlett-Packard','Hewlett-Packard','Hewlett-Packard',''),(5,1,'http://www.hp.com',0,NULL,'Hewlett-Packard','Hewlett-Packard','Hewlett-Packard',''),(5,5,'http://www.hp.com',0,NULL,'Hewlett-Packard','Hewlett-Packard','Hewlett-Packard',''),(5,4,'http://www.hp.com',0,NULL,'Hewlett-Packard','Hewlett-Packard','Hewlett-Packard',''),(5,3,'http://www.hp.com',0,NULL,'Hewlett-Packard','Hewlett-Packard','Hewlett-Packard','');
/*!40000 ALTER TABLE `manufacturers_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletters`
--

DROP TABLE IF EXISTS `newsletters`;
CREATE TABLE `newsletters` (
  `newsletters_id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate latin1_general_ci NOT NULL,
  `content` text collate latin1_general_ci NOT NULL,
  `module` varchar(255) collate latin1_general_ci NOT NULL,
  `date_added` datetime NOT NULL,
  `date_sent` datetime default NULL,
  `status` int(1) default NULL,
  `locked` int(1) default '0',
  PRIMARY KEY  (`newsletters_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `newsletters`
--

LOCK TABLES `newsletters` WRITE;
/*!40000 ALTER TABLE `newsletters` DISABLE KEYS */;
/*!40000 ALTER TABLE `newsletters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `orders_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL,
  `customers_name` varchar(64) collate latin1_general_ci NOT NULL,
  `customers_company` varchar(32) collate latin1_general_ci default NULL,
  `customers_street_address` varchar(64) collate latin1_general_ci NOT NULL,
  `customers_suburb` varchar(32) collate latin1_general_ci default NULL,
  `customers_city` varchar(32) collate latin1_general_ci NOT NULL,
  `customers_postcode` varchar(10) collate latin1_general_ci NOT NULL,
  `customers_state` varchar(32) collate latin1_general_ci default NULL,
  `customers_country` varchar(32) collate latin1_general_ci NOT NULL,
  `customers_telephone` varchar(32) collate latin1_general_ci NOT NULL,
  `customers_email_address` varchar(96) collate latin1_general_ci NOT NULL,
  `customers_address_format_id` int(5) NOT NULL,
  `delivery_name` varchar(64) collate latin1_general_ci NOT NULL,
  `delivery_company` varchar(32) collate latin1_general_ci default NULL,
  `delivery_street_address` varchar(64) collate latin1_general_ci NOT NULL,
  `delivery_suburb` varchar(32) collate latin1_general_ci default NULL,
  `delivery_city` varchar(32) collate latin1_general_ci NOT NULL,
  `delivery_postcode` varchar(10) collate latin1_general_ci NOT NULL,
  `delivery_state` varchar(32) collate latin1_general_ci default NULL,
  `delivery_country` varchar(32) collate latin1_general_ci NOT NULL,
  `delivery_address_format_id` int(5) NOT NULL,
  `billing_name` varchar(64) collate latin1_general_ci NOT NULL,
  `billing_company` varchar(32) collate latin1_general_ci default NULL,
  `billing_street_address` varchar(64) collate latin1_general_ci NOT NULL,
  `billing_suburb` varchar(32) collate latin1_general_ci default NULL,
  `billing_city` varchar(32) collate latin1_general_ci NOT NULL,
  `billing_postcode` varchar(10) collate latin1_general_ci NOT NULL,
  `billing_state` varchar(32) collate latin1_general_ci default NULL,
  `billing_country` varchar(32) collate latin1_general_ci NOT NULL,
  `billing_address_format_id` int(5) NOT NULL,
  `payment_method` varchar(32) collate latin1_general_ci NOT NULL,
  `cc_type` varchar(20) collate latin1_general_ci default NULL,
  `cc_owner` varchar(64) collate latin1_general_ci default NULL,
  `cc_number` varchar(32) collate latin1_general_ci default NULL,
  `cc_expires` varchar(4) collate latin1_general_ci default NULL,
  `cc_cvv2` varchar(4) collate latin1_general_ci default NULL,
  `last_modified` datetime default NULL,
  `date_purchased` datetime default NULL,
  `orders_status` int(5) NOT NULL,
  `orders_date_finished` datetime default NULL,
  `currency` char(3) collate latin1_general_ci default NULL,
  `currency_value` decimal(14,6) default NULL,
  PRIMARY KEY  (`orders_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products`
--

DROP TABLE IF EXISTS `orders_products`;
CREATE TABLE `orders_products` (
  `orders_products_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(12) collate latin1_general_ci default NULL,
  `products_name` varchar(64) collate latin1_general_ci NOT NULL,
  `products_price` decimal(15,4) NOT NULL,
  `final_price` decimal(15,4) NOT NULL,
  `products_tax` decimal(7,4) NOT NULL,
  `products_quantity` int(2) NOT NULL,
  PRIMARY KEY  (`orders_products_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `orders_products`
--

LOCK TABLES `orders_products` WRITE;
/*!40000 ALTER TABLE `orders_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products_attributes`
--

DROP TABLE IF EXISTS `orders_products_attributes`;
CREATE TABLE `orders_products_attributes` (
  `orders_products_attributes_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL,
  `orders_products_id` int(11) NOT NULL,
  `products_options` varchar(32) collate latin1_general_ci NOT NULL,
  `products_options_values` varchar(32) collate latin1_general_ci NOT NULL,
  `options_values_price` decimal(15,4) NOT NULL,
  `price_prefix` char(1) collate latin1_general_ci NOT NULL,
  PRIMARY KEY  (`orders_products_attributes_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `orders_products_attributes`
--

LOCK TABLES `orders_products_attributes` WRITE;
/*!40000 ALTER TABLE `orders_products_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_products_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products_download`
--

DROP TABLE IF EXISTS `orders_products_download`;
CREATE TABLE `orders_products_download` (
  `orders_products_download_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL default '0',
  `orders_products_id` int(11) NOT NULL default '0',
  `orders_products_filename` varchar(255) collate latin1_general_ci NOT NULL default '',
  `download_maxdays` int(2) NOT NULL default '0',
  `download_count` int(2) NOT NULL default '0',
  PRIMARY KEY  (`orders_products_download_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

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
CREATE TABLE `orders_status` (
  `orders_status_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `orders_status_name` varchar(32) collate latin1_general_ci NOT NULL,
  PRIMARY KEY  (`orders_status_id`,`language_id`),
  KEY `idx_orders_status_name` (`orders_status_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `orders_status`
--

LOCK TABLES `orders_status` WRITE;
/*!40000 ALTER TABLE `orders_status` DISABLE KEYS */;
INSERT INTO `orders_status` VALUES (1,1,'Pending'),(1,2,'Offen'),(1,3,'Pendiente'),(2,1,'Processing'),(2,2,'In Bearbeitung'),(2,3,'Proceso'),(3,1,'Delivered'),(3,2,'Versendet'),(3,3,'Entregado'),(1,4,'Offen'),(2,4,'In Bearbeitung'),(3,4,'Versendet'),(1,5,'Offen'),(2,5,'In Bearbeitung'),(3,5,'Versendet');
/*!40000 ALTER TABLE `orders_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_status_history`
--

DROP TABLE IF EXISTS `orders_status_history`;
CREATE TABLE `orders_status_history` (
  `orders_status_history_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL,
  `orders_status_id` int(5) NOT NULL,
  `date_added` datetime NOT NULL,
  `customer_notified` int(1) default '0',
  `comments` text collate latin1_general_ci,
  PRIMARY KEY  (`orders_status_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `orders_status_history`
--

LOCK TABLES `orders_status_history` WRITE;
/*!40000 ALTER TABLE `orders_status_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_total`
--

DROP TABLE IF EXISTS `orders_total`;
CREATE TABLE `orders_total` (
  `orders_total_id` int(10) unsigned NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL,
  `title` varchar(255) collate latin1_general_ci NOT NULL,
  `text` varchar(255) collate latin1_general_ci NOT NULL,
  `value` decimal(15,4) NOT NULL,
  `class` varchar(32) collate latin1_general_ci NOT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY  (`orders_total_id`),
  KEY `idx_orders_total_orders_id` (`orders_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `orders_total`
--

LOCK TABLES `orders_total` WRITE;
/*!40000 ALTER TABLE `orders_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `products_id` int(11) NOT NULL auto_increment,
  `products_quantity` int(4) NOT NULL,
  `products_model` varchar(12) collate latin1_general_ci default NULL,
  `products_image` varchar(64) collate latin1_general_ci default NULL,
  `products_image2` varchar(64) collate latin1_general_ci NOT NULL,
  `products_image3` varchar(64) collate latin1_general_ci NOT NULL,
  `products_image4` varchar(64) collate latin1_general_ci NOT NULL,
  `products_price` decimal(15,4) NOT NULL,
  `products_date_added` datetime NOT NULL,
  `products_last_modified` datetime default NULL,
  `products_date_available` datetime default NULL,
  `products_weight` decimal(5,2) NOT NULL,
  `products_status` tinyint(1) NOT NULL,
  `products_tax_class_id` int(11) NOT NULL,
  `manufacturers_id` int(11) default NULL,
  `products_ordered` int(11) NOT NULL default '0',
  PRIMARY KEY  (`products_id`),
  KEY `idx_products_date_added` (`products_date_added`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,0,'','buggy-hbx.jpg','buggy-hbx-02.jpg','buggy-hbx-03.jpg','buggy-hbx-04.jpg','157.0632','2007-11-04 14:11:17','2007-11-04 14:42:50',NULL,'3.50',1,1,1,0),(2,10,'80002','monster.jpg','monster-02.jpg','monster-03.jpg','monster-04.jpg','1013.0112','2007-11-04 15:01:18','2007-11-04 15:03:09',NULL,'5.80',1,1,2,0),(4,10,'80004','sony-hdr.jpg','sony-hdr-02.jpg','sony-hdr-03.jpg','','4033.4572','2007-11-05 02:33:13','2007-11-05 02:36:50',NULL,'0.25',1,1,4,0),(5,10,'80005','hp-2710p.jpg','hp-2710p-02.jpg','','','1719.3309','2007-11-05 03:03:14',NULL,NULL,'1.68',1,1,5,0),(6,10,'80006','vaio-micro-pc.jpg','vaio-micro-pc-02.jpg','vaio-micro-pc-03.jpg','','2137.5465','2007-11-05 03:18:00',NULL,NULL,'0.50',1,1,4,0),(7,10,'80007','katamaran.jpg','katamaran-02.jpg','katamaran-03.jpg','','74.2565','2007-11-05 03:34:24',NULL,NULL,'4.50',1,1,1,0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_attributes`
--

DROP TABLE IF EXISTS `products_attributes`;
CREATE TABLE `products_attributes` (
  `products_attributes_id` int(11) NOT NULL auto_increment,
  `products_id` int(11) NOT NULL,
  `options_id` int(11) NOT NULL,
  `options_values_id` int(11) NOT NULL,
  `options_values_price` decimal(15,4) NOT NULL,
  `price_prefix` char(1) collate latin1_general_ci NOT NULL,
  `products_options_sort_order` int(3) NOT NULL,
  `products_attributes_weight` decimal(5,2) NOT NULL,
  `products_attributes_weight_prefix` char(1) collate latin1_general_ci NOT NULL,
  PRIMARY KEY  (`products_attributes_id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `products_attributes`
--

LOCK TABLES `products_attributes` WRITE;
/*!40000 ALTER TABLE `products_attributes` DISABLE KEYS */;
INSERT INTO `products_attributes` VALUES (40,5,3,7,'0.0000','+',0,'0.00','+'),(39,5,3,8,'0.0000','+',0,'0.00','+'),(38,5,3,9,'0.0000','+',0,'0.00','+'),(37,5,3,10,'0.0000','+',-1,'0.00','+'),(36,5,2,3,'0.0000','+',1,'0.00','+'),(35,5,2,4,'46.4684','+',2,'0.00','+'),(34,5,2,5,'92.9368','+',3,'0.00','+'),(33,5,1,1,'0.0000','+',0,'0.00','+'),(32,5,1,2,'157.9925','+',0,'0.00','+'),(41,5,3,6,'0.0000','+',0,'0.00','+');
/*!40000 ALTER TABLE `products_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_attributes_download`
--

DROP TABLE IF EXISTS `products_attributes_download`;
CREATE TABLE `products_attributes_download` (
  `products_attributes_id` int(11) NOT NULL,
  `products_attributes_filename` varchar(255) collate latin1_general_ci NOT NULL default '',
  `products_attributes_maxdays` int(2) default '0',
  `products_attributes_maxcount` int(2) default '0',
  PRIMARY KEY  (`products_attributes_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

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
CREATE TABLE `products_description` (
  `products_id` int(11) NOT NULL auto_increment,
  `language_id` int(11) NOT NULL default '1',
  `products_name` varchar(64) collate latin1_general_ci NOT NULL default '',
  `products_description` text collate latin1_general_ci,
  `products_url` varchar(255) collate latin1_general_ci default NULL,
  `products_viewed` int(5) default '0',
  `products_seo_url` varchar(100) collate latin1_general_ci NOT NULL,
  `products_head_title_tag` varchar(80) collate latin1_general_ci default NULL,
  `products_head_desc_tag` longtext collate latin1_general_ci,
  `products_head_keywords_tag` longtext collate latin1_general_ci,
  PRIMARY KEY  (`products_id`,`language_id`),
  KEY `products_name` (`products_name`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `products_description`
--

LOCK TABLES `products_description` WRITE;
/*!40000 ALTER TABLE `products_description` DISABLE KEYS */;
INSERT INTO `products_description` VALUES (1,2,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p><ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul><p><br /><strong>Beschreibung:</strong></p><ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul><p><br /><strong>Lieferumfang:</strong></p><ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',57,'','R/C Buggy HBX W2','R/C Buggy HBX W2','R/C Buggy HBX W2'),(1,1,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p> <ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul> <p><br /><strong>Beschreibung:</strong></p> <ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul> <p><br /><strong>Lieferumfang:</strong></p> <ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',0,'','R/C Buggy HBX W2','R/C Buggy HBX W2','R/C Buggy HBX W2'),(1,5,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p> <ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul> <p><br /><strong>Beschreibung:</strong></p> <ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul> <p><br /><strong>Lieferumfang:</strong></p> <ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',0,'','R/C Buggy HBX W2','R/C Buggy HBX W2','R/C Buggy HBX W2'),(1,4,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p> <ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul> <p><br /><strong>Beschreibung:</strong></p> <ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul> <p><br /><strong>Lieferumfang:</strong></p> <ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',0,'','R/C Buggy HBX W2','R/C Buggy HBX W2','R/C Buggy HBX W2'),(1,3,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p> <ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul> <p><br /><strong>Beschreibung:</strong></p> <ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul> <p><br /><strong>Lieferumfang:</strong></p> <ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',0,'','R/C Buggy HBX W2','R/C Buggy HBX W2','R/C Buggy HBX W2'),(2,2,'Monster Truck BigFoot','<p class=\"bodytext\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"bodytext\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"bodytext\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"bodytext\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"bodytext\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"bodytext\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"bodytext\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"bodytext\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"bodytext\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"bodytext\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"bodytext\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"bodytext\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',15,'','Monster Truck BigFoot','Monster Truck BigFoot','Monster Truck BigFoot'),(2,1,'Monster Truck BigFoot','<p class=\"bodytext\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"bodytext\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"bodytext\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"bodytext\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"bodytext\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"bodytext\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"bodytext\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"bodytext\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"bodytext\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"bodytext\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"bodytext\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"bodytext\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',0,'','Monster Truck BigFoot','Monster Truck BigFoot','Monster Truck BigFoot'),(2,5,'Monster Truck BigFoot','<p class=\"bodytext\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"bodytext\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"bodytext\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"bodytext\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"bodytext\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"bodytext\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"bodytext\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"bodytext\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"bodytext\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"bodytext\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"bodytext\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"bodytext\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',0,'','Monster Truck BigFoot','Monster Truck BigFoot','Monster Truck BigFoot'),(2,4,'Monster Truck BigFoot','<p class=\"bodytext\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"bodytext\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"bodytext\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"bodytext\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"bodytext\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"bodytext\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"bodytext\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"bodytext\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"bodytext\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"bodytext\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"bodytext\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"bodytext\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',0,'','Monster Truck BigFoot','Monster Truck BigFoot','Monster Truck BigFoot'),(2,3,'Monster Truck BigFoot','<p class=\"bodytext\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"bodytext\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"bodytext\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"bodytext\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"bodytext\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"bodytext\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"bodytext\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"bodytext\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"bodytext\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"bodytext\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"bodytext\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"bodytext\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',0,'','Monster Truck BigFoot','Monster Truck BigFoot','Monster Truck BigFoot'),(4,2,'Sony HDR-HC1','<ul><li>10fach optischer Zoom</li><li>3 Megapixel CMOS-Sensor</li><li>14 bit HD DXP Analog/Digital-Wandler</li><li>2,7 Zoll Hybrid LCD-Monitor</li><li>123.000 Pixel</li><li>Steady Shot Bildstabilisator</li><li>Fotofunktion Fotos mit 1920 x 1440 Pixel</li><li>Speicherm&ouml;glichkeit auf Memory Stick Duo</li><li>Anschl&uuml;sse i.LlNK Ein- und Ausgang</li><li>USB</li><li>Komponenten-Ausgang</li><li>Audio/Video- und S-Video-Ausgang</li><li>Abmessungen 71 x 94 x 188 mm</li><li>Gewicht 670 g</li></ul>','',22,'','Sony HDR-HC1','Sony HDR-HC1','Sony HDR-HC1'),(4,1,'Sony HDR-HC1','The Sony Handycam HDR-HC1\'s real draw is its ability to record 1080i HD video on standard MiniDV cassettes; it uses the recently implemented HDV format, which employs MPEG-2 compression rather than DV. Not much software currently supports HDV for digitizing, and the packages that do tend to be expensive products such as Adobe Premiere Pro 1.5 and Apple Final Cut Pro 5.0. So the HC1 also provides HD-to-DV downconversion for editing or playback on a standard-def (SD) TV. Like its big brother, the HDR-FX1, it incorporates Sony\'s Cinematic mode for simulating the appearance of 24fps film. It can also record standard DV. The camcorder supports component-video output and supplies the necessary cables, but if you have a FireWire port on your TV, you\'ll get the best playback quality that way.<br /><br />For the HC1\'s sensor, Sony uses a 1/3-inch, 3-megapixel CMOS chip with an RGB filter array. That provides an effective 2.0 megapixels for HD shooting and stills, 1.5 megapixels for SD video, and 2.8 megapixels for 4:3 photos. Its Zeiss T* 10X zoom lens won\'t win any spec wars, but it\'s perfectly sufficient for most shots, and Sony boosts the zoom effectiveness with its Super SteadyShot electronic stabilization.<br /><br />The rest of the HC1\'s features compete respectably with those of most camcorders in the same price bracket. You can select among automatic, manual, or spot focus. The Expanded Focus button enlarges the center of the scene for easier manual focusing, and the Tele Macro button will defocus the background to bring out the subject. In addition to using automatic adjustment and a handful of exposure presets, you can manually adjust the exposure or select the shutter speed. Same goes for the white balance, which includes a manual color-bias slider within the menu system. A zebra-stripe overexposure display and a live histogram supplement your exposure options, and for low-light shooting, you can turn to Sony\'s infrared NightShot mode and Super NightShot, which uses infrared and the built-in video light. An on-camera flash works for still photography, and Sony\'s Active Interface Shoe allows for more accessories. You can adjust the audio levels manually, and the HC1 includes connectors for an external microphone and headphones.','',0,'','Sony HDR-HC1','Sony HDR-HC1','Sony HDR-HC1'),(4,5,'Sony HDR-HC1','<ul><li>10fach optischer Zoom</li><li>3 Megapixel CMOS-Sensor</li><li>14 bit HD DXP Analog/Digital-Wandler</li><li>2,7 Zoll Hybrid LCD-Monitor</li><li>123.000 Pixel</li><li>Steady Shot Bildstabilisator</li><li>Fotofunktion Fotos mit 1920 x 1440 Pixel</li><li>Speicherm&ouml;glichkeit auf Memory Stick Duo</li><li>Anschl&uuml;sse i.LlNK Ein- und Ausgang</li><li>USB</li><li>Komponenten-Ausgang</li><li>Audio/Video- und S-Video-Ausgang</li><li>Abmessungen 71 x 94 x 188 mm</li><li>Gewicht 670 g</li></ul>','',0,'','Sony HDR-HC1','Sony HDR-HC1','Sony HDR-HC1'),(4,4,'Sony HDR-HC1','<ul><li>10fach optischer Zoom</li><li>3 Megapixel CMOS-Sensor</li><li>14 bit HD DXP Analog/Digital-Wandler</li><li>2,7 Zoll Hybrid LCD-Monitor</li><li>123.000 Pixel</li><li>Steady Shot Bildstabilisator</li><li>Fotofunktion Fotos mit 1920 x 1440 Pixel</li><li>Speicherm&ouml;glichkeit auf Memory Stick Duo</li><li>Anschl&uuml;sse i.LlNK Ein- und Ausgang</li><li>USB</li><li>Komponenten-Ausgang</li><li>Audio/Video- und S-Video-Ausgang</li><li>Abmessungen 71 x 94 x 188 mm</li><li>Gewicht 670 g</li></ul>','',0,'','Sony HDR-HC1','Sony HDR-HC1','Sony HDR-HC1'),(4,3,'Sony HDR-HC1','<ul><li>10fach optischer Zoom</li><li>3 Megapixel CMOS-Sensor</li><li>14 bit HD DXP Analog/Digital-Wandler</li><li>2,7 Zoll Hybrid LCD-Monitor</li><li>123.000 Pixel</li><li>Steady Shot Bildstabilisator</li><li>Fotofunktion Fotos mit 1920 x 1440 Pixel</li><li>Speicherm&ouml;glichkeit auf Memory Stick Duo</li><li>Anschl&uuml;sse i.LlNK Ein- und Ausgang</li><li>USB</li><li>Komponenten-Ausgang</li><li>Audio/Video- und S-Video-Ausgang</li><li>Abmessungen 71 x 94 x 188 mm</li><li>Gewicht 670 g</li></ul>','',0,'','Sony HDR-HC1','Sony HDR-HC1','Sony HDR-HC1'),(5,2,'HP Compaq 2710p Notebook','<ul><li>Genuine Windows Vista&reg; Business</li><li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li><li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li><li>1 GB 667 MHz DDR2 SDRAM</li><li>60 GB 4200 rpm SMART PATA</li><li>Intel 802.11a/b/g<br /> Bluetooth 2.0</li><li>100 GB 4200 rpm SMART PATA</li></ul>','',51,'','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook'),(5,1,'HP Compaq 2710p Notebook','<ul><li>Genuine Windows Vista&reg; Business</li><li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li><li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li><li>1 GB 667 MHz DDR2 SDRAM</li><li>60 GB 4200 rpm SMART PATA</li><li>Intel 802.11a/b/g<br />  Bluetooth 2.0</li><li>100 GB 4200 rpm SMART PATA</li></ul>','',0,'','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook'),(5,5,'HP Compaq 2710p Notebook','<ul><li>Genuine Windows Vista&reg; Business</li><li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li><li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li><li>1 GB 667 MHz DDR2 SDRAM</li><li>60 GB 4200 rpm SMART PATA</li><li>Intel 802.11a/b/g<br />  Bluetooth 2.0</li><li>100 GB 4200 rpm SMART PATA</li></ul>','',0,'','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook'),(5,4,'HP Compaq 2710p Notebook','<ul><li>Genuine Windows Vista&reg; Business</li><li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li><li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li><li>1 GB 667 MHz DDR2 SDRAM</li><li>60 GB 4200 rpm SMART PATA</li><li>Intel 802.11a/b/g<br />  Bluetooth 2.0</li><li>100 GB 4200 rpm SMART PATA</li></ul>','',0,'','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook'),(5,3,'HP Compaq 2710p Notebook','<ul><li>Genuine Windows Vista&reg; Business</li><li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li><li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li><li>1 GB 667 MHz DDR2 SDRAM</li><li>60 GB 4200 rpm SMART PATA</li><li>Intel 802.11a/b/g<br />  Bluetooth 2.0</li><li>100 GB 4200 rpm SMART PATA</li></ul>','',0,'','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook'),(6,2,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5&quot; wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.</p><p><strong>Ultra-portable design.</strong><br />The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.</p><p><strong>A truly mobile wireless companion.</strong><br />True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.</p><p><strong>Communication on the go.</strong><br />The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.</p><p><strong>Ingenious design.</strong><br />An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',144,'','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC'),(6,1,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5&quot; wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.<br /> </p><p><strong>Ultra-portable design.</strong><br /> The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.<br /> </p><p><strong>A truly mobile wireless companion.</strong><br /> True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.<br /> </p><p><strong>Communication on the go.</strong><br /> The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.<br /> </p><p><strong>Ingenious design.</strong><br /> An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',0,'','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC'),(6,5,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5&quot; wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.<br /> </p><p><strong>Ultra-portable design.</strong><br /> The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.<br /> </p><p><strong>A truly mobile wireless companion.</strong><br /> True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.<br /> </p><p><strong>Communication on the go.</strong><br /> The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.<br /> </p><p><strong>Ingenious design.</strong><br /> An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',0,'','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC'),(6,4,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5&quot; wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.<br /> </p><p><strong>Ultra-portable design.</strong><br /> The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.<br /> </p><p><strong>A truly mobile wireless companion.</strong><br /> True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.<br /> </p><p><strong>Communication on the go.</strong><br /> The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.<br /> </p><p><strong>Ingenious design.</strong><br /> An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',0,'','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC'),(6,3,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5&quot; wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.<br /> </p><p><strong>Ultra-portable design.</strong><br /> The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.<br /> </p><p><strong>A truly mobile wireless companion.</strong><br /> True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.<br /> </p><p><strong>Communication on the go.</strong><br /> The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.<br /> </p><p><strong>Ingenious design.</strong><br /> An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',0,'','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC'),(7,2,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /><br />Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /><br />Dieses Speed Boot liegt super auf dem Wasser.<br /><br />Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /><br /><strong>Dynamic:</strong><br />Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /><br /><strong>Power:</strong><br />Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /><br /><strong>Energy:</strong><br />Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /><br /><strong>Controller:</strong><br />R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /><br /><strong>Lieferumfang:</strong><br />R/C Speed Boot Katamaran<br />Powerakku, Ni-cd 1700mAh 7.2V<br />6 x AA f&uuml;r die Fernsteuerung.<br />Ladeger&auml;t f&uuml;r den Akku<br />Fernsteuerung','',26,'','R/C Katamaran','R/C Katamaran','R/C Katamaran'),(7,1,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /> <br /> Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /> <br /> Dieses Speed Boot liegt super auf dem Wasser.<br /> <br /> Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /> <br /> <strong>Dynamic:</strong><br /> Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /> <br /> <strong>Power:</strong><br /> Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /> <br /> <strong>Energy:</strong><br /> Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /> <br /> <strong>Controller:</strong><br /> R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /> <br /> <strong>Lieferumfang:</strong><br /> R/C Speed Boot Katamaran<br /> Powerakku, Ni-cd 1700mAh 7.2V<br /> 6 x AA f&uuml;r die Fernsteuerung.<br /> Ladeger&auml;t f&uuml;r den Akku<br /> Fernsteuerung','',0,'','R/C Katamaran','R/C Katamaran','R/C Katamaran'),(7,5,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /> <br /> Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /> <br /> Dieses Speed Boot liegt super auf dem Wasser.<br /> <br /> Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /> <br /> <strong>Dynamic:</strong><br /> Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /> <br /> <strong>Power:</strong><br /> Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /> <br /> <strong>Energy:</strong><br /> Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /> <br /> <strong>Controller:</strong><br /> R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /> <br /> <strong>Lieferumfang:</strong><br /> R/C Speed Boot Katamaran<br /> Powerakku, Ni-cd 1700mAh 7.2V<br /> 6 x AA f&uuml;r die Fernsteuerung.<br /> Ladeger&auml;t f&uuml;r den Akku<br /> Fernsteuerung','',0,'','R/C Katamaran','R/C Katamaran','R/C Katamaran'),(7,4,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /> <br /> Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /> <br /> Dieses Speed Boot liegt super auf dem Wasser.<br /> <br /> Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /> <br /> <strong>Dynamic:</strong><br /> Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /> <br /> <strong>Power:</strong><br /> Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /> <br /> <strong>Energy:</strong><br /> Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /> <br /> <strong>Controller:</strong><br /> R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /> <br /> <strong>Lieferumfang:</strong><br /> R/C Speed Boot Katamaran<br /> Powerakku, Ni-cd 1700mAh 7.2V<br /> 6 x AA f&uuml;r die Fernsteuerung.<br /> Ladeger&auml;t f&uuml;r den Akku<br /> Fernsteuerung','',0,'','R/C Katamaran','R/C Katamaran','R/C Katamaran'),(7,3,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /> <br /> Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /> <br /> Dieses Speed Boot liegt super auf dem Wasser.<br /> <br /> Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /> <br /> <strong>Dynamic:</strong><br /> Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /> <br /> <strong>Power:</strong><br /> Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /> <br /> <strong>Energy:</strong><br /> Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /> <br /> <strong>Controller:</strong><br /> R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /> <br /> <strong>Lieferumfang:</strong><br /> R/C Speed Boot Katamaran<br /> Powerakku, Ni-cd 1700mAh 7.2V<br /> 6 x AA f&uuml;r die Fernsteuerung.<br /> Ladeger&auml;t f&uuml;r den Akku<br /> Fernsteuerung','',0,'','R/C Katamaran','R/C Katamaran','R/C Katamaran');
/*!40000 ALTER TABLE `products_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_notifications`
--

DROP TABLE IF EXISTS `products_notifications`;
CREATE TABLE `products_notifications` (
  `products_id` int(11) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`products_id`,`customers_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `products_notifications`
--

LOCK TABLES `products_notifications` WRITE;
/*!40000 ALTER TABLE `products_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `products_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_options`
--

DROP TABLE IF EXISTS `products_options`;
CREATE TABLE `products_options` (
  `products_options_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `products_options_name` varchar(32) collate latin1_general_ci NOT NULL default '',
  `products_options_type` int(5) NOT NULL,
  `products_options_length` smallint(2) NOT NULL default '32',
  `products_options_comment` varchar(128) collate latin1_general_ci default NULL,
  `products_options_sort_order` int(2) NOT NULL,
  PRIMARY KEY  (`products_options_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `products_options`
--

LOCK TABLES `products_options` WRITE;
/*!40000 ALTER TABLE `products_options` DISABLE KEYS */;
INSERT INTO `products_options` VALUES (1,2,'RAM',0,0,'',0),(1,1,'RAM',0,0,'',0),(1,5,'RAM',0,0,'',0),(1,4,'RAM',0,0,'',0),(1,3,'RAM',0,0,'',0),(2,5,'Disc dur',0,0,'',0),(2,1,'Hard Disk',0,0,'',0),(2,2,'Festplatte',0,0,'',0),(2,4,'Hard Disk',0,0,'',0),(2,3,'Hard Disk',0,0,'',0),(3,2,'Betriebssystem',0,0,'',0),(3,1,'Operating System',0,0,'',0),(3,5,'Operating System',0,0,'',0),(3,4,'Operating System',0,0,'',0),(3,3,'Operating System',0,0,'',0);
/*!40000 ALTER TABLE `products_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_options_values`
--

DROP TABLE IF EXISTS `products_options_values`;
CREATE TABLE `products_options_values` (
  `products_options_values_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `products_options_values_name` varchar(64) collate latin1_general_ci NOT NULL default '',
  PRIMARY KEY  (`products_options_values_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `products_options_values`
--

LOCK TABLES `products_options_values` WRITE;
/*!40000 ALTER TABLE `products_options_values` DISABLE KEYS */;
INSERT INTO `products_options_values` VALUES (1,2,'1 GB 667 MHz DDR2 SDRAM'),(1,1,'1 GB 667 MHz DDR2 SDRAM'),(1,5,'1 GB 667 MHz DDR2 SDRAM'),(1,4,'1 GB 667 MHz DDR2 SDRAM'),(1,3,'1 GB 667 MHz DDR2 SDRAM'),(2,2,'2 GB 667 MHz DDR2 SDRAM'),(2,1,'2 GB 667 MHz DDR2 SDRAM'),(2,5,'2 GB 667 MHz DDR2 SDRAM'),(2,4,'2 GB 667 MHz DDR2 SDRAM'),(2,3,'2 GB 667 MHz DDR2 SDRAM'),(3,2,'60 GB 4200 rpm SMART PATA'),(3,1,'60 GB 4200 rpm SMART PATA'),(3,5,'60 GB 4200 rpm SMART PATA'),(3,4,'60 GB 4200 rpm SMART PATA'),(3,3,'60 GB 4200 rpm SMART PATA'),(4,2,'80 GB 4200 rpm SMART PATA'),(4,1,'80 GB 4200 rpm SMART PATA'),(4,5,'80 GB 4200 rpm SMART PATA'),(4,4,'80 GB 4200 rpm SMART PATA'),(4,3,'80 GB 4200 rpm SMART PATA'),(5,2,'100 GB 4200 rpm SMART PATA'),(5,1,'100 GB 4200 rpm SMART PATA'),(5,5,'100 GB 4200 rpm SMART PATA'),(5,4,'100 GB 4200 rpm SMART PATA'),(5,3,'100 GB 4200 rpm SMART PATA'),(6,2,'Windows XP Business'),(6,1,'Windows XP Business'),(6,5,'Windows XP Business'),(6,4,'Windows XP Business'),(6,3,'Windows XP Business'),(7,2,'Windows Vista® Business'),(7,1,'Windows Vista® Business'),(7,5,'Windows Vista® Business'),(7,4,'Windows Vista® Business'),(7,3,'Windows Vista® Business'),(8,2,'Linux openSUSE 10.3'),(8,1,'Linux openSUSE 10.3'),(8,5,'Linux openSUSE 10.3'),(8,4,'Linux openSUSE 10.3'),(8,3,'Linux openSUSE 10.3'),(9,2,'Linux Ubuntu Gibbon 7.10'),(9,1,'Linux Ubuntu Gibbon 7.10'),(9,5,'Linux Ubuntu Gibbon 7.10'),(9,4,'Linux Ubuntu Gibbon 7.10'),(9,3,'Linux Ubuntu Gibbon 7.10'),(10,2,'Bitte wählen'),(10,1,'Please choose'),(10,5,'Veuillez choisir'),(10,4,'Please choose'),(10,3,'Please choose');
/*!40000 ALTER TABLE `products_options_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_options_values_to_products_options`
--

DROP TABLE IF EXISTS `products_options_values_to_products_options`;
CREATE TABLE `products_options_values_to_products_options` (
  `products_options_values_to_products_options_id` int(11) NOT NULL auto_increment,
  `products_options_id` int(11) NOT NULL,
  `products_options_values_id` int(11) NOT NULL,
  PRIMARY KEY  (`products_options_values_to_products_options_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `products_options_values_to_products_options`
--

LOCK TABLES `products_options_values_to_products_options` WRITE;
/*!40000 ALTER TABLE `products_options_values_to_products_options` DISABLE KEYS */;
INSERT INTO `products_options_values_to_products_options` VALUES (1,1,1),(2,1,2),(3,2,3),(4,2,4),(5,2,5),(6,3,6),(7,3,7),(8,3,8),(9,3,9),(10,3,10);
/*!40000 ALTER TABLE `products_options_values_to_products_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_to_categories`
--

DROP TABLE IF EXISTS `products_to_categories`;
CREATE TABLE `products_to_categories` (
  `products_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL,
  PRIMARY KEY  (`products_id`,`categories_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `products_to_categories`
--

LOCK TABLES `products_to_categories` WRITE;
/*!40000 ALTER TABLE `products_to_categories` DISABLE KEYS */;
INSERT INTO `products_to_categories` VALUES (1,1),(2,1),(4,2),(5,2),(6,2),(7,1);
/*!40000 ALTER TABLE `products_to_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews` (
  `reviews_id` int(11) NOT NULL auto_increment,
  `products_id` int(11) NOT NULL,
  `customers_id` int(11) default NULL,
  `customers_name` varchar(64) collate latin1_general_ci NOT NULL,
  `reviews_rating` int(1) default NULL,
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  `reviews_read` int(5) NOT NULL default '0',
  PRIMARY KEY  (`reviews_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

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
CREATE TABLE `reviews_description` (
  `reviews_id` int(11) NOT NULL,
  `languages_id` int(11) NOT NULL,
  `reviews_text` text collate latin1_general_ci NOT NULL,
  PRIMARY KEY  (`reviews_id`,`languages_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

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
CREATE TABLE `saferpay_transactions` (
  `trans_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL default '0',
  `orders_id` int(11) NOT NULL default '0',
  `saferpay_ID` varchar(96) default NULL,
  `saferpay_amount` decimal(15,4) NOT NULL default '0.0000',
  `saferpay_currency` varchar(8) NOT NULL default '',
  `saferpay_provider_id` int(11) default '0',
  `saferpay_provider_name` varchar(255) default NULL,
  `saferpay_complete` int(1) NOT NULL default '0',
  `saferpay_complete_result` varchar(255) default NULL,
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  PRIMARY KEY  (`trans_id`),
  KEY `IDX_CUSTOMERS` (`customers_id`),
  KEY `IDX_ORDER` (`orders_id`),
  KEY `IDX_SAFERPAY_ID` (`saferpay_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

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
CREATE TABLE `sessions` (
  `sesskey` varchar(32) collate latin1_general_ci NOT NULL,
  `expiry` int(11) unsigned NOT NULL,
  `value` text collate latin1_general_ci NOT NULL,
  PRIMARY KEY  (`sesskey`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specials`
--

DROP TABLE IF EXISTS `specials`;
CREATE TABLE `specials` (
  `specials_id` int(11) NOT NULL auto_increment,
  `products_id` int(11) NOT NULL,
  `specials_new_products_price` decimal(15,4) NOT NULL,
  `specials_date_added` datetime default NULL,
  `specials_last_modified` datetime default NULL,
  `expires_date` datetime default NULL,
  `date_status_change` datetime default NULL,
  `status` int(1) NOT NULL default '1',
  PRIMARY KEY  (`specials_id`),
  KEY `IDX_SPECIALS_PRODUCTS_ID` (`products_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `specials`
--

LOCK TABLES `specials` WRITE;
/*!40000 ALTER TABLE `specials` DISABLE KEYS */;
INSERT INTO `specials` VALUES (1,7,'64.9628','2007-11-05 06:16:02','2007-11-05 06:16:38','0000-00-00 00:00:00',NULL,1);
/*!40000 ALTER TABLE `specials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_class`
--

DROP TABLE IF EXISTS `tax_class`;
CREATE TABLE `tax_class` (
  `tax_class_id` int(11) NOT NULL auto_increment,
  `tax_class_title` varchar(32) collate latin1_general_ci NOT NULL,
  `tax_class_description` varchar(255) collate latin1_general_ci NOT NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`tax_class_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

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
CREATE TABLE `tax_rates` (
  `tax_rates_id` int(11) NOT NULL auto_increment,
  `tax_zone_id` int(11) NOT NULL,
  `tax_class_id` int(11) NOT NULL,
  `tax_priority` int(5) default '1',
  `tax_rate` decimal(7,4) NOT NULL,
  `tax_description` varchar(255) collate latin1_general_ci NOT NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`tax_rates_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `tax_rates`
--

LOCK TABLES `tax_rates` WRITE;
/*!40000 ALTER TABLE `tax_rates` DISABLE KEYS */;
INSERT INTO `tax_rates` VALUES (1,1,1,1,'7.6000','7.6% MwSt.','2007-08-07 22:43:02','2007-06-12 22:50:01');
/*!40000 ALTER TABLE `tax_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `whos_online`
--

DROP TABLE IF EXISTS `whos_online`;
CREATE TABLE `whos_online` (
  `customer_id` int(11) default NULL,
  `full_name` varchar(64) collate latin1_general_ci NOT NULL,
  `session_id` varchar(128) collate latin1_general_ci NOT NULL,
  `ip_address` varchar(15) collate latin1_general_ci NOT NULL,
  `time_entry` varchar(14) collate latin1_general_ci NOT NULL,
  `time_last_click` varchar(14) collate latin1_general_ci NOT NULL,
  `last_page_url` varchar(255) collate latin1_general_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `whos_online`
--

LOCK TABLES `whos_online` WRITE;
/*!40000 ALTER TABLE `whos_online` DISABLE KEYS */;
INSERT INTO `whos_online` VALUES (0,'Guest','a4096fa3f4cd54d666174365cb803bde','127.0.0.1','1197343934','1197343979','/swisscart/trunk/index.php?osCsid=a4096fa3f4cd54d666174365cb803bde');
/*!40000 ALTER TABLE `whos_online` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zones`
--

DROP TABLE IF EXISTS `zones`;
CREATE TABLE `zones` (
  `zone_id` int(11) NOT NULL auto_increment,
  `zone_country_id` int(11) NOT NULL,
  `zone_code` varchar(32) collate latin1_general_ci NOT NULL,
  `zone_name` varchar(32) collate latin1_general_ci NOT NULL,
  PRIMARY KEY  (`zone_id`)
) ENGINE=MyISAM AUTO_INCREMENT=182 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

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
CREATE TABLE `zones_to_geo_zones` (
  `association_id` int(11) NOT NULL auto_increment,
  `zone_country_id` int(11) NOT NULL,
  `zone_id` int(11) default NULL,
  `geo_zone_id` int(11) default NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY  (`association_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

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

-- Dump completed on 2007-12-11  3:48:57
