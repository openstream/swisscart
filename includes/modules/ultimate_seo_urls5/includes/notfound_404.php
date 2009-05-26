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
 * @author Robert Fisher, FWR Media, http://www.fwrmedia.co.uk 
 * @lastdev $Author:: Rob                                              $:  Author of last commit
 * @lastmod $Date:: 2009-05-20 20:46:12 +0100 (Wed, 20 May 2009)       $:  Date of last commit
 * @version $Rev:: 44                                                  $:  Revision of last commit
 * @Id $Id:: notfound_404.php 44 2009-05-20 19:46:12Z Rob              $:  Full Details   
 */

header("HTTP/1.0 404 Not Found");
?>
<title>Die Seite wurde leider nicht gefunden (404 Page Not Found)</title>
<div style="margin: 50 auto; width: 600px; border: 1px dotted #D02F30; font-family: Verdana, Geneva, sans-serif; font-size: 12px; "> 
  <div style="padding: 10px; ">
    <img src="http://demo.swisscart.com/admin/images/swisscart.gif" alt="swisscart&reg;, die Schweizer Webshop L&ouml;sung" />
    <h1 style="font-size: 16px; color: #666; ">Die Seite wurde leider nicht gefunden / 404 Page Not Found</h1>
    <p>Bitte gehen Sie zur&uuml;ck zur <a href="<?php echo tep_href_link(FILENAME_DEFAULT) ?>">Startseite</a> und benutzen Sie die Produktsuche oder die Kategorienauswahl / Please return to the <a href="<?php echo tep_href_link(FILENAME_DEFAULT) ?>">home page</a></p>
  </div>
</div>
