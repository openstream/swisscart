<?php
/* $Id$ 
osCommerce, Open Source E-Commerce Solutions 
http://www.oscommerce.com 
Copyright (c) 2002 osCommerce 

Released under the GNU General Public License 
xsell.php
Original Idea From Isaac Mualem im@imwebdesigning.com <mailto:im@imwebdesigning.com>
Complete Recoding From Stephen Walker admin@snjcomputers.com
*/ 

define('CROSS_SELL_SUCCESS', 'Die Verkn&uuml;pfungen f&uuml;r Produkt ID ' . $_GET['add_related_product_ID'] . ' wurden erfolgreich aktualisiert.');
define('SORT_CROSS_SELL_SUCCESS', 'Die Sortierreihenfolge der Verkn&uuml;pfungen f&uuml;r das Hauptprodukt ' .$_GET['add_related_product_ID'] . ' sind erfolgreich aktuallisiert worden.');

/* define('CROSS_SELL_SUCCESS', 'Cross Sell Items Successfully Update For Cross Sell Product #'.$_GET['add_related_product_ID']);
define('SORT_CROSS_SELL_SUCCESS', 'Sort Order Successfully Update For Cross Sell Product #'.$_GET['add_related_product_ID']);
*/

define('HEADING_TITLE', 'Cross-Selling');
define('TABLE_HEADING_PRODUCT_ID', 'Produkt Id');
define('TABLE_HEADING_PRODUCT_MODEL', 'Artikelnummer');
define('TABLE_HEADING_PRODUCT_NAME', 'Produktname');
define('TABLE_HEADING_CURRENT_SELLS', 'Verkn&uuml;pfte Artikel');
define('TABLE_HEADING_UPDATE_SELLS', 'Aktionen');
define('TABLE_HEADING_PRODUCT_IMAGE', 'Artikelbild');
define('TABLE_HEADING_PRODUCT_PRICE', 'Produktpreis');
define('TABLE_HEADING_CROSS_SELL_THIS', 'Bitte ausw&auml;hlen');
define('TEXT_EDIT_SELLS', 'Bearbeiten');
define('TEXT_SORT', 'Anordnen');
define('TEXT_SETTING_SELLS', 'Verkn&uuml;pfungen f&uuml;r den Artikel');
define('TEXT_PRODUCT_ID', 'Produkt Id');
define('TEXT_MODEL', 'Art.nr.');
define('TABLE_HEADING_PRODUCT_SORT', 'Sortierreihenfolge');
define('TEXT_NO_IMAGE', 'Kein Bild');
define('TEXT_CROSS_SELL', 'verkn&uuml;pfen');
define('TEXT_SORT_ORDER', 'Sortierreihenfolge der Verkn&uuml;pfungen von');
?>
