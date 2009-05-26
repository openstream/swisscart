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
 * @lastmod $Date:: 2009-05-22 11:26:28 +0100 (Fri, 22 May 2009)       $:  Date of last commit
 * @version $Rev:: 56                                                  $:  Revision of last commit
 * @Id $Id:: Usu_Articles.php 56 2009-05-22 10:26:28Z Rob              $:  Full Details   
 */

class Usu_Articles extends aDataMap {

  public $dependency = 'tPath';
  public $dependency_tags;
  private $page_relations;
  private $markers = array('-t-' => 'tPath');
  private $base_query;
  private $query;
  private $link_text;
  private $tPath;
  private $installed = false;
  
  public function __construct(){
    if ( defined('FILENAME_ARTICLES') && defined('TABLE_TOPICS_DESCRIPTION') ){
      $this->dependency_tags = array('-t-' => FILENAME_ARTICLES);
      $this->page_relations = array(FILENAME_ARTICLES => 1);
      $this->base_query = "SELECT topics_name AS tName FROM " . TABLE_TOPICS_DESCRIPTION . " WHERE topics_id=':tPath' AND language_id=':languages_id' LIMIT 1";
      usu::$registry->merge('seo_pages', $this->page_relations);
      usu::$registry->merge('markers', $this->markers);
      usu::$registry->addPageDependency( array(FILENAME_ARTICLES => 'tPath') );
      $this->installed = true;
    }
  }
  
  public function acquire($dependency){
    if ( is_numeric(str_replace('_', '', $dependency)) ){
      $this->tPath = $dependency;
    } else {
      return false;
    }
    if ( strpos($dependency, '_') ){
      $single_tpath = (int)ltrim(strrchr($dependency, '_'), '_');
    } else {
      $single_tpath = (int)$dependency;
    }  
    // Bypass the query if already in the registry
    if ( false !== isset(usu::$registry->{$this->dependency}[$this->tPath]) ){
      usu::$performance['queries_saved']++;
      return true;
    }
    $placeholders = array( ':tPath', ':languages_id' );
    // $values are already type cast
    $values = array( $single_tpath, usu::$languages_id );
    $this->query = str_replace($placeholders, $values, $this->base_query);
    $result = usu::query( $this->query );
    $this->query = null;
    $row = tep_db_fetch_array( $result );
    tep_db_free_result( $result );
    if ( false === $row ){
      return false;
    }
    $this->link_text = $this->linkText($row['tName']);

    if ( false === isset(usu::$registry->{$this->dependency}) ){
      usu::$registry->{$this->dependency} = array();
    }
    usu::$registry->attach($this->dependency, $this->tPath, $this->getProperties());
  } // End method
   
   protected function getProperties(){
     $properties = get_object_vars($this);
     unset($properties['page_relations']);
     return $properties;  
   } // End method
   
   public function buildLink($page, $valuepair, &$url, &$added_qs, $parameters){
     if ( ($valuepair[0] != $this->dependency) || (false === array_key_exists(1, $valuepair)) || (false === $this->installed) ){
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
       case ( $page == FILENAME_ARTICLES ):
         $url = $this->linkCreate(FILENAME_ARTICLES, $reg_item['link_text'], '-t-', $valuepair[1]);
         break;
       default:
         $added_qs[filter_var($valuepair[0], FILTER_SANITIZE_STRING)] = usu::cleanse($valuepair[1]);
         break;                                        
     } # end switch
  }
}  
?>