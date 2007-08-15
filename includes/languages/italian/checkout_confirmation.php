<?php
/*
  $Id: checkout_confirmation.php,v 1.24 2003/02/06 17:38:16 thomasamoulton Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 osCommerce 

  Released under the GNU General Public License 
*/

define('NAVBAR_TITLE_1', 'Acquista');
define('NAVBAR_TITLE_2', 'Conferma');

define('HEADING_TITLE', 'Sono pronto all\' acquisto!');

define('HEADING_DELIVERY_ADDRESS', 'Indirizzo per la consegna');
define('HEADING_SHIPPING_METHOD', 'Metodo di spedizione');
define('HEADING_PRODUCTS', 'Prodotti');
define('HEADING_TAX', 'Tasse');
define('HEADING_TOTAL', 'Totale');
define('HEADING_SHIPPING_INFORMATION', 'Informazioni di spedizione');
define('HEADING_BILLING_INFORMATION', 'Informazioni sulla fattura');
define('HEADING_BILLING_ADDRESS', 'Indirizzo per la fattura');
define('HEADING_PAYMENT_METHOD', 'Metodo di pagamento');
define('HEADING_PAYMENT_INFORMATION', 'Informazioni pagamento');
define('HEADING_ORDER_COMMENTS', 'Commenti riguardo il tuo ordine');

define('TEXT_EDIT', 'Modifica');

define('CONDITIONS',"Condizioni per l'uso");
define('CONDITION_AGREEMENT', "Ho letto gli <a style=\"text-decoration: underline; color: #CF2F31; \" href=\"javascript:void(0);\" onclick=\"NewWindow('" . tep_href_link('popup_conditions.php') . "','tech','800','600','yes');return false\">condizioni per l'uso</a> e accosento a loro ");
// Special chars are escaped to use this message text in Javascript-Function alert(unescape("this text"));
// can be found at http://www.salesianer.de/util/alert-umlaute.html
define('CONDITION_AGREEMENT_ERROR', 'Leggere prego i nostri condizioni per l%27uso e accosentiree a loro. Se non fate cos%EC%2C il vostro ordine non sar%E0 proceduto.')
?>