<?php
/*
  $Id: sitemap.php,v1.0 2004/05/25 devosc Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2003 osCommerce

  Released under the GNU General Public License

  Compatibility with Extra Pages-InfoBox CROSSOVER

	Use if you have installed the contribution Extra pages-info box w/ admin 
	http://www.oscommerce.com/community/contributions,2021

*/

  require('includes/application_top.php');

  require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_SITEMAP);

  $breadcrumb->add(NAVBAR_TITLE, tep_href_link(FILENAME_SITEMAP));
?>
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">
<html <?php echo HTML_PARAMS; ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>">
<title><?php echo TITLE; ?></title>
<base href="<?php echo (($request_type == 'SSL') ? HTTPS_SERVER : HTTP_SERVER) . DIR_WS_CATALOG; ?>">
<link rel="stylesheet" type="text/css" href="<?php echo DIR_WS_MODULES . STYLE_SHEET ?>">
<script language="javascript" src="includes/siir/external.js"></script>
</head>
<body marginwidth="0" marginheight="0" topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0">
<!-- header //-->
<?php require(DIR_WS_INCLUDES . 'header.php'); ?>
<!-- header_eof //-->

<!-- body //-->
<table border="0" width="100%" cellspacing="3" cellpadding="3">
  <tr>
    <td width="<?php echo BOX_WIDTH; ?>" valign="top"><table border="0" width="<?php echo BOX_WIDTH; ?>" cellspacing="0" cellpadding="2">
<!-- left_navigation //-->
<?php require(DIR_WS_INCLUDES . 'column_left.php'); ?>
<!-- left_navigation_eof //-->
    </table></td>
<!-- body_text //-->
    <td width="100%" valign="top"><table border="0" width="100%" cellspacing="0" cellpadding="0">
      <tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td><h1 class="pageHeading"><?php echo HEADING_TITLE; ?></h1></td>
            <td class="pageHeading" align="right"><?php //echo tep_image(DIR_WS_IMAGES . 'table_background_specials.gif', HEADING_TITLE, HEADING_IMAGE_WIDTH, HEADING_IMAGE_HEIGHT); ?></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_separator('pixel_trans.gif', '100%', '10'); ?></td>
      </tr>
      <tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="5" class="bigbox">
          <tr>
            <td class="main"><br>
                <table border="0" width="100%" cellspacing="1" cellpadding="2" id="sitemap">
                  <tr>
                    <td valign="top" class="main"><?php require DIR_WS_CLASSES . 'category_tree.php'; $osC_CategoryTree = new osC_CategoryTree; echo $osC_CategoryTree->buildTree(); ?>
                      <ul>
                        <li><?php echo '<a href="' . tep_href_link(FILENAME_ACCOUNT, '', 'SSL') . '">' . PAGE_ACCOUNT . '</a>'; ?></li>
                        <ul>
                          <li><?php echo '<a href="' . tep_href_link(FILENAME_ACCOUNT_EDIT, '', 'SSL') . '">' . PAGE_ACCOUNT_EDIT . '</a>'; ?></li>
                          <li><?php echo '<a href="' . tep_href_link(FILENAME_ADDRESS_BOOK, '', 'SSL') . '">' . PAGE_ADDRESS_BOOK . '</a>'; ?></li>
                          <li><?php echo '<a href="' . tep_href_link(FILENAME_ACCOUNT_HISTORY, '', 'SSL') . '">' . PAGE_ACCOUNT_HISTORY . '</a>'; ?></li>
                          <li><?php echo '<a href="' . tep_href_link(FILENAME_ACCOUNT_NEWSLETTERS, '', 'SSL') . '">' . PAGE_ACCOUNT_NOTIFICATIONS . '</a>'; ?></li>
                        </ul>
                        <li><?php echo '<a href="' . tep_href_link(FILENAME_SHOPPING_CART) . '">' . PAGE_SHOPPING_CART . '</a>'; ?></li>
                        <li><?php echo '<a href="' . tep_href_link(FILENAME_CHECKOUT_SHIPPING, '', 'SSL') . '">' . PAGE_CHECKOUT_SHIPPING . '</a>'; ?></li>
                        <li><?php echo '<a href="' . tep_href_link(FILENAME_ADVANCED_SEARCH) . '">' . PAGE_ADVANCED_SEARCH . '</a>'; ?></li>
                        <li><?php echo '<a href="' . tep_href_link(FILENAME_PRODUCTS_NEW) . '">' . PAGE_PRODUCTS_NEW . '</a>'; ?></li>
                        <li><?php echo '<a href="' . tep_href_link(FILENAME_SPECIALS) . '">' . PAGE_SPECIALS . '</a>'; ?></li>
                        <li><?php echo '<a href="' . tep_href_link(FILENAME_REVIEWS) . '">' . PAGE_REVIEWS . '</a>'; ?></li>
                        <li><?php echo BOX_HEADING_INFORMATION; ?></li>
                        <ul>
                          <?php
// Info Pages ADDED BEGIN 
$page_query = tep_db_query("select information_id, sort_order, visible, information_title, information_description
                            from 
                               " . TABLE_INFORMATION . " 
                            where 
                               visible = 1
                            and
                               language_id = '" . (int)$languages_id . "'
                            and
                               sort_order > 0 and information_id > 5 order by sort_order, information_title");
						   
$rows = 0;

while ($page = tep_db_fetch_array($page_query)) {
  $rows++;
  $link = FILENAME_INFORMATION . '?info_id=' . $page['information_id'];
  echo '<li><a href="' . tep_href_link($link) . '">' . $page['information_title'] . '</a></li>';
}
  echo '<li><a href="' . tep_href_link(FILENAME_CONTACT_US) . '">' . BOX_INFORMATION_CONTACT . '</a></li>';
  echo '<li><a href="' . tep_href_link(FILENAME_SITEMAP) . '">' . BOX_INFORMATION_SITEMAP . '</a></li>';      
// Info Pages ADDED END
?>
                        </ul>
                      </ul>
                      <p>&nbsp;</p></td>
                    </tr>
              </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
<!-- body_text_eof //-->
    <td width="<?php echo BOX_WIDTH; ?>" valign="top"><table border="0" width="<?php echo BOX_WIDTH; ?>" cellspacing="0" cellpadding="2">
<!-- right_navigation //-->
<?php require(DIR_WS_INCLUDES . 'column_right.php'); ?>
<!-- right_navigation_eof //-->
    </table></td>
  </tr>
</table>
<!-- body_eof //-->

<!-- footer //-->
<?php require(DIR_WS_INCLUDES . 'footer.php'); ?>
<!-- footer_eof //-->
<br>
</body>
</html>
<?php require(DIR_WS_INCLUDES . 'application_bottom.php'); ?>
