<?php
/*
  $Id: application_bottom.php,v 1.14 2003/02/10 22:30:41 hpdl Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Customized by swisscart®, Swiss Webshop Solutions
  http://www.swisscart.com

  Copyright (c) 2003-2007 osCommerce

  Released under the GNU General Public License
*/

// STS
  if ($sts->display_template_output) {
	$sts->stop_capture();
	include DIR_WS_MODULES.'sts_inc/sts_display_output.php';
  }

// close session (store variables)
  tep_session_close();

  if (STORE_PAGE_PARSE_TIME == 'true') {
    $time_start = explode(' ', PAGE_PARSE_START_TIME);
    $time_end = explode(' ', microtime());
    $parse_time = number_format(($time_end[1] + $time_end[0] - ($time_start[1] + $time_start[0])), 3);
    error_log(strftime(STORE_PARSE_DATE_TIME_FORMAT) . ' - ' . getenv('REQUEST_URI') . ' (' . $parse_time . 's)' . "\n", 3, STORE_PAGE_PARSE_TIME_LOG);

    if (DISPLAY_PAGE_PARSE_TIME == 'true') {
      echo '<span class="smallText">Parse Time: ' . $parse_time . 's</span>';
    }
  }

  if ( (GZIP_COMPRESSION == 'true') && ($ext_zlib_loaded == true) && ($ini_zlib_output_compression < 1) ) {
    if ( (PHP_VERSION < '4.0.4') && (PHP_VERSION >= '4') ) {
      tep_gzip_output(GZIP_LEVEL);
    }
  }

// SEO debug
  if ( $_REQUEST['profile'] == 'on' || $_SESSION['profile'] == 'on' ) {
          $_SESSION['profile'] = isset($_REQUEST['profile']) ? $_REQUEST['profile'] : 'on';
        $seo_urls->profile();
  }
  
// general debugging
  if(DEBUGGING_ENABLED == 'true') {
	echo '<div style="padding-top: 50px; height: 500px; padding: 25px; margin: 25px; overflow: auto; border: 1px solid black; ">';
	echo '<h1 style="font-size: 24px; color: red; ">This is the $GLOBALS array</h1>';
	echo '<pre style="text-align: left; background: #fff; color: #000; >';
	print_r($GLOBALS);
	echo '</pre></div>';
  }   
?>