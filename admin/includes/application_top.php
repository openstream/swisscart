<?php
/*
        $Id: application_top.php,v 1.162 2003/07/12 09:39:03 hpdl Exp $

        osCommerce, Open Source E-Commerce Solutions
        http://www.oscommerce.com

        Customized by swisscart�, Swiss Webshop Solutions
        http://www.swisscart.com

        Copyright (c) 2003-2007 osCommerce

        Released under the GNU General Public License
*/

// Start the clock for the page parse time log
        define('PAGE_PARSE_START_TIME', microtime());

// Set the level of error reporting
        error_reporting(E_ALL & ~E_NOTICE);

// Check if register_globals is enabled.
// Since this is a temporary measure this message is hardcoded. The requirement will be removed before 2.2 is finalized.
        /*if (function_exists('ini_get')) {
                ini_get('register_globals') or $messageStack->add('Server Requirement Error: register_globals is disabled in your PHP configuration.');
        }*/
        
// Since register global is disabled request values are copyed to HTTP_* and global vars
        require('includes/register_globals.php');        

// Set the local configuration parameters - mainly for developers
        if (file_exists('includes/local/configure.php')) include('includes/local/configure.php');

// Include application configuration parameters
        require('includes/configure.php');

        ini_set('log_errors', true);
        ini_set('error_log', DIR_FS_CATALOG . 'error_log/errors.log');

        // Define the project version
        define('PROJECT_VERSION', 'osCommerce 2.2-MS2');
        define('SWISSCART_VERSION', 'v4.0');

// set php_self in the local scope
        // removed for security reasons
        //$PHP_SELF = (isset($HTTP_SERVER_VARS['PHP_SELF']) ? $HTTP_SERVER_VARS['PHP_SELF'] : $HTTP_SERVER_VARS['SCRIPT_NAME']);
        $PHP_SELF = $_SERVER['SCRIPT_NAME'];
        define('CURRENT_PAGE', basename($PHP_SELF));

// Used in the "Backup Manager" to compress backups
        define('LOCAL_EXE_GZIP', '/usr/bin/gzip');
        define('LOCAL_EXE_GUNZIP', '/usr/bin/gunzip');
        define('LOCAL_EXE_ZIP', '/usr/local/bin/zip');
        define('LOCAL_EXE_UNZIP', '/usr/local/bin/unzip');

// include the list of project filenames
        require(DIR_WS_INCLUDES . 'filenames.php');

// include the list of project database tables
        require(DIR_WS_INCLUDES . 'database_tables.php');

// customization for the design layout
        define('BOX_WIDTH', 170); // how wide the boxes should be in pixels (default: 125)

// Define how do we update currency exchange rates
// Possible values are 'oanda' 'xe' or ''
        define('CURRENCY_SERVER_PRIMARY', 'oanda');
        define('CURRENCY_SERVER_BACKUP', 'xe');

// include the database functions
        require(DIR_WS_FUNCTIONS . 'database.php');

// make a connection to the database... now
        tep_db_connect() or die('Unable to connect to database server!');

// set application wide parameters
        $configuration_query = tep_db_query('select configuration_key as cfgKey, configuration_value as cfgValue from ' . TABLE_CONFIGURATION);
        while ($configuration = tep_db_fetch_array($configuration_query)) {
                define($configuration['cfgKey'], $configuration['cfgValue']);
        }

// define our general functions used application-wide
        require(DIR_WS_FUNCTIONS . 'general.php');
        require(DIR_WS_FUNCTIONS . 'html_output.php');

// initialize the logger class
        require(DIR_WS_CLASSES . 'logger.php');

// include shopping cart class
        require(DIR_WS_CLASSES . 'shopping_cart.php');

// some code to solve compatibility issues
        require(DIR_WS_FUNCTIONS . 'compatibility.php');

// define how the session functions will be used
        require(DIR_WS_FUNCTIONS . 'sessions.php');

// set the cookie domain
        $cookie_domain = (($request_type == 'NONSSL') ? HTTP_COOKIE_DOMAIN : HTTPS_COOKIE_DOMAIN);
        $cookie_path = (($request_type == 'NONSSL') ? HTTP_COOKIE_PATH : HTTPS_COOKIE_PATH);

// set the session name and save path
        tep_session_name('osCAdminID');
        tep_session_save_path(SESSION_WRITE_DIRECTORY);

// set the session cookie parameters
        if (function_exists('session_set_cookie_params')) {
          session_set_cookie_params(0, $cookie_path, $cookie_domain);
        } elseif (function_exists('ini_set')) {
          ini_set('session.cookie_lifetime', '0');
          ini_set('session.cookie_path', $cookie_path);
          ini_set('session.cookie_domain', $cookie_domain);
        }

        @ini_set('session.use_only_cookies', (SESSION_FORCE_COOKIE_USE == 'True') ? 1 : 0);

// lets start our session
        tep_session_start();

        if ( (PHP_VERSION >= 4.3) && function_exists('ini_get') && (ini_get('register_globals') == false) ) {
          extract($_SESSION, EXTR_OVERWRITE+EXTR_REFS);
        }

// set the language
        if (!tep_session_is_registered('language') || isset($HTTP_GET_VARS['language'])) {
                if (!tep_session_is_registered('language')) {
                        tep_session_register('language');
                        tep_session_register('languages_id');
                }

                include(DIR_WS_CLASSES . 'language.php');
                $lng = new language();

                if (isset($HTTP_GET_VARS['language']) && tep_not_null($HTTP_GET_VARS['language'])) {
                        $lng->set_language($HTTP_GET_VARS['language']);
                } else {
                        $lng->get_browser_language();
                }

                $language = $lng->language['directory'];
                $languages_id = $lng->language['id'];
        }

// prepare language drop down array
        $languages = tep_get_languages();
        $languages_array = array();
        $languages_selected = DEFAULT_LANGUAGE;
        for ($i = 0, $n = sizeof($languages); $i < $n; $i++) {
                $languages_array[] = array('id' => $languages[$i]['code'],
                                                                         'text' => $languages[$i]['name']);
                if ($languages[$i]['directory'] == $language) $languages_selected = $languages[$i]['code'];
        }

// include the language translations
        require(DIR_WS_LANGUAGES . $language . '.php');
        $current_page = basename($PHP_SELF);
        if (file_exists(DIR_WS_LANGUAGES . $language . '/' . $current_page)) {
                include(DIR_WS_LANGUAGES . $language . '/' . $current_page);
        }

// define our localization functions
        require(DIR_WS_FUNCTIONS . 'localization.php');

// Include validation functions (right now only email address)
        require(DIR_WS_FUNCTIONS . 'validations.php');

// setup our boxes
        require(DIR_WS_CLASSES . 'table_block.php');
        require(DIR_WS_CLASSES . 'box.php');

// initialize the message stack for output messages
        require(DIR_WS_CLASSES . 'message_stack.php');
        $messageStack = new messageStack;

// split-page-results
        require(DIR_WS_CLASSES . 'split_page_results.php');

// entry/item info classes
        require(DIR_WS_CLASSES . 'object_info.php');

// email classes
        require(DIR_WS_CLASSES . 'mime.php');
        require(DIR_WS_CLASSES . 'email.php');

        // require(DIR_FS_CATALOG.DIR_WS_FUNCTIONS.'debug_functions.php');
        
// file uploading class
        require(DIR_WS_CLASSES . 'upload.php');

        if(file_exists(DIR_WS_FUNCTIONS . 'cleverreach.php')){
            include(DIR_WS_FUNCTIONS . 'cleverreach.php');
        }

// calculate category path
        if (isset($HTTP_GET_VARS['cPath'])) {
                $cPath = $HTTP_GET_VARS['cPath'];
        } else {
                $cPath = '';
        }

        if (tep_not_null($cPath)) {
                $cPath_array = tep_parse_category_path($cPath);
                $cPath = implode('_', $cPath_array);
                $current_category_id = $cPath_array[(sizeof($cPath_array)-1)];
        } else {
                $current_category_id = 0;
        }

// default open navigation box
        if (!tep_session_is_registered('selected_box')) {
                tep_session_register('selected_box');
                $selected_box = 'customers';
        }

        if (isset($HTTP_GET_VARS['selected_box'])) {
                $selected_box = $HTTP_GET_VARS['selected_box'];
        }

// the following cache blocks are used in the Tools->Cache section
// ('language' in the filename is automatically replaced by available languages)
        $cache_blocks = array(array('title' => TEXT_CACHE_CATEGORIES, 'code' => 'categories', 'file' => 'categories_box-language.cache', 'multiple' => true),
                                                                                                array('title' => TEXT_CACHE_MANUFACTURERS, 'code' => 'manufacturers', 'file' => 'manufacturers_box-language.cache', 'multiple' => true),
                                                                                                array('title' => TEXT_CACHE_ALSO_PURCHASED, 'code' => 'also_purchased', 'file' => 'also_purchased-language.cache', 'multiple' => true)
                                                                                         );

// check if a default currency is set
        if (!defined('DEFAULT_CURRENCY')) {
                $messageStack->add(ERROR_NO_DEFAULT_CURRENCY_DEFINED, 'error');
        }

// check if a default language is set
        if (!defined('DEFAULT_LANGUAGE')) {
                $messageStack->add(ERROR_NO_DEFAULT_LANGUAGE_DEFINED, 'error');
        }

        if (function_exists('ini_get') && ((bool)ini_get('file_uploads') == false) ) {
                $messageStack->add(WARNING_FILE_UPLOADS_DISABLED, 'warning');
        }

 if(file_exists(DIR_WS_FUNCTIONS . 'cleverreach.php')){
  include(DIR_WS_FUNCTIONS . 'cleverreach.php');
 }

 if(file_exists(DIR_WS_FUNCTIONS . 'paymentlog.php')){
  include(DIR_WS_FUNCTIONS . 'paymentlog.php');
 }

?>