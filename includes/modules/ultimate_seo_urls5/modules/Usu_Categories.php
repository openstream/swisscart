<?php
 /**
 *
 * ULTIMATE Seo Urls 5
 *
 * 
 * @package Ultimate Seo Urls 5
 * @license http://www.opensource.org/licenses/gpl-2.0.php GNU Public License
 * @link http://www.fwrmedia.co.uk
 * @copyright Copyright 2008-2009 FWR Media
 * @copyright Portions Copyright 2005 Bobby Easland
 * @author Robert Fisher, FWR Media, http://www.fwrmedia.co.uk 
 * @lastdev $Author:: Rob                                              $:  Author of last commit
 * @lastmod $Date:: 2009-05-22 10:13:19 +0100 (Fri, 22 May 2009)       $:  Date of last commit
 * @version $Rev:: 54                                                  $:  Revision of last commit
 * @Id $Id:: Usu_Categories.php 54 2009-05-22 09:13:19Z Rob            $:  Full Details   
 */

class Usu_Categories extends aDataMap {

  public $dependency = 'cPath';
  public $dependency_tags = array('-c-' => FILENAME_DEFAULT);
  private $page_relations = array(FILENAME_DEFAULT => 1);
  private $markers = array('-c-' => 'cPath');
  private $base_query;
  private $query;
  private $catname;
  private $parentname;
  private $cPath;
  
  public function __construct(){
    $this->base_query = "SELECT c.categories_id AS id, c.parent_id, cd.categories_name AS cName, cd2.categories_name AS pName FROM " . TABLE_CATEGORIES . " c LEFT JOIN " . TABLE_CATEGORIES_DESCRIPTION . " cd2 ON c.parent_id = cd2.categories_id AND c.parent_id = cd2.categories_id AND cd2.language_id = :languages_id, categories_description cd WHERE c.categories_id = cd.categories_id AND c.categories_id = :cid AND cd.language_id = :languages_id";
    usu::$registry->merge('seo_pages', $this->page_relations);
    usu::$registry->merge('markers', $this->markers);
    usu::$registry->addPageDependency( array(FILENAME_DEFAULT => 'cPath'));
  }
  
  public function acquire($dependency){
    $this->cPath = $dependency;
    if ( strpos($dependency, '_') ){
      $single_cid = (int)ltrim(strrchr($dependency, '_'), '_');
    } else {
      $single_cid = (int)$dependency;
    }   
    // Bypass the query if already in the registry
    if ( false !== isset(usu::$registry->{$this->dependency}[$this->cPath]) ){
      usu::$performance['queries_saved']++;
      return true;
    }
    $placeholders = array( ':cid', ':languages_id' );
    // $values are already type cast
    $values = array( $single_cid, usu::$languages_id );
    $this->query = str_replace($placeholders, $values, $this->base_query);
    $result = usu::query( $this->query );
    $this->query = null;
    $row = tep_db_fetch_array( $result );
    tep_db_free_result( $result );
    if ( false === $row ){
      return false;
    }
    $this->catname = $this->linkText($row['cName']);
    $this->parentname = tep_not_null($row['pName']) ? $this->linkText($row['pName']) : 'false';

    if ( false === isset(usu::$registry->{$this->dependency}) ){
      usu::$registry->{$this->dependency} = array();
    }
    usu::$registry->attach($this->dependency, $this->cPath, $this->getProperties());
  } // End method
   
   protected function getProperties(){
     $properties = get_object_vars($this);
     unset($properties['page_relations']);
     return $properties;  
   } // End method
   
   function get_full_cPath($cID, &$original){
     if ( is_numeric(strpos($cID, '_')) ){
       $temp = @explode('_', $cID);
       $original = $temp[count($temp)-1];
       return $cID;
     } else {
       $c = array();
       $this->GetParentCategories($c, $cID);
       $c = array_reverse($c);
       $c[] = $cID;
       $original = $cID;
       $cID = count($c) > 1 ? implode('_', $c) : $cID;
       return $cID;
     }
   } // End method
   
   function GetParentCategories(&$categories, $categories_id) {
     $sql = "SELECT parent_id 
     FROM " . TABLE_CATEGORIES . " 
     WHERE categories_id='" . (int)$categories_id . "'";
     $parent_categories_query = tep_db_query($sql);
     while ($parent_categories = tep_db_fetch_array($parent_categories_query)) {
       if ($parent_categories['parent_id'] == 0){
         return true;
       }
       $categories[count($categories)] = $parent_categories['parent_id'];
       if ($parent_categories['parent_id'] != $categories_id) {
         $this->GetParentCategories($categories, $parent_categories['parent_id']);
       }
     }
     tep_db_free_result($parent_categories_query);
   } // End method
   
   public function buildLink($page, $valuepair, &$url, &$added_qs, $parameters){
     if ( ($valuepair[0] != $this->dependency) || (false === array_key_exists(1, $valuepair)) ){
       return false;
     }
     // cache the category => parent relationship in the registry
     if ( false === array_key_exists('fullpaths', usu::$registry->vars) ){
       usu::$registry->vars['fullpaths'] = array();
     }
     if ( false === array_key_exists($valuepair[1], usu::$registry->vars['fullpaths']) ){
       $valuepair[1] = $this->get_full_cPath($valuepair[1], $original);
       if ( false !== strpos($valuepair[1], '_') ){
         $lastnum = ltrim(strrchr($valuepair[1], '_'), '_');
         if ( is_numeric($lastnum) ){
           usu::$registry->vars['fullpaths'][$lastnum] = $valuepair[1];
         }
       }
     } else {
       usu::$performance['queries_saved']++;
       $valuepair[1] = usu::$registry->vars['fullpaths'][$valuepair[1]]; 
     }
     // End cache the category => parent relationship in the registry
     if ( !isset(usu::$registry->vars[$valuepair[0]][$valuepair[1]]) ){
       if ( false === $this->acquire($valuepair[1]) ){
         return false;
       }
     } else {
       usu::$performance['queries_saved']++;
     }
     $reg_item = usu::$registry->vars[$valuepair[0]][$valuepair[1]];
     if ( defined('SEO_ADD_CAT_PARENT') && (SEO_ADD_CAT_PARENT == 'true') && ($reg_item['parentname'] != 'false') ){
       $link_text = $reg_item['parentname'] . '-' . $reg_item['catname'];
     } else {
       $link_text = $reg_item['catname'];
     }
     switch(true){
       case ($page == FILENAME_DEFAULT):
         $url = $this->linkCreate(FILENAME_DEFAULT, $link_text, '-c-', $valuepair[1]);
         break;
       case ( false === strpos($valuepair[1], '{') ):
         if ( SEO_ADD_CPATH_TO_PRODUCT_URLS == 'true' ){
           $added_qs[filter_var($valuepair[0], FILTER_SANITIZE_STRING)] = usu::cleanse($valuepair[1]);
         }
         break;
       default:
         $added_qs[filter_var($valuepair[0], FILTER_SANITIZE_STRING)] = usu::cleanse($valuepair[1]);
         break;
     } # end switch
   }
}  
?>