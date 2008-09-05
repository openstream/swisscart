<?php
/*
  $Id: postfinance.php
  v 3.1 2007-08-02
  Created by : Ex-perience Informatique Delémont
  Adapted by : ASULIS and Openstream Internet Solutions

  Copyright (c) 2002-2007 osCommerce, Open Source E-Commerce Solutions  http://www.oscommerce.com
  Released under the GNU General Public License

  This module offers payment via postcard and credit cards using the yellowpay payment module of the swiss post.
  Information: This module is free, but please refer to infos@ex-perience.ch everywhere it should be as he did the  whole base of this contribution.

  This new version is based on the POSTFINANCE contrution of dj-smoye's/ex-perience :
  - allow call in right language depending on navagitation language (french=4108, english=2057, italian=2064, 
    german=2055) or use the default admin language that has been set
  - allow to use the navigation currency if not special is set in the admin
  - added fields to define different hash seeds and shop-ids on the amdin side as well as the test and production 
    mod 

  NOTE:
  - all has been updated to allow direct call of the yellowpay window from checkout_confirmation.php
  - this helps to remove the calling page postfinance_process.php 
  - ASULIS tweak of checkout_confirmation.php is actually unneccessary if the parameter txtHistoryBack
    is set to false. This prevents PostFinance to call the history.back() JavaScript function and avoids
	having to change the form action from POST to GET
  - this minor change should make the PostFinance module as easily installable as other payment modules, i.e.
    no modifications to any files are required any more!
*/

global $adminlang, $zero, $one, $two, $three , $four, $five, $six,$seven,$eight,$nine;
////////////////////////////////////////////////////////////////
// Language Configuration
// Plese choose your Language used at Adminzone
// 1 = Francais 2 = Deutsch 3 = English
$adminlang = "2";  // <--------------- Choose your language!!!
////////////////////////////////////////////////////////////////
// Plan: We give all the Text intro an array for each line
// First of all, we have to check what lang is used, then fill the arrays
switch($adminlang){
  case 1:
    $zero[0] = "Activer le module PostFinance";
    $zero[1] = "Voulez-vous accepter les paiement par postcard?";
    $one[0] = "Langue par défaut utilisée pour le masque de paiement";
    $one[1] = "Choisissez la langue par défaut désirée pour le masque de paiement, français (4108), anglais (2057), italien (2064), allemand (2055)";
    $two[0] = "ID Shop (Transmis par la Poste)";
    $two[1] = "txtShopID";
    $three[0] = "Ordre de tri";
    $three[1] = "ordre de tri pour l\'affichage (Le plus petit nombre est montré en premier)";
    $four[0] = "Devise par défaut";
    $four[1] = "Devise par défaut utilisée pour les transactions (ex: CHF force l\'achat en CHF / laisser vide si le module de paiement est appelé avec la devise de navigation";
    $five[0] = "Etat de la commande";
    $five[1] = "Sélectionner l\'état de la commande que vous voulez par défault.";
    $six[0] = "Zone";
    $six[1] = "Si une zone est sélectionnée activer ce module uniquement pour cette zone.";
    $seven[0] = "Hash seed";
    $seven[1] = "Hash seed";
    $eight[0] = "Shop-ID";
    $eight[1] = "Shop-ID";
    $nine[0] = "Mod";
    $nine[1] = "Mod (1=TEST / ELSE=PRODUCTION)";
  break;
  case 2:
    $zero[0] = "PostFinance Modul aktivieren";
    $zero[1] = "Möchten Sie die Bezahlung via Postcard akzeptieren?";
    $one[0] = "Mit welcher Standard Sprache soll die Zahlungsmaske aufgerufen werden?";
    $one[1] = "Bitte wählen Sie die Standard Sprache für die Zahlungsmaske, Französisch (4108), Englisch (2057), Italienisch (2064), Deutsch (2055)";
    $two[0] = "ID Shop (Von der Post erhalten)";
    $two[1] = "txtShopID";
    $three[0] = "Sortierung";
    $three[1] = "Reihenfolge für die Zahlungsmöglichkeiten (Die kleinste Nummer kommt als erstes)";
    $four[0] = "Standard Währung";
    $four[1] = "Standard Währung die für die Transaktion verwendet wird (Bsp: CHF zwingt die CHF Währung zu benutzen / leer wenn Navigationswährung benutzt wird)";
    $five[0] = "Status der Bestellung";
    $five[1] = "Wählen Sie den Status den Sie per default gesetzt haben möchten.";
    $six[0] = "Zone";
    $six[1] = "Wählen Sie für welche Zone dieses Modul aktiviert werden soll.";
    $seven[0] = "Hash seed";
    $seven[1] = "Hash seed";
    $eight[0] = "Shop-ID";
    $eight[1] = "Shop-ID";
    $nine[0] = "Mod";
    $nine[1] = "Mod (1=TEST / ELSE=PRODUCTION)";
  break;
  case 3:
    $zero[0] = "Activate PostFinance module";
    $zero[1] = "Do you wanna accept payments over Postcard?";
    $one[0] = "What default language should we use for the yellowpay mask?";
    $one[1] = "Please choose your default language for the Postfinancemask, French (4108), English (2057), Italian (2064), German (2055)";
    $two[0] = "ID Shop (You get it from Postfinance)";
    $two[1] = "txtShopID";
    $three[0] = "Sort";
    $three[1] = "Sort order of display. (Lowest is displayed first)";
    $four[0] = "Default Transaction Currency";
    $four[1] = "The default currency to use for transactions (ex: CHF forces to use CHF for payment / empty if Navigation currency is udes)";
    $five[0] = "State of order";
    $five[1] = "Set the status of orders made with this payment module to this value.";
    $six[0] = "Payment Zone";
    $six[1] = "If a zone is selected, only enable this payment method for that zone.";
    $seven[0] = "Hash seed";
    $seven[1] = "Hash seed";
    $eight[0] = "Shop-ID";
    $eight[1] = "Shop-ID";
    $nine[0] = "Mod";
    $nine[1] = "Mod (1=TEST / ELSE=PRODUCTION)";
  break;
}


// Dont change anything below this line!!!



  class postfinance {
    var $code, $title, $description, $enabled;

// class constructor
    function postfinance() {
      global $order;

      $this->code = 'postfinance';
      $this->title = MODULE_PAYMENT_POSTFINANCE_TEXT_TITLE;
      $this->description = MODULE_PAYMENT_POSTFINANCE_TEXT_DESCRIPTION;
      $this->sort_order = MODULE_PAYMENT_POSTFINANCE_SORT_ORDER;
      $this->email_description = MODULE_PAYMENT_POSTFINANCE_TEXT_DESCRIPTION ;//cs: added
      $this->enabled = ((MODULE_PAYMENT_POSTFINANCE_STATUS == 'True') ? true : false);
      $this->state = ((MODULE_PAYMENT_POSTFINANCE_MOD == '1') ? '1' : '0');

      if ((int)MODULE_PAYMENT_POSTFINANCE_ORDER_STATUS_ID > 0) {
        $this->order_status = MODULE_PAYMENT_POSTFINANCE_ORDER_STATUS_ID;
      }

      if (is_object($order)) $this->update_status();
      //$this->form_action_url = 'postfinance_process.php';

      ///////////////////////////////////////////////////////////////////////////
      // Please choose if you are in testing or production phase:
      // 1 = Test 2 = Production
      //$state = "1";
      // check if we are in production or testing mode
      //if($state=="1") {$url = "<form name='postfinance' action='https://yellowpaytest.postfinance.ch/checkout/Yellowpay.aspx?userctrl=Invisible' method='POST'>";}
      //else {$url = "<form name='postfinance' action='https://yellowpay.postfinance.ch/checkout/Yellowpay.aspx?userctrl=Invisible' method='POST'>";}
      if($this->state=="1") {$this->form_action_url='https://yellowpaytest.postfinance.ch/checkout/Yellowpay.aspx?userctrl=Invisible';}
      else {$this->form_action_url='https://yellowpay.postfinance.ch/checkout/Yellowpay.aspx?userctrl=Invisible';}
      // build form header with the URL
      echo $url;
      ///////////////////////////////////////////////////////////////////////////
    }

// class methods
    function update_status() {
      global $order;

      if ( ($this->enabled == true) && ((int)MODULE_PAYMENT_POSTFINANCE_ZONE > 0) ) {
        $check_flag = false;
        $check_query = tep_db_query("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_PAYMENT_POSTFINANCE_ZONE . "' and zone_country_id = '" . $order->billing['country']['id'] . "' order by zone_id");
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
      return false;
    }

    function process_button() {
      global $HTTP_POST_VARS, $HTTP_SERVER_VARS, $customer_id, $currencies, $currency, $order, $osCsid, $sidretour, $customers_id, $language;
       
	    switch($language){
        case 'german':
          $usedlanguage=2055;
        break;
        case 'english':
          $usedlanguage=2057;
        break;
        case 'italian':
          $usedlanguage=2064;
        break;
        case 'french':
          $usedlanguage=4108;
        break;
        default:
          $usedlanguage=MODULE_PAYMENT_POSTFINANCE_LANGUAGE;
        break;
		  }
      
      //set default currency for module
	    if(MODULE_PAYMENT_POSTFINANCE_CURRENCY){$usedcurrency=MODULE_PAYMENT_POSTFINANCE_CURRENCY;}
	    else{$usedcurrency=$currency;}
      $usedtotal = number_format($order->info['total'] * $currencies->get_value($currency), $currencies->get_decimal_places($currency), '.', '');
  		//$sidretour = tep_session_id();
  		//$sidretour = 'osCsid=' . tep_session_id(); 
      $sidretour = tep_session_name() . '=' . tep_session_id(); 
	  eval('$Hash_seed=MODULE_PAYMENT_POSTFINANCE_TEXT_HASH_'.$currency.';');
      eval('$Shop_ID=MODULE_PAYMENT_POSTFINANCE_SHOP_ID_'.$currency.';');
      eval('$txtShopId=MODULE_PAYMENT_POSTFINANCE_TXT_SHOP_ID_'.$currency.';');
      $txtHash_tosecure = $txtShopId . $currency . $usedtotal . $Hash_seed;
      $txtHash = md5($txtHash_tosecure);

      // required hidden fields
      $process_button_string = tep_draw_hidden_field('txtShopID', $txtShopId) .
      			       		   tep_draw_hidden_field('txtShopPara', $sidretour) .
                               tep_draw_hidden_field('txtOrderTotal', $usedtotal) .
                               tep_draw_hidden_field('txtLangVersion', $usedlanguage) .
                               tep_draw_hidden_field('txtArtCurrency', $usedcurrency) .
							   tep_draw_hidden_field('txtHash', $txtHash) .
	  // optional hidden fields
                               tep_draw_hidden_field('txtOrderIDShop', $customer_id) .
			       			   tep_draw_hidden_field('txtBLastName', $order->billing['lastname']) .
							   tep_draw_hidden_field('txtBFirstName', $order->billing['firstname']) .
							   tep_draw_hidden_field('txtBAddr1', $order->billing['street_address']) .
							   tep_draw_hidden_field('txtBZipCode', $order->billing['postcode']) .
							   tep_draw_hidden_field('txtBCity', $order->billing['city']) .
							   tep_draw_hidden_field('txtBTel', $order->customer['telephone']) .
                               tep_draw_hidden_field('txtBEmail', $order->customer['email_address']) .
							   tep_draw_hidden_field('txtHistoryBack', 'false') .
							   tep_draw_hidden_field('deliveryPaymentType', 'deferred') . 						   
                               tep_draw_hidden_field(tep_session_name(),tep_session_id());


      return $process_button_string;
    }

    function before_process() {
      return false;
    }

    function after_process() {
      return false;
    }

    function get_error() {
      return false;
    }

    function check() {
      if (!isset($this->_check)) {
        $check_query = tep_db_query("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_PAYMENT_POSTFINANCE_STATUS'");
        $this->_check = tep_db_num_rows($check_query);
      }
      return $this->_check;
    }


    function install() {
      
      global $adminlang, $bzero, $zero, $one, $two, $three , $four, $five, $six, $seven, $eight, $nine;
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('$zero[0]', 'MODULE_PAYMENT_POSTFINANCE_STATUS', 'True', '$zero[1]', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('$one[0]', 'MODULE_PAYMENT_POSTFINANCE_LANGUAGE', '4108', '$one[1]', '6', '1', 'tep_cfg_select_option(array(\'4108\', \'2057\', \'2064\', \'2055\'), ', now())");
      //tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('$two[0]', 'MODULE_PAYMENT_POSTFINANCE_MERCHANT_ID', 'XXXXXXXX0000_yp', '$two[1]', '6', '2', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('$three[0]', 'MODULE_PAYMENT_POSTFINANCE_SORT_ORDER', '0', '$three[1]', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('$four[0]', 'MODULE_PAYMENT_POSTFINANCE_CURRENCY', 'CHF', '$four[1]', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) values ('$five[0]', 'MODULE_PAYMENT_POSTFINANCE_ORDER_STATUS_ID', '0', '$five[1]', '6', '0', 'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('$six[0]', 'MODULE_PAYMENT_POSTFINANCE_ZONE', '0', '$six[1]', '6', '2', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now())"); 
    
	    $currencies_query = tep_db_query("SELECT * FROM " . TABLE_CURRENCIES . "");
	    while($currencies = tep_db_fetch_array($currencies_query)){
	      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('$two[0] ".$currencies['code']."', 'MODULE_PAYMENT_POSTFINANCE_TXT_SHOP_ID_".$currencies['code']."', 'XXXXXXXXXX', '$two[1] ".$currencies['code']."', '6', '2', now())"); 
	      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('$seven[0] ".$currencies['code']."', 'MODULE_PAYMENT_POSTFINANCE_TEXT_HASH_".$currencies['code']."', 'XXXXXXXXXX', '$seven[1] ".$currencies['code']."', '6', '2', now())"); 
        tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('$eight[0] ".$currencies['code']."', 'MODULE_PAYMENT_POSTFINANCE_SHOP_ID_".$currencies['code']."', '0000', '$eight[1] ".$currencies['code']."', '6', '2', now())"); 
      }

      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('$nine[0]', 'MODULE_PAYMENT_POSTFINANCE_MOD', '1', '$nine[1]', '6', '1', 'tep_cfg_select_option(array(\'1\', \'0\'), ', now())");
    }


    function remove() {
      //tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where locate('MODULE_PAYMENT_POSTFINANCE',configuration_key)");
    }

    function keys() {
      //$keys = array('MODULE_PAYMENT_POSTFINANCE_STATUS','MODULE_PAYMENT_POSTFINANCE_LANGUAGE', 'MODULE_PAYMENT_POSTFINANCE_MERCHANT_ID', 'MODULE_PAYMENT_POSTFINANCE_CURRENCY', 'MODULE_PAYMENT_POSTFINANCE_ORDER_STATUS_ID', 'MODULE_PAYMENT_POSTFINANCE_SORT_ORDER', 'MODULE_PAYMENT_POSTFINANCE_ZONE');
      $keys = array('MODULE_PAYMENT_POSTFINANCE_STATUS','MODULE_PAYMENT_POSTFINANCE_LANGUAGE', 'MODULE_PAYMENT_POSTFINANCE_CURRENCY', 'MODULE_PAYMENT_POSTFINANCE_ORDER_STATUS_ID', 'MODULE_PAYMENT_POSTFINANCE_SORT_ORDER', 'MODULE_PAYMENT_POSTFINANCE_ZONE');
	    $currencies_query = tep_db_query("SELECT * FROM " . TABLE_CURRENCIES . "");
	    while($currencies = tep_db_fetch_array($currencies_query)){
	      $keys[]='MODULE_PAYMENT_POSTFINANCE_TXT_SHOP_ID_'.$currencies['code']; 
	      $keys[]='MODULE_PAYMENT_POSTFINANCE_TEXT_HASH_'.$currencies['code']; 
	      $keys[]='MODULE_PAYMENT_POSTFINANCE_SHOP_ID_'.$currencies['code']; 
      }
	    $keys[]='MODULE_PAYMENT_POSTFINANCE_MOD'; 
      return $keys;
    }
  }
?>
