<?php
/*
  $Id: coupons.php,v 1.0 2006/04/05 Ingo <http://forums.oscommerce.de/index.php?showuser=36>

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2006 osCommerce

  Released under the GNU General Public License
*/

define('HEADING_TITLE', 'Gutscheine');

define('TABLE_HEADING_SORT', 'Sortieren nach');
define('TABLE_HEADING_CODE', 'Code');
define('TABLE_HEADING_NOTICE', 'Bemerkung');
define('TABLE_HEADING_VALUE', 'Wert');
define('TABLE_HEADING_MIN_ORDER', 'Mindestauftrag');
define('TABLE_HEADING_DATE', 'Ablaufdatum');
define('TABLE_HEADING_ACTION', 'Aktion');

define('TEXT_COUPONS_CODE_LENGTH', 'L&auml;nge Code');
define('TEXT_COUPONS_CODE', 'Gutscheincode');
define('TEXT_COUPONS_NOTICE', 'Bemerkung');
define('TEXT_COUPONS_VALUE', 'Couponwert');
define('TEXT_COUPONS_MIN_ORDER', 'Mindestauftrag');
define('TEXT_COUPONS_DATE', 'G&uuml;ltig bis:<br><small>(dd.mm.yyyy)</small>');
define('TEXT_COUPONS_TIP', '<b>Bemerkung:</b><ul><li>Sie k&ouml;nnen den Wert mit Punkt oder Komma eingeben</li><li>Gutscheinwerte kleiner <i>0,01</i> werden <b>nicht</b> akzeptiert</li><li>Lassen Sie das Feld <b>\'Gültig bis\'</b> leer, wenn der Gutschein nur <b>heute</b> gilt</li><li>Um den Code eines neuen Gutscheins zu &auml;ndern, aktualisieren Sie Ihren Browser</ul>');

define('ERROR_COUPON_EXIST', 'Fehler bei der Erstellung des Codes: existiert bereits.');
define('ERROR_COUPON_CODE', 'Fehler bei der Erstellung des Codes: unzul&auml;ssiger Code.');
define('TEXT_DISPLAY_NUMBER_OF_COUPONS', 'Angezeigt werden <b>%d</b> bis <b>%d</b> (von insgesamt <b>%d</b> Gutscheinen)');

define('TEXT_INFO_HEADING_DELETE_COUPONS', 'Gutschein l&ouml;schen');
define('TEXT_INFO_DELETE_INTRO', 'Sind Sie sicher, dass Sie den Gutschein l&ouml;schen m&ouml;chten?');
?>
