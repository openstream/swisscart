<?php
/*
  $Id: clickandbuy.php,v 1.0 2005/10/05
  $Id: clickandbuy.php,v 1.1.1 2005/01/18

  osCommerce payment contribution
  Copyright (c) 2005 by Julius Firl | jfirl@fotocommunity.com | fotocommuntiy.de | v 1.0
  Copyright (c) 2006 by Johannes Teitge | info@tmedia.de | www.oscommerce-admin.de | v 1.1, v 1.1.1


  Released under the GNU General Public License

  Changes on v 1.1
  - added: function install()
  - added: function remove()

  Changes on v 1.1.1
  Compatibility to PHP-Version < 4.3.0 (str_shuffle is not supported on PHP-Version < 4.3.0)
  - added: function _str_shuffle
  - changed str_shuffle to _str_shuffle


*/



function _str_shuffle($str) {
  for ($i = 0; $i <= strlen($str); $i++) {
    $nary[] = substr($str, $i, 1);
  }
  shuffle ($nary);
  $output = '';
  while (list (, $number) = each ($nary)) { $output .= $number; }
  return $output;
}




class clickandbuy {

    var $data;

    function clickandbuy() {
          global $order;


    $this->code = 'clickandbuy';
    $this->href = MODULE_PAYMENT_clickandbuy_ID;
          $this->title = MODULE_PAYMENT_clickandbuy_TEXT_TITLE;
          $this->description = MODULE_PAYMENT_clickandbuy_TEXT_DESCRIPTION;
          $this->sort_order = MODULE_PAYMENT_clickandbuy_SORT_ORDER;
          $this->enabled = ((MODULE_PAYMENT_clickandbuy_STATUS == 'True') ? true : false);
          $this->order_status = MODULE_PAYMENT_clickandbuy_ORDER_STATUS_ID;

        if (is_object($order)) {
            $this->update_status();
        }

          $this->form_action_url = $this->mk_premium_link();
    }

    function mk_premium_link () {
        global $order;


        $cZone_query     = tep_db_query("select geo_zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where zone_country_id = '" . $_SESSION['customer_country_id'] . "' order by zone_id");
        if($cZone_query) {
            $cZone         = tep_db_fetch_array($cZone_query);
        }

        $zone_query     = tep_db_query("select tax_rate from " . TABLE_TAX_RATES . " where tax_zone_id = '".$cZone['geo_zone_id']."'");

        if($zone_query) {
            $zone         = tep_db_fetch_array($zone_query);
        }

        $user_more_query= tep_db_query("select customers_email_address as email, customers_telephone as telefone, customers_default_address_id as address_id from customers where customers_id='".$_SESSION['customer_id']."'");
        if($user_more_query) {
            $user_more        = tep_db_fetch_array($user_more_query);
        }


        $user_query        = tep_db_query("select     entry_firstname as firstname,
                                                entry_lastname as lastname,
                                                entry_street_address as street_address,
                                                entry_postcode as postcode,
                                                entry_city as city,
                                                entry_country_id as country
                                                from address_book where customers_id='".$_SESSION['customer_id']."' and address_book_id='".$user_more['address_id']."'");
        if($user_query) {
            $user        = tep_db_fetch_array($user_query);
        }

        $lang_query        = tep_db_query("select countries_iso_code_2 as country from countries where countries_id='".$user['country']."'");
        if($lang_query) {
            $user_country        = tep_db_fetch_array($lang_query);
        }

        $tax = preg_replace("/\./", "", $zone['tax_rate']);
        $tax_factor = '1.'.$tax;

        if(!isset($_SESSION['cartID'])) {
            $sess_a     = rand('1000', '9999');

            $_SESSION['cartID'] = substr(md5(rand('1000', '9999')),0,7);
        }


        $return  = $this->href.'clickandbuy_check.php';
            $clickandbuy_price = $this->mk_clickandbuy_amount($_SESSION['cart']->total + round(($_SESSION['shipping']['cost']),2) );
        $return .= '?price='.$clickandbuy_price;                 // total
        $return .= '&userid='.$_SESSION['customer_id'];        // shop userid
        $return .= '&TransactionID='.$_SESSION['cartID'];    // session cartid and clickandbuy TransactionID
        $return .= '&check='.rand('1000','9999');            // first value for redirection-check
        $return .= '&b_check='.rand('100','999');            // second value for redirection-check
        $BDRID = substr(md5(_str_shuffle(rand('100000', '999999'))),1,10);
        $return .= '&externalBDRID='.$BDRID;    // clickandbuy ExternalBDRID


                // optional clickandbuy parameters
                $return .= '&lang='.strtolower($user_country['country']);
                $return .= '&Email='.$user_more['email'];
                $return .= '&FirstName='.$user['firstname'];
                $return .= '&LastName='.$user['lastname'];
                $return .= '&Street='.$user['street_address'];
                $return .= '&ZIP='.$user['postcode'];
                $return .= '&City='.$user['city'];
                $return .= '&telefone='.$user_more['telefone'];


        $_SESSION['externalBDRID'] = $BDRID;
        $_SESSION['TransactionID'] = $_SESSION['cartID'];

        $clickandbuy_query = tep_db_query("update customers_basket set final_price='".round($clickandbuy_price/100,4)."', clickandbuy_TransactionID='".$_SESSION['TransactionID']."', clickandbuy_externalBDRID='".$_SESSION['externalBDRID']."' where customers_id='".$_SESSION['customer_id']."'");

        return($return);

    }

    function mk_clickandbuy_amount ($total) {

        return($total*100);    // return amount in cents

    }

    function check() {
      if (!isset($this->_check)) {
        $check_query = tep_db_query("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_PAYMENT_clickandbuy_STATUS'");
        $this->_check = tep_db_num_rows($check_query);
      }
      return $this->_check;
    }

    function update_status() {
      global $order;

      if ( ($this->enabled == true) && ((int)MODULE_PAYMENT_clickandbuy_ZONE > 0) ) {
        $check_flag = false;
        $check_query = tep_db_query("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_PAYMENT_clickandbuy_ZONE . "' and zone_country_id = '" . $order->billing['country']['id'] . "' order by zone_id");
        while ($check = tep_db_fetch_array($check_query)) {
          if ($check['zone_id'] < 1) {
            $check_flag = true;
            break;
          } elseif ($check['zone_id'] == $order->billing['zone_id']) {
            $check_flag = true;
            break;
          }
        }

        if ($check_flag == false) {
          $this->enabled = false;
        }
      }
    }

    function keys() {
      return array('MODULE_PAYMENT_clickandbuy_STATUS', 'MODULE_PAYMENT_clickandbuy_ID', 'MODULE_PAYMENT_clickandbuy_REDIRECT', 'MODULE_PAYMENT_clickandbuy_CURRENCY', 'MODULE_PAYMENT_clickandbuy_ZONE', 'MODULE_PAYMENT_clickandbuy_ORDER_STATUS_ID', 'MODULE_PAYMENT_clickandbuy_SORT_ORDER');
    }

    function javascript_validation() {
      return false;
    }

    function selection() {
      return array('id' => $this->code,
                   'module' => $this->title);
    }

    function pre_confirmation_check() {
      return false;
    }

    function confirmation() {
      global $cartID, $cab_ID, $customer_id, $languages_id, $order, $order_total_modules;

      if (tep_session_is_registered('cartID')) {
        $insert_order = false;

        if (tep_session_is_registered('cab_ID')) {
          $order_id = substr($cab_ID, strpos($cab_ID, '-')+1);

          $curr_check = tep_db_query("select currency from " . TABLE_ORDERS . " where orders_id = '" . (int)$order_id . "'");
          $curr = tep_db_fetch_array($curr_check);

          if ( ($curr['currency'] != $order->info['currency']) || ($cartID != substr($cab_ID, 0, strlen($cartID))) ) {
            $check_query = tep_db_query('select orders_id from ' . TABLE_ORDERS_STATUS_HISTORY . ' where orders_id = "' . (int)$order_id . '" limit 1');

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
              $class = substr($value, 0, strrpos($value, '.'));
              if ($GLOBALS[$class]->enabled) {
                for ($i=0, $n=sizeof($GLOBALS[$class]->output); $i<$n; $i++) {
                  if (tep_not_null($GLOBALS[$class]->output[$i]['title']) && tep_not_null($GLOBALS[$class]->output[$i]['text'])) {
                    $order_totals[] = array('code' => $GLOBALS[$class]->code,
                                            'title' => $GLOBALS[$class]->output[$i]['title'],
                                            'text' => $GLOBALS[$class]->output[$i]['text'],
                                            'value' => $GLOBALS[$class]->output[$i]['value'],
                                            'sort_order' => $GLOBALS[$class]->sort_order);
                  }
                }
              }
            }
          }

          $sql_data_array = array('customers_id' => $customer_id,
                                  'customers_name' => $order->customer['firstname'] . ' ' . $order->customer['lastname'],
                                  'customers_company' => $order->customer['company'],
                                  'customers_street_address' => $order->customer['street_address'],
                                  'customers_suburb' => $order->customer['suburb'],
                                  'customers_city' => $order->customer['city'],
                                  'customers_postcode' => $order->customer['postcode'],
                                  'customers_state' => $order->customer['state'],
                                  'customers_country' => $order->customer['country']['title'],
                                  'customers_telephone' => $order->customer['telephone'],
                                  'customers_email_address' => $order->customer['email_address'],
                                  'customers_address_format_id' => $order->customer['format_id'],
                                  'delivery_name' => $order->delivery['firstname'] . ' ' . $order->delivery['lastname'],
                                  'delivery_company' => $order->delivery['company'],
                                  'delivery_street_address' => $order->delivery['street_address'],
                                  'delivery_suburb' => $order->delivery['suburb'],
                                  'delivery_city' => $order->delivery['city'],
                                  'delivery_postcode' => $order->delivery['postcode'],
                                  'delivery_state' => $order->delivery['state'],
                                  'delivery_country' => $order->delivery['country']['title'],
                                  'delivery_address_format_id' => $order->delivery['format_id'],
                                  'billing_name' => $order->billing['firstname'] . ' ' . $order->billing['lastname'],
                                  'billing_company' => $order->billing['company'],
                                  'billing_street_address' => $order->billing['street_address'],
                                  'billing_suburb' => $order->billing['suburb'],
                                  'billing_city' => $order->billing['city'],
                                  'billing_postcode' => $order->billing['postcode'],
                                  'billing_state' => $order->billing['state'],
                                  'billing_country' => $order->billing['country']['title'],
                                  'billing_address_format_id' => $order->billing['format_id'],
                                  'payment_method' => $order->info['payment_method'],
                                  'cc_type' => $order->info['cc_type'],
                                  'cc_owner' => $order->info['cc_owner'],
                                  'cc_number' => $order->info['cc_number'],
                                  'cc_expires' => $order->info['cc_expires'],
                                  'date_purchased' => 'now()',
                                  'orders_status' => $order->info['order_status'],
                                  'currency' => $order->info['currency'],
                                  'currency_value' => $order->info['currency_value']);

          tep_db_perform(TABLE_ORDERS, $sql_data_array);

          $insert_id = tep_db_insert_id();

          for ($i=0, $n=sizeof($order_totals); $i<$n; $i++) {
            $sql_data_array = array('orders_id' => $insert_id,
                                    'title' => $order_totals[$i]['title'],
                                    'text' => $order_totals[$i]['text'],
                                    'value' => $order_totals[$i]['value'],
                                    'class' => $order_totals[$i]['code'],
                                    'sort_order' => $order_totals[$i]['sort_order']);

            tep_db_perform(TABLE_ORDERS_TOTAL, $sql_data_array);
          }

          for ($i=0, $n=sizeof($order->products); $i<$n; $i++) {
            $sql_data_array = array('orders_id' => $insert_id,
                                    'products_id' => tep_get_prid($order->products[$i]['id']),
                                    'products_model' => $order->products[$i]['model'],
                                    'products_name' => $order->products[$i]['name'],
                                    'products_price' => $order->products[$i]['price'],
                                    'final_price' => $order->products[$i]['final_price'],
                                    'products_tax' => $order->products[$i]['tax'],
                                    'products_quantity' => $order->products[$i]['qty']);

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

          tep_session_register('cab_ID');
          $cab_ID = $cartID . '-' . $insert_id;
        }
      }
    }

    function before_process() {
      global $customer_id, $order, $sendto, $billto, $payment, $currencies, $cart, $cab_ID, $$payment;

      include(DIR_WS_CLASSES . 'order_total.php');
      $order_total_modules = new order_total;

      $order_totals = $order_total_modules->process();

      $order_id = substr($cab_ID, strpos($cab_ID, '-')+1);

      $sql_data_array = array('orders_id' => $order_id,
                              'orders_status_id' => $order->info['order_status'],
                              'date_added' => 'now()',
                              'customer_notified' => (SEND_EMAILS == 'true') ? '1' : '0',
                              'comments' => $order->info['comments']);

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

      tep_mail($order->customer['firstname'] . ' ' . $order->customer['lastname'], $order->customer['email_address'], EMAIL_TEXT_SUBJECT, $email_order, STORE_OWNER, STORE_OWNER_EMAIL_ADDRESS);

// send emails to other people
      if (SEND_EXTRA_ORDER_EMAILS_TO != '') {
        tep_mail('', SEND_EXTRA_ORDER_EMAILS_TO, EMAIL_TEXT_SUBJECT, $email_order, STORE_OWNER, STORE_OWNER_EMAIL_ADDRESS);
      }

// load the after_process function from the payment modules
      $this->after_process();

      $cart->reset(true);

// unregister session variables used during checkout
      tep_session_unregister('sendto');
      tep_session_unregister('billto');
      tep_session_unregister('shipping');
      tep_session_unregister('payment');
      tep_session_unregister('comments');

      tep_session_unregister('cab_ID');
      
      tep_redirect(tep_href_link(FILENAME_CHECKOUT_SUCCESS, '', 'SSL'));
      return false;
    }

    function after_process() {
        global $insert_id, $HTTP_GET_VARS, $_GET;

        $external = $_GET['externalBDRID'];
            if(!external) $external = 'NULL';

        $string = $_SERVER['argv'][0];
        $pieces = explode('&', $string);

        while($data = each($pieces)) {
            if(substr_count($data['value'], 'transaction') >= '1') {
                $transaction = substr(strrchr($data['value'], '='),1);
            }
            if(substr_count($data['value'], 'userid') >= '1') {
                $userid = substr(strrchr($data['value'], '='),1);
            }
        }


        $sql = tep_db_query("insert into orders_clickandbuy (orders_id, f_transactionID, f_externalBDRID, f_userid, date) values     (
                                                                                                                                '".$insert_id."',
                                                                                                                                '".$transaction."',
                                                                                                                                '".$external."',
                                                                                                                                '".$userid."',
                                                                                                                                '".date("Y-m-d H:i:s")."'
                                                                                                                                )");
        if($sql) return(true);
          else return(false);
    }

    function process_button() {
      global $order, $currencies, $currency;

      if (MODULE_PAYMENT_clickandbuy_CURRENCY == 'Selected Currency') {
        $my_currency = $currency;
      } else {
        $my_currency = substr(MODULE_PAYMENT_clickandbuy_CURRENCY, 5);
      }
      if (!in_array($my_currency, array('CAD', 'EUR', 'GBP', 'JPY', 'USD'))) {
        $my_currency = 'USD';
      }
      $process_button_string = tep_draw_hidden_field('return', tep_href_link(FILENAME_CHECKOUT_PROCESS, '', 'SSL')) .
                               tep_draw_hidden_field('cancel_return', tep_href_link(FILENAME_CHECKOUT_PAYMENT, '', 'SSL'));

      return $process_button_string;
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable clickandbuy Module', 'MODULE_PAYMENT_clickandbuy_STATUS', 'True', 'Do you want to accept clickandbuy payments?', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Premium-Link', 'MODULE_PAYMENT_clickandbuy_ID', 'http://premium-link.net/xxxxxx/', 'Your premium-link from clickandbuy to transfer payments', '6', '4', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Redirect-Filename', 'MODULE_PAYMENT_clickandbuy_REDIRECT', 'clickandbuy_check.php', 'The redirection-Filename for clickandbuy (YOU CAN NOT CHANGE!!!)', '6', '4', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Transaction Currency', 'MODULE_PAYMENT_clickandbuy_CURRENCY', 'Only EUR', 'The currency to use for clickandbuy transactions', '6', '6', 'tep_cfg_select_option(array(''Selected Currency'',''Only USD'',''Only CAD'',''Only EUR'',''Only GBP'',''Only JPY''),', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort order of display.', 'MODULE_PAYMENT_clickandbuy_SORT_ORDER', '1', 'Sort order of display. Lowest is displayed first.', '6', '4', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Payment Zone', 'MODULE_PAYMENT_clickandbuy_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', '6', '2', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Set Order Status', 'MODULE_PAYMENT_clickandbuy_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', '6', '0', 'tep_get_order_status_name', 'tep_cfg_pull_down_order_statuses(', now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }



}




?>