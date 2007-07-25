<TR>
  <TD class="pageHeading" colspan="3"><?=$pageTitle?></TD>
</TR>
<FORM ACTION="<?=$PHP_SELF?>" NAME="SELECT_PRODUCT" METHOD="POST">
  <INPUT TYPE="HIDDEN" NAME="action" VALUE="select">
  <?
echo "<TR>";
echo "<TD class=\"main\"><BR><B>Please select a product to edit:<BR></TD>";
echo "</TR>";
echo "<TR>";
echo "<TD class=\"main\"><SELECT NAME=\"current_product_id\">";

$query = "SELECT * FROM products_description where products_id LIKE '%' AND language_id = '$languageFilter' ORDER BY products_name ASC";

$result = mysql_query($query) or die(mysql_error());

$matches = mysql_num_rows($result);

if ($matches) {

   while ($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
                                                           	
        $title = $line['products_name'];
        $current_product_id = $line['products_id'];
        
        echo "<OPTION VALUE=\"" . $current_product_id . "\">" . $title;
        
   }
} else { echo "You have no products at this time."; }
   
echo "</SELECT>";
echo "</TD></TR>";

echo "<TR>";
echo "<TD class=\"main\"><input type=\"image\" src=\"" . $adminImages . "button_edit.gif\"></TD>";
echo "</TR>";
?>
</FORM>
<tr>
  <td>&nbsp;</td>
</tr>
<tr>
  <td class="pageHeading">How does it work?</td>
</tr>
<tr>
  <td class="main"><p>This is a short tutorial for using the Advanced Attribute Manager.</p>
    <p><strong>1st step:</strong><br />
      Use the original <em>Product Attributes</em> section that came with swisscart&reg; to create your Product Options and the values associated with the  option.</p>
    <p>Example. Your selling Product X, and your customer can upgrade from  Product X to Product Z for $10. So in the attributes screen you create  a product options (left menu) of &quot;Upgrade to Product Z&quot;. Then in the  Options Values menu (right menu) choose from the drop down &quot;upgrade to  product Z&quot; and in your language of choice enter &quot;yes&quot;. Then repeat the  step except changing &quot;yes&quot; to &quot;no&quot;. So you have a yes option and a no  option to upgrade.</p>
    <p><strong>2nd step:</strong><br />
      Click on the <em>Advanced Attributes Manager</em> link on the bottom of the default product attributes page (if you read this you've probably already done that). You  should now have a drop down menu with your Product X listed in there.  Choose it from the drop down menu and hit &quot;Edit&quot;</p>
    <p><strong>3rd Step:</strong><br />
      Check mark the boxes for the options you want to add  to product X. in this case your options are Yes and No. You would check  mark both boxes and enter 0.00 for option No and your upgrade amount  10$ for option Yes.</p>
    <p>The + means add price to purchased product.  The - would subtract or discount the price.</p>
    <p>&nbsp;</p></td>
</tr>
