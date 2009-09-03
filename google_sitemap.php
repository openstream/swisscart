<?php
/**
 * Google XML Sitemap Feed Cron Script
 *
 * The Google sitemap service was announced on 2 June 2005 and represents
 * a huge development in terms of crawler technology.  This contribution is
 * designed to create the sitemap XML feed per the specification delineated 
 * by Google.  This cron script will call the code to create the scripts and 
 * eliminate the session auto start issues. 
 * @package Google-XML-Sitemap-Feed
 * @license http://opensource.org/licenses/gpl-license.php GNU Public License
 * @version 1.2
 * @link http://www.oscommerce-freelancers.com/ osCommerce-Freelancers
 * @link http://www.google.com/webmasters/sitemaps/docs/en/about.html About Google Sitemap 
 * @copyright Copyright 2005, Bobby Easland 
 * @author Bobby Easland 
 * @filesource
 */

//	chdir('../');
	/**
	 * Option to compress the files
	 */
	define('GOOGLE_SITEMAP_COMPRESS', 'false');
	/**
	 * Option for change frequency of products
	 */
	define('GOOGLE_SITEMAP_PROD_CHANGE_FREQ', 'weekly');
	/**
	 * Option for change frequency of categories
	 */
	define('GOOGLE_SITEMAP_CAT_CHANGE_FREQ', 'weekly');
	/**
	 * Carried over from application_top.php for compatibility
	 */
	define('GOOGLE_SITEMAP_MAN_CHANGE_FREQ', 'weekly');
	/**
	 * Carried over from application_top.php for compatibility
	 */
	define('GOOGLE_SITEMAP_SPECIALS_CHANGE_FREQ', 'weekly');
	/**
	 * Carried over from application_top.php for compatibility
	 */
include_once 'includes/application_top.php';

require_once(DIR_WS_CLASSES . 'google_sitemap.php');

$google = new GoogleSitemap(DB_SERVER, DB_SERVER_USERNAME, DB_DATABASE, DB_SERVER_PASSWORD);

$submit = true;

echo '<pre>';
if ($google->GenerateProductSitemap()){
	echo 'Generated Google Product Sitemap Successfully' . "\n\n";
} else {
	$submit = false;
	echo 'ERROR: Google Product Sitemap Generation FAILED!' . "\n\n";
}

if ($google->GenerateCategorySitemap()){
	echo 'Generated Google Category Sitemap Successfully' . "\n\n";
} else {
	$submit = false;
	echo 'ERROR: Google Category Sitemap Generation FAILED!' . "\n\n";
}

$showManufacturers = true;
if ($google->GenerateManufacturerSitemap()){
	echo 'Generated Google Manufacturers Sitemap Successfully' . "\n\n";
} else {
  $manufacturers_query = tep_db_query("select manufacturers_id from " . TABLE_MANUFACTURERS . " limit 1");
  if (tep_db_num_rows($manufacturers_query) > 0)
  {
    $submit = false;
	  echo 'ERROR: Google Manufacturers Sitemap Generation FAILED!' . "\n\n";
  }
  else 
  {
    $showManufacturers = false;
	  echo 'Google Sitemap Manufacturers not generated - no Manufacturers found!' . "\n\n";
  } 
}

$showSpecials = true;
if ($google->GenerateSpecialsSitemap()){
	echo 'Generated Google Specials Sitemap Successfully' . "\n\n";
} else {
  $specials_query = tep_db_query("select p.products_id from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd, " . TABLE_SPECIALS . " s where p.products_status = '1' and p.products_id = s.products_id and pd.products_id = s.products_id and pd.language_id = '" . (int)$languages_id . "' and s.status = '1' limit 1");
  if (tep_db_num_rows($specials_query) > 0)
  {
	  $submit = false;
	  echo 'ERROR: Google Specials Sitemap Generation FAILED!' . "\n\n";
  }
  else 
  {
    $showSpecials = false;
	  echo 'Google Sitemap Specials not generated - no specials found!' . "\n\n";
  } 
}

if ($google->GenerateSitemapIndex()){
	echo 'Generated Google Sitemap Index Successfully' . "\n\n";
} else {
	$submit = false;
	echo 'ERROR: Google Sitemap Index Generation FAILED!' . "\n\n";
}

if ($submit){
	echo 'CONGRATULATIONS! All files generated successfully.' . "\n\n";
	echo 'If you have not already submitted the sitemap index to Google click the link below.' . "\n";
	echo 'Before you do I HIGHLY recommend that you view the XML files to make sure the data is correct.' . "\n\n";
	echo $google->GenerateSubmitURL() . "\n\n";
	echo 'For your convenience here is the CRON command for your site:' . "\n";
	echo 'php ' . dirname($_SERVER['SCRIPT_FILENAME']) . '/index.php' . "\n\n";
	echo 'Here is your sitemap index: ' . $google->base_url . 'sitemapindex.xml' . "\n";
	echo 'Here is your product sitemap: ' . $google->base_url . 'sitemapproducts.xml' . "\n";
	echo 'Here is your category sitemap: ' . $google->base_url . 'sitemapcategories.xml' . "\n";
	
  if ($showManufacturers)
    echo 'Here is your manufacturers sitemap: ' . $google->base_url . 'sitemapmanufacturers.xml' . "\n";
  
  if ($showSpecials)
  	echo 'Here is your specials sitemap: ' . $google->base_url . 'sitemapspecials.xml' . "\n";
} else {
	print_r($google->debug);
}

echo '</pre>';
include_once 'includes/application_bottom.php';
?>