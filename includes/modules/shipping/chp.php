<?php
/*
  $Id: chp.php,v 1.02 2003/02/18 03:37:00 harley_vb Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 - 2003 osCommerce

  Released under the GNU General Public License

  Copyright (C) 2001 - 2003 TheMedia, Dipl.-Ing Thomas Plänkers
  http://www.themedia.at & http://www.oscommerce.at
*/

  class chp {
    var $code, $title, $description, $icon, $enabled, $num_chp, $types;

// class constructor
    function chp() {
      global $order;

      $this->code = 'chp';
      $this->title = MODULE_SHIPPING_CHP_TEXT_TITLE;
      $this->description = MODULE_SHIPPING_CHP_TEXT_DESCRIPTION;
      $this->sort_order = MODULE_SHIPPING_CHP_SORT_ORDER;
      $this->icon = DIR_WS_ICONS . 'shipping_chp.gif';
      $this->tax_class = MODULE_SHIPPING_CHP_TAX_CLASS;
      $this->enabled = ((MODULE_SHIPPING_CHP_STATUS == 'True') ? true : false);

      if ( ($this->enabled == true) && ((int)MODULE_SHIPPING_CHP_ZONE > 0) ) {
        $check_flag = false;
        $check_query = tep_db_query("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_SHIPPING_CHP_ZONE . "' and zone_country_id = '" . $order->delivery['country']['id'] . "' order by zone_id");
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

      $this->types = array('ECO' => 'Economy',
                           'PRI' => 'Priority',
                           'URG' => 'Urgent');

      // CUSTOMIZE THIS SETTING FOR THE NUMBER OF ZONES NEEDED
      $this->num_chp = 7;
    }

// class methods
    function quote($method = '') {
      global $HTTP_POST_VARS, $order, $shipping_weight, $shipping_num_boxes;

      $dest_country = $order->delivery['country']['iso_code_2'];
      $dest_zone = 0;
      $error = false;

      for ($j=1; $j<=$this->num_chp; $j++) {
        $countries_table = constant('MODULE_SHIPPING_CHP_COUNTRIES_' . $j);
        $country_zones = preg_split("/[,]/", $countries_table);
        if (in_array($dest_country, $country_zones)) {
          $dest_zone = $j;
          break;
        }
      }

      if ($dest_zone == 0) {
        $error = true;
      } else {
        $shipping = -1;
        $chp_cost_eco = @constant('MODULE_SHIPPING_CHP_COST_ECO_' . $j);
        $chp_cost_pri = @constant('MODULE_SHIPPING_CHP_COST_PRI_' . $j);
        $chp_cost_urg = @constant('MODULE_SHIPPING_CHP_COST_URG_' . $j);

        $methods = array();

        if ($chp_cost_eco != '') {
          $chp_table_eco = preg_split("/[:,]/" , $chp_cost_eco);

          for ($i=0; $i<sizeof($chp_table_eco); $i+=2) {
            if ($shipping_weight <= $chp_table_eco[$i]) {
              $shipping_eco = $chp_table_eco[$i+1];
              break;
            }
          }

          if ($shipping_eco == -1) {
            $shipping_cost = 0;
            $shipping_method = MODULE_SHIPPING_CHP_UNDEFINED_RATE;
          } else {
            $shipping_cost_1 = ($shipping_eco + MODULE_SHIPPING_CHP_HANDLING);
          }

          if ($shipping_eco != 0) {
            $methods[] = array('id' => 'ECO',
                               'title' => 'Economy',
                               'cost' => (MODULE_SHIPPING_CHP_HANDLING + $shipping_cost_1) * $shipping_num_boxes);
          }
        }

        if ($chp_cost_pri != '') {
          $chp_table_pri = preg_split("/[:,]/" , $chp_cost_pri);

          for ($i=0; $i<sizeof($chp_table_pri); $i+=2) {
            if ($shipping_weight <= $chp_table_pri[$i]) {
              $shipping_pri = $chp_table_pri[$i+1];
              break;
            }
          }

          if ($shipping_pri == -1) {
            $shipping_cost = 0;
            $shipping_method = MODULE_SHIPPING_CHP_UNDEFINED_RATE;
          } else {
            $shipping_cost_2 = ($shipping_pri + MODULE_SHIPPING_CHP_HANDLING);
          }

          if ($shipping_pri != 0) {
            $methods[] = array('id' => 'PRI',
                               'title' => 'Priority',
                               'cost' => (MODULE_SHIPPING_CHP_HANDLING + $shipping_cost_2) * $shipping_num_boxes);
          }
        }  

        if ($chp_cost_urg != '') {
          $chp_table_urg = preg_split("/[:,]/" , $chp_cost_urg);

          for ($i=0; $i<sizeof($chp_table_urg); $i+=2) {
            if ($shipping_weight <= $chp_table_urg[$i]) {
              $shipping_urg = $chp_table_urg[$i+1];
              break;
            }
          }

          if ($shipping_urg == -1) {
            $shipping_cost = 0;
            $shipping_method = MODULE_SHIPPING_CHP_UNDEFINED_RATE;
          } else {
            $shipping_cost_3 = ($shipping_urg + MODULE_SHIPPING_CHP_HANDLING);
          }

          if ($shipping_urg != 0) {
            $methods[] = array('id' => 'URG',
                               'title' => 'Urgent',
                               'cost' => (MODULE_SHIPPING_CHP_HANDLING + $shipping_cost_3) * $shipping_num_boxes);
          }
        }
      }

      $this->quotes = array('id' => $this->code,
                            'module' => $this->title . ' (' . $shipping_num_boxes . ' x ' . $shipping_weight . ' ' . MODULE_SHIPPING_CHP_TEXT_UNITS .')');
      $this->quotes['methods'] = $methods;

      if ($this->tax_class > 0) {
        $this->quotes['tax'] = tep_get_tax_rate($this->tax_class, $order->delivery['country']['id'], $order->delivery['zone_id']);
      }

      if (tep_not_null($this->icon)) $this->quotes['icon'] = tep_image($this->icon, $this->title);

      if ($error == true) $this->quotes['error'] = MODULE_SHIPPING_CHP_INVALID_ZONE;

      if ( (tep_not_null($method)) && (isset($this->types[$method])) ) {

        for ($i=0; $i<sizeof($methods); $i++) {
          if ($method == $methods[$i]['id']) {
            $methodsc = array();
            $methodsc[] = array('id' => $methods[$i]['id'],
                                'title' => $methods[$i]['title'],
                                'cost' => $methods[$i]['cost']);
            break;
          }
        }
        $this->quotes['methods'] = $methodsc;
      }

      return $this->quotes;
    }

    function check() {
      if (!isset($this->_check)) {
        $check_query = tep_db_query("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_SHIPPING_CHP_STATUS'");
        $this->_check = tep_db_num_rows($check_query);
      }
      return $this->_check;
    }

    function install() {
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Schweizerische Post', 'MODULE_SHIPPING_CHP_STATUS', 'True', 'Wollen Sie den Versand über die schweizerische Post anbieten?', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Handling Fee', 'MODULE_SHIPPING_CHP_HANDLING', '0', 'Bearbeitungsgebühr für diese Versandart in CHF', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Steuersatz', 'MODULE_SHIPPING_CHP_TAX_CLASS', '0', 'Wählen Sie den MwSt.-Satz für diese Versandart aus.', '6', '0', 'tep_get_tax_class_title', 'tep_cfg_pull_down_tax_classes(', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Versand Zone', 'MODULE_SHIPPING_CHP_ZONE', '0', 'Wenn Sie eine Zone auswählen, wird diese Versandart nur in dieser Zone angeboten.', '6', '0', 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Reihenfolge der Anzeige', 'MODULE_SHIPPING_CHP_SORT_ORDER', '0', 'Niedrigste wird zuerst angezeigt.', '6', '0', now())");

      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tarifzone 0 Länder', 'MODULE_SHIPPING_CHP_COUNTRIES_1', 'CH,LI', 'Inlandszone', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 0 bis 30 kg ECO', 'MODULE_SHIPPING_CHP_COST_ECO_1', '2:6.00,5:8.00,10:11.00,20:16.00,30:23.00', 'Tarif Tabelle für die Inlandszone, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 0 bis 30 kg PRI', 'MODULE_SHIPPING_CHP_COST_PRI_1', '2:8.00,5:10.00,10:13.00,20:19.00,30:26.00', 'Tarif Tabelle für die Inlandszone, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tarifzone 1 Länder', 'MODULE_SHIPPING_CHP_COUNTRIES_2', 'AD,AT,BE,FR,DE,VA,IT,LU,MC,NL', 'Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 1 sind.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 1 bis 30 kg ECO', 'MODULE_SHIPPING_CHP_COST_ECO_2', '2:37,5:45,10:43,15:48,20:53,25:58,26:59,30:63', 'Tarif Tabelle für die Zone 1, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 1 bis 30 kg PRI', 'MODULE_SHIPPING_CHP_COST_PRI_2', '2:41,5:51,10:59,15:70,20:75,25:74,30:86', 'Tarif Tabelle für die Zone 1, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 1 bis 30 kg URG', 'MODULE_SHIPPING_CHP_COST_URG_2', '0.5:65,1:72,1.5:77,2:82,2.5:88,3:94,3.5:102,4:109,4.5:116,5:123,6:129,7:134,8:140,9:146,10:152,11:160,12:168,13:177,14:185,15:193,16:202,17:210,18:219,19:228,20:236,21:245,22:253,23:263,24:271,25:279,26:288,27:297,28:306,29:315,30:324', 'Tarif Tabelle für die Zone 1, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tarifzone 2 Länder', 'MODULE_SHIPPING_CHP_COUNTRIES_3', 'AL,BA,BG,HR,CZ,DK,EE,FI,GI,GR,HU,IS,IE,LV,LT,MK,MT,MH,NO,PL,PT,RO,SK,SI,ES,SE,GB,YU', 'Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 2 sind.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 2 bis 30 kg ECO', 'MODULE_SHIPPING_CHP_COST_ECO_3', '2:34,3:38,4:42,5:46,6:49,7:52,8:55,9:58,10:61,11:63,12:65,13:67,14:69,15:71,16:72,17:73,18:74,19:75,20:76,21:77,22:78,23:79,24:80,25:81,26:82,27:83,28:84,29:85,30:86', 'Tarif Tabelle für die Zone 2, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 2 bis 30 kg PRI', 'MODULE_SHIPPING_CHP_COST_PRI_3', '2:38,3:43,4:48,5:53,6:58,7:62,8:66,9:68,10:71,11:75,12:78,13:81,14:84,15:87,16:90,17:91,18:92,19:93,20:94,21:95,22:96,23:97,24:98,25:99,26:100,27:101,28:102,29:103,30:104', 'Tarif Tabelle für die Zone 2, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 2 bis 30 kg URG', 'MODULE_SHIPPING_CHP_COST_URG_3', '0.5:57,1:63,1.5:68,2:73,2.5:78,3:84,3.5:90,4:95,4.5:100,5:106,6:114,7:124,8:132,9:141,10:149,11:158,12:165,13:172,14:180,15:187,16:196,17:203,18:210,19:218,20:226,21:234,22:241,23:248,24:256,25:264,26:272,27:279,28:286,29:295,30:302', 'Tarif Tabelle für die Zone 2, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tarifzone 3 Länder', 'MODULE_SHIPPING_CHP_COUNTRIES_4', 'DZ,BY,CA,CY,EG,IL,JO,LB,LY,MD,MA,RU,PM,SY,TN,TR,UA,US', 'Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 3 sind.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 3 bis 30 kg ECO', 'MODULE_SHIPPING_CHP_COST_ECO_4', '2:38,3:44,4:50,5:56,6:62,7:68,8:74,9:80,10:86,11:92,12:98,13:104,14:110,15:116,16:121,17:126,18:131,19:136,20:141,21:145,22:149,23:153,24:157,25:161,26:165,27:169,28:173,29:177,30:181', 'Tarif Tabelle für die Zone 3, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 3 bis 30 kg PRI', 'MODULE_SHIPPING_CHP_COST_PRI_4', '2:46,3:55,4:66,5:77,6:86,7:95,8:104,9:113,10:122,11:130,12:138,13:146,14:154,15:162,16:170,17:178,18:186,19:194,20:202,21:209,22:216,23:223,24:230,25:237,26:244,27:251,28:258,29:265,30:272', 'Tarif Tabelle für die Zone 3, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 3 bis 30 kg URG', 'MODULE_SHIPPING_CHP_COST_URG_4', '0.5:65,1:72,1.5:79,2:87,2.5:94,3:101,3.5:108,4:115,4.5:123,5:130,6:141,7:152,8:164,9:175,10:186,11:198,12:209,13:220,14:232,15:243,16:254,17:266,18:277,19:288,20:300,21:309,22:318,23:328,24:337,25:346,26:355,27:365,28:374,29:383,30:392', 'Tarif Tabelle für die Zone 3, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tarifzone 4 Länder', 'MODULE_SHIPPING_CHP_COUNTRIES_5', 'AF,AO,AI,AG,AM,AZ,BS,BH,BD,BB,BZ,BJ,BM,BT,BW,BF,BI,KY,KH,CM,CV,CF,TD,CN,KM,CG,CR,CI,CU,DJ,DM,DO,SV,GQ,ER,ET,GA,GM,GE,GH,GD,GP,GT,GN,GW,HT,HN,HK,IN,IR,IQ,JM,JP,YE,KZ,KE,KP,KR,KW,KG,LA,LS', 'Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 4 sind.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 4 bis 30 kg ECO', 'MODULE_SHIPPING_CHP_COST_ECO_5', '2:43,3:50,4:57,5:64,6:71,7:78,8:85,9:92,10:99,11:104,12:109,13:114,14:119,15:124,16:129,17:134,18:139,19:144,20:149,21:153,22:157,23:161,24:165,25:169,26:173,27:177,28:181,29:185,30:189', 'Tarif Tabelle für die Zone 4, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 4 bis 30 kg PRI', 'MODULE_SHIPPING_CHP_COST_PRI_5', '2:53,3:67,4:80,5:94,6:107,7:120,8:133,9:146,10:159,11:167,12:177,13:187,14:197,15:207,16:215,17:223,18:231,19:239,20:247,21:255,22:263,23:271,24:279,25:287,26:295,27:303,28:311,29:319,30:327', 'Tarif Tabelle für die Zone 4, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 4 bis 30 kg URG', 'MODULE_SHIPPING_CHP_COST_URG_5', '0.5:83,1:96,1.5:108,2:121,2.5:133,3:145,3.5:158,4:170,4.5:182,5:195,6:214,7:234,8:253,9:273,10:293,11:311,12:330,13:348,14:367,15:385,16:404,17:422,18:441,19:459,20:478,21:495,22:513,23:530,24:548,25:565,26:583,27:600,28:618,29:636,30:653', 'Tarif Tabelle für die Zone 4, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tarifzone 4 Länder', 'MODULE_SHIPPING_CHP_COUNTRIES_6', 'LR,MO,MG,MW,MY,MV,ML,MQ,MR,MU,YT,MX,MN,MS,MZ,MM,NA,NP,NI,NE,NG,OM,PK,PA,QA,RE,RW,KN,LC,VC,SH,ZM,SM,ST,SA,SN,SC,SL,SG,SO,ZA,LK,SD,SZ,TW,TJ,TZ,TH,TG,TM,TC,UG,AE,UZ,VN,VG,VI,ZW', 'Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 4 sind.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 4 bis 30 kg ECO', 'MODULE_SHIPPING_CHP_COST_ECO_6', '2:43,3:50,4:57,5:64,6:71,7:78,8:85,9:92,10:99,11:104,12:109,13:114,14:119,15:124,16:129,17:134,18:139,19:144,20:149,21:153,22:157,23:161,24:165,25:169,26:173,27:177,28:181,29:185,30:189', 'Tarif Tabelle für die Zone 4, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 4 bis 30 kg PRI', 'MODULE_SHIPPING_CHP_COST_PRI_6', '2:53,3:67,4:80,5:94,6:107,7:120,8:133,9:146,10:159,11:167,12:177,13:187,14:197,15:207,16:215,17:223,18:231,19:239,20:247,21:255,22:263,23:271,24:279,25:287,26:295,27:303,28:311,29:319,30:327', 'Tarif Tabelle für die Zone 4, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 4 bis 30 kg URG', 'MODULE_SHIPPING_CHP_COST_URG_6', '0.5:83,1:96,1.5:108,2:121,2.5:133,3:145,3.5:158,4:170,4.5:182,5:195,6:214,7:234,8:253,9:273,10:293,11:311,12:330,13:348,14:367,15:385,16:404,17:422,18:441,19:459,20:478,21:495,22:513,23:530,24:548,25:565,26:583,27:600,28:618,29:636,30:653', 'Tarif Tabelle für die Zone 4, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tarifzone 5 Länder', 'MODULE_SHIPPING_CHP_COUNTRIES_7', 'AR,AW,AU,BO,BR,BN,CL,CO,CK,EC,FK,FJ,GF,PF,GY,ID,KI,NR,AN,NC,NZ,NF,PG,PY,PE,PH,PN,WS,SB,SR,TP,TO,TT,TV,UY,VU,VE,WF', 'Durch Komma getrennt Liste der Länder als zwei Zeichen ISO-Code Landeskennzahlen, die Teil der Zone 5 sind.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 5 bis 30 kg ECO', 'MODULE_SHIPPING_CHP_COST_ECO_7', '2:47,3:55,4:63,5:71,6:79,7:87,8:95,9:103,10:111,11:118,12:125,13:132,14:139,15:146,16:152,17:160,18:166,19:172,20:178,21:184,22:190,23:196,24:202,25:206,26:211,27:216,28:221,29:226,30:231', 'Tarif Tabelle für die Zone 5, basiered auf <b>\'ECO\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 5 bis 30 kg PRI', 'MODULE_SHIPPING_CHP_COST_PRI_7', '2:65,3:83,4:101,5:119,6:136,7:153,8:170,9:187,10:204,11:219,12:234,13:249,14:264,15:279,16:294,17:309,18:324,19:339,20:354,21:367,22:380,23:393,24:406,25:419,26:432,27:445,28:458,29:471,30:484', 'Tarif Tabelle für die Zone 5, basiered auf <b>\'PRI\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
      tep_db_query("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Tariftabelle für Zone 5 bis 30 kg URG', 'MODULE_SHIPPING_CHP_COST_URG_7', '0.5:92,1:106,1.5:121,2:135,2.5:149,3:164,3.5:178,4:193,4.5:207,5:221,6:241,7:261,8:280,9:300,10:319,11:338,12:356,13:375,14:393,15:412,16:431,17:449,18:468,19:486,20:505,21:522,22:540,23:557,24:575,25:592,26:610,27:627,28:645,29:662,30:680', 'Tarif Tabelle für die Zone 5, basiered auf <b>\'URG\'</b> bis 30 kg Versandgewicht.', '6', '0', now())");
    }

    function remove() {
      tep_db_query("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      $keys = array('MODULE_SHIPPING_CHP_STATUS', 'MODULE_SHIPPING_CHP_HANDLING', 'MODULE_SHIPPING_CHP_TAX_CLASS', 'MODULE_SHIPPING_CHP_ZONE', 'MODULE_SHIPPING_CHP_SORT_ORDER');

      for ($i=1; $i <= $this->num_chp; $i++) {
        $keys[count($keys)] = 'MODULE_SHIPPING_CHP_COUNTRIES_' . $i;
        $keys[count($keys)] = 'MODULE_SHIPPING_CHP_COST_ECO_' . $i;
        $keys[count($keys)] = 'MODULE_SHIPPING_CHP_COST_PRI_' . $i;
        $keys[count($keys)] = 'MODULE_SHIPPING_CHP_COST_URG_' . $i;
      }

      return $keys;
    }
  }
?>