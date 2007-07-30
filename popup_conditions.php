<?php
/*
  $Id: popup_conditions.php,v 1.5.3 2005/09/23 23:26:23 hpdl Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2003 osCommerce

  Released under the GNU General Public License

  edited by mr_absinthe originalabsinthe.com

*/

  require('includes/application_top.php');

  $navigation->remove_current_page();

   require(DIR_WS_LANGUAGES . $language . '/' . FILENAME_CONDITIONS);
?>
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">
<html <?php echo HTML_PARAMS; ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>">
<base href="<?php echo (($request_type == 'SSL') ? HTTPS_SERVER : HTTP_SERVER) . DIR_WS_CATALOG; ?>">
<title><?php echo TITLE; ?></title>
<link rel="stylesheet" type="text/css" href="stylesheet.css">
</head>
<body style="padding: 10px; ">
<?php
  $info_box_contents = array();
  $info_box_contents[] = array('text' => HEADING_TITLE);

  //new infoBoxHeading($info_box_contents, true, true);
  echo '<div class="pageHeading">' . HEADING_TITLE . '</div>';

  $query = tep_db_query("select information_description from " . TABLE_INFORMATION . " where information_id = '" . CONDITIONS_INFOID . "' and language_id = '" . $GLOBALS['languages_id'] . "'");
  $condition = tep_db_fetch_array($query);

  $info_box_contents = array();
  $info_box_contents[] = array('text' => $condition['information_description']);

  new infoBox($info_box_contents);
?>

<p class="smallText"><?php echo '<a href="javascript:window.close()">&raquo; ' . TEXT_CLOSE_WINDOW . '</a>'; ?></p>

</body>
</html>
<?php require('includes/application_bottom.php'); ?>