<?php
/*******************************************************************************************
*                                                                                          *
*  CAO-Faktura für Windows Version 1.2 (http://www.cao-wawi.de)                            *
*  Copyright (C) 2004 Jan Pokrandt / Info@JP-SOFT.de                                       *
*                                                                                          *
*  This program is free software; you can redistribute it and/or                           *
*  modify it under the terms of the GNU General Public License                             *
*  as published by the Free Software Foundation; either version 2                          *
*  of the License, or any later version.                                                   *
*                                                                                          *
*  This program is distributed in the hope that it will be useful,                         *
*  but WITHOUT ANY WARRANTY; without even the implied warranty of                          *
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                           *
*  GNU General Public License for more details.                                            *
*                                                                                          *
*  You should have received a copy of the GNU General Public License                       *
*  along with this program; if not, write to the Free Software                             *
*  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
*                                                                                          *
*  ******* CAO-Faktura comes with ABSOLUTELY NO WARRANTY ***************                   *
*                                                                                          *
********************************************************************************************
*                                                                                          *
* Eine Entfernung oder Veraenderung dieses Dateiheaders ist nicht zulaessig !!!            *
* Wenn Sie diese Datei veraendern dann fuegen Sie ihre eigenen Copyrightmeldungen          *
* am Ende diese Headers an                                                                 *
*                                                                                          *
********************************************************************************************
*                                                                                          *
*  Programm     : CAO-Faktura                                                              *
*  Modul        : cao_osc_functions.php                                                    *
*  Stand        : 15.08.2006                                                               *
*  Version      : 1.53                                                                     *
*  Beschreibung : Script zum Datenaustausch CAO-Faktura <--> osCommerce-Shop               *
*                                                                                          *
*  based on:                                                                               *
* (c) 2000 - 2001 The Exchange Project                                                     *
* (c) 2001 - 2003 osCommerce, Open Source E-Commerce Solutions                             *
* (c) 2001 - 2003 TheMedia, Dipl.-Ing Thomas Plänkers                                      *
* (c) 2003 JP-Soft, Jan Pokrandt                                                           *
* (c) 2003 IN-Solution, Henri Schmidhuber                                                  *
* (c) 2003 www.websl.de, Karl Langmann                                                     *
* (c) 2003 RV-Design Raphael Vullriede                                                     *
*                                                                                          *
* Released under the GNU General Public License                                            *
*                                                                                          *
*  History :                                                                               *
*                                                                                          *
*  - 26.09.2005 JP Funktionen aus xml_export.php und cao_updat.php erstellt                *
*  - 04.10.2005 JP Version 1.44 released                                                   *
*  - 07.10.2005 JP Categories-Description eingebaut                                        *
*  - 23.10.2005 hartleib Fehlende $LangID in OrderUpdate hinzugefuegt                      *
*  - 07.11.2005 JP Export Orders/VAT_ID hinzugefuegt (benoetigt Contrib)                   *
*  - 08.11.2005 JP Erweiterung zum anlegen der Tabellenspaleten fuer 3 Produktbilder       *
*                  implementiert                                                           *
*  - 09.11.2005 Pagemaster B $this = null durch unset($this) ersetzt (Anpassung fuer PHP5) *
*  - 13.02.2006 JP Bugfix beim Versenden des Status-Updates                                *
*  * 22.02.2006 JP Bugfix beim uebertragen der Meta-Daten                                  *
*******************************************************************************************/

//--------------------------------------------------------------

function SendScriptVersion ()
{
   global $_GET, $version_nr, $version_datum;

   $schema = '<?xml version="1.0" encoding="' . CHARSET . '"?>' . "\n" .
             '<STATUS>' . "\n" .
             '<STATUS_DATA>' . "\n" .
             '<ACTION>' . $_GET['action'] . '</ACTION>' . "\n" .
             '<CODE>' . '111' . '</CODE>' . "\n" .              
             '<SCRIPT_VER>' . $version_nr . '</SCRIPT_VER>' . "\n" . 
             '<SCRIPT_DATE>' . $version_datum . '</SCRIPT_DATE>' . "\n" . 
             '</STATUS_DATA>' . "\n" .
             '</STATUS>' . "\n\n";
   echo $schema; 
}


//--------------------------------------------------------------

function print_xml_status ($code, $action, $msg, $mode, $item, $value)
{
  $schema = '<?xml version="1.0" encoding="' . CHARSET . '"?>' . "\n" .
            '<STATUS>' . "\n" .
            '<STATUS_DATA>' . "\n" .
            '<CODE>' . $code . '</CODE>' . "\n" .
            '<ACTION>' . $action . '</ACTION>' . "\n" .
            '<MESSAGE>' . $msg . '</MESSAGE>' . "\n";
	    
  if (strlen($mode)>0) {
    $schema .= '<MODE>' . $mode . '</MODE>' . "\n";
  }
  
  if (strlen($item)>0) {
    $schema .= '<' . $item . '>' . $value . '</' . $item . '>' . "\n";
  }
  $schema .= '</STATUS_DATA>' . "\n" .
             '</STATUS>' . "\n\n";

  echo $schema;
  
  return;
}

//--------------------------------------------------------------

function SendCategories ()
{

  if (defined('SET_TIME_LIMIT')) { tep_set_time_limit(0); }
        
  $schema = '<?xml version="1.0" encoding="' . CHARSET . '"?>' . "\n" .
                  '<CATEGORIES>' . "\n";
                  
  echo $schema;
                  
  $cat_query = "SELECT
                 categories_id,
                 categories_image,
                 parent_id,
                 sort_order,
                 date_added,
                 last_modified 
                FROM 
                 " . TABLE_CATEGORIES . "
                ORDER BY 
                 parent_id,
                 categories_id";
                                     
  $cat_result = tep_db_query($cat_query);
        
  while ($cat = tep_db_fetch_array($cat_result)) 
  {
    $schema  = '<CATEGORIES_DATA>' . "\n" .
               '<ID>' . $cat['categories_id'] . '</ID>' . "\n" .
               '<PARENT_ID>' . $cat['parent_id'] . '</PARENT_ID>' . "\n" .
               '<IMAGE_URL>' . htmlspecialchars($cat['categories_image']) . '</IMAGE_URL>' . "\n" .
               '<SORT_ORDER>' . $cat['sort_order'] . '</SORT_ORDER>' . "\n" .
               '<DATE_ADDED>' . $cat['date_added'] . '</DATE_ADDED>' . "\n" .
               '<LAST_MODIFIED>' . $cat['last_modified'] . '</LAST_MODIFIED>' . "\n";
                     
    $detail_query = "SELECT
                      cd.categories_id,
                      cd.language_id,
                      cd.categories_name,
                      l.code as lang_code,
                      l.name as lang_name ";
		  
	 if (HEADERTAGS == true)
	 {
	    $detail_query .= ",cd.categories_htc_title_tag,cd.categories_htc_desc_tag,cd.categories_htc_keywords_tag,cd.categories_htc_description ";
	 }	  
	  	  
	 $detail_query .="FROM
                    " . TABLE_CATEGORIES_DESCRIPTION . " cd,
                    " . TABLE_LANGUAGES . " l WHERE 
                    cd.categories_id=" . $cat['categories_id'] . " AND 
                    l.languages_id= cd.language_id";
            
    $detail_result = tep_db_query($detail_query);
          
    while ($details = tep_db_fetch_array($detail_result)) 
    {
       $schema .= "<CATEGORIES_DESCRIPTION ID='" . $details["language_id"] ."' CODE='" . $details["lang_code"] . "' NAME='" . $details["lang_name"] . "'>\n";
       $schema .= "<NAME>" . htmlspecialchars($details["categories_name"]) . "</NAME>" . "\n";
            
	    if (HEADERTAGS == true)
	    {
	       $schema .= "<META_TITLE>" . htmlspecialchars($details["categories_htc_title_tag"]) . "</META_TITLE>";
	       
          $cat_meta_desc = $details['categories_htc_desc_tag'];
          if ($cat_meta_desc != 'Array')
          {
             $schema .=  "<META_DESCRIPTION>" . htmlspecialchars($cat_meta_desc) . "</META_DESCRIPTION>" . "\n";
          }
				 
          $cat_meta_key = $details['categories_htc_keywords_tag'];
          if ($cat_meta_key != 'Array')
          {
             $schema .=  "<META_KEYWORDS>" . htmlspecialchars($cat_meta_key) . "</META_KEYWORDS>" . "\n";
          }
	    }    
	    
	    $schema .= "</CATEGORIES_DESCRIPTION>\n";
    }
        
    // Produkte in dieser Categorie auflisten
    $prod2cat_query = "SELECT
                        categories_id,
                        products_id
                       FROM 
                        " . TABLE_PRODUCTS_TO_CATEGORIES . "
                       WHERE
                        categories_id='" . $cat['categories_id'] . "'";
                                         
    $prod2cat_result = tep_db_query($prod2cat_query);
    while ($prod2cat = tep_db_fetch_array($prod2cat_result)) 
    {
      $schema .="<PRODUCTS ID='" . $prod2cat["products_id"] ."'></PRODUCTS>" . "\n";
    }
    $schema .= '</CATEGORIES_DATA>' . "\n";
    echo $schema;
  }
  $schema = '</CATEGORIES>' . "\n";
  echo $schema;
}

//--------------------------------------------------------------

function  SendManufacturers ()
{
  if (defined('SET_TIME_LIMIT')) { tep_set_time_limit(0); }
        
  $schema = '<?xml version="1.0" encoding="' . CHARSET . '"?>' . "\n" .
            '<MANUFACTURERS>' . "\n";
                  
  echo $schema;
        
  $man_query = "SELECT
                 manufacturers_id,
                 manufacturers_name,
                 manufacturers_image,
                 date_added,
                 last_modified
                FROM 
                 " . TABLE_MANUFACTURERS . "
                ORDER BY
                 manufacturers_id";
            
  $man_result = tep_db_query($man_query);
  while ($cat = tep_db_fetch_array($man_result)) 
  {
    $schema  = '<MANUFACTURERS_DATA>' . "\n" .
               '<ID>' . $cat['manufacturers_id'] . '</ID>' . "\n" .
               '<NAME>' . htmlspecialchars($cat['manufacturers_name']) . '</NAME>' . "\n" .
               '<IMAGE>' . htmlspecialchars($cat['manufacturers_image']) . '</IMAGE>' . "\n" .
               '<DATE_ADDED>' . $cat['date_added'] . '</DATE_ADDED>' . "\n" .
               '<LAST_MODIFIED>' . $cat['last_modified'] . '</LAST_MODIFIED>' . "\n";
                     
          
    $man_info_query = 
            "SELECT
              mi.manufacturers_id, 
              mi.languages_id,
              mi.manufacturers_url,
              url_clicked,
              date_last_click,
              l.code as lang_code,
              l.name as lang_name
            FROM 
              " . TABLE_MANUFACTURERS_INFO . " mi,
              " . TABLE_LANGUAGES . " l
            WHERE
              mi.manufacturers_id= " . $cat['manufacturers_id'] . " AND
              l.languages_id = mi.languages_id";
              
    $man_info_result = tep_db_query($man_info_query);

    while ($details = tep_db_fetch_array($man_info_result)) 
    {
      $schema .= "<MANUFACTURERS_DESCRIPTION ID='" . $details["languages_id"] ."' CODE='" . $details["lang_code"] . "' NAME='" . $details["lang_name"] . "'>\n";
      $schema .= "<URL>" . htmlspecialchars($details["manufacturers_url"]) . "</URL>" . "\n" ;
      $schema .= "<URL_CLICK>" . $details["url_clicked"] . "</URL_CLICK>" . "\n" ;
      $schema .= "<DATE_LAST_CLICK>" . $details["date_last_click"] . "</DATE_LAST_CLICK>" . "\n" ;
      $schema .= "</MANUFACTURERS_DESCRIPTION>\n";
    }
          
    $schema .= '</MANUFACTURERS_DATA>' . "\n";
    echo $schema;
  }
  $schema = '</MANUFACTURERS>' . "\n";
  echo $schema;
}

//--------------------------------------------------------------

function SendOrders ()
{
  global $_GET, $order_total_class;
  
  $order_from   = tep_db_prepare_input($_GET['order_from']);
  //$order_to     = tep_db_prepare_input($_GET['order_to']);
  $order_status = tep_db_prepare_input($_GET['order_status']);
        
  if (defined('SET_TIME_LIMIT')) { tep_set_time_limit(0); }
  
  $schema = '<?xml version="1.0" encoding="' . CHARSET . '"?>' . "\n" .
            '<ORDER>' . "\n";
        
  echo $schema;
        
  $orders_query = "
          SELECT
            *
          FROM 
            " . TABLE_ORDERS . "
          WHERE
            orders_id >= '" . tep_db_input($order_from) . "'";
            
  if (!isset($order_status) && !isset($order_from)) 
  {
     $order_status = 1;
     $orders_query .= " AND orders_status = " . $order_status;
  }
        
	
  $orders_query .= " order by orders_id";
  $orders_result = tep_db_query($orders_query);
  
  while ($orders = tep_db_fetch_array($orders_result)) 
  {
    // Geburtsdatum laden
    $cust_query = "
            SELECT
              *
            FROM 
              " . TABLE_CUSTOMERS . "
            WHERE
              customers_id=" . $orders['customers_id'];
              
    $cust_result = tep_db_query ($cust_query);
    if (tep_db_num_rows($cust_result) >0) 
    {
      $cust_data = tep_db_fetch_array($cust_result);
      $cust_dob = $cust_data['customers_dob'];
      $cust_gender = $cust_data['customers_gender'];
    } else {
      $cust_dob = '';
      $cust_gender = '';
    }
          
    $schema  = '<ORDER_INFO>' . "\n" .
               '<ORDER_HEADER>' . "\n" .
               '<ORDER_ID>' . $orders['orders_id'] . '</ORDER_ID>' . "\n" .
               '<CUSTOMER_ID>' . $orders['customers_id'] . '</CUSTOMER_ID>' . "\n" .
               '<ORDER_DATE>' . $orders['date_purchased'] . '</ORDER_DATE>' . "\n" .
               '<ORDER_STATUS>' . $orders['orders_status'] . '</ORDER_STATUS>' . "\n" .
               '<ORDER_CURRENCY>' . htmlspecialchars($orders['currency']) . '</ORDER_CURRENCY>' . "\n" .
               '<ORDER_CURRENCY_VALUE>' . $orders['currency_value'] . '</ORDER_CURRENCY_VALUE>' . "\n" .
               '</ORDER_HEADER>' . "\n" .
               '<BILLING_ADDRESS>' . "\n";
               
    if (isset($orders['billing_tva_intracom']))
    {
      $schema .= '<VAT_ID>' . htmlspecialchars($orders['billing_tva_intracom']) . '</VAT_ID>' . "\n";
    }
               
    $schema .= '<COMPANY>' . htmlspecialchars($orders['billing_company']) . '</COMPANY>' . "\n" .
               '<FIRSTNAME>' . htmlspecialchars($orders['billing_firstname']) . '</FIRSTNAME>' . "\n" .
               '<LASTNAME>' . htmlspecialchars($orders['billing_lastname']) . '</LASTNAME>' . "\n" .
               '<NAME>' . htmlspecialchars($orders['billing_name']) . '</NAME>' . "\n" . // fuer Abwaertskompatibilitaet
               '<STREET>' . htmlspecialchars($orders['billing_street_address']) . '</STREET>' . "\n" .
//             '<ZIP>' . htmlspecialchars($orders['billing_postcode']) . '</ZIP>' . /* bis 1.2.5.4 */
               '<POSTCODE>' . htmlspecialchars($orders['billing_postcode']) . '</POSTCODE>' . "\n" . /* ab 1.2.6.x */
               '<CITY>' . htmlspecialchars($orders['billing_city']) . '</CITY>' . "\n" .
               '<SUBURB>' . htmlspecialchars($orders['billing_suburb']) . '</SUBURB>' . "\n" .
               '<STATE>' . htmlspecialchars($orders['billing_state']) . '</STATE>' . "\n" .
               '<COUNTRY>' . htmlspecialchars($orders['billing_country_iso_code_2']) . '</COUNTRY>' . "\n" . /* ab 1.2.6.x */
//             '<COUNTRY>' . htmlspecialchars($orders['billing_country']) . '</COUNTRY>' . "\n" . /* bis 1.2.5.4 */
               '<TELEPHONE>' . htmlspecialchars($orders['customers_telephone']) . '</TELEPHONE>' . "\n" . // JAN
               '<EMAIL>' . htmlspecialchars($orders['customers_email_address']) . '</EMAIL>' . "\n" . // JAN
               '<BIRTHDAY>' . htmlspecialchars($cust_dob) . '</BIRTHDAY>' . "\n" .
               '<GENDER>' . htmlspecialchars($cust_gender) . '</GENDER>' . "\n" .
               '</BILLING_ADDRESS>' . "\n" .
               '<DELIVERY_ADDRESS>' . "\n" .
               '<COMPANY>' . htmlspecialchars($orders['delivery_company']) . '</COMPANY>' . "\n" .
               '<FIRSTNAME>' . htmlspecialchars($orders['delivery_firstname']) . '</FIRSTNAME>' . "\n" .
               '<LASTNAME>' . htmlspecialchars($orders['delivery_lastname']) . '</LASTNAME>' . "\n" .
               '<NAME>' . htmlspecialchars($orders['delivery_name']) . '</NAME>' . "\n" . // fuer Abwaertskompatibilitaet
               '<STREET>' . htmlspecialchars($orders['delivery_street_address']) . '</STREET>' . "\n" .
//             '<ZIP>' . htmlspecialchars($orders['delivery_postcode']) . '</ZIP>' . /* bis 1.2.5.4 */                     
               '<POSTCODE>' . htmlspecialchars($orders['delivery_postcode']) . '</POSTCODE>' . "\n" . /* ab 1.2.6.x */
               '<CITY>' . htmlspecialchars($orders['delivery_city']) . '</CITY>' . "\n" .
               '<SUBURB>' . htmlspecialchars($orders['delivery_suburb']) . '</SUBURB>' . "\n" .
               '<STATE>' . htmlspecialchars($orders['delivery_state']) . '</STATE>' . "\n" .
               '<COUNTRY>' . htmlspecialchars($orders['delivery_country_iso_code_2']) . '</COUNTRY>' . "\n" . /* ab 1.2.6.x */
//             '<COUNTRY>' . htmlspecialchars($orders['delivery_country']) . '</COUNTRY>' . "\n" . /* bis 1.2.5.4 */
               '</DELIVERY_ADDRESS>' . "\n" .
               '<PAYMENT>' . "\n" . 
               '<PAYMENT_METHOD>' . htmlspecialchars($orders['payment_method']) . '</PAYMENT_METHOD>'  . "\n" .
               '<PAYMENT_CLASS>' . htmlspecialchars($orders['payment_class']) . '</PAYMENT_CLASS>'  . "\n";
          
    switch ($orders['payment_class']) 
    {
      case 'banktransfer':
        // Bankverbindung laden, wenn aktiv
        $bank_name = '';
        $bank_blz  = '';
        $bank_kto  = '';
        $bank_inh  = '';
        $bank_stat = -1;
              
        $bank_query = "
                SELECT
                  *
                FROM
                  banktransfer
                WHERE
                  orders_id = " . $orders['orders_id'];
                  
        $bank_result = tep_db_query($bank_query);
        if (($bank_result) && ($bankdata = tep_db_fetch_array($bank_result))) 
        {
          $bank_name = $bankdata['banktransfer_bankname'];
          $bank_blz  = $bankdata['banktransfer_blz'];
          $bank_kto  = $bankdata['banktransfer_number'];
          $bank_inh  = $bankdata['banktransfer_owner'];
          $bank_stat = $bankdata['banktransfer_status'];
        }
        $schema .= '<PAYMENT_BANKTRANS_BNAME>' . htmlspecialchars($bank_name) . '</PAYMENT_BANKTRANS_BNAME>' . "\n" .
                   '<PAYMENT_BANKTRANS_BLZ>' . htmlspecialchars($bank_blz) . '</PAYMENT_BANKTRANS_BLZ>' . "\n" .
                   '<PAYMENT_BANKTRANS_NUMBER>' . htmlspecialchars($bank_kto) . '</PAYMENT_BANKTRANS_NUMBER>' . "\n" .
                   '<PAYMENT_BANKTRANS_OWNER>' . htmlspecialchars($bank_inh) . '</PAYMENT_BANKTRANS_OWNER>' . "\n" .
                   '<PAYMENT_BANKTRANS_STATUS>' . htmlspecialchars($bank_stat) . '</PAYMENT_BANKTRANS_STATUS>' . "\n";
        break;
      }   
          
    $schema .= '</PAYMENT>' . "\n" . 
               '<SHIPPING>' . "\n" . 
               '<SHIPPING_METHOD>' . htmlspecialchars($orders['shipping_method']) . '</SHIPPING_METHOD>'  . "\n" .
               '<SHIPPING_CLASS>' . htmlspecialchars($orders['shipping_class']) . '</SHIPPING_CLASS>'  . "\n" .
               '</SHIPPING>' . "\n" .                      
               '<ORDER_PRODUCTS>' . "\n";
                     
    $products_query = "
            SELECT
              orders_products_id,
              products_id,
              products_model,
              products_name,
              final_price,
              products_tax,
              products_quantity
            FROM 
              " . TABLE_ORDERS_PRODUCTS . "
            WHERE
              orders_id = '" . $orders['orders_id'] . "'";
              
    $products_result = tep_db_query($products_query);
    while ($products = tep_db_fetch_array($products_result)) 
    {
      $schema .= '<PRODUCT>' . "\n" .
                 '<PRODUCTS_ID>' . $products['products_id'] . '</PRODUCTS_ID>' . "\n" .
                 '<PRODUCTS_QUANTITY>' . $products['products_quantity'] . '</PRODUCTS_QUANTITY>' . "\n" .
                 '<PRODUCTS_MODEL>' . htmlspecialchars($products['products_model']) . '</PRODUCTS_MODEL>' . "\n" .
                 '<PRODUCTS_NAME>' . htmlspecialchars($products['products_name']) . '</PRODUCTS_NAME>' . "\n" .
                 '<PRODUCTS_PRICE>' . $products['final_price'] . '</PRODUCTS_PRICE>' . "\n" .
                 '<PRODUCTS_TAX>' . $products['products_tax'] . '</PRODUCTS_TAX>' . "\n";
                       
      $attributes_query = "
              SELECT
                products_options,
                products_options_values,
                options_values_price,
                price_prefix
              FROM 
                " . TABLE_ORDERS_PRODUCTS_ATTRIBUTES . " 
              WHERE
                orders_id = '" .$orders['orders_id'] . "' AND 
                orders_products_id = '" . $products['orders_products_id'] . "'";
                
      $attributes_result = tep_db_query($attributes_query);
      if (tep_db_num_rows( $attributes_result ) > 0) 
      {
        while ($attributes = tep_db_fetch_array($attributes_result)) 
        {
          $schema .= '<OPTION>' . "\n" .
                     '<PRODUCTS_OPTIONS>' .  htmlspecialchars($attributes['products_options']) . '</PRODUCTS_OPTIONS>' . "\n" . 
                     '<PRODUCTS_OPTIONS_VALUES>' .  htmlspecialchars($attributes['products_options_values']) . '</PRODUCTS_OPTIONS_VALUES>' . "\n" .
                     '<PRODUCTS_OPTIONS_PRICE>' .  $attributes['price_prefix'] . ' ' . $attributes['options_values_price'] . '</PRODUCTS_OPTIONS_PRICE>' . "\n" .
                     '</OPTION>' . "\n";
        }
      }            
      $schema .=  '</PRODUCT>' . "\n";
    }
          
    $schema .= '</ORDER_PRODUCTS>' . "\n";                     
    $schema .= '<ORDER_TOTAL>' . "\n";
          
    $totals_query = "
            SELECT 
              title,
              value,
              class,
              sort_order
            FROM
              " . TABLE_ORDERS_TOTAL . "
            WHERE
              orders_id = '" . $orders['orders_id'] . "'
            ORDER BY
              sort_order";
              
    $totals_result = tep_db_query($totals_query);
          
    while ($totals = tep_db_fetch_array($totals_result)) 
    {
      $total_prefix = "";
      $total_tax    = "";
      $total_prefix = $order_total_class[$totals['class']]['prefix'];
      $total_tax = $order_total_class[$totals['class']]['tax'];
            
      $schema .= '<TOTAL>' . "\n" .
                 '<TOTAL_TITLE>' . htmlspecialchars($totals['title']) . '</TOTAL_TITLE>' . "\n" .
                 '<TOTAL_VALUE>' . htmlspecialchars($totals['value']) . '</TOTAL_VALUE>' . "\n" .
                 '<TOTAL_CLASS>' . htmlspecialchars($totals['class']) . '</TOTAL_CLASS>' . "\n" .
                 '<TOTAL_SORT_ORDER>' . htmlspecialchars($totals['sort_order']) . '</TOTAL_SORT_ORDER>' . "\n" .
                 '<TOTAL_PREFIX>' . htmlspecialchars($total_prefix) . '</TOTAL_PREFIX>' . "\n" .
                 '<TOTAL_TAX>' . htmlspecialchars($total_tax) . '</TOTAL_TAX>' . "\n" . 
                 '</TOTAL>' . "\n";
    }
          
    $schema .= '</ORDER_TOTAL>' . "\n";
          
    $comments_query = "
            SELECT
              comments
            FROM 
              " . TABLE_ORDERS_STATUS_HISTORY . "
            WHERE
              orders_id = '" . $orders['orders_id'] . "' AND
              orders_status_id = '" . $orders['orders_status'] . "' ";
              
    $comments_result = tep_db_query ($comments_query);
          
    if ($comments =  tep_db_fetch_array($comments_result)) 
    {
      $schema .=  '<ORDER_COMMENTS>' . htmlspecialchars($comments['comments']) . '</ORDER_COMMENTS>' . "\n";
    }
          
    $schema .= '</ORDER_INFO>' . "\n\n";
    echo $schema;
  }
  $schema = '</ORDER>' . "\n\n";
  echo $schema;
}

//--------------------------------------------------------------

function SendProducts ()
{
  global $_GET;
  
  if (defined('SET_TIME_LIMIT')) { tep_set_time_limit(0); }
        
  $schema = '<?xml version="1.0" encoding="' . CHARSET . '"?>' . "\n" .
            '<PRODUCTS>' . "\n";
  echo $schema;
        
  if (DREI_PRODUKTBILDER == true)
  {
    $sql = "select products_id, products_quantity, products_model, products_image, products_image_medium, products_image_large, products_price, " .
           "products_date_added, products_last_modified, products_date_available, products_weight, " .
           "products_status, products_tax_class_id, manufacturers_id, products_ordered from " . TABLE_PRODUCTS;        
  }
    else          
  {     
    $sql = "select products_id, products_quantity, products_model, products_image, products_price, " .
           "products_date_added, products_last_modified, products_date_available, products_weight, " .
           "products_status, products_tax_class_id, manufacturers_id, products_ordered from " . TABLE_PRODUCTS;
  }
         
  $from = tep_db_prepare_input($_GET['products_from']);
  $anz  = tep_db_prepare_input($_GET['products_count']);
        
  if (isset($from)) 
  {
    if (!isset($anz)) { $anz=1000; }
    $sql .= " limit " . $from . "," . $anz;
  }
                  
  $orders_query = tep_db_query($sql);
  while ($products = tep_db_fetch_array($orders_query)) 
  {
    $schema  = '<PRODUCT_INFO>' . "\n" .
               '<PRODUCT_DATA>' . "\n" .
               '<PRODUCT_ID>' . $products['products_id'] . '</PRODUCT_ID>' . "\n" .
               '<PRODUCT_QUANTITY>' . $products['products_quantity'] . '</PRODUCT_QUANTITY>' . "\n" .
               '<PRODUCT_MODEL>' . htmlspecialchars($products['products_model']) . '</PRODUCT_MODEL>' . "\n" .
               '<PRODUCT_IMAGE>' . htmlspecialchars($products['products_image']) . '</PRODUCT_IMAGE>' . "\n";
          
    if (DREI_PRODUKTBILDER == true)
    {
      $schema .= '<PRODUCT_IMAGE_MED>' . htmlspecialchars($products['products_image_medium']) . '</PRODUCT_IMAGE_MED>' . "\n" .
                 '<PRODUCT_IMAGE_LARGE>' . htmlspecialchars($products['products_image_large']) . '</PRODUCT_IMAGE_LARGE>' . "\n";
    }
                     
    $schema .= '<PRODUCT_PRICE>' . $products['products_price'] . '</PRODUCT_PRICE>' . "\n" .
               '<PRODUCT_WEIGHT>' . $products['products_weight'] . '</PRODUCT_WEIGHT>' . "\n" .
               '<PRODUCT_STATUS>' . $products['products_status'] . '</PRODUCT_STATUS>' . "\n" .
               '<PRODUCT_TAX_CLASS_ID>' . $products['products_tax_class_id'] . '</PRODUCT_TAX_CLASS_ID>' . "\n"  .
               '<MANUFACTURERS_ID>' . $products['manufacturers_id'] . '</MANUFACTURERS_ID>' . "\n" .
               '<PRODUCT_DATE_ADDED>' . $products['products_date_added'] . '</PRODUCT_DATE_ADDED>' . "\n" .
               '<PRODUCT_LAST_MODIFIED>' . $products['products_last_modified'] . '</PRODUCT_LAST_MODIFIED>' . "\n" .
               '<PRODUCT_DATE_AVAILABLE>' . $products['products_date_available'] . '</PRODUCT_DATE_AVAILABLE>' . "\n" .
               '<PRODUCTS_ORDERED>' . $products['products_ordered'] . '</PRODUCTS_ORDERED>' . "\n" ;
                     
          
    $detail_query = "SELECT
              products_id,
              language_id,
              products_name,
              pd.products_description,
              products_url,
              name as language_name,
              code as language_code";
	      
	      
    if (HEADERTAGS == true)
	 {
	   $detail_query .= ",products_head_title_tag,products_head_desc_tag,products_head_keywords_tag";
	 }
	      
	 $detail_query .= "	      
            FROM
              " . TABLE_PRODUCTS_DESCRIPTION . " pd, 
              " . TABLE_LANGUAGES ." l
            WHERE
              pd.language_id = l.languages_id AND
              pd.products_id=" . $products['products_id'];
              
    $detail_result = tep_db_query($detail_query);
    while ($details = tep_db_fetch_array($detail_result)) 
    {
      $schema .= "<PRODUCT_DESCRIPTION ID='" . $details["language_id"] ."' CODE='" . $details["language_code"] . "' NAME='" . $details["language_name"] . "'>\n";
      if ($details["products_name"] !='Array') 
      {
        $schema .= "<NAME>" . htmlspecialchars($details["products_name"]) . "</NAME>" . "\n" ;
      }
      $schema .=  "<URL>" . htmlspecialchars($details["products_url"]) . "</URL>" . "\n" ;
      $prod_details = $details["products_description"];
      if ($prod_details != 'Array') 
      {
        $schema .=  "<DESCRIPTION>" . htmlspecialchars($prod_details) . "</DESCRIPTION>" . "\n";
      }
      if (HEADERTAGS == true)
		{    
		  $schema .=  "<META_TITLE>" . htmlspecialchars($details['products_head_title_tag']) . "</META_TITLE>" . "\n";
        $prod_meta_desc = $details['products_head_desc_tag'];
        if ($prod_meta_desc != 'Array') 
        {
          $schema .=  "<META_DESCRIPTION>" . htmlspecialchars($prod_meta_desc) . "</META_DESCRIPTION>" . "\n";
        }
        $prod_meta_key = $details['products_head_keywords_tag'];
        if ($prod_meta_key != 'Array') 
        {
          $schema .=  "<META_KEYWORDS>" . htmlspecialchars($prod_meta_key) . "</META_KEYWORDS>" . "\n";
        }
      } // ENDE HEADERTAGS
      $schema .= "</PRODUCT_DESCRIPTION>\n";
    }
	 // NEU 26.08.2005 Aktionspreise exportieren
	 $special_query = "SELECT * from " . TABLE_SPECIALS . " " .
	                  "where products_id=" . $products['products_id'] . " limit 0,1";
					                            
    $special_result = tep_db_query($special_query);
    while ($specials = tep_db_fetch_array($special_result)) 
    {
	   $schema .= '<SPECIAL>' . "\n" .
                 '<SPECIAL_PRICE>' . $specials['specials_new_products_price'] . '</SPECIAL_PRICE>' . "\n" .
                 '<SPECIAL_DATE_ADDED>' . $specials['specials_date_added'] . '</SPECIAL_DATE_ADDED>' . "\n" .
                 '<SPECIAL_LAST_MODIFIED>' . $specials['specials_last_modified'] . '</SPECIAL_LAST_MODIFIED>' . "\n" .
                 '<SPECIAL_DATE_EXPIRES>' . $specials['expires_date'] . '</SPECIAL_DATE_EXPIRES>' . "\n" .
                 '<SPECIAL_STATUS>' . $specials['status'] . '</SPECIAL_STATUS>' . "\n" .
                 '<SPECIAL_DATE_STATUS_CHANGE>' . $specials['date_status_change'] . '</SPECIAL_DATE_STATUS_CHANGE>' . "\n" .
                 '</SPECIAL>' . "\n";          
    }
	 // Ende Aktionspreise      
    $schema .= '</PRODUCT_DATA>' . "\n" .
               '</PRODUCT_INFO>' . "\n";
    echo $schema;
  }
  $schema = '</PRODUCTS>' . "\n\n";
  echo $schema;
}

//--------------------------------------------------------------

function SendCustomers ()
{
  global $_GET;
  
  if (defined('SET_TIME_LIMIT')) { tep_set_time_limit(0); }
  
  $schema = '<?xml version="1.0" encoding="' . CHARSET . '"?>' . "\n" .
            '<CUSTOMERS>' . "\n";
      
  echo $schema;
      
  $from = tep_db_prepare_input($_GET['customers_from']);
  $anz  = tep_db_prepare_input($_GET['customers_count']);
    
  $address_query = "
      SELECT
        c.customers_gender,
        c.customers_id,
        c.customers_dob,
        c.customers_email_address,
        c.customers_telephone,
        c.customers_fax, 
        ci.customers_info_date_account_created, 
        a.entry_firstname,
        a.entry_lastname,
        a.entry_company,
        a.entry_street_address,
        a.entry_city,
        a.entry_postcode, 
        a.entry_suburb,
        a.entry_state,
        co.countries_iso_code_2 
      FROM
        ".TABLE_CUSTOMERS. " c, 
        ".TABLE_CUSTOMERS_INFO. " ci, 
        ".TABLE_ADDRESS_BOOK . " a , 
        ".TABLE_COUNTRIES." co 
      WHERE
        c.customers_id = ci.customers_info_id AND 
        c.customers_id = a.customers_id AND
        c.customers_default_address_id = a.address_book_id AND 
        a.entry_country_id  = co.countries_id";
        
  if (isset($from)) 
  {
    if (!isset($anz)) { $anz = 1000; }
    $address_query.= " LIMIT " . $from . "," . $anz;
  }
    
  $address_result = tep_db_query($address_query);
    
  while ($address = tep_db_fetch_array($address_result))  
  {
    $schema = '<CUSTOMERS_DATA>' . "\n" .
              '<CUSTOMERS_ID>' . htmlspecialchars($address['customers_id']) . '</CUSTOMERS_ID>' . "\n" .
              '<GENDER>' . htmlspecialchars($address['customers_gender']) . '</GENDER>' . "\n" .
              '<COMPANY>' . htmlspecialchars($address['entry_company']) . '</COMPANY>' . "\n" .
              '<FIRSTNAME>' . htmlspecialchars($address['entry_firstname']) . '</FIRSTNAME>' . "\n" .
              '<LASTNAME>' . htmlspecialchars($address['entry_lastname']) . '</LASTNAME>' . "\n" .
              '<STREET>' . htmlspecialchars($address['entry_street_address']) . '</STREET>' . "\n" .
              '<POSTCODE>' . htmlspecialchars($address['entry_postcode']) . '</POSTCODE>' . "\n" .
              '<CITY>' . htmlspecialchars($address['entry_city']) . '</CITY>' . "\n" .
              '<SUBURB>' . htmlspecialchars($address['entry_suburb']) . '</SUBURB>' . "\n" .
              '<STATE>' . htmlspecialchars($address['entry_state']) . '</STATE>' . "\n" .
              '<COUNTRY>' . htmlspecialchars($address['countries_iso_code_2']) . '</COUNTRY>' . "\n" .
              '<TELEPHONE>' . htmlspecialchars($address['customers_telephone']) . '</TELEPHONE>' . "\n" . // JAN
              '<FAX>' . htmlspecialchars($address['customers_fax']) . '</FAX>' . "\n" . // JAN
              '<EMAIL>' . htmlspecialchars($address['customers_email_address']) . '</EMAIL>' . "\n" . // JAN
              '<BIRTHDAY>' . htmlspecialchars($address['customers_dob']) . '</BIRTHDAY>' . "\n" .
              '<DATE_ACCOUNT_CREATED>' . htmlspecialchars($address['customers_info_date_account_created']) . '</DATE_ACCOUNT_CREATED>' . "\n" .
              '</CUSTOMERS_DATA>' . "\n";
    echo $schema;
  }
  $schema = '</CUSTOMERS>' . "\n\n";
  echo $schema;
}

//--------------------------------------------------------------

function SendCustomersNewsletter ()
{
  global $_GET;
  
  if (defined('SET_TIME_LIMIT')) { tep_set_time_limit(0); }
  $schema = '<?xml version="1.0" encoding="' . CHARSET . '"?>' . "\n" .
            '<CUSTOMERS>' . "\n";
            
  echo $schema;
      
  $from = tep_db_prepare_input($_GET['customers_from']);
  $anz  = tep_db_prepare_input($_GET['customers_count']);
    
  $address_query = "
      SELECT
        *
      FROM 
        " . TABLE_CUSTOMERS. " 
      WHERE
        customers_newsletter = 1";
        
  if (isset($from)) 
  {
    if (!isset($anz)) { $anz = 1000; }
    $address_query.= " LIMIT " . $from . "," . $anz;
  }
  
  $address_result = tep_db_query($address_query);
  
  while ($address = tep_db_fetch_array($address_result)) 
  {
    $schema  = '<CUSTOMERS_DATA>' . "\n";
    $schema .= '<CUSTOMERS_ID>' . $address['customers_id'] . '</CUSTOMERS_ID>' . "\n";
    $schema .= '<CUSTOMERS_GENDER>' . $address['customers_gender'] . '</CUSTOMERS_GENDER>' . "\n";
    $schema .= '<CUSTOMERS_FIRSTNAME>' . $address['customers_firstname'] . '</CUSTOMERS_FIRSTNAME>' . "\n";
    $schema .= '<CUSTOMERS_LASTNAME>' . $address['customers_lastname'] . '</CUSTOMERS_LASTNAME>' . "\n";
    $schema .= '<CUSTOMERS_EMAIL_ADDRESS>' . $address['customers_email_address'] . '</CUSTOMERS_EMAIL_ADDRESS>' . "\n";
    $schema .= '</CUSTOMERS_DATA>' . "\n";
    
    echo $schema;
  }
  $schema = '</CUSTOMERS>' . "\n\n";
  echo $schema;
}

//--------------------------------------------------------------

function SendShopConfig ()
{
  $schema = '<?xml version="1.0" encoding="' . CHARSET . '"?>' . "\n" .
            '<CONFIG>' . "\n" .
            '<CONFIG_DATA>' . "\n" ;
  echo $schema;
  
  $config_sql = 'select * from configuration';
  $config_res = tep_db_query($config_sql);

  while ($config = tep_db_fetch_array($config_res)) 
  {
    $schema = '<ENTRY ID="' . $config['configuration_id'] . '">' .  "\n" .
	           '<PARAM>' . htmlspecialchars($config['configuration_key']) . '</PARAM>' . "\n" .
	           '<VALUE>' . htmlspecialchars($config['configuration_value']) . '</VALUE>' . "\n" .
	           '<TITLE>' . htmlspecialchars($config['configuration_title']) . '</TITLE>' . "\n" .
	           '<DESCRIPTION>' . htmlspecialchars($config['configuration_description']) . '</DESCRIPTION>' . "\n" .
	           '<GROUP_ID>' . htmlspecialchars($config['config_group_id']) . '</GROUP_ID>' . "\n" .
	           '<SORT_ORDER>' . htmlspecialchars($config['sort_order']) . '</SORT_ORDER>' . "\n" .
	           '<USE_FUNCTION>' . htmlspecialchars($config['use_function']) . '</USE_FUNCTION>' . "\n" .
	           '<SET_FUNCTION>' . htmlspecialchars($config['set_function']) . '</SET_FUNCTION>' . "\n" .
	           '</ENTRY>' . "\n";
    echo $schema;
  }	  
  $schema = '</CONFIG_DATA>' . "\n";
  echo $schema;
	
	
  $schema = '<TAX_CLASS>' . "\n";
  echo $schema;
	
  $tax_class_sql = 'select * from tax_class';
  $tax_class_res = tep_db_query($tax_class_sql);
	
  while ($tax_class = tep_db_fetch_array($tax_class_res)) 
  {
    $schema = '<CLASS ID="' . $tax_class['tax_class_id'] . '">' . "\n" .
	           '<TITLE>' .         htmlspecialchars($tax_class['tax_class_title']) .       '</TITLE>' . "\n" .
	           '<DESCRIPTION>' .   htmlspecialchars($tax_class['tax_class_description']) . '</DESCRIPTION>' . "\n" .
	           '<LAST_MODIFIED>' . htmlspecialchars($tax_class['last_modified']) .         '</LAST_MODIFIED>' . "\n" .
	           '<DATE_ADDED>' .    htmlspecialchars($tax_class['date_added']) .            '</DATE_ADDED>' . "\n" .
              '</CLASS>'. "\n";
    echo $schema;
  }
	
  $schema = '</TAX_CLASS>' . "\n";
  echo $schema;
  $schema = '<TAX_RATES>' . "\n";
  echo $schema;

  $tax_rates_sql = 'select * from tax_rates';
  $tax_rates_res = tep_db_query($tax_rates_sql);
	
  while ($tax_rates = tep_db_fetch_array($tax_rates_res)) 
  {
    $schema = '<RATES ID=">' . $tax_rates['tax_rates_id'] . '">' . "\n" .
              '<ZONE_ID>' .       htmlspecialchars($tax_rates['tax_zone_id']) .     '</ZONE_ID>' . "\n" .
              '<CLASS_ID>' .      htmlspecialchars($tax_rates['tax_class_id']) .    '</CLASS_ID>' . "\n" .
              '<PRIORITY>' .      htmlspecialchars($tax_rates['tax_priority']) .    '</PRIORITY>' . "\n" .
              '<RATE>' .          htmlspecialchars($tax_rates['tax_rate']) .        '</RATE>' . "\n" .
              '<DESCRIPTION>' .   htmlspecialchars($tax_rates['tax_description']) . '</DESCRIPTION>' . "\n" .
              '<LAST_MODIFIED>' . htmlspecialchars($tax_rates['last_modified']) .   '</LAST_MODIFIED>' . "\n" .
              '<DATE_ADDED>' .    htmlspecialchars($tax_rates['date_added']) .      '</DATE_ADDED>' . "\n" .
              '</RATES>' . "\n";
    echo $schema;
  }
  $schema = '</TAX_RATES>' . "\n";
  echo $schema;
  $schema = '</CONFIG>' . "\n";		  
  echo $schema;
}

//--------------------------------------------------------------
 
function SendXMLHeader ()
{
  header ("Last-Modified: ". gmdate ("D, d M Y H:i:s"). " GMT");  // immer geändert
  header ("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
  header ("Pragma: no-cache"); // HTTP/1.0
  header ("Content-type: text/xml");
}
//--------------------------------------------------------------
 

function SendHTMLHeader ()
{
  header ("Last-Modified: ". gmdate ("D, d M Y H:i:s"). " GMT");  // immer geändert
  header ("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
  header ("Pragma: no-cache"); // HTTP/1.0
  header ("Content-type: text/html");
}

//--------------------------------------------------------------

function ShowHTMLMenu ()
{
  global $version_nr, $version_datum, $PHP_SELF;
  
  SendHTMLHeader;

?>
<html><head></head><body style="font-family: sans-serif; font-size: small; ">
<h3>CAO-Faktura - osCommerce Shopanbindung</h3>
<p>Version <?php echo $version_nr; ?> Stand : <?php echo $version_datum; ?></p>
<p>(powered by swisscart&reg;)</p>
<br><b>m&ouml;gliche Funktionen :</b><br><br>
<a href="<?php echo $PHP_SELF; ?>?action=version">Ausgabe XML Scriptversion</a><br>
<br>
<a href="<?php echo $PHP_SELF; ?>?action=manufacturers_export">Ausgabe XML Manufacturers</a><br>
<a href="<?php echo $PHP_SELF; ?>?action=categories_export">Ausgabe XML Categories</a><br>
<a href="<?php echo $PHP_SELF; ?>?action=products_export">Ausgabe XML Products</a><br>
<a href="<?php echo $PHP_SELF; ?>?action=customers_export">Ausgabe XML Customers</a><br>
<a href="<?php echo $PHP_SELF; ?>?action=customers_newsletter_export">Ausgabe XML Customers-Newsletter</a><br>
<br>
<a href="<?php echo $PHP_SELF; ?>?action=orders_export">Ausgabe XML Orders</a><br>
<br>
<a href="<?php echo $PHP_SELF; ?>?action=config_export">Ausgabe XML Shop-Config</a><br>
<br>
<a href="<?php echo $PHP_SELF; ?>?action=update_tables">MySQL-Tabellen aktualisieren</a><br>
<a href="<?php echo $PHP_SELF; ?>?action=update_tables_3_images">MySQL-Tabellen f&uuml;r 3 Produktbilder erweitern</a><br>
<?php
  if (!file_exists('.htaccess'))
  {
?>
<br><font color="red"><b>Achtung :<br>
Das Verzeichnis in dem sich diese Script befindet ist nicht per .htaccess gesch&uuml;tzt.<br>
Dies stellt m&ouml;glicherweise ein potenzielles Sicherheitsrisiko dar !!!</b></font>
<?php  
  }
?>
</body>
</html>
<?php
}   

//--------------------------------------------------------------   
   
function UpdateTables ()
{
  global $version_nr, $version_datum;
  
  SendHTMLHeader;

  echo '<html><head></head><body>';
  echo '<h3>Tabellen-Update / Erweiterung für CAO-Faktura</h3>';
  echo '<h4>Version ' . $version_nr . ' Stand : ' . $version_datum .'</h4>';
      
  $sql[1]  = 'ALTER TABLE ' . TABLE_ORDERS . ' ADD payment_class VARCHAR(32) NOT NULL';
  $sql[2]  = 'ALTER TABLE ' . TABLE_ORDERS . ' ADD shipping_method VARCHAR(32) NOT NULL';
  $sql[3]  = 'ALTER TABLE ' . TABLE_ORDERS . ' ADD shipping_class VARCHAR(32) NOT NULL';
  $sql[4]  = 'ALTER TABLE ' . TABLE_ORDERS . ' ADD billing_country_iso_code_2 CHAR(2) NOT NULL AFTER billing_country';
  $sql[5]  = 'ALTER TABLE ' . TABLE_ORDERS . ' ADD delivery_country_iso_code_2 CHAR(2) NOT NULL AFTER delivery_country';
  $sql[6]  = 'ALTER TABLE ' . TABLE_ORDERS . ' ADD billing_firstname VARCHAR(32) NOT NULL AFTER billing_name';
  $sql[7]  = 'ALTER TABLE ' . TABLE_ORDERS . ' ADD billing_lastname VARCHAR(32) NOT NULL AFTER billing_firstname';
  $sql[8]  = 'ALTER TABLE ' . TABLE_ORDERS . ' ADD delivery_firstname VARCHAR(32) NOT NULL AFTER delivery_name';
  $sql[9]  = 'ALTER TABLE ' . TABLE_ORDERS . ' ADD delivery_lastname VARCHAR(32) NOT NULL AFTER delivery_firstname';
  $sql[10] = 'ALTER TABLE ' . TABLE_ORDERS . ' CHANGE payment_method payment_method VARCHAR(255) NOT NULL';
  $sql[11] = 'ALTER TABLE ' . TABLE_ORDERS . ' CHANGE shipping_method shipping_method VARCHAR(255) NOT NULL';
  $sql[12] = 'CREATE TABLE cao_log ( id int(11) NOT NULL auto_increment, date datetime NOT NULL default "0000-00-00 00:00:00",'.
             'user varchar(64) NOT NULL default "", pw varchar(64) NOT NULL default "", method varchar(64) NOT NULL default "",'.
             'action varchar(64) NOT NULL default "", post_data mediumtext, get_data mediumtext, PRIMARY KEY  (id))';
 
  $link = 'db_link';
  
  global $$link, $logger;

  for ($i=1;$i<=12;$i++)
  {
    echo '<b>SQL:</b> ' . $sql[$i] . '<br>';;
	   
    if (mysql_query($sql[$i], $$link))
    {
      echo '<b>Ergebnis : OK</b>';
    }
	   else
    {
      $error = mysql_error();
      $pos=strpos($error,'Duplicate column name');
	       
      if ($pos===False)
      {
        $pos=strpos($error,'already exists');
        if ($pos===False)
        {
          echo '<b>Ergebnis : </b><font color="red"><b>' . $error . '</b></font>';
		  }
		    else
		  {
		    echo '<b>Ergebnis : OK, Tabelle existierte bereits !</b>';
		  }
	   }
	     else
	   {
	     echo '<b>Ergebnis : OK, Spalte existierte bereits !</b>';
	   }	   
	 }
    echo '<br><br>';
  }
  echo '</body></html>';
}

//--------------------------------------------------------------

function UpdateTablesFor3Images ()
{
  global $version_nr, $version_datum;
  
  SendHTMLHeader;

  echo '<html><head></head><body>';
  echo '<h3>Tabellen-Update (F&uuml;r 3 Produktbilder) / Erweiterung für CAO-Faktura</h3>';
  echo '<h4>Version ' . $version_nr . ' Stand : ' . $version_datum .'</h4>';
      
  $sql[1]  = 'ALTER TABLE ' . TABLE_PRODUCTS . ' ADD products_image_medium VARCHAR( 64 ) NOT NULL AFTER products_image';
  $sql[2]  = 'ALTER TABLE ' . TABLE_PRODUCTS . ' ADD products_image_large VARCHAR( 64 ) NOT NULL AFTER products_image_medium';
  
  
 
  $link = 'db_link';
  
  global $$link, $logger;

  for ($i=1;$i<=2;$i++)
  {
    echo '<b>SQL:</b> ' . $sql[$i] . '<br>';;
	   
    if (mysql_query($sql[$i], $$link))
    {
      echo '<b>Ergebnis : OK</b>';
    }
	   else
    {
      $error = mysql_error();
      $pos=strpos($error,'Duplicate column name');
	       
      if ($pos===False)
      {
        $pos=strpos($error,'already exists');
        if ($pos===False)
        {
          echo '<b>Ergebnis : </b><font color="red"><b>' . $error . '</b></font>';
		  }
		    else
		  {
		    echo '<b>Ergebnis : OK, Tabelle existierte bereits !</b>';
		  }
	   }
	     else
	   {
	     echo '<b>Ergebnis : OK, Spalte existierte bereits !</b>';
	   }	   
	 }
    echo '<br><br>';
  }
  echo '</body></html>';
}

//--------------------------------------------------------------

function ManufacturersImageUpload ()
{
  global $_GET;
  
  if ($manufacturers_image = new upload('manufacturers_image', DIR_FS_CATALOG_IMAGES)) 
  {
    $code = 0;
    $message = 'OK';
  } else {
    $code = -1;
    $message = 'UPLOAD FAILED';
  }
  print_xml_status ($code, $_GET['action'], $message, '', 'FILE_NAME', $manufacturers_image->filename);
}

//--------------------------------------------------------------

function CategoriesImageUpload ()
{
  global $_GET;
 
  if ($categories_image = new upload('categories_image', DIR_FS_CATALOG_IMAGES)) 
  {
    $code = 0;
    $message = 'OK';
  } else {
    $code = -1;
    $message = 'UPLOAD FAILED';
  } 
  print_xml_status ($code, $_GET['action'], $message, '', 'FILE_NAME', $categories_image->filename);       
}

//--------------------------------------------------------------

function ProductsImageUpload ()
{
  global $_GET;
  
  $products_image = new upload('products_image');
  $products_image->set_destination(DIR_FS_CATALOG_IMAGES);
  if ($products_image->parse() && $products_image->save())  
  {
    $code = 0;
    $message = 'OK';
  } else {
    $code = -1;
    $message = 'UPLOAD FAILED';
  }        
  print_xml_status ($code, $_GET['action'], $message, '', 'FILE_NAME', $products_image->filename);
}

//--------------------------------------------------------------

function ProductsImageUploadMed ()
{
  global $_GET;
  
  if (DREI_PRODUKTBILDER == true) 
  {
    $products_image = new upload('products_image');
    $products_image->set_destination(DIR_FS_CATALOG_IMAGES_MEDIUM);
    if ($products_image->parse() && $products_image->save())  
    {
      $code = 0;
      $message = 'OK';
    } else {
      $code = -1;
      $message = 'UPLOAD FAILED';
    } 
    print_xml_status ($code, $_GET['action'], $message, '', 'FILE_NAME', $products_image->filename);
  } else {
    print_xml_status (-1, $_GET['action'], 'MULTIPLE IMAGES NOT INSTALLED', '', '', '');
  }
}

//--------------------------------------------------------------

function ProductsImageUploadLarge ()
{
  global $_GET;
  
  if (DREI_PRODUKTBILDER == true) 
  {
    $products_image = new upload('products_image');
    $products_image->set_destination(DIR_FS_CATALOG_IMAGES_LARGE);
    if ($products_image->parse() && $products_image->save())  
    {
      $code = 0;
      $message = 'OK';
    } else {
      $code = -1;
      $message = 'UPLOAD FAILED';
    } 
    print_xml_status ($code, $_GET['action'], $message, '', 'FILE_NAME', $products_image->filename);       
  } else {
    print_xml_status (-1, $_GET['action'], 'MULTIPLE IMAGES NOT INSTALLED', '', '', '');
  }
}

//--------------------------------------------------------------

function ManufacturersUpdate ()
{
  global $_POST;

  $manufacturers_id = tep_db_prepare_input($_POST['mID']);
        
  if (isset($manufacturers_id))
  {
    // Hersteller laden
    $count_query = tep_db_query("select manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified from " . TABLE_MANUFACTURERS . " where manufacturers_id='" . $manufacturers_id . "'");
	 if ($manufacturer = tep_db_fetch_array($count_query))
	 {
	   $exists = 1;
	   // aktuelle Herstellerdaten laden
	   $manufacturers_name  = $manufacturer['manufacturers_name'];
	   $manufacturers_image = $manufacturer['manufacturers_image'];
	   $date_added          = $manufacturer['date_added'];
	   $last_modified       = $manufacturer['last_modified'];
	 } 
	   else 
	 {
	   $exists = 0; 
	 }
	        
	 // Variablen nur ueberschreiben wenn als Parameter vorhanden !!!
	 if (isset($_POST['manufacturers_name'])) $manufacturers_name = tep_db_prepare_input($_POST['manufacturers_name']);
	 if (isset($_POST['manufacturers_image'])) $manufacturers_image = tep_db_prepare_input($_POST['manufacturers_image']);
	        
	 $sql_data_array = array('manufacturers_id' => $manufacturers_id,
	                         'manufacturers_name' => $manufacturers_name,
	                         'manufacturers_image' => $manufacturers_image);
	                                
	 if ($exists==0) // Neuanlage (ID wird von CAO vorgegeben !!!)
	 {
	   $mode='APPEND';
	   $insert_sql_data = array('date_added' => 'now()');
	   $sql_data_array = /*tep_*/array_merge($sql_data_array, $insert_sql_data);
	   tep_db_perform(TABLE_MANUFACTURERS, $sql_data_array);
	 } 
	 elseif ($exists==1) //Update
	 {
	   $mode='UPDATE';
	   $update_sql_data = array('last_modified' => 'now()');
	   $sql_data_array = /*tep_*/array_merge($sql_data_array, $update_sql_data);
	   tep_db_perform(TABLE_MANUFACTURERS, $sql_data_array, 'update', 'manufacturers_id = \'' . tep_db_input($manufacturers_id) . '\'');
	 }
	        
	 $languages = tep_get_languages();
	 for ($i = 0, $n = sizeof($languages); $i < $n; $i++) 
	 {
	   $language_id = $languages[$i]['id'];
	          
	   // Bestehende Daten laden
	   $desc_query = tep_db_query("select manufacturers_id,languages_id,manufacturers_url,url_clicked,date_last_click from " . 
	                              TABLE_MANUFACTURERS_INFO . " where manufacturers_id='" . $manufacturers_id . "' and languages_id='" . $language_id . "'");
	   
	   if ($desc = tep_db_fetch_array($desc_query))
	   {
	     $manufacturers_url = $desc['manufacturers_url'];
	     $url_clicked       = $desc['url_clicked'];
	     $date_last_click   = $desc['date_last_click'];
	   }
	          
	   // uebergebene Daten einsetzen
	   if (isset($_POST['manufacturers_url'][$language_id])) $manufacturers_url=tep_db_prepare_input($_POST['manufacturers_url'][$language_id]);
	   if (isset($_POST['url_clicked'][$language_id]))       $url_clicked=tep_db_prepare_input($_POST['url_clicked'][$language_id]);
	   if (isset($_POST['date_last_click'][$language_id]))   $date_last_click=tep_db_prepare_input($_POST['date_last_click'][$language_id]);
	              
	   $sql_data_array = array('manufacturers_url' => $manufacturers_url);
	          
	   if ($exists==0) // Insert
	   {
	     $insert_sql_data = array('manufacturers_id' => $manufacturers_id,
	                              'languages_id' => $language_id);
	     $sql_data_array = /*tep_*/array_merge($sql_data_array, $insert_sql_data);
	     tep_db_perform(TABLE_MANUFACTURERS_INFO, $sql_data_array);
	   } 
	   else if ($exists==1) // Update
	   {
	     tep_db_perform(TABLE_MANUFACTURERS_INFO, $sql_data_array, 'update', 'manufacturers_id = \'' . tep_db_input($manufacturers_id) . '\' and languages_id = \'' . $language_id . '\'');
	   }
	 }
    print_xml_status (0, $_POST['action'], 'OK', $mode ,'MANUFACTURERS_ID', $mID);
  }
    else
  {
    print_xml_status (99, $_POST['action'], 'PARAMETER ERROR', '', '', '');
  }
}

//--------------------------------------------------------------

function ManufacturersErase ()
{
  global $_POST;
  
  $ManID  = tep_db_prepare_input($_POST['mID']);
		  
  if (isset($ManID))
  {
    // Hersteller loeschen
    tep_db_query("delete from " . TABLE_MANUFACTURERS . " where manufacturers_id = '" . (int)$ManID . "'");
    tep_db_query("delete from " . TABLE_MANUFACTURERS_INFO . " where manufacturers_id = '" . (int)$ManID . "'");
          
    // Herstellerverweis in den Artikeln loeschen
    tep_db_query("update " . TABLE_PRODUCTS . " set manufacturers_id = '' where manufacturers_id = '" . (int)$ManID . "'");

    print_xml_status (0, $_POST['action'], 'OK', '', '', '');
    
  } 
   else 
  {
    print_xml_status (99, $_POST['action'], 'PARAMETER ERROR', '', '', '');
  }
}

//--------------------------------------------------------------

function ProductsUpdate ()
{
  global $_POST, $LangID;

  $products_id = tep_db_prepare_input($_POST['pID']);
  
  // product laden
  $SQL = "select products_quantity,products_model,products_image,products_price,products_date_available,products_weight,products_status,products_tax_class_id,manufacturers_id ";

  if (DREI_PRODUKTBILDER == true)
  {
    $SQL .= ", products_image_medium, products_image_large ";
  }
  $count_query = tep_db_query($SQL . " from " . TABLE_PRODUCTS . " where products_id='" . $products_id . "'");
  if ($product = tep_db_fetch_array($count_query))
  {
    $exists = 1;
    // aktuelle Produktdaten laden
    $products_quantity = $product['products_quantity'];
    $products_model = $product['products_model'];
    $products_image = $product['products_image'];
           
    if (DREI_PRODUKTBILDER == true)
    {
      $products_image_med = $product['products_image_medium'];
      $products_image_large = $product['products_image_large'];
    }
           
    $products_price = $product['products_price'];
    $products_date_available = $product['products_date_available'];
    $products_weight = $product['products_weight'];
    $products_status = $product['products_status'];
    $products_tax_class_id = $product['products_tax_class_id'];
    $manufacturers_id = $product['manufacturers_id'];
  } 
  else $exists = 0; 
        
  // Variablen nur ueberschreiben wenn als Parameter vorhanden !!!
  if (isset($_POST['products_quantity'])) $products_quantity = tep_db_prepare_input($_POST['products_quantity']);
  if (isset($_POST['products_model'])) $products_model = tep_db_prepare_input($_POST['products_model']);
  if (isset($_POST['products_image'])) $products_image = tep_db_prepare_input($_POST['products_image']);
        
  if (DREI_PRODUKTBILDER == true)
  {
    if (isset($_POST['products_image_med'])) $products_image_med = tep_db_prepare_input($_POST['products_image_med']);
    if (isset($_POST['products_image_large'])) $products_image_large = tep_db_prepare_input($_POST['products_image_large']);
  }
        
  if (isset($_POST['products_price'])) $products_price = tep_db_prepare_input($_POST['products_price']);
  if (isset($_POST['products_date_available'])) $products_date_available = tep_db_prepare_input($_POST['products_date_available']);
  if (isset($_POST['products_weight'])) $products_weight = tep_db_prepare_input($_POST['products_weight']);
  if (isset($_POST['products_status'])) $products_status = tep_db_prepare_input($_POST['products_status']);
  if (isset($_POST['products_tax_class_id'])) $products_tax_class_id = tep_db_prepare_input($_POST['products_tax_class_id']);
  if (isset($_POST['manufacturers_id'])) $manufacturers_id = tep_db_prepare_input($_POST['manufacturers_id']);
        
  if (file_exists('cao_produpd_1.php')) { include('cao_produpd_1.php'); }
        
  $products_date_available = (date('Y-m-d') < $products_date_available) ? $products_date_available : 'null';
          
  if (DREI_PRODUKTBILDER == true)
  {
    $sql_data_array = array('products_id' => $products_id,
                            'products_quantity' => $products_quantity,
                            'products_model' => $products_model,
                            'products_image' => ($products_image == 'none') ? '' : $products_image,
                            'products_image_medium' => ($products_image_med == 'none') ? '' : $products_image_med,
                            'products_image_large' => ($products_image_large == 'none') ? '' : $products_image_large,
                            'products_price' => $products_price,
                            'products_date_available' => $products_date_available,
                            'products_weight' => $products_weight,
                            'products_status' => $products_status,
                            'products_tax_class_id' => $products_tax_class_id,
                            'manufacturers_id' => $manufacturers_id);
  }
    else
  {
    $sql_data_array = array('products_id' => $products_id,
                            'products_quantity' => $products_quantity,
                            'products_model' => $products_model,
                            'products_image' => ($products_image == 'none') ? '' : $products_image,
                            'products_price' => $products_price,
                            'products_date_available' => $products_date_available,
                            'products_weight' => $products_weight,
                            'products_status' => $products_status,
                            'products_tax_class_id' => $products_tax_class_id,
                            'manufacturers_id' => $manufacturers_id);
  }
          
  if ($exists==0) // Neuanlage (ID wird an CAO zurueckgegeben !!!)
  {
    $mode='APPEND';
    $insert_sql_data = array('products_date_added' => 'now()');
    $sql_data_array = /*tep_*/array_merge($sql_data_array, $insert_sql_data);
    tep_db_perform(TABLE_PRODUCTS, $sql_data_array);
    $products_id = tep_db_insert_id();
  } 
  elseif ($exists==1) //Update
  {
    $mode='UPDATE';
    $update_sql_data = array('products_last_modified' => 'now()');
    $sql_data_array = /*tep_*/array_merge($sql_data_array, $update_sql_data);
      
    tep_db_perform(TABLE_PRODUCTS, $sql_data_array, 'update', 'products_id = \'' . tep_db_input($products_id) . '\'');
  }
        
  $languages = tep_get_languages();
  for ($i = 0, $n = sizeof($languages); $i < $n; $i++) 
  {
    $language_id = $languages[$i]['id'];
          
    // Bestehende Daten laden
    $SQL = "select products_id,products_name,products_description,products_url,products_viewed,language_id";
	  
    if (HEADERTAGS == true)
    {
      $SQL .= ", products_head_title_tag, products_head_desc_tag, products_head_keywords_tag";
    }
	
    $desc_query = tep_db_query($SQL . " from " . TABLE_PRODUCTS_DESCRIPTION . " where products_id='" . $products_id . "' and language_id='" . $language_id . "'");
    if ($desc = tep_db_fetch_array($desc_query))
    {
      $products_name = $desc['products_name'];
      $products_description = $desc['products_description'];
      $products_url = $desc['products_url'];
	    
      if (HEADERTAGS == true)
      {
        $products_head_title_tag    = $desc['products_head_title_tag'];
        $products_head_desc_tag     = $desc['products_head_desc_tag'];
        $products_head_keywords_tag = $desc['products_head_keywords_tag'];	      
      }
    }
          
    // uebergebene Daten einsetzen
    if (isset($_POST['products_name'][$LangID]))              $products_name             =tep_db_prepare_input($_POST['products_name'][$LangID]);
    if (isset($_POST['products_description'][$LangID]))       $products_description      =tep_db_prepare_input($_POST['products_description'][$LangID]);
    if (isset($_POST['products_url'][$LangID]))               $products_url              =tep_db_prepare_input($_POST['products_url'][$LangID]);
	  
    if (isset($_POST['products_meta_title'][$LangID]))        $products_head_title_tag   =tep_db_prepare_input($_POST['products_meta_title'][$LangID]);	  
    if (isset($_POST['products_meta_description'][$LangID]))  $products_head_desc_tag    =tep_db_prepare_input($_POST['products_meta_description'][$LangID]);
    if (isset($_POST['products_meta_keywords'][$LangID]))     $products_head_keywords_tag=tep_db_prepare_input($_POST['products_meta_keywords'][$LangID]);    

    $sql_data_array = array('products_name' => $products_name,
                            'products_description' => $products_description,
                            'products_url' => $products_url);
          
    if (HEADERTAGS == true)
    {
      $sql_data_array2 = array('products_head_title_tag'    => $products_head_title_tag,
                               'products_head_desc_tag'     => $products_head_desc_tag,
                               'products_head_keywords_tag' => $products_head_keywords_tag);
      
      $sql_data_array = /*tep_*/array_merge($sql_data_array, $sql_data_array2); 
    }
          
    if ($exists==0) // Insert
    {
      $insert_sql_data = array('products_id' => $products_id,
                               'language_id' => $language_id);
      $sql_data_array = /*tep_*/array_merge($sql_data_array, $insert_sql_data);
      tep_db_perform(TABLE_PRODUCTS_DESCRIPTION, $sql_data_array);
    } 
    elseif (($exists==1)and($LangID==$language_id)) // Update
    {
      tep_db_perform(TABLE_PRODUCTS_DESCRIPTION, $sql_data_array, 'update', 'products_id = \'' . tep_db_input($products_id) . '\' and language_id = \'' . $language_id . '\'');
    }
  }
  if (file_exists('cao_produpd_2.php')) { include('cao_produpd_2.php'); }
  
  print_xml_status (0, $_POST['action'], 'OK', $mode, 'PRODUCTS_ID', $products_id);
}

//--------------------------------------------------------------
 
function ProductsErase ()
{
  global $_POST;
  $ProdID  = tep_db_prepare_input($_POST['prodid']);

  if (isset($ProdID))
  {       
    // ProductsToCategieries loeschen bei denen die products_id = ... ist
    $res1 = tep_db_query("delete from " . TABLE_PRODUCTS_TO_CATEGORIES . " where products_id='" . $ProdID . "'");

    // Product loeschen
    tep_remove_product($ProdID);

    print_xml_status (0, $_POST['action'], 'OK', '', 'SQL_RES1', $res1);
  }
    else
  {
    print_xml_status (99, $_POST['action'], 'PARAMETER ERROR', '', '', '');
  }
}

//--------------------------------------------------------------
 
function ProductsSpecialPriceUpdate ()
{
  global $_POST;

  $ProdID  = tep_db_prepare_input($_POST['prodid']);

  $Price = tep_db_prepare_input($_POST['price']);
  $Status = tep_db_prepare_input($_POST['status']);
  $Expire = tep_db_prepare_input($_POST['expired']);
		  
  if (isset($ProdID))
  {
    /*
    1. Ermitteln ob Produkt bereits einen Spezialpreis hat
    2. wenn JA -> Update / NEIN -> INSERT		    
    */

    $sp_sql = "select specials_id from " . TABLE_SPECIALS . " " .
              "where products_id='" . (int)$ProdID . "'";
    $sp_query = tep_db_query($sql);

    if ($sp = tep_db_fetch_array($sp_query))
    {
      // es existiert bereits ein Datensatz -> Update
      $SpecialID = $sp['specials_id'];
           
      tep_db_query(
              "update " . TABLE_SPECIALS . 
              " set specials_new_products_price = '" . $Price . "'," .
              " specials_last_modified = now()," . 
              " expires_date = '" . $Expire .
              "' where specials_id = '" . (int)$SpecialID. "'");
            
      print_xml_status (0, $_POST['action'], 'OK', 'UPDATE', '', '');
           
    }
      else
    {
      // Neuanlage
      tep_db_query(
              "insert into " . TABLE_SPECIALS .
              " (products_id, specials_new_products_price, specials_date_added, expires_date, status) " .
              " values ('" . (int)$ProdID . "', '" . $Price . "', now(), '" . $Expire . "', '1')");
            
      print_xml_status (0, $_POST['action'], 'OK', 'APPEND', '', '');
    }
  }
    else
  {
    print_xml_status (99, $_POST['action'], 'PARAMETER ERROR', '', '', '');
  }
}

//--------------------------------------------------------------
 
function ProductsSpecialPriceErase ()
{
  global $_POST;
  
  $ProdID  = tep_db_prepare_input($_POST['prodid']);
  if (isset($ProdID))
  {
    tep_db_query("delete from " . TABLE_SPECIALS . " where products_id = '" . (int)$ProdID . "'");
    print_xml_status (0, $_POST['action'], 'OK', '', '', '');
  }
    else
  {
    print_xml_status (99, $_POST['action'], 'PARAMETER ERROR', '', '', '');
  }
}

//--------------------------------------------------------------

function CategoriesUpdate ()
{
  global $_POST, $LangID;

  $CatID    = tep_db_prepare_input($_POST['catid']);
  $ParentID = tep_db_prepare_input($_POST['parentid']);
  
  if (isset($ParentID) && isset($CatID))
  {
    // product laden
    $SQL  = "select categories_id, parent_id, date_added, sort_order, categories_image";
   
    $SQL .=" from " . TABLE_CATEGORIES . " where categories_id='" . $CatID . "'";


    $count_query = tep_db_query($SQL);
    if ($categorie = tep_db_fetch_array($count_query))
    {
      $exists = 1;
    
      $ParentID = $categorie['parent_id'];
      $Sort     = $categorie['sort_order'];
      $Image    = $categorie['categories_image'];   
    } 
    else $exists = 0; 
        
    // Variablen nur ueberschreiben wenn als Parameter vorhanden !!!
    if (isset($_POST['parentid'])) $ParentID = tep_db_prepare_input($_POST['parentid']);
    if (isset($_POST['sort']))     $Sort     = tep_db_prepare_input($_POST['sort']);
    if (isset($_POST['image']))    $Image    = tep_db_prepare_input($_POST['image']);
    
    
  
  
    $sql_data_array = array('categories_id'    => $CatID,
                            'parent_id'        => $ParentID,
                            'sort_order'       => $Sort,
                            'categories_image' => $Image,
                            'last_modified'    => 'now()');
  
    if ($exists==0) // Neuanlage 
    {
      $mode='APPEND';
      $insert_sql_data = array('date_added' => 'now()');
      $sql_data_array = /*tep_*/array_merge($sql_data_array, $insert_sql_data);

      tep_db_perform(TABLE_CATEGORIES, $sql_data_array);
    } 
    elseif ($exists==1) //Update
    {
      $mode='UPDATE';

      tep_db_perform(TABLE_CATEGORIES, $sql_data_array, 'update', 'categories_id = \'' . tep_db_input($CatID) . '\'');
    }
        
    $languages = tep_get_languages();
    for ($i = 0, $n = sizeof($languages); $i < $n; $i++) 
    {
      $language_id = $languages[$i]['id'];
      
      // Bestehende Daten laden
      $SQL = "select categories_id,language_id,categories_name";
	  
      if (HEADERTAGS == true)
      {
        $SQL .= ",categories_htc_title_tag,categories_htc_desc_tag,categories_htc_keywords_tag,categories_htc_description";
      }
      
      if (CATDESCR == true)
      {
        $SQL .= ",categories_description";
      }
	
      $desc_query = tep_db_query($SQL . " from " . TABLE_CATEGORIES_DESCRIPTION . " where categories_id='" . $CatID . "' and language_id='" . $language_id . "'");
      if ($desc = tep_db_fetch_array($desc_query))
      {
        $categories_name = $desc['categories_name'];
        
        if (HEADERTAGS == true)
        {
          $categories_htc_title_tag    = $desc['categories_htc_title_tag'];
          $categories_htc_desc_tag     = $desc['categories_htc_desc_tag'];
          $categories_htc_keywords_tag = $desc['categories_htc_keywords_tag'];        
        }
        if (CATDESCR == true)
        {
          $categories_description = $desc['categories_description'];        
        }
      }
        
      // uebergebene Daten einsetzen
      if (isset($_POST['name']))              $categories_name =tep_db_prepare_input(UrlDecode($_POST['name']));
      
      if (CATDESCR == true)
      {
        if (isset($_POST['descr']))                     $categories_description = tep_db_prepare_input(UrlDecode($_POST['descr']));
      }
        
      if (isset($_POST['categories_meta_title']))       $categories_htc_title_tag    = tep_db_prepare_input($_POST['categories_meta_title']);	  
	   if (isset($_POST['categories_meta_description'])) $categories_htc_desc_tag     = tep_db_prepare_input($_POST['categories_meta_description']);
	   if (isset($_POST['categories_meta_keywords']))    $categories_htc_keywords_tag = tep_db_prepare_input($_POST['categories_meta_keywords']);    

      $sql_data_array = array('categories_name' => $categories_name);

                            
      if (HEADERTAGS == true)
      {
        $sql_data_array2 = array('categories_htc_title_tag'    => $categories_htc_title_tag,
                                 'categories_htc_desc_tag'     => $categories_htc_desc_tag,
                                 'categories_htc_keywords_tag' => $categories_htc_keywords_tag);
		      
		  $sql_data_array = /*tep_*/array_merge($sql_data_array, $sql_data_array2); 
		}
		
		if (CATDESCR == true)
      {
        $sql_data_array3 = array('categories_description'    => $categories_description);
		      
		  $sql_data_array = /*tep_*/array_merge($sql_data_array, $sql_data_array3); 
		}
		  
		if ($exists==0) // Insert
      {
        $insert_sql_data = array('categories_id' => $CatID,
                                 'language_id' => $language_id);
                                 
        $sql_data_array = /*tep_*/array_merge($sql_data_array, $insert_sql_data);
        tep_db_perform(TABLE_CATEGORIES_DESCRIPTION, $sql_data_array);
      } 
      elseif (($exists==1)and($language_id==$LangID)) // Update
      {
        // Nur 1 Sprache aktualisieren
        tep_db_perform(TABLE_CATEGORIES_DESCRIPTION, $sql_data_array, 'update', 'categories_id = \'' . tep_db_input($CatID) . '\' and language_id = \'' . $language_id . '\'');
      }
    }
    print_xml_status (0, $_POST['action'], 'OK', $mode, '', '');
  }
    else
  {
    print_xml_status (99, $_POST['action'], 'PARAMETER ERROR', '', '', '');
  }
}

//--------------------------------------------------------------

function CategoriesErase ()
{
  global $_POST;
  
  $CatID  = tep_db_prepare_input($_POST['catid']);

  if (isset($CatID))
  {
    // Categorie loeschen
    $res1 = tep_db_query("delete from " . TABLE_CATEGORIES . " where categories_id='" . $CatID . "'");
    // ProductsToCategieries loeschen bei denen die Categorie = ... ist
    $res2 = tep_db_query("delete from " . TABLE_PRODUCTS_TO_CATEGORIES . " where categories_id='" . $CatID . "'");
    // CategieriesDescription loeschenm bei denen die Categorie = ... ist
    $res3 = tep_db_query("delete from " . TABLE_CATEGORIES_DESCRIPTION . " where categories_id='" . $CatID . "'");

    print_xml_status (0, $_POST['action'], 'OK', '', 'SQL_RES1', $res1);
  }
    else
  {
    print_xml_status (99, $_POST['action'], 'PARAMETER ERROR', '', '', '');
  }
}

//--------------------------------------------------------------

function Prod2CatUpdate ()
{
  global $_POST;
  
  $ProdID = tep_db_prepare_input($_POST['prodid']);
  $CatID  = tep_db_prepare_input($_POST['catid']);
		  
  if (isset($ProdID) && isset($CatID))
  {
    $res = tep_db_query("replace into " . TABLE_PRODUCTS_TO_CATEGORIES . " (products_id, categories_id) Values ('" . $ProdID ."', '" . $CatID . "')");
    print_xml_status (0, $_POST['action'], 'OK', '', 'SQL_RES', $res);
  }
    else
  {
    print_xml_status (99, $_POST['action'], 'PARAMETER ERROR', '', '', '');
  }
}

//--------------------------------------------------------------

function Prod2CatErase ()
{
  global $_POST;
  
  $ProdID = tep_db_prepare_input($_POST['prodid']);
  $CatID  = tep_db_prepare_input($_POST['catid']);

  if (isset($ProdID) && isset($CatID))
  {
    $res = tep_db_query("delete from " . TABLE_PRODUCTS_TO_CATEGORIES . " where products_id='" . $ProdID ."' and categories_id='" . $CatID . "'");
    print_xml_status (0, $_POST['action'], 'OK', '', 'SQL_RES', $res);
  }
    else
  {
    print_xml_status (99, $_POST['action'], 'PARAMETER ERROR', '', '', '');
  }
}

//--------------------------------------------------------------

function OrderUpdate ()
{
  global $_POST, $LangID;
  
  $schema = '<?xml version="1.0" encoding="' . CHARSET . '"?>' . "\n" . "\n";
        
  if ((isset($_POST['order_id'])) && (isset($_POST['status']))) 
  {
    // Per Post übergebene Variablen
    $oID = $_POST['order_id'];
    $status = $_POST['status'];
    $comments = tep_db_prepare_input($_POST['comments']);
    $cao_language = $_POST['cao_language'];  // german, english, espanol...
    // Weiter wird per POST übergeben:
    // $_POST['notify'] == 'on' für Emailversand
    // $_POST['notify_comments'] == 'on'  für Versand des Kommentars
          
    //Status überprüfen
    $check_status_query = tep_db_query("select * from " . TABLE_ORDERS . " where orders_id = '" . tep_db_input($oID) . "'");
    if ($check_status = tep_db_fetch_array($check_status_query)) 
    {
      if ($check_status['orders_status'] != $status || $comments != '') 
      {
        tep_db_query("update " . TABLE_ORDERS . " set orders_status = '" . tep_db_input($status) . "', last_modified = now() where orders_id = '" . tep_db_input($oID) . "'");
        $customer_notified = '0';
        if ($_POST['notify'] == 'on') 
        {
          // Falls eine Sprach ID zur Order existiert die Emailbestätigung in dieser Sprache ausführen
          if (isset($check_status['orders_language_id']) && $check_status['orders_language_id'] > 0 ) 
          {
            $osc_language_query = tep_db_query("select directory from " . TABLE_LANGUAGES . " where languages_id = '" . $check_status['orders_language_id'] . "'");
            $osc_language = tep_db_fetch_array($osc_language_query);
            if ( strlen($osc_language['directory']) > 0 ) 
            {
              $cao_language = $osc_language['directory'];
            }
            $orders_status_query = tep_db_query("select orders_status_id, orders_status_name from " . TABLE_ORDERS_STATUS . " where language_id = '" . $check_status['orders_language_id'] . "'");
            if (tep_db_num_rows($orders_status_query) == 0) 
            {
              $orders_status_query = tep_db_query("select orders_status_id, orders_status_name from " . TABLE_ORDERS_STATUS . " where language_id = '" . $LangID /*$languages_id*/ . "'");
            }
          } else {
            $orders_status_query = tep_db_query("select orders_status_id, orders_status_name from " . TABLE_ORDERS_STATUS . " where language_id = '" . $LangID /*$languages_id*/ . "'");
          }
        
          //$orders_statuses = array();
          $orders_status_array = array();
          while ($orders_status = tep_db_fetch_array($orders_status_query)) 
          {
            //$orders_statuses[] = array('id'   => $orders_status['orders_status_id'],
            //                           'text' => $orders_status['orders_status_name']);
            $orders_status_array[$orders_status['orders_status_id']] = $orders_status['orders_status_name'];
          }
                  
          // Wir nehmen die Orginal Emailbestätigung des OSC Admins
          if (file_exists(DIR_WS_LANGUAGES . $cao_language . '/' . FILENAME_ORDERS)) 
          {
            include(DIR_WS_LANGUAGES . $cao_language . '/' . FILENAME_ORDERS);
            $language = $cao_language;
          } else if (file_exists(DIR_WS_LANGUAGES . $language . '/' . FILENAME_ORDERS)) 
          {
            include(DIR_WS_LANGUAGES . $language . '/' . FILENAME_ORDERS);
          }               
 
          if ($_POST['notify_comments'] == 'on') 
          {
            $notify_comments = sprintf(EMAIL_TEXT_COMMENTS_UPDATE, $comments) . "\n\n";
          }
          $email = STORE_NAME . "\n" . EMAIL_SEPARATOR . "\n" . EMAIL_TEXT_ORDER_NUMBER . ' ' . $oID . "\n" . EMAIL_TEXT_INVOICE_URL . ' ' . tep_catalog_href_link(FILENAME_CATALOG_ACCOUNT_HISTORY_INFO, 'order_id=' . $oID, 'SSL') . "\n" . EMAIL_TEXT_DATE_ORDERED . ' ' . tep_date_long($check_status['date_purchased']) . "\n\n" . $notify_comments . sprintf(EMAIL_TEXT_STATUS_UPDATE, $orders_status_array[$status]);
          
          //$email .= "\n" . EMAIL_SEPARATOR . "\n" . print_r($orders_status_array) . "\n" . EMAIL_SEPARATOR . "\n" . print($status);
          
          tep_mail($check_status['customers_name'], $check_status['customers_email_address'], EMAIL_TEXT_SUBJECT, nl2br($email), STORE_OWNER, STORE_OWNER_EMAIL_ADDRESS);
          $customer_notified = '1';
        }
        tep_db_query("insert into " . TABLE_ORDERS_STATUS_HISTORY . " (orders_id, orders_status_id, date_added, customer_notified, comments) values ('" . tep_db_input($oID) . "', '" . tep_db_input($status) . "', now(), '" . $customer_notified . "', '" . tep_db_input($comments)  . "')");
        $schema .= '<STATUS>' . "\n" .
                   '<STATUS_DATA>' . "\n" .
                   '<ORDER_ID>' . $oID . '</ORDER_ID>' . "\n" .
                   '<ORDER_STATUS>' . $status . '</ORDER_STATUS>' . "\n" .
                   '<ACTION>' . $_POST['action'] . '</ACTION>' . "\n" .
                   '<CODE>' . '0' . '</CODE>' . "\n" .
	                '<MESSAGE>' . 'OK' . '</MESSAGE>' . "\n" . 
                   '</STATUS_DATA>' . "\n" .
                   '</STATUS>' . "\n";
      } 
      else if ($check_status['orders_status'] == $status) 
      {
        // Status ist bereits gesetzt
        $schema .= '<STATUS>' . "\n" .
                   '<STATUS_DATA>' . "\n" .
                   '<ORDER_ID>' . $oID . '</ORDER_ID>' . "\n" .
                   '<ORDER_STATUS>' . $status . '</ORDER_STATUS>' . "\n" .
                   '<ACTION>' . $_POST['action'] . '</ACTION>' . "\n" .
                   '<CODE>' . '1' . '</CODE>' . "\n" .
	                '<MESSAGE>' . 'NO STATUS CHANGE' . '</MESSAGE>' . "\n" . 
                   '</STATUS_DATA>' . "\n" .
                   '</STATUS>' . "\n";
      }
    } 
      else           
    {
      // Fehler Order existiert nicht
      $schema .= '<STATUS>' . "\n" .
                 '<STATUS_DATA>' . "\n" .
                 '<ORDER_ID>' . $oID . '</ORDER_ID>' . "\n" .
                 '<ACTION>' . $_POST['action'] . '</ACTION>' . "\n" .
	       	     '<CODE>' . '2' . '</CODE>' . "\n" .
	              '<MESSAGE>' . 'ORDER_ID NOT FOUND OR SET' . '</MESSAGE>' . "\n" . 
                 '</STATUS_DATA>' . "\n" .
                 '</STATUS>' . "\n";
    }
  } 
    else 
  {
    $schema = '<?xml version="1.0" encoding="' . CHARSET . '"?>' . "\n" .
	           '<STATUS>' . "\n" .
	           '<STATUS_DATA>' . "\n" .
	           '<ACTION>' . $_POST['action'] . '</ACTION>' . "\n" .
	           '<CODE>' . '99' . '</CODE>' . "\n" .
	           '<MESSAGE>' . 'PARAMETER ERROR' . '</MESSAGE>' . "\n" . 
	           '</STATUS_DATA>' . "\n" .
	           '</STATUS>' . "\n\n";
  }
  echo $schema;
}

//--------------------------------------------------------------

function CustomersUpdate ()
{
  global $_POST;
  $customers_id = -1;
  
  if (isset($_POST['cID'])) $customers_id = tep_db_prepare_input($_POST['cID']);
			
  $sql_customers_data_array = array();
  if (isset($_POST['customers_firstname'])) $sql_customers_data_array['customers_firstname'] = $_POST['customers_firstname'];
  if (isset($_POST['customers_lastname'])) $sql_customers_data_array['customers_lastname'] = $_POST['customers_lastname'];
//  if (isset($_POST['customers_company'])) $sql_customers_data_array['customers_company'] = $_POST['customers_company'];
  if (isset($_POST['customers_dob'])) $sql_customers_data_array['customers_dob'] = $_POST['customers_dob'];
  if (isset($_POST['customers_email'])) $sql_customers_data_array['customers_email_address'] = $_POST['customers_email'];
  if (isset($_POST['customers_tele'])) $sql_customers_data_array['customers_telephone'] = $_POST['customers_tele'];
  if (isset($_POST['customers_fax'])) $sql_customers_data_array['customers_fax'] = $_POST['customers_fax'];
  if (isset($_POST['customers_password'])) $sql_customers_data_array['customers_password'] = tep_encrypt_password($_POST['customers_password']);
  	
  if (isset($_POST['customers_gender'])) $sql_customers_data_array['customers_gender'] = $_POST['customers_gender'];
			
  $sql_address_data_array =array();
  if (isset($_POST['customers_firstname'])) $sql_address_data_array['entry_firstname'] = $_POST['customers_firstname'];
  if (isset($_POST['customers_lastname'])) $sql_address_data_array['entry_lastname'] = $_POST['customers_lastname'];
  if (isset($_POST['customers_company'])) $sql_address_data_array['entry_company'] = $_POST['customers_company'];
  if (isset($_POST['customers_street'])) $sql_address_data_array['entry_street_address'] = $_POST['customers_street'];
  if (isset($_POST['customers_city'])) $sql_address_data_array['entry_city'] = $_POST['customers_city'];
  if (isset($_POST['customers_postcode'])) $sql_address_data_array['entry_postcode'] = $_POST['customers_postcode'];
  if (isset($_POST['customers_country_id'])) $country_code = $_POST['customers_country_id'];
  
  $country_query = "SELECT countries_id FROM ".TABLE_COUNTRIES." WHERE countries_iso_code_2 = '".$country_code ."' LIMIT 1";
  $country_result = tep_db_query($country_query);
  $row = tep_db_fetch_array($country_result);
  $sql_address_data_array['entry_country_id'] = $row['countries_id'];
  
  if (file_exists('cao_produpd_1.php')) { include('cao_custupd_1.php'); }
  
  $count_query = tep_db_query("SELECT count(*) as count FROM " . TABLE_CUSTOMERS . " WHERE customers_id='" . (int)$customers_id . "' LIMIT 1");
  $check = tep_db_fetch_array($count_query);
			
  if ($check['count'] > 0) 
  {
    $mode = 'UPDATE';
    $address_book_result = tep_db_query("SELECT customers_default_address_id FROM ".TABLE_CUSTOMERS." WHERE customers_id = '". (int)$customers_id ."' LIMIT 1");
    $customer = tep_db_fetch_array($address_book_result);
    tep_db_perform(TABLE_CUSTOMERS, $sql_customers_data_array, 'update', "customers_id = '" . tep_db_input($customers_id) . "' LIMIT 1");
    tep_db_perform(TABLE_ADDRESS_BOOK, $sql_address_data_array, 'update', "customers_id = '" . tep_db_input($customers_id) . "' AND address_book_id = '".$customer['customers_default_address_id']."' LIMIT 1");
    tep_db_query("update " . TABLE_CUSTOMERS_INFO . " set customers_info_date_account_last_modified = now() where customers_info_id = '" . (int)$customers_id . "'  LIMIT 1");
  }  
    else 
  {
    $mode= 'APPEND';
    
    $sql_customers_data_array['customers_newsletter'] = "0"; // JAN ADDED	    
    tep_db_perform(TABLE_CUSTOMERS, $sql_customers_data_array);
    $customers_id = tep_db_insert_id();
    $sql_address_data_array['customers_id'] = $customers_id;
    tep_db_perform(TABLE_ADDRESS_BOOK, $sql_address_data_array);
    $address_id = tep_db_insert_id();
    tep_db_query("update " . TABLE_CUSTOMERS . " set customers_default_address_id = '" . (int)$address_id . "' where customers_id = '" . (int)$customers_id . "'");

    tep_db_query("insert into " . TABLE_CUSTOMERS_INFO . " (customers_info_id, customers_info_number_of_logons, customers_info_date_account_created) values ('" . (int)$customers_id . "', '0', now())");
  }
  print_xml_status (0, $_POST['action'], 'OK', $mode, 'CUSTOMERS_ID', $customers_id);
}

//--------------------------------------------------------------

function CustomersErase ()
{
  global $_POST;

  $cID  = tep_db_prepare_input($_POST['cID']);
  if (isset($cID)) 
  {
    tep_db_query("update " . TABLE_REVIEWS . " set customers_id = null where customers_id = '" .  $cID . "'");
    tep_db_query("delete from " . TABLE_ADDRESS_BOOK . " where customers_id = '" . $cID . "'");
    tep_db_query("delete from " . TABLE_CUSTOMERS . " where customers_id = '" .$cID . "'");
    tep_db_query("delete from " . TABLE_CUSTOMERS_INFO . " where customers_info_id = '" . $cID. "'");
    tep_db_query("delete from " . TABLE_CUSTOMERS_BASKET . " where customers_id = '" . $cID . "'");
    tep_db_query("delete from " . TABLE_CUSTOMERS_BASKET_ATTRIBUTES . " where customers_id = '" . $cID . "'");
    tep_db_query("delete from " . TABLE_WHOS_ONLINE . " where customer_id = '" . $cID . "'");
	         
    print_xml_status (0, $_POST['action'], 'OK', '', '', '');
  } 
    else 
  {
    print_xml_status (99, $_POST['action'], 'PARAMETER ERROR', '', '', '');
  }
}

//--------------------------------------------------------------
//                     Ende Funktionen 
//-------------------------------------------------------------- 




  $table_has_products_image_medium = false;
  $table_has_products_image_large = false;
  
  $images_query = tep_db_query(' SHOW COLUMNS FROM '.TABLE_PRODUCTS);
  while($column = tep_db_fetch_array($images_query)) {
        if ($column['Field'] == 'products_image_medium') {
          $table_has_products_image_medium = true;
        }
        if ($column['Field'] == 'products_image_large') {
          $table_has_products_image_large = true;
        }
  }
  if ($table_has_products_image_medium && $table_has_products_image_large) {
      define('DREI_PRODUKTBILDER', true);
  } else {
      define('DREI_PRODUKTBILDER', false);
  }


  if (LOGGER==true) 
  {
		// log data into db.
	
		$pdata ='';
		while (list($key, $value) = each($_POST))
		{
	   	if (is_array($value))
	   	{
	   	  while (list($key1, $value1) = each($value))
	        {
	   	    $pdata .= addslashes($key)."[" . addslashes($key1)."] => ".addslashes($value1)."\\r\\n";    	
	   	  }
	   	} 
	   	  else
	   	{
	   	  $pdata .= addslashes($key)." => ".addslashes($value)."\\r\\n";
	   	}
		} 
	
		$gdata ='';
		while (list($key, $value) = each($_GET))
		{
	   	$gdata .= addslashes($key)." => ".addslashes($value)."\\r\\n";
		} 
	
		tep_db_query("INSERT INTO cao_log
	              (date,user,pw,method,action,post_data,get_data) VALUES
	              (NOW(),'".$user."','".$password."','".$REQUEST_METHOD."','".$_POST['action']."','".$pdata."','".$gdata."')");
	}
	
	
	
	
	
//---------------------------------------------------------------------
// Definition der Class UPLOAD, wenn diese nicht existiert (osc MS 1.1)
//---------------------------------------------------------------------

if (!class_exists(upload)) {  
  class upload {
    var $file, $filename, $destination, $permissions, $extensions, $tmp_filename, $message_location;

    function upload($file = '', $destination = '', $permissions = '777', $extensions = '') {
      $this->set_file($file);
      $this->set_destination($destination);
      $this->set_permissions($permissions);
      $this->set_extensions($extensions);

      $this->set_output_messages('direct');

      if (tep_not_null($this->file) && tep_not_null($this->destination)) {
        $this->set_output_messages('session');

        if ( ($this->parse() == true) && ($this->save() == true) ) {
          return true;
        } else {
// self destruct
          //$this = null;
			 unset($this); //Bugfix by Pagemaster B
			 
          return false;
        }
      }
    }

    function parse() {
      global $messageStack;

      if (isset($_FILES[$this->file])) {
        $file = array('name' => $_FILES[$this->file]['name'],
                      'type' => $_FILES[$this->file]['type'],
                      'size' => $_FILES[$this->file]['size'],
                      'tmp_name' => $_FILES[$this->file]['tmp_name']);
      } elseif (isset($GLOBALS['HTTP_POST_FILES'][$this->file])) {
        global $HTTP_POST_FILES;

        $file = array('name' => $HTTP_POST_FILES[$this->file]['name'],
                      'type' => $HTTP_POST_FILES[$this->file]['type'],
                      'size' => $HTTP_POST_FILES[$this->file]['size'],
                      'tmp_name' => $HTTP_POST_FILES[$this->file]['tmp_name']);
      } else {
        $file = array('name' => (isset($GLOBALS[$this->file . '_name']) ? $GLOBALS[$this->file . '_name'] : ''),
                      'type' => (isset($GLOBALS[$this->file . '_type']) ? $GLOBALS[$this->file . '_type'] : ''),
                      'size' => (isset($GLOBALS[$this->file . '_size']) ? $GLOBALS[$this->file . '_size'] : ''),
                      'tmp_name' => (isset($GLOBALS[$this->file]) ? $GLOBALS[$this->file] : ''));
      }

      if ( tep_not_null($file['tmp_name']) && ($file['tmp_name'] != 'none') && is_uploaded_file($file['tmp_name']) ) {
        if (sizeof($this->extensions) > 0) {
          if (!in_array(strtolower(substr($file['name'], strrpos($file['name'], '.')+1)), $this->extensions)) {
            if ($this->message_location == 'direct') {
              $messageStack->add(ERROR_FILETYPE_NOT_ALLOWED, 'error');
            } else {
              $messageStack->add_session(ERROR_FILETYPE_NOT_ALLOWED, 'error');
            }

            return false;
          }
        }

        $this->set_file($file);
        $this->set_filename($file['name']);
        $this->set_tmp_filename($file['tmp_name']);

        return $this->check_destination();
      } else {
        if ($this->message_location == 'direct') {
          $messageStack->add(WARNING_NO_FILE_UPLOADED, 'warning');
        } else {
          $messageStack->add_session(WARNING_NO_FILE_UPLOADED, 'warning');
        }

        return false;
      }
    }

    function save() {
      global $messageStack;

      if (substr($this->destination, -1) != '/') $this->destination .= '/';

      if (move_uploaded_file($this->file['tmp_name'], $this->destination . $this->filename)) {
        chmod($this->destination . $this->filename, $this->permissions);

        if ($this->message_location == 'direct') {
          $messageStack->add(SUCCESS_FILE_SAVED_SUCCESSFULLY, 'success');
        } else {
          $messageStack->add_session(SUCCESS_FILE_SAVED_SUCCESSFULLY, 'success');
        }

        return true;
      } else {
        if ($this->message_location == 'direct') {
          $messageStack->add(ERROR_FILE_NOT_SAVED, 'error');
        } else {
          $messageStack->add_session(ERROR_FILE_NOT_SAVED, 'error');
        }

        return false;
      }
    }

    function set_file($file) {
      $this->file = $file;
    }

    function set_destination($destination) {
      $this->destination = $destination;
    }

    function set_permissions($permissions) {
      $this->permissions = octdec($permissions);
    }

    function set_filename($filename) {
      $this->filename = $filename;
    }

    function set_tmp_filename($filename) {
      $this->tmp_filename = $filename;
    }

    function set_extensions($extensions) {
      if (tep_not_null($extensions)) {
        if (is_array($extensions)) {
          $this->extensions = $extensions;
        } else {
          $this->extensions = array($extensions);
        }
      } else {
        $this->extensions = array();
      }
    }

    function check_destination() {
      global $messageStack;

      if (!is_writeable($this->destination)) {
        if (is_dir($this->destination)) {
          if ($this->message_location == 'direct') {
            $messageStack->add(sprintf(ERROR_DESTINATION_NOT_WRITEABLE, $this->destination), 'error');
          } else {
            $messageStack->add_session(sprintf(ERROR_DESTINATION_NOT_WRITEABLE, $this->destination), 'error');
          }
        } else {
          if ($this->message_location == 'direct') {
            $messageStack->add(sprintf(ERROR_DESTINATION_DOES_NOT_EXIST, $this->destination), 'error');
          } else {
            $messageStack->add_session(sprintf(ERROR_DESTINATION_DOES_NOT_EXIST, $this->destination), 'error');
          }
        }

        return false;
      } else {
        return true;
      }
    }

    function set_output_messages($location) {
      switch ($location) {
        case 'session':
          $this->message_location = 'session';
          break;
        case 'direct':
        default:
          $this->message_location = 'direct';
          break;
      }
    }
  }
}  
	
//---------------------------------------------------------------------
// Ende Class UPLOAD
//---------------------------------------------------------------------
	
	
?>