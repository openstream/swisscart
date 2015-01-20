<?php
/*
  $Id: application.php,v 1.5 2003/07/09 01:11:05 hpdl Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Customized by swisscart®, Swiss Webshop Solutions
  http://www.swisscart.com

  Copyright (c) 2003-2007 osCommerce

  Released under the GNU General Public License
*/

// Set the level of error reporting
  error_reporting(E_ALL & ~E_NOTICE);

// Check if register_globals is enabled.
// Since this is a temporary measure this message is hardcoded. The requirement will be removed before 2.2 is finalized.
/*  if (function_exists('ini_get')) {
    ini_get('register_globals') or exit('FATAL ERROR: register_globals is disabled in php.ini, please enable it!');
  }*/

// parse request get,post
  $HTTP_GET_VARS = array();
  $HTTP_POST_VARS = array();    
  if( is_object($_REQUEST)) {
  	$a = get_object_vars($_REQUEST);
  } else {
  	$a = $_REQUEST;
  }  
  $k = array_keys($a);
  $v = array_values($a);
  
  for($i=0; $i<count($k); $i++) {
  	$$k[$i] = $v[$i]; // globalize
  	if( isset($_GET[$k[$i]]))
  		$HTTP_GET_VARS[$k[$i]] = $v[$i];
  	if( isset($_POST[$k[$i]]))
  		$HTTP_POST_VARS[$k[$i]] = $v[$i];
  }
  
  // maybe this is not needed:
  $HTTP_COOKIE_VARS = array();
  // parse cookie
  if( is_object($_COOKIE)) {
  	$a = get_object_vars($_COOKIE);
  } else {
  	$a = $_COOKIE;
  }  
  $k = array_keys($a);
  $v = array_values($a);
  
  for($i=0; $i<count($k); $i++) {
  	$HTTP_COOKIE_VARS[$k[$i]] = $v[$i];
  }
  

  require('includes/functions/general.php');
  require('includes/functions/database.php');
  require('includes/functions/html_output.php');
?>
