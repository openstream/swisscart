<?php
/*
  $Id: header_tags_popup_help.php,v 1.0 2005/09/22 
   
  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2003 osCommerce
  
  Released under the GNU General Public License
*/
?>
<style type="text/css">
.popupText { font-family: Verdana, Arial, Helvetica, sans-serif; color: #000; font-size: 12px; } 
</style>
<table width="510" border="0" cellpadding="0" cellspacing="0" class="popupText">
  <tr><td><hr class="solid"></td></tr>
  <tr>
   <td class="popupText"><p><b>What are HTTA, HTDA, HTKA and HTCA used for?</b><br><br>
    Header Tags comes with a default set of tags. You can create your own
    set of tags for each page (it comes with some set up, like for index
    and product pages).

<pre>
HT = Header Tags  
T  = Title 
A  = All 
D  = Description
K  = Keywords
C  = Categories *
P  = Categories and Products **
</pre>  
<b>* Note:</b> The HTCA option only works for the index and product_info pages. 
For the index page, it causes the category name to be displayed in the title. For 
the product_info page, if it is checked, the text in the boxes in Text Control will
be appended to the title, description and keywords, respectively.<br><br>

<b>** Note:</b> The HTPA option only works for the product_info page.  If it is checked, the 
name of the category the product is in will be added to the title and meta tags.
<br><br>

If HTTA is set on (checked), then it says display the Header Tags Title All 
(default title plus the one you set up).<br><br>

So if you have the option checked, both titles will be displayed.
Let's say your title is Mysite and the default title is osCommerce.<br>
<pre>
With HTTA on, the title is
 Mysite Oscommerce
With HTTA off, the title is
 Mysite
</pre>
</p>
<p>If the name of the section is in <font color="red">red</font>, it means that that file does not have
the required Header Tags code installed in it. See the Install_Catalog.txt file
for instructions on how to do this.</p>
  </td>
 </tr> 
</table>
