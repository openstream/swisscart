<?php
/*
  $Id: chplet.php,v 1.05 2003/02/18 03:37:00 harley_vb Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 - 2003 osCommerce

  Released under the GNU General Public License

  Copyright (C) 2002 - 2003 TheMedia, Dipl.-Ing Thomas Pl�nkers
  http://www.themedia.at & http://www.oscommerce.at
  
  Modified by Openstream Internet Solutions
  http://www.openstream.ch
*/


  class chplet {
    var $code, $title, $description, $icon, $enabled, $num_chplet;

// class constructor
    function chplet() {
      global $order;

      $this->code = 'chplet';
      $this->title = MODULE_SHIPPING_CHPLET_TEXT_TITLE;
      $this->description = MODULE_SHIPPING_CHPLET_TEXT_DESCRIPTION;
      $this->sort_order = MODULE_SHIPPING_CHPLET_SORT_ORDER;
      $this->icon = DIR_WS_ICONS . 'shipping_chp.gif';
      $this->tax_class = MODULE_SHIPPING_CHPLET_TAX_CLASS;
      $this->enabled = ((MODULE_SHIPPING_CHPLET_STATUS == 'True') ? true : false);

      if ( ($this->enabled == true) && ((int)MODULE_SHIPPING_CHPLET_ZONE > 0) ) {
        $check_flag = false;
        $check_query = tep_db_query("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_SHIPPING_CHPLET_ZONE . "' and zone_country_id = '" . $order->delivery['country']['id'] . "' order by zone_id");
        while ($check = tep_db_fetch_array($check_query)) {
          if ($check['zone_id'] < 1) {
            $check_flag = true;
            break;
          } elseif ($check['zone_id'] == $order->delivery['zone_id']) {
            $check_flag = true;
            break;
          }
        }

        if ($check_flag == false) {
          $this->enabled = false;
        }
		
		// hide module if too much weight instead of displaying
		// error message and leaving the radio button available with
		// no shipping cost
        $chplet_cost = constant('MODULE_SHIPPING_CHPLET_COST_1');
        $chplet_table = preg_split("/[:,]/" , $chplet_cost);
		$maximum_weight = $chplet_table[count($chplet_table)-2];
        if ($_SESSION['cart']->weight > $maximum_weight) $this->enabled = false;
		
      }

      // CUSTOMIZE THIS SETTING FOR THE NUMBER OF ZONES NEEDED
      $this->num_chplet = 1;
    }

// class methods
    function quote($method = '') {
      global $HTTP_POST_VARS, $order, $shipping_weight, $shipping_num_boxes;

      $dest_country = $order->delivery['country']['iso_code_2'];
      $dest_zone = 0;
      $error = false;

      for ($i=1; $i<=$this->num_chplet; $i++) {
        $countries_table = constant('MODULE_SHIPPING_CHPLET_COUNTRIES_' . $i);
        $country_zones = preg_split("/[,]/", $countries_table);
        if (in_array($dest_country, $country_zones)) {
          $dest_zone = $i;
          break;
        }
      }
	  
	 
      if ($dest_zone == 0) {
        $error = true;
      } else {
        $shipping = -1;
        $chplet_cost = constant('MODULE_SHIPPING_CHPLET_COST_' . $i);

        $chplet_table = preg_split("/[:,]/" , $chplet_cost);
        for ($i=0; $i<sizeof($chplet_table); $i+=2) {
          if ($shipping_weight <= $chplet_table[$i]) {
            $shipping = $chplet_table[$i+1];
            $shipping_method = MODULE_SHIPPING_CHPLET_TEXT_WAY . ' ' . $dest_country . ' : ' . $shipping_weight . ' ' . MODULE_SHIPPING_CHPLET_TEXT_UNITS;
            break;
          }
        }

        if ($shipping == -1) {
          $shipping_cost = 0;
          $shipping_method = MODULE_SHIPPING_CHPLET_UNDEFINED_RATE;
        } else {
          $shipping_cost = ($shipping + MODULE_SHIPPING_CHPLET_HANDLING);
        }
      }

      $this->quotes = array('id' => $this->code,
                            'module' => MODULE_SHIPPING_CHPLET_TEXT_TITLE,
                            'methods' => array(array('id' => $this->code,
                                                     'title' => $shipping_method . ' (' . $shipping_num_boxes . ' x ' . $shipping_weight . ' ' . MODULE_SHIPPING_CHPLET_TEXT_UNITS .')',
                                                     'cost' => $shipping_cost * $shipping_num_boxes)));

      if ($this->tax_class > 0) {
        $this->quotes['tax'] = tep_get_tax_rate($this->tax_class, $order->delivery['country']['id'], $order->delivery['zone_id']);
      }

      if (tep_not_null($this->icon)) $this->quotes['icon'] = tep_image($this->icon, $this->title);

      if ($error == true) $this->quotes['error'] = MODULE_SHIPPING_CHPLET_INVALID_ZONE;

      return $this->quotes;
    }

    function check() {
      if (!isset($this->_check)) {
        $check_query = tep_db_query("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_SHIPPING_CHPLET_STATUS'");
        $this->_check = tep_db_num_rows($check_query);
      }
      return $this->_check;
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Schweizerische Post - Brief Inland', 'MODULE_SHIPPING_CHPLET_STATUS', 'True', 'Wollen Sie die Versandart Brief Inland via Schweizerische Post anbieten?', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Handling Fee', 'MODULE_SHIPPING_CHPLET_HANDLING', '0', 'Bearbeitungsgeb�hr f�r diese Versandart in CHF', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Steuersatz', 'MODULE_SHIPPING_CHPLET_TAX_CLASS', '0', 'W�hlen Sie den MwSt.-Satz f�r diese Versandart aus.', '6', '0', 'tep_get_tax_class_title', 'tep_cfg_pull_down_tax_classes(', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Versand Zone', 'MODULE_SHIPPING_CHPLET_ZONE', '0', 'Wenn Sie eine Zone ausw�hlen, wird diese Versandart nur in dieser Zone angeboten.', '6', '0', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Reihenfolge der Anzeige', 'MODULE_SHIPPING_CHPLET_SORT_ORDER', '0', 'Niedrigste wird zuerst angezeigt.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Zone Inland', 'MODULE_SHIPPING_CHPLET_COUNTRIES_1', 'CH', 'Inlandszone', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Zone Tarif Tabelle bis 2 kg', 'MODULE_SHIPPING_CHPLET_COST_1', '0.1:0.85,0.25:1.10,0.5:1.80,1:4.50', 'Tarif Tabelle f�r die Inlandszone, Brief bis 2 kg Versandgewicht.', '6', '0', now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      $keys = array('MODULE_SHIPPING_CHPLET_STATUS', 'MODULE_SHIPPING_CHPLET_HANDLING', 'MODULE_SHIPPING_CHPLET_TAX_CLASS', 'MODULE_SHIPPING_CHPLET_ZONE', 'MODULE_SHIPPING_CHPLET_SORT_ORDER');

      for ($i = 1; $i <= $this->num_chplet; $i ++) {
        $keys[count($keys)] = 'MODULE_SHIPPING_CHPLET_COUNTRIES_' . $i;
        $keys[count($keys)] = 'MODULE_SHIPPING_CHPLET_COST_' . $i;
      }

      return $keys;
    }
  }
?>