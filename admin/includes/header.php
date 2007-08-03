<?php
/*
  $Id: header.php,v 1.19 2002/04/13 16:11:52 hpdl Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2002 osCommerce

  Released under the GNU General Public License
*/

  if ($messageStack->size > 0) {
    echo $messageStack->output();
  }
?>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td><?php echo tep_image(DIR_WS_IMAGES . 'swisscart.gif', 'swisscart&reg;', '126', '29'); ?></td>
    <td align="right">
	<?php if (strstr($_SERVER['PHP_SELF'], FILENAME_DEFINE_NEWS) || strstr($_SERVER['PHP_SELF'], FILENAME_DEFINE_MAINPAGE) || strstr($_SERVER['PHP_SELF'], FILENAME_DEFINE_TERMS) ) { } else {
		$languages = tep_get_languages();
		$languages_array = array();
		$languages_selected = DEFAULT_LANGUAGE;
		for ($i = 0, $n = sizeof($languages); $i < $n; $i++) {
		$languages_array[] = array('id' => $languages[$i]['code'],
		'text' => $languages[$i]['name']);
		if ($languages[$i]['directory'] == $language) {
		$languages_selected = $languages[$i]['code'];
		  }
		}
	?>
    <form name="languages" action="<?php echo 'http://' . $_SERVER['SERVER_NAME'] . $_SERVER['PHP_SELF'] . '?' . $_SERVER['QUERY_STRING']; ?>" method="get">
    <?php echo tep_draw_pull_down_menu('language', $languages_array, $languages_selected, 'onChange="this.form.submit();"'); ?>
    </form><?php } ?></td>
  </tr>
  <tr class="headerBar">
    <td class="headerBarContent">&nbsp;&nbsp;<?php echo '<a href="' . tep_href_link(FILENAME_DEFAULT, '', 'NONSSL') . '" class="headerLink">' . HEADER_TITLE_TOP . '</a>'; ?></td>
    <td class="headerBarContent" align="right"><?php echo '<a href="http://www.swisscart.com" class="headerLink">' . HEADER_TITLE_SUPPORT_SITE . '</a> &nbsp;|&nbsp; <a href="' . tep_catalog_href_link() . '" class="headerLink">' . HEADER_TITLE_ONLINE_CATALOG . '</a> &nbsp;|&nbsp; <a href="' . tep_href_link(FILENAME_DEFAULT, '', 'NONSSL') . '" class="headerLink">' . HEADER_TITLE_ADMINISTRATION . '</a>'; ?>&nbsp;&nbsp;</td>
  </tr>
</table>