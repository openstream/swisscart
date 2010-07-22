<?php
/*
  PostFinance Mobile module by mobile solutions ag
  http://www.postfinance.ch/mobile
  http://www.mobilesolutions.ch/

  Version 1.0

  Copyright (c) 2010 mobile solutions ag
*/
class mobilesolutions {
  var $title, $description, $enabled, $log;
  var $code = 'mobilesolutions';
  var $form_action_url = 'https://postfinance.mobilesolutions.ch/webshop/handyzahlung';
  
  var $currency = array (
                      'CHF' => array (
                          'tag' => 'MODULE_PAYMENT_MOBILESOLUTIONS_ACCEPT_CHF', 
                          'name' => 'CHF' 
                      )
                      /*
                       * EUR Not supported atm
                      'EUR' => array(
                          'tag' => 'MODULE_PAYMENT_MOBILESOLUTIONS_ACCEPT_EUR',
                          'name' => 'Euro'
                      )
                      */
                      );
                      
  var $translate;
  
  /**
   * Constructor
   * @return mobilesolutions
   */
  function mobilesolutions() {
    global $order, $request_type;
    
    // Admin Language Switch
    switch ($_SESSION ['languages_id']) {
      case 2 : // German
        $this->translate = array(
          'PREPARATION_STATUS_TITLE' => 'Preparing Order Status',
          'PREPARATION_STATUS_DESC' => 'Der Status für noch nicht bezahlte PostFinance Mobile Bestellungen',
          'ORDER_STATUS_TITLE' => 'Default Order Status',
          'ORDER_STATUS_DESC' => 'Der Standard Status für bezahlte PostFinance Mobile Bestellungen',
       	  'STATUS_TITLE' => 'mobile solutions handyzahlung aktivieren',
          'STATUS_DESC' => 'M&ouml;chten Sie Zahlungen per mobile solutions Handyzahlung akzeptieren?',
          'TESTMODE_TITLE' => 'Testsystem',
          'TESTMODE_DESC' => 'M&ouml;chten Sie die Zahlungen über das Testsystem simulieren?',
          'DEBUG_EMAIL_TITLE' => 'Debug Email',
          'DEBUG_EMAIL_DESC' => 'M&ouml;chten Sie debug e-mails an den shopbesitzer senden?',
          'SORT_ORDER_TITLE' => 'Anzeigereihenfolge',
          'SORT_ORDER_DESC' => 'Reihenfolge der Anzeige in der Liste der Zahlungsarten (kleinste Zahl zuerst).',
          'WEBUSER_TITLE' => 'Webuser Name',
          'WEBUSER_DESC' => 'Der von mobile solutions ag vergebene "webuser" name.',
          'SIGNKEY_TITLE' => 'Signkey',
          'SIGNKEY_DESC' => 'Der von mobile solutions ag vergebene schlüssel zum signieren.',
          'ZONE_TITLE' => 'Zahlungszone',
          'ZONE_DESC' => 'Wenn eine Zone selektiert ist, kann die Zahlungsart nur in dieser Zone benutzt werden.',    
          'DEFAULT_CURRENCY_TITLE' => 'Standardwährung',
          'DEFAULT_CURRENCY_DESC' => 'Standardwährung.',
          // use sprintf format syntax
          'ACCEPT_CURRENCY' => 'Möchten Sie %s akzeptieren',
        );
        
        break;
      case 1 : // English
      default:  
        $this->translate = array(
          'PREPARATION_STATUS_TITLE' => 'Preparing Order Status',
          'PREPARATION_STATUS_DESC' => 'The state for not yet payed PostFinance Mobile Orders.',
          'ORDER_STATUS_TITLE' => 'Default Order State',
          'ORDER_STATUS_DESC' => 'Set the state of orders made with this payment module to this value.',
       	  'STATUS_TITLE' => 'activate mobile solutions handypayment',
          'STATUS_DESC' => 'Do you want to accept mobilepayment (by mobile solutions ag) ?',
          'TESTMODE_TITLE' => 'Testsystem',
          'TESTMODE_DESC' => 'Do you want to simulate payment using the testsystem?',
          'DEBUG_EMAIL_TITLE' => 'Debug Email',
          'DEBUG_EMAIL_DESC' => 'Do you want to send debug e-mails to the shop owner?',
          'SORT_ORDER_TITLE' => 'Sort order of display.',
          'SORT_ORDER_DESC' => 'Sort order of display. Lowest is displayed first.',
          'WEBUSER_TITLE' => 'Webuser Name',
          'WEBUSER_DESC' => 'the webuser name given by mobile solutions ag.',
          'SIGNKEY_TITLE' => 'Signkey',
          'SIGNKEY_DESC' => 'the signkey given by mobile solutions ag.',
          'ZONE_TITLE' => 'Payment Zone',
          'ZONE_DESC' => 'If a zone is selected, only enable this payment method for that zone.',  
          'DEFAULT_CURRENCY_TITLE' => 'Default currency',
          'DEFAULT_CURRENCY_DESC' => 'Default currency.',
          // use sprintf format syntax
          'ACCEPT_CURRENCY' => 'Do you want to accept %s',
		    );
        break;
    }
    define ( 'MODULE_PAYMENT_MOBILESOLUTIONS_PREPARATION_STATUS_DEFAULTNAME', 'Preparing [PostFinance Mobile]' );

    $this->title = MODULE_PAYMENT_MOBILESOLUTIONS_TEXT_TITLE;
    $this->description = MODULE_PAYMENT_MOBILESOLUTIONS_TEXT_DESCRIPTION;
    $this->sort_order = MODULE_PAYMENT_MOBILESOLUTIONS_SORT_ORDER;
    $this->enabled = ((MODULE_PAYMENT_MOBILESOLUTIONS_STATUS == 'True') ? true : false);
    
    // Switch the Form Action URL
    if (MODULE_PAYMENT_MOBILESOLUTIONS_TESTMODE == "True") {
      if ($request_type == 'SSL') {
        $this->form_action_url = "https://postfinance.mobilesolutions.ch/shoptest/handyzahlung";
      } else {
        $this->form_action_url = "http://api.smsserv.ch/shoptest/handyzahlung";
      }
    } else {
      if ($request_type == 'SSL') {
        $this->form_action_url = "https://postfinance.mobilesolutions.ch/webshop/handyzahlung";
      } else {
        $this->form_action_url = "http://api.smsserv.ch/webshop/handyzahlung";
      }
    }    
    
    if ((int)MODULE_PAYMENT_MOBILESOLUTIONS_PREPARE_ORDER_STATUS_ID > 0) {
      $this->order_status = MODULE_PAYMENT_MOBILESOLUTIONS_PREPARE_ORDER_STATUS_ID;
    }
   
    if (is_object ( $order )) {
      $this->update_status ();
    }
  }
  
  function update_status() {
    global $order;
    if (($this->enabled == true) && (( int ) MODULE_PAYMENT_MOBILESOLUTIONS_ZONE > 0)) {
      $check_flag = false;
      $check_query = tep_db_query ( "select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_PAYMENT_MOBILESOLUTIONS_ZONE . "' and zone_country_id = '" . $order->billing ['country'] ['id'] . "' order by zone_id" );
      while ( $check = tep_db_fetch_array ( $check_query ) ) {
        if ($check ['zone_id'] < 1) {
          $check_flag = true;
          break;
        } elseif ($check ['zone_id'] == $order->billing ['zone_id']) {
          $check_flag = true;
          break;
        }
      }
      if ($check_flag == false) {
        $this->enabled = false;
      }
    }
  }
  
  /**
   * client Side javascript to verify input fields on payment Selection Page.
   * the String returned will be posted inside the javascript function check_form()
   * on the payment Selection Page.
   * @return unknown
   */
  function javascript_validation() {
    return false;
  }
  
  /**
   * Check if the Order has been stored to the database,
   * and delete it, if there is no Order Status History.
   * @return array containing data for the List of Payment Options.
   */
  function selection() {
    global $cart_PostFinance_ID;

    if (tep_session_is_registered('cart_PostFinance_ID')) {
      $order_id = substr($cart_PostFinance_ID, strpos($cart_PostFinance_ID, '-')+1);
      $check_query = tep_db_query('select orders_id from ' . TABLE_ORDERS_STATUS_HISTORY . ' where orders_id = "' . (int)$order_id . '" limit 1');

      if (tep_db_num_rows($check_query) < 1) {
        tep_db_query('delete from ' . TABLE_ORDERS . ' where orders_id = "' . (int)$order_id . '"');
        tep_db_query('delete from ' . TABLE_ORDERS_TOTAL . ' where orders_id = "' . (int)$order_id . '"');
        tep_db_query('delete from ' . TABLE_ORDERS_STATUS_HISTORY . ' where orders_id = "' . (int)$order_id . '"');
        tep_db_query('delete from ' . TABLE_ORDERS_PRODUCTS . ' where orders_id = "' . (int)$order_id . '"');
        tep_db_query('delete from ' . TABLE_ORDERS_PRODUCTS_ATTRIBUTES . ' where orders_id = "' . (int)$order_id . '"');
        tep_db_query('delete from ' . TABLE_ORDERS_PRODUCTS_DOWNLOAD . ' where orders_id = "' . (int)$order_id . '"');

        tep_session_unregister('cart_PostFinance_ID');
      }
    }

    return array('id'		=> $this->code,
                 'module' => $this->title);
  }
  
  /**
   * Make sure the cart ID is generated.
   */
  function pre_confirmation_check() {
    global $cartID, $cart;
    
    if (empty($cart->cartID)) {
      $cartID = $cart->cartID = $cart->generate_cart_id();
    }
    
    if (!tep_session_is_registered('cartID')) {
      tep_session_register('cartID');
    }
  }
  
  /**
   * Check if the Order was stored in the Database.
   * If the Cart has changed, delete the Order entry,
   * and add the current Order to the Database.
   */
  function confirmation() {
    global $cartID, $cart_PostFinance_ID, $customer_id, $languages_id, $order, $order_total_modules;
    
    if (tep_session_is_registered('cartID')) {
      $insert_order	= false;
      
      // is there an combined cart-order id 
      if (tep_session_is_registered('cart_PostFinance_ID')) {
        $order_id		= substr($cart_PostFinance_ID, strpos($cart_PostFinance_ID, '-')+1);
        $curr_check	= tep_db_query("select currency from " . TABLE_ORDERS . " where orders_id = '" . (int)$order_id . "'");
        $curr			= tep_db_fetch_array($curr_check);

        // if Currency has changed, or Cart was modified...
        if ( ($curr['currency'] != $order->info['currency']) || ($cartID != substr($cart_PostFinance_ID, 0, strlen($cartID))) ) {
          $check_query = tep_db_query('select orders_id from ' . TABLE_ORDERS_STATUS_HISTORY . ' where orders_id = "' . (int)$order_id . '" limit 1');

          // If there is no Order Status History, delete the existing Order
          if (tep_db_num_rows($check_query) < 1) {
            tep_db_query('delete from ' . TABLE_ORDERS . ' where orders_id = "' . (int)$order_id . '"');
            tep_db_query('delete from ' . TABLE_ORDERS_TOTAL . ' where orders_id = "' . (int)$order_id . '"');
            tep_db_query('delete from ' . TABLE_ORDERS_STATUS_HISTORY . ' where orders_id = "' . (int)$order_id . '"');
            tep_db_query('delete from ' . TABLE_ORDERS_PRODUCTS . ' where orders_id = "' . (int)$order_id . '"');
            tep_db_query('delete from ' . TABLE_ORDERS_PRODUCTS_ATTRIBUTES . ' where orders_id = "' . (int)$order_id . '"');
            tep_db_query('delete from ' . TABLE_ORDERS_PRODUCTS_DOWNLOAD . ' where orders_id = "' . (int)$order_id . '"');
          }
          $insert_order = true;
        }
      } else {
        $insert_order = true;
      }

      if ($insert_order == true) {
        $order_totals = array();
        if (is_array($order_total_modules->modules)) {
          reset($order_total_modules->modules);
          while (list(, $value) = each($order_total_modules->modules)) {
            $class	= substr($value, 0, strrpos($value, '.'));
            if ($GLOBALS[$class]->enabled) {
              for ($i=0, $n=sizeof($GLOBALS[$class]->output); $i<$n; $i++) {
                if (tep_not_null($GLOBALS[$class]->output[$i]['title']) && tep_not_null($GLOBALS[$class]->output[$i]['text'])) {
                  $order_totals[] = array('code'				=> $GLOBALS[$class]->code,
                                          'title'				=> $GLOBALS[$class]->output[$i]['title'],
                                          'text'				=> $GLOBALS[$class]->output[$i]['text'],
                                          'value'				=> $GLOBALS[$class]->output[$i]['value'],
                                          'sort_order'		=> $GLOBALS[$class]->sort_order);
                }
              }
            }
          }
        }

        $sql_data_array = array('customers_id'				=> $customer_id,
                                'customers_name'				=> $order->customer['firstname'] . ' ' . $order->customer['lastname'],
                                'customers_company'			=> $order->customer['company'],
                                'customers_street_address'	=> $order->customer['street_address'],
                                'customers_suburb'			=> $order->customer['suburb'],
                                'customers_city'				=> $order->customer['city'],
                                'customers_postcode'			=> $order->customer['postcode'],
                                'customers_state'				=> $order->customer['state'],
                                'customers_country'			=> $order->customer['country']['title'],
                                'customers_telephone'			=> $order->customer['telephone'],
                                'customers_email_address'		=> $order->customer['email_address'],
                                'customers_address_format_id' => $order->customer['format_id'],
                                'delivery_name'				=> $order->delivery['firstname'] . ' ' . $order->delivery['lastname'],
                                'delivery_company'			=> $order->delivery['company'],
                                'delivery_street_address'		=> $order->delivery['street_address'],
                                'delivery_suburb'				=> $order->delivery['suburb'],
                                'delivery_city'				=> $order->delivery['city'],
                                'delivery_postcode'			=> $order->delivery['postcode'],
                                'delivery_state'				=> $order->delivery['state'],
                                'delivery_country'			=> $order->delivery['country']['title'],
                                'delivery_address_format_id'	=> $order->delivery['format_id'],
                                'billing_name'				=> $order->billing['firstname'] . ' ' . $order->billing['lastname'],
                                'billing_company'				=> $order->billing['company'],
                                'billing_street_address'		=> $order->billing['street_address'],
                                'billing_suburb'				=> $order->billing['suburb'],
                                'billing_city'				=> $order->billing['city'],
                                'billing_postcode'			=> $order->billing['postcode'],
                                'billing_state'				=> $order->billing['state'],
                                'billing_country'				=> $order->billing['country']['title'],
                                'billing_address_format_id'	=> $order->billing['format_id'],
                                'payment_method'				=> $order->info['payment_method'],
                                'cc_type'						=> $order->info['cc_type'],
                                'cc_owner'					=> $order->info['cc_owner'],
                                'cc_number'					=> $order->info['cc_number'],
                                'cc_expires'					=> $order->info['cc_expires'],
                                'date_purchased'				=> 'now()',
                                'orders_status'				=> $order->info['order_status'],
                                'currency'					=> $order->info['currency'],
                                'currency_value'				=> $order->info['currency_value']);

        tep_db_perform(TABLE_ORDERS, $sql_data_array);
        
        $insert_id = tep_db_insert_id();
        
        for ($i=0, $n=sizeof($order_totals); $i<$n; $i++) {
          $sql_data_array = array('orders_id'					=> $insert_id,
                                  'title'						=> $order_totals[$i]['title'],
                                  'text'						=> $order_totals[$i]['text'],
                                  'value'						=> $order_totals[$i]['value'],
                                  'class'						=> $order_totals[$i]['code'],
                                  'sort_order'				=> $order_totals[$i]['sort_order']);

          tep_db_perform(TABLE_ORDERS_TOTAL, $sql_data_array);
        }

        for ($i=0, $n=sizeof($order->products); $i<$n; $i++) {
          $sql_data_array = array('orders_id'					=> $insert_id,
                                  'products_id'				=> tep_get_prid($order->products[$i]['id']),
                                  'products_model'			=> $order->products[$i]['model'],
                                  'products_name'				=> $order->products[$i]['name'],
                                  'products_price'			=> $order->products[$i]['price'],
                                  'final_price'				=> $order->products[$i]['final_price'],
                                  'products_tax'				=> $order->products[$i]['tax'],
                                  'products_quantity'			=> $order->products[$i]['qty']);

          tep_db_perform(TABLE_ORDERS_PRODUCTS, $sql_data_array);

          $order_products_id = tep_db_insert_id();

          $attributes_exist = '0';
          if (isset($order->products[$i]['attributes'])) {
            $attributes_exist = '1';
            for ($j=0, $n2=sizeof($order->products[$i]['attributes']); $j<$n2; $j++) {
              if (DOWNLOAD_ENABLED == 'true') {
                $attributes_query = "select popt.products_options_name, poval.products_options_values_name, pa.options_values_price, pa.price_prefix, pad.products_attributes_maxdays, pad.products_attributes_maxcount , pad.products_attributes_filename
                                     from " . TABLE_PRODUCTS_OPTIONS . " popt, " . TABLE_PRODUCTS_OPTIONS_VALUES . " poval, " . TABLE_PRODUCTS_ATTRIBUTES . " pa
                                     left join " . TABLE_PRODUCTS_ATTRIBUTES_DOWNLOAD . " pad
                                     on pa.products_attributes_id=pad.products_attributes_id
                                     where pa.products_id = '" . $order->products[$i]['id'] . "'
                                     and pa.options_id = '" . $order->products[$i]['attributes'][$j]['option_id'] . "'
                                     and pa.options_id = popt.products_options_id
                                     and pa.options_values_id = '" . $order->products[$i]['attributes'][$j]['value_id'] . "'
                                     and pa.options_values_id = poval.products_options_values_id
                                     and popt.language_id = '" . $languages_id . "'
                                     and poval.language_id = '" . $languages_id . "'";
                $attributes = tep_db_query($attributes_query);
              } else {
                $attributes = tep_db_query("select popt.products_options_name, poval.products_options_values_name, pa.options_values_price, pa.price_prefix from " . TABLE_PRODUCTS_OPTIONS . " popt, " . TABLE_PRODUCTS_OPTIONS_VALUES . " poval, " . TABLE_PRODUCTS_ATTRIBUTES . " pa where pa.products_id = '" . $order->products[$i]['id'] . "' and pa.options_id = '" . $order->products[$i]['attributes'][$j]['option_id'] . "' and pa.options_id = popt.products_options_id and pa.options_values_id = '" . $order->products[$i]['attributes'][$j]['value_id'] . "' and pa.options_values_id = poval.products_options_values_id and popt.language_id = '" . $languages_id . "' and poval.language_id = '" . $languages_id . "'");
              }
              $attributes_values = tep_db_fetch_array($attributes);

              $sql_data_array = array('orders_id' => $insert_id,
                                      'orders_products_id' => $order_products_id,
                                      'products_options' => $attributes_values['products_options_name'],
                                      'products_options_values' => $attributes_values['products_options_values_name'],
                                      'options_values_price' => $attributes_values['options_values_price'],
                                      'price_prefix' => $attributes_values['price_prefix']);

              tep_db_perform(TABLE_ORDERS_PRODUCTS_ATTRIBUTES, $sql_data_array);

              if ((DOWNLOAD_ENABLED == 'true') && isset($attributes_values['products_attributes_filename']) && tep_not_null($attributes_values['products_attributes_filename'])) {
                $sql_data_array = array('orders_id' => $insert_id,
                                        'orders_products_id' => $order_products_id,
                                        'orders_products_filename' => $attributes_values['products_attributes_filename'],
                                        'download_maxdays' => $attributes_values['products_attributes_maxdays'],
                                        'download_count' => $attributes_values['products_attributes_maxcount']);

                tep_db_perform(TABLE_ORDERS_PRODUCTS_DOWNLOAD, $sql_data_array);
              }
            }
          }
        }

        $cart_PostFinance_ID = $cartID . '-' . $insert_id;
        tep_session_register('cart_PostFinance_ID');
        tep_session_register('order_id');
      }
    }
  }
  
  /**
   * Creates the Process Button Code, including the Hidden Fields.
   */
  function process_button() {
    global $_POST, $customer_id, $currencies, $order, $language, $cart_PostFinance_ID;
    switch ($language) {
      case 'german' :
        $usedlanguage = 'de';
        break;
      case 'italian' :
        $usedlanguage = 'it';
        break;
      case 'french' :
        $usedlanguage = 'fr';
        break;
      case 'english' :
      default :
        $usedlanguage = 'en';
    }
    
    $usedcurrency = MODULE_PAYMENT_MOBILESOLUTIONS_CURRENCY_STANDARD;
    if (isset ( $this->currency [$_SESSION ['currency']] )) {
      $usedcurrency = $_SESSION ['currency'];
    }
    
    $amount = round ( $order->info['total'], $currencies->currencies [$usedcurrency] ['decimal_places'] );
    
    $orderid = substr($cart_PostFinance_ID, strpos($cart_PostFinance_ID, '-')+1);
    
    // Urls
    $amount = round ( $amount * 100, 0 );
    $process_button_string = tep_draw_hidden_field ( 'urlsuccess', tep_href_link ( FILENAME_CHECKOUT_PROCESS ) );
    $process_button_string .= tep_draw_hidden_field ( 'urlerror', tep_href_link ( FILENAME_CHECKOUT_PAYMENT, '', 'SSL', true ) );
    
    $process_button_string .= tep_draw_hidden_field ( 'amount', $amount );
    $process_button_string .= tep_draw_hidden_field ( 'currency', $usedcurrency );
    $process_button_string .= tep_draw_hidden_field ( 'orderid', $orderid );
    
    // language
    $process_button_string .= tep_draw_hidden_field ( 'lang', $usedlanguage );
    
    // webuser name
    $process_button_string .= tep_draw_hidden_field ( 'webuser', MODULE_PAYMENT_MOBILESOLUTIONS_WEBUSER );
    
    // Testmode ?
    if (MODULE_PAYMENT_MOBILESOLUTIONS_TESTMODE === 'True') {
      $process_button_string .= tep_draw_hidden_field ( 'ijustwanttotest', 'True' );
    }
    
    // Create Signature (amount+currency+orderid+webuser)
    $datastring = $amount . $usedcurrency . $orderid . MODULE_PAYMENT_MOBILESOLUTIONS_WEBUSER;
    $sign = $this->hmac_sha ( pack ( "H*", MODULE_PAYMENT_MOBILESOLUTIONS_SIGNKEY ), $datastring );
    $process_button_string .= tep_draw_hidden_field ( 'sign', $sign );
    
    // Session Information
    $encoded_ses_id = urlencode(tep_session_name()."=".tep_session_id());
    $process_button_string .= tep_draw_hidden_field('customparam',$encoded_ses_id);
    
    
    return $process_button_string;
  }
  
  /**
   * Validation of Returned Data.
   * @return unknown
   */
  function before_process() {
    global $customer_id, $order, $order_totals, $sendto, $billto, $languages_id, $payment, $currencies, $cart;
    global $$payment;
    
    // check the Signature 
    // state+amount+currency+orderid+mosoauth+postref
    $msg = $_REQUEST['state'];
    $msg .= $_REQUEST['amount'];
    $msg .= $_REQUEST['currency'];
    $msg .= $_REQUEST['orderid'];
    $msg .= $_REQUEST['mosoauth'];
    $msg .= $_REQUEST['postref'];
    
    $check = $this->hmac_sha ( pack ( "H*", MODULE_PAYMENT_MOBILESOLUTIONS_SIGNKEY ), $msg );
    
    // If not the Same, redirect to Payment Method selection !!
    if ($check != $_REQUEST['sign']) {
      tep_redirect ( tep_href_link ( FILENAME_CHECKOUT_PAYMENT, 'error_message=' . urlencode ( MODULE_PAYMENT_MOBILESOLUTIONS_ERROR_PAYMENT_FAILED ), 'SSL' ) );
    }
    
    $order_id = $_REQUEST['orderid'];
    $order_status = $_REQUEST['state'];
    
    $order_query = tep_db_query("select orders_status from " . TABLE_ORDERS . " where orders_id = '" . (int)$order_id  . "'");
    if (tep_db_num_rows($order_query) > 0) {
      $db_array = tep_db_fetch_array($order_query);
      $db_order_status = $db_array['orders_status'];

      // Change the State only, if current State is Preparation
      if ($db_order_status == MODULE_PAYMENT_MOBILESOLUTIONS_PREPARE_ORDER_STATUS_ID ) {
        
        if ($order_status == 'error') {
          if (tep_not_null(MODULE_PAYMENT_MOBILESOLUTIONS_DEBUG_EMAIL)) {
            $email_body = '$_POST:' . "\n\n";
          
            reset($_POST);
            while (list($key, $value) = each($_POST)) {
          	  $email_body .= $key . '=' . $value . "\n";
            }
          
            $email_body .= "\n" . '$_GET:' . "\n\n";
          
            reset($_GET);
            while (list($key, $value) = each($_GET)) {
          	  $email_body .= $key . '=' . $value . "\n";
            }
          
            tep_mail('', MODULE_PAYMENT_MOBILESOLUTIONS_DEBUG_EMAIL, 'Post Finance Mobile (mobile solutions ag) Invalid Process', $email_body, STORE_OWNER, STORE_OWNER_EMAIL_ADDRESS);
          }
          tep_db_query('delete from ' . TABLE_ORDERS . ' where orders_id = "' . $order_id . '"');
          tep_redirect(tep_href_link(FILENAME_CHECKOUT_PAYMENT));
          
        } else if ($order_status == 'success') {
          $new_status_id = MODULE_PAYMENT_MOBILESOLUTIONS_ORDER_STATUS_ID > 0 ? (int)MODULE_PAYMENT_MOBILESOLUTIONS_ORDER_STATUS_ID : (int)DEFAULT_ORDERS_STATUS_ID;
          
          // Set the Default Order State (after Preparation)
          tep_db_query("update " . TABLE_ORDERS . " set orders_status = '" . (int)$new_status_id . "', last_modified = now() where orders_id = '" . (int)$order_id . "'");
          
          // Add en State History Entry
          $sql_data_array = array('orders_id' => $order_id,
                                  'orders_status_id' => $new_status_id,
                                  'date_added' => 'now()',
                                  'customer_notified' => (SEND_EMAILS == 'true') ? '1' : '0',
                                  'comments' => 'PostFinance Mobile ('. $_GET['mosoauth'] .')');
    
          tep_db_perform(TABLE_ORDERS_STATUS_HISTORY, $sql_data_array);
          
          // initialized for the email confirmation
          $products_ordered = '';
          $subtotal = 0;
          $total_tax = 0;
    
          for ($i=0, $n=sizeof($order->products); $i<$n; $i++) {
            // Stock Update - Joao Correia
            if (STOCK_LIMITED == 'true') {
              if (DOWNLOAD_ENABLED == 'true') {
                $stock_query_raw = "SELECT products_quantity, pad.products_attributes_filename
                                    FROM " . TABLE_PRODUCTS . " p
                                    LEFT JOIN " . TABLE_PRODUCTS_ATTRIBUTES . " pa
                                    ON p.products_id=pa.products_id
                                    LEFT JOIN " . TABLE_PRODUCTS_ATTRIBUTES_DOWNLOAD . " pad
                                    ON pa.products_attributes_id=pad.products_attributes_id
                                    WHERE p.products_id = '" . tep_get_prid($order->products[$i]['id']) . "'";
                // Will work with only one option for downloadable products
                // otherwise, we have to build the query dynamically with a loop
                $products_attributes = $order->products[$i]['attributes'];
                if (is_array($products_attributes)) {
                  $stock_query_raw .= " AND pa.options_id = '" . $products_attributes[0]['option_id'] . "' AND pa.options_values_id = '" . $products_attributes[0]['value_id'] . "'";
                }
                $stock_query = tep_db_query($stock_query_raw);
              } else {
                $stock_query = tep_db_query("select products_quantity from " . TABLE_PRODUCTS . " where products_id = '" . tep_get_prid($order->products[$i]['id']) . "'");
              }
              if (tep_db_num_rows($stock_query) > 0) {
                $stock_values = tep_db_fetch_array($stock_query);
                // do not decrement quantities if products_attributes_filename exists
                if ((DOWNLOAD_ENABLED != 'true') || (!$stock_values['products_attributes_filename'])) {
                  $stock_left = $stock_values['products_quantity'] - $order->products[$i]['qty'];
                } else {
                  $stock_left = $stock_values['products_quantity'];
                }
                tep_db_query("update " . TABLE_PRODUCTS . " set products_quantity = '" . $stock_left . "' where products_id = '" . tep_get_prid($order->products[$i]['id']) . "'");
                if ( ($stock_left < 1) && (STOCK_ALLOW_CHECKOUT == 'false') ) {
                  tep_db_query("update " . TABLE_PRODUCTS . " set products_status = '0' where products_id = '" . tep_get_prid($order->products[$i]['id']) . "'");
                }
              }
            }
            
            // Update products_ordered (for bestsellers list)
    		tep_db_query("update " . TABLE_PRODUCTS . " set products_ordered = products_ordered + " . sprintf('%d', $order->products[$i]['qty']) . " where products_id = '" . tep_get_prid($order->products[$i]['id']) . "'");
    
    		//------insert customer choosen option to order--------
            $attributes_exist = '0';
            $products_ordered_attributes = '';
            if (isset($order->products[$i]['attributes'])) {
              $attributes_exist = '1';
              for ($j=0, $n2=sizeof($order->products[$i]['attributes']); $j<$n2; $j++) {
                if (DOWNLOAD_ENABLED == 'true') {
                  $attributes_query = "select popt.products_options_name, poval.products_options_values_name, pa.options_values_price, pa.price_prefix, pad.products_attributes_maxdays, pad.products_attributes_maxcount , pad.products_attributes_filename
                                       from " . TABLE_PRODUCTS_OPTIONS . " popt, " . TABLE_PRODUCTS_OPTIONS_VALUES . " poval, " . TABLE_PRODUCTS_ATTRIBUTES . " pa
                                       left join " . TABLE_PRODUCTS_ATTRIBUTES_DOWNLOAD . " pad
                                       on pa.products_attributes_id=pad.products_attributes_id
                                       where pa.products_id = '" . $order->products[$i]['id'] . "'
                                       and pa.options_id = '" . $order->products[$i]['attributes'][$j]['option_id'] . "'
                                       and pa.options_id = popt.products_options_id
                                       and pa.options_values_id = '" . $order->products[$i]['attributes'][$j]['value_id'] . "'
                                       and pa.options_values_id = poval.products_options_values_id
                                       and popt.language_id = '" . $languages_id . "'
                                       and poval.language_id = '" . $languages_id . "'";
                  $attributes = tep_db_query($attributes_query);
                } else {
                  $attributes = tep_db_query("select popt.products_options_name, poval.products_options_values_name, pa.options_values_price, pa.price_prefix from " . TABLE_PRODUCTS_OPTIONS . " popt, " . TABLE_PRODUCTS_OPTIONS_VALUES . " poval, " . TABLE_PRODUCTS_ATTRIBUTES . " pa where pa.products_id = '" . $order->products[$i]['id'] . "' and pa.options_id = '" . $order->products[$i]['attributes'][$j]['option_id'] . "' and pa.options_id = popt.products_options_id and pa.options_values_id = '" . $order->products[$i]['attributes'][$j]['value_id'] . "' and pa.options_values_id = poval.products_options_values_id and popt.language_id = '" . $languages_id . "' and poval.language_id = '" . $languages_id . "'");
                }
                $attributes_values = tep_db_fetch_array($attributes);
    
                $products_ordered_attributes .= "\n\t" . $attributes_values['products_options_name'] . ' ' . $attributes_values['products_options_values_name'];
              }
            }
    		//------insert customer choosen option eof ----
            $total_weight += ($order->products[$i]['qty'] * $order->products[$i]['weight']);
            $total_tax += tep_calculate_tax($total_products_price, $products_tax) * $order->products[$i]['qty'];
            $total_cost += $total_products_price;
    
            $products_ordered .= $order->products[$i]['qty'] . ' x ' . $order->products[$i]['name'] . ' (' . $order->products[$i]['model'] . ') = ' . $currencies->display_price($order->products[$i]['final_price'], $order->products[$i]['tax'], $order->products[$i]['qty']) . $products_ordered_attributes . "\n";
          }
          
          // lets start with the email confirmation
          $email_order = STORE_NAME . "\n" .
                       EMAIL_SEPARATOR . "\n" .
                       EMAIL_TEXT_ORDER_NUMBER . ' ' . $order_id . "\n" .
                       EMAIL_TEXT_INVOICE_URL . ' ' . tep_href_link(FILENAME_ACCOUNT_HISTORY_INFO, 'order_id=' . $order_id, 'SSL', false) . "\n" .
                       EMAIL_TEXT_DATE_ORDERED . ' ' . strftime(DATE_FORMAT_LONG) . "\n\n";
          if ($order->info['comments']) {
            $email_order .= tep_db_output($order->info['comments']) . "\n\n";
          }
          $email_order .= EMAIL_TEXT_PRODUCTS . "\n" .
                          EMAIL_SEPARATOR . "\n" .
                          $products_ordered .
                          EMAIL_SEPARATOR . "\n";
    
          for ($i=0, $n=sizeof($order_totals); $i<$n; $i++) {
            $email_order .= strip_tags($order_totals[$i]['title']) . ' ' . strip_tags($order_totals[$i]['text']) . "\n";
          }
    
          if ($order->content_type != 'virtual') {
            $email_order .= "\n" . EMAIL_TEXT_DELIVERY_ADDRESS . "\n" .
                            EMAIL_SEPARATOR . "\n" .
                            tep_address_label($customer_id, $sendto, 0, '', "\n") . "\n";
          }
    
          $email_order .= "\n" . EMAIL_TEXT_BILLING_ADDRESS . "\n" .
                          EMAIL_SEPARATOR . "\n" .
                          tep_address_label($customer_id, $billto, 0, '', "\n") . "\n\n";
          if (is_object($$payment)) {
            $email_order .= EMAIL_TEXT_PAYMENT_METHOD . "\n" .
                            EMAIL_SEPARATOR . "\n";
            $payment_class = $$payment;
            $email_order .= $payment_class->title . "\n\n";
            if ($payment_class->email_footer) {
              $email_order .= $payment_class->email_footer . "\n\n";
            }
    	  }
          
          // send email to customer and (maybe) other people
          tep_mail($order->customer['firstname'] . ' ' . $order->customer['lastname'], $order->customer['email_address'], EMAIL_TEXT_SUBJECT, $email_order, STORE_OWNER, STORE_OWNER_EMAIL_ADDRESS);
          if (SEND_EXTRA_ORDER_EMAILS_TO != '') {
            tep_mail('', SEND_EXTRA_ORDER_EMAILS_TO, EMAIL_TEXT_SUBJECT, $email_order, STORE_OWNER, STORE_OWNER_EMAIL_ADDRESS);
          }
          
          // Reset Cart, if User-Agent does not start with "Java"
          if (strncasecmp($_SERVER['HTTP_USER_AGENT'],"Java",4) == 0) {
            // Remove Database part of Shopping Cart
            tep_db_query("delete from " . TABLE_CUSTOMERS_BASKET . " where customers_id = '" . (int)$customer_id . "'");
            tep_db_query("delete from " . TABLE_CUSTOMERS_BASKET_ATTRIBUTES . " where customers_id = '" . (int)$customer_id . "'");
            
          } else {
            // Real User
            $cart->reset(true);
            
            // unregister session variables used during checkout
            tep_session_unregister('sendto');
            tep_session_unregister('billto');
            tep_session_unregister('shipping');
            tep_session_unregister('payment');
            tep_session_unregister('comments');
          }
          
          tep_redirect(tep_href_link(FILENAME_CHECKOUT_SUCCESS, '', 'SSL'));
        }
        
      } else if($db_order_status == MODULE_PAYMENT_MOBILESOLUTIONS_ORDER_STATUS_ID ||
                $db_order_status == DEFAULT_ORDERS_STATUS_ID) {
                  
        // HTTP Post call was faster than the User, just unregister the cart and redirect User 
        $cart->reset(true);

        // unregister session variables used during checkout
        tep_session_unregister('sendto');
        tep_session_unregister('billto');
        tep_session_unregister('shipping');
        tep_session_unregister('payment');
        tep_session_unregister('comments');
        
        tep_redirect(tep_href_link(FILENAME_CHECKOUT_SUCCESS, '', 'SSL'));
      }
    }
    tep_redirect(tep_href_link(FILENAME_CHECKOUT_PAYMENT, '', 'SSL'));
  }
  
  function after_process() {
    return false;
  }
  
  function get_error() {
    $error = array ('title' => 'Error', 'error' => $_POST ['errorDetail'] );
    return $error;
  }
  
  function check() {
    if (! isset ( $this->_check )) {
      $check_query = tep_db_query ( "select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_PAYMENT_MOBILESOLUTIONS_STATUS'" );
      $this->_check = tep_db_num_rows ( $check_query );
    }
    return $this->_check;
  }
  
  /**
   * Install Config Values for Admin Backend.
   */
  function install() {
    
    // We need a "preparation" status
    $check_query = tep_db_query ( "select orders_status_id from " . TABLE_ORDERS_STATUS . " where orders_status_name = '" . MODULE_PAYMENT_MOBILESOLUTIONS_PREPARATION_STATUS_DEFAULTNAME . "' limit 1" );
    $existing_order_status = tep_db_fetch_array ( $check_query );

    $status_id = $existing_order_status ['orders_status_id'];
    if (! $existing_order_status) {
      // Add our State havig default Name
      $status_query = tep_db_query ( "select max(orders_status_id) as status_id from " . TABLE_ORDERS_STATUS );
      $status = tep_db_fetch_array ( $status_query );
      
      $status_id = $status ['status_id'] + 1;
      $languages = tep_get_languages ();
      
      foreach ( $languages as $lang ) {
        tep_db_query ( "insert into " . TABLE_ORDERS_STATUS . " (orders_status_id, language_id, orders_status_name) values ('" . $status_id . "', '" . $lang ['id'] . "', '" . MODULE_PAYMENT_MOBILESOLUTIONS_PREPARATION_STATUS_DEFAULTNAME . "')" );
      }
    }

    // Preparation ORDER_STATUS_ID
    tep_db_query ( 
    	"insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_description, configuration_key, configuration_value, configuration_group_id, sort_order, set_function, use_function, date_added) 
    	values ('" . $this->translate['PREPARATION_STATUS_TITLE'] . "', '" . $this->translate['PREPARATION_STATUS_DESC'] . "', 'MODULE_PAYMENT_MOBILESOLUTIONS_PREPARE_ORDER_STATUS_ID', '" . $status_id . "', '6', '0', 'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', now())" 
    );
    
    // Default ORDER_STATUS_ID
    tep_db_query ( 
    	"insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_description, configuration_key, configuration_value, configuration_group_id, sort_order, set_function, use_function, date_added) 
    	values ('" . $this->translate['ORDER_STATUS_TITLE'] . "', '" . $this->translate['ORDER_STATUS_DESC'] . "', 'MODULE_PAYMENT_MOBILESOLUTIONS_ORDER_STATUS_ID', '0', '6', '8', 'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', now())" 
    );

    // Modul Status
    tep_db_query ( 
    	"insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_description, configuration_key, configuration_value, configuration_group_id, sort_order, set_function, date_added) 
    	values ('" . $this->translate['STATUS_TITLE'] . "', '" . $this->translate['STATUS_DESC']  . "', 'MODULE_PAYMENT_MOBILESOLUTIONS_STATUS', 'True', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())" 
    );
    
    // Testmode
    tep_db_query ( 
    	"insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_description, configuration_key, configuration_value, configuration_group_id, sort_order, set_function, date_added) 
    	values ('" . $this->translate['TESTMODE_TITLE']  . "', '" . $this->translate['TESTMODE_DESC'] . "', 'MODULE_PAYMENT_MOBILESOLUTIONS_TESTMODE', 'False', '6', '2', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())" 
    );
    
    // Debug Mails
    tep_db_query ( 
    	"insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_description, configuration_key, configuration_value, configuration_group_id, sort_order, set_function, date_added) 
    	values ('" . $this->translate['DEBUG_EMAIL_TITLE']  . "', '" . $this->translate['DEBUG_EMAIL_DESC'] . "', 'MODULE_PAYMENT_MOBILESOLUTIONS_DEBUG_EMAIL', 'False', '6', '2', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())" 
    );
    
    // Zonen
    tep_db_query ( 
    	"insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_description, configuration_key, configuration_value, configuration_group_id, sort_order, use_function, set_function, date_added) 
    	values ('" . $this->translate['ZONE_TITLE']  . "', '" . $this->translate['ZONE_DESC']  . "', 'MODULE_PAYMENT_MOBILESOLUTIONS_ZONE', '0', '6', '2', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now())" 
    );
    
    // Sortierung
    tep_db_query(
    	"insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_description, configuration_key, configuration_value, configuration_group_id, sort_order, date_added) 
    	values ('". $this->translate['SORT_ORDER_TITLE'] ."', '". $this->translate['SORT_ORDER_DESC'] ."', 'MODULE_PAYMENT_MOBILESOLUTIONS_SORT_ORDER', '0', '6', '7', now())"
    );

    // webuser name
    tep_db_query ( 
    	"insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_description, configuration_key, configuration_value, configuration_group_id, sort_order, date_added) 
    	values ('". $this->translate['WEBUSER_TITLE'] ."', '". $this->translate['WEBUSER_DESC'] ."', 'MODULE_PAYMENT_MOBILESOLUTIONS_WEBUSER', '', '6', '6', now())" 
    );
    
    // signkey used for HMAC-SHA-1 signature
    tep_db_query ( 
    	"insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_description, configuration_key, configuration_value, configuration_group_id, sort_order, date_added) 
    	values ('". $this->translate['SIGNKEY_TITLE'] ."', '". $this->translate['SIGNKEY_DESC'] ."', 'MODULE_PAYMENT_MOBILESOLUTIONS_SIGNKEY', '', '6', '7', now())" 
    );
    
    // All enabled Currencies
    $keyString = '';
    $pre = '';
    foreach ( $this->currency as $key => $value ) {
      $keyString .= $pre . '"' . $key . '"';
      $pre = ', ';
      tep_db_query ( 
      	"insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_description, configuration_key, configuration_value,  configuration_group_id, sort_order, set_function, date_added) 
      	values ('" . $value ['name'] . "', '". sprintf($this->translate['ACCEPT_CURRENCY'], $value ['name']) . " ?', '" . $value ['tag'] . "', 'True', '6', '11', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())" 
      );
    }
    // Default Currency
    tep_db_query ( 
    	"insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_description, configuration_key, configuration_value,  configuration_group_id, sort_order, set_function, date_added) 
    	values ('". $this->translate['DEFAULT_CURRENCY_TITLE'] ."', '". $this->translate['DEFAULT_CURRENCY_DESC'] ."', 'MODULE_PAYMENT_MOBILESOLUTIONS_CURRENCY_STANDARD', 'CHF', '6', '14', 'tep_cfg_select_option(array(" . $keyString . "), ', now())" 
    );
  }
  
  /**
   * The Config Keys used in install routine.
   * @return array
   */
  function keys() {
    $keys = array (
    	'MODULE_PAYMENT_MOBILESOLUTIONS_STATUS', 
    	'MODULE_PAYMENT_MOBILESOLUTIONS_PREPARE_ORDER_STATUS_ID', 
    	'MODULE_PAYMENT_MOBILESOLUTIONS_ORDER_STATUS_ID', 
    	'MODULE_PAYMENT_MOBILESOLUTIONS_ZONE', 
    	'MODULE_PAYMENT_MOBILESOLUTIONS_SORT_ORDER', 
    	'MODULE_PAYMENT_MOBILESOLUTIONS_WEBUSER', 
    	'MODULE_PAYMENT_MOBILESOLUTIONS_SIGNKEY', 
    	'MODULE_PAYMENT_MOBILESOLUTIONS_TESTMODE', 
      'MODULE_PAYMENT_MOBILESOLUTIONS_DEBUG_EMAIL',
    	'MODULE_PAYMENT_MOBILESOLUTIONS_CURRENCY_STANDARD' 
    );
    
    foreach ( $this->currency as $currency => $value ) {
      $keys [] = $value ['tag'];
    }
    return $keys;
  }
  
  /**
   * Uninstall Config Values.
   */
  function remove() {
    tep_db_query ( "delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode ( "', '", $this->keys () ) . "')" );
  }
  
  function hmac_sha($key, $data) {
    // Creates an sha-1 HMAC.
    // Eliminates the need to install mhash to compute a HMAC
    // Hacked by Lance Rushing (original md5 version)
    // Modified by Patrik Wehrli
    

    $b = 64; // byte length for sha-1
    if (strlen ( $key ) > $b) {
      $key = pack ( "H*", sha1 ( $key ) );
    }
    $key = str_pad ( $key, $b, chr ( 0x00 ) );
    $ipad = str_pad ( '', $b, chr ( 0x36 ) );
    $opad = str_pad ( '', $b, chr ( 0x5c ) );
    $k_ipad = $key ^ $ipad;
    $k_opad = $key ^ $opad;
    
    return sha1 ( $k_opad . pack ( "H*", sha1 ( $k_ipad . $data ) ) );
  }
}
?>