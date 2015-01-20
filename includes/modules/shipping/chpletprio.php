<?php
/*
  $Id: chpletprio.php,v 1.05 2003/02/18 03:37:00 harley_vb Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 - 2003 osCommerce

  Released under the GNU General Public License

  Copyright (C) 2002 - 2003 TheMedia, Dipl.-Ing Thomas Plänkers
  http://www.themedia.at & http://www.oscommerce.at
*/

  class chpletprio {
    var $code, $title, $description, $icon, $enabled, $num_chpletprio;

// class constructor
    function chpletprio() {
      global $order;

      $this->code = 'chpletprio';
      $this->title = MODULE_SHIPPING_CHPLETPRIO_TEXT_TITLE;
      $this->description = MODULE_SHIPPING_CHPLETPRIO_TEXT_DESCRIPTION;
      $this->sort_order = MODULE_SHIPPING_CHPLETPRIO_SORT_ORDER;
      $this->icon = DIR_WS_ICONS . 'shipping_chp.gif';
      $this->tax_class = MODULE_SHIPPING_CHPLETPRIO_TAX_CLASS;
      $this->enabled = ((MODULE_SHIPPING_CHPLETPRIO_STATUS == 'True') ? true : false);

      if ( ($this->enabled == true) && ((int)MODULE_SHIPPING_CHPLETPRIO_ZONE > 0) ) {
        $check_flag = false;
        $check_query = tep_db_query("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_SHIPPING_CHPLETPRIO_ZONE . "' and zone_country_id = '" . $order->delivery['country']['id'] . "' order by zone_id");
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
      }

	  // disable module if shipping country does not match shop country
	  if ($order->delivery['zone_id'] != STORE_COUNTRY) $this->enabled = false;	

      // CUSTOMIZE THIS SETTING FOR THE NUMBER OF ZONES NEEDED
      $this->num_chpletprio = 2;
    }

// class methods
    function quote($method = '') {
      global $HTTP_POST_VARS, $order, $shipping_weight, $shipping_num_boxes;

      $dest_country = $order->delivery['country']['iso_code_2'];
      $dest_zone = 0;
      $error = false;

      for ($i=1; $i<=$this->num_chpletprio; $i++) {
        $countries_table = constant('MODULE_SHIPPING_CHPLETPRIO_COUNTRIES_' . $i);
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
        $chpletprio_cost = constant('MODULE_SHIPPING_CHPLETPRIO_COST_' . $i);

        $chpletprio_table = preg_split("/[:,]/" , $chpletprio_cost);
        for ($i=0; $i<sizeof($chpletprio_table); $i+=2) {
          if ($shipping_weight <= $chpletprio_table[$i]) {
            $shipping = $chpletprio_table[$i+1];
            $shipping_method = MODULE_SHIPPING_CHPLETPRIO_TEXT_WAY . ' ' . $dest_country . ' : ' . $shipping_weight . ' ' . MODULE_SHIPPING_CHPLETPRIO_TEXT_UNITS;
            break;
          }
        }

        if ($shipping == -1) {
          $shipping_cost = 0;
          $shipping_method = MODULE_SHIPPING_CHPLETPRIO_UNDEFINED_RATE;
        } else {
          $shipping_cost = ($shipping + MODULE_SHIPPING_CHPLETPRIO_HANDLING);
        }
      }

      $this->quotes = array('id' => $this->code,
                            'module' => MODULE_SHIPPING_CHPLETPRIO_TEXT_TITLE,
                            'methods' => array(array('id' => $this->code,
                                                     'title' => $shipping_method . ' (' . $shipping_num_boxes . ' x ' . $shipping_weight . ' ' . MODULE_SHIPPING_CHPLETPRIO_TEXT_UNITS .')',
                                                     'cost' => $shipping_cost * $shipping_num_boxes)));

      if ($this->tax_class > 0) {
        $this->quotes['tax'] = tep_get_tax_rate($this->tax_class, $order->delivery['country']['id'], $order->delivery['zone_id']);
      }

      if (tep_not_null($this->icon)) $this->quotes['icon'] = tep_image($this->icon, $this->title);

      if ($error == true) $this->quotes['error'] = MODULE_SHIPPING_CHPLETPRIO_INVALID_ZONE;

      return $this->quotes;
    }

    function check() {
      if (!isset($this->_check)) {
        $check_query = tep_db_query("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_SHIPPING_CHPLETPRIO_STATUS'");
        $this->_check = tep_db_num_rows($check_query);
      }
      return $this->_check;
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Schweizerische Post - Brief priority', 'MODULE_SHIPPING_CHPLETPRIO_STATUS', 'True', 'Wollen Sie die Versandart Brief priority via Schweizerische Post anbieten?', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Bearbeitungsgebühr', 'MODULE_SHIPPING_CHPLETPRIO_HANDLING', '0', 'Bearbeitungsgebühr für diese Versandart in Euro', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Steuersatz', 'MODULE_SHIPPING_CHPLETPRIO_TAX_CLASS', '0', 'Wählen Sie den MwSt.-Satz für diese Versandart aus.', '6', '0', 'tep_get_tax_class_title', 'tep_cfg_pull_down_tax_classes(', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Versand Zone', 'MODULE_SHIPPING_CHPLETPRIO_ZONE', '0', 'Wenn Sie eine Zone auswählen, wird diese Versandart nur in dieser Zone angeboten.', '6', '0', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Reihenfolge der Anzeige', 'MODULE_SHIPPING_CHPLETPRIO_SORT_ORDER', '0', 'Niedrigste wird zuerst angezeigt.', '6', '0', now())");

      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Zone Europa Länder', 'MODULE_SHIPPING_CHPLETPRIO_COUNTRIES_1', 'AL,AD,AM,AZ,BE,BA,BG,DK,FO,GL,DE,EE,FI,FR,GP,GF,MQ,YT,RE,GE,GI,GR,GB,GG,JE,IM,IE,IS,IT,HR,LV,LI,LT,LU,MK,MD,MC,NL,NO,PL,PT,RO,RU,SM,SE,AT,PM,YU,SI,SK,ES,TR,VA,CY,HU,UA,CZ,BY,IC', 'Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone Europa sind.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Zone Europa Tarif Tabelle bis 2 kg', 'MODULE_SHIPPING_CHPLETPRIO_COST_1', '0.10:3.60,0.25:6.20,0.50:11.50,1.00:21.00,2.00:32', 'Tarif Tabelle für die Zone Europa, basiered auf <b>\'Brief Priority\'</b> bis 2 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Zone Welt Länder', 'MODULE_SHIPPING_CHPLETPRIO_COUNTRIES_2', 'SE,EG,DZ,IL,LB,LY,MT,MA,SY,TN,ET,BH,BJ,BF,CI,DJ,ER,GM,GH,GU,GN,GW,IQ,IR,YE,JO,CM,CA,CV,KZ,QA,KG,KW,LR,ML,MH,MR,FM,NE,NG,MP,OM,PR,SA,SN,SL,SO,SD,TJ,TG,TD,TM,UZ,AE,US,UM,CF,AF,AO,AI,AG,GQ,AR,BS,BD,BB,BZ,BM,BT,BO,BW,BR,BN,BI,KY,CL,CN,CR,DM,DO,EC,SV,FK,GA,GD,GT,GY,HT,HN,HK,IN,ID,TP,JM,JP,KH,KE,CO,KM,CG,KP,KR,CU,LA,LS,MO,MG,MW,MY,MV,MU,MX,MN,MS,MZ,MM,NA,NP,NI,AN,AW,PK,PA,PY,PE,PH,RW,ZM,ST,SC,ZW,SG,LK,KN,LC,VC,ZA,SR,SZ,TZ,TH,TT,TC,UG,UY,VE,VN,VG,AU,CK,FJ,PF,KI,NR,NC,NZ,PG,PN,SB,TO,TV,VU,WF,WS', 'Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone Welt sind.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Zone Welt Tarif Tabelle bis 2 kg', 'MODULE_SHIPPING_CHPLETPRIO_COST_2', '0.10:5.00,0.25:8.50,0.50:15.00,1.00:33.00,2.00:45.00', 'Tarif Tabelle für die Zone Welt, basiered auf <b>\'Brief Priority\'</b> bis 2 kg Versandgewicht.', '6', '0', now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      $keys = array('MODULE_SHIPPING_CHPLETPRIO_STATUS', 'MODULE_SHIPPING_CHPLETPRIO_HANDLING', 'MODULE_SHIPPING_CHPLETPRIO_TAX_CLASS', 'MODULE_SHIPPING_CHPLETPRIO_ZONE', 'MODULE_SHIPPING_CHPLETPRIO_SORT_ORDER');

      for ($i = 1; $i <= $this->num_chpletprio; $i ++) {
        $keys[count($keys)] = 'MODULE_SHIPPING_CHPLETPRIO_COUNTRIES_' . $i;
        $keys[count($keys)] = 'MODULE_SHIPPING_CHPLETPRIO_COST_' . $i;
      }

      return $keys;
    }
  }
?>