<?php
/*
  $Id: checkout_confirmation.php,v 1.24 2003/02/06 17:38:16 thomasamoulton Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Customized by swisscart®, Swiss Webshop Solutions
  http://www.swisscart.com

  Copyright (c) 2003-2007 osCommerce

  Released under the GNU General Public License
*/

define('NAVBAR_TITLE_1', 'Commander');
define('NAVBAR_TITLE_2', 'Validation');

define('HEADING_TITLE', 'Validation de commande');

define('HEADING_DELIVERY_ADDRESS', 'Adresse de livraison');
define('HEADING_SHIPPING_METHOD', 'Mode de livraison');
define('HEADING_PRODUCTS', 'Produits');
define('HEADING_TAX', 'Taxe');
define('HEADING_TOTAL', 'Total');
define('HEADING_BILLING_INFORMATION', 'Information de facturation');
define('HEADING_BILLING_ADDRESS', 'Adresse de facturation');
define('HEADING_PAYMENT_METHOD', 'Moyen de paiement');
define('HEADING_PAYMENT_INFORMATION', 'Information sur le paiement');
define('HEADING_ORDER_COMMENTS', 'Commentaire sur votre commande');

define('TEXT_EDIT', 'Modifier');

define('CONDITIONS',"Conditions g&eacute;n&eacute;rales de vente");
define('CONDITION_AGREEMENT', "J'ai lu vos <a style=\"text-decoration: underline; color: #CF2F31; \" href=\"javascript:void(0);\" onclick=\"NewWindow('" . tep_href_link('popup_conditions.php') . "','tech','800','600','yes');return false\">conditions g&eacute;n&eacute;rales de vente</a> et je les accepte ");
// Special chars are escaped to use this message text in Javascript-Function alert(unescape("this text"));
// can be found at http://www.salesianer.de/util/alert-umlaute.html
define('CONDITION_AGREEMENT_ERROR', 'Veuillez s%27il vous pla%EEt lire nos conditions generales de vente. Nour pouvons seulement travailler votre ordre si vous acceptez nos conditions.')
?>
