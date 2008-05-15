<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 osCommerce
  Copyright (c) 2003 Rodolphe Quiedeville <rodolphe@quiedeville.org>
  Copyright (c) 2008 Nick Weisser <nick@openstream.ch>  

  Author : Rodolphe Quiedeville <rodolphe@quiedeville.org>
  Customized by : Nick Weisser <nick@openstream.ch>  

  Released under the GNU General Public License

  Usage : call /catalog/rss.php?box=BOX_NAME
  If no BOX_NAME specified we use whats_new by default

  Remember to define in configure.php :

  define('DIR_WS_RSS', DIR_WS_INCLUDES . 'rss/');

  TODO : set channel description correctly
*/

header("Content-type: application/rss+xml");

require('includes/application_top.php');

print '<?xml version="1.0" encoding="iso-8859-1"?>' . "\n";
print '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">' . "\n";
print '  <channel>' . "\n";
print "    <title>".STORE_NAME.": New products</title>\n";
print "    <description>This feed lists all our latest products</description>\n";
//print "    <source></source>\n";
print "    <link>".HTTP_SERVER.FILENAME_PRODUCTS_NEW."</link>\n";
print '    <atom:link href="'.HTTP_SERVER.'/whats_new.xml" rel="self" type="application/rss+xml" />' . "\n";
// todo: insert ISO-639 language code
//print "    <language>".$language."</language>\n\n";


require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_DEFAULT);

if (!strlen($box))
{
  $box = "whats_new";
}

$file = DIR_WS_RSS . $box . '.php';

if (file_exists($file))
{
  require($file); 
}

print "  </channel>\n";
print "</rss>\n";

?>

