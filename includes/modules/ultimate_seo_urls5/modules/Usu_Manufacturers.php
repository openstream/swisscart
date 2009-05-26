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
 * @Id $Id:: Usu_Manufacturers.php 54 2009-05-22 09:13:19Z Rob         $:  Full Details   
 */

class Usu_Manufacturers extends aDataMap {

  public $dependency = 'manufacturers_id';
  public $dependency_tags = array('-m-' => FILENAME_DEFAULT);
  private $page_relations = array(FILENAME_DEFAULT => 1);
  private $markers = array('-m-' => 'manufacturers_id');
  private $base_query;
  private $query;
  private $link_text;
  private $manufacturers_id;
  
  public function __construct(){
    $this->base_query = "SELECT manufacturers_name FROM " . TABLE_MANUFACTURERS . " WHERE manufacturers_id=':manufacturers_id' LIMIT 1";
    usu::$registry->merge('seo_pages', $this->page_relations);
    usu::$registry->merge('markers', $this->markers);
    usu::$registry->addPageDependency( array(FILENAME_DEFAULT => 'manufacturers_id') );
  }
  
  public function acquire($dependency){
    $this->manufacturers_id = (int)$dependency;  
    // Bypass the query if already in the registry
    if ( false !== isset(usu::$registry->{$this->dependency}[$this->manufacturers_id]) ){
      usu::$performance['queries_saved']++;
      return true;
    }
    $placeholders = array( ':manufacturers_id' );
    // $values are already type cast
    $values = array( $this->manufacturers_id );
    $this->query = str_replace($placeholders, $values, $this->base_query);
    $result = usu::query( $this->query );
    $this->query = null;
    $row = tep_db_fetch_array( $result );
    tep_db_free_result( $result );
    if ( false === $row ){
      return false;
    }
    $this->link_text = $this->linkText($row['manufacturers_name']);

    if ( false === isset(usu::$registry->{$this->dependency}) ){
      usu::$registry->{$this->dependency} = array();
    }
    usu::$registry->attach($this->dependency, $this->manufacturers_id, $this->getProperties());
  } // End method
   
   protected function getProperties(){
     $properties = get_object_vars($this);
     unset($properties['page_relations']);
     return $properties;  
   } // End method
   
   public function buildLink($page, $valuepair, &$url, &$added_qs, $parameters){
     if ( ($valuepair[0] != $this->dependency) || (false === array_key_exists(1, $valuepair)) ){
       return false;
     }
     if ( !isset(usu::$registry->vars[$valuepair[0]][$valuepair[1]]) ){
       if ( false === $this->acquire($valuepair[1]) ){
         return false;
       }
     } else {
       usu::$performance['queries_saved']++;
     }
     $reg_item = usu::$registry->vars[$valuepair[0]][$valuepair[1]];
     switch(true){
       case ( ($page == FILENAME_DEFAULT) && (false === strpos($parameters, 'cPath')) ):
         $url = $this->linkCreate(FILENAME_DEFAULT, $reg_item['link_text'], '-m-', $valuepair[1]);
         break;
       case ($page == FILENAME_PRODUCT_INFO):
         break;
       default:
         $added_qs[filter_var($valuepair[0], FILTER_SANITIZE_STRING)] = usu::cleanse($valuepair[1]);
         break;                                        
     } # end switch
  }
}  
?>