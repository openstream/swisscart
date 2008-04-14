<?php
/*
  $Id: edit_orders.php v5.0 08/05/2007 djmonkey1 Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2007 osCommerce

  Released under the GNU General Public License
*/

define('HEADING_TITLE', 'Modifica ordini #%s of %s');
define('ADDING_TITLE', 'Aggiunta prodotto(i) all\'ordine #%s');

define('ENTRY_UPDATE_TO_CC', '(Aggiorna a ' . ORDER_EDITOR_CREDIT_CARD . ' per vedere le caselle della carta di credito.)');
define('TABLE_HEADING_COMMENTS', 'Commenti');
define('TABLE_HEADING_STATUS', 'Stato');
define('TABLE_HEADING_NEW_STATUS', 'Nuovo stato');
define('TABLE_HEADING_ACTION', 'Azione');
define('TABLE_HEADING_DELETE', 'Cancella?');
define('TABLE_HEADING_QUANTITY', 'Qtità.');
define('TABLE_HEADING_PRODUCTS_MODEL', 'Modello');
define('TABLE_HEADING_PRODUCTS', 'Prodotti');
define('TABLE_HEADING_TAX', 'Tasse');
define('TABLE_HEADING_TOTAL', 'Totale');
define('TABLE_HEADING_BASE_PRICE', 'Prezzo<br>(base)');
define('TABLE_HEADING_UNIT_PRICE', 'Prezzo<br>(lordo.)');
define('TABLE_HEADING_UNIT_PRICE_TAXED', 'Prezzo<br>(incl iva.)');
define('TABLE_HEADING_TOTAL_PRICE', 'Totale<br>(escl. iva)');
define('TABLE_HEADING_TOTAL_PRICE_TAXED', 'Totale<br>(incl. iva)');
define('TABLE_HEADING_OT_TOTALS', 'Totale ordine:');
define('TABLE_HEADING_OT_VALUES', 'Valore:');
define('TABLE_HEADING_SHIPPING_QUOTES', 'Spese di spedizione:');
define('TABLE_HEADING_NO_SHIPPING_QUOTES', 'Non ci sono spese di spedizione da mostrare!');

define('TABLE_HEADING_CUSTOMER_NOTIFIED', 'Notifica<br>Cliente');
define('TABLE_HEADING_DATE_ADDED', 'Data');

define('ENTRY_CUSTOMER', 'Cliente');
define('ENTRY_NAME', 'Nome:');
define('ENTRY_CITY_STATE', 'Città, Regione:');
define('ENTRY_SHIPPING_ADDRESS', 'Indirizzo Spedizione');
define('ENTRY_BILLING_ADDRESS', 'Indirizzo fatturazione');
define('ENTRY_PAYMENT_METHOD', 'Metodo pagamento');
define('ENTRY_CREDIT_CARD_TYPE', 'Tipo carta:');
define('ENTRY_CREDIT_CARD_OWNER', 'Proprietario carta:');
define('ENTRY_CREDIT_CARD_NUMBER', 'Num. carta:');
define('ENTRY_CREDIT_CARD_EXPIRES', 'Scadenza carta:');
define('ENTRY_SUB_TOTAL', 'Sub-Totale:');
define('ENTRY_TYPE_BELOW', 'Scrivi sotto');

//the definition of ENTRY_TAX is important when dealing with certain tax components and scenarios
define('ENTRY_TAX', 'Tasse');
//do not use a colon (:) in the defintion, ie 'VAT' is ok, but 'VAT:' is not

define('ENTRY_SHIPPING', 'Spedizione:');
define('ENTRY_TOTAL', 'Totale:');
define('ENTRY_STATUS', 'Stato:');
define('ENTRY_NOTIFY_CUSTOMER', 'Notifica cliente:');
define('ENTRY_NOTIFY_COMMENTS', 'Invia commenti:');
define('ENTRY_CURRENCY_TYPE', 'Valuta');
define('ENTRY_CURRENCY_VALUE', 'Valore valuta');

define('TEXT_INFO_PAYMENT_METHOD', 'Metodo pagamento:');
define('TEXT_NO_ORDER_PRODUCTS', 'Questo ordine non contiene prodotti');
define('TEXT_ADD_NEW_PRODUCT', 'Aggiungi prodotti');
define('TEXT_PACKAGE_WEIGHT_COUNT', 'Peso spedizione: %s  |  Quant. prodotti: %s');

define('TEXT_STEP_1', '<b>Passo 1:</b>');
define('TEXT_STEP_2', '<b>Passo 2:</b>');
define('TEXT_STEP_3', '<b>Passo 3:</b>');
define('TEXT_STEP_4', '<b>Passo 4:</b>');
define('TEXT_SELECT_CATEGORY', '- Scegli la categoria dalla lista -');
define('TEXT_PRODUCT_SEARCH', '<b>- O inserisci una parola per ricercare -</b>');
define('TEXT_ALL_CATEGORIES', 'Tutte le categorie/Tutti i prodotti');
define('TEXT_SELECT_PRODUCT', '- Scegli il prodotto -');
define('TEXT_BUTTON_SELECT_OPTIONS', 'Scegli le opzioni');
define('TEXT_BUTTON_SELECT_CATEGORY', 'Scegli la categoria');
define('TEXT_BUTTON_SELECT_PRODUCT', 'Scegli questo prodotto');
define('TEXT_SKIP_NO_OPTIONS', '<em>No Opzioni - tralasciato...</em>');
define('TEXT_QUANTITY', 'Quantità:');
define('TEXT_BUTTON_ADD_PRODUCT', 'Aggiungi all\'ordine');
define('TEXT_CLOSE_POPUP', '<u>Chiudi</u> [x]');
define('TEXT_ADD_PRODUCT_INSTRUCTIONS', 'Keep adding products until you are done.<br>Then close this tab/window, return to the main tab/window, and press the "update" button.');
define('TEXT_PRODUCT_NOT_FOUND', '<b>Prodotto non trovato<b>');
define('TEXT_SHIPPING_SAME_AS_BILLING', 'Shipping same as billing address');
define('TEXT_BILLING_SAME_AS_CUSTOMER', 'Billing same as customer address');

define('IMAGE_ADD_NEW_OT', 'Insert new custom order total after this one');
define('IMAGE_REMOVE_NEW_OT', 'Remove this order total component');
define('IMAGE_NEW_ORDER_EMAIL', 'Invia email con la nuova conferma dell\'ordine');

define('TEXT_NO_ORDER_HISTORY', 'No Order History Available');

define('PLEASE_SELECT', 'Scegli');

define('EMAIL_SEPARATOR', '------------------------------------------------------');
define('EMAIL_TEXT_SUBJECT', 'Il tuo ordine è stato aggiornato');
define('EMAIL_TEXT_ORDER_NUMBER', 'Ordine numero:');
define('EMAIL_TEXT_INVOICE_URL', 'Fattura dettagliata:');
define('EMAIL_TEXT_DATE_ORDERED', 'Data ordine:');
define('EMAIL_TEXT_STATUS_UPDATE', 'Grazie per il tuo acquisto!' . "\n\n" . 'Lo stato del tuo ordine è stato aggiornato.' . "\n\n" . 'Nuovo stato: %s' . "\n\n");
define('EMAIL_TEXT_STATUS_UPDATE2', 'Se hai altre domande, rispondi a questa mail.' . "\n\n" . 'Con i migliori saluti dagli amici per la decorazione della tua casa ' . STORE_NAME . "\n");
define('EMAIL_TEXT_COMMENTS_UPDATE', 'I commenti per il tuo ordine sono' . "\n\n%s\n\n");

define('ERROR_ORDER_DOES_NOT_EXIST', 'Error: Order %s does not exist.');
define('ERROR_NO_ORDER_SELECTED', 'You have not selected an order to edit, or the order ID variable has not been set.');
define('SUCCESS_ORDER_UPDATED', 'Successo: L\'ordine è stato aggiornato.');
define('SUCCESS_EMAIL_SENT', 'Completato: L\'ordine è stato aggiornato e un email con le nuove informazioni è stata spedita.');

//the hints
define('HINT_UPDATE_TO_CC', 'Set payment method to ' . ORDER_EDITOR_CREDIT_CARD . ' and the other fields will be displayed automatically.  CC fields are hidden if any other payment method is selected.  The name of the payment method that, when selected, will display the CC fields is configurable in the Order Editor area of the Configuration section of the Administration panel.');
define('HINT_UPDATE_CURRENCY', 'Changing the currency will cause the shipping quotes and order totals to recalculate and reload.');
define('HINT_SHIPPING_ADDRESS', 'If you change the shipping state, postcode, or country you will be given the option of whether or not to recalculate the totals and reload the shipping quotes.');
define('HINT_TOTALS', 'Feel free to give discounts by adding negative values. Subtotal, tax total, and grand total fields are not editable. When adding in custom order total components via AJAX make sure you enter the title first or the code will not recognize the entry (ie, a component with a blank title is deleted from the order).');
define('HINT_PRESS_UPDATE', 'Please click on "Update" to save all changes.');
define('HINT_BASE_PRICE', 'Price (base) is the products price before products attributes (ie, the catalog price of the item)');
define('HINT_PRICE_EXCL', 'Price (excl) is the base price plus any product attributes prices that may exist');
define('HINT_PRICE_INCL', 'Price (incl) is Price (excl) times tax');
define('HINT_TOTAL_EXCL', 'Total (excl) is Price (excl) times qty');
define('HINT_TOTAL_INCL', 'Total (incl) is Price (excl) times tax and qty');
//end hints

//new order confirmation email- this is a separate email from order status update
define('ENTRY_SEND_NEW_ORDER_CONFIRMATION', 'Conferma nuovo ordine:');
define('EMAIL_TEXT_DATE_MODIFIED', 'Data modifica:');
define('EMAIL_TEXT_PRODUCTS', 'Produotti');
define('EMAIL_TEXT_DELIVERY_ADDRESS', 'Indirizzo spedizione');
define('EMAIL_TEXT_BILLING_ADDRESS', 'Indirizzo fatturazione');
define('EMAIL_TEXT_PAYMENT_METHOD', 'Metodo di pagamento');
// If you want to include extra payment information, enter text below (use <br> for line breaks):
//define('EMAIL_TEXT_PAYMENT_INFO', ''); //why would this be useful???
// If you want to include footer text, enter text below (use <br> for line breaks):
define('EMAIL_TEXT_FOOTER', '');
//end email

//add-on for downloads
define('ENTRY_DOWNLOAD_COUNT', 'Download #');
define('ENTRY_DOWNLOAD_FILENAME', 'Filename');
define('ENTRY_DOWNLOAD_MAXDAYS', 'Expiry days');
define('ENTRY_DOWNLOAD_MAXCOUNT', 'Downloads remaining');

//add-on for Ajax
define('AJAX_CONFIRM_PRODUCT_DELETE', 'Are you sure you want to delete this product from the order?');
define('AJAX_CONFIRM_COMMENT_DELETE', 'Are you sure you want to delete this comment from the orders status history?');
define('AJAX_MESSAGE_STACK_SUCCESS', 'Success! \' + %s + \' has been updated');
define('AJAX_CONFIRM_RELOAD_TOTALS', 'You have changed some shipping information. Would you like to recalculate the order totals and shipping quotes?');
define('AJAX_CANNOT_CREATE_XMLHTTP', 'Cannot create XMLHTTP instance');
define('AJAX_SUBMIT_COMMENT', 'Submit new comments and/or status');
define('AJAX_NO_QUOTES', 'There are no shipping quotes to display.');
define('AJAX_SELECTED_NO_SHIPPING', 'You have selected a shipping method for this order but it appears there is not one already stored in the database.  Would you like to add this shipping charge to the order?');
define('AJAX_RELOAD_TOTALS', 'The new shipping component has been written to the database but the totals have not yet been re-calculated.  Click ok now to re-calculate the order totals.  If your connection is slow wait for all components to load before clicking ok.');
define('AJAX_NEW_ORDER_EMAIL', 'Are you sure you want to send a new order confirmation email for this order?');
define('AJAX_INPUT_NEW_EMAIL_COMMENTS', 'Please input any comments you may have here.  It is ok to leave this blank if you do not wish to include comments.  Please remember as you type that hitting the "enter" key will result in submitting the comments as they appear.  It is not yet possible to include line breaks.');
define('AJAX_SUCCESS_EMAIL_SENT', 'Success!  A new order confirmation email was sent to %s');
define('AJAX_WORKING', 'Working, please wait....');

?>
