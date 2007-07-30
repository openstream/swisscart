<?php
/*
  $Id: checkout_confirmation.php,v 1.21 2003/07/08 16:56:04 dgw_ Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Customized by swisscart®, Swiss Webshop Solutions
  http://www.swisscart.com

  Copyright (c) 2003-2007 osCommerce

  Released under the GNU General Public License
*/

define('NAVBAR_TITLE_1', 'Realizar Pedido');
define('NAVBAR_TITLE_2', 'Confirmaci&oacute;n');

define('HEADING_TITLE', 'Estoy preparado para Comprar!');

define('HEADING_DELIVERY_ADDRESS', 'Direcci&oacute;n de Entrega');
define('HEADING_SHIPPING_METHOD', 'Forma de Envio');
define('HEADING_PRODUCTS', 'Producto');
define('HEADING_TAX', 'Impuestos');
define('HEADING_TOTAL', 'Total');
define('HEADING_BILLING_INFORMATION', 'Datos de Facturaci&oacute;n');
define('HEADING_BILLING_ADDRESS', 'Direcci&oacute;n de Facturaci&oacute;n');
define('HEADING_PAYMENT_METHOD', 'Forma de Pago');
define('HEADING_PAYMENT_INFORMATION', 'Datos del Pago');
define('HEADING_ORDER_COMMENTS', 'Comentarios Sobre Su Orden');

define('TEXT_EDIT', 'Cambio');

define('CONDITION_AGREEMENT', "He leído las <a style=\"text-decoration: underline; color: #CF2F31; \" href=\"javascript:void(0);\" onclick=\"NewWindow('" . tep_href_link('popup_conditions.php') . "','tech','800','600','yes');return false\">condiciones de uso</a> y las acepto íntegramente.");
define('CONDITIONS', 'Condiciones y términos de uso.');
define('CONDITION_AGREEMENT_ERROR', "Lea detenidamente nuestras condiciones de uso, sí no las acepta, su pedido no será cursado.");
?>