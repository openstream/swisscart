<?php
/*
  $Id: login.php,v 1.18 2003/07/08 16:56:04 dgw_ Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Customized by swisscart®, Swiss Webshop Solutions
  http://www.swisscart.com

  Copyright (c) 2003-2007 osCommerce

  Released under the GNU General Public License
*/

define('NAVBAR_TITLE', 'Entrar');
define('HEADING_TITLE', 'Dejame Entrar!');

define('HEADING_NEW_CUSTOMER', 'Nuevo Cliente');
define('TEXT_NEW_CUSTOMER', 'Soy un nuevo cliente.');
define('TEXT_NEW_CUSTOMER_INTRODUCTION', 'Al crear una cuenta en ' . STORE_NAME . ' podrá realizar sus compras rapidamente, revisar el estado de sus pedidos y consultar sus operaciones anteriores.');

define('HEADING_RETURNING_CUSTOMER', 'Ya Soy Cliente');
define('TEXT_RETURNING_CUSTOMER', 'He comprado otras veces.');

define('TEXT_PASSWORD_FORGOTTEN', '&iquest;Ha olvidado su contrase&ntilde;a? Siga este enlace y se la enviamos.');

define('TEXT_LOGIN_ERROR', 'Error: El E-Mail y/o Contrase&ntilde;a no figuran en nuestros datos.');
define('TEXT_VISITORS_CART', '<font color="#ff0000"><b>Nota:</b></font> El contenido de su &quot;Cesta de Visitante&quot; ser&aacute; a&ntilde;adido a su &quot;Cesta de Asociado&quot; una vez que haya entrado. <a href="javascript:session_win();">[M&aacute;s Informaci&oacute;n]</a>');

define('HEADING_GUEST_CUSTOMER', 'Compra sin quenta');
define('TEXT_GUEST_INTRODUCTION', 'Choose this option if you just want to checkout. You will still need to give us your Billing Address on the following page but we will not create a Password Account for you. <br><br>Please choose <STRONG><font color="#000000">Returning Customer</font></STRONG> if you have already registered your E-Mail address with ' . STORE_NAME . '.');
?>
