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
 * @lastmod $Date:: 2009-05-19 11:36:38 +0100 (Tue, 19 May 2009)       $:  Date of last commit
 * @version $Rev:: 39                                                  $:  Revision of last commit
 * @Id $Id:: Usu_PopUpImage.php 39 2009-05-19 10:36:38Z Rob            $:  Full Details   
 */

class Usu_PopUpImage extends aDataMap {

  public $dependency = 'pID';
  public $dependency_tags = array('-pi-' => FILENAME_POPUP_IMAGE);
  private $page_relations = array(FILENAME_POPUP_IMAGE => 1);
  private $markers = array('-pi-' => 'pID');
  private $link_text;
  private $pID;
  
  public function __construct(){
    usu::$registry->merge('seo_pages', $this->page_relations);
    usu::$registry->merge('markers', $this->markers);
    usu::$registry->addPageDependency( array(FILENAME_POPUP_IMAGE => 'pID') );
  }
  
  public function acquire($dependency){
    $this->pID = $dependency;  

    // Already set by product_info.php
    $this->link_text = usu::$registry->vars['products_id'][$this->pID]['link_text'];

    if ( false === isset(usu::$registry->{$this->dependency}) ){
      usu::$registry->{$this->dependency} = array();
    }
    usu::$registry->attach($this->dependency, $this->pID, $this->getProperties());
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
     }
     $reg_item = usu::$registry->vars[$valuepair[0]][$valuepair[1]];
     switch(true){
       case ( $page == FILENAME_POPUP_IMAGE ):
         $url = $this->linkCreate(FILENAME_POPUP_IMAGE, $reg_item['link_text'], '-pi-', $valuepair[1]);
         break;
       default:
         $added_qs[filter_var($valuepair[0], FILTER_SANITIZE_STRING)] = usu::cleanse($valuepair[1]);
         break;                                        
     } # end switch
  }
}  
?>