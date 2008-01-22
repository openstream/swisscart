
<?php
/* 
$Id: xsell_products.php, v1  2002/09/11

osCommerce, Open Source E-Commerce Solutions 
<http://www.oscommerce.com> 

Copyright (c) 2002 osCommerce 

Released under the GNU General Public License 
*/ 

if ($HTTP_GET_VARS['products_id']) { 
$xsell_query = tep_db_query("select distinct p.products_id, p.products_image, pd.products_name from " . TABLE_PRODUCTS_XSELL . " xp, " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where xp.products_id = '" . $HTTP_GET_VARS['products_id'] . "' and xp.xsell_id = p.products_id and p.products_id = pd.products_id and pd.language_id = '" . $languages_id . "' and p.products_status = '1' order by xp.products_id asc limit " . MAX_DISPLAY_ALSO_PURCHASED); 
$num_products_xsell = tep_db_num_rows($xsell_query); 
if ($num_products_xsell >= MIN_DISPLAY_ALSO_PURCHASED) { 
?> 
<!-- xsell_products //-->
          <tr>
            <td>
<?php
      $info_box_contents = array();
      $info_box_contents[] = array('text' => TEXT_XSELL_PRODUCTS);
	  
      new contentBoxHeading($info_box_contents, false, false);
	  
      $info_box_contents = array();
	  $xsellbox_contents = '<ul class="xsell">' . "\n";
	  while ($xsell = tep_db_fetch_array($xsell_query)) {
        $xsell['products_name'] = tep_get_products_name($xsell['products_id']);
        $xsellbox_contents .= "\t" . '<li><a href="' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $xsell['products_id']) . '">' . $xsell['products_name'] . '</a></li>' . "\n";
      }
	  $xsellbox_contents .= '<ul>';
	  $info_box_contents[] = array('text' => $xsellbox_contents);
      new contentBox($info_box_contents);
?>
            </td>
          </tr>
<!-- xsell_products_eof //-->
<?php
    }
  }
?>