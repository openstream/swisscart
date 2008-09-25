<?php
/*
  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2005-2008 osCommerce

  Released under the GNU General Public License
  
  This generic price search feeder has been released by nick@openstream.ch
  Copyright (c) 2008 Openstream Internet Solutions
*/

  require('includes/application_top.php');

  $psfeeder_subdir = "pub/feeds/";
  $psfeeder_file = (!$_GET['file']) ? 'product-feed-generic.txt' : trim($_GET['file']);
  
  // some price search engines require to set a flat shipping rate on a per product basis
  $flat_shipping_rate = '6.00';
  $flat_shipping = ($_GET['flat_shipping'] == 1) ? 1 : 0;

  //
  // no edit required below
  //
  $psfeeder_dir = DIR_FS_CATALOG . $psfeeder_subdir;

  $tax_rate = array();
  function get_tax($class_id=0) {
    global $tax_rate;
    if (!isset($tax_rate[$class_id])) $tax_rate[$class_id] = tep_get_tax_rate($class_id);
    return $tax_rate[$class_id];
  }
  $included_categories_query = tep_db_query("SELECT c.categories_id, c.parent_id, cd.categories_name FROM " . TABLE_CATEGORIES . " c, " . TABLE_CATEGORIES_DESCRIPTION . " cd WHERE c.categories_id = cd.categories_id AND cd.language_id = FLOOR($languages_id) ");
  $inc_cat = array();
  while ($included_categories = tep_db_fetch_array($included_categories_query)) {
    $inc_cat[] = array (
          'id' => $included_categories['categories_id'],
      'parent' => $included_categories['parent_id'],
        'name' => $included_categories['categories_name']);
  }
  $cat_info = array();
  for ($i=0; $i<sizeof($inc_cat); $i++)
    $cat_info[$inc_cat[$i]['id']] = array (
      'parent'=> $inc_cat[$i]['parent'],
      'name'  => $inc_cat[$i]['name'],
      'path'  => $inc_cat[$i]['id'],
      'link'  => '',
      'sons'  => $inc_cat[$i]['id'] );
  for ($i=0; $i<sizeof($inc_cat); $i++) {
    $cat_id = $inc_cat[$i]['id'];
    while ($cat_info[$cat_id]['parent'] != 0){
      $cat_info[$cat_info[$cat_id]['parent']]['sons'] .= ( (strpos($cat_info[$cat_info[$cat_id]['parent']]['sons'],$cat_id)===false)? (($cat_info[$cat_info[$cat_id]['parent']]['sons']!='')?',':'') . $cat_id:'');
      $cat_info[$inc_cat[$i]['id']]['path'] = $cat_info[$cat_id]['parent'] . '_' . $cat_info[$inc_cat[$i]['id']]['path'];
      $cat_id = $cat_info[$cat_id]['parent'];
    }
    $link_array = split('_', $cat_info[$inc_cat[$i]['id']]['path']);
    for ($j=0; $j<sizeof($link_array); $j++) {
      $cat_info[$inc_cat[$i]['id']]['link'] .= (($cat_info[$inc_cat[$i]['id']]['link']!='')? ' > ':'') . str_replace('>', ' ', strip_tags($cat_info[$link_array[$j]]['name']));
    }
  }

  $psfeeder_list_header .= "product_id\tsku\tproduct_url\tname\tdescription\timage_url\tcategory\tprice";
  $psfeeder_list_header .= ($flat_shipping == 1) ? "\tshipping" : "";
  $psfeeder_list_header .= "\n";

  // use these variables if you have many products and run into execution time problems
  $offset = (isset($_GET['offset']) && intval($_GET['offset'])>0)? intval($_GET['offset']):0;
  $rows   = (isset($_GET['rows']) && intval($_GET['rows'])>0)? intval($_GET['rows']):1000;
  $sql_limit = '';
  if ($rows>0) {
    $sql_limit = $rows;
    if ($offset>0) {
      $sql_limit = $offset . ',' . $sql_limit;
    }
    $sql_limit = ' limit ' . $sql_limit;
  }

    $products_query = tep_db_query("select p.products_id, p.products_quantity, p.products_model, p.products_image, p.products_price, IF(s.status, s.specials_new_products_price, NULL) as specials_price, p.products_tax_class_id, pd.products_name, pd.products_description, p2c.categories_id FROM " . TABLE_PRODUCTS . " p left join " . TABLE_SPECIALS . " s using (products_id), " . TABLE_PRODUCTS_DESCRIPTION . " pd, " . TABLE_PRODUCTS_TO_CATEGORIES . " p2c WHERE p.products_status = 1 AND pd.products_id = p.products_id AND p.products_price != 0 AND p2c.products_id = p.products_id AND pd.language_id = '" . (int)$languages_id . "' group by p.products_id order by p2c.categories_id, pd.products_name" . $sql_limit);

//$products_query = tep_db_query("select p.products_id, p.products_quantity, p.products_model, p.products_image, p.products_price, p.products_tax_class_id, pd.products_name, pc.categories_id, cd.categories_name FROM " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd, " . TABLE_PRODUCTS_TO_CATEGORIES . " pc, " . TABLE_CATEGORIES . " c, " . TABLE_CATEGORIES_DESCRIPTION . " cd WHERE p.products_id = pd.products_id AND p.products_id = pc.products_id AND c.categories_id = pc.categories_id AND c.categories_id = cd.categories_id AND p.products_status = 1 AND p.products_compare_status = 1 AND pd.language_id = '" . (int)$languages_id . "' AND cd.language_id = '" . (int)$languages_id . "' order by c.sort_order, pd.products_name limit $offset, $rows");
//$expedition_query = tep_db_query("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key  = 'EXPEDITION_PRICE'");
//$products_query = tep_db_query("select * from " . TABLE_PRODUCTS);
//echo mysql_num_rows($products_query);
//die();
//$expedition_price = tep_db_fetch_array($expedition_query);

    while($products = tep_db_fetch_array($products_query)) {

// products_id
      $psfeeder_list .= $products['products_id'];
	  $psfeeder_list .= "\t";

// products_model
      $psfeeder_list .= ($products['products_model'] == '') ? $products['products_id'] : $products['products_model'];
	  $psfeeder_list .= "\t";

// product URL;
      $psfeeder_list .= tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $products['products_id'], 'NONSSL', false) . "\t";

// product name
      $psfeeder_list .= str_replace("\t", " ", substr($products['products_name'], 0 , 80)) . "\t";

// product description or name
      $psfeeder_list .= substr(strip_tags(html_entity_decode(str_replace(array("\t", "\n", "\r", '<br>', '<BR>', '<br />', '<BR />'), " ", $products['products_description']))) . " " . $products['products_name'], 0 , 200) . "\t";
	  
	  
// product image
      if (tep_not_null($products['products_image'])) {
  	    $psfeeder_list .= tep_href_link(DIR_WS_IMAGES . $products['products_image'], '', 'NONSSL', false) . "\t";
      } else {
  	    $psfeeder_list .= "no_image\t";
      }
	  	  
// Category
      $psfeeder_list .= $cat_info[$products['categories_id']]['link'] . "\t";		  

// product price
      if (isset($products['specials_price']) && $products['specials_price']>0) {
        //$psfeeder_list .= $currencies->display_price($products['specials_price'], get_tax($products['products_tax_class_id'])) . "\n";
		$psfeeder_list .= $currencies->display_price_simple($products['specials_price'], get_tax($products['products_tax_class_id']));
      } else {
        //$psfeeder_list .= $currencies->display_price($products['products_price'], get_tax($products['products_tax_class_id'])) . "\n";
		$psfeeder_list .= $currencies->display_price_simple($products['products_price'], get_tax($products['products_tax_class_id']));
      }

//echo $currencies->display_price_kelkoo($products['products_price'], tep_get_tax_rate($products['products_tax_class_id']));

// shipping cost per product 
// (not stored/retrieved in the store database, this is currently set to a static value at the top of this file)
	  $psfeeder_list .= ($flat_shipping == 1) ? "\t" . $flat_shipping_rate : "";


// Numéro de l'offre
//      $psfeeder_list .= $products['products_id'] . "\t";




// Qté en stock
/*      if ( $products['products_quantity'] > 0 ) {
        $psfeeder_list .=  "001\t";
      } else {
        $psfeeder_list .=  "003\t";
      }
*/

// Cout de la livraison
/*      $psfeeder_list .= substr(EXPEDITION_PRICE, 0 , 20);
      $psfeeder_list .= "\n";
    }
*/

// line break
	  $psfeeder_list .= "\n";


// if txt file does not exist, create it!
    if (!file_exists($psfeeder_dir . $psfeeder_file)) touch($psfeeder_dir . $psfeeder_file);

    if (!$noparam == 1) { // if no get parameters are set, skip this part
      if (isset($_GET['mode']) && $_GET['mode'] == 'add') {
		// append to file
        $fp= fopen($psfeeder_dir . $psfeeder_file,"a");
        fputs($fp,"$psfeeder_list");
        $messageStack->add('header', 'Inhalt an Froogle-Datei angehängt', 'success');
      } else {
        // begin new file
        $fp= fopen($psfeeder_dir . $psfeeder_file,"w");
        fputs($fp,"$psfeeder_list_header$psfeeder_list");
      }
      fclose($fp);
    }
  }


  echo "\n\nDie Exportdatei wurde erfolgreich erstellt!\n";
  echo tep_href_link($psfeeder_subdir . $psfeeder_file, '', 'NONSSL', false) . "\n\n";

//  require(DIR_WS_INCLUDES . 'application_bottom.php'); 

// close session (store variables)
  tep_session_close();
?>