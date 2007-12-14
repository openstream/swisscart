<?php
/*******************************************************************************************
*                                                                                          *
*  CAO-Faktura für Windows Version 1.2 (http://www.cao-wawi.de)                            *
*  Copyright (C) 2004 Jan Pokrandt / Info@JP-SOFT.de                                       *
*                                                                                          *
*  This program is free software; you can redistribute it and/or                           *
*  modify it under the terms of the GNU General Public License                             *
*  as published by the Free Software Foundation; either version 2                          *
*  of the License, or any later version.                                                   *
*                                                                                          *
*  This program is distributed in the hope that it will be useful,                         *
*  but WITHOUT ANY WARRANTY; without even the implied warranty of                          *
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                           *
*  GNU General Public License for more details.                                            *
*                                                                                          *
*  You should have received a copy of the GNU General Public License                       *
*  along with this program; if not, write to the Free Software                             *
*  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
*                                                                                          *
*  ******* CAO-Faktura comes with ABSOLUTELY NO WARRANTY ***************                   *
*                                                                                          *
********************************************************************************************
*                                                                                          *
* Eine Entfernung oder Veraenderung dieses Dateiheaders ist nicht zulaessig !!!            *
* Wenn Sie diese Datei veraendern dann fuegen Sie ihre eigenen Copyrightmeldungen          *
* am Ende diese Headers an                                                                 *
*                                                                                          *
********************************************************************************************
*                                                                                          *
*  Programm     : CAO-Faktura                                                              *
*  Modul        : cao_osc.php                                                              *
*  Stand        : 15.08.2006                                                               *
*  Version      : 1.53                                                                     *
*  Beschreibung : Script zum Datenaustausch CAO-Faktura <--> osCommerce-Shop               *
*                                                                                          *
*  based on:                                                                               *
* (c) 2000 - 2001 The Exchange Project                                                     *
* (c) 2001 - 2003 osCommerce, Open Source E-Commerce Solutions                             *
* (c) 2001 - 2003 TheMedia, Dipl.-Ing Thomas Plänkers                                      *
* (c) 2003 JP-Soft, Jan Pokrandt                                                           *
* (c) 2003 IN-Solution, Henri Schmidhuber                                                  *
* (c) 2003 www.websl.de, Karl Langmann                                                     *
* (c) 2003 RV-Design Raphael Vullriede                                                     *
*                                                                                          *
* Released under the GNU General Public License                                            *
*                                                                                          *
*  History :                                                                               *
*                                                                                          *
*  - 25.06.2003 JP Version 0.1 released                                                    *
*  - 26.06.2003 HS beim Orderexport orderstatus und comment hinzugefuegt                   *
*  - 29.06.2003 JP order_update entfernt und in die Datei cao_update.php verschoben        *
*  - 17.07.2003 tep_array_merge durch array_merge ersetzt                                  *
*  - 18.07.2003 Code fuer Image_Upload hinzugefuegt                                        *
*  - 20.07.2003 HS Shipping und Paymentklassen aufgenommen                                 *
*  - 02.08.2003 KL MANUFACTURERS_DESCRIPTION  language_id geändert in languages_id         *
*  - 09.08.2003 JP fuer das Modul Banktransfer werden jetzt die daten bei der Bestll-      *
*                  uebermittlung mit ausgegeben                                            *
*  - 10.08.2003 JP Geburtsdatum wird jetzt in den Bestellungen mit uebergeben              *
*  - 18.08.2003 JP Bug bei Products/URL beseitigt                                          *
*  - 18.08.2003 HS Bankdaten werden nur bei Banktransfer ausgelesen                        *
*  - 23.08.2003 Code fuer Hersteller-Update hinzugefuegt                                   *
*  - 25.10.2003 RV Kunden-Export hinzugefügt                                               *
*  - 25.10.2003 Kunden-Update hinzugefügt                                                  *
*  - 01.11.2003 Statusänderung werden wenn möglich in der Bestellsprache ausgeführt        *
*  - 24.11.2003 HS Fix Kunden-Export - Newsletterexport hinzugefügt                        *
*  - 01.12.2003 RV Code für 3 Produktbilder-Erweiterung hinzugefügt.                       *
*  - 31.01.2004 JP Resourcenverbrauch minimiert                                            *
*                  tep_set_time_limit ist jetzt per DEFINE zu- und abschaltbar             *
*  - 06.06.2004 JP per DEFINE kann jetzt die Option "3 Produktbilder" geschaltet werden    *
*  - 06.06.2004 JP diverse kleine &Auml;nderungen beimKunden-Upload                        *
*  - 09.10.2004 RV automatisch Erkennung von 3 Bilder Contrib laut readme                  *
*  - 09.10.2004 RV vereinheitlicher Adress-Export bei Bestellungen und Kunden              *
*  - 09.10.2004 RV Kunden Vor- und Nachname bei Bestellungen getrennt exportieren          *
*  - 09.10.2004 RV SQL-Cleanup                                                             *
*  - 09.10.2004 RV CODE-Cleanup                                                            *
*  - 14.10.2004 RV Länder bei Bestellungen als ISO-Code                                    *
*  - 03.12.2004 JP Bugfix beim Kunden-Export (Fehlende Felder)                             *
*  - 05.12.2004 RV automatisch Erkennung für 3 Produktbilder                               *
*  - 07.01.2005 JP Bugfix bei manufacturers_id (gemeldet im CAO-Forum durch r23)           *
*  - 09.01.2004 JP Logger eingebaut                                                        *
*  - 09.01.2005 JP Export der Konfiguration eingebaut                                      *
*  - 22.01.2005 JP Export der Configuration eingebaut                                      *
*  - 25.01.2005 JP kleine Aenderungen fuer Abwaertskompatibilitaet                         *
*  - 09.08.2005 JP Erweiterung fuer Contrib  HeaderTags_V_2.5.3                            *
*  - 26.08.2005 JP Artikel-Aktionspreise werden jetzt mit exportiert                       *
*  - 04.10.2005 JP/KL Version 1.44 released, Scripte komplett ueberarbeitet                *
*  - 07.10.2005 JP Categories-Description eingebaut                                        *
*  - 23.10.2005 hartleib Fehlende $LangID in OrderUpdate hinzugefuegt                      *
*  - 07.11.2005 JP Export Orders/VAT_ID hinzugefuegt (benoetigt Contrib)                   *
*  - 08.11.2005 JP Erweiterung zum anlegen der Tabellenspaleten fuer 3 Produktbilder       *
*                  implementiert                                                           *
*  - 10.01.2007 JP Steuern angepasst                                                       *
*******************************************************************************************/

$order_total_class['ot_cod_fee']['prefix'] = '+';
$order_total_class['ot_cod_fee']['tax'] = '19';

$order_total_class['ot_customer_discount']['prefix'] = '-';
$order_total_class['ot_customer_discount']['tax'] = '19';

$order_total_class['ot_gv']['prefix'] = '-';
$order_total_class['ot_gv']['tax'] = '0';

$order_total_class['ot_loworderfee']['prefix'] = '+';
$order_total_class['ot_loworderfee']['tax'] = '19';

$order_total_class['ot_shipping']['prefix'] = '+';
$order_total_class['ot_shipping']['tax'] = '19';

$order_total_class['ot_payment']['prefix'] = '-';
$order_total_class['ot_payment']['tax'] = '19';

// Default-Sprache
$LangID = 2;

/******************************************************************************************/
$version_nr    = '1.53';
$version_datum = '2006.08.15';
/******************************************************************************************/


// define('SET_TIME_LIMIT', 1); // aktivieren um SetTimeLimit einzuschalten
   
define ('LOGGER',false);  // Um das Loggen einzuschalten false durch true ersetzen.
  
define ('HEADERTAGS',false); // HeaderTags_V_2.5.3

define ('CATDESCR',false); // CategoriesDescription

require ('includes/application_top.php');
require ('cao_osc_functions.php');  

if (!function_exists('tep_validate_password')) : 
 require (DIR_WS_FUNCTIONS . 'password_funcs.php');
endif;


//---------------------------------------------------------------------
//
//---------------------------------------------------------------------

if ($_SERVER['REQUEST_METHOD']=='GET') 
{
  switch ($_GET['action']) 
  {
     case 'version':        // Ausgabe Scriptversion
     
       SendXMLHeader ();
       SendScriptVersion ();
       exit; 
     
     case 'categories_export':
     
       SendXMLHeader ();
       SendCategories ();
       exit;
     
     case 'manufacturers_export':
     
       SendXMLHeader ();
       SendManufacturers ();
       exit;
     
     case 'orders_export':
     
       SendXMLHeader ();
       SendOrders ();
       exit;
     
     case 'products_export':
     
       SendXMLHeader ();
       SendProducts ();
       exit;
     
     case 'customers_export':
     
       SendXMLHeader ();
       SendCustomers ();
       exit;
     
     case 'customers_newsletter_export':
     
       SendXMLHeader ();
       SendCustomersNewsletter ();
       exit;
     
     case 'config_export':
     
       SendXMLHeader ();
       SendShopConfig ();
       exit;
       
     case 'update_tables':
     
       UpdateTables ();
       exit;
     
     case 'update_tables_3_images':  
       UpdateTablesFor3Images ();
       exit;
       
     default :
       
       ShowHTMLMenu ();
       exit;
       
   } // End Case   
} // End Method POST
 else 
{
  if ($_SERVER['REQUEST_METHOD']=='POST') 
  {
    switch ($_POST['action']) 
    {
      case 'manufacturers_image_upload':
     
        SendXMLHeader ();
        ManufacturersImageUpload ();
        exit;
     
     case 'categories_image_upload':
     
        SendXMLHeader ();
        CategoriesImageUpload ();
        exit;
     
     case 'products_image_upload':
     
        SendXMLHeader ();
        ProductsImageUpload ();
        exit;   
        
     case 'products_image_upload_med':
     
        SendXMLHeader ();
        ProductsImageUploadMed ();
        exit;   
        
     case 'products_image_upload_large':
     
        SendXMLHeader ();
        ProductsImageUploadLarge ();
        exit;   
        
     case 'manufacturers_update':
     
        SendXMLHeader ();
        ManufacturersUpdate ();
        exit;   
        
      case 'manufacturers_erase':
     
        SendXMLHeader ();
        ManufacturersErase ();
        exit;   
        
      case 'products_update':
        
        SendXMLHeader ();
        ProductsUpdate ();
        exit;
        
      case 'products_erase':
        
        SendXMLHeader ();
        ProductsErase ();
        exit;
        
      case 'products_specialprice_update':
        
        SendXMLHeader ();
        ProductsSpecialPriceUpdate ();
        exit;
        
      case 'products_specialprice_erase':  
        
        SendXMLHeader ();
        ProductsSpecialPriceErase ();
        exit;
        
      case 'categories_update':
        
        SendXMLHeader ();
        CategoriesUpdate ();
        exit;
        
      case 'categories_erase':
        
        SendXMLHeader ();  
        CategoriesErase ();
        exit;
        
      case 'prod2cat_update':

        SendXMLHeader ();  
        Prod2CatUpdate ();
        exit;

      case 'prod2cat_erase':

        SendXMLHeader ();  
        Prod2CatErase ();
        exit;
        
      case 'order_update':
      
        SendXMLHeader ();  
        OrderUpdate ();
        exit;
        
      case 'customers_update':
      
        SendXMLHeader ();  
        CustomersUpdate ();
        exit;
      
      case 'customers_erase':
      
        SendXMLHeader ();  
        CustomersErase ();
        exit;
          
    } // End Case
  }  // End Method POST
}
?>