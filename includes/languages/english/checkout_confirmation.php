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

define('NAVBAR_TITLE_1', 'Checkout');
define('NAVBAR_TITLE_2', 'Confirmation');

define('HEADING_TITLE', 'Order Confirmation');

define('HEADING_DELIVERY_ADDRESS', 'Delivery Address');
define('HEADING_SHIPPING_METHOD', 'Shipping Method');
define('HEADING_PRODUCTS', 'Products');
define('HEADING_TAX', 'Tax');
define('HEADING_TOTAL', 'Total');
define('HEADING_SHIPPING_INFORMATION', 'Shipping Information');
define('HEADING_BILLING_INFORMATION', 'Billing Information');
define('HEADING_BILLING_ADDRESS', 'Billing Address');
define('HEADING_PAYMENT_METHOD', 'Payment Method');
define('HEADING_PAYMENT_INFORMATION', 'Payment Information');
define('HEADING_ORDER_COMMENTS', 'Comments About Your Order');

define('TEXT_EDIT', 'Edit');

define('CONDITION_AGREEMENT', "I have read the <a style=\"text-decoration: underline; color: #CF2F31; \" href=\"javascript:void(0);\" onclick=\"NewWindow('" . tep_href_link('popup_conditions.php') . "','tech','800','600','yes');return false\">conditions of use</a> and I agree to them.");
define('CONDITIONS', 'Terms & Conditions');
define('CONDITION_AGREEMENT_ERROR', "Please read our conditions of use and agree to them. If you do not do so, your order will not be processed.");
?>
