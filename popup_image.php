<?php
/*
  $Id: popup_image.php,v 1.18 2003/06/05 23:26:23 hpdl Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Customized by swisscart®, Swiss Webshop Solutions
  http://www.swisscart.com

  Copyright (c) 2003-2007 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  $navigation->remove_current_page();

  $products_query = tep_db_query("select pd.products_name, p.products_image from " . TABLE_PRODUCTS . " p left join " . TABLE_PRODUCTS_DESCRIPTION . " pd on p.products_id = pd.products_id where p.products_status = '1' and p.products_id = '" . (int)$HTTP_GET_VARS['pID'] . "' and pd.language_id = '" . (int)$languages_id . "'");
  $products = tep_db_fetch_array($products_query);
?>
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">
<html <?php echo HTML_PARAMS; ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>">
<title><?php echo $products['products_name']; ?></title>
<base href="<?php echo (($request_type == 'SSL') ? HTTPS_SERVER : HTTP_SERVER) . DIR_WS_CATALOG; ?>">
<script language="javascript" type="text/javascript"><!--
var i=0;

function resize() {
	
        if (window.navigator.userAgent.indexOf('MSIE 6.0') != -1 && window.navigator.userAgent.indexOf('SV1') != -1) { 
		               i=23; //IE 6.x on Windows XP SP2
        } else if (window.navigator.userAgent.indexOf('MSIE 6.0') != -1) { 
		               i=50; //IE 6.x somewhere else
	  } else if (window.navigator.userAgent.indexOf('MSIE 7.0') != -1) { 
		               i=0;  //IE 7.x 
        } else if (window.navigator.userAgent.indexOf('Firefox') != -1 && window.navigator.userAgent.indexOf("Windows") != -1) { 
		               i=38; //Firefox on Windows
        } else if (window.navigator.userAgent.indexOf('Mozilla') != -1 && window.navigator.userAgent.indexOf("Windows") != -1 && window.navigator.userAgent.indexOf("MSIE") == -1) { 
		               i=45; //Mozilla on Windows, but not IE7		
	  } else if (window.opera && document.childNodes) {
		               i=50; //Opera 7+
        } else if (navigator.vendor == 'KDE' && window.navigator.userAgent.indexOf("Konqueror") != -1) {
                           i=-4; //Konqueror- this works ok with small images but not so great with large ones
				         //if you tweak it make sure i remains negative
        } else { 
		               i=70; //All other browsers
        }
          
	if (document.images[0]) {
        imgHeight = document.images[0].height+110-i;
        imgWidth = document.images[0].width+30;
        var height = screen.height;
        var width = screen.width;
        var leftpos = width / 2 - imgWidth / 2;
        var toppos = height / 2 - imgHeight / 2;
        window.moveTo(leftpos, toppos);
        window.resizeTo(imgWidth, imgHeight);
       }
   
  self.focus();
   
}
//--></script>
</head>
<body onload="resize();">
<?php 
	// check for large images
	$image_size = getimagesize(DIR_WS_IMAGES . $products['products_image']);
	$image_width = ($image_size[0] < POPUP_IMAGE_WIDTH) ? '':POPUP_IMAGE_WIDTH;
	$image_height = ($image_size[1] < POPUP_IMAGE_HEIGHT) ? '':POPUP_IMAGE_HEIGHT;
	
	echo tep_image(DIR_WS_IMAGES . $products['products_image'], $products['products_name'], POPUP_IMAGE_WIDTH, POPUP_IMAGE_HEIGHT); 
?>
</body>
</html>
<?php require('includes/application_bottom.php'); ?>
