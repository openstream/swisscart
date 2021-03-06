<?
/*
  $Id: categories.php,v 1.24 2002/08/17 09:43:33 project3000 Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 osCommerce 

  Released under the GNU General Public License 
*/

define('HEADING_TITLE', 'Categorie / Prodotti');
define('HEADING_TITLE_SEARCH', 'Cerca:');
define('HEADING_TITLE_GOTO', 'Vai a:');

define('TABLE_HEADING_ID', 'ID');
define('TABLE_HEADING_CATEGORIES_PRODUCTS', 'Categorie / Prodotti');
define('TABLE_HEADING_ACTION', 'Azione');
define('TABLE_HEADING_SORT_ORDER', 'Ordinamento');
define('TABLE_HEADING_STATUS', 'Stato');

define('TEXT_NEW_PRODUCT', 'Nuovo prodotto in &quot;%s&quot;');
define('TEXT_CATEGORIES', 'Categorie:');
define('TEXT_SUBCATEGORIES', 'Sottocategorie:');
define('TEXT_PRODUCTS', 'Prodotti:');
define('TEXT_PRODUCTS_PRICE_INFO', 'Prezzo:');
define('TEXT_PRODUCTS_TAX_CLASS', 'Tipo di tassa:');
define('TEXT_PRODUCTS_AVERAGE_RATING', 'Valore medio:');
define('TEXT_PRODUCTS_QUANTITY_INFO', 'Quantit�:');
define('TEXT_DATE_ADDED', 'Data inserimento:');
define('TEXT_DATE_AVAILABLE', 'Data disponibilit�:');
define('TEXT_LAST_MODIFIED', 'Ultima modifica:');
define('TEXT_IMAGE_NONEXISTENT', 'L\'IMMAGINE NON ESISTE');
define('TEXT_NO_CHILD_CATEGORIES_OR_PRODUCTS', 'Inserire una nuova categoria o un nuovo prodotto in <br>&nbsp;<br><b>%s</b>');
define('TEXT_PRODUCT_MORE_INFORMATION', 'Per ulteriori informazioni, visitare il <a href="http://%s" target="blank"><u>sito</u></a> di questo prodotto.');
define('TEXT_PRODUCT_DATE_ADDED', 'Questo prodotto � stato aggiunto al catalogo il %s.');
define('TEXT_PRODUCT_DATE_AVAILABLE', 'Questo prodotto sar� disponibile il%s.');

define('TEXT_EDIT_INTRO', 'Eseguire i cambiamenti necessari');
define('TEXT_EDIT_CATEGORIES_ID', 'ID categoria:');
define('TEXT_EDIT_CATEGORIES_NAME', 'Nome categoria:');
define('TEXT_EDIT_CATEGORIES_DESCRIPTION', 'Descrizione categoria:');
define('TEXT_EDIT_CATEGORIES_IMAGE', 'Immagine per la categoria:');
define('TEXT_EDIT_SORT_ORDER', 'Categoria num.:');

define('TEXT_INFO_COPY_TO_INTRO', 'Scegliere la nuova categoria in cui copiare questo prodotto');
define('TEXT_INFO_CURRENT_CATEGORIES', 'Categorie correnti:');

define('TEXT_PRODUCT_META_INFO', 'Meta Tag Information <img src="' . DIR_WS_ICONS . 'help.png' . '" alt="Please click here to toggle the meta tag fields" title="Please click here to toggle the meta tag fields"><br><small>(optional)</small>');
define('TEXT_PRODUCTS_META_INFO2', '<a href="http://en.wikipedia.org/wiki/Meta_element" target="_blank" class="smallLink">Meta Tags</a> are elements used to provide structured metadata about a web page for search engines. If you don\'t fill in the fields this will be done automatically to a certain extent.');
define('TEXT_PRODUCTS_PAGE_TITLE', 'Product Title Tag:');
define('TEXT_PRODUCTS_HEADER_DESCRIPTION', 'Product Description Tag:');
define('TEXT_PRODUCTS_KEYWORDS', 'Product Keywords Tag:');

define('TEXT_INFO_HEADING_NEW_CATEGORY', 'Nuova Categoria');
define('TEXT_INFO_HEADING_EDIT_CATEGORY', 'Modifica Categoria');
define('TEXT_INFO_HEADING_DELETE_CATEGORY', 'Cancella Categoria');
define('TEXT_INFO_HEADING_MOVE_CATEGORY', 'Sposta Categoria');
define('TEXT_INFO_HEADING_DELETE_PRODUCT', 'Cancella Prodotto');
define('TEXT_INFO_HEADING_MOVE_PRODUCT', 'Sposta Prodotto');
define('TEXT_INFO_HEADING_COPY_TO', 'Copia in');

define('TEXT_DELETE_CATEGORY_INTRO', 'Sicuro di voler eliminare questa categoria?');
define('TEXT_DELETE_PRODUCT_INTRO', 'Sicuro di voler eliminare permanentemente questo prodotto?');

define('TEXT_DELETE_WARNING_CHILDS', '<b>ATTENZIONE:</b> Ci sono %s (sotto-)categorie collegate a questa categoria!');
define('TEXT_DELETE_WARNING_PRODUCTS', '<b>ATTENZIONE:</b> Ci sono %s prodotti collegati a questa categoria!');

define('TEXT_MOVE_PRODUCTS_INTRO', 'Seleziona la categoria in cui vuoi spostare il file <b>%s</b>');
define('TEXT_MOVE_CATEGORIES_INTRO', 'Seleziona la categoria in cui vuoi spostare il file <b>%s</b>');
define('TEXT_MOVE', 'Spostare <b>%s</b> in:');

define('TEXT_NEW_CATEGORY_INTRO', 'Inserire le seguenti informazioni per la nuova categoria');
define('TEXT_CATEGORIES_NAME', 'Nome categoria:');
define('TEXT_CATEGORIES_IMAGE', 'Immagine per la categoria:');
define('TEXT_SORT_ORDER', 'Categoria num.:');

define('TEXT_PRODUCTS_STATUS', 'Stato prodotto:');
define('TEXT_PRODUCTS_DATE_AVAILABLE', 'Data disponibilit�:');
define('TEXT_PRODUCT_AVAILABLE', 'Disponibile');
define('TEXT_PRODUCT_NOT_AVAILABLE', 'Esaurito');
define('TEXT_PRODUCTS_MANUFACTURER', 'Produttore:');
define('TEXT_PRODUCTS_NAME', 'Nome prodotto:');
define('TEXT_PRODUCTS_DESCRIPTION', 'Descrizione prodotto:');
define('TEXT_PRODUCTS_QUANTITY', 'Quantit� prodotto:');
define('TEXT_PRODUCTS_MODEL', 'Modello prodotto:');
define('TEXT_PRODUCTS_IMAGE', 'Immagine prodotto:');
define('TEXT_PRODUCTS_IMAGE2', 'Immagine 2:');
define('TEXT_PRODUCTS_IMAGE3', 'Immagine 3:');
define('TEXT_PRODUCTS_IMAGE4', 'Immagine 4:');
define('TEXT_PRODUCTS_IMAGE_REMOVE', 'Remove this Image from this Product?');
define('TEXT_PRODUCTS_IMAGE_DELETE', 'Delete this Image from the Server permanently?');
define('TEXT_PRODUCTS_URL', 'URL prodotto:');
define('TEXT_PRODUCTS_URL_WITHOUT_HTTP', '<small>(senza http://)</small>');
define('TEXT_PRODUCTS_PRICE_NET', 'Prezzo prodotto (Netto):');
define('TEXT_PRODUCTS_PRICE_GROSS', 'Products Price (Lordo):');
define('TEXT_PRODUCTS_WEIGHT', 'Grandezza prodotto:');

define('EMPTY_CATEGORY', 'Categoria vuota');

define('TEXT_HOW_TO_COPY', 'Metodo di Copia:');
define('TEXT_COPY_AS_LINK', 'Copia come Link');
define('TEXT_COPY_AS_DUPLICATE', 'Copia come duplicato');

define('ERROR_CANNOT_LINK_TO_SAME_CATEGORY', 'Errore: Non puoi linkare i prodotti nella stessa Categoria.');
define('ERROR_CATALOG_IMAGE_DIRECTORY_NOT_WRITEABLE', 'Errore: La Directory del Catalogo delle Immagini non � scrivibile: ' . DIR_FS_CATALOG_IMAGES);
define('ERROR_CATALOG_IMAGE_DIRECTORY_DOES_NOT_EXIST', 'Errore: La Directory del Catalogo delle Immagini non esiste: ' . DIR_FS_CATALOG_IMAGES);
define('ERROR_CANNOT_MOVE_CATEGORY_TO_PARENT', 'Errore: Questa categoria non pu� essere mossa in usa sotto-categoria.');

define('TEXT_PRODUCTS_SEO_URL', 'Products SEO URL:');
define('TEXT_EDIT_CATEGORIES_SEO_URL', 'Category SEO URL:');
define('TEXT_CATEGORIES_SEO_URL', 'Category SEO URL:');
?>
