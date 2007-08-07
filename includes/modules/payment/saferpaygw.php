<?php
/* -----------------------------------------------------------------------------------------
   $Id: saferpaygw.php 1308 2005-10-15 14:22:18Z af $

   Copyright (c) 2006 Alexander Federau
   -----------------------------------------------------------------------------------------

   Released under the GNU General Public License 
   ---------------------------------------------------------------------------------------*/

error_reporting(E_ALL ^ E_NOTICE);
  
define('MODULE_PAYMENT_SAFERPAYGW_TEST_ACCOUNT', '99867-94913159');
if ( !defined('MODULE_PAYMENT_SAFERPAYGW_PASSWORD') ) {
	define('MODULE_PAYMENT_SAFERPAYGW_PASSWORD', 'XAjc3Kna');
}
define('TABLE_SAFERPAY_TRANSACTIONS', 'saferpay_transactions');
  
class saferpaygw {
    var $code, $title, $description, $enabled;
    var $payinit_url, $xml_name;
	var $saferpay_languages;
	var $terminal_lang_code = 'en';

// class constructor
	function saferpaygw() {
		global $order;
		
  	    $this->code = 'saferpaygw';
		$this->title = ((defined('MODULE_PAYMENT_SAFERPAYGW_TEXT_TITLE')) ? MODULE_PAYMENT_SAFERPAYGW_TEXT_TITLE : "");
		$this->description = ((defined('MODULE_PAYMENT_SAFERPAYGW_TEXT_DESCRIPTION')) ? MODULE_PAYMENT_SAFERPAYGW_TEXT_DESCRIPTION : "");
		$this->sort_order = ((defined('MODULE_PAYMENT_SAFERPAYGW_SORT_ORDER')) ? MODULE_PAYMENT_SAFERPAYGW_SORT_ORDER : "");
		$this->enabled = ((defined('MODULE_PAYMENT_SAFERPAYGW_STATUS') && strtolower(MODULE_PAYMENT_SAFERPAYGW_STATUS) == 'true') ? true : false);

		if (defined('MODULE_PAYMENT_SAFERPAYGW_ORDER_STATUS_ID') && (int)MODULE_PAYMENT_SAFERPAYGW_ORDER_STATUS_ID > 0) {
			$this->order_status = MODULE_PAYMENT_SAFERPAYGW_ORDER_STATUS_ID;
		}

		// set array of languages
		$this->terminal_lang_code = DEFAULT_LANGUAGE;
	  
		if (is_object($order)) $this->update_status();
      
		$this->form_action_url = '';
	}

	// class methods
    function update_status() {
		global $order;

  	    if ( ($this->enabled == true) && ((int)MODULE_PAYMENT_SAFERPAYGW_ZONE > 0) ) {
			$check_flag = false;
			$check_query = tep_db_query("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_PAYMENT_SAFERPAYGW_ZONE . "' and zone_country_id = '" . $order->billing['country']['id'] . "' order by zone_id");
			while ($check = tep_db_fetch_array($check_query)) {
				if ($check['zone_id'] < 1) {
					$check_flag = true;
					break;
				}
				elseif ($check['zone_id'] == $order->billing['zone_id']) {
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
		global $order;
		$selection = array('id' => $this->code,
                         'module' => $this->title);

		return $selection;
	}

	function pre_confirmation_check() {
		global $osC_Session, $order, $currencies;
		global $currency, $customer_id;
      	
		if (PHP_VERSION < 4.1) {
			global $_POST;
		}

		if ( defined('MODULE_PAYMENT_SAFERPAYGW_CURRENCY') && tep_not_null(MODULE_PAYMENT_SAFERPAYGW_CURRENCY) ) {
			$trx_currency = MODULE_PAYMENT_SAFERPAYGW_CURRENCY;
		}
		else {
			$trx_currency = $currency;
		}

		$query  = tep_db_query("SELECT MAX(orders_id)+1 as new_id FROM " . TABLE_ORDERS);
		$this->orderid = '1';

		if ( tep_db_num_rows($query) > 0)
		{
			$orders = tep_db_fetch_array($query);
			if ( isset($orders['new_id']) && (int)$orders['new_id'] > 0 )
				$this->orderid = $orders['new_id'];
		} else {
			tep_db_query("alter table " . TABLE_ORDERS . " auto_increment=1");
		}
		// order_id + Time  XXX_HHMMSS 
		$this->orderid .= '_' . date("YmdHis");
		//the checking for a posibility to send a request
		//
		$total=$order->info['total'];


  	    if ( $currency == $trx_currency ) {
  	    	$amount = $total;
		}
		else {
			$amount = $total  * $currencies->get_value($trx_currency);
		} 
	  
		$strAttributes = 'ACCOUNTID=' . MODULE_PAYMENT_SAFERPAYGW_ACCOUNT_ID .
					   '&LANGID=' . $this->terminal_lang_code .
					   '&AMOUNT=' . number_format($amount*100, 0, '', '') .
					   '&CURRENCY=' . $trx_currency .
					   '&ALLOWCOLLECT=no' .
					   '&ORDERID='. $this->orderid .
					   //'&USERNOTIFY=' . $customer_values['customers_email_address'] .
					   '&DESCRIPTION=' . urlencode(STORE_NAME) .	
					   '&SUCCESSLINK='.tep_href_link(FILENAME_CHECKOUT_PROCESS, '', 'SSL').
					 '&DELIVERY=no'.
					 '&CCCVC='. (MODULE_PAYMENT_SAFERPAYGW_CCCVC=='true'?'yes':'no').
					 '&CCNAME='. (MODULE_PAYMENT_SAFERPAYGW_CCNAME=='true'?'yes':'no').
					 '&FAILLINK='.tep_href_link(FILENAME_CHECKOUT_PAYMENT, 'payment_error=' . $this->code, 'SSL', true). 
					 '&BACKLINK='.tep_href_link(FILENAME_CHECKOUT_PAYMENT, '', 'SSL');
					 
		if ( defined('MODULE_PAYMENT_SAFERPAYGW_MENUCOLOR') && tep_not_null(MODULE_PAYMENT_SAFERPAYGW_MENUCOLOR) ) {
			$strAttributes .= '&MENUCOLOR='.MODULE_PAYMENT_SAFERPAYGW_MENUCOLOR;
		}
		if ( defined('MODULE_PAYMENT_SAFERPAYGW_MENUFONTCOLOR') && tep_not_null(MODULE_PAYMENT_SAFERPAYGW_MENUFONTCOLOR) ) {
			$strAttributes .= '&MENUFONTCOLOR='.MODULE_PAYMENT_SAFERPAYGW_MENUFONTCOLOR;
		}
		if ( defined('MODULE_PAYMENT_SAFERPAYGW_BODYFONTCOLOR') && tep_not_null(MODULE_PAYMENT_SAFERPAYGW_BODYFONTCOLOR) ) {
			$strAttributes .= '&BODYFONTCOLOR='.MODULE_PAYMENT_SAFERPAYGW_BODYFONTCOLOR;
		}
		if ( defined('MODULE_PAYMENT_SAFERPAYGW_BODYCOLOR') && tep_not_null(MODULE_PAYMENT_SAFERPAYGW_BODYCOLOR) ) {
			$strAttributes .= '&BODYCOLOR='.MODULE_PAYMENT_SAFERPAYGW_BODYCOLOR;
		}
		if ( defined('MODULE_PAYMENT_SAFERPAYGW_HEADFONTCOLOR') && tep_not_null(MODULE_PAYMENT_SAFERPAYGW_HEADFONTCOLOR) ) {
			$strAttributes .= '&HEADFONTCOLOR='.MODULE_PAYMENT_SAFERPAYGW_HEADFONTCOLOR;
		}
		if ( defined('MODULE_PAYMENT_SAFERPAYGW_HEADCOLOR') && tep_not_null(MODULE_PAYMENT_SAFERPAYGW_HEADCOLOR) ) {
			$strAttributes .= '&HEADCOLOR='.MODULE_PAYMENT_SAFERPAYGW_HEADCOLOR;
		}
		if ( defined('MODULE_PAYMENT_SAFERPAYGW_HEADLINECOLOR') && tep_not_null(MODULE_PAYMENT_SAFERPAYGW_HEADLINECOLOR) ) {
			$strAttributes .= '&HEADLINECOLOR='.MODULE_PAYMENT_SAFERPAYGW_HEADLINECOLOR;
		}
		if ( defined('MODULE_PAYMENT_SAFERPAYGW_LINKCOLOR') && tep_not_null(MODULE_PAYMENT_SAFERPAYGW_LINKCOLOR) ) {
			$strAttributes .= '&LINKCOLOR='.MODULE_PAYMENT_SAFERPAYGW_LINKCOLOR;
		}
		
		$url = MODULE_PAYMENT_SAFERPAYGW_PAYINIT_URL.'?'.$strAttributes;
		// debug
		//error_log(var_export($url, true)."\n", 3, DIR_FS_CATALOG.'tmp/saferpay_'.date('Ymd').'.log');
		$payinit_url = join("", file($url));
		// debug
		//error_log("PayInit: ". var_export($payinit_url, true)."\n", 3, DIR_FS_CATALOG.'tmp/saferpay_'.date('Ymd').'.log');

  	    if(strlen($payinit_url) >0) {
			$this->payinit_url = rawurlencode($payinit_url);
			$this->form_action_url = "JavaScript: OpenSaferpayTerminal('" . $this->payinit_url . "', this, 'BUTTON');";
		}
		else{
			$payment_error_return = 'payment_error=' . $this->code . '&error=' . TEXT_SAFERPAYGW_SETUP_ERROR;
			tep_redirect(tep_href_link(FILENAME_CHECKOUT_PAYMENT, $payment_error_return, 'SSL', true, false));
		}
		return false;
    }

	function confirmation() {
		return false;
    }

    function process_button() {
//the preperation for a payment here
		$process_button_string = '<script src="http://www.saferpay.com/OpenSaferpayScript.js"></script>';
//end of the preperation for a payment here

  	    return $process_button_string;
    }

    function before_process() {
		global $customer_id, $currency;
		//global $QUERY_STRING;
		parse_str($_SERVER['QUERY_STRING']);
		//$DATA = rawurldecode($DATA);
		//$SIGNATURE = rawurldecode($SIGNATURE);
		// debug
		//error_log("Responce: ". var_export($_SERVER['QUERY_STRING'], true)."\n", 3, DIR_FS_CATALOG.'tmp/saferpay_'.date('Ymd').'.log');
		//error_log("Responce DATA: ". var_export($DATA, true)."\n", 3, DIR_FS_CATALOG.'tmp/saferpay_'.date('Ymd').'.log');
		
		//extract amount and currency 
		$trx_amount = 0;
		if ( preg_match('/^<IDP\s.*AMOUNT="([0-9]+)".*>$/i', $DATA, $matches) ) {
			$trx_amount = floatval($matches[1]);
		}
		$trx_currency = $currency;
		if ( preg_match('/^<IDP\s.*CURRENCY="([A-Z]{3})".*>$/i', $DATA, $matches) ) {
			$trx_currency = $matches[1];
		}
		$payment_provider_id = 0;
		if ( preg_match('/^<IDP\s.*PROVIDERID="([0-9]+)".*>$/i', $DATA, $matches) ) {
			$payment_provider_id = intval($matches[1]);
		}
		$payment_provider_name = '';
		if ( preg_match('/^<IDP\s.*PROVIDERNAME="([^"]+)".*>$/i', $DATA, $matches) ) {
			$payment_provider_name = $matches[1];
		}
		

		/* put it all together */
		$url = MODULE_PAYMENT_SAFERPAYGW_CONFIRM_URL ."?DATA=".urlencode($DATA)."&SIGNATURE=".urlencode($SIGNATURE);
		/* verify pay confirm message at hosting server */
		$result = join("", file($url));
		// debug
		//error_log("PayConfirm: ". var_export($result, true)."\n", 3, DIR_FS_CATALOG.'tmp/saferpay_'.date('Ymd').'.log');

  	    if (substr($result, 0, 3) == "OK:" ) {
			parse_str(substr($result, 3));
			/* $ID = saferpay transaction identifier, store in DBMS */
			/* $TOKEN = token of transaction, store in DBMS */
			$this->ID = $ID;
			$sql_data_array = array( 'customers_id' => $customer_id,
									 'saferpay_ID' => $this->ID,
									 'saferpay_amount' => $trx_amount/100,
									 'saferpay_currency' => $trx_currency,
									 'saferpay_provider_id' => $payment_provider_id,
									 'saferpay_provider_name' => tep_db_prepare_input($payment_provider_name),
									 'date_added' => 'now()');
			tep_db_perform(TABLE_SAFERPAY_TRANSACTIONS, $sql_data_array);

			if ( defined('MODULE_PAYMENT_SAFERPAYGW_COMPLETE') && MODULE_PAYMENT_SAFERPAYGW_COMPLETE == 'true' ) {
				/***** Optional: Finalize payment by capture of transaction *****/
				// if test account than use Password
				$spPassword = '';
				if ( defined('MODULE_PAYMENT_SAFERPAYGW_ACCOUNT_ID') && MODULE_PAYMENT_SAFERPAYGW_ACCOUNT_ID == MODULE_PAYMENT_SAFERPAYGW_TEST_ACCOUNT ) {
					$spPassword = '&spPassword='.MODULE_PAYMENT_SAFERPAYGW_PASSWORD;
				}

				/* put it all together */
				$url = MODULE_PAYMENT_SAFERPAYGW_COMPLETE_URL."?ACCOUNTID=".MODULE_PAYMENT_SAFERPAYGW_ACCOUNT_ID."&ID=".urlencode($ID)."&TOKEN=".urlencode($TOKEN).$spPassword;
				// debug
				//error_log("PayComplete URL:". var_export($url, true)."\n", 3, DIR_FS_CATALOG.'tmp/saferpay_'.date('Ymd').'.log');
				/* complete payment by hosting server */
				$result = join("", file($url));
				// debug
				//error_log("PayComplete:". var_export($result, true)."\n", 3, DIR_FS_CATALOG.'tmp/saferpay_'.date('Ymd').'.log');
				if (substr($result, 0, 2) == "OK") {
					$sql_data_array = array( 'saferpay_complete' => '1',
											 'saferpay_complete_result' => $result);
				}
				else {
					// payment could not be completed
					$sql_data_array = array( 'saferpay_complete_result' => $result);
				}
				tep_db_perform(TABLE_SAFERPAY_TRANSACTIONS, $sql_data_array, 'update', "customers_id='". $customer_id ."' AND saferpay_ID='". $this->ID ."'");
			}
		}
		else {
			$payment_error_return = 'payment_error=' . $this->code . '&error=' . TEXT_SAFERPAYGW_CONFIRMATION_ERROR;
			tep_redirect(tep_href_link(FILENAME_CHECKOUT_PAYMENT, $payment_error_return, 'SSL', true, false));
		}

 	     return false;
	}


    function after_process() {
	    global $insert_id, $customer_id;

		if ( isset($this->ID) && strlen($this->ID) > 0 ) {
			$sql_data_array = array( 'orders_id' => $insert_id);
			tep_db_perform(TABLE_SAFERPAY_TRANSACTIONS, $sql_data_array, 'update', "customers_id='". $customer_id ."' AND saferpay_ID='". $this->ID ."'");
		}
		return false;
    }

    function get_error() {
		if (PHP_VERSION < 4.1) {
			global $_GET;
		}

  	    $error = array('title' => SAFERPAYGW_ERROR_HEADING,
                     'error' => ((isset($_GET['error'])) ? stripslashes(urldecode($_GET['error'])) : SAFERPAYGW_ERROR_MESSAGE));

 	     return $error;
	}

    function check() {
		if (!isset($this->_check)) {
			$check_query = tep_db_query("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_PAYMENT_SAFERPAYGW_STATUS'");
			$this->_check = tep_db_num_rows($check_query);
		}
		return $this->_check;
    }

    function install() {
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, set_function, use_function, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_STATUS', 'true', '6', '1', 'tep_cfg_pull_down_truefalse(', 'tep_get_cfg_truefalse', now(), 'Saferpay Modul aktivieren', 'M&ouml;chten Sie Zahlungen per Saferpay akzeptieren?')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_ALLOWED', '', '6', '0', now(), 'Erlaubte Zonen', 'Geben Sie <b>einzeln</b> die Zonen an, welche f&uuml;r dieses Modul erlaubt sein sollen. (z.B. AT,DE (wenn leer, werden alle Zonen erlaubt))')");
		//tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_LOGIN', 'e99867001', '6', '2', now(), 'Saferpay-Loginname', 'Loginname, welches f&uuml;r Saferpay verwendet wird')");
		//tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_PASSWORD', 'XAjc3Kna', '6', '4', now(), 'Saferpay-Passwort', 'Passwort welches f&uuml;r Saferpay verwendet wird')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_ACCOUNT_ID', '99867-94913159', '6', '5', now(), 'Saferpay-Konto', 'ACCOUNTID des Saferpay Terminals')");
		//tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_PATH', '', '6', '3', now(), '', '')");
		
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_PAYINIT_URL', 'https://www.saferpay.com/hosting/CreatePayInit.asp', '6', '6', now(), 'PayInit URL', 'URL für die Initialisierung der Zahlung')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_CONFIRM_URL', 'https://www.saferpay.com/hosting/VerifyPayConfirm.asp', '6', '7', now(), 'PayConfirm URL', 'URL für die Bestätigung der Zahlung')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_COMPLETE_URL', 'https://www.saferpay.com/hosting/PayComplete.asp', '6', '8', now(), 'PayComplete URL', 'URL für das Abschließen der Zahlung')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, set_function, use_function, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_COMPLETE', 'false', '6', '9', 'tep_cfg_pull_down_truefalse(', 'tep_get_cfg_truefalse', now(), 'Transaktion verbuchen', 'Sofortige Verbuchung der Saferpay Transaktion')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, set_function, use_function, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_CCCVC', 'true', '6', '10', 'tep_cfg_pull_down_truefalse(', 'tep_get_cfg_truefalse', now(), 'CVC Eingabe', 'Abfrage der Kartenprüfnummer')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, set_function, use_function, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_CCNAME', 'true', '6', '11', 'tep_cfg_pull_down_truefalse(', 'tep_get_cfg_truefalse', now(), 'Karteninhaber', 'Abfrage des Karteninhabernamens')");

		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, set_function, use_function, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_CURRENCY', '".DEFAULT_CURRENCY."', '6', '9', 'tep_cfg_pull_down_currencies(', 'tep_get_currency_name', now(), 'Transaktionswährung', 'Währung für die Zahlungsanfragen')");

		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_MENUCOLOR', '#93B1CF', '6', '10', now(), '<hr size=1><br>MENUCOLOR', 'Farbe inaktiver Reiter.&nbsp;<a href=\"images/saferpaygw_styling.jpg\" target=_blank><img src=\"images/icons/unknown.jpg\" width=\"15\" border=\"0\" alt=\"Hilfe\"></a>')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_MENUFONTCOLOR', '#000000', '6', '10', now(), 'MENUFONTCOLOR', 'Schriftfarbe des Menüs.')");
		//tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_FONT', 'Verdana', '6', '10', now(), '', '')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_BODYFONTCOLOR', '#000000', '6', '10', now(), 'BODYFONTCOLOR', 'Schriftfarbe des Eingabebereichs.')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_BODYCOLOR', '#E5E7E8', '6', '10', now(), 'BODYCOLOR', 'Hintergrundfarbe des Saferpay VT.')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_HEADFONTCOLOR', '#000000', '6', '10', now(), 'HEADFONTCOLOR', 'Schriftfarbe der Reiter.')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_HEADCOLOR', '#134B83', '6', '10', now(), 'HEADCOLOR', 'Hintergrundfarbe des oberen Bereichs.')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_HEADLINECOLOR', '#93B1CF', '6', '10', now(), 'HEADLINECOLOR', 'Farbe der Trennlinie oben links.')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_LINKCOLOR', '#134B83', '6', '10', now(), 'LINKCOLOR', 'Schriftfarbe der Links.')");
		
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_SORT_ORDER', '0', '6', '10', now(), 'Anzeigereihenfolge', 'Reihenfolge der Anzeige. Kleinste Ziffer wird zuerst angezeigt.')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, use_function, set_function, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_ZONE', '0', '6', '11', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now(), '<hr><br />Zahlungszone', 'Wenn eine Zone ausgew&auml;hlt ist, gilt die Zahlungsmethode nur f&uuml;r diese Zone.')");
		tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_key, configuration_value, configuration_group_id, sort_order, set_function, use_function, date_added, configuration_title, configuration_description) values ('MODULE_PAYMENT_SAFERPAYGW_ORDER_STATUS_ID', '0', '6', '12', 'tep_cfg_pull_down_order_statuses(', 'tep_get_order_status_name', now(), 'Bestellstatus festlegen', 'Mit Saferpay bezahlte Bestellungen, auf diesen Status setzen')");
		
		// create DB table for store of saferpaytransactions
		$query_raw = "CREATE TABLE IF NOT EXISTS ". TABLE_SAFERPAY_TRANSACTIONS ." (
  trans_id int(11) NOT NULL auto_increment,
  customers_id int(11) NOT NULL default '0',
  orders_id int(11) NOT NULL default '0',
  saferpay_ID varchar(96) default NULL,
  saferpay_amount decimal(15,4) NOT NULL default '0.0000',
  saferpay_currency varchar(8) NOT NULL default '',
  saferpay_provider_id int(11) default '0',
  saferpay_provider_name varchar(255) default NULL,
  saferpay_complete int(1) NOT NULL default '0',
  saferpay_complete_result varchar(255) default NULL,
  date_added datetime default NULL,
  last_modified datetime default NULL,
  PRIMARY KEY  (trans_id),
  KEY IDX_CUSTOMERS (customers_id),
  KEY IDX_ORDER (orders_id),
  KEY IDX_SAFERPAY_ID (saferpay_ID) 
);";
		
		tep_db_query($query_raw);

    }

    function remove() {
		tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
		return array('MODULE_PAYMENT_SAFERPAYGW_STATUS',
					 'MODULE_PAYMENT_SAFERPAYGW_ALLOWED',
					 //'MODULE_PAYMENT_SAFERPAYGW_LOGIN',
					 //'MODULE_PAYMENT_SAFERPAYGW_PASSWORD',
					 'MODULE_PAYMENT_SAFERPAYGW_ACCOUNT_ID',
					 //'MODULE_PAYMENT_SAFERPAYGW_PATH',
					 'MODULE_PAYMENT_SAFERPAYGW_PAYINIT_URL',
					 'MODULE_PAYMENT_SAFERPAYGW_CONFIRM_URL',
					 'MODULE_PAYMENT_SAFERPAYGW_COMPLETE_URL',
					 'MODULE_PAYMENT_SAFERPAYGW_COMPLETE',
					 'MODULE_PAYMENT_SAFERPAYGW_CCCVC',
					 'MODULE_PAYMENT_SAFERPAYGW_CCNAME',
					 'MODULE_PAYMENT_SAFERPAYGW_CURRENCY',
					 
					 'MODULE_PAYMENT_SAFERPAYGW_MENUCOLOR',
					 'MODULE_PAYMENT_SAFERPAYGW_MENUFONTCOLOR',
					 //'MODULE_PAYMENT_SAFERPAYGW_FONT',
					 'MODULE_PAYMENT_SAFERPAYGW_BODYFONTCOLOR',
					 'MODULE_PAYMENT_SAFERPAYGW_BODYCOLOR',
					 'MODULE_PAYMENT_SAFERPAYGW_HEADFONTCOLOR',
					 'MODULE_PAYMENT_SAFERPAYGW_HEADCOLOR',
					 'MODULE_PAYMENT_SAFERPAYGW_HEADLINECOLOR',
					 'MODULE_PAYMENT_SAFERPAYGW_LINKCOLOR',
					 
					 'MODULE_PAYMENT_SAFERPAYGW_ZONE',
					 'MODULE_PAYMENT_SAFERPAYGW_ORDER_STATUS_ID',
					 'MODULE_PAYMENT_SAFERPAYGW_SORT_ORDER');
	}
}

function tep_cfg_pull_down_truefalse($truefalse, $key = '') {

	$name = (($key) ? 'configuration['.$key.']' : 'configuration_value');

	$truefalse_array = array(array ('id' => 'true', 'text' => YES),
						     array('id' => 'false', 'text' => NO));

	return tep_draw_pull_down_menu($name, $truefalse_array, $truefalse);
}

function tep_get_cfg_truefalse($truefalse, $language_id = '') {

	if ( tep_not_null($truefalse) ) {
		if ( $truefalse == 'true' ) {
			return YES;
		}
	}
	return NO;
}

function tep_cfg_pull_down_currencies($currency_code, $key = '') {

	$name = (($key) ? 'configuration['.$key.']' : 'configuration_value');

	$query_res = tep_db_query("select title, code from ".TABLE_CURRENCIES." order by title");
	if ( tep_db_num_rows($query_res) > 1) {
		//$currencies_array = array (array ('id' => '', 'text' => TEXT_USER_CURRENCY));
	}
	else {
		$currencies_array = array ();
	}
	
	while ($record = tep_db_fetch_array($query_res)) {
		$currencies_array[] = array ('id' => $record['code'], 'text' => $record['title']);
	}

	return tep_draw_pull_down_menu($name, $currencies_array, $currency_code);
}

function tep_get_currency_name($currency_id, $language_id = '') {

	if ( tep_not_null($currency_id) ) {
		return $currency_id;
	}
	return TEXT_USER_CURRENCY;
}
?>