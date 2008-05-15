<?php
/*
  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002-2003 osCommerce
  Copyright (c) 2003 Rodolphe Quiedeville <rodolphe@quiedeville.org>
  Copyright (c) 2008 Nick Weisser <nick@openstream.ch>

  Author : Rodolphe Quiedeville <rodolphe@quiedeville.org>
  Customized by : Nick Weisser <nick@openstream.ch>

  Released under the GNU General Public License
*/

$products_new_query_raw = "select p.products_id, pd.products_name, p.products_image, p.products_price, p.products_tax_class_id, p.products_date_added, m.manufacturers_name from " . TABLE_PRODUCTS . " p left join " . TABLE_MANUFACTURERS . " m on (p.manufacturers_id = m.manufacturers_id), " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_status = '1' and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' order by p.products_date_added DESC, pd.products_name limit 20";

$products_new_result = tep_db_query($products_new_query_raw);

while($products_new = tep_db_fetch_array($products_new_result)) {

  $whats_new_price =  $currencies->display_price($products_new['products_price'], tep_get_tax_rate($products_new['products_tax_class_id']));
  $products_new['specials_new_products_price'] = tep_get_products_special_price($products_new['products_id']);
  
  if ($products_new['specials_new_products_price']) $whats_new_price_special = $currencies->display_price($products_new['specials_new_products_price'], tep_get_tax_rate($products_new['products_tax_class_id']));

	print '    <item>' . "\n";
	
	print '      <title>' . htmlspecialchars(tep_get_products_name($products_new['products_id'])) . '</title>'. "\n";
	
	// this will only apply for swisscart® stores (http://www.swisscart.com)
	if(function_exists(sc_get_products_teaser)) print '      <description>' . htmlspecialchars(strip_tags(sc_get_products_teaser($products_new['products_id'], '', 250))) . '</description>'. "\n";

	print '      <link>' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $products_new['products_id'], NONSSL) . '</link>' . "\n";

	print '      <guid>' . tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $products_new['products_id'], NONSSL) . '</guid>' . "\n";
		
/*  this does not validate for RSS 2.0 
	print '      <img>' . HTTP_SERVER.DIR_WS_CATALOG.DIR_WS_IMAGES . $products_new['products_image'] . '</img>' . "\n";  
	
	print '      <price>' . $whats_new_price . '</price>'. "\n";
	
	if ($products_new['specials_new_products_price'])
	{
	  print '      <specialprice>' . $whats_new_price_special . '</specialprice>' . "\n";
	}
*/	
	print '    </item>' . "\n";
}

?>


