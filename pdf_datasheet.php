<?php
/*
  $Id: pdf_datasheet_creator v1.1 2003/03/11 13:46:29 ip chilipepper.it Exp $
  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com
  Copyright (c) 2003 osCommerce
  Released under the GNU General Public License
*/

// start the timer for the page parse time log
define('PAGE_PARSE_START_TIME', microtime());

require('includes/application_top.php');
require(DIR_WS_INCLUDES . 'pdf/pdf_datasheet_functions.php');

?>