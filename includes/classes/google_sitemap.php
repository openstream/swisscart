<?php
/**
 * Google XML Sitemap Feed
 *
 * The Google sitemap service was announced on 2 June 2005 and represents
 * a huge development in terms of crawler technology.  This contribution is
 * designed to create the sitemap XML feed per the specification delineated
 * by Google.
 * @package Google-XML-Sitemap-Feed
 * @license http://opensource.org/licenses/gpl-license.php GNU Public License
 * @version 1.0
 * @link http://www.oscommerce-freelancers.com/ osCommerce-Freelancers
 * @link http://www.google.com/webmasters/sitemaps/docs/en/about.html About Google Sitemap
 * @copyright Copyright 2005, Bobby Easland
 * @author Bobby Easland
 * @filesource
 */

/**
 * MySQL_Database Class
 *
 * The MySQL_Database class provides abstraction so the databaes can be accessed
 * without having to use tep API functions. This class has minimal error handling
 * so make sure your code is tight!
 * @package Google-XML-Sitemap-Feed
 * @license http://opensource.org/licenses/gpl-license.php GNU Public License
 * @version 1.1
 * @link http://www.oscommerce-freelancers.com/ osCommerce-Freelancers
 * @copyright Copyright 2005, Bobby Easland
 * @author Bobby Easland
 */

/**
 * Google Sitemap Base Class
 *
 * The MySQL_Database class provides abstraction so the databaes can be accessed
 * @package Google-XML-Sitemap-Feed
 * @license http://opensource.org/licenses/gpl-license.php GNU Public License
 * @version 1.2
 * @link http://www.oscommerce-freelancers.com/ osCommerce-Freelancers
 * @link http://www.google.com/webmasters/sitemaps/docs/en/about.html About Google Sitemap
 * @copyright Copyright 2005, Bobby Easland
 * @author Bobby Easland
 */
class GoogleSitemap{
	/**
	* $filename is the base name of the feeds (i.e. - 'sitemap')
	* @var string
	*/
	var $filename;
	/**
	* $savepath is the path where the feeds will be saved - store root
	* @var string
	*/
	var $savepath;
	/**
	* $base_url is the URL for the catalog
	* @var string
	*/
	var $base_url;
	/**
	* $debug holds all the debug data
	* @var array
	*/
	var $debug;


/**
 * GoogleSitemap class constructor
 * @author Bobby Easland
 * @version 1.0
 * @param string $host Database host setting (i.e. - localhost)
 * @param string $user Database user
 * @param string $db Database name
 * @param string $pass Database password
 */
	function GoogleSitemap(){
		$this->filename = "sitemap";
		$this->savepath = DIR_FS_CATALOG;
		$this->base_url = HTTP_SERVER . DIR_WS_HTTP_CATALOG;
		$this->debug = array();
	} # end class constructor

/**
 * Function to save the sitemap data to file as either XML or XML.GZ format
 * @author Bobby Easland
 * @version 1.1
 * @param string $data XML data
 * @param string $type Feed type (index, products, categories)
 * @return boolean
 */
	function SaveFile($data, $type){
		$filename = $this->savepath . $this->filename . $type;
		$compress = defined('GOOGLE_SITEMAP_COMPRESS') ? GOOGLE_SITEMAP_COMPRESS : 'false';
		if ($type == 'index') $compress = 'false';
		switch($compress){
			case 'true':
				$filename .= '.xml.gz';
				if ($gz = gzopen($filename,'wb9')){
					gzwrite($gz, $data);
					gzclose($gz);
					$this->debug['SAVE_FILE_COMPRESS'][] = array('file' => $filename, 'status' => 'success', 'file_exists' => 'true');
					return true;
				} else {
					$file_check = file_exists($filename) ? 'true' : 'false';
					$this->debug['SAVE_FILE_COMPRESS'][] = array('file' => $filename, 'status' => 'failure', 'file_exists' => $file_check);
					return false;
				}
				break;
			default:
				$filename .= '.xml';
				if ($fp = fopen($filename, 'w+')){
						 echo 'Write '.$filename.'<br>';
					fwrite($fp, $data);
					fclose($fp);
					$this->debug['SAVE_FILE_XML'][] = array('file' => $filename, 'status' => 'success', 'file_exists' => 'true');
					return true;
				} else {
					$file_check = file_exists($filename) ? 'true' : 'false';
					$this->debug['SAVE_FILE_XML'][] = array('file' => $filename, 'status' => 'failure', 'file_exists' => $file_check);
					return false;
				}
				break;
		} # end switch
	} # end function

/**
 * Function to compress a normal file
 * @author Bobby Easland
 * @version 1.0
 * @param string $file
 * @return boolean
 */
	function CompressFile($file){
		$source = $this->savepath . $file . '.xml';
		$filename = $this->savepath . $file . '.xml.gz';
		$error_encountered = false;
		if( $gz_out = gzopen($filename, 'wb9') ){
			if($fp_in = fopen($source,'rb')){
				while(!feof($fp_in)) gzwrite($gz_out, fread($fp_in, 1024*512));
					fclose($fp_in);

			} else {
				$error_encountered = true;
			}
			gzclose($gz_out);
		} else {
			$error_encountered = true;
		}
		if($error_encountered){
			return false;
		} else {
			return true;
		}
	} # end function

/**
 * Function to generate sitemap file from data
 * @author Bobby Easland
 * @version 1.0
 * @param array $data
 * @param string $file
 * @return boolean
 */
	function GenerateSitemap($data, $file){
		$content = '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
		$content = '<?xml-stylesheet type="text/xsl" href="includes/gss.xsl"?>' . "\n";
		$content .= '<urlset xmlns="http://www.google.com/schemas/sitemap/0.84">' . "\n";
		foreach ($data as $url){
			$content .= "\t" . '<url>' . "\n";
			$content .= "\t\t" . '<loc>'.$url['loc'].'</loc>' . "\n";
			$content .= "\t\t" . '<lastmod>'.$url['lastmod'].'</lastmod>' . "\n";
			$content .= "\t\t" . '<changefreq>'.$url['changefreq'].'</changefreq>' . "\n";
			$content .= "\t\t" . '<priority>'.$url['priority'].'</priority>' . "\n";
			$content .= "\t" . '</url>' . "\n";
		} # end foreach
		$content .= '</urlset>';
		return $this->SaveFile($content, $file);
	} # end function

/**
 * Function to generate sitemap index file
 * @author Bobby Easland
 * @version 1.1
 * @return boolean
 */
	function GenerateSitemapIndex(){
		$content = '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
		$content = '<?xml-stylesheet type="text/xsl" href="includes/gss.xsl"?>' . "\n"; //human readable
		$content .= '<sitemapindex xmlns="http://www.google.com/schemas/sitemap/0.84">' . "\n";
		$pattern = defined('GOOGLE_SITEMAP_COMPRESS')
						 ?	GOOGLE_SITEMAP_COMPRESS == 'true'
							?	"{sitemap*.xml.gz}"
							: 	"{sitemap*.xml}"
					 :	"{sitemap*.xml}";
		foreach ( glob($this->savepath . $pattern, GLOB_BRACE) as $filename ) {
			 if ( preg_match('/index/i', $filename) ) continue;
			 $content .= "\t" . '<sitemap>' . "\n";
			 $content .= "\t\t" . '<loc>'.$this->base_url . basename($filename).'</loc>' . "\n";
			 $content .= "\t\t" . '<lastmod>'.date ("Y-m-d", filemtime($filename)).'</lastmod>' . "\n";
			 $content .= "\t" . '</sitemap>' . "\n";
		} # end foreach
		$content .= '</sitemapindex>';
		return $this->SaveFile($content, 'index');
	} # end function

/**
 * Function to generate product sitemap data
 * @author Bobby Easland
 * @version 1.1
 * @return boolean
 */
	function GenerateProductSitemap(){
		$sql = "SELECT distinct products_id as pID, products_date_added as date_added, products_last_modified as last_mod, products_ordered
					FROM  (" . TABLE_PRODUCTS . " p left join ". TABLE_PRODUCTS_TO_CATEGORIES. " p2c using (products_id) left join ". TABLE_CATEGORIES ." c using (categories_id))
				WHERE c.categories_status=1 and products_status=1
				ORDER BY products_ordered DESC";
		if ( $products_query = tep_db_query($sql) ){
			$this->debug['QUERY']['PRODUCTS']['STATUS'] = 'success';
			$this->debug['QUERY']['PRODUCTS']['NUM_ROWS'] = tep_db_num_rows($products_query);
			$container = array();
			$number = 0;
			$top = 0;
			while( $result = tep_db_fetch_array($products_query) ){
				$top = max($top, $result['products_ordered']);
				$location = tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $result['pID'], 'NONSSL', false);
				$lastmod = tep_not_null($result['last_mod']) ? $result['last_mod'] : $result['date_added'];
				$changefreq = GOOGLE_SITEMAP_PROD_CHANGE_FREQ;
				$ratio = $top > 0 ? $result['products_ordered']/$top : 0;
				$priority = $ratio < .1 ? .1 : number_format($ratio, 1, '.', '');

				$container[] = array('loc' => htmlspecialchars(utf8_encode($location)),
														 'lastmod' => date ("Y-m-d", strtotime($lastmod)),
									 'changefreq' => $changefreq,
									 'priority' => $priority
														 );
				if ( sizeof($container) >= 50000 ){
					$type = $number == 0 ? 'products' : 'products' . $number;
					$this->GenerateSitemap($container, $type);
					$container = array();
					$number++;
				}
			} # end while
			tep_db_free_result($products_query);
			if ( sizeof($container) > 0 ) {
				$type = $number == 0 ? 'products' : 'products' . $number;
				return $this->GenerateSitemap($container, $type);
			} # end if
		} else {
			$this->debug['QUERY']['PRODUCTS']['STATUS'] = 'false';
			$this->debug['QUERY']['PRODUCTS']['NUM_ROWS'] = '0';
		}
	} # end function

/**
 * Funciton to generate category sitemap data
 * @author Bobby Easland
 * @version 1.1
 * @return boolean
 */
	function GenerateCategorySitemap(){
		$sql ='SELECT categories_id as cID, date_added, last_modified as last_mod '.
					' FROM ' . TABLE_CATEGORIES .
					' where categories_status=1 '.
					' ORDER BY parent_id ASC, sort_order ASC, categories_id ASC';
		if ( $categories_query = tep_db_query($sql) ){
			$this->debug['QUERY']['CATEOGRY']['STATUS'] = 'success';
			$this->debug['QUERY']['CATEOGRY']['NUM_ROWS'] = tep_db_num_rows($categories_query);
			$container = array();
			$number = 0;
			while( $result = tep_db_fetch_array($categories_query) ){
				$location =tep_href_link(FILENAME_DEFAULT, 'cPath=' . $this->GetFullcPath($result['cID']), 'NONSSL', false);
				$lastmod = tep_not_null($result['last_mod']) ? $result['last_mod'] : $result['date_added'];
				$changefreq = GOOGLE_SITEMAP_CAT_CHANGE_FREQ;
				$priority = .5;

				$container[] = array('loc' => htmlspecialchars(utf8_encode($location)),
														 'lastmod' => date ("Y-m-d", strtotime($lastmod)),
									 'changefreq' => $changefreq,
									 'priority' => $priority
														 );
				if ( sizeof($container) >= 50000 ){
					$type = $number == 0 ? 'categories' : 'categories' . $number;
					$this->GenerateSitemap($container, $type);
					$container = array();
					$number++;
				}
			} # end while
			tep_db_free_result($categories_query);
			if ( sizeof($container) > 1 ) {
				$type = $number == 0 ? 'categories' : 'categories' . $number;
				return $this->GenerateSitemap($container, $type);
			} # end if
		} else {
			$this->debug['QUERY']['CATEOGRY']['STATUS'] = 'false';
			$this->debug['QUERY']['CATEOGRY']['NUM_ROWS'] = '0';
		}
	} # end function

/**
 * Funciton to generate manufacturer sitemap data
 * @author Jack_mcs from Bobbys code
 * @version 1.1
 * @return boolean
 */
	function GenerateManufacturerSitemap(){
				$sql = "SELECT manufacturers_id as mID, date_added, last_modified as last_mod, manufacturers_name
								FROM " . TABLE_MANUFACTURERS . " order by manufacturers_name DESC";

		if ( $manufacturers_query = tep_db_query($sql) ){
			$this->debug['QUERY']['MANUFACTURERS']['STATUS'] = 'success';
			$this->debug['QUERY']['MANUFACTURERS']['NUM_ROWS'] = tep_db_num_rows($manufacturers_query);
			$container = array();
			$number = 0;
			while( $result = tep_db_fetch_array($manufacturers_query) ){
				$location = tep_href_link(FILENAME_DEFAULT, 'manufacturers_id=' . $result['mID'], 'NONSSL', false);
				$lastmod = tep_not_null($result['last_mod']) ? $result['last_mod'] : $result['date_added'];
				$changefreq = GOOGLE_SITEMAP_MAN_CHANGE_FREQ;
				$priority = .5;

				$container[] = array('loc' => htmlspecialchars(utf8_encode($location)),
														 'lastmod' => date ("Y-m-d", strtotime($lastmod)),
									 'changefreq' => $changefreq,
									 'priority' => $priority
														 );
				if ( sizeof($container) >= 50000 ){
					$type = $number == 0 ? 'manufacturers' : 'manufacturers' . $number;
					$this->GenerateSitemap($container, $type);
					$container = array();
					$number++;
				}
			} # end while
			tep_db_free_result($manufacturers_query);
			if ( sizeof($container) > 0 ) {
				$type = $number == 0 ? 'manufacturers' : 'manufacturers' . $number;
				return $this->GenerateSitemap($container, $type);
			} # end if
		} else {
			$this->debug['QUERY']['MANUFACTURERS']['STATUS'] = 'false';
			$this->debug['QUERY']['MANUFACTURERS']['NUM_ROWS'] = '0';
		}
	} # end function

/**
 * Funciton to generate manufacturer sitemap data
 * @author Jack_mcs from Bobbys code
 * @version 1.1
 * @return boolean
 */
	function GenerateSpecialsSitemap(){
				$sql = "SELECT distinct p.products_id as pID, s.specials_date_added as date_added, s.specials_last_modified as last_mod, p.products_ordered
								FROM (" . TABLE_PRODUCTS . " p left join ". TABLE_PRODUCTS_TO_CATEGORIES. " p2c using (products_id) left join ". TABLE_CATEGORIES ." c using (categories_id)) left join " . TABLE_PRODUCTS_DESCRIPTION . " pd on p.products_id = pd.products_id left join " . TABLE_SPECIALS . " s on pd.products_id = s.products_id
								where c.categories_status=1 and p.products_status = '1' and s.status = '1' order by s.specials_date_added desc ";
		if ( $products_query = tep_db_query($sql) ){
			$this->debug['QUERY']['SPECIALS']['STATUS'] = 'success';
			$this->debug['QUERY']['SPECIALS']['NUM_ROWS'] = tep_db_num_rows($products_query);
			$container = array();
			$number = 0;
			$top = 0;
			while( $result = tep_db_fetch_array($products_query) ){
				$top = max($top, $result['products_ordered']);
				$location = tep_href_link(FILENAME_PRODUCT_INFO, 'products_id=' . $result['pID'], 'NONSSL', false);
				$lastmod = tep_not_null($result['last_mod']) ? $result['last_mod'] : $result['date_added'];
				$changefreq = GOOGLE_SITEMAP_SPECIALS_CHANGE_FREQ;
				$ratio = $top > 0 ? $result['products_ordered']/$top : 0;
				$priority = $ratio < .1 ? .1 : number_format($ratio, 1, '.', '');

				$container[] = array('loc' => htmlspecialchars(utf8_encode($location)),
														 'lastmod' => date ("Y-m-d", strtotime($lastmod)),
									 'changefreq' => $changefreq,
									 'priority' => $priority
														 );
				if ( sizeof($container) >= 50000 ){
					$type = $number == 0 ? 'specials' : 'specials' . $number;
					$this->GenerateSitemap($container, $type);
					$container = array();
					$number++;
				}
			} # end while
			tep_db_free_result($products_query);
			if ( sizeof($container) > 0 ) {
				$type = $number == 0 ? 'specials' : 'specials' . $number;
				$ret = $this->GenerateSitemap($container, $type);
				return $ret;
			} # end if
		} else {
			$this->debug['QUERY']['SPECIALS']['STATUS'] = 'false';
			$this->debug['QUERY']['SPECIALS']['NUM_ROWS'] = '0';
		}
	} # end function

/**
 * Function to retrieve full cPath from category ID
 * @author Bobby Easland
 * @version 1.0
 * @param mixed $cID Could contain cPath or single category_id
 * @return string Full cPath string
 */
	function GetFullcPath($cID){
		if ( preg_match('/_/', $cID) ){
			return $cID;
		} else {
			$c = array();
			$this->GetParentCategories($c, $cID);
			$c = array_reverse($c);
			$c[] = $cID;
			$cID = sizeof($c) > 1 ? implode('_', $c) : $cID;
			return $cID;
		}
	} # end function

/**
 * Recursion function to retrieve parent categories from category ID
 * @author Bobby Easland
 * @version 1.0
 * @param mixed $categories Passed by reference
 * @param integer $categories_id
 */
	function GetParentCategories(&$categories, $categories_id) {
		$sql = "SELECT parent_id
						FROM " . TABLE_CATEGORIES . "
				WHERE categories_id='" . (int)$categories_id . "'";
		$parent_categories_query = tep_db_query($sql);
		while ($parent_categories = tep_db_fetch_array($parent_categories_query)) {
			if ($parent_categories['parent_id'] == 0) return true;
			$categories[sizeof($categories)] = $parent_categories['parent_id'];
			if ($parent_categories['parent_id'] != $categories_id) {
				$this->GetParentCategories($categories, $parent_categories['parent_id']);
			}
		}
	} # end function

/**
 * Utility function to read and return the contents of a GZ formatted file
 * @author Bobby Easland
 * @version 1.0
 * @param string $file File to open
 * @return string
 */
	function ReadGZ( $file ){
		$file = $this->savepath . $file;
		$lines = gzfile($file);
		return implode('', $lines);
	} # end function

/**
 * Utility function to generate the submit URL
 * @author Bobby Easland
 * @version 1.0
 * @return string
 */
	function GenerateSubmitURL(){
		$url = urlencode($this->base_url . 'sitemapindex.xml');
		return htmlspecialchars(utf8_encode('http://www.google.com/webmasters/sitemaps/ping?sitemap=' . $url));
	} # end function
} #  end class
?>