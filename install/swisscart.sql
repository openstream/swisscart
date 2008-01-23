-- MySQL dump 9.11
--
-- Host: localhost    Database: swisscart_development
-- ------------------------------------------------------
-- Server version	4.0.21-debug-log

--
-- Table structure for table `address_book`
--

DROP TABLE IF EXISTS address_book;
CREATE TABLE address_book (
  address_book_id int(11) NOT NULL auto_increment,
  customers_id int(11) NOT NULL default '0',
  entry_gender char(1) NOT NULL default '',
  entry_company varchar(64) default NULL,
  entry_firstname varchar(32) NOT NULL default '',
  entry_lastname varchar(32) NOT NULL default '',
  entry_street_address varchar(64) NOT NULL default '',
  entry_suburb varchar(32) default NULL,
  entry_postcode varchar(10) NOT NULL default '',
  entry_city varchar(32) NOT NULL default '',
  entry_state varchar(32) default NULL,
  entry_country_id int(11) NOT NULL default '0',
  entry_zone_id int(11) NOT NULL default '0',
  PRIMARY KEY  (address_book_id),
  KEY idx_address_book_customers_id (customers_id)
) TYPE=MyISAM;

--
-- Dumping data for table `address_book`
--

INSERT INTO address_book VALUES (2,2,'m','Openstream Internet Solutions','Nick','Weisser','Wieslergasse 6','','8049','Zürch','',204,129);
INSERT INTO address_book VALUES (3,2,'m','Openstream Internet Solutions','Nick','Weisser','Waldkircher Str. 14','','78054','Villingen-Schwenningen','',81,80);

--
-- Table structure for table `address_format`
--

DROP TABLE IF EXISTS address_format;
CREATE TABLE address_format (
  address_format_id int(11) NOT NULL auto_increment,
  address_format varchar(128) NOT NULL default '',
  address_summary varchar(48) NOT NULL default '',
  PRIMARY KEY  (address_format_id)
) TYPE=MyISAM;

--
-- Dumping data for table `address_format`
--

INSERT INTO address_format VALUES (1,'$firstname $lastname$cr$streets$cr$city, $postcode$cr$statecomma$country','$city / $country');
INSERT INTO address_format VALUES (2,'$firstname $lastname$cr$streets$cr$city, $state    $postcode$cr$country','$city, $state / $country');
INSERT INTO address_format VALUES (3,'$firstname $lastname$cr$streets$cr$city$cr$postcode - $statecomma$country','$state / $country');
INSERT INTO address_format VALUES (4,'$firstname $lastname$cr$streets$cr$city ($postcode)$cr$country','$postcode / $country');
INSERT INTO address_format VALUES (5,'$firstname $lastname$cr$streets$cr$postcode $city$cr$country','$city / $country');

--
-- Table structure for table `banners`
--

DROP TABLE IF EXISTS banners;
CREATE TABLE banners (
  banners_id int(11) NOT NULL auto_increment,
  banners_title varchar(64) NOT NULL default '',
  banners_url varchar(255) NOT NULL default '',
  banners_image varchar(64) NOT NULL default '',
  banners_group varchar(10) NOT NULL default '',
  banners_html_text text,
  expires_impressions int(7) default '0',
  expires_date datetime default NULL,
  date_scheduled datetime default NULL,
  date_added datetime NOT NULL default '0000-00-00 00:00:00',
  date_status_change datetime default NULL,
  status int(1) NOT NULL default '1',
  PRIMARY KEY  (banners_id)
) TYPE=MyISAM;

--
-- Dumping data for table `banners`
--

INSERT INTO banners VALUES (1,'osCommerce','http://www.oscommerce.com','banners/oscommerce.gif','468x50','',0,NULL,NULL,'2007-06-12 22:50:01','2007-07-05 15:50:01',0);

--
-- Table structure for table `banners_history`
--

DROP TABLE IF EXISTS banners_history;
CREATE TABLE banners_history (
  banners_history_id int(11) NOT NULL auto_increment,
  banners_id int(11) NOT NULL default '0',
  banners_shown int(5) NOT NULL default '0',
  banners_clicked int(5) NOT NULL default '0',
  banners_history_date datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (banners_history_id)
) TYPE=MyISAM;

--
-- Dumping data for table `banners_history`
--

INSERT INTO banners_history VALUES (1,1,21,0,'2007-06-12 22:50:09');
INSERT INTO banners_history VALUES (2,1,176,0,'2007-06-13 02:03:37');
INSERT INTO banners_history VALUES (3,1,196,0,'2007-07-05 00:43:57');

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS cache;
CREATE TABLE cache (
  cache_id varchar(32) NOT NULL default '',
  cache_language_id tinyint(1) NOT NULL default '0',
  cache_name varchar(255) NOT NULL default '',
  cache_data mediumtext NOT NULL,
  cache_global tinyint(1) NOT NULL default '1',
  cache_gzip tinyint(1) NOT NULL default '1',
  cache_method varchar(20) NOT NULL default 'RETURN',
  cache_date datetime NOT NULL default '0000-00-00 00:00:00',
  cache_expires datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (cache_id,cache_language_id),
  KEY cache_id (cache_id),
  KEY cache_language_id (cache_language_id),
  KEY cache_global (cache_global)
) TYPE=MyISAM;

--
-- Dumping data for table `cache`
--


--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
  categories_id int(11) NOT NULL auto_increment,
  categories_image varchar(64) default NULL,
  parent_id int(11) NOT NULL default '0',
  sort_order int(3) default NULL,
  date_added datetime default NULL,
  last_modified datetime default NULL,
  PRIMARY KEY  (categories_id),
  KEY idx_categories_parent_id (parent_id)
) TYPE=MyISAM;

--
-- Dumping data for table `categories`
--

INSERT INTO categories VALUES (1,'',0,1,'2007-11-04 13:57:31','2007-11-05 06:23:28');
INSERT INTO categories VALUES (2,'',0,0,'2007-11-04 13:57:51',NULL);

--
-- Table structure for table `categories_description`
--

DROP TABLE IF EXISTS categories_description;
CREATE TABLE categories_description (
  categories_id int(11) NOT NULL default '0',
  language_id int(11) NOT NULL default '1',
  categories_name varchar(32) NOT NULL default '',
  categories_seo_url varchar(100) NOT NULL default '',
  categories_htc_title_tag varchar(80) default NULL,
  categories_htc_desc_tag longtext,
  categories_htc_keywords_tag longtext,
  categories_htc_description longtext,
  PRIMARY KEY  (categories_id,language_id),
  KEY idx_categories_name (categories_name)
) TYPE=MyISAM;

--
-- Dumping data for table `categories_description`
--

INSERT INTO categories_description VALUES (1,2,'Ferngesteuerte Autos','','R/C Modellbau','R/C Modellbau','R/C Modellbau','');
INSERT INTO categories_description VALUES (1,1,'Remote Cars','','R/C Modellbau','R/C Modellbau','R/C Modellbau','');
INSERT INTO categories_description VALUES (1,5,'Ferngesteuerte Autos','','R/C Modellbau','R/C Modellbau','R/C Modellbau','');
INSERT INTO categories_description VALUES (1,4,'Ferngesteuerte Autos','','R/C Modellbau','R/C Modellbau','R/C Modellbau','');
INSERT INTO categories_description VALUES (1,3,'Ferngesteuerte Autos','','R/C Modellbau','R/C Modellbau','R/C Modellbau','');
INSERT INTO categories_description VALUES (2,2,'Consumer Electronics','','Consumer Electronics','Consumer Electronics','Consumer Electronics','');
INSERT INTO categories_description VALUES (2,1,'Consumer Electronics','','Consumer Electronics','Consumer Electronics','Consumer Electronics','');
INSERT INTO categories_description VALUES (2,5,'Consumer Electronics','','Consumer Electronics','Consumer Electronics','Consumer Electronics','');
INSERT INTO categories_description VALUES (2,4,'Consumer Electronics','','Consumer Electronics','Consumer Electronics','Consumer Electronics','');
INSERT INTO categories_description VALUES (2,3,'Consumer Electronics','','Consumer Electronics','Consumer Electronics','Consumer Electronics','');

--
-- Table structure for table `configuration`
--

DROP TABLE IF EXISTS configuration;
CREATE TABLE configuration (
  configuration_id int(11) NOT NULL auto_increment,
  configuration_title varchar(64) NOT NULL default '',
  configuration_key varchar(64) NOT NULL default '',
  configuration_value varchar(255) NOT NULL default '',
  configuration_description varchar(255) NOT NULL default '',
  configuration_group_id int(11) NOT NULL default '0',
  sort_order int(5) default NULL,
  last_modified datetime default NULL,
  date_added datetime NOT NULL default '0000-00-00 00:00:00',
  use_function varchar(255) default NULL,
  set_function varchar(255) default NULL,
  PRIMARY KEY  (configuration_id)
) TYPE=MyISAM;

--
-- Dumping data for table `configuration`
--

INSERT INTO configuration VALUES (1,'Store Name','STORE_NAME','swisscart®','The name of my store',1,1,'2007-06-13 03:41:48','2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (2,'Store Owner','STORE_OWNER','Nick Weisser','The name of my store owner',1,2,'2007-06-13 02:02:45','2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (3,'E-Mail Address','STORE_OWNER_EMAIL_ADDRESS','root@localhost','The e-mail address of my store owner',1,3,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (4,'E-Mail From','EMAIL_FROM','osCommerce <root@localhost>','The e-mail address used in (sent) e-mails',1,4,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (5,'Country','STORE_COUNTRY','204','The country my store is located in <br><br><b>Note: Please remember to update the store zone.</b>',1,6,'2007-06-13 02:02:21','2007-06-12 22:50:01','tep_get_country_name','tep_cfg_pull_down_country_list(');
INSERT INTO configuration VALUES (6,'Zone','STORE_ZONE','129','The zone my store is located in',1,7,'2007-06-13 02:02:30','2007-06-12 22:50:01','tep_cfg_get_zone_name','tep_cfg_pull_down_zone_list(');
INSERT INTO configuration VALUES (7,'Expected Sort Order','EXPECTED_PRODUCTS_SORT','desc','This is the sort order used in the expected products box.',1,8,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'asc\', \'desc\'),');
INSERT INTO configuration VALUES (8,'Expected Sort Field','EXPECTED_PRODUCTS_FIELD','date_expected','The column to sort by in the expected products box.',1,9,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'products_name\', \'date_expected\'),');
INSERT INTO configuration VALUES (9,'Switch To Default Language Currency','USE_DEFAULT_LANGUAGE_CURRENCY','false','Automatically switch to the language\'s currency when it is changed',1,10,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (10,'Send Extra Order Emails To','SEND_EXTRA_ORDER_EMAILS_TO','','Send extra order emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;',1,11,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (11,'Use Search-Engine Safe URLs (still in development)','SEARCH_ENGINE_FRIENDLY_URLS','false','Use search-engine safe urls for all site links',1,12,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (12,'Display Cart After Adding Product','DISPLAY_CART','true','Display the shopping cart after adding a product (or return back to their origin)',1,14,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (13,'Allow Guest To Tell A Friend','ALLOW_GUEST_TO_TELL_A_FRIEND','false','Allow guests to tell a friend about a product',1,15,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (14,'Default Search Operator','ADVANCED_SEARCH_DEFAULT_OPERATOR','and','Default search operators',1,17,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'and\', \'or\'),');
INSERT INTO configuration VALUES (15,'Store Address and Phone','STORE_NAME_ADDRESS','Openstream Internet Solutions\r\nWieslergasse 6\r\n8049 Zürich\r\n+41 44 500 78 78\r\ninfo@swisscart.com','This is the Store Name, Address and Phone used on printable documents and displayed online',1,18,'2007-12-13 17:41:41','2007-06-12 22:50:01',NULL,'tep_cfg_textarea(');
INSERT INTO configuration VALUES (16,'Show Category Counts','SHOW_COUNTS','false','Count recursively how many products are in each category',1,19,'2007-08-13 20:02:16','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (17,'Tax Decimal Places','TAX_DECIMAL_PLACES','0','Pad the tax value this amount of decimal places',1,20,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (18,'Display Prices with Tax','DISPLAY_PRICE_WITH_TAX','true','Display prices with tax included (true) or add the tax at the end (false)',1,21,'2007-11-04 14:12:51','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (19,'First Name','ENTRY_FIRST_NAME_MIN_LENGTH','2','Minimum length of first name',2,1,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (20,'Last Name','ENTRY_LAST_NAME_MIN_LENGTH','2','Minimum length of last name',2,2,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (21,'Date of Birth','ENTRY_DOB_MIN_LENGTH','10','Minimum length of date of birth',2,3,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (22,'E-Mail Address','ENTRY_EMAIL_ADDRESS_MIN_LENGTH','6','Minimum length of e-mail address',2,4,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (23,'Street Address','ENTRY_STREET_ADDRESS_MIN_LENGTH','5','Minimum length of street address',2,5,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (24,'Company','ENTRY_COMPANY_MIN_LENGTH','2','Minimum length of company name',2,6,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (25,'Post Code','ENTRY_POSTCODE_MIN_LENGTH','4','Minimum length of post code',2,7,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (26,'City','ENTRY_CITY_MIN_LENGTH','3','Minimum length of city',2,8,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (27,'State','ENTRY_STATE_MIN_LENGTH','2','Minimum length of state',2,9,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (28,'Telephone Number','ENTRY_TELEPHONE_MIN_LENGTH','3','Minimum length of telephone number',2,10,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (29,'Password','ENTRY_PASSWORD_MIN_LENGTH','5','Minimum length of password',2,11,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (30,'Credit Card Owner Name','CC_OWNER_MIN_LENGTH','3','Minimum length of credit card owner name',2,12,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (31,'Credit Card Number','CC_NUMBER_MIN_LENGTH','10','Minimum length of credit card number',2,13,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (32,'Review Text','REVIEW_TEXT_MIN_LENGTH','50','Minimum length of review text',2,14,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (33,'Best Sellers','MIN_DISPLAY_BESTSELLERS','1','Minimum number of best sellers to display',2,15,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (34,'Also Purchased','MIN_DISPLAY_ALSO_PURCHASED','1','Minimum number of products to display in the \'This Customer Also Purchased\' box',2,16,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (35,'Address Book Entries','MAX_ADDRESS_BOOK_ENTRIES','5','Maximum address book entries a customer is allowed to have',3,1,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (36,'Search Results','MAX_DISPLAY_SEARCH_RESULTS','20','Amount of products to list',3,2,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (37,'Page Links','MAX_DISPLAY_PAGE_LINKS','5','Number of \'number\' links use for page-sets',3,3,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (38,'Special Products','MAX_DISPLAY_SPECIAL_PRODUCTS','9','Maximum number of products on special to display',3,4,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (39,'New Products Module','MAX_DISPLAY_NEW_PRODUCTS','9','Maximum number of new products to display in a category',3,5,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (40,'Products Expected','MAX_DISPLAY_UPCOMING_PRODUCTS','10','Maximum number of products expected to display',3,6,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (41,'Manufacturers List','MAX_DISPLAY_MANUFACTURERS_IN_A_LIST','0','Used in manufacturers box; when the number of manufacturers exceeds this number, a drop-down list will be displayed instead of the default list',3,7,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (42,'Manufacturers Select Size','MAX_MANUFACTURERS_LIST','1','Used in manufacturers box; when this value is \'1\' the classic drop-down list will be used for the manufacturers box. Otherwise, a list-box with the specified number of rows will be displayed.',3,7,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (43,'Length of Manufacturers Name','MAX_DISPLAY_MANUFACTURER_NAME_LEN','15','Used in manufacturers box; maximum length of manufacturers name to display',3,8,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (44,'New Reviews','MAX_DISPLAY_NEW_REVIEWS','6','Maximum number of new reviews to display',3,9,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (45,'Selection of Random Reviews','MAX_RANDOM_SELECT_REVIEWS','10','How many records to select from to choose one random product review',3,10,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (46,'Selection of Random New Products','MAX_RANDOM_SELECT_NEW','10','How many records to select from to choose one random new product to display',3,11,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (47,'Selection of Products on Special','MAX_RANDOM_SELECT_SPECIALS','10','How many records to select from to choose one random product special to display',3,12,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (48,'Categories To List Per Row','MAX_DISPLAY_CATEGORIES_PER_ROW','3','How many categories to list per row',3,13,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (49,'New Products Listing','MAX_DISPLAY_PRODUCTS_NEW','10','Maximum number of new products to display in new products page',3,14,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (50,'Best Sellers','MAX_DISPLAY_BESTSELLERS','10','Maximum number of best sellers to display',3,15,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (51,'Also Purchased','MAX_DISPLAY_ALSO_PURCHASED','6','Maximum number of products to display in the \'This Customer Also Purchased\' box',3,16,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (52,'Customer Order History Box','MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX','6','Maximum number of products to display in the customer order history box',3,17,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (53,'Order History','MAX_DISPLAY_ORDER_HISTORY','10','Maximum number of orders to display in the order history page',3,18,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (54,'Small Image Width','SMALL_IMAGE_WIDTH','100','The pixel width of small images',4,1,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (55,'Small Image Height','SMALL_IMAGE_HEIGHT','','The pixel height of small images',4,2,'2007-08-05 01:51:34','2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (56,'Heading Image Width','HEADING_IMAGE_WIDTH','57','The pixel width of heading images',4,3,'2007-08-14 23:41:05','2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (57,'Heading Image Height','HEADING_IMAGE_HEIGHT','','The pixel height of heading images',4,4,'2007-08-01 22:32:43','2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (58,'Subcategory Image Width','SUBCATEGORY_IMAGE_WIDTH','100','The pixel width of subcategory images',4,5,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (59,'Subcategory Image Height','SUBCATEGORY_IMAGE_HEIGHT','','The pixel height of subcategory images',4,6,'2007-08-01 22:32:53','2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (60,'Calculate Image Size','CONFIG_CALCULATE_IMAGE_SIZE','true','Calculate the size of images?',4,7,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (61,'Image Required','IMAGE_REQUIRED','true','Enable to display broken images. Good for development.',4,8,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (62,'Gender','ACCOUNT_GENDER','true','Display gender in the customers account',5,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (63,'Date of Birth','ACCOUNT_DOB','false','Display date of birth in the customers account',5,2,'2007-12-13 14:32:25','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (64,'Company','ACCOUNT_COMPANY','true','Display company in the customers account',5,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (65,'Suburb','ACCOUNT_SUBURB','false','Display suburb in the customers account',5,4,'2007-12-13 14:32:33','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (66,'State','ACCOUNT_STATE','false','Display state in the customers account',5,5,'2007-12-13 14:32:38','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (67,'Installed Modules','MODULE_PAYMENT_INSTALLED','cc.php;cod.php','List of payment module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: cc.php;cod.php;paypal.php)',6,0,'2007-10-22 16:10:53','2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (68,'Installed Modules','MODULE_ORDER_TOTAL_INSTALLED','ot_subtotal.php;ot_shipping.php;ot_tax.php;ot_total.php','List of order_total module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)',6,0,'2007-12-04 03:38:32','2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (69,'Installed Modules','MODULE_SHIPPING_INSTALLED','chp.php;chplet.php;chpletinpri.php','List of shipping module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ups.php;flat.php;item.php)',6,0,'2007-08-14 00:22:47','2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (70,'Enable Cash On Delivery Module','MODULE_PAYMENT_COD_STATUS','True','Do you want to accept Cash On Delevery payments?',6,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (71,'Payment Zone','MODULE_PAYMENT_COD_ZONE','0','If a zone is selected, only enable this payment method for that zone.',6,2,NULL,'2007-06-12 22:50:01','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes(');
INSERT INTO configuration VALUES (72,'Sort order of display.','MODULE_PAYMENT_COD_SORT_ORDER','0','Sort order of display. Lowest is displayed first.',6,0,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (73,'Set Order Status','MODULE_PAYMENT_COD_ORDER_STATUS_ID','0','Set the status of orders made with this payment module to this value',6,0,NULL,'2007-06-12 22:50:01','tep_get_order_status_name','tep_cfg_pull_down_order_statuses(');
INSERT INTO configuration VALUES (418,'Require CCV2','MODULE_PAYMENT_CC_CVV2','True','Require cvv2 numbers',6,0,NULL,'2007-10-22 16:10:52',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (417,'Set Order Status','MODULE_PAYMENT_CC_ORDER_STATUS_ID','0','Set the status of orders made with this payment module to this value',6,0,NULL,'2007-10-22 16:10:52','tep_get_order_status_name','tep_cfg_pull_down_order_statuses(');
INSERT INTO configuration VALUES (415,'Sort order of display.','MODULE_PAYMENT_CC_SORT_ORDER','0','Sort order of display. Lowest is displayed first.',6,0,NULL,'2007-10-22 16:10:52',NULL,NULL);
INSERT INTO configuration VALUES (416,'Payment Zone','MODULE_PAYMENT_CC_ZONE','0','If a zone is selected, only enable this payment method for that zone.',6,2,NULL,'2007-10-22 16:10:52','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes(');
INSERT INTO configuration VALUES (413,'Enable Credit Card Module','MODULE_PAYMENT_CC_STATUS','True','Do you want to accept credit card payments?',6,0,NULL,'2007-10-22 16:10:52',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (414,'Split Credit Card E-Mail Address','MODULE_PAYMENT_CC_EMAIL','','If an e-mail address is entered, the middle digits of the credit card number will be sent to the e-mail address (the outside digits are stored in the database with the middle digits censored)',6,0,NULL,'2007-10-22 16:10:52',NULL,NULL);
INSERT INTO configuration VALUES (436,'TinyMCE Advanced Image Manager','TINYMCE_IMAGEMANAGER_ENABLED','true','If you want to enable the image manager you need to <a href=\"http://tinymce.moxiecode.com/paypal/item_imagemanager.php\" target=\"_blank\" class=\"underline\">purchase a license</a>!',17,2,'2007-12-28 20:32:42','2007-12-28 20:20:39',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (84,'Default Currency','DEFAULT_CURRENCY','CHF','Default Currency',6,0,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (85,'Default Language','DEFAULT_LANGUAGE','en','Default Language',6,0,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (86,'Default Order Status For New Orders','DEFAULT_ORDERS_STATUS_ID','1','When a new order is created, this order status will be assigned to it.',6,0,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (87,'Display Shipping','MODULE_ORDER_TOTAL_SHIPPING_STATUS','true','Do you want to display the order shipping cost?',6,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (88,'Sort Order','MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER','2','Sort order of display.',6,2,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (89,'Allow Free Shipping','MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING','false','Do you want to allow free shipping?',6,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (90,'Free Shipping For Orders Over','MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER','50','Provide free shipping for orders over the set amount.',6,4,NULL,'2007-06-12 22:50:01','currencies->format',NULL);
INSERT INTO configuration VALUES (91,'Provide Free Shipping For Orders Made','MODULE_ORDER_TOTAL_SHIPPING_DESTINATION','national','Provide free shipping for orders sent to the set destination.',6,5,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'national\', \'international\', \'both\'),');
INSERT INTO configuration VALUES (92,'Display Sub-Total','MODULE_ORDER_TOTAL_SUBTOTAL_STATUS','true','Do you want to display the order sub-total cost?',6,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (93,'Sort Order','MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER','1','Sort order of display.',6,2,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (94,'Display Tax','MODULE_ORDER_TOTAL_TAX_STATUS','true','Do you want to display the order tax value?',6,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (95,'Sort Order','MODULE_ORDER_TOTAL_TAX_SORT_ORDER','3','Sort order of display.',6,2,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (96,'Display Total','MODULE_ORDER_TOTAL_TOTAL_STATUS','true','Do you want to display the total order value?',6,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (97,'Sort Order','MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER','4','Sort order of display.',6,2,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (98,'Country of Origin','SHIPPING_ORIGIN_COUNTRY','204','Select the country of origin to be used in shipping quotes.',7,1,'2007-08-07 22:06:02','2007-06-12 22:50:01','tep_get_country_name','tep_cfg_pull_down_country_list(');
INSERT INTO configuration VALUES (99,'Postal Code','SHIPPING_ORIGIN_ZIP','8049','Enter the Postal Code (ZIP) of the Store to be used in shipping quotes.',7,2,'2007-08-07 22:06:07','2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (100,'Enter the Maximum Package Weight you will ship','SHIPPING_MAX_WEIGHT','30','Carriers have a max weight limit for a single package. This is a common one for all.',7,3,'2007-08-07 22:06:20','2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (101,'Package Tare weight.','SHIPPING_BOX_WEIGHT','0','What is the weight of typical packaging of small to medium packages?',7,4,'2007-08-07 22:05:49','2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (102,'Larger packages - percentage increase.','SHIPPING_BOX_PADDING','0','For 10% enter 10',7,5,'2007-08-07 22:05:53','2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (103,'Display Product Image','PRODUCT_LIST_IMAGE','1','Do you want to display the Product Image?',8,1,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (104,'Display Product Manufaturer Name','PRODUCT_LIST_MANUFACTURER','0','Do you want to display the Product Manufacturer Name?',8,2,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (105,'Display Product Model','PRODUCT_LIST_MODEL','0','Do you want to display the Product Model?',8,3,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (106,'Display Product Name','PRODUCT_LIST_NAME','2','Do you want to display the Product Name?',8,4,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (107,'Display Product Price','PRODUCT_LIST_PRICE','3','Do you want to display the Product Price',8,5,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (108,'Display Product Quantity','PRODUCT_LIST_QUANTITY','0','Do you want to display the Product Quantity?',8,6,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (109,'Display Product Weight','PRODUCT_LIST_WEIGHT','0','Do you want to display the Product Weight?',8,7,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (110,'Display Buy Now column','PRODUCT_LIST_BUY_NOW','4','Do you want to display the Buy Now column?',8,8,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (111,'Display Category/Manufacturer Filter (0=disable; 1=enable)','PRODUCT_LIST_FILTER','1','Do you want to display the Category/Manufacturer Filter?',8,9,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (112,'Location of Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)','PREV_NEXT_BAR_LOCATION','2','Sets the location of the Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)',8,10,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (113,'Check stock level','STOCK_CHECK','true','Check to see if sufficent stock is available',9,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (114,'Subtract stock','STOCK_LIMITED','true','Subtract product in stock by product orders',9,2,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (115,'Allow Checkout','STOCK_ALLOW_CHECKOUT','true','Allow customer to checkout even if there is insufficient stock',9,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (116,'Mark product out of stock','STOCK_MARK_PRODUCT_OUT_OF_STOCK','***','Display something on screen so customer can see which product has insufficient stock',9,4,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (117,'Stock Re-order level','STOCK_REORDER_LEVEL','5','Define when stock needs to be re-ordered',9,5,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (118,'Store Page Parse Time','STORE_PAGE_PARSE_TIME','false','Store the time it takes to parse a page',10,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (119,'Log Destination','STORE_PAGE_PARSE_TIME_LOG','/var/log/www/tep/page_parse_time.log','Directory and filename of the page parse time log',10,2,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (120,'Log Date Format','STORE_PARSE_DATE_TIME_FORMAT','%d/%m/%Y %H:%M:%S','The date format',10,3,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (121,'Display The Page Parse Time','DISPLAY_PAGE_PARSE_TIME','true','Display the page parse time (store page parse time must be enabled)',10,4,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (122,'Store Database Queries','STORE_DB_TRANSACTIONS','false','Store the database queries in the page parse time log (PHP4 only)',10,5,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (123,'Use Cache','USE_CACHE','false','Use caching features',11,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (124,'Cache Directory','DIR_FS_CACHE','/tmp/','The directory where the cached files are saved',11,2,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (125,'E-Mail Transport Method','EMAIL_TRANSPORT','sendmail','Defines if this server uses a local connection to sendmail or uses an SMTP connection via TCP/IP. Servers running on Windows and MacOS should change this setting to SMTP.',12,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'sendmail\', \'smtp\'),');
INSERT INTO configuration VALUES (126,'E-Mail Linefeeds','EMAIL_LINEFEED','LF','Defines the character sequence used to separate mail headers.',12,2,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'LF\', \'CRLF\'),');
INSERT INTO configuration VALUES (127,'Use MIME HTML When Sending Emails','EMAIL_USE_HTML','false','Send e-mails in HTML format',12,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (128,'Verify E-Mail Addresses Through DNS','ENTRY_EMAIL_ADDRESS_CHECK','false','Verify e-mail address through a DNS server',12,4,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (129,'Send E-Mails','SEND_EMAILS','true','Send out e-mails',12,5,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (130,'Enable download','DOWNLOAD_ENABLED','false','Enable the products download functions.',13,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (131,'Download by redirect','DOWNLOAD_BY_REDIRECT','false','Use browser redirection for download. Disable on non-Unix systems.',13,2,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (132,'Expiry delay (days)','DOWNLOAD_MAX_DAYS','7','Set number of days before the download link expires. 0 means no limit.',13,3,NULL,'2007-06-12 22:50:01',NULL,'');
INSERT INTO configuration VALUES (133,'Maximum number of downloads','DOWNLOAD_MAX_COUNT','5','Set the maximum number of downloads. 0 means no download authorized.',13,4,NULL,'2007-06-12 22:50:01',NULL,'');
INSERT INTO configuration VALUES (134,'Enable GZip Compression','GZIP_COMPRESSION','false','Enable HTTP GZip compression.',14,1,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (135,'Compression Level','GZIP_LEVEL','5','Use this compression level 0-9 (0 = minimum, 9 = maximum).',14,2,NULL,'2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (136,'Session Directory','SESSION_WRITE_DIRECTORY','C:\\xampp\\tmp','If sessions are file based, store them in this directory.',15,1,'2008-01-16 04:07:25','2007-06-12 22:50:01',NULL,NULL);
INSERT INTO configuration VALUES (137,'Force Cookie Use','SESSION_FORCE_COOKIE_USE','False','Force the use of sessions when cookies are only enabled.',15,2,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (138,'Check SSL Session ID','SESSION_CHECK_SSL_SESSION_ID','False','Validate the SSL_SESSION_ID on every secure HTTPS page request.',15,3,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (139,'Check User Agent','SESSION_CHECK_USER_AGENT','False','Validate the clients browser user agent on every page request.',15,4,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (140,'Check IP Address','SESSION_CHECK_IP_ADDRESS','False','Validate the clients IP address on every page request.',15,5,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (141,'Prevent Spider Sessions','SESSION_BLOCK_SPIDERS','True','Prevent known spiders from starting a session.',15,6,'2007-11-27 19:38:31','2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (142,'Recreate Session','SESSION_RECREATE','False','Recreate the session to generate a new session ID when the customer logs on or creates an account (PHP >=4.1 needed).',15,7,NULL,'2007-06-12 22:50:01',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (143,'Enable SEO URLs?','SEO_ENABLED','false','Enable the SEO URLs?  This is a global setting and will turn them off completely.',16,0,'2007-11-08 22:21:23','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (144,'Add cPath to product URLs?','SEO_ADD_CPATH_TO_PRODUCT_URLS','false','This setting will append the cPath to the end of product URLs (i.e. - some-product-p-1.html?cPath=xx).',16,1,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (145,'Add category parent to begining of URLs?','SEO_ADD_CAT_PARENT','true','This setting will add the category parent name to the beginning of the category URLs (i.e. - parent-category-c-1.html).',16,2,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (146,'Filter Short Words','SEO_URLS_FILTER_SHORT_WORDS','3','This setting will filter words less than or equal to the value from the URL.',16,3,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,NULL);
INSERT INTO configuration VALUES (147,'Output W3C valid URLs (parameter string)?','SEO_URLS_USE_W3C_VALID','true','This setting will output W3C valid URLs.',16,4,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (148,'Enable SEO cache to save queries?','USE_SEO_CACHE_GLOBAL','true','This is a global setting and will turn off caching completely.',16,5,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (149,'Enable product cache?','USE_SEO_CACHE_PRODUCTS','true','This will turn off caching for the products.',16,6,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (150,'Enable categories cache?','USE_SEO_CACHE_CATEGORIES','true','This will turn off caching for the categories.',16,7,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (151,'Enable manufacturers cache?','USE_SEO_CACHE_MANUFACTURERS','true','This will turn off caching for the manufacturers.',16,8,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (152,'Enable articles cache?','USE_SEO_CACHE_ARTICLES','true','This will turn off caching for the articles.',16,9,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (153,'Enable topics cache?','USE_SEO_CACHE_TOPICS','true','This will turn off caching for the article topics.',16,10,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (154,'Enable information cache?','USE_SEO_CACHE_INFO_PAGES','true','This will turn off caching for the information pages.',16,11,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (155,'Enable automatic redirects?','USE_SEO_REDIRECT','true','This will activate the automatic redirect code and send 301 headers for old to new URLs.',16,12,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (156,'Choose URL Rewrite Type','SEO_REWRITE_TYPE','Rewrite','Choose which SEO URL format to use.',16,13,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'Rewrite\'),');
INSERT INTO configuration VALUES (157,'Enter special character conversions','SEO_CHAR_CONVERT_SET','ä=>ae,ö=>oe,ü=>ue,Ä=>Ae,Ö=>Oe,Ü=>Ue,ß=>ss,é=>e,è=>e,à=>a,É=>E','This setting will convert characters.<br><br>The format <b>MUST</b> be in the form: <b>char=>conv,char2=>conv2</b>',16,14,'2007-11-06 19:48:17','2007-06-12 23:21:07',NULL,NULL);
INSERT INTO configuration VALUES (158,'Remove all non-alphanumeric characters?','SEO_REMOVE_ALL_SPEC_CHARS','false','This will remove all non-letters and non-numbers.  This should be handy to remove all special characters with 1 setting.',16,15,'2007-06-12 23:21:07','2007-06-12 23:21:07',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (159,'Reset SEO URLs Cache','SEO_URLS_CACHE_RESET','false','This will reset the cache data for SEO',16,16,'2007-06-12 23:31:15','2007-06-12 23:21:07','tep_reset_cache_data_seo_urls','tep_cfg_select_option(array(\'reset\', \'false\'),');
INSERT INTO configuration VALUES (160,'Installed Modules','MODULE_STS_INSTALLED','sts_default.php;sts_product_info.php','This is automatically updated. No need to edit.',6,0,'2007-11-07 21:06:16','2007-06-13 16:11:39',NULL,NULL);
INSERT INTO configuration VALUES (169,'Code for debug output','MODULE_STS_DEBUG_CODE','debug','Code to enable debug output from URL (ex: index.php?sts_debug=debug',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL);
INSERT INTO configuration VALUES (170,'Files for normal template','MODULE_STS_DEFAULT_NORMAL','sts_user_code.php;headertags.php','Files to include for a normal template, separated by semicolon',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL);
INSERT INTO configuration VALUES (171,'Base folder','MODULE_STS_TEMPLATES_FOLDER','includes/sts_templates/','Base folder where the templates folders are located. Relative to your catalog folder. Should end with a slash',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL);
INSERT INTO configuration VALUES (172,'Template folder','MODULE_STS_TEMPLATE_FOLDER','swisscart','This is the template folder in use, located inside the previous parameter. Do not start nor end with a slash',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL);
INSERT INTO configuration VALUES (173,'Default template file','MODULE_STS_TEMPLATE_FILE','sts_template.html','Name of the default template file',6,2,NULL,'2007-06-13 16:12:04',NULL,NULL);
INSERT INTO configuration VALUES (174,'Use template for infoboxes','MODULE_STS_INFOBOX_STATUS','true','Do you want to use templates for infoboxes?',6,1,NULL,'2007-06-13 16:12:04',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (168,'Use Templates?','MODULE_STS_DEFAULT_STATUS','true','Do you want to use Simple Template System?',6,1,NULL,'2007-06-13 16:12:04',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (185,'Use template for product info page','MODULE_STS_PRODUCT_INFO_STATUS','false','Do you want to use templates for product info pages?',6,1,NULL,'2007-07-07 03:33:35',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (189,'Lightbox Popup Images','LIGHTBOX_ENABLE','true','Lightbox is a simple, unobtrusive script used to overlay images on the product detail page.',4,10,'2007-12-11 02:20:47','2007-07-07 03:59:26',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (188,'Files for content template','MODULE_STS_PRODUCT_INFO_CONTENT','sts_user_code.php;product_info.php;headertags.php','Files to include for a content template, separated by semicolon',6,3,NULL,'2007-07-07 03:33:35',NULL,NULL);
INSERT INTO configuration VALUES (186,'Enable STS3 compatibility mode','MODULE_STS_PRODUCT_V3COMPAT','false','Do you want to enable the STS v3 compatibility mode (only for product info templates made with STS v2 and v3)?',6,1,NULL,'2007-07-07 03:33:35',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (187,'Files for normal template','MODULE_STS_PRODUCT_INFO_NORMAL','sts_user_code.php;headertags.php','Files to include for a normal template, separated by semicolon',6,2,NULL,'2007-07-07 03:33:35',NULL,NULL);
INSERT INTO configuration VALUES (190,'Info-Seiten-ID der AGBs','CONDITIONS_INFOID','7','Setzen Sie hier die Seiten-ID der Allgemeinen Geschäftsbedingungen im Info-Manager ein. Der Text wird dann im Checkout automatisch eingebunden.',1,30,NULL,'2007-07-28 06:07:18',NULL,NULL);
INSERT INTO configuration VALUES (191,'Product Information Image Width','PRODUCT_INFO_IMAGE_WIDTH','350','The pixel width of images shown on your product information page',4,100,'2007-11-05 04:51:30','2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (192,'Product Information Image Height','PRODUCT_INFO_IMAGE_HEIGHT','','The pixel height of images shown on your product information page',4,101,'2007-08-01 22:33:11','2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (193,'Image Magic Master Switch','CFG_MASTER_SWITCH','On','Switch OSC Image Magic on or off',333,3,'2007-08-01 19:15:53','2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'On\', \'Off\'),');
INSERT INTO configuration VALUES (194,'Apply security features to registered customers','CFG_REGISTERED_WATERMARKS','Yes','If this option is set to no, all image security features will be disabled when a registered customer is browsing your site',333,4,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (195,'Help support the OSC Image Magic Project','','Make a donation','Reward the author & support future releases. Please click the button below to make a donation<p><a href=\"http://www.celtware.com/im/donate.php?ref=6350088749406942\"><img src=\"http://www.celtware.com/im/donate.php?ref=img6350088749406942\" border=\"0\"></a>',333,-1,'2005-10-03 03:08:38','1899-12-29 00:00:00','','tep_cfg_readonly(');
INSERT INTO configuration VALUES (196,'Process Store\'s Graphics','CFG_PROCESS_GRAPHICS','False','If this is set to true, ALL store graphics will be processed and cached, including buttons, clip art etc. The default, recommended setting for this is False',333,6,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (197,'Auto Clean Cache','CFG_CACHE_AUTO_CLEAN','True','If selected, the cache will automatically be cleared of un-needed items. Set to true if you want to sacrifice a small amount of performance for server disk space saving',333,9,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (198,'Encrypt Image Filenames','CFG_ENCRYPT_FILENAMES','False','If you select this option all of your filenames will be encrypted. This option will prevent visitors from discovering your image filenames. Use it in combination with image watermarking to prevent theft of your images.',333,12,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (199,'Filename Encryption Key','CFG_ENCRYPTION_KEY','changeme','If you have switched on image filename encryption, then enter a string here to be used as the encryption key',333,15,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (200,'Apply Internet Explorer PNG Transparency work-around?','CFG_PNG_BUG','False','This option will switch on a work-around so that PNG alpha transparency images will display correctly in Internet Explorer<br><b>Note:</b> Two files need to be modified to enable this - See readme.',333,18,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (201,'Use Resampling','CFG_USE_RESAMPLING','True','If selected, thumbnails will be resampled rather than resized. Resampling creates much higher quality thumbnails.',333,21,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (202,'Create Truecolour Thumbnails','CFG_CREATE_TRUECOLOR','True','Create True color Thumbnails? Better quality overall but set to false if you have GD version < 2.01 or if creating transparent thumbnails.',333,24,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (203,'Output GIFs as JPEGs','CFG_GIFS_AS_JPEGS','False','Set this option true if you have GD version > 1.6 and want to output GIFs as JPGs. Note that transparencies will not be retained (set matte colour below). If you have GD Library < 1.6 with GIF create support, GIFs will be output as GIFs.',333,27,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (204,'\'GIF as JPEG\' Matte colour (HEX)','CFG_MATTE_COLOR','FFFFFF','Enter the HEX colour value that transparent backgrounds will be converted to if GIFs output as JPGs',333,28,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (205,'Cache Thumbnails on the Server','CFG_TN_SERVER_CACHE','True','Set to true if you want to cache previously processed thumbnails on disk. This will add to disk space but will save your processor from having to create a new thumbnail for every visitor. (recommended)',333,30,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (206,'Cache Thumbnails in user\'s browser','CFG_TN_BROWSER_CACHE','True','Set to true if you want browsers to be able to cache viewed thumbnails in their own cache. This will save bandwidth for every visitor that views the same thumbnail again. (recommended)',333,31,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (207,'Thumbnail Cache directory','CFG_TN_CACHE_DIRECTORY','images/thumbnails','Directory where cached thumbnails will be stored. <br><b>Note:</b> This directory should be automatically created, if not, do so manually and chmod it to 777',333,33,'2007-08-01 18:38:19','2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (208,'Use 404 Response if image not found?','CFG_USE_404','True','If set to true a 404 (not found) response will be sent (broken image), otherwise a small error picture will be shown',333,36,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (209,'Allow thumbnails larger than original','CFG_ALLOW_LARGER','False','Set to true if you want to allow scaling UP of source image files.',333,45,'2007-11-04 13:41:32','2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (210,'Center if thumbnail larger than original','CFG_CENTER_THUMB','False','If your source is smaller than the thumbnail, should it be centered on the larger thumbnail rather than resized?<br><b>Note:</b> \'Allow thumbnails larger than original\' (above) must be set to true',333,46,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (211,'JPEG Quality - Pop-up Images','POPUP_JPEG_QUALITY','100','The output quality of JPEG pop-up images.',333,48,NULL,'2005-01-06 20:24:30',NULL,NULL);
INSERT INTO configuration VALUES (212,'JPEG Quality - Product Information Thumbnails','PRODUCT_JPEG_QUALITY','100','The output quality of JPEG thumbnails displayed on your product information page',333,51,NULL,'2005-01-06 20:24:30',NULL,NULL);
INSERT INTO configuration VALUES (213,'JPEG Quality - Category Thumbnails','CATEGORY_JPEG_QUALITY','100','The output quality of category JPEG thumbnails',333,52,NULL,'2005-01-06 20:24:30',NULL,NULL);
INSERT INTO configuration VALUES (214,'JPEG Quality - Heading Thumbnails','HEADING_JPEG_QUALITY','100','The output quality of heading JPEG thumbnails',333,53,NULL,'2005-01-06 20:24:30',NULL,NULL);
INSERT INTO configuration VALUES (215,'JPEG Quality - Small Thumbnails','SMALL_JPEG_QUALITY','100','The output quality of your small sized JPEG thumbnails',333,55,NULL,'2005-01-06 20:24:30',NULL,NULL);
INSERT INTO configuration VALUES (216,'Graphic Watermark in Pop-up Images','USE_WATERMARK_IMAGE_POPUP','No','Do you wish to use a watermark image in your pop-up product image?<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images',333,57,'2007-08-01 19:43:12','2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (217,'Graphic Watermark in Product Information Thumbnails','USE_WATERMARK_IMAGE_PRODUCT','No','Do you wish to use a watermark image in your product information thumbnails?<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images',333,58,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (218,'Graphic Watermark in Category Thumbnails','USE_WATERMARK_IMAGE_CATEGORY','No','Do you wish to use a watermark image in your category thumbnails?<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images',333,59,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (219,'Graphic Watermark in Heading Thumbnails','USE_WATERMARK_IMAGE_HEADING','No','Do you wish to use a watermark image in your heading thumbnails?<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images',333,60,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (220,'Graphic Watermark in Small Thumbnails','USE_WATERMARK_IMAGE_SMALL','No','Do you wish to use a watermark image in your small thumbnails<br><b>Note:</b>Graphic Watermarks will NOT be added to GIF images?',333,61,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (221,'Watermark Image File','WATERMARK_IMAGE','logo.png','Select which watermark image you wish to use<br><br>New watermark images may be installed in your:<br><b>/catalog/includes/imagemagic/watermarks/</b><br>directory<br>',333,66,'2007-08-01 19:41:04','2005-01-06 20:24:30',NULL,'tep_cfg_pull_down_installed_watermarks(');
INSERT INTO configuration VALUES (222,'Image Watermark Transparency','WATERMARK_IMAGE_OPACITY','80','Enter a value of 0 to 100 to set the opacity value of your watermark image (0=transparent, 100=opaque)',333,69,'2007-12-11 03:58:22','2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (223,'Image Watermark Position','WATERMARK_IMAGE_POSITION','Top','Select where you would like your watermark image to be positioned on your thumbnail',333,71,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_pull_down_watermark_alignment(');
INSERT INTO configuration VALUES (224,'Image Watermark Margin','WATERMARK_IMAGE_MARGIN','0','Enter the offset in pixels where you would like your watermark image to be positioned',333,72,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (225,'Resize Watermark Image','CFG_RESIZE_WATERMARK','True','If selected, your watermark image will be resized in the same ratio as your source image, otherwise the watermark image will always be added full-sized',333,73,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (226,'Text Watermark in Pop-up Images','USE_WATERMARK_TEXT_POPUP','Yes','Do you wish to use watermark text in your pop-up product images?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,75,'2007-08-01 19:36:36','2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (227,'Text Watermark in Product Information Thumbnails','USE_WATERMARK_TEXT_PRODUCT','No','Do you wish to use watermark text in your product information thumbnails?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,76,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (228,'Text Watermark in Category Thumbnails','USE_WATERMARK_TEXT_CATEGORY','No','Do you wish to use watermark text in your category thumbnails?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,77,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (229,'Text Watermark in Heading Thumbnails','USE_WATERMARK_TEXT_HEADING','No','Do you wish to use watermark text in your heading thumbnails?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,78,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (230,'Text Watermark in Small Thumbnails','USE_WATERMARK_TEXT_SMALL','No','Do you wish to use watermark text in your small thumbnails?<br><b>Note:</b>Text Watermarks do not work well with GIF images',333,79,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (231,'Watermark Text','WATERMARK_TEXT','SWISSCART','Enter the text you wish to appear in your thumbnails as a watermark',333,84,'2007-12-11 04:07:40','2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (232,'Text Watermark Font Name','WATERMARK_TEXT_FONT','arial.ttf','Select the font filename you wish to use for watermark text<br><br>New TTF fonts may be installed in your:<br><b>/catalog/includes/imagemagic/fonts/</b><br>directory<br>',333,87,'2007-12-11 04:05:55','2005-01-06 20:24:30',NULL,'tep_cfg_pull_down_installed_fonts(');
INSERT INTO configuration VALUES (233,'Text Watermark Size','WATERMARK_TEXT_SIZE','30','Enter the font point size of your text watermark',333,90,'2007-12-11 04:07:02','2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (234,'Text Watermark Colour (HEX)','WATERMARK_TEXT_COLOR','000000','Enter the hex value for the colour of your text watermark',333,93,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (235,'Text Watermark Transparency','WATERMARK_TEXT_OPACITY','7','Enter a value of 0 to 100 to set the transparency value of your watermark text (0=transparent, 100=opaque)',333,96,'2007-12-11 04:07:12','2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (236,'Text Watermark Position','WATERMARK_TEXT_POSITION','Bottom Left','Select where you would like your watermark text to be positioned on your thumbnails',333,99,'2007-12-11 04:05:29','2005-01-06 20:24:30',NULL,'tep_cfg_pull_down_watermark_alignment(');
INSERT INTO configuration VALUES (237,'Text Watermark Margin','WATERMARK_TEXT_MARGIN','0','Enter the offset in pixels where you would like your watermark text to be positioned',333,102,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (238,'Text Watermark Angle','WATERMARK_TEXT_ANGLE','90','Enter the counter-clockwise angle of the text watermark',333,105,'2007-12-11 04:04:54','2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (239,'Auto Adjust Brightness','BRIGHTNESS_ADJUST','0','Enter an amount between -255 and 255 which your thumbnail brightness will be adjusted by<br><b>Note:</b> This will not work with GIF images',333,108,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (240,'Auto Adjust Contrast','CONTRAST_ADJUST','0','Enter an amount between -255 and 255 which your thumbnail contrast will be adjusted by<br><b>Note:</b> This will not work with GIF images',333,111,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (241,'Frame Pop-up Images','FRAME_POPUP','No','Do you want to include a frame around your pop-up product images?',333,114,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (242,'Frame Product Information Thumbnails','FRAME_PRODUCT','No','Do you want to include a frame around your product information thumbnails?',333,115,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (243,'Frame Category Thumbnails','FRAME_CATEGORY','No','Do you want to include a frame around your category thumbnails?',333,116,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (244,'Frame Heading Thumbnails','FRAME_HEADING','No','Do you want to include a frame around your heading thumbnails?',333,117,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (245,'Frame Small Thumbnails','FRAME_SMALL','No','Do you want to include a frame around your small thumbnails?',333,118,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (246,'Frame Width','FRAME_WIDTH','4','Enter the width in pixels of the thumbnail frame',333,120,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (247,'Frame Depth','FRAME_EDGE_WIDTH','4','Enter the 3D depth of the frame in pixels',333,123,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (248,'Frame Colour (HEX)','FRAME_COLOR','CCCCCC','Enter the HEX colour of the thumbnail frame',333,126,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (249,'Frame Inside 3D Highlight Colour (HEX)','FRAME_INSIDE_COLOR1','FFFFFF','Enter the colour (in hex) you wish the frame\'s inside higlight colour to be',333,129,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (250,'Frame Inside 3D Shadow Colour (HEX)','FRAME_INSIDE_COLOR2','000000','Enter the colour (in hex) you wish the frame\'s inside shadow colour to be',333,132,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (251,'Buttonize Pop-up Images','BEVEL_POPUP','No','Do you want to add a 3D button effect to your pop-up images?',333,133,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (252,'Buttonize Product Information Thumbnails','BEVEL_PRODUCT','No','Do you want to add a 3D button effect to your product information thumbnails?',333,134,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (253,'Buttonize Category Thumbnails','BEVEL_CATEGORY','No','Do you want to add a 3D button effect to your category thumbnails?',333,135,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (254,'Buttonize Heading Thumbnails','BEVEL_HEADING','No','Do you want to add a 3D button effect to your heading thumbnails?',333,136,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (255,'Buttonize Small Thumbnails','BEVEL_SMALL','No','Do you want to add a 3D button effect to your small thumbnails?',333,137,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_select_option(array(\'Yes\', \'No\'),');
INSERT INTO configuration VALUES (256,'Button Height','BEVEL_HEIGHT','4','Enter the height in pixels of the 3D button effect',333,144,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (257,'Button Highlight Colour (HEX)','BEVEL_HIGHLIGHT','CCCCCC','Enter the colour (in hex) you wish the button\'s higlight colour to be',333,147,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (258,'Button Shadow Colour (HEX)','BEVEL_SHADOW','000000','Enter the colour (in hex) you wish the button\'s shadow colour to be',333,150,NULL,'2005-01-06 20:24:30',NULL,'');
INSERT INTO configuration VALUES (259,'Last Hash (System Use - Read Only)','LAST_HASH','bec0f307fef7cc320d37f1e145e453d3','Stores the last hash value of the thumbnail configuration settings.  This will allow the script to detect when they have changed and maintain the cache.',333,153,NULL,'2005-01-06 20:24:30',NULL,'tep_cfg_readonly(');
INSERT INTO configuration VALUES (425,'Order Fee For Orders Under','MODULE_ORDER_TOTAL_LOWORDERFEE_ORDER_UNDER','50','Add the low order fee to orders under this amount.',6,4,NULL,'2007-12-04 03:38:38','currencies->format',NULL);
INSERT INTO configuration VALUES (426,'Order Fee','MODULE_ORDER_TOTAL_LOWORDERFEE_FEE','5','Low order fee.',6,5,NULL,'2007-12-04 03:38:38','currencies->format',NULL);
INSERT INTO configuration VALUES (412,'TinyMCE Theme (Display Mode)','TINYMCE_THEME','advanced','Simple will only give a couple of features for the text area fields, advanced will give a whole lot more of them, but will also take longer to load',17,1,'2007-12-28 20:32:37','2007-08-09 19:02:22',NULL,'tep_cfg_select_option(array(\'simple\', \'advanced\'),');
INSERT INTO configuration VALUES (411,'Heading Image Enabled','HEADING_IMAGE_ENABLED','false','Show the small image on the top right of every shop page?',4,3,'2007-08-15 00:02:40','2007-08-14 23:45:44',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (410,'Tariftabelle für Zone 5 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_7','0.5:92,1:106,1.5:121,2:135,2.5:149,3:164,3.5:178,4:193,4.5:207,5:221,6:241,7:261,8:280,9:300,10:319,11:338,12:356,13:375,14:393,15:412,16:431,17:449,18:468,19:486,20:505,21:522,22:540,23:557,24:575,25:592,26:610,27:627,28:645,29:662,30:680','Tarif Tabelle für die Zone 5, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (409,'Tariftabelle für Zone 5 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_7','2:65,3:83,4:101,5:119,6:136,7:153,8:170,9:187,10:204,11:219,12:234,13:249,14:264,15:279,16:294,17:309,18:324,19:339,20:354,21:367,22:380,23:393,24:406,25:419,26:432,27:445,28:458,29:471,30:484','Tarif Tabelle für die Zone 5, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (408,'Tariftabelle für Zone 5 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_7','2:47,3:55,4:63,5:71,6:79,7:87,8:95,9:103,10:111,11:118,12:125,13:132,14:139,15:146,16:152,17:160,18:166,19:172,20:178,21:184,22:190,23:196,24:202,25:206,26:211,27:216,28:221,29:226,30:231','Tarif Tabelle für die Zone 5, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (407,'Tarifzone 5 Länder','MODULE_SHIPPING_CHP_COUNTRIES_7','AR,AW,AU,BO,BR,BN,CL,CO,CK,EC,FK,FJ,GF,PF,GY,ID,KI,NR,AN,NC,NZ,NF,PG,PY,PE,PH,PN,WS,SB,SR,TP,TO,TT,TV,UY,VU,VE,WF','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 5 sind.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (406,'Tariftabelle für Zone 4 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_6','0.5:83,1:96,1.5:108,2:121,2.5:133,3:145,3.5:158,4:170,4.5:182,5:195,6:214,7:234,8:253,9:273,10:293,11:311,12:330,13:348,14:367,15:385,16:404,17:422,18:441,19:459,20:478,21:495,22:513,23:530,24:548,25:565,26:583,27:600,28:618,29:636,30:653','Tarif Tabelle für die Zone 4, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (404,'Tariftabelle für Zone 4 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_6','2:43,3:50,4:57,5:64,6:71,7:78,8:85,9:92,10:99,11:104,12:109,13:114,14:119,15:124,16:129,17:134,18:139,19:144,20:149,21:153,22:157,23:161,24:165,25:169,26:173,27:177,28:181,29:185,30:189','Tarif Tabelle für die Zone 4, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (405,'Tariftabelle für Zone 4 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_6','2:53,3:67,4:80,5:94,6:107,7:120,8:133,9:146,10:159,11:167,12:177,13:187,14:197,15:207,16:215,17:223,18:231,19:239,20:247,21:255,22:263,23:271,24:279,25:287,26:295,27:303,28:311,29:319,30:327','Tarif Tabelle für die Zone 4, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (403,'Tarifzone 4 Länder','MODULE_SHIPPING_CHP_COUNTRIES_6','LR,MO,MG,MW,MY,MV,ML,MQ,MR,MU,YT,MX,MN,MS,MZ,MM,NA,NP,NI,NE,NG,OM,PK,PA,QA,RE,RW,KN,LC,VC,SH,ZM,SM,ST,SA,SN,SC,SL,SG,SO,ZA,LK,SD,SZ,TW,TJ,TZ,TH,TG,TM,TC,UG,AE,UZ,VN,VG,VI,ZW','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 4 sind.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (402,'Tariftabelle für Zone 4 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_5','0.5:83,1:96,1.5:108,2:121,2.5:133,3:145,3.5:158,4:170,4.5:182,5:195,6:214,7:234,8:253,9:273,10:293,11:311,12:330,13:348,14:367,15:385,16:404,17:422,18:441,19:459,20:478,21:495,22:513,23:530,24:548,25:565,26:583,27:600,28:618,29:636,30:653','Tarif Tabelle für die Zone 4, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (401,'Tariftabelle für Zone 4 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_5','2:53,3:67,4:80,5:94,6:107,7:120,8:133,9:146,10:159,11:167,12:177,13:187,14:197,15:207,16:215,17:223,18:231,19:239,20:247,21:255,22:263,23:271,24:279,25:287,26:295,27:303,28:311,29:319,30:327','Tarif Tabelle für die Zone 4, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (400,'Tariftabelle für Zone 4 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_5','2:43,3:50,4:57,5:64,6:71,7:78,8:85,9:92,10:99,11:104,12:109,13:114,14:119,15:124,16:129,17:134,18:139,19:144,20:149,21:153,22:157,23:161,24:165,25:169,26:173,27:177,28:181,29:185,30:189','Tarif Tabelle für die Zone 4, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (399,'Tarifzone 4 Länder','MODULE_SHIPPING_CHP_COUNTRIES_5','AF,AO,AI,AG,AM,AZ,BS,BH,BD,BB,BZ,BJ,BM,BT,BW,BF,BI,KY,KH,CM,CV,CF,TD,CN,KM,CG,CR,CI,CU,DJ,DM,DO,SV,GQ,ER,ET,GA,GM,GE,GH,GD,GP,GT,GN,GW,HT,HN,HK,IN,IR,IQ,JM,JP,YE,KZ,KE,KP,KR,KW,KG,LA,LS','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 4 sind.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (398,'Tariftabelle für Zone 3 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_4','0.5:65,1:72,1.5:79,2:87,2.5:94,3:101,3.5:108,4:115,4.5:123,5:130,6:141,7:152,8:164,9:175,10:186,11:198,12:209,13:220,14:232,15:243,16:254,17:266,18:277,19:288,20:300,21:309,22:318,23:328,24:337,25:346,26:355,27:365,28:374,29:383,30:392','Tarif Tabelle für die Zone 3, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (397,'Tariftabelle für Zone 3 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_4','2:46,3:55,4:66,5:77,6:86,7:95,8:104,9:113,10:122,11:130,12:138,13:146,14:154,15:162,16:170,17:178,18:186,19:194,20:202,21:209,22:216,23:223,24:230,25:237,26:244,27:251,28:258,29:265,30:272','Tarif Tabelle für die Zone 3, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (396,'Tariftabelle für Zone 3 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_4','2:38,3:44,4:50,5:56,6:62,7:68,8:74,9:80,10:86,11:92,12:98,13:104,14:110,15:116,16:121,17:126,18:131,19:136,20:141,21:145,22:149,23:153,24:157,25:161,26:165,27:169,28:173,29:177,30:181','Tarif Tabelle für die Zone 3, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (395,'Tarifzone 3 Länder','MODULE_SHIPPING_CHP_COUNTRIES_4','DZ,BY,CA,CY,EG,IL,JO,LB,LY,MD,MA,RU,PM,SY,TN,TR,UA,US','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 3 sind.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (394,'Tariftabelle für Zone 2 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_3','0.5:57,1:63,1.5:68,2:73,2.5:78,3:84,3.5:90,4:95,4.5:100,5:106,6:114,7:124,8:132,9:141,10:149,11:158,12:165,13:172,14:180,15:187,16:196,17:203,18:210,19:218,20:226,21:234,22:241,23:248,24:256,25:264,26:272,27:279,28:286,29:295,30:302','Tarif Tabelle für die Zone 2, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (393,'Tariftabelle für Zone 2 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_3','2:38,3:43,4:48,5:53,6:58,7:62,8:66,9:68,10:71,11:75,12:78,13:81,14:84,15:87,16:90,17:91,18:92,19:93,20:94,21:95,22:96,23:97,24:98,25:99,26:100,27:101,28:102,29:103,30:104','Tarif Tabelle für die Zone 2, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (392,'Tariftabelle für Zone 2 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_3','2:34,3:38,4:42,5:46,6:49,7:52,8:55,9:58,10:61,11:63,12:65,13:67,14:69,15:71,16:72,17:73,18:74,19:75,20:76,21:77,22:78,23:79,24:80,25:81,26:82,27:83,28:84,29:85,30:86','Tarif Tabelle für die Zone 2, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (391,'Tarifzone 2 Länder','MODULE_SHIPPING_CHP_COUNTRIES_3','AL,BA,BG,HR,CZ,DK,EE,FI,GI,GR,HU,IS,IE,LV,LT,MK,MT,MH,NO,PL,PT,RO,SK,SI,ES,SE,GB,YU','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 2 sind.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (389,'Tariftabelle für Zone 1 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_2','2:33,3:37,4:41,5:46,6:49,7:51,8:53,9:55,10:57,11:60,12:61,13:62,14:63,15:64,16:65,17:66,18:67,19:68,20:69,21:70,22:71,23:72,24:73,25:74,26:75,27:76,28:77,29:78,30:79','Tarif Tabelle für die Zone 1, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (390,'Tariftabelle für Zone 1 bis 30 kg URG','MODULE_SHIPPING_CHP_COST_URG_2','0.5:51,1:57,1.5:62,2:67,2.5:72,3:78,3.5:83,4:89,4.5:95,5:100,6:107,7:115,8:123,9:130,10:138,11:144,12:151,13:158,14:164,15:171,16:177,17:184,18:191,19:197,20:204,21:210,22:217,23:224,24:230,25:237,26:243,27:250,28:256,29:263,30:269','Tarif Tabelle für die Zone 1, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (435,'Product description teaser length','PRODUCT_LIST_TEASER_LENGTH','100','Product description teaser length',8,31,'2007-12-28 18:36:07','2007-12-28 18:23:37',NULL,NULL);
INSERT INTO configuration VALUES (433,'Store Logo','STORE_LOGO','swisscart.gif','Bitte laden Sie das Logo mit dem Datei-Manager (Hilfsprogramme) in den images-Ordner',1,2,NULL,'2007-12-13 16:56:51',NULL,NULL);
INSERT INTO configuration VALUES (434,'Enable product description teaser','PRODUCT_LIST_TEASER_ENABLED','true','Show product description in product listing view',8,30,'2007-12-28 18:29:36','2007-12-28 18:20:37',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (324,'Schweizerische Post - Brief Inland','MODULE_SHIPPING_CHPLET_STATUS','True','Wollen Sie die Versandart Brief Inland via Schweizerische Post anbieten?',6,0,NULL,'2007-08-13 22:37:23',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (325,'Handling Fee','MODULE_SHIPPING_CHPLET_HANDLING','0','Bearbeitungsgebühr für diese Versandart in CHF',6,0,NULL,'2007-08-13 22:37:23',NULL,NULL);
INSERT INTO configuration VALUES (326,'Steuersatz','MODULE_SHIPPING_CHPLET_TAX_CLASS','0','Wählen Sie den MwSt.-Satz für diese Versandart aus.',6,0,NULL,'2007-08-13 22:37:23','tep_get_tax_class_title','tep_cfg_pull_down_tax_classes(');
INSERT INTO configuration VALUES (327,'Versand Zone','MODULE_SHIPPING_CHPLET_ZONE','1','Wenn Sie eine Zone auswählen, wird diese Versandart nur in dieser Zone angeboten.',6,0,NULL,'2007-08-13 22:37:23','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes(');
INSERT INTO configuration VALUES (328,'Reihenfolge der Anzeige','MODULE_SHIPPING_CHPLET_SORT_ORDER','5','Niedrigste wird zuerst angezeigt.',6,0,NULL,'2007-08-13 22:37:23',NULL,NULL);
INSERT INTO configuration VALUES (329,'Zone Inland','MODULE_SHIPPING_CHPLET_COUNTRIES_1','CH','Inlandszone',6,0,NULL,'2007-08-13 22:37:23',NULL,NULL);
INSERT INTO configuration VALUES (330,'Zone Tarif Tabelle bis 2 kg','MODULE_SHIPPING_CHPLET_COST_1','0.1:0.85,0.25:1.10,0.5:1.80,1:4.50','Tarif Tabelle für die Inlandszone, Brief bis 2 kg Versandgewicht.',6,0,NULL,'2007-08-13 22:37:23',NULL,NULL);
INSERT INTO configuration VALUES (331,'Schweizerische Post - Brief Inland','MODULE_SHIPPING_CHPLETINPRI_STATUS','True','Wollen Sie die Versandart Brief Inland via Schweizerische Post anbieten?',6,0,NULL,'2007-08-13 23:33:13',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (332,'Handling Fee','MODULE_SHIPPING_CHPLETINPRI_HANDLING','0','Bearbeitungsgebühr für diese Versandart in CHF',6,0,NULL,'2007-08-13 23:33:13',NULL,NULL);
INSERT INTO configuration VALUES (333,'Steuersatz','MODULE_SHIPPING_CHPLETINPRI_TAX_CLASS','0','Wählen Sie den MwSt.-Satz für diese Versandart aus.',6,0,NULL,'2007-08-13 23:33:13','tep_get_tax_class_title','tep_cfg_pull_down_tax_classes(');
INSERT INTO configuration VALUES (334,'Versand Zone','MODULE_SHIPPING_CHPLETINPRI_ZONE','1','Wenn Sie eine Zone auswählen, wird diese Versandart nur in dieser Zone angeboten.',6,0,NULL,'2007-08-13 23:33:13','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes(');
INSERT INTO configuration VALUES (335,'Reihenfolge der Anzeige','MODULE_SHIPPING_CHPLETINPRI_SORT_ORDER','10','Niedrigste wird zuerst angezeigt.',6,0,NULL,'2007-08-13 23:33:13',NULL,NULL);
INSERT INTO configuration VALUES (336,'Zone Inland','MODULE_SHIPPING_CHPLETINPRI_COUNTRIES_1','CH','Inlandszone',6,0,NULL,'2007-08-13 23:33:13',NULL,NULL);
INSERT INTO configuration VALUES (337,'Zone Tarif Tabelle bis 1 kg','MODULE_SHIPPING_CHPLETINPRI_COST_1','0.10:1,0.25:1.30,0.5:2.20,1.0:5.0','Tarif Tabelle für die Inlandszone, Brief bis 1 kg Versandgewicht.',6,0,NULL,'2007-08-13 23:33:13',NULL,NULL);
INSERT INTO configuration VALUES (430,'Popup Image Height','POPUP_IMAGE_HEIGHT','','Maximum height of the popup image',4,201,'2007-12-11 03:55:22','2007-12-11 01:54:15',NULL,NULL);
INSERT INTO configuration VALUES (428,'Tax Class','MODULE_ORDER_TOTAL_LOWORDERFEE_TAX_CLASS','0','Use the following tax class on the low order fee.',6,7,NULL,'2007-12-04 03:38:38','tep_get_tax_class_title','tep_cfg_pull_down_tax_classes(');
INSERT INTO configuration VALUES (429,'Popup Image Width','POPUP_IMAGE_WIDTH','700','Maximum width of the popup image',4,200,'2007-12-11 03:56:32','2007-12-11 01:53:39',NULL,NULL);
INSERT INTO configuration VALUES (427,'Attach Low Order Fee On Orders Made','MODULE_ORDER_TOTAL_LOWORDERFEE_DESTINATION','both','Attach low order fee for orders sent to the set destination.',6,6,NULL,'2007-12-04 03:38:38',NULL,'tep_cfg_select_option(array(\'national\', \'international\', \'both\'),');
INSERT INTO configuration VALUES (423,'Sort Order','MODULE_ORDER_TOTAL_LOWORDERFEE_SORT_ORDER','4','Sort order of display.',6,2,NULL,'2007-12-04 03:38:38',NULL,NULL);
INSERT INTO configuration VALUES (424,'Allow Low Order Fee','MODULE_ORDER_TOTAL_LOWORDERFEE_LOW_ORDER_FEE','false','Do you want to allow low order fees?',6,3,NULL,'2007-12-04 03:38:38',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (422,'Display Low Order Fee','MODULE_ORDER_TOTAL_LOWORDERFEE_STATUS','true','Do you want to display the low order fee?',6,1,NULL,'2007-12-04 03:38:38',NULL,'tep_cfg_select_option(array(\'true\', \'false\'),');
INSERT INTO configuration VALUES (388,'Tariftabelle für Zone 1 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_2','2:29,3:32,4:35,5:38,6:39,7:40,8:41,9:42,10:43,11:44,12:45,13:46,14:47,15:48,16:49,17:50,18:51,19:52,20:53,21:54,22:55,23:56,24:57,25:58,26:59,27:60,28:61,29:62,30:63','Tarif Tabelle für die Zone 1, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (379,'Schweizerische Post','MODULE_SHIPPING_CHP_STATUS','True','Wollen Sie den Versand über die schweizerische Post anbieten?',6,0,NULL,'2007-08-14 00:22:47',NULL,'tep_cfg_select_option(array(\'True\', \'False\'),');
INSERT INTO configuration VALUES (380,'Handling Fee','MODULE_SHIPPING_CHP_HANDLING','0','Bearbeitungsgebühr für diese Versandart in CHF',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (381,'Steuersatz','MODULE_SHIPPING_CHP_TAX_CLASS','0','Wählen Sie den MwSt.-Satz für diese Versandart aus.',6,0,NULL,'2007-08-14 00:22:47','tep_get_tax_class_title','tep_cfg_pull_down_tax_classes(');
INSERT INTO configuration VALUES (382,'Versand Zone','MODULE_SHIPPING_CHP_ZONE','0','Wenn Sie eine Zone auswählen, wird diese Versandart nur in dieser Zone angeboten.',6,0,NULL,'2007-08-14 00:22:47','tep_get_zone_class_title','tep_cfg_pull_down_zone_classes(');
INSERT INTO configuration VALUES (383,'Reihenfolge der Anzeige','MODULE_SHIPPING_CHP_SORT_ORDER','0','Niedrigste wird zuerst angezeigt.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (384,'Tarifzone 0 Länder','MODULE_SHIPPING_CHP_COUNTRIES_1','CH,LI','Inlandszone',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (385,'Tariftabelle für Zone 0 bis 30 kg ECO','MODULE_SHIPPING_CHP_COST_ECO_1','2:6.00,5:8.00,10:11.00,20:16.00,30:23.00','Tarif Tabelle für die Inlandszone, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (386,'Tariftabelle für Zone 0 bis 30 kg PRI','MODULE_SHIPPING_CHP_COST_PRI_1','2:8.00,5:10.00,10:13.00,20:19.00,30:26.00','Tarif Tabelle für die Inlandszone, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (387,'Tarifzone 1 Länder','MODULE_SHIPPING_CHP_COUNTRIES_2','AD,AT,BE,FR,DE,VA,IT,LU,MC,NL','Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 1 sind.',6,0,NULL,'2007-08-14 00:22:47',NULL,NULL);
INSERT INTO configuration VALUES (437,'E-Mail-Signatur','EMAIL_SIGNATURE','Mit freundlichen Grüssen\r\nNick Weisser\r\n\r\nOpenstream Internet Solutions\r\nZürich, Switzerland\r\n\r\nPhone  +41 44 500 78 78\r\nFax    +41 44 500 78 79\r\nSkype  nick.weisser\r\n\r\nhttp://www.swisscart.com','Diese Signatur wird an alle Mails angehÃ¤ngt, die vom System verschickt werden, d.h. RegistrationsbestÃ¤tigung, BestellbestÃ¤tigung, StatusÃ¤nderungen, etc.',1,18,'2008-01-18 21:18:34','2008-01-18 20:55:19','','tep_cfg_textarea(');
INSERT INTO configuration VALUES (438,'Einkaufen ohne Konto','PURCHASE_WITHOUT_ACCOUNT','ja','D&uuml;rfen Kunden ohne Konto einkaufen?',5,10,'2008-01-23 16:31:05','2008-01-23 02:22:22',NULL,'tep_cfg_select_option(array(\'ja\', \'nein\'),');
INSERT INTO configuration VALUES (439,'Einkaufen ohne Konto Versandadresse','PURCHASE_WITHOUT_ACCOUNT_SEPARATE_SHIPPING','ja','D&uuml;rfen Kunden ohne Konto eine separate Versandadresse anlegen?',5,11,NULL,'2008-01-23 02:22:22',NULL,'tep_cfg_select_option(array(\'ja\', \'nein\'),');

--
-- Table structure for table `configuration_group`
--

DROP TABLE IF EXISTS configuration_group;
CREATE TABLE configuration_group (
  configuration_group_id int(11) NOT NULL auto_increment,
  configuration_group_title varchar(64) NOT NULL default '',
  configuration_group_description varchar(255) NOT NULL default '',
  sort_order int(5) default NULL,
  visible int(1) default '1',
  PRIMARY KEY  (configuration_group_id)
) TYPE=MyISAM;

--
-- Dumping data for table `configuration_group`
--

INSERT INTO configuration_group VALUES (1,'My Store','General information about my store',1,1);
INSERT INTO configuration_group VALUES (2,'Minimum Values','The minimum values for functions / data',2,1);
INSERT INTO configuration_group VALUES (3,'Maximum Values','The maximum values for functions / data',3,1);
INSERT INTO configuration_group VALUES (4,'Images','Image parameters',4,1);
INSERT INTO configuration_group VALUES (5,'Customer Details','Customer account configuration',5,1);
INSERT INTO configuration_group VALUES (6,'Module Options','Hidden from configuration',6,0);
INSERT INTO configuration_group VALUES (7,'Shipping/Packaging','Shipping options available at my store',7,1);
INSERT INTO configuration_group VALUES (8,'Product Listing','Product Listing    configuration options',8,1);
INSERT INTO configuration_group VALUES (9,'Stock','Stock configuration options',9,1);
INSERT INTO configuration_group VALUES (10,'Logging','Logging configuration options',10,1);
INSERT INTO configuration_group VALUES (11,'Cache','Caching configuration options',11,1);
INSERT INTO configuration_group VALUES (12,'E-Mail Options','General setting for E-Mail transport and HTML E-Mails',12,1);
INSERT INTO configuration_group VALUES (13,'Download','Downloadable products options',13,1);
INSERT INTO configuration_group VALUES (14,'GZip Compression','GZip compression options',14,1);
INSERT INTO configuration_group VALUES (15,'Sessions','Session options',15,1);
INSERT INTO configuration_group VALUES (16,'SEO URLs','Options for Ultimate SEO URLs by Chemo',16,1);
INSERT INTO configuration_group VALUES (333,'Image Magic','Configuration options for the OSC Image Magic contribution',17,1);
INSERT INTO configuration_group VALUES (17,'Miscellaneous','Various configuration settings',17,1);

--
-- Table structure for table `counter`
--

DROP TABLE IF EXISTS counter;
CREATE TABLE counter (
  startdate char(8) default NULL,
  counter int(12) default NULL
) TYPE=MyISAM;

--
-- Dumping data for table `counter`
--

INSERT INTO counter VALUES ('20070612',2745);

--
-- Table structure for table `counter_history`
--

DROP TABLE IF EXISTS counter_history;
CREATE TABLE counter_history (
  month char(8) default NULL,
  counter int(12) default NULL
) TYPE=MyISAM;

--
-- Dumping data for table `counter_history`
--


--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
  countries_id int(11) NOT NULL auto_increment,
  countries_name varchar(64) NOT NULL default '',
  countries_iso_code_2 char(2) NOT NULL default '',
  countries_iso_code_3 char(3) NOT NULL default '',
  address_format_id int(11) NOT NULL default '0',
  sorting int(3) NOT NULL default '0',
  PRIMARY KEY  (countries_id),
  KEY IDX_COUNTRIES_NAME (countries_name)
) TYPE=MyISAM;

--
-- Dumping data for table `countries`
--

INSERT INTO countries VALUES (1,'Afghanistan','AF','AFG',1,0);
INSERT INTO countries VALUES (2,'Albania','AL','ALB',1,0);
INSERT INTO countries VALUES (3,'Algeria','DZ','DZA',1,0);
INSERT INTO countries VALUES (4,'American Samoa','AS','ASM',1,0);
INSERT INTO countries VALUES (5,'Andorra','AD','AND',1,0);
INSERT INTO countries VALUES (6,'Angola','AO','AGO',1,0);
INSERT INTO countries VALUES (7,'Anguilla','AI','AIA',1,0);
INSERT INTO countries VALUES (8,'Antarctica','AQ','ATA',1,0);
INSERT INTO countries VALUES (9,'Antigua and Barbuda','AG','ATG',1,0);
INSERT INTO countries VALUES (10,'Argentina','AR','ARG',1,0);
INSERT INTO countries VALUES (11,'Armenia','AM','ARM',1,0);
INSERT INTO countries VALUES (12,'Aruba','AW','ABW',1,0);
INSERT INTO countries VALUES (13,'Australia','AU','AUS',1,0);
INSERT INTO countries VALUES (14,'Austria','AT','AUT',5,-6);
INSERT INTO countries VALUES (15,'Azerbaijan','AZ','AZE',1,0);
INSERT INTO countries VALUES (16,'Bahamas','BS','BHS',1,0);
INSERT INTO countries VALUES (17,'Bahrain','BH','BHR',1,0);
INSERT INTO countries VALUES (18,'Bangladesh','BD','BGD',1,0);
INSERT INTO countries VALUES (19,'Barbados','BB','BRB',1,0);
INSERT INTO countries VALUES (20,'Belarus','BY','BLR',1,0);
INSERT INTO countries VALUES (21,'Belgium','BE','BEL',1,0);
INSERT INTO countries VALUES (22,'Belize','BZ','BLZ',1,0);
INSERT INTO countries VALUES (23,'Benin','BJ','BEN',1,0);
INSERT INTO countries VALUES (24,'Bermuda','BM','BMU',1,0);
INSERT INTO countries VALUES (25,'Bhutan','BT','BTN',1,0);
INSERT INTO countries VALUES (26,'Bolivia','BO','BOL',1,0);
INSERT INTO countries VALUES (27,'Bosnia and Herzegowina','BA','BIH',1,0);
INSERT INTO countries VALUES (28,'Botswana','BW','BWA',1,0);
INSERT INTO countries VALUES (29,'Bouvet Island','BV','BVT',1,0);
INSERT INTO countries VALUES (30,'Brazil','BR','BRA',1,0);
INSERT INTO countries VALUES (31,'British Indian Ocean Territory','IO','IOT',1,0);
INSERT INTO countries VALUES (32,'Brunei Darussalam','BN','BRN',1,0);
INSERT INTO countries VALUES (33,'Bulgaria','BG','BGR',1,0);
INSERT INTO countries VALUES (34,'Burkina Faso','BF','BFA',1,0);
INSERT INTO countries VALUES (35,'Burundi','BI','BDI',1,0);
INSERT INTO countries VALUES (36,'Cambodia','KH','KHM',1,0);
INSERT INTO countries VALUES (37,'Cameroon','CM','CMR',1,0);
INSERT INTO countries VALUES (38,'Canada','CA','CAN',1,0);
INSERT INTO countries VALUES (39,'Cape Verde','CV','CPV',1,0);
INSERT INTO countries VALUES (40,'Cayman Islands','KY','CYM',1,0);
INSERT INTO countries VALUES (41,'Central African Republic','CF','CAF',1,0);
INSERT INTO countries VALUES (42,'Chad','TD','TCD',1,0);
INSERT INTO countries VALUES (43,'Chile','CL','CHL',1,0);
INSERT INTO countries VALUES (44,'China','CN','CHN',1,0);
INSERT INTO countries VALUES (45,'Christmas Island','CX','CXR',1,0);
INSERT INTO countries VALUES (46,'Cocos (Keeling) Islands','CC','CCK',1,0);
INSERT INTO countries VALUES (47,'Colombia','CO','COL',1,0);
INSERT INTO countries VALUES (48,'Comoros','KM','COM',1,0);
INSERT INTO countries VALUES (49,'Congo','CG','COG',1,0);
INSERT INTO countries VALUES (50,'Cook Islands','CK','COK',1,0);
INSERT INTO countries VALUES (51,'Costa Rica','CR','CRI',1,0);
INSERT INTO countries VALUES (52,'Cote D\'Ivoire','CI','CIV',1,0);
INSERT INTO countries VALUES (53,'Croatia','HR','HRV',1,0);
INSERT INTO countries VALUES (54,'Cuba','CU','CUB',1,0);
INSERT INTO countries VALUES (55,'Cyprus','CY','CYP',1,0);
INSERT INTO countries VALUES (56,'Czech Republic','CZ','CZE',1,0);
INSERT INTO countries VALUES (57,'Denmark','DK','DNK',1,0);
INSERT INTO countries VALUES (58,'Djibouti','DJ','DJI',1,0);
INSERT INTO countries VALUES (59,'Dominica','DM','DMA',1,0);
INSERT INTO countries VALUES (60,'Dominican Republic','DO','DOM',1,0);
INSERT INTO countries VALUES (61,'East Timor','TP','TMP',1,0);
INSERT INTO countries VALUES (62,'Ecuador','EC','ECU',1,0);
INSERT INTO countries VALUES (63,'Egypt','EG','EGY',1,0);
INSERT INTO countries VALUES (64,'El Salvador','SV','SLV',1,0);
INSERT INTO countries VALUES (65,'Equatorial Guinea','GQ','GNQ',1,0);
INSERT INTO countries VALUES (66,'Eritrea','ER','ERI',1,0);
INSERT INTO countries VALUES (67,'Estonia','EE','EST',1,0);
INSERT INTO countries VALUES (68,'Ethiopia','ET','ETH',1,0);
INSERT INTO countries VALUES (69,'Falkland Islands (Malvinas)','FK','FLK',1,0);
INSERT INTO countries VALUES (70,'Faroe Islands','FO','FRO',1,0);
INSERT INTO countries VALUES (71,'Fiji','FJ','FJI',1,0);
INSERT INTO countries VALUES (72,'Finland','FI','FIN',1,0);
INSERT INTO countries VALUES (73,'France','FR','FRA',1,-4);
INSERT INTO countries VALUES (74,'France, Metropolitan','FX','FXX',1,0);
INSERT INTO countries VALUES (75,'French Guiana','GF','GUF',1,0);
INSERT INTO countries VALUES (76,'French Polynesia','PF','PYF',1,0);
INSERT INTO countries VALUES (77,'French Southern Territories','TF','ATF',1,0);
INSERT INTO countries VALUES (78,'Gabon','GA','GAB',1,0);
INSERT INTO countries VALUES (79,'Gambia','GM','GMB',1,0);
INSERT INTO countries VALUES (80,'Georgia','GE','GEO',1,0);
INSERT INTO countries VALUES (81,'Germany','DE','DEU',5,-8);
INSERT INTO countries VALUES (82,'Ghana','GH','GHA',1,0);
INSERT INTO countries VALUES (83,'Gibraltar','GI','GIB',1,0);
INSERT INTO countries VALUES (84,'Greece','GR','GRC',1,0);
INSERT INTO countries VALUES (85,'Greenland','GL','GRL',1,0);
INSERT INTO countries VALUES (86,'Grenada','GD','GRD',1,0);
INSERT INTO countries VALUES (87,'Guadeloupe','GP','GLP',1,0);
INSERT INTO countries VALUES (88,'Guam','GU','GUM',1,0);
INSERT INTO countries VALUES (89,'Guatemala','GT','GTM',1,0);
INSERT INTO countries VALUES (90,'Guinea','GN','GIN',1,0);
INSERT INTO countries VALUES (91,'Guinea-bissau','GW','GNB',1,0);
INSERT INTO countries VALUES (92,'Guyana','GY','GUY',1,0);
INSERT INTO countries VALUES (93,'Haiti','HT','HTI',1,0);
INSERT INTO countries VALUES (94,'Heard and Mc Donald Islands','HM','HMD',1,0);
INSERT INTO countries VALUES (95,'Honduras','HN','HND',1,0);
INSERT INTO countries VALUES (96,'Hong Kong','HK','HKG',1,0);
INSERT INTO countries VALUES (97,'Hungary','HU','HUN',1,0);
INSERT INTO countries VALUES (98,'Iceland','IS','ISL',1,0);
INSERT INTO countries VALUES (99,'India','IN','IND',1,0);
INSERT INTO countries VALUES (100,'Indonesia','ID','IDN',1,0);
INSERT INTO countries VALUES (101,'Iran (Islamic Republic of)','IR','IRN',1,0);
INSERT INTO countries VALUES (102,'Iraq','IQ','IRQ',1,0);
INSERT INTO countries VALUES (103,'Ireland','IE','IRL',1,0);
INSERT INTO countries VALUES (104,'Israel','IL','ISR',1,0);
INSERT INTO countries VALUES (105,'Italy','IT','ITA',1,-2);
INSERT INTO countries VALUES (106,'Jamaica','JM','JAM',1,0);
INSERT INTO countries VALUES (107,'Japan','JP','JPN',1,0);
INSERT INTO countries VALUES (108,'Jordan','JO','JOR',1,0);
INSERT INTO countries VALUES (109,'Kazakhstan','KZ','KAZ',1,0);
INSERT INTO countries VALUES (110,'Kenya','KE','KEN',1,0);
INSERT INTO countries VALUES (111,'Kiribati','KI','KIR',1,0);
INSERT INTO countries VALUES (112,'Korea, Democratic People\'s Republic of','KP','PRK',1,0);
INSERT INTO countries VALUES (113,'Korea, Republic of','KR','KOR',1,0);
INSERT INTO countries VALUES (114,'Kuwait','KW','KWT',1,0);
INSERT INTO countries VALUES (115,'Kyrgyzstan','KG','KGZ',1,0);
INSERT INTO countries VALUES (116,'Lao People\'s Democratic Republic','LA','LAO',1,0);
INSERT INTO countries VALUES (117,'Latvia','LV','LVA',1,0);
INSERT INTO countries VALUES (118,'Lebanon','LB','LBN',1,0);
INSERT INTO countries VALUES (119,'Lesotho','LS','LSO',1,0);
INSERT INTO countries VALUES (120,'Liberia','LR','LBR',1,0);
INSERT INTO countries VALUES (121,'Libyan Arab Jamahiriya','LY','LBY',1,0);
INSERT INTO countries VALUES (122,'Liechtenstein','LI','LIE',1,0);
INSERT INTO countries VALUES (123,'Lithuania','LT','LTU',1,0);
INSERT INTO countries VALUES (124,'Luxembourg','LU','LUX',1,0);
INSERT INTO countries VALUES (125,'Macau','MO','MAC',1,0);
INSERT INTO countries VALUES (126,'Macedonia, The Former Yugoslav Republic of','MK','MKD',1,0);
INSERT INTO countries VALUES (127,'Madagascar','MG','MDG',1,0);
INSERT INTO countries VALUES (128,'Malawi','MW','MWI',1,0);
INSERT INTO countries VALUES (129,'Malaysia','MY','MYS',1,0);
INSERT INTO countries VALUES (130,'Maldives','MV','MDV',1,0);
INSERT INTO countries VALUES (131,'Mali','ML','MLI',1,0);
INSERT INTO countries VALUES (132,'Malta','MT','MLT',1,0);
INSERT INTO countries VALUES (133,'Marshall Islands','MH','MHL',1,0);
INSERT INTO countries VALUES (134,'Martinique','MQ','MTQ',1,0);
INSERT INTO countries VALUES (135,'Mauritania','MR','MRT',1,0);
INSERT INTO countries VALUES (136,'Mauritius','MU','MUS',1,0);
INSERT INTO countries VALUES (137,'Mayotte','YT','MYT',1,0);
INSERT INTO countries VALUES (138,'Mexico','MX','MEX',1,0);
INSERT INTO countries VALUES (139,'Micronesia, Federated States of','FM','FSM',1,0);
INSERT INTO countries VALUES (140,'Moldova, Republic of','MD','MDA',1,0);
INSERT INTO countries VALUES (141,'Monaco','MC','MCO',1,0);
INSERT INTO countries VALUES (142,'Mongolia','MN','MNG',1,0);
INSERT INTO countries VALUES (143,'Montserrat','MS','MSR',1,0);
INSERT INTO countries VALUES (144,'Morocco','MA','MAR',1,0);
INSERT INTO countries VALUES (145,'Mozambique','MZ','MOZ',1,0);
INSERT INTO countries VALUES (146,'Myanmar','MM','MMR',1,0);
INSERT INTO countries VALUES (147,'Namibia','NA','NAM',1,0);
INSERT INTO countries VALUES (148,'Nauru','NR','NRU',1,0);
INSERT INTO countries VALUES (149,'Nepal','NP','NPL',1,0);
INSERT INTO countries VALUES (150,'Netherlands','NL','NLD',1,0);
INSERT INTO countries VALUES (151,'Netherlands Antilles','AN','ANT',1,0);
INSERT INTO countries VALUES (152,'New Caledonia','NC','NCL',1,0);
INSERT INTO countries VALUES (153,'New Zealand','NZ','NZL',1,0);
INSERT INTO countries VALUES (154,'Nicaragua','NI','NIC',1,0);
INSERT INTO countries VALUES (155,'Niger','NE','NER',1,0);
INSERT INTO countries VALUES (156,'Nigeria','NG','NGA',1,0);
INSERT INTO countries VALUES (157,'Niue','NU','NIU',1,0);
INSERT INTO countries VALUES (158,'Norfolk Island','NF','NFK',1,0);
INSERT INTO countries VALUES (159,'Northern Mariana Islands','MP','MNP',1,0);
INSERT INTO countries VALUES (160,'Norway','NO','NOR',1,0);
INSERT INTO countries VALUES (161,'Oman','OM','OMN',1,0);
INSERT INTO countries VALUES (162,'Pakistan','PK','PAK',1,0);
INSERT INTO countries VALUES (163,'Palau','PW','PLW',1,0);
INSERT INTO countries VALUES (164,'Panama','PA','PAN',1,0);
INSERT INTO countries VALUES (165,'Papua New Guinea','PG','PNG',1,0);
INSERT INTO countries VALUES (166,'Paraguay','PY','PRY',1,0);
INSERT INTO countries VALUES (167,'Peru','PE','PER',1,0);
INSERT INTO countries VALUES (168,'Philippines','PH','PHL',1,0);
INSERT INTO countries VALUES (169,'Pitcairn','PN','PCN',1,0);
INSERT INTO countries VALUES (170,'Poland','PL','POL',1,0);
INSERT INTO countries VALUES (171,'Portugal','PT','PRT',1,0);
INSERT INTO countries VALUES (172,'Puerto Rico','PR','PRI',1,0);
INSERT INTO countries VALUES (173,'Qatar','QA','QAT',1,0);
INSERT INTO countries VALUES (174,'Reunion','RE','REU',1,0);
INSERT INTO countries VALUES (175,'Romania','RO','ROM',1,0);
INSERT INTO countries VALUES (176,'Russian Federation','RU','RUS',1,0);
INSERT INTO countries VALUES (177,'Rwanda','RW','RWA',1,0);
INSERT INTO countries VALUES (178,'Saint Kitts and Nevis','KN','KNA',1,0);
INSERT INTO countries VALUES (179,'Saint Lucia','LC','LCA',1,0);
INSERT INTO countries VALUES (180,'Saint Vincent and the Grenadines','VC','VCT',1,0);
INSERT INTO countries VALUES (181,'Samoa','WS','WSM',1,0);
INSERT INTO countries VALUES (182,'San Marino','SM','SMR',1,0);
INSERT INTO countries VALUES (183,'Sao Tome and Principe','ST','STP',1,0);
INSERT INTO countries VALUES (184,'Saudi Arabia','SA','SAU',1,0);
INSERT INTO countries VALUES (185,'Senegal','SN','SEN',1,0);
INSERT INTO countries VALUES (186,'Seychelles','SC','SYC',1,0);
INSERT INTO countries VALUES (187,'Sierra Leone','SL','SLE',1,0);
INSERT INTO countries VALUES (188,'Singapore','SG','SGP',4,0);
INSERT INTO countries VALUES (189,'Slovakia (Slovak Republic)','SK','SVK',1,0);
INSERT INTO countries VALUES (190,'Slovenia','SI','SVN',1,0);
INSERT INTO countries VALUES (191,'Solomon Islands','SB','SLB',1,0);
INSERT INTO countries VALUES (192,'Somalia','SO','SOM',1,0);
INSERT INTO countries VALUES (193,'South Africa','ZA','ZAF',1,0);
INSERT INTO countries VALUES (194,'South Georgia and the South Sandwich Islands','GS','SGS',1,0);
INSERT INTO countries VALUES (195,'Spain','ES','ESP',3,0);
INSERT INTO countries VALUES (196,'Sri Lanka','LK','LKA',1,0);
INSERT INTO countries VALUES (197,'St. Helena','SH','SHN',1,0);
INSERT INTO countries VALUES (198,'St. Pierre and Miquelon','PM','SPM',1,0);
INSERT INTO countries VALUES (199,'Sudan','SD','SDN',1,0);
INSERT INTO countries VALUES (200,'Suriname','SR','SUR',1,0);
INSERT INTO countries VALUES (201,'Svalbard and Jan Mayen Islands','SJ','SJM',1,0);
INSERT INTO countries VALUES (202,'Swaziland','SZ','SWZ',1,0);
INSERT INTO countries VALUES (203,'Sweden','SE','SWE',1,0);
INSERT INTO countries VALUES (204,'Switzerland','CH','CHE',1,-10);
INSERT INTO countries VALUES (205,'Syrian Arab Republic','SY','SYR',1,0);
INSERT INTO countries VALUES (206,'Taiwan','TW','TWN',1,0);
INSERT INTO countries VALUES (207,'Tajikistan','TJ','TJK',1,0);
INSERT INTO countries VALUES (208,'Tanzania, United Republic of','TZ','TZA',1,0);
INSERT INTO countries VALUES (209,'Thailand','TH','THA',1,0);
INSERT INTO countries VALUES (210,'Togo','TG','TGO',1,0);
INSERT INTO countries VALUES (211,'Tokelau','TK','TKL',1,0);
INSERT INTO countries VALUES (212,'Tonga','TO','TON',1,0);
INSERT INTO countries VALUES (213,'Trinidad and Tobago','TT','TTO',1,0);
INSERT INTO countries VALUES (214,'Tunisia','TN','TUN',1,0);
INSERT INTO countries VALUES (215,'Turkey','TR','TUR',1,0);
INSERT INTO countries VALUES (216,'Turkmenistan','TM','TKM',1,0);
INSERT INTO countries VALUES (217,'Turks and Caicos Islands','TC','TCA',1,0);
INSERT INTO countries VALUES (218,'Tuvalu','TV','TUV',1,0);
INSERT INTO countries VALUES (219,'Uganda','UG','UGA',1,0);
INSERT INTO countries VALUES (220,'Ukraine','UA','UKR',1,0);
INSERT INTO countries VALUES (221,'United Arab Emirates','AE','ARE',1,0);
INSERT INTO countries VALUES (222,'United Kingdom','GB','GBR',1,0);
INSERT INTO countries VALUES (223,'United States','US','USA',2,0);
INSERT INTO countries VALUES (224,'United States Minor Outlying Islands','UM','UMI',1,0);
INSERT INTO countries VALUES (225,'Uruguay','UY','URY',1,0);
INSERT INTO countries VALUES (226,'Uzbekistan','UZ','UZB',1,0);
INSERT INTO countries VALUES (227,'Vanuatu','VU','VUT',1,0);
INSERT INTO countries VALUES (228,'Vatican City State (Holy See)','VA','VAT',1,0);
INSERT INTO countries VALUES (229,'Venezuela','VE','VEN',1,0);
INSERT INTO countries VALUES (230,'Viet Nam','VN','VNM',1,0);
INSERT INTO countries VALUES (231,'Virgin Islands (British)','VG','VGB',1,0);
INSERT INTO countries VALUES (232,'Virgin Islands (U.S.)','VI','VIR',1,0);
INSERT INTO countries VALUES (233,'Wallis and Futuna Islands','WF','WLF',1,0);
INSERT INTO countries VALUES (234,'Western Sahara','EH','ESH',1,0);
INSERT INTO countries VALUES (235,'Yemen','YE','YEM',1,0);
INSERT INTO countries VALUES (236,'Yugoslavia','YU','YUG',1,0);
INSERT INTO countries VALUES (237,'Zaire','ZR','ZAR',1,0);
INSERT INTO countries VALUES (238,'Zambia','ZM','ZMB',1,0);
INSERT INTO countries VALUES (239,'Zimbabwe','ZW','ZWE',1,0);

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS currencies;
CREATE TABLE currencies (
  currencies_id int(11) NOT NULL auto_increment,
  title varchar(32) NOT NULL default '',
  code char(3) NOT NULL default '',
  symbol_left varchar(12) default NULL,
  symbol_right varchar(12) default NULL,
  decimal_point char(1) default NULL,
  thousands_point char(1) default NULL,
  decimal_places char(1) default NULL,
  value float(13,8) default NULL,
  last_updated datetime default NULL,
  PRIMARY KEY  (currencies_id)
) TYPE=MyISAM;

--
-- Dumping data for table `currencies`
--

INSERT INTO currencies VALUES (1,'US Dollar','USD','$','','.',',','2',0.80669999,'2007-06-13 02:03:21');
INSERT INTO currencies VALUES (2,'Euro','EUR','','EUR','.',',','2',0.60439998,'2007-06-13 02:03:22');
INSERT INTO currencies VALUES (3,'Schweizer Franken','CHF','CHF','','.',',','2',1.00000000,'2007-06-13 02:03:23');

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
  customers_id int(11) NOT NULL auto_increment,
  customers_gender char(1) NOT NULL default '',
  customers_firstname varchar(32) NOT NULL default '',
  customers_lastname varchar(32) NOT NULL default '',
  customers_dob datetime NOT NULL default '0000-00-00 00:00:00',
  customers_email_address varchar(96) NOT NULL default '',
  customers_default_address_id int(11) default NULL,
  customers_telephone varchar(32) NOT NULL default '',
  customers_fax varchar(32) default NULL,
  customers_password varchar(40) NOT NULL default '',
  customers_newsletter char(1) default NULL,
  PRIMARY KEY  (customers_id)
) TYPE=MyISAM;

--
-- Dumping data for table `customers`
--

INSERT INTO customers VALUES (2,'m','Nick','Weisser','1970-05-21 00:00:00','nick@openstream.ch',2,'0445007878','','4b0bb070a6ffa89de54e062da0c29936:d9','1');

--
-- Table structure for table `customers_basket`
--

DROP TABLE IF EXISTS customers_basket;
CREATE TABLE customers_basket (
  customers_basket_id int(11) NOT NULL auto_increment,
  customers_id int(11) NOT NULL default '0',
  products_id tinytext NOT NULL,
  customers_basket_quantity int(2) NOT NULL default '0',
  final_price decimal(15,4) default NULL,
  customers_basket_date_added varchar(8) default NULL,
  clickandbuy_TransactionID varchar(11) NOT NULL default '',
  clickandbuy_externalBDRID varchar(11) NOT NULL default '',
  PRIMARY KEY  (customers_basket_id)
) TYPE=MyISAM;

--
-- Dumping data for table `customers_basket`
--


--
-- Table structure for table `customers_basket_attributes`
--

DROP TABLE IF EXISTS customers_basket_attributes;
CREATE TABLE customers_basket_attributes (
  customers_basket_attributes_id int(11) NOT NULL auto_increment,
  customers_id int(11) NOT NULL default '0',
  products_id tinytext NOT NULL,
  products_options_id int(11) NOT NULL default '0',
  products_options_value_id int(11) NOT NULL default '0',
  products_options_value_text text,
  PRIMARY KEY  (customers_basket_attributes_id)
) TYPE=MyISAM;

--
-- Dumping data for table `customers_basket_attributes`
--


--
-- Table structure for table `customers_info`
--

DROP TABLE IF EXISTS customers_info;
CREATE TABLE customers_info (
  customers_info_id int(11) NOT NULL default '0',
  customers_info_date_of_last_logon datetime default NULL,
  customers_info_number_of_logons int(5) default NULL,
  customers_info_date_account_created datetime default NULL,
  customers_info_date_account_last_modified datetime default NULL,
  global_product_notifications int(1) default '0',
  PRIMARY KEY  (customers_info_id)
) TYPE=MyISAM;

--
-- Dumping data for table `customers_info`
--

INSERT INTO customers_info VALUES (2,'2007-12-13 17:26:50',13,'2007-07-05 01:00:50',NULL,0);

--
-- Table structure for table `geo_zones`
--

DROP TABLE IF EXISTS geo_zones;
CREATE TABLE geo_zones (
  geo_zone_id int(11) NOT NULL auto_increment,
  geo_zone_name varchar(32) NOT NULL default '',
  geo_zone_description varchar(255) NOT NULL default '',
  last_modified datetime default NULL,
  date_added datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (geo_zone_id)
) TYPE=MyISAM;

--
-- Dumping data for table `geo_zones`
--

INSERT INTO geo_zones VALUES (1,'Schweiz','Steuerzone Schweiz','2007-08-07 22:42:21','2007-06-12 22:50:01');

--
-- Table structure for table `information`
--

DROP TABLE IF EXISTS information;
CREATE TABLE information (
  information_id tinyint(3) unsigned NOT NULL auto_increment,
  information_group_id int(11) unsigned NOT NULL default '0',
  information_title varchar(255) NOT NULL default '',
  information_description text NOT NULL,
  parent_id int(11) default NULL,
  sort_order tinyint(3) unsigned NOT NULL default '0',
  visible enum('1','0') NOT NULL default '1',
  language_id int(11) NOT NULL default '0',
  PRIMARY KEY  (information_id,language_id)
) TYPE=MyISAM;

--
-- Dumping data for table `information`
--

INSERT INTO information VALUES (1,2,'HEADING_TITLE','What\'s New Here?',0,1,'1',1);
INSERT INTO information VALUES (2,2,'TEXT_GREETING_PERSONAL','Welcome back <span class=\"greetUser\">%s!</span> Would you like to see which <a href=\"/swisscart/trunk/admin/%s\"><u>new products</u></a> are available to purchase?',0,2,'1',1);
INSERT INTO information VALUES (3,2,'TEXT_GREETING_PERSONAL_RELOGON','<small>If you are not %s, please <a href=\"%s\"><u>log yourself in</u></a> with your account information.</small>',0,3,'1',1);
INSERT INTO information VALUES (4,2,'TEXT_GREETING_GUEST','Would you like to <a href=\"%s\"><u>log yourself in</u></a>? Or would you prefer to <a href=\"%s\"><u>create an account</u></a>?',0,4,'1',1);
INSERT INTO information VALUES (5,2,'TEXT_MAIN','This is a default text. This can be changed in the admin panel\'s info manager.',0,5,'1',1);
INSERT INTO information VALUES (1,2,'HEADING_TITLE','Willkommen im Online-Shop',0,1,'1',2);
INSERT INTO information VALUES (2,2,'TEXT_GREETING_PERSONAL','Sch&ouml;n das Sie wieder da sind <span class=\"greetUser\">%s!</span> M&ouml;chten Sie die <a href=\"/swisscart/trunk/admin/%s\"><u>neuen Produkte</u></a> ansehen?',0,2,'1',2);
INSERT INTO information VALUES (3,2,'TEXT_GREETING_PERSONAL_RELOGON','<small>Wenn Sie nicht %s sind, melden Sie sich bitte <a href=\"%s\"><u>hier</u></a> mit Ihrem Kundenkonto an.</small>',0,3,'1',2);
INSERT INTO information VALUES (4,2,'TEXT_GREETING_GUEST','Bestehende Kunden k&ouml;nnen sich hier <a href=\"%s\"><u>einloggen</u></a>. Neukunden bitten wir, bei einer Bestellung ein <a href=\"%s\"><u>Kundenkonto</u></a> zu er&ouml;ffnen, um jederzeit den Bestellstatus online abrufen zu k&ouml;nnen.',0,4,'1',2);
INSERT INTO information VALUES (5,2,'TEXT_MAIN','Diesen Text k&ouml;nnen Sie im Admin unter Info-Manager &auml;ndern.',0,5,'1',2);
INSERT INTO information VALUES (1,2,'HEADING_TITLE','A ver que tenemos aqui',0,1,'1',3);
INSERT INTO information VALUES (2,2,'TEXT_GREETING_PERSONAL','Bienvenido de nuevo <span class=\"greetUser\">%s!</span> &iquest;Le gustaria ver que <a href=\"/swisscart/trunk/admin/%s\"><u>nuevos productos</u></a> hay disponibles?',0,2,'1',3);
INSERT INTO information VALUES (3,2,'TEXT_GREETING_PERSONAL_RELOGON','<small>Si no es %s, por favor <a href=\"%s\"><u>entre aqui</u></a> e introduzca sus datos.</small>',0,3,'1',3);
INSERT INTO information VALUES (4,2,'TEXT_GREETING_GUEST','Bienvenido <span class=\"greetUser\">Invitado!</span> &iquest;Le gustaria <a href=\"%s\"><u>entrar en su cuenta</u></a> o preferiria <a href=\"%s\"><u>crear una cuenta nueva</u></a>?',0,4,'1',3);
INSERT INTO information VALUES (5,2,'TEXT_MAIN','Este text se puede cambiar en el info manager de la administracion.',0,5,'1',3);
INSERT INTO information VALUES (1,2,'HEADING_TITLE','Vediamo cose c\'&egrave; qui',0,1,'1',4);
INSERT INTO information VALUES (2,2,'TEXT_GREETING_PERSONAL','Bentornato <span class=\"greetUser\">%s!</span> Vuoi vedere i <a href=\"/swisscart/trunk/admin/%s\"><u>nouvi prodotti</u></a> che sono disponibili?',0,2,'1',4);
INSERT INTO information VALUES (3,2,'TEXT_GREETING_PERSONAL_RELOGON','<small>Se tu non sei %s, <a href=\"%s\"><u>effettua il log-in</u></a> con i dati del tuo accout.</small>',0,3,'1',4);
INSERT INTO information VALUES (4,2,'TEXT_GREETING_GUEST','Benvenuto <span class=\"greetUser\">!</span> Puoi effettuare qui <a href=\"%s\"><u>il log-in</u></a>? Oppure puoi creare qui <a href=\"%s\"><u>un account</u></a>?',0,4,'1',4);
INSERT INTO information VALUES (5,2,'TEXT_MAIN','This is a default text. This can be changed in the admim panel\'s info manager.',0,5,'1',4);
INSERT INTO information VALUES (1,2,'HEADING_TITLE','Voyons ce que nous avons-l&agrave;',0,1,'1',5);
INSERT INTO information VALUES (2,2,'TEXT_GREETING_PERSONAL','Bienvenue &agrave; nouveau <span class=\"greetUser\">%s&nbsp;!</span> Voudriez-vous voir quels <a href=\"/swisscart/trunk/admin/%s\"><u>nouveaux produits</u></a> sont disponibles&nbsp;?',0,2,'1',5);
INSERT INTO information VALUES (3,2,'TEXT_GREETING_PERSONAL_RELOGON','<small>Si vous n\'&ecirc;tes pas %s, veuillez <a href=\"%s\"><u>vous indentifier</u></a> avec vos param&egrave;tres de compte.</small>',0,3,'1',5);
INSERT INTO information VALUES (4,2,'TEXT_GREETING_GUEST','Bienvenue <span class=\"greetUser\">cher visiteur&nbsp;!</span> Voulez-vous <a href=\"%s\"><u>vous identifier</u></a>? Ou pr&eacute;f&eacute;rez-vous <a href=\"%s\"><u>cr&eacute;er un compte</u></a>&nbsp;?',0,4,'1',5);
INSERT INTO information VALUES (5,2,'TEXT_MAIN','Ce text peut être changé avec le info manager dans l\'administration',0,5,'1',5);
INSERT INTO information VALUES (6,1,'Versand','F&uuml;gen Sie hier Ihre Informationen &uuml;ber Liefer- und Versandkosten ein.',0,1,'1',2);
INSERT INTO information VALUES (6,1,'Shipping','Put here your Shipping &amp; Returns information.',0,1,'1',1);
INSERT INTO information VALUES (6,1,'Livraison','Mettez ici vous informations sur les livraison &amp; retour.',0,1,'1',5);
INSERT INTO information VALUES (6,1,'Spedizione','Inserisci qui le tue informazioni sulla spedizione e consegna.',0,1,'1',4);
INSERT INTO information VALUES (6,1,'Envíos','Ponga aqui informacion sobre los Envios y Devoluciones',0,1,'1',3);
INSERT INTO information VALUES (7,1,'Unsere AGBs','F&uuml;gen Sie hier Ihre allgemeinen Gesch&auml;ftsbedingungen ein. Diesen Text k&ouml;nnen Sie im Admin-Bereich unter <strong>Info-Manager/Infobox</strong> bearbeiten.',0,2,'1',2);
INSERT INTO information VALUES (7,1,'Conditions of Use','Put here your Conditions of Use information. This text can be modified in the admin section under <strong>Info Manager/Infobox</strong>.',0,2,'1',1);
INSERT INTO information VALUES (7,1,'Conditions d\'utilisation','Mettez ici les informations concernant vos conditions d\'utilisation.',0,2,'1',5);
INSERT INTO information VALUES (7,1,'Condizioni per l\'uso','Inserisci qui le condizioni di informazione sull\' uso.',0,2,'1',4);
INSERT INTO information VALUES (7,1,'Condiciones de Uso','Ponga aqui sus condiciones de uso.',0,2,'1',3);

--
-- Table structure for table `information_group`
--

DROP TABLE IF EXISTS information_group;
CREATE TABLE information_group (
  information_group_id int(11) NOT NULL auto_increment,
  information_group_title varchar(64) NOT NULL default '',
  information_group_description varchar(255) NOT NULL default '',
  sort_order int(5) default NULL,
  visible int(1) default '1',
  locked varchar(255) NOT NULL default '',
  PRIMARY KEY  (information_group_id)
) TYPE=MyISAM;

--
-- Dumping data for table `information_group`
--

INSERT INTO information_group VALUES (1,'Infobox','Diese Seiten werden in der Infobox angezeigt',1,1,'');
INSERT INTO information_group VALUES (2,'Startseite','Zum Ändern des Text auf der Startseite Ihres Shops',2,1,'');

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS languages;
CREATE TABLE languages (
  languages_id int(11) NOT NULL auto_increment,
  name varchar(32) NOT NULL default '',
  code char(2) NOT NULL default '',
  image varchar(64) default NULL,
  directory varchar(32) default NULL,
  sort_order int(3) default NULL,
  PRIMARY KEY  (languages_id),
  KEY IDX_LANGUAGES_NAME (name)
) TYPE=MyISAM;

--
-- Dumping data for table `languages`
--

INSERT INTO languages VALUES (1,'English','en','icon.gif','english',10);
INSERT INTO languages VALUES (2,'Deutsch','de','icon.gif','german',5);
INSERT INTO languages VALUES (3,'Español','es','icon.gif','espanol',25);
INSERT INTO languages VALUES (4,'Italiano','it','icon.gif','italian',20);
INSERT INTO languages VALUES (5,'Français','fr','icon.gif','french',15);

--
-- Table structure for table `manufacturers`
--

DROP TABLE IF EXISTS manufacturers;
CREATE TABLE manufacturers (
  manufacturers_id int(11) NOT NULL auto_increment,
  manufacturers_name varchar(32) NOT NULL default '',
  manufacturers_image varchar(64) default NULL,
  date_added datetime default NULL,
  last_modified datetime default NULL,
  PRIMARY KEY  (manufacturers_id),
  KEY IDX_MANUFACTURERS_NAME (manufacturers_name)
) TYPE=MyISAM;

--
-- Dumping data for table `manufacturers`
--

INSERT INTO manufacturers VALUES (1,'JamoTrade','jamotrade.jpg','2007-11-04 14:42:14',NULL);
INSERT INTO manufacturers VALUES (2,'Zeed','zeed.gif','2007-11-04 15:02:43',NULL);
INSERT INTO manufacturers VALUES (4,'Sony','sony-logo.jpg','2007-11-05 02:36:16',NULL);
INSERT INTO manufacturers VALUES (5,'Hewlett-Packard','hp-logo.gif','2007-11-05 02:57:47',NULL);

--
-- Table structure for table `manufacturers_info`
--

DROP TABLE IF EXISTS manufacturers_info;
CREATE TABLE manufacturers_info (
  manufacturers_id int(11) NOT NULL default '0',
  languages_id int(11) NOT NULL default '0',
  manufacturers_url varchar(255) NOT NULL default '',
  url_clicked int(5) NOT NULL default '0',
  date_last_click datetime default NULL,
  manufacturers_htc_title_tag varchar(80) default NULL,
  manufacturers_htc_desc_tag longtext,
  manufacturers_htc_keywords_tag longtext,
  manufacturers_htc_description longtext,
  PRIMARY KEY  (manufacturers_id,languages_id)
) TYPE=MyISAM;

--
-- Dumping data for table `manufacturers_info`
--

INSERT INTO manufacturers_info VALUES (1,2,'www.jamotrade.ch',1,'2007-11-04 14:44:47','JamoTrade','JamoTrade','JamoTrade','');
INSERT INTO manufacturers_info VALUES (1,1,'www.jamotrade.ch',0,NULL,'JamoTrade','JamoTrade','JamoTrade','');
INSERT INTO manufacturers_info VALUES (1,5,'www.jamotrade.ch',0,NULL,'JamoTrade','JamoTrade','JamoTrade','');
INSERT INTO manufacturers_info VALUES (1,4,'www.jamotrade.ch',0,NULL,'JamoTrade','JamoTrade','JamoTrade','');
INSERT INTO manufacturers_info VALUES (1,3,'www.jamotrade.ch',0,NULL,'JamoTrade','JamoTrade','JamoTrade','');
INSERT INTO manufacturers_info VALUES (2,2,'http://www.zeed.ch',2,'2007-11-04 15:03:30','Zeed','Zeed','Zeed','');
INSERT INTO manufacturers_info VALUES (2,1,'http://www.zeed.ch',0,NULL,'Zeed','Zeed','Zeed','');
INSERT INTO manufacturers_info VALUES (2,5,'http://www.zeed.ch',0,NULL,'Zeed','Zeed','Zeed','');
INSERT INTO manufacturers_info VALUES (2,4,'http://www.zeed.ch',0,NULL,'Zeed','Zeed','Zeed','');
INSERT INTO manufacturers_info VALUES (2,3,'http://www.zeed.ch',0,NULL,'Zeed','Zeed','Zeed','');
INSERT INTO manufacturers_info VALUES (4,2,'http://www.sony.com/',0,NULL,'Sony','Sony','Sony','');
INSERT INTO manufacturers_info VALUES (4,1,'http://www.sony.com/',0,NULL,'Sony','Sony','Sony','');
INSERT INTO manufacturers_info VALUES (4,5,'http://www.sony.com/',0,NULL,'Sony','Sony','Sony','');
INSERT INTO manufacturers_info VALUES (4,4,'http://www.sony.com/',0,NULL,'Sony','Sony','Sony','');
INSERT INTO manufacturers_info VALUES (4,3,'http://www.sony.com/',0,NULL,'Sony','Sony','Sony','');
INSERT INTO manufacturers_info VALUES (5,2,'http://www.hp.com',0,NULL,'Hewlett-Packard','Hewlett-Packard','Hewlett-Packard','');
INSERT INTO manufacturers_info VALUES (5,1,'http://www.hp.com',0,NULL,'Hewlett-Packard','Hewlett-Packard','Hewlett-Packard','');
INSERT INTO manufacturers_info VALUES (5,5,'http://www.hp.com',0,NULL,'Hewlett-Packard','Hewlett-Packard','Hewlett-Packard','');
INSERT INTO manufacturers_info VALUES (5,4,'http://www.hp.com',0,NULL,'Hewlett-Packard','Hewlett-Packard','Hewlett-Packard','');
INSERT INTO manufacturers_info VALUES (5,3,'http://www.hp.com',0,NULL,'Hewlett-Packard','Hewlett-Packard','Hewlett-Packard','');

--
-- Table structure for table `newsletters`
--

DROP TABLE IF EXISTS newsletters;
CREATE TABLE newsletters (
  newsletters_id int(11) NOT NULL auto_increment,
  title varchar(255) NOT NULL default '',
  content text NOT NULL,
  module varchar(255) NOT NULL default '',
  date_added datetime NOT NULL default '0000-00-00 00:00:00',
  date_sent datetime default NULL,
  status int(1) default NULL,
  locked int(1) default '0',
  PRIMARY KEY  (newsletters_id)
) TYPE=MyISAM;

--
-- Dumping data for table `newsletters`
--


--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  orders_id int(11) NOT NULL auto_increment,
  customers_id int(11) NOT NULL default '0',
  customers_name varchar(64) NOT NULL default '',
  customers_company varchar(32) default NULL,
  customers_street_address varchar(64) NOT NULL default '',
  customers_suburb varchar(32) default NULL,
  customers_city varchar(32) NOT NULL default '',
  customers_postcode varchar(10) NOT NULL default '',
  customers_state varchar(32) default NULL,
  customers_country varchar(32) NOT NULL default '',
  customers_telephone varchar(32) NOT NULL default '',
  customers_email_address varchar(96) NOT NULL default '',
  customers_address_format_id int(5) NOT NULL default '0',
  delivery_name varchar(64) NOT NULL default '',
  delivery_company varchar(32) default NULL,
  delivery_street_address varchar(64) NOT NULL default '',
  delivery_suburb varchar(32) default NULL,
  delivery_city varchar(32) NOT NULL default '',
  delivery_postcode varchar(10) NOT NULL default '',
  delivery_state varchar(32) default NULL,
  delivery_country varchar(32) NOT NULL default '',
  delivery_address_format_id int(5) NOT NULL default '0',
  billing_name varchar(64) NOT NULL default '',
  billing_company varchar(32) default NULL,
  billing_street_address varchar(64) NOT NULL default '',
  billing_suburb varchar(32) default NULL,
  billing_city varchar(32) NOT NULL default '',
  billing_postcode varchar(10) NOT NULL default '',
  billing_state varchar(32) default NULL,
  billing_country varchar(32) NOT NULL default '',
  billing_address_format_id int(5) NOT NULL default '0',
  payment_method varchar(32) NOT NULL default '',
  cc_type varchar(20) default NULL,
  cc_owner varchar(64) default NULL,
  cc_number varchar(32) default NULL,
  cc_expires varchar(4) default NULL,
  cc_cvv2 varchar(4) default NULL,
  last_modified datetime default NULL,
  date_purchased datetime default NULL,
  orders_status int(5) NOT NULL default '0',
  orders_date_finished datetime default NULL,
  currency char(3) default NULL,
  currency_value decimal(14,6) default NULL,
  PRIMARY KEY  (orders_id)
) TYPE=MyISAM;

--
-- Dumping data for table `orders`
--

INSERT INTO orders VALUES (1,2,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Zürch','8049','Zürich','Switzerland','0445007878','nick@openstream.ch',1,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Zürch','8049','Zürich','Switzerland',1,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Zürch','8049','Zürich','Switzerland',1,'Nachnahme','','','','','',NULL,'2007-12-13 17:27:27',1,NULL,'CHF','1.000000');
INSERT INTO orders VALUES (2,0,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','044-5007878','info@openstream.ch',1,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland',1,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland',1,'Nachnahme','','','','','','2008-01-23 18:42:34','2008-01-23 18:22:55',2,NULL,'CHF','1.000000');
INSERT INTO orders VALUES (3,0,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland','044-5007878','nick.weisser@gmail.com',1,'Nick Weisser','Openstream Internet Solutions','Friedhofstrasse 36','','Wahlwies','78333','','Germany',5,'Nick Weisser','Openstream Internet Solutions','Wieslergasse 6','','Zürich','8049','','Switzerland',1,'Nachnahme','','','','','',NULL,'2008-01-23 21:32:07',1,NULL,'CHF','1.000000');

--
-- Table structure for table `orders_products`
--

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  orders_products_id int(11) NOT NULL auto_increment,
  orders_id int(11) NOT NULL default '0',
  products_id int(11) NOT NULL default '0',
  products_model varchar(12) default NULL,
  products_name varchar(64) NOT NULL default '',
  products_price decimal(15,4) NOT NULL default '0.0000',
  final_price decimal(15,4) NOT NULL default '0.0000',
  products_tax decimal(7,4) NOT NULL default '0.0000',
  products_quantity int(2) NOT NULL default '0',
  PRIMARY KEY  (orders_products_id)
) TYPE=MyISAM;

--
-- Dumping data for table `orders_products`
--

INSERT INTO orders_products VALUES (1,1,4,'80004','Sony HDR-HC1','4033.4572','4033.4572','7.6000',1);
INSERT INTO orders_products VALUES (2,2,2,'80002','Monster Truck BigFoot','1013.0112','1013.0112','7.6000',1);
INSERT INTO orders_products VALUES (3,3,1,'','R/C Buggy HBX W2','157.0632','157.0632','7.6000',1);

--
-- Table structure for table `orders_products_attributes`
--

DROP TABLE IF EXISTS orders_products_attributes;
CREATE TABLE orders_products_attributes (
  orders_products_attributes_id int(11) NOT NULL auto_increment,
  orders_id int(11) NOT NULL default '0',
  orders_products_id int(11) NOT NULL default '0',
  products_options varchar(32) NOT NULL default '',
  products_options_values varchar(32) NOT NULL default '',
  options_values_price decimal(15,4) NOT NULL default '0.0000',
  price_prefix char(1) NOT NULL default '',
  PRIMARY KEY  (orders_products_attributes_id)
) TYPE=MyISAM;

--
-- Dumping data for table `orders_products_attributes`
--


--
-- Table structure for table `orders_products_download`
--

DROP TABLE IF EXISTS orders_products_download;
CREATE TABLE orders_products_download (
  orders_products_download_id int(11) NOT NULL auto_increment,
  orders_id int(11) NOT NULL default '0',
  orders_products_id int(11) NOT NULL default '0',
  orders_products_filename varchar(255) NOT NULL default '',
  download_maxdays int(2) NOT NULL default '0',
  download_count int(2) NOT NULL default '0',
  PRIMARY KEY  (orders_products_download_id)
) TYPE=MyISAM;

--
-- Dumping data for table `orders_products_download`
--


--
-- Table structure for table `orders_status`
--

DROP TABLE IF EXISTS orders_status;
CREATE TABLE orders_status (
  orders_status_id int(11) NOT NULL default '0',
  language_id int(11) NOT NULL default '1',
  orders_status_name varchar(32) NOT NULL default '',
  PRIMARY KEY  (orders_status_id,language_id),
  KEY idx_orders_status_name (orders_status_name)
) TYPE=MyISAM;

--
-- Dumping data for table `orders_status`
--

INSERT INTO orders_status VALUES (1,1,'Pending');
INSERT INTO orders_status VALUES (1,2,'Offen');
INSERT INTO orders_status VALUES (1,3,'Pendiente');
INSERT INTO orders_status VALUES (2,1,'Processing');
INSERT INTO orders_status VALUES (2,2,'In Bearbeitung');
INSERT INTO orders_status VALUES (2,3,'Proceso');
INSERT INTO orders_status VALUES (3,1,'Delivered');
INSERT INTO orders_status VALUES (3,2,'Versendet');
INSERT INTO orders_status VALUES (3,3,'Entregado');
INSERT INTO orders_status VALUES (1,4,'Offen');
INSERT INTO orders_status VALUES (2,4,'In Bearbeitung');
INSERT INTO orders_status VALUES (3,4,'Versendet');
INSERT INTO orders_status VALUES (1,5,'Offen');
INSERT INTO orders_status VALUES (2,5,'In Bearbeitung');
INSERT INTO orders_status VALUES (3,5,'Versendet');

--
-- Table structure for table `orders_status_history`
--

DROP TABLE IF EXISTS orders_status_history;
CREATE TABLE orders_status_history (
  orders_status_history_id int(11) NOT NULL auto_increment,
  orders_id int(11) NOT NULL default '0',
  orders_status_id int(5) NOT NULL default '0',
  date_added datetime NOT NULL default '0000-00-00 00:00:00',
  customer_notified int(1) default '0',
  comments text,
  PRIMARY KEY  (orders_status_history_id)
) TYPE=MyISAM;

--
-- Dumping data for table `orders_status_history`
--

INSERT INTO orders_status_history VALUES (1,1,1,'2007-12-13 17:27:27',1,'');
INSERT INTO orders_status_history VALUES (2,2,1,'2008-01-23 18:22:55',1,'test');
INSERT INTO orders_status_history VALUES (3,2,2,'2008-01-23 18:42:35',1,'Test Aktualisierung des Status.');
INSERT INTO orders_status_history VALUES (4,3,1,'2008-01-23 21:32:07',1,'');

--
-- Table structure for table `orders_total`
--

DROP TABLE IF EXISTS orders_total;
CREATE TABLE orders_total (
  orders_total_id int(10) unsigned NOT NULL auto_increment,
  orders_id int(11) NOT NULL default '0',
  title varchar(255) NOT NULL default '',
  text varchar(255) NOT NULL default '',
  value decimal(15,4) NOT NULL default '0.0000',
  class varchar(32) NOT NULL default '',
  sort_order int(11) NOT NULL default '0',
  PRIMARY KEY  (orders_total_id),
  KEY idx_orders_total_orders_id (orders_id)
) TYPE=MyISAM;

--
-- Dumping data for table `orders_total`
--

INSERT INTO orders_total VALUES (1,1,'Zwischensumme:','CHF 4,340.00','4340.0000','ot_subtotal',1);
INSERT INTO orders_total VALUES (2,1,'Paketversand (1 x 0.25 kg) (Priority):','CHF 8.00','8.0000','ot_shipping',2);
INSERT INTO orders_total VALUES (3,1,'7.6% MwSt.:','CHF 306.54','306.5428','ot_tax',3);
INSERT INTO orders_total VALUES (4,1,'<b>Summe</b>:','<b>CHF 4,348.00</b>','4348.0000','ot_total',4);
INSERT INTO orders_total VALUES (5,2,'Zwischensumme:','CHF 1,090.00','1090.0000','ot_subtotal',1);
INSERT INTO orders_total VALUES (6,2,'Paketversand (1 x 5.8 kg) (Economy):','CHF 11.00','11.0000','ot_shipping',2);
INSERT INTO orders_total VALUES (7,2,'7.6% MwSt.:','CHF 76.99','76.9888','ot_tax',3);
INSERT INTO orders_total VALUES (8,2,'<b>Summe</b>:','<b>CHF 1,101.00</b>','1101.0000','ot_total',4);
INSERT INTO orders_total VALUES (9,3,'Zwischensumme:','CHF 169.00','169.0000','ot_subtotal',1);
INSERT INTO orders_total VALUES (10,3,'Paketversand (1 x 3.5 kg) (Economy):','CHF 35.00','35.0000','ot_shipping',2);
INSERT INTO orders_total VALUES (11,3,'7.6% MwSt.:','CHF 11.94','11.9368','ot_tax',3);
INSERT INTO orders_total VALUES (12,3,'<b>Summe</b>:','<b>CHF 204.00</b>','204.0000','ot_total',4);

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  products_id int(11) NOT NULL auto_increment,
  products_quantity int(4) NOT NULL default '0',
  products_model varchar(12) default NULL,
  products_image varchar(64) default NULL,
  products_image2 varchar(64) NOT NULL default '',
  products_image3 varchar(64) NOT NULL default '',
  products_image4 varchar(64) NOT NULL default '',
  products_price decimal(15,4) NOT NULL default '0.0000',
  products_date_added datetime NOT NULL default '0000-00-00 00:00:00',
  products_last_modified datetime default NULL,
  products_date_available datetime default NULL,
  products_weight decimal(5,2) NOT NULL default '0.00',
  products_status tinyint(1) NOT NULL default '0',
  products_tax_class_id int(11) NOT NULL default '0',
  manufacturers_id int(11) default NULL,
  products_ordered int(11) NOT NULL default '0',
  PRIMARY KEY  (products_id),
  KEY idx_products_date_added (products_date_added)
) TYPE=MyISAM;

--
-- Dumping data for table `products`
--

INSERT INTO products VALUES (1,-1,'','buggy-hbx.jpg','buggy-hbx-02.jpg','buggy-hbx-03.jpg','buggy-hbx-04.jpg','157.0632','2007-11-04 14:11:17','2007-11-04 14:42:50',NULL,'3.50',1,1,1,1);
INSERT INTO products VALUES (2,9,'80002','monster.jpg','monster-02.jpg','monster-03.jpg','monster-04.jpg','1013.0112','2007-11-04 15:01:18','2007-11-04 15:03:09',NULL,'5.80',1,1,2,1);
INSERT INTO products VALUES (4,9,'80004','sony-hdr.jpg','sony-hdr-02.jpg','sony-hdr-03.jpg','','4033.4572','2007-11-05 02:33:13','2007-11-05 02:36:50',NULL,'0.25',1,1,4,1);
INSERT INTO products VALUES (5,10,'80005','hp-2710p.jpg','hp-2710p-02.jpg','','','1719.3309','2007-11-05 03:03:14','2007-12-14 15:25:55',NULL,'1.68',1,1,5,0);
INSERT INTO products VALUES (6,10,'80006','vaio-micro-pc.jpg','vaio-micro-pc-02.jpg','vaio-micro-pc-03.jpg','','2137.5465','2007-11-05 03:18:00',NULL,NULL,'0.50',1,1,4,0);
INSERT INTO products VALUES (7,10,'80007','katamaran.jpg','katamaran-02.jpg','katamaran-03.jpg','','74.2565','2007-11-05 03:34:24',NULL,NULL,'4.50',1,1,1,0);

--
-- Table structure for table `products_attributes`
--

DROP TABLE IF EXISTS products_attributes;
CREATE TABLE products_attributes (
  products_attributes_id int(11) NOT NULL auto_increment,
  products_id int(11) NOT NULL default '0',
  options_id int(11) NOT NULL default '0',
  options_values_id int(11) NOT NULL default '0',
  options_values_price decimal(15,4) NOT NULL default '0.0000',
  price_prefix char(1) NOT NULL default '',
  products_options_sort_order int(3) NOT NULL default '0',
  products_attributes_weight decimal(5,2) NOT NULL default '0.00',
  products_attributes_weight_prefix char(1) NOT NULL default '',
  PRIMARY KEY  (products_attributes_id)
) TYPE=MyISAM;

--
-- Dumping data for table `products_attributes`
--

INSERT INTO products_attributes VALUES (40,5,3,7,'0.0000','+',0,'0.00','+');
INSERT INTO products_attributes VALUES (39,5,3,8,'0.0000','+',0,'0.00','+');
INSERT INTO products_attributes VALUES (38,5,3,9,'0.0000','+',0,'0.00','+');
INSERT INTO products_attributes VALUES (37,5,3,10,'0.0000','+',-1,'0.00','+');
INSERT INTO products_attributes VALUES (36,5,2,3,'0.0000','+',1,'0.00','+');
INSERT INTO products_attributes VALUES (35,5,2,4,'46.4684','+',2,'0.00','+');
INSERT INTO products_attributes VALUES (34,5,2,5,'92.9368','+',3,'0.00','+');
INSERT INTO products_attributes VALUES (33,5,1,1,'0.0000','+',0,'0.00','+');
INSERT INTO products_attributes VALUES (32,5,1,2,'157.9925','+',0,'0.00','+');
INSERT INTO products_attributes VALUES (41,5,3,6,'0.0000','+',0,'0.00','+');

--
-- Table structure for table `products_attributes_download`
--

DROP TABLE IF EXISTS products_attributes_download;
CREATE TABLE products_attributes_download (
  products_attributes_id int(11) NOT NULL default '0',
  products_attributes_filename varchar(255) NOT NULL default '',
  products_attributes_maxdays int(2) default '0',
  products_attributes_maxcount int(2) default '0',
  PRIMARY KEY  (products_attributes_id)
) TYPE=MyISAM;

--
-- Dumping data for table `products_attributes_download`
--


--
-- Table structure for table `products_description`
--

DROP TABLE IF EXISTS products_description;
CREATE TABLE products_description (
  products_id int(11) NOT NULL auto_increment,
  language_id int(11) NOT NULL default '1',
  products_name varchar(64) NOT NULL default '',
  products_description text,
  products_url varchar(255) default NULL,
  products_viewed int(5) default '0',
  products_seo_url varchar(100) NOT NULL default '',
  products_head_title_tag varchar(80) default NULL,
  products_head_desc_tag longtext,
  products_head_keywords_tag longtext,
  PRIMARY KEY  (products_id,language_id),
  KEY products_name (products_name)
) TYPE=MyISAM;

--
-- Dumping data for table `products_description`
--

INSERT INTO products_description VALUES (1,2,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p><ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul><p><br /><strong>Beschreibung:</strong></p><ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul><p><br /><strong>Lieferumfang:</strong></p><ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',115,'','R/C Buggy HBX W2','R/C Buggy HBX W2','R/C Buggy HBX W2');
INSERT INTO products_description VALUES (1,1,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p> <ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul> <p><br /><strong>Beschreibung:</strong></p> <ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul> <p><br /><strong>Lieferumfang:</strong></p> <ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',7,'','R/C Buggy HBX W2','R/C Buggy HBX W2','R/C Buggy HBX W2');
INSERT INTO products_description VALUES (1,5,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p> <ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul> <p><br /><strong>Beschreibung:</strong></p> <ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul> <p><br /><strong>Lieferumfang:</strong></p> <ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',0,'','R/C Buggy HBX W2','R/C Buggy HBX W2','R/C Buggy HBX W2');
INSERT INTO products_description VALUES (1,4,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p> <ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul> <p><br /><strong>Beschreibung:</strong></p> <ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul> <p><br /><strong>Lieferumfang:</strong></p> <ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',0,'','R/C Buggy HBX W2','R/C Buggy HBX W2','R/C Buggy HBX W2');
INSERT INTO products_description VALUES (1,3,'R/C Buggy HBX W2','<p>Der HBX MAX BUGGY W2 ist ein reinrassiges Hightechger&auml;t. Der Allradantrieb, die Vollfederung des Fahrwerks sowie die extreme Gel&auml;ndeg&auml;ngigkeit werden Piloten JEDEN Alters begeistern.&nbsp;</p><p><strong>Technische Daten:</strong></p> <ul><li>Mode: RC Buggy HBX W2</li><li>Ma&szlig;stab: 1:10</li><li>Mottorart: Elektromotor Luftgek&uuml;hlt</li><li>max. Geschwindigkeit: ca.60km/h</li><li>Stromversorgung: 7,2V 1800mAh Ni-Cd Akku</li><li>Karosserie: aus Lexan</li><li>Radstand: ca.260mm</li><li>Abmessungen (LxBxH): 400mm/260mm/180mm</li><li>Gewicht: ca.1380g (fahrbereit)</li><li>Fernbedienung: rechts/links proportional Vorw&auml;rts/R&uuml;ckw&auml;rts</li><li>dosierbare Regelung der Geschwindigkeit</li><li>Frequenz: 27 Mhz auswechselbarer Quarz.</li><li>Durchmesser der R&auml;der: 8,5 cm</li></ul> <p><br /><strong>Beschreibung:</strong></p> <ul><li>F&auml;hrt bis zu ca. 60 Km/h!</li><li>4x4 Allradantrieb!</li><li>spitzen Beschleunigung</li><li>Einzelradaufh&auml;ngung</li><li>Einzelradfederung</li><li>Ma&szlig;stab 1:10</li><li>luftgek&uuml;hlter starker elktro- Rippenmotor</li><li>Versiegeltes Getriebe</li><li>elektronischer Fahrtenregler</li><li>Servolenkung</li><li>Chassis des Buggys ist &uuml;berwiegen aus Metall hergestellt</li><li>Wechselbares Cover strapazierf&auml;hig aus Polycarbonat</li><li>Luftgef&uuml;llte noppen Gummireifen</li><li>Fahrzeug ist komplett geschraubt und kann komplett auseinander genommen werden (Anleitung liegt auch bei)</li><li>Der Buggy ist fertig montiert und sofort startklar</li><li>Profi Pistolenfernsteuerung mit ca. 200 Metern Reichweite!</li><li>Per Fernsteuerung l&auml;sst sich alles am Buggy einstellen wie kalibrieren der Lenkung usw!</li><li>Starker Akkupack 1800mAh 7,2V</li><li>Schnellladeger&auml;t Ladedauer nur 5 Stunden</li><li>mit dem Ladeger&auml;t k&ouml;nnen sogar wiederaufladbare Akkus &uuml;ber die Fernsteuerung geladen werden (passender Stecker enthalten).</li><li>Rennen mit mehreren Autos durch Frequenzquarz m&ouml;glich.</li><li>Buggy wird in verschiedenen Farben geliefert.</li></ul> <p><br /><strong>Lieferumfang:</strong></p> <ul><li>RC Buggy HBX W2</li><li>Profi Pistolenfernbedienung proportionalHochleistungs- Akkupack</li><li>Ladeger&auml;t</li><li>Batterien f&uuml;r Fernsteuerung</li><li>Ausf&uuml;hrliches Anleitung mit Bildern</li></ul>','',0,'','R/C Buggy HBX W2','R/C Buggy HBX W2','R/C Buggy HBX W2');
INSERT INTO products_description VALUES (2,2,'Monster Truck BigFoot','<p class=\"bodytext\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"bodytext\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"bodytext\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"bodytext\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"bodytext\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"bodytext\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"bodytext\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"bodytext\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"bodytext\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"bodytext\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"bodytext\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"bodytext\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',20,'','Monster Truck BigFoot','Monster Truck BigFoot','Monster Truck BigFoot');
INSERT INTO products_description VALUES (2,1,'Monster Truck BigFoot','<p class=\"bodytext\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"bodytext\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"bodytext\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"bodytext\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"bodytext\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"bodytext\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"bodytext\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"bodytext\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"bodytext\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"bodytext\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"bodytext\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"bodytext\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',0,'','Monster Truck BigFoot','Monster Truck BigFoot','Monster Truck BigFoot');
INSERT INTO products_description VALUES (2,5,'Monster Truck BigFoot','<p class=\"bodytext\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"bodytext\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"bodytext\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"bodytext\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"bodytext\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"bodytext\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"bodytext\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"bodytext\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"bodytext\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"bodytext\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"bodytext\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"bodytext\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',0,'','Monster Truck BigFoot','Monster Truck BigFoot','Monster Truck BigFoot');
INSERT INTO products_description VALUES (2,4,'Monster Truck BigFoot','<p class=\"bodytext\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"bodytext\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"bodytext\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"bodytext\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"bodytext\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"bodytext\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"bodytext\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"bodytext\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"bodytext\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"bodytext\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"bodytext\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"bodytext\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',0,'','Monster Truck BigFoot','Monster Truck BigFoot','Monster Truck BigFoot');
INSERT INTO products_description VALUES (2,3,'Monster Truck BigFoot','<p class=\"bodytext\"><strong>THE BIGGEST BY ZEED! </strong></p> <p class=\"bodytext\">BigFood, der gr&ouml;&szlig;te Monster Truck bei ZEED, damit fahren Sie alles um! </p> <p class=\"bodytext\">Das gro&szlig;e und breite Chassis sorgt mit seinem Design schon von weitem f&uuml;r aufsehen. Die Reifen sind mit den Felgen verklebt und garantieren auf fast jedem Untergrund guten halt. Ob auf feuchtem Gras, im Gel&auml;nde oder auf der Strasse, mit dem BigFood macht es einfach Spa&szlig;! Dank den gro&szlig;en Stossd&auml;mpfern hat der BigFood eine hohe Bodenfreiheit. Dieses Federwerk sorgt zudem f&uuml;r perfekte Gewichtsverteilung, damit der Monster Truck auch weite Spr&uuml;nge &uuml;ber H&uuml;gel oder Rampen ohne weiteres meistert. </p> <p class=\"bodytext\">Dank dem Betrieb eines 23ccm Zweitakt Motors mit herk&ouml;mmlichem Treibstoff ist der Monster Truck wesentlich einfacher im Betrieb und wird zudem als Ready to Run Modell ausgeliefert. Aus der Packung, fertig und los! </p> <p class=\"bodytext\">Das starten beim BigFood ist ein Kinderspiel. Dank dem eingebauten Zugseil, wird der Monster Truck wie ein Rasenm&auml;her gestartet. </p> <p class=\"bodytext\">Das flexible Chassis sorgt bei dem BigFood f&uuml;r extreme Haltbarkeit und Stabilit&auml;t. </p> <p class=\"bodytext\">Die Kombination der voll einstellbaren langen Federwerken und Doppelquerlenker Aufh&auml;ngung, sorgen f&uuml;r optimales Fahrverhalten im Gel&auml;nde wie auch auf der Strasse. Die Stossd&auml;mpfer, welche aus hochfestem Aluminium gefertigt werden, k&ouml;nnen von aussen durch 2 Varianten eingestellt und ge&auml;ndert werden. F&uuml;r ein gleichm&auml;ssiges Arbeiten der Aufh&auml;ngungen auf allen Oberfl&auml;chen sorgen die langen Federn. </p> <p class=\"bodytext\">Eine hochwertige Fernsteuerung, welche f&uuml;r eine grosse Reichweite garantiert, ist selbstverst&auml;ndlich im RTR Pack enthalten. </p> <p class=\"bodytext\">Dank des grossen 23ccm Benzinmotor hat der BigFood eine grosse Leistung zu bieten. Der 1:5 grosse Monster Truck ist durch die grosse Leistung des 23ccm Benzinmotors gleich beweglich wie ein 1:10 Modell. Mit nur einer Tankf&uuml;llung f&auml;hrt der BigFood l&auml;nger als 40 Minuten. Dadurch dass der Monster Truck normalen Treibstoff ben&uuml;tzt, ist dieser auch deutlich g&uuml;nstiger als Modellbaukraftstoff. Der Motor des BigFood verf&uuml;gt &uuml;ber einen Seilzugstarter, einer Treibstoffpumpe und einen Chocke. </p> <p class=\"bodytext\"><strong>Chassis:</strong> </p> <ul><li>L&auml;nge gesamt 700mm </li><li>H&ouml;he 350mm </li><li>Breite: Vorne 490mm / Hinten 510mm </li><li>Spurweite: Vorne 380mm / Hinten 410mm </li><li>Radstand 485mm </li><li>Bodenfreiheit 92mm </li><li>Gewicht 9,9kg </li><li>4mm Aluminiumchassis </li><li>bel&uuml;ftete Doppelscheibenbremse </li><li>Antrieb: geh&auml;rtete Metallzahnr&auml;der mit Schutzabdeckung </li><li>D&auml;mpfer: 2 verschiedene D&auml;mpfungen und einstellbare Federspannung </li><li>Differenzial: 4 Zahn&auml;der im abgedichteten Geh&auml;use </li></ul> <p class=\"bodytext\"><strong>Motor:</strong> </p> <ul><li>2 Takt Benzinmotor </li><li>Luftk&uuml;hlung </li><li>23ccm Hubraum </li><li>Maximale Leistung: 2,2PS </li><li>Treibstoff: Gemisch 25 (Benzin) : 1 (hochwertiges Zweitakt&ouml;l) </li><li>700ccm Treibstofftank </li><li>Seilzugstarter </li></ul> <p class=\"bodytext\"><strong>Fernsteuerung:</strong> </p> <ul><li>2 Kanal FM Fernsteuerung </li><li>Lenkservo: Starkes, wasserdichtes Servo mit 15kg Stellkraft </li><li>Gasservo: Starkes, wasserdichtes Servo mit 6kg Stallkraft </li></ul>','',0,'','Monster Truck BigFoot','Monster Truck BigFoot','Monster Truck BigFoot');
INSERT INTO products_description VALUES (4,2,'Sony HDR-HC1','<ul><li>10fach optischer Zoom</li><li>3 Megapixel CMOS-Sensor</li><li>14 bit HD DXP Analog/Digital-Wandler</li><li>2,7 Zoll Hybrid LCD-Monitor</li><li>123.000 Pixel</li><li>Steady Shot Bildstabilisator</li><li>Fotofunktion Fotos mit 1920 x 1440 Pixel</li><li>Speicherm&ouml;glichkeit auf Memory Stick Duo</li><li>Anschl&uuml;sse i.LlNK Ein- und Ausgang</li><li>USB</li><li>Komponenten-Ausgang</li><li>Audio/Video- und S-Video-Ausgang</li><li>Abmessungen 71 x 94 x 188 mm</li><li>Gewicht 670 g</li></ul>','',24,'','Sony HDR-HC1','Sony HDR-HC1','Sony HDR-HC1');
INSERT INTO products_description VALUES (4,1,'Sony HDR-HC1','The Sony Handycam HDR-HC1\'s real draw is its ability to record 1080i HD video on standard MiniDV cassettes; it uses the recently implemented HDV format, which employs MPEG-2 compression rather than DV. Not much software currently supports HDV for digitizing, and the packages that do tend to be expensive products such as Adobe Premiere Pro 1.5 and Apple Final Cut Pro 5.0. So the HC1 also provides HD-to-DV downconversion for editing or playback on a standard-def (SD) TV. Like its big brother, the HDR-FX1, it incorporates Sony\'s Cinematic mode for simulating the appearance of 24fps film. It can also record standard DV. The camcorder supports component-video output and supplies the necessary cables, but if you have a FireWire port on your TV, you\'ll get the best playback quality that way.<br /><br />For the HC1\'s sensor, Sony uses a 1/3-inch, 3-megapixel CMOS chip with an RGB filter array. That provides an effective 2.0 megapixels for HD shooting and stills, 1.5 megapixels for SD video, and 2.8 megapixels for 4:3 photos. Its Zeiss T* 10X zoom lens won\'t win any spec wars, but it\'s perfectly sufficient for most shots, and Sony boosts the zoom effectiveness with its Super SteadyShot electronic stabilization.<br /><br />The rest of the HC1\'s features compete respectably with those of most camcorders in the same price bracket. You can select among automatic, manual, or spot focus. The Expanded Focus button enlarges the center of the scene for easier manual focusing, and the Tele Macro button will defocus the background to bring out the subject. In addition to using automatic adjustment and a handful of exposure presets, you can manually adjust the exposure or select the shutter speed. Same goes for the white balance, which includes a manual color-bias slider within the menu system. A zebra-stripe overexposure display and a live histogram supplement your exposure options, and for low-light shooting, you can turn to Sony\'s infrared NightShot mode and Super NightShot, which uses infrared and the built-in video light. An on-camera flash works for still photography, and Sony\'s Active Interface Shoe allows for more accessories. You can adjust the audio levels manually, and the HC1 includes connectors for an external microphone and headphones.','',0,'','Sony HDR-HC1','Sony HDR-HC1','Sony HDR-HC1');
INSERT INTO products_description VALUES (4,5,'Sony HDR-HC1','<ul><li>10fach optischer Zoom</li><li>3 Megapixel CMOS-Sensor</li><li>14 bit HD DXP Analog/Digital-Wandler</li><li>2,7 Zoll Hybrid LCD-Monitor</li><li>123.000 Pixel</li><li>Steady Shot Bildstabilisator</li><li>Fotofunktion Fotos mit 1920 x 1440 Pixel</li><li>Speicherm&ouml;glichkeit auf Memory Stick Duo</li><li>Anschl&uuml;sse i.LlNK Ein- und Ausgang</li><li>USB</li><li>Komponenten-Ausgang</li><li>Audio/Video- und S-Video-Ausgang</li><li>Abmessungen 71 x 94 x 188 mm</li><li>Gewicht 670 g</li></ul>','',0,'','Sony HDR-HC1','Sony HDR-HC1','Sony HDR-HC1');
INSERT INTO products_description VALUES (4,4,'Sony HDR-HC1','<ul><li>10fach optischer Zoom</li><li>3 Megapixel CMOS-Sensor</li><li>14 bit HD DXP Analog/Digital-Wandler</li><li>2,7 Zoll Hybrid LCD-Monitor</li><li>123.000 Pixel</li><li>Steady Shot Bildstabilisator</li><li>Fotofunktion Fotos mit 1920 x 1440 Pixel</li><li>Speicherm&ouml;glichkeit auf Memory Stick Duo</li><li>Anschl&uuml;sse i.LlNK Ein- und Ausgang</li><li>USB</li><li>Komponenten-Ausgang</li><li>Audio/Video- und S-Video-Ausgang</li><li>Abmessungen 71 x 94 x 188 mm</li><li>Gewicht 670 g</li></ul>','',0,'','Sony HDR-HC1','Sony HDR-HC1','Sony HDR-HC1');
INSERT INTO products_description VALUES (4,3,'Sony HDR-HC1','<ul><li>10fach optischer Zoom</li><li>3 Megapixel CMOS-Sensor</li><li>14 bit HD DXP Analog/Digital-Wandler</li><li>2,7 Zoll Hybrid LCD-Monitor</li><li>123.000 Pixel</li><li>Steady Shot Bildstabilisator</li><li>Fotofunktion Fotos mit 1920 x 1440 Pixel</li><li>Speicherm&ouml;glichkeit auf Memory Stick Duo</li><li>Anschl&uuml;sse i.LlNK Ein- und Ausgang</li><li>USB</li><li>Komponenten-Ausgang</li><li>Audio/Video- und S-Video-Ausgang</li><li>Abmessungen 71 x 94 x 188 mm</li><li>Gewicht 670 g</li></ul>','',0,'','Sony HDR-HC1','Sony HDR-HC1','Sony HDR-HC1');
INSERT INTO products_description VALUES (5,2,'HP Compaq 2710p Notebook','<ul><li>Genuine Windows Vista&reg; Business</li><li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li><li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li><li>1 GB 667 MHz DDR2 SDRAM</li><li>60 GB 4200 rpm SMART PATA</li><li>Intel 802.11a/b/g<br /> Bluetooth 2.0</li><li>100 GB 4200 rpm SMART PATA</li></ul>','',54,'','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook');
INSERT INTO products_description VALUES (5,1,'HP Compaq 2710p Notebook','<ul><li>Genuine Windows Vista&reg; Business</li><li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li><li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li><li>1 GB 667 MHz DDR2 SDRAM</li><li>60 GB 4200 rpm SMART PATA</li><li>Intel 802.11a/b/g<br />  Bluetooth 2.0</li><li>100 GB 4200 rpm SMART PATA</li></ul>','',0,'','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook');
INSERT INTO products_description VALUES (5,5,'HP Compaq 2710p Notebook','<ul><li>Genuine Windows Vista&reg; Business</li><li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li><li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li><li>1 GB 667 MHz DDR2 SDRAM</li><li>60 GB 4200 rpm SMART PATA</li><li>Intel 802.11a/b/g<br />  Bluetooth 2.0</li><li>100 GB 4200 rpm SMART PATA</li></ul>','',0,'','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook');
INSERT INTO products_description VALUES (5,4,'HP Compaq 2710p Notebook','<ul><li>Genuine Windows Vista&reg; Business</li><li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li><li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li><li>1 GB 667 MHz DDR2 SDRAM</li><li>60 GB 4200 rpm SMART PATA</li><li>Intel 802.11a/b/g<br />  Bluetooth 2.0</li><li>100 GB 4200 rpm SMART PATA</li></ul>','',0,'','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook');
INSERT INTO products_description VALUES (5,3,'HP Compaq 2710p Notebook','<ul><li>Genuine Windows Vista&reg; Business</li><li>Intel&reg; Core&trade;2 Duo ULV processor U7500 1.06 GHz 2 MB L2 cache 533 MHz front side bus</li><li>12.1 in&nbsp;Illumi-Lite, WXGA UWVA, anti-glare with Digitizer</li><li>1 GB 667 MHz DDR2 SDRAM</li><li>60 GB 4200 rpm SMART PATA</li><li>Intel 802.11a/b/g<br />  Bluetooth 2.0</li><li>100 GB 4200 rpm SMART PATA</li></ul>','',0,'','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook','HP Compaq 2710p Notebook');
INSERT INTO products_description VALUES (6,2,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5&quot; wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.</p><p><strong>Ultra-portable design.</strong><br />The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.</p><p><strong>A truly mobile wireless companion.</strong><br />True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.</p><p><strong>Communication on the go.</strong><br />The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.</p><p><strong>Ingenious design.</strong><br />An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',145,'','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC');
INSERT INTO products_description VALUES (6,1,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5&quot; wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.<br /> </p><p><strong>Ultra-portable design.</strong><br /> The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.<br /> </p><p><strong>A truly mobile wireless companion.</strong><br /> True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.<br /> </p><p><strong>Communication on the go.</strong><br /> The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.<br /> </p><p><strong>Ingenious design.</strong><br /> An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',0,'','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC');
INSERT INTO products_description VALUES (6,5,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5&quot; wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.<br /> </p><p><strong>Ultra-portable design.</strong><br /> The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.<br /> </p><p><strong>A truly mobile wireless companion.</strong><br /> True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.<br /> </p><p><strong>Communication on the go.</strong><br /> The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.<br /> </p><p><strong>Ingenious design.</strong><br /> An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',0,'','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC');
INSERT INTO products_description VALUES (6,4,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5&quot; wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.<br /> </p><p><strong>Ultra-portable design.</strong><br /> The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.<br /> </p><p><strong>A truly mobile wireless companion.</strong><br /> True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.<br /> </p><p><strong>Communication on the go.</strong><br /> The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.<br /> </p><p><strong>Ingenious design.</strong><br /> An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',0,'','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC');
INSERT INTO products_description VALUES (6,3,'VAIO® UX Series Micro PC','<p>Lightweight heavyweight: The ultra-portable VAIO&reg; VGN-UX380N Micro PC, a handheld wonder that packs powerful computing into a compact size. The ingenious design is for more than just good looks-it\'s actually engineered for serious productivity on the go. Features include a 4.5&quot; wide SVGA display with XBRITE&reg; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing and Windows Vista&reg; Business on board. Of course, advanced wireless capabilities are built right in, and expansion is a breeze with the included port replicator. Integrated camera and microphone ensure that you can stay connected via VoIP.<br /> </p><p><strong>Ultra-portable design.</strong><br /> The VAIO&reg; UX Micro PC is so small and lightweight you won&rsquo;t believe it&rsquo;s a full-functioning PC. But this remarkably compact dynamo is designed for productivity on the go. With a 4.5&rdquo; wide SVGA11 (1024x600) display with XBRITE&trade; LCD technology, Intel&reg; Core&trade; Solo Ultra Low Voltage CPU for fast processing, and Windows Vista&trade; Business on board. Advanced Wireless capabilities are built right in, and expansion is a breeze with the included port replicator.<br /> </p><p><strong>A truly mobile wireless companion.</strong><br /> True mobility is about broad access, just as much as it is about slim, lightweight design. And the VAIO&reg; UX Micro PC is taking that access farther than ever before. With integrated wireless Wide Area Network (WAN)13 technology, you can access the Cingular Wireless EDGE network to extend your wireless coverage beyond LAN3 access networks and hotspots. And with integrated wireless LAN3 and Bluetooth&reg; technology5, the VAIO&reg; UX Micro PC gives you the freedom to go farther, do more, and stay connected.<br /> </p><p><strong>Communication on the go.</strong><br /> The VAIO&reg; UX Micro PC is communications-ready, with integrated camera and built-in microphone and speakers, so you&rsquo;re equipped to communicate via VoIP12 (Voice over Internet Protocol) virtually anywhere WLAN3 or WWAN13 service is available.<br /> </p><p><strong>Ingenious design.</strong><br /> An integrated keyboard and stylus allow you to choose the input method you prefer. VAIO&reg; Touch Launcher and Instant Command enable quick and easy program access, and the biometric fingerprint sensor stores your passwords so you can access applications and secure web sites without having to type them. And the UX Micro PC really makes smart use of all its display space. With control buttons for zooming, scrolling, and a stick pointer, as well as the ability to view in either landscape or portrait orientations, you know you&rsquo;ll be able to view documents, applications, and media in the most appropriate way.</p>','',0,'','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC','VAIO® UX Series Micro PC');
INSERT INTO products_description VALUES (7,2,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /><br />Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /><br />Dieses Speed Boot liegt super auf dem Wasser.<br /><br />Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /><br /><strong>Dynamic:</strong><br />Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /><br /><strong>Power:</strong><br />Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /><br /><strong>Energy:</strong><br />Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /><br /><strong>Controller:</strong><br />R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /><br /><strong>Lieferumfang:</strong><br />R/C Speed Boot Katamaran<br />Powerakku, Ni-cd 1700mAh 7.2V<br />6 x AA f&uuml;r die Fernsteuerung.<br />Ladeger&auml;t f&uuml;r den Akku<br />Fernsteuerung','',28,'','R/C Katamaran','R/C Katamaran','R/C Katamaran');
INSERT INTO products_description VALUES (7,1,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /> <br /> Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /> <br /> Dieses Speed Boot liegt super auf dem Wasser.<br /> <br /> Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /> <br /> <strong>Dynamic:</strong><br /> Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /> <br /> <strong>Power:</strong><br /> Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /> <br /> <strong>Energy:</strong><br /> Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /> <br /> <strong>Controller:</strong><br /> R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /> <br /> <strong>Lieferumfang:</strong><br /> R/C Speed Boot Katamaran<br /> Powerakku, Ni-cd 1700mAh 7.2V<br /> 6 x AA f&uuml;r die Fernsteuerung.<br /> Ladeger&auml;t f&uuml;r den Akku<br /> Fernsteuerung','',0,'','R/C Katamaran','R/C Katamaran','R/C Katamaran');
INSERT INTO products_description VALUES (7,5,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /> <br /> Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /> <br /> Dieses Speed Boot liegt super auf dem Wasser.<br /> <br /> Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /> <br /> <strong>Dynamic:</strong><br /> Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /> <br /> <strong>Power:</strong><br /> Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /> <br /> <strong>Energy:</strong><br /> Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /> <br /> <strong>Controller:</strong><br /> R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /> <br /> <strong>Lieferumfang:</strong><br /> R/C Speed Boot Katamaran<br /> Powerakku, Ni-cd 1700mAh 7.2V<br /> 6 x AA f&uuml;r die Fernsteuerung.<br /> Ladeger&auml;t f&uuml;r den Akku<br /> Fernsteuerung','',0,'','R/C Katamaran','R/C Katamaran','R/C Katamaran');
INSERT INTO products_description VALUES (7,4,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /> <br /> Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /> <br /> Dieses Speed Boot liegt super auf dem Wasser.<br /> <br /> Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /> <br /> <strong>Dynamic:</strong><br /> Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /> <br /> <strong>Power:</strong><br /> Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /> <br /> <strong>Energy:</strong><br /> Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /> <br /> <strong>Controller:</strong><br /> R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /> <br /> <strong>Lieferumfang:</strong><br /> R/C Speed Boot Katamaran<br /> Powerakku, Ni-cd 1700mAh 7.2V<br /> 6 x AA f&uuml;r die Fernsteuerung.<br /> Ladeger&auml;t f&uuml;r den Akku<br /> Fernsteuerung','',0,'','R/C Katamaran','R/C Katamaran','R/C Katamaran');
INSERT INTO products_description VALUES (7,3,'R/C Katamaran','Riesen gross: ca. 83cm lang, einfach RIESIG!!!<br /> <br /> Das ideale Geschenk f&uuml;r alle gro&szlig;en und kleinen Kinder.<br /> <br /> Dieses Speed Boot liegt super auf dem Wasser.<br /> <br /> Ein echter Hingucker gegen&uuml;ber den normalen Booten<br /> <br /> <strong>Dynamic:</strong><br /> Das optimale Spielzeug f&uuml;r jeden See oder am Meer! Seien Sie Ihr eigener Kapit&auml;n eines der modernsten RC Speedboot Katamaran die zur Zeit auf dem Markt erh&auml;ltlich sind. Durch die Dynamische Konstruktion werden die zwei High-Power Speed Motor des Typ 380 unterst&uuml;tzt. Hierdurch werden Geschwindigkeiten von bis zu 40km/h ereicht. Sie k&ouml;nnen gezielte Lenk- und Kurvenman&ouml;ver durchzuf&uuml;hren.<br /> <br /> <strong>Power:</strong><br /> Angetrieben wird das Speed Boot von 2 extrem starken Power-Speed Motoren des Typ 380. Sie entwickeln bei vollst&auml;ndig geladenem Akku extreme Kraft, die &uuml;ber die Antriebswellen auf die Schiffsschrauben &uuml;bertragen wird. Das Ergebnis ist ein extremer TOP SPEED und Fahrspass pur!!!<br /> <br /> <strong>Energy:</strong><br /> Power Akku-Pack mit 1700mAh &amp; 7,2Volt. Diese kraftvollen Zellen sorgen f&uuml;r grenzenlosen und lange Fahrspass. Bitte laden Sie die Akkus vollst&auml;ndig auf und lassen sie sich durch einen Dauerbetrieb wieder vollst&auml;ndig entladen, damit sorgen Sie f&uuml;r eine lange Lebensdauer der Zellen. Wiederholen Sie den Vorgang 2-3 Mal.<br /> <br /> <strong>Controller:</strong><br /> R/C Fernsteuerung. Damit haben Sie Ihr Turbo - Speed Boot voll im Griff! Ob schnelle Man&ouml;ver oder Rennen mit anderen Booten werden f&uuml;r Sie kein Problem darstellen.<br /> <br /> <strong>Lieferumfang:</strong><br /> R/C Speed Boot Katamaran<br /> Powerakku, Ni-cd 1700mAh 7.2V<br /> 6 x AA f&uuml;r die Fernsteuerung.<br /> Ladeger&auml;t f&uuml;r den Akku<br /> Fernsteuerung','',0,'','R/C Katamaran','R/C Katamaran','R/C Katamaran');

--
-- Table structure for table `products_notifications`
--

DROP TABLE IF EXISTS products_notifications;
CREATE TABLE products_notifications (
  products_id int(11) NOT NULL default '0',
  customers_id int(11) NOT NULL default '0',
  date_added datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (products_id,customers_id)
) TYPE=MyISAM;

--
-- Dumping data for table `products_notifications`
--

INSERT INTO products_notifications VALUES (0,2,'2007-12-13 17:27:31');

--
-- Table structure for table `products_options`
--

DROP TABLE IF EXISTS products_options;
CREATE TABLE products_options (
  products_options_id int(11) NOT NULL default '0',
  language_id int(11) NOT NULL default '1',
  products_options_name varchar(32) NOT NULL default '',
  products_options_type int(5) NOT NULL default '0',
  products_options_length smallint(2) NOT NULL default '32',
  products_options_comment varchar(128) default NULL,
  products_options_sort_order int(2) NOT NULL default '0',
  PRIMARY KEY  (products_options_id,language_id)
) TYPE=MyISAM;

--
-- Dumping data for table `products_options`
--

INSERT INTO products_options VALUES (1,2,'RAM',0,0,'',0);
INSERT INTO products_options VALUES (1,1,'RAM',0,0,'',0);
INSERT INTO products_options VALUES (1,5,'RAM',0,0,'',0);
INSERT INTO products_options VALUES (1,4,'RAM',0,0,'',0);
INSERT INTO products_options VALUES (1,3,'RAM',0,0,'',0);
INSERT INTO products_options VALUES (2,5,'Disc dur',0,0,'',0);
INSERT INTO products_options VALUES (2,1,'Hard Disk',0,0,'',0);
INSERT INTO products_options VALUES (2,2,'Festplatte',0,0,'',0);
INSERT INTO products_options VALUES (2,4,'Hard Disk',0,0,'',0);
INSERT INTO products_options VALUES (2,3,'Hard Disk',0,0,'',0);
INSERT INTO products_options VALUES (3,2,'Betriebssystem',0,0,'',0);
INSERT INTO products_options VALUES (3,1,'Operating System',0,0,'',0);
INSERT INTO products_options VALUES (3,5,'Operating System',0,0,'',0);
INSERT INTO products_options VALUES (3,4,'Operating System',0,0,'',0);
INSERT INTO products_options VALUES (3,3,'Operating System',0,0,'',0);

--
-- Table structure for table `products_options_values`
--

DROP TABLE IF EXISTS products_options_values;
CREATE TABLE products_options_values (
  products_options_values_id int(11) NOT NULL default '0',
  language_id int(11) NOT NULL default '1',
  products_options_values_name varchar(64) NOT NULL default '',
  PRIMARY KEY  (products_options_values_id,language_id)
) TYPE=MyISAM;

--
-- Dumping data for table `products_options_values`
--

INSERT INTO products_options_values VALUES (1,2,'1 GB 667 MHz DDR2 SDRAM');
INSERT INTO products_options_values VALUES (1,1,'1 GB 667 MHz DDR2 SDRAM');
INSERT INTO products_options_values VALUES (1,5,'1 GB 667 MHz DDR2 SDRAM');
INSERT INTO products_options_values VALUES (1,4,'1 GB 667 MHz DDR2 SDRAM');
INSERT INTO products_options_values VALUES (1,3,'1 GB 667 MHz DDR2 SDRAM');
INSERT INTO products_options_values VALUES (2,2,'2 GB 667 MHz DDR2 SDRAM');
INSERT INTO products_options_values VALUES (2,1,'2 GB 667 MHz DDR2 SDRAM');
INSERT INTO products_options_values VALUES (2,5,'2 GB 667 MHz DDR2 SDRAM');
INSERT INTO products_options_values VALUES (2,4,'2 GB 667 MHz DDR2 SDRAM');
INSERT INTO products_options_values VALUES (2,3,'2 GB 667 MHz DDR2 SDRAM');
INSERT INTO products_options_values VALUES (3,2,'60 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (3,1,'60 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (3,5,'60 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (3,4,'60 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (3,3,'60 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (4,2,'80 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (4,1,'80 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (4,5,'80 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (4,4,'80 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (4,3,'80 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (5,2,'100 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (5,1,'100 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (5,5,'100 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (5,4,'100 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (5,3,'100 GB 4200 rpm SMART PATA');
INSERT INTO products_options_values VALUES (6,2,'Windows XP Business');
INSERT INTO products_options_values VALUES (6,1,'Windows XP Business');
INSERT INTO products_options_values VALUES (6,5,'Windows XP Business');
INSERT INTO products_options_values VALUES (6,4,'Windows XP Business');
INSERT INTO products_options_values VALUES (6,3,'Windows XP Business');
INSERT INTO products_options_values VALUES (7,2,'Windows Vista® Business');
INSERT INTO products_options_values VALUES (7,1,'Windows Vista® Business');
INSERT INTO products_options_values VALUES (7,5,'Windows Vista® Business');
INSERT INTO products_options_values VALUES (7,4,'Windows Vista® Business');
INSERT INTO products_options_values VALUES (7,3,'Windows Vista® Business');
INSERT INTO products_options_values VALUES (8,2,'Linux openSUSE 10.3');
INSERT INTO products_options_values VALUES (8,1,'Linux openSUSE 10.3');
INSERT INTO products_options_values VALUES (8,5,'Linux openSUSE 10.3');
INSERT INTO products_options_values VALUES (8,4,'Linux openSUSE 10.3');
INSERT INTO products_options_values VALUES (8,3,'Linux openSUSE 10.3');
INSERT INTO products_options_values VALUES (9,2,'Linux Ubuntu Gibbon 7.10');
INSERT INTO products_options_values VALUES (9,1,'Linux Ubuntu Gibbon 7.10');
INSERT INTO products_options_values VALUES (9,5,'Linux Ubuntu Gibbon 7.10');
INSERT INTO products_options_values VALUES (9,4,'Linux Ubuntu Gibbon 7.10');
INSERT INTO products_options_values VALUES (9,3,'Linux Ubuntu Gibbon 7.10');
INSERT INTO products_options_values VALUES (10,2,'Bitte wählen');
INSERT INTO products_options_values VALUES (10,1,'Please choose');
INSERT INTO products_options_values VALUES (10,5,'Veuillez choisir');
INSERT INTO products_options_values VALUES (10,4,'Please choose');
INSERT INTO products_options_values VALUES (10,3,'Please choose');

--
-- Table structure for table `products_options_values_to_products_options`
--

DROP TABLE IF EXISTS products_options_values_to_products_options;
CREATE TABLE products_options_values_to_products_options (
  products_options_values_to_products_options_id int(11) NOT NULL auto_increment,
  products_options_id int(11) NOT NULL default '0',
  products_options_values_id int(11) NOT NULL default '0',
  PRIMARY KEY  (products_options_values_to_products_options_id)
) TYPE=MyISAM;

--
-- Dumping data for table `products_options_values_to_products_options`
--

INSERT INTO products_options_values_to_products_options VALUES (1,1,1);
INSERT INTO products_options_values_to_products_options VALUES (2,1,2);
INSERT INTO products_options_values_to_products_options VALUES (3,2,3);
INSERT INTO products_options_values_to_products_options VALUES (4,2,4);
INSERT INTO products_options_values_to_products_options VALUES (5,2,5);
INSERT INTO products_options_values_to_products_options VALUES (6,3,6);
INSERT INTO products_options_values_to_products_options VALUES (7,3,7);
INSERT INTO products_options_values_to_products_options VALUES (8,3,8);
INSERT INTO products_options_values_to_products_options VALUES (9,3,9);
INSERT INTO products_options_values_to_products_options VALUES (10,3,10);

--
-- Table structure for table `products_to_categories`
--

DROP TABLE IF EXISTS products_to_categories;
CREATE TABLE products_to_categories (
  products_id int(11) NOT NULL default '0',
  categories_id int(11) NOT NULL default '0',
  PRIMARY KEY  (products_id,categories_id)
) TYPE=MyISAM;

--
-- Dumping data for table `products_to_categories`
--

INSERT INTO products_to_categories VALUES (1,1);
INSERT INTO products_to_categories VALUES (2,1);
INSERT INTO products_to_categories VALUES (4,2);
INSERT INTO products_to_categories VALUES (5,2);
INSERT INTO products_to_categories VALUES (6,2);
INSERT INTO products_to_categories VALUES (7,1);

--
-- Table structure for table `products_xsell`
--

DROP TABLE IF EXISTS products_xsell;
CREATE TABLE products_xsell (
  ID int(10) NOT NULL auto_increment,
  products_id int(10) unsigned NOT NULL default '1',
  xsell_id int(10) unsigned NOT NULL default '1',
  sort_order int(10) unsigned NOT NULL default '1',
  PRIMARY KEY  (ID)
) TYPE=MyISAM;

--
-- Dumping data for table `products_xsell`
--

INSERT INTO products_xsell VALUES (7,1,5,2);
INSERT INTO products_xsell VALUES (6,1,2,1);
INSERT INTO products_xsell VALUES (3,4,2,1);
INSERT INTO products_xsell VALUES (4,4,5,2);
INSERT INTO products_xsell VALUES (5,4,6,3);
INSERT INTO products_xsell VALUES (8,1,7,3);

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
  reviews_id int(11) NOT NULL auto_increment,
  products_id int(11) NOT NULL default '0',
  customers_id int(11) default NULL,
  customers_name varchar(64) NOT NULL default '',
  reviews_rating int(1) default NULL,
  date_added datetime default NULL,
  last_modified datetime default NULL,
  reviews_read int(5) NOT NULL default '0',
  PRIMARY KEY  (reviews_id)
) TYPE=MyISAM;

--
-- Dumping data for table `reviews`
--


--
-- Table structure for table `reviews_description`
--

DROP TABLE IF EXISTS reviews_description;
CREATE TABLE reviews_description (
  reviews_id int(11) NOT NULL default '0',
  languages_id int(11) NOT NULL default '0',
  reviews_text text NOT NULL,
  PRIMARY KEY  (reviews_id,languages_id)
) TYPE=MyISAM;

--
-- Dumping data for table `reviews_description`
--


--
-- Table structure for table `saferpay_transactions`
--

DROP TABLE IF EXISTS saferpay_transactions;
CREATE TABLE saferpay_transactions (
  trans_id int(11) NOT NULL auto_increment,
  customers_id int(11) NOT NULL default '0',
  orders_id int(11) NOT NULL default '0',
  saferpay_ID varchar(96) default NULL,
  saferpay_amount decimal(15,4) NOT NULL default '0.0000',
  saferpay_currency varchar(8) NOT NULL default '',
  saferpay_provider_id int(11) default '0',
  saferpay_provider_name varchar(255) default NULL,
  saferpay_complete int(1) NOT NULL default '0',
  saferpay_complete_result varchar(255) default NULL,
  date_added datetime default NULL,
  last_modified datetime default NULL,
  PRIMARY KEY  (trans_id),
  KEY IDX_CUSTOMERS (customers_id),
  KEY IDX_ORDER (orders_id),
  KEY IDX_SAFERPAY_ID (saferpay_ID)
) TYPE=MyISAM;

--
-- Dumping data for table `saferpay_transactions`
--


--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (
  sesskey varchar(32) NOT NULL default '',
  expiry int(11) unsigned NOT NULL default '0',
  value text NOT NULL,
  PRIMARY KEY  (sesskey)
) TYPE=MyISAM;

--
-- Dumping data for table `sessions`
--


--
-- Table structure for table `specials`
--

DROP TABLE IF EXISTS specials;
CREATE TABLE specials (
  specials_id int(11) NOT NULL auto_increment,
  products_id int(11) NOT NULL default '0',
  specials_new_products_price decimal(15,4) NOT NULL default '0.0000',
  specials_date_added datetime default NULL,
  specials_last_modified datetime default NULL,
  expires_date datetime default NULL,
  date_status_change datetime default NULL,
  status int(1) NOT NULL default '1',
  PRIMARY KEY  (specials_id),
  KEY IDX_SPECIALS_PRODUCTS_ID (products_id)
) TYPE=MyISAM;

--
-- Dumping data for table `specials`
--

INSERT INTO specials VALUES (1,7,'64.9628','2007-11-05 06:16:02','2007-11-05 06:16:38','0000-00-00 00:00:00',NULL,1);

--
-- Table structure for table `tax_class`
--

DROP TABLE IF EXISTS tax_class;
CREATE TABLE tax_class (
  tax_class_id int(11) NOT NULL auto_increment,
  tax_class_title varchar(32) NOT NULL default '',
  tax_class_description varchar(255) NOT NULL default '',
  last_modified datetime default NULL,
  date_added datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (tax_class_id)
) TYPE=MyISAM;

--
-- Dumping data for table `tax_class`
--

INSERT INTO tax_class VALUES (1,'7.6% MwSt.','7.6% MwSt.','2007-08-07 22:43:29','2007-06-12 22:50:01');

--
-- Table structure for table `tax_rates`
--

DROP TABLE IF EXISTS tax_rates;
CREATE TABLE tax_rates (
  tax_rates_id int(11) NOT NULL auto_increment,
  tax_zone_id int(11) NOT NULL default '0',
  tax_class_id int(11) NOT NULL default '0',
  tax_priority int(5) default '1',
  tax_rate decimal(7,4) NOT NULL default '0.0000',
  tax_description varchar(255) NOT NULL default '',
  last_modified datetime default NULL,
  date_added datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (tax_rates_id)
) TYPE=MyISAM;

--
-- Dumping data for table `tax_rates`
--

INSERT INTO tax_rates VALUES (1,1,1,1,'7.6000','7.6% MwSt.','2007-08-07 22:43:02','2007-06-12 22:50:01');

--
-- Table structure for table `whos_online`
--

DROP TABLE IF EXISTS whos_online;
CREATE TABLE whos_online (
  customer_id int(11) default NULL,
  full_name varchar(64) NOT NULL default '',
  session_id varchar(128) NOT NULL default '',
  ip_address varchar(15) NOT NULL default '',
  time_entry varchar(14) NOT NULL default '',
  time_last_click varchar(14) NOT NULL default '',
  last_page_url varchar(255) NOT NULL default ''
) TYPE=MyISAM;

--
-- Dumping data for table `whos_online`
--

INSERT INTO whos_online VALUES (0,'Guest','60e43cd724f47f9f89c48330b88b5342','127.0.0.1','1201120055','1201120331','/swisscart/trunk/index.php?osCsid=60e43cd724f47f9f89c48330b88b5342');

--
-- Table structure for table `zones`
--

DROP TABLE IF EXISTS zones;
CREATE TABLE zones (
  zone_id int(11) NOT NULL auto_increment,
  zone_country_id int(11) NOT NULL default '0',
  zone_code varchar(32) NOT NULL default '',
  zone_name varchar(32) NOT NULL default '',
  PRIMARY KEY  (zone_id)
) TYPE=MyISAM;

--
-- Dumping data for table `zones`
--

INSERT INTO zones VALUES (1,223,'AL','Alabama');
INSERT INTO zones VALUES (2,223,'AK','Alaska');
INSERT INTO zones VALUES (3,223,'AS','American Samoa');
INSERT INTO zones VALUES (4,223,'AZ','Arizona');
INSERT INTO zones VALUES (5,223,'AR','Arkansas');
INSERT INTO zones VALUES (6,223,'AF','Armed Forces Africa');
INSERT INTO zones VALUES (7,223,'AA','Armed Forces Americas');
INSERT INTO zones VALUES (8,223,'AC','Armed Forces Canada');
INSERT INTO zones VALUES (9,223,'AE','Armed Forces Europe');
INSERT INTO zones VALUES (10,223,'AM','Armed Forces Middle East');
INSERT INTO zones VALUES (11,223,'AP','Armed Forces Pacific');
INSERT INTO zones VALUES (12,223,'CA','California');
INSERT INTO zones VALUES (13,223,'CO','Colorado');
INSERT INTO zones VALUES (14,223,'CT','Connecticut');
INSERT INTO zones VALUES (15,223,'DE','Delaware');
INSERT INTO zones VALUES (16,223,'DC','District of Columbia');
INSERT INTO zones VALUES (17,223,'FM','Federated States Of Micronesia');
INSERT INTO zones VALUES (18,223,'FL','Florida');
INSERT INTO zones VALUES (19,223,'GA','Georgia');
INSERT INTO zones VALUES (20,223,'GU','Guam');
INSERT INTO zones VALUES (21,223,'HI','Hawaii');
INSERT INTO zones VALUES (22,223,'ID','Idaho');
INSERT INTO zones VALUES (23,223,'IL','Illinois');
INSERT INTO zones VALUES (24,223,'IN','Indiana');
INSERT INTO zones VALUES (25,223,'IA','Iowa');
INSERT INTO zones VALUES (26,223,'KS','Kansas');
INSERT INTO zones VALUES (27,223,'KY','Kentucky');
INSERT INTO zones VALUES (28,223,'LA','Louisiana');
INSERT INTO zones VALUES (29,223,'ME','Maine');
INSERT INTO zones VALUES (30,223,'MH','Marshall Islands');
INSERT INTO zones VALUES (31,223,'MD','Maryland');
INSERT INTO zones VALUES (32,223,'MA','Massachusetts');
INSERT INTO zones VALUES (33,223,'MI','Michigan');
INSERT INTO zones VALUES (34,223,'MN','Minnesota');
INSERT INTO zones VALUES (35,223,'MS','Mississippi');
INSERT INTO zones VALUES (36,223,'MO','Missouri');
INSERT INTO zones VALUES (37,223,'MT','Montana');
INSERT INTO zones VALUES (38,223,'NE','Nebraska');
INSERT INTO zones VALUES (39,223,'NV','Nevada');
INSERT INTO zones VALUES (40,223,'NH','New Hampshire');
INSERT INTO zones VALUES (41,223,'NJ','New Jersey');
INSERT INTO zones VALUES (42,223,'NM','New Mexico');
INSERT INTO zones VALUES (43,223,'NY','New York');
INSERT INTO zones VALUES (44,223,'NC','North Carolina');
INSERT INTO zones VALUES (45,223,'ND','North Dakota');
INSERT INTO zones VALUES (46,223,'MP','Northern Mariana Islands');
INSERT INTO zones VALUES (47,223,'OH','Ohio');
INSERT INTO zones VALUES (48,223,'OK','Oklahoma');
INSERT INTO zones VALUES (49,223,'OR','Oregon');
INSERT INTO zones VALUES (50,223,'PW','Palau');
INSERT INTO zones VALUES (51,223,'PA','Pennsylvania');
INSERT INTO zones VALUES (52,223,'PR','Puerto Rico');
INSERT INTO zones VALUES (53,223,'RI','Rhode Island');
INSERT INTO zones VALUES (54,223,'SC','South Carolina');
INSERT INTO zones VALUES (55,223,'SD','South Dakota');
INSERT INTO zones VALUES (56,223,'TN','Tennessee');
INSERT INTO zones VALUES (57,223,'TX','Texas');
INSERT INTO zones VALUES (58,223,'UT','Utah');
INSERT INTO zones VALUES (59,223,'VT','Vermont');
INSERT INTO zones VALUES (60,223,'VI','Virgin Islands');
INSERT INTO zones VALUES (61,223,'VA','Virginia');
INSERT INTO zones VALUES (62,223,'WA','Washington');
INSERT INTO zones VALUES (63,223,'WV','West Virginia');
INSERT INTO zones VALUES (64,223,'WI','Wisconsin');
INSERT INTO zones VALUES (65,223,'WY','Wyoming');
INSERT INTO zones VALUES (66,38,'AB','Alberta');
INSERT INTO zones VALUES (67,38,'BC','British Columbia');
INSERT INTO zones VALUES (68,38,'MB','Manitoba');
INSERT INTO zones VALUES (69,38,'NF','Newfoundland');
INSERT INTO zones VALUES (70,38,'NB','New Brunswick');
INSERT INTO zones VALUES (71,38,'NS','Nova Scotia');
INSERT INTO zones VALUES (72,38,'NT','Northwest Territories');
INSERT INTO zones VALUES (73,38,'NU','Nunavut');
INSERT INTO zones VALUES (74,38,'ON','Ontario');
INSERT INTO zones VALUES (75,38,'PE','Prince Edward Island');
INSERT INTO zones VALUES (76,38,'QC','Quebec');
INSERT INTO zones VALUES (77,38,'SK','Saskatchewan');
INSERT INTO zones VALUES (78,38,'YT','Yukon Territory');
INSERT INTO zones VALUES (79,81,'NDS','Niedersachsen');
INSERT INTO zones VALUES (80,81,'BAW','Baden-Württemberg');
INSERT INTO zones VALUES (81,81,'BAY','Bayern');
INSERT INTO zones VALUES (82,81,'BER','Berlin');
INSERT INTO zones VALUES (83,81,'BRG','Brandenburg');
INSERT INTO zones VALUES (84,81,'BRE','Bremen');
INSERT INTO zones VALUES (85,81,'HAM','Hamburg');
INSERT INTO zones VALUES (86,81,'HES','Hessen');
INSERT INTO zones VALUES (87,81,'MEC','Mecklenburg-Vorpommern');
INSERT INTO zones VALUES (88,81,'NRW','Nordrhein-Westfalen');
INSERT INTO zones VALUES (89,81,'RHE','Rheinland-Pfalz');
INSERT INTO zones VALUES (90,81,'SAR','Saarland');
INSERT INTO zones VALUES (91,81,'SAS','Sachsen');
INSERT INTO zones VALUES (92,81,'SAC','Sachsen-Anhalt');
INSERT INTO zones VALUES (93,81,'SCN','Schleswig-Holstein');
INSERT INTO zones VALUES (94,81,'THE','Thüringen');
INSERT INTO zones VALUES (95,14,'WI','Wien');
INSERT INTO zones VALUES (96,14,'NO','Niederösterreich');
INSERT INTO zones VALUES (97,14,'OO','Oberösterreich');
INSERT INTO zones VALUES (98,14,'SB','Salzburg');
INSERT INTO zones VALUES (99,14,'KN','Kärnten');
INSERT INTO zones VALUES (100,14,'ST','Steiermark');
INSERT INTO zones VALUES (101,14,'TI','Tirol');
INSERT INTO zones VALUES (102,14,'BL','Burgenland');
INSERT INTO zones VALUES (103,14,'VB','Voralberg');
INSERT INTO zones VALUES (104,204,'AG','Aargau');
INSERT INTO zones VALUES (105,204,'AI','Appenzell Innerrhoden');
INSERT INTO zones VALUES (106,204,'AR','Appenzell Ausserrhoden');
INSERT INTO zones VALUES (107,204,'BE','Bern');
INSERT INTO zones VALUES (108,204,'BL','Basel-Landschaft');
INSERT INTO zones VALUES (109,204,'BS','Basel-Stadt');
INSERT INTO zones VALUES (110,204,'FR','Freiburg');
INSERT INTO zones VALUES (111,204,'GE','Genf');
INSERT INTO zones VALUES (112,204,'GL','Glarus');
INSERT INTO zones VALUES (113,204,'JU','Graubünden');
INSERT INTO zones VALUES (114,204,'JU','Jura');
INSERT INTO zones VALUES (115,204,'LU','Luzern');
INSERT INTO zones VALUES (116,204,'NE','Neuenburg');
INSERT INTO zones VALUES (117,204,'NW','Nidwalden');
INSERT INTO zones VALUES (118,204,'OW','Obwalden');
INSERT INTO zones VALUES (119,204,'SG','St. Gallen');
INSERT INTO zones VALUES (120,204,'SH','Schaffhausen');
INSERT INTO zones VALUES (121,204,'SO','Solothurn');
INSERT INTO zones VALUES (122,204,'SZ','Schwyz');
INSERT INTO zones VALUES (123,204,'TG','Thurgau');
INSERT INTO zones VALUES (124,204,'TI','Tessin');
INSERT INTO zones VALUES (125,204,'UR','Uri');
INSERT INTO zones VALUES (126,204,'VD','Waadt');
INSERT INTO zones VALUES (127,204,'VS','Wallis');
INSERT INTO zones VALUES (128,204,'ZG','Zug');
INSERT INTO zones VALUES (129,204,'ZH','Zürich');
INSERT INTO zones VALUES (130,195,'A Coruña','A Coruña');
INSERT INTO zones VALUES (131,195,'Alava','Alava');
INSERT INTO zones VALUES (132,195,'Albacete','Albacete');
INSERT INTO zones VALUES (133,195,'Alicante','Alicante');
INSERT INTO zones VALUES (134,195,'Almeria','Almeria');
INSERT INTO zones VALUES (135,195,'Asturias','Asturias');
INSERT INTO zones VALUES (136,195,'Avila','Avila');
INSERT INTO zones VALUES (137,195,'Badajoz','Badajoz');
INSERT INTO zones VALUES (138,195,'Baleares','Baleares');
INSERT INTO zones VALUES (139,195,'Barcelona','Barcelona');
INSERT INTO zones VALUES (140,195,'Burgos','Burgos');
INSERT INTO zones VALUES (141,195,'Caceres','Caceres');
INSERT INTO zones VALUES (142,195,'Cadiz','Cadiz');
INSERT INTO zones VALUES (143,195,'Cantabria','Cantabria');
INSERT INTO zones VALUES (144,195,'Castellon','Castellon');
INSERT INTO zones VALUES (145,195,'Ceuta','Ceuta');
INSERT INTO zones VALUES (146,195,'Ciudad Real','Ciudad Real');
INSERT INTO zones VALUES (147,195,'Cordoba','Cordoba');
INSERT INTO zones VALUES (148,195,'Cuenca','Cuenca');
INSERT INTO zones VALUES (149,195,'Girona','Girona');
INSERT INTO zones VALUES (150,195,'Granada','Granada');
INSERT INTO zones VALUES (151,195,'Guadalajara','Guadalajara');
INSERT INTO zones VALUES (152,195,'Guipuzcoa','Guipuzcoa');
INSERT INTO zones VALUES (153,195,'Huelva','Huelva');
INSERT INTO zones VALUES (154,195,'Huesca','Huesca');
INSERT INTO zones VALUES (155,195,'Jaen','Jaen');
INSERT INTO zones VALUES (156,195,'La Rioja','La Rioja');
INSERT INTO zones VALUES (157,195,'Las Palmas','Las Palmas');
INSERT INTO zones VALUES (158,195,'Leon','Leon');
INSERT INTO zones VALUES (159,195,'Lleida','Lleida');
INSERT INTO zones VALUES (160,195,'Lugo','Lugo');
INSERT INTO zones VALUES (161,195,'Madrid','Madrid');
INSERT INTO zones VALUES (162,195,'Malaga','Malaga');
INSERT INTO zones VALUES (163,195,'Melilla','Melilla');
INSERT INTO zones VALUES (164,195,'Murcia','Murcia');
INSERT INTO zones VALUES (165,195,'Navarra','Navarra');
INSERT INTO zones VALUES (166,195,'Ourense','Ourense');
INSERT INTO zones VALUES (167,195,'Palencia','Palencia');
INSERT INTO zones VALUES (168,195,'Pontevedra','Pontevedra');
INSERT INTO zones VALUES (169,195,'Salamanca','Salamanca');
INSERT INTO zones VALUES (170,195,'Santa Cruz de Tenerife','Santa Cruz de Tenerife');
INSERT INTO zones VALUES (171,195,'Segovia','Segovia');
INSERT INTO zones VALUES (172,195,'Sevilla','Sevilla');
INSERT INTO zones VALUES (173,195,'Soria','Soria');
INSERT INTO zones VALUES (174,195,'Tarragona','Tarragona');
INSERT INTO zones VALUES (175,195,'Teruel','Teruel');
INSERT INTO zones VALUES (176,195,'Toledo','Toledo');
INSERT INTO zones VALUES (177,195,'Valencia','Valencia');
INSERT INTO zones VALUES (178,195,'Valladolid','Valladolid');
INSERT INTO zones VALUES (179,195,'Vizcaya','Vizcaya');
INSERT INTO zones VALUES (180,195,'Zamora','Zamora');
INSERT INTO zones VALUES (181,195,'Zaragoza','Zaragoza');

--
-- Table structure for table `zones_to_geo_zones`
--

DROP TABLE IF EXISTS zones_to_geo_zones;
CREATE TABLE zones_to_geo_zones (
  association_id int(11) NOT NULL auto_increment,
  zone_country_id int(11) NOT NULL default '0',
  zone_id int(11) default NULL,
  geo_zone_id int(11) default NULL,
  last_modified datetime default NULL,
  date_added datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (association_id)
) TYPE=MyISAM;

--
-- Dumping data for table `zones_to_geo_zones`
--

INSERT INTO zones_to_geo_zones VALUES (1,204,NULL,1,'2007-08-07 22:42:29','2007-06-12 22:50:01');
INSERT INTO zones_to_geo_zones VALUES (2,122,0,1,NULL,'2007-08-07 22:42:38');

