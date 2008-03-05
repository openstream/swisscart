<?php
/*
  $Id: login.php,v 1.14 2003/06/09 22:46:46 hpdl Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 osCommerce 

  Released under the GNU General Public License 
*/

define('NAVBAR_TITLE', 'Login');
define('HEADING_TITLE', 'Benevenuto, Accedi');

define('HEADING_NEW_CUSTOMER', 'Nuovo Cliente');
define('TEXT_NEW_CUSTOMER', 'Sono un nuovo cliente.');
define('TEXT_NEW_CUSTOMER_INTRODUCTION', 'Creando un nuovo account da ' . STORE_NAME . ' sarai in grado di acquistare velocemente, essere sempre aggiornato sullo stato dei tuoi ordini, e rivedere la cronologia degli ordini che hai effettuato.');

define('HEADING_RETURNING_CUSTOMER', 'Vecchio Cliente');
define('TEXT_RETURNING_CUSTOMER', 'Sono già stato vostro cliente.');

define('TEXT_PASSWORD_FORGOTTEN', 'Dimenticato la password? Clicca qui.');

define('TEXT_LOGIN_ERROR', 'Errore: Nessun indirizzo E-Mail e/o password corrispondenti a quelli inseriti.');
define('TEXT_VISITORS_CART', '<font color="#ff0000"><b>Note:</b></font> Il contenuto del suo &quot;Carrello ospiti&quot; sarà inserito nel suo &quot;Carrello membri&quot; appena accederà tramite il suo account. <a href="javascript:session_win();">[Ulteriorio Informazioni Qui]</a>');

define('HEADING_GUEST_CUSTOMER', 'Purchase without Account');
define('TEXT_GUEST_INTRODUCTION', 'Choose this option if you just want to checkout. You will still need to give us your Billing Address on the following page but we will not create a Password Account for you. <br><br>Please choose <STRONG><font color="#000000">Returning Customer</font></STRONG> if you have already registered your E-Mail address with ' . STORE_NAME . '.');
?>
