<?php
/*
  $Id: checkout_confirmation.php,v 1.27 2003/02/16 00:42:02 harley_vb Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Customized by swisscart®, Swiss Webshop Solutions
  http://www.swisscart.com

  Copyright (c) 2003-2007 osCommerce

  Released under the GNU General Public License
*/

define('NAVBAR_TITLE_1', 'Kasse');
define('NAVBAR_TITLE_2', 'Best&auml;tigung');

define('HEADING_TITLE', 'Bestellung abschicken:');

define('HEADING_DELIVERY_ADDRESS', 'Versandadresse');
define('HEADING_SHIPPING_METHOD', 'Versandart');
define('HEADING_PRODUCTS', 'Ihre Bestellung');
define('HEADING_TAX', 'MwSt.');
define('HEADING_TOTAL', 'Summe');
define('HEADING_SHIPPING_INFORMATION', 'Versandinformationen');
define('HEADING_BILLING_INFORMATION', 'Rechnungs- und Zahlungsinformationen');
define('HEADING_BILLING_ADDRESS', 'Rechnungsadresse');
define('HEADING_PAYMENT_METHOD', 'Zahlungsweise');
define('HEADING_PAYMENT_INFORMATION', 'Zahlungsinformationen');
define('HEADING_ORDER_COMMENTS', 'Anmerkung zu Ihrer Bestellung');

define('TEXT_EDIT', 'Bearbeiten');

define('CONDITIONS',"Allgemeine Gesch&auml;ftsbedingungen");
define('CONDITION_AGREEMENT', "Ich habe die <a style=\"text-decoration: underline; color: #CF2F31; \" href=\"javascript:void(0);\" onclick=\"NewWindow('" . tep_href_link('popup_conditions.php') . "','tech','800','600','yes');return false\">Allgemeinen Gesch&auml;ftsbedingungen</a> gelesen und akzeptiert ");
// Special chars are escaped to use this message text in Javascript-Function alert(unescape("this text"));
// can be found at http://www.salesianer.de/util/alert-umlaute.html
define('CONDITION_AGREEMENT_ERROR', 'Bitte lesen Sie die allgemeinen Gesch\%E4ftsbedingungen. Nur wenn Sie sie akzeptieren\%2C k\%F6nnen wir Ihre Bestellung entgegen nehmen.')
?>