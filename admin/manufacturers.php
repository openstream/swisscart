<?php
/*
  $Id: manufacturers.php,v 1.55 2003/06/29 22:50:52 hpdl Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Customized by swisscart�, Swiss Webshop Solutions
  http://www.swisscart.com

  Copyright (c) 2003-2007 osCommerce

  Released under the GNU General Public License
*/

  require('includes/application_top.php');

  $action = (isset($HTTP_GET_VARS['action']) ? $HTTP_GET_VARS['action'] : '');

  if (tep_not_null($action)) {
    switch ($action) {
      case 'insert':
      case 'save':
        if (isset($HTTP_GET_VARS['mID'])) $manufacturers_id = tep_db_prepare_input($HTTP_GET_VARS['mID']);
        $manufacturers_name = tep_db_prepare_input($HTTP_POST_VARS['manufacturers_name']);
		$manufacturers_region = tep_db_prepare_input($HTTP_POST_VARS['manufacturers_region']);
		$manufacturers_country = tep_db_prepare_input($HTTP_POST_VARS['manufacturers_country']);

        $sql_data_array = array('manufacturers_name' => $manufacturers_name,
								'manufacturers_region'=>$manufacturers_region,
								'manufacturers_country'=>$manufacturers_country);

        if ($action == 'insert') {
          $insert_sql_data = array('date_added' => 'now()');

          $sql_data_array = array_merge($sql_data_array, $insert_sql_data);

          tep_db_perform(TABLE_MANUFACTURERS, $sql_data_array);
          $manufacturers_id = tep_db_insert_id();
        } elseif ($action == 'save') {
          $update_sql_data = array('last_modified' => 'now()');

          $sql_data_array = array_merge($sql_data_array, $update_sql_data);

          tep_db_perform(TABLE_MANUFACTURERS, $sql_data_array, 'update', "manufacturers_id = '" . (int)$manufacturers_id . "'");
        }

		if(!empty($manufacturers_image) || (empty($manufacturers_image) && $HTTP_POST_VARS['remove_image']=='on'))
        if ($manufacturers_image = new upload('manufacturers_image', DIR_FS_CATALOG_IMAGES)) {
          tep_db_query("update " . TABLE_MANUFACTURERS . " set manufacturers_image = '" . $manufacturers_image->filename . "' where manufacturers_id = '" . (int)$manufacturers_id . "'");
        }
		
		for($i=1; $i<=5; $i++){
			if(!empty($_FILES['manufacturers_image_' . $i]['name']) || (empty($_FILES['manufacturers_image_' . $i]['name']) && $HTTP_POST_VARS['remove_image_' . $i]=='on'))
			if ($manufacturers_image_x = new upload('manufacturers_image_' . $i, DIR_FS_CATALOG_IMAGES)) {
			  tep_db_query("update " . TABLE_MANUFACTURERS . " set manufacturers_image_".$i." = '" . $manufacturers_image_x->filename . "' where manufacturers_id = '" . (int)$manufacturers_id . "'");
			}
		}

        $languages = tep_get_languages();
        for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
          $manufacturers_url_array = $HTTP_POST_VARS['manufacturers_url'];
          $manufacturers_htc_title_array = $HTTP_POST_VARS['manufacturers_htc_title_tag'];
          $manufacturers_htc_desc_array = $HTTP_POST_VARS['manufacturers_htc_desc_tag'];
          $manufacturers_htc_keywords_array = $HTTP_POST_VARS['manufacturers_htc_keywords_tag'];
          $manufacturers_htc_description_array = $HTTP_POST_VARS['manufacturers_htc_description'];
 		  
          $language_id = $languages[$i]['id'];


          $sql_data_array = array('manufacturers_url' => tep_db_prepare_input($manufacturers_url_array[$language_id]),
           						  'manufacturers_htc_title_tag' => (tep_not_null($manufacturers_htc_title_array[$language_id]) ? tep_db_prepare_input($manufacturers_htc_title_array[$language_id]) : $manufacturers_name),
           						  'manufacturers_htc_desc_tag' => (tep_not_null($manufacturers_htc_desc_array[$language_id]) ? tep_db_prepare_input($manufacturers_htc_desc_array[$language_id]) : $manufacturers_name),
           						  'manufacturers_htc_keywords_tag' => (tep_not_null($manufacturers_htc_keywords_array[$language_id]) ? tep_db_prepare_input($manufacturers_htc_keywords_array[$language_id]) : $manufacturers_name),
           						  'manufacturers_htc_description' => tep_db_prepare_input($manufacturers_htc_description_array[$language_id]));


          if ($action == 'insert') {
            $insert_sql_data = array('manufacturers_id' => $manufacturers_id,
                                     'languages_id' => $language_id);

            $sql_data_array = array_merge($sql_data_array, $insert_sql_data);

            tep_db_perform(TABLE_MANUFACTURERS_INFO, $sql_data_array);
          } elseif ($action == 'save') {
            tep_db_perform(TABLE_MANUFACTURERS_INFO, $sql_data_array, 'update', "manufacturers_id = '" . (int)$manufacturers_id . "' and languages_id = '" . (int)$language_id . "'");
          }
        }

        if (USE_CACHE == 'true') {
          tep_reset_cache_block('manufacturers');
        }
		
        tep_redirect(tep_href_link(FILENAME_MANUFACTURERS, (isset($HTTP_GET_VARS['page']) ? 'page=' . $HTTP_GET_VARS['page'] . '&' : '') . 'mID=' . $manufacturers_id));
        break;
      case 'deleteconfirm':
        $manufacturers_id = tep_db_prepare_input($HTTP_GET_VARS['mID']);

        if (isset($HTTP_POST_VARS['delete_image']) && ($HTTP_POST_VARS['delete_image'] == 'on')) {
          $manufacturer_query = tep_db_query("select manufacturers_image from " . TABLE_MANUFACTURERS . " where manufacturers_id = '" . (int)$manufacturers_id . "'");
          $manufacturer = tep_db_fetch_array($manufacturer_query);

          $image_location = DIR_FS_DOCUMENT_ROOT . DIR_WS_CATALOG_IMAGES . $manufacturer['manufacturers_image'];

          if (file_exists($image_location)) @unlink($image_location);
        }

        tep_db_query("delete from " . TABLE_MANUFACTURERS . " where manufacturers_id = '" . (int)$manufacturers_id . "'");
        tep_db_query("delete from " . TABLE_MANUFACTURERS_INFO . " where manufacturers_id = '" . (int)$manufacturers_id . "'");

        if (isset($HTTP_POST_VARS['delete_products']) && ($HTTP_POST_VARS['delete_products'] == 'on')) {
          $products_query = tep_db_query("select products_id from " . TABLE_PRODUCTS . " where manufacturers_id = '" . (int)$manufacturers_id . "'");
          while ($products = tep_db_fetch_array($products_query)) {
            tep_remove_product($products['products_id']);
          }
        } else {
          tep_db_query("update " . TABLE_PRODUCTS . " set manufacturers_id = '' where manufacturers_id = '" . (int)$manufacturers_id . "'");
        }

        if (USE_CACHE == 'true') {
          tep_reset_cache_block('manufacturers');
        }

        tep_redirect(tep_href_link(FILENAME_MANUFACTURERS, 'page=' . $HTTP_GET_VARS['page']));
        break;
    }
  }
?>
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">
<html <?php echo HTML_PARAMS; ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>">
<title><?php echo TITLE; ?></title>
<link rel="stylesheet" type="text/css" href="includes/stylesheet.css">
<script language="javascript" src="includes/general.js"></script>
<?php
// Tiny MCE WYISIWYG detection and include
$tinymce_imagemanager = (TINYMCE_IMAGEMANAGER_ENABLED == 'true') ? ',imagemanager':'';
if($action== 'new' || $action=='edit') { // prevent hidden fields to be rendered by TinyMCE in preview
	if (file_exists("tiny_mce/tiny_mce.js")) { $tiny_mce = "tiny_mce/tiny_mce.js"; }
	elseif (file_exists("includes/javascript/tiny_mce/tiny_mce.js")) { $tiny_mce = "includes/javascript/tiny_mce/tiny_mce.js"; }
	else $tiny_mce = '';
	if($tiny_mce) {
	echo '<script language="javascript" type="text/javascript" src="' . $tiny_mce . '"></script>
	<script language="javascript" type="text/javascript">
	tinyMCE.init({
	relative_urls : false,
	remove_script_host : true,
	mode : "exact",
	elements : "';
	$languages = tep_get_languages();
	for ($i=0, $n=sizeof($languages); $i<$n; $i++) echo 'manufacturers_htc_description[' . $languages[$i]['id'] . '],';
	echo '",
	language : "' . $languages_selected . '",
	theme : "' . TINYMCE_THEME . '",
	plugins : "table,advhr,advimage,advlink,emotions,flash,contextmenu' . $tinymce_imagemanager . '",';
	// theme_advanced_buttons1_add : "fontselect,fontsizeselect",
	echo 'theme_advanced_buttons2_add : "separator,forecolor",
	theme_advanced_buttons2_add_before: "cut,copy,paste,separator",
	theme_advanced_buttons3_add_before : "tablecontrols,separator",
	theme_advanced_buttons3_add : "emotions,flash,advhr",
	theme_advanced_toolbar_location : "top",
	theme_advanced_toolbar_align : "left",
	theme_advanced_path_location : "bottom",
	extended_valid_elements : "a[name|href|target|title|onclick],img[class|src|border=0|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name],hr[class|width|size|noshade]",
	external_link_list_url : "example_data/example_link_list.js",
	external_image_list_url : "example_data/example_image_list.js",
	flash_external_list_url : "example_data/example_flash_list.js"
	});
	</script>';
	}
}
?>
</head>
<body marginwidth="0" marginheight="0" topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0" bgcolor="#FFFFFF" onLoad="SetFocus();">
<!-- header //-->
<?php require(DIR_WS_INCLUDES . 'header.php'); ?>
<!-- header_eof //-->

<!-- body //-->
<table border="0" width="100%" cellspacing="2" cellpadding="2">
  <tr>
    <td width="<?php echo BOX_WIDTH; ?>" valign="top"><table border="0" width="<?php echo BOX_WIDTH; ?>" cellspacing="1" cellpadding="1" class="columnLeft">
<!-- left_navigation //-->
<?php require(DIR_WS_INCLUDES . 'column_left.php'); ?>
<!-- left_navigation_eof //-->
    </table></td>
<!-- body_text //-->
    <td width="100%" valign="top"><table border="0" width="100%" cellspacing="0" cellpadding="2">
      <tr>
        <td width="100%"><table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td class="pageHeading"><?php echo HEADING_TITLE; ?></td>
            <td class="pageHeading" align="right"><?php echo tep_draw_separator('pixel_trans.gif', HEADING_IMAGE_WIDTH, HEADING_IMAGE_HEIGHT); ?></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td valign="top"><table border="0" width="100%" cellspacing="0" cellpadding="2">
              <tr class="dataTableHeadingRow">
                <td class="dataTableHeadingContent"><?php echo TABLE_HEADING_MANUFACTURERS; ?></td>
                <td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_ACTION; ?>&nbsp;</td>
              </tr>
<?php
  $manufacturers_query_raw = "select m.manufacturers_id, m.manufacturers_name, m.manufacturers_image, m.date_added, m.last_modified, m.manufacturers_region, m.manufacturers_country, m.manufacturers_image_1, m.manufacturers_image_2, m.manufacturers_image_3, m.manufacturers_image_4, m.manufacturers_image_5, mi.manufacturers_htc_title_tag from " . TABLE_MANUFACTURERS . " m LEFT JOIN " .  TABLE_MANUFACTURERS_INFO . " mi on m.manufacturers_id = mi.manufacturers_id where mi.languages_id = '".$languages_id ."' order by m.manufacturers_name";
  $manufacturers_split = new splitPageResults($HTTP_GET_VARS['page'], MAX_DISPLAY_SEARCH_RESULTS, $manufacturers_query_raw, $manufacturers_query_numrows);
  $manufacturers_query = tep_db_query($manufacturers_query_raw);
  while ($manufacturers = tep_db_fetch_array($manufacturers_query)) {
    if ((!isset($HTTP_GET_VARS['mID']) || (isset($HTTP_GET_VARS['mID']) && ($HTTP_GET_VARS['mID'] == $manufacturers['manufacturers_id']))) && !isset($mInfo) && (substr($action, 0, 3) != 'new')) {
      $manufacturer_products_query = tep_db_query("select count(*) as products_count from " . TABLE_PRODUCTS . " where manufacturers_id = '" . (int)$manufacturers['manufacturers_id'] . "'");
      $manufacturer_products = tep_db_fetch_array($manufacturer_products_query);

      $mInfo_array = array_merge($manufacturers, $manufacturer_products);
      $mInfo = new objectInfo($mInfo_array);
    }

    if (isset($mInfo) && is_object($mInfo) && ($manufacturers['manufacturers_id'] == $mInfo->manufacturers_id)) {
      echo '              <tr id="defaultSelected" class="dataTableRowSelected" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)" onclick="document.location.href=\'' . tep_href_link(FILENAME_MANUFACTURERS, 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $manufacturers['manufacturers_id'] . '&action=edit') . '\'">' . "\n";
    } else {
      echo '              <tr class="dataTableRow" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)" onclick="document.location.href=\'' . tep_href_link(FILENAME_MANUFACTURERS, 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $manufacturers['manufacturers_id']) . '\'">' . "\n";
    }
?>
                <td class="dataTableContent"><?php echo $manufacturers['manufacturers_name']; ?></td>
                <td class="dataTableContent" align="right"><?php if (isset($mInfo) && is_object($mInfo) && ($manufacturers['manufacturers_id'] == $mInfo->manufacturers_id)) { echo tep_image(DIR_WS_IMAGES . 'icon_arrow_right.gif'); } else { echo '<a href="' . tep_href_link(FILENAME_MANUFACTURERS, 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $manufacturers['manufacturers_id']) . '">' . tep_image(DIR_WS_IMAGES . 'icon_info.gif', IMAGE_ICON_INFO) . '</a>'; } ?>&nbsp;</td>
              </tr>
<?php
  }
?>
              <tr>
                <td colspan="2"><table border="0" width="100%" cellspacing="0" cellpadding="2">
                  <tr>
                    <td class="smallText" valign="top"><?php echo $manufacturers_split->display_count($manufacturers_query_numrows, MAX_DISPLAY_SEARCH_RESULTS, $HTTP_GET_VARS['page'], TEXT_DISPLAY_NUMBER_OF_MANUFACTURERS); ?></td>
                    <td class="smallText" align="right"><?php echo $manufacturers_split->display_links($manufacturers_query_numrows, MAX_DISPLAY_SEARCH_RESULTS, MAX_DISPLAY_PAGE_LINKS, $HTTP_GET_VARS['page']); ?></td>
                  </tr>
                </table></td>
              </tr>
<?php
  if (empty($action)) {
?>
              <tr>
                <td align="right" colspan="2" class="smallText"><?php echo '<a href="' . tep_href_link(FILENAME_MANUFACTURERS, 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $mInfo->manufacturers_id . '&action=new') . '">' . tep_image_button('button_insert.gif', IMAGE_INSERT) . '</a>'; ?></td>
              </tr>
<?php
  }
?>
            </table></td>
<?php
  $heading = array();
  $contents = array();

  switch ($action) {
    case 'new':
      $heading[] = array('text' => '<b>' . TEXT_HEADING_NEW_MANUFACTURER . '</b>');

      $contents = array('form' => tep_draw_form('manufacturers', FILENAME_MANUFACTURERS, 'action=insert', 'post', 'enctype="multipart/form-data"'));
      $contents[] = array('text' => TEXT_NEW_INTRO);
      $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_NAME . '<br>' . tep_draw_input_field('manufacturers_name'));
	  $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_REGION . '<br>' . tep_draw_input_field('manufacturers_region'));
	  $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_COUNTRY . '<br>' . tep_draw_input_field('manufacturers_country'));
      $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_IMAGE . '<br>' . tep_draw_file_field('manufacturers_image'));
	  $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_IMAGE . '<br>' . tep_draw_file_field('manufacturers_image_1'));
	  $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_IMAGE . '<br>' . tep_draw_file_field('manufacturers_image_2'));
	  $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_IMAGE . '<br>' . tep_draw_file_field('manufacturers_image_3'));
	  $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_IMAGE . '<br>' . tep_draw_file_field('manufacturers_image_4'));
	  $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_IMAGE . '<br>' . tep_draw_file_field('manufacturers_image_5'));

      $manufacturer_inputs_string = '';
      $languages = tep_get_languages();
      for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
        $manufacturer_inputs_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_url[' . $languages[$i]['id'] . ']');
        $manufacturer_htc_title_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_htc_title_tag[' . $languages[$i]['id'] . ']');
        $manufacturer_htc_desc_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_htc_desc_tag[' . $languages[$i]['id'] . ']');
        $manufacturer_htc_keywords_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_htc_keywords_tag[' . $languages[$i]['id'] . ']');
        //$manufacturer_htc_description_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_textarea_field('manufacturers_htc_description[' . $languages[$i]['id'] . ']', 'hard', 30, 5, '');
		$manufacturer_htc_description_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_textarea_field('manufacturers_htc_description[' . $languages[$i]['id'] . ']', 'soft', '70', '15', tep_get_manufacturer_htc_description($mInfo->manufacturers_id, $languages[$i]['id']), 'id="manufacturers_htc_description[' . $languages[$i]['id'] . ']"');
      }
	  
      $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_URL . $manufacturer_inputs_string);
      $contents[] = array('text' => '<br>' . 'Header Tags Manufacturer Title' . $manufacturer_htc_title_string);
      $contents[] = array('text' => '<br>' . 'Header Tags Manufacturer Description' . $manufacturer_htc_desc_string);
      $contents[] = array('text' => '<br>' . 'Header Tags Manufacturer Keywords' . $manufacturer_htc_keywords_string);
      $contents[] = array('text' => '<br>' . 'Header Tags Manufacturer Description' . $manufacturer_htc_description_string);
      $contents[] = array('align' => 'center', 'text' => '<br>' . tep_image_submit('button_save.gif', IMAGE_SAVE) . ' <a href="' . tep_href_link(FILENAME_MANUFACTURERS, 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $HTTP_GET_VARS['mID']) . '">' . tep_image_button('button_cancel.gif', IMAGE_CANCEL) . '</a>');
      break;
    case 'edit':
      $heading[] = array('text' => '<b>' . TEXT_HEADING_EDIT_MANUFACTURER . '</b>');

	  $remove_image = ($mInfo->manufacturers_image == '') ? '' : '<br />' . TEXT_MANUFACTURERS_IMAGE_REMOVE .'&nbsp;<input type="checkbox" id="remove_image" name="remove_image">';
	  $remove_image_1 = ($mInfo->manufacturers_image_1 == '') ? '' : '<br />' . TEXT_MANUFACTURERS_IMAGE_REMOVE .'&nbsp;<input type="checkbox" id="remove_image" name="remove_image_1">';
	  $remove_image_2 = ($mInfo->manufacturers_image_2 == '') ? '' : '<br />' . TEXT_MANUFACTURERS_IMAGE_REMOVE .'&nbsp;<input type="checkbox" id="remove_image" name="remove_image_2">';
	  $remove_image_3 = ($mInfo->manufacturers_image_3 == '') ? '' : '<br />' . TEXT_MANUFACTURERS_IMAGE_REMOVE .'&nbsp;<input type="checkbox" id="remove_image" name="remove_image_3">';
	  $remove_image_4 = ($mInfo->manufacturers_image_4 == '') ? '' : '<br />' . TEXT_MANUFACTURERS_IMAGE_REMOVE .'&nbsp;<input type="checkbox" id="remove_image" name="remove_image_4">';
	  $remove_image_5 = ($mInfo->manufacturers_image_5 == '') ? '' : '<br />' . TEXT_MANUFACTURERS_IMAGE_REMOVE .'&nbsp;<input type="checkbox" id="remove_image" name="remove_image_5">';

      $contents = array('form' => tep_draw_form('manufacturers', FILENAME_MANUFACTURERS, 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $mInfo->manufacturers_id . '&action=save', 'post', 'enctype="multipart/form-data"'));
      $contents[] = array('text' => TEXT_EDIT_INTRO);
      $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_NAME . '<br>' . tep_draw_input_field('manufacturers_name', $mInfo->manufacturers_name));
	  $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_REGION . '<br>' . tep_draw_input_field('manufacturers_region', $mInfo->manufacturers_region));
	  $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_COUNTRY . '<br>' . tep_draw_input_field('manufacturers_country', $mInfo->manufacturers_country));
      $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_IMAGE . '<br>' . tep_draw_file_field('manufacturers_image') . '<br>' . $mInfo->manufacturers_image . $remove_image);
	  $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_IMAGE . '<br>' . tep_draw_file_field('manufacturers_image_1') . '<br>' . $mInfo->manufacturers_image_1 . $remove_image_1);
	  $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_IMAGE . '<br>' . tep_draw_file_field('manufacturers_image_2') . '<br>' . $mInfo->manufacturers_image_2 . $remove_image_2);
	  $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_IMAGE . '<br>' . tep_draw_file_field('manufacturers_image_3') . '<br>' . $mInfo->manufacturers_image_3 . $remove_image_3);
	  $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_IMAGE . '<br>' . tep_draw_file_field('manufacturers_image_4') . '<br>' . $mInfo->manufacturers_image_4 . $remove_image_4);
	  $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_IMAGE . '<br>' . tep_draw_file_field('manufacturers_image_5') . '<br>' . $mInfo->manufacturers_image_5 . $remove_image_5);

      $manufacturer_inputs_string = '';
      $languages = tep_get_languages();
      for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
        $manufacturer_inputs_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_url[' . $languages[$i]['id'] . ']', tep_get_manufacturer_url($mInfo->manufacturers_id, $languages[$i]['id']));
        $manufacturer_htc_title_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_htc_title_tag[' . $languages[$i]['id'] . ']', tep_get_manufacturer_htc_title($mInfo->manufacturers_id, $languages[$i]['id']));
        $manufacturer_htc_desc_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_htc_desc_tag[' . $languages[$i]['id'] . ']', tep_get_manufacturer_htc_desc($mInfo->manufacturers_id, $languages[$i]['id']));
        $manufacturer_htc_keywords_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('manufacturers_htc_keywords_tag[' . $languages[$i]['id'] . ']', tep_get_manufacturer_htc_keywords($mInfo->manufacturers_id, $languages[$i]['id']));
        //$manufacturer_htc_description_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_textarea_field('manufacturers_htc_description[' . $languages[$i]['id'] . ']', 'hard', 30, 5, tep_get_manufacturer_htc_description($mInfo->manufacturers_id, $languages[$i]['id']));
		$manufacturer_htc_description_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' .tep_draw_textarea_field('manufacturers_htc_description[' . $languages[$i]['id'] . ']', 'soft', '70', '15', tep_get_manufacturer_htc_description($mInfo->manufacturers_id, $languages[$i]['id']), 'id="manufacturers_htc_description[' . $languages[$i]['id'] . ']"');
      }	  

      $contents[] = array('text' => '<br>' . TEXT_MANUFACTURERS_URL . $manufacturer_inputs_string);
      $contents[] = array('text' => '<br>' . 'Header Tags Manufacturer Title' . $manufacturer_htc_title_string);
      $contents[] = array('text' => '<br>' . 'Header Tags Manufacturer Description' . $manufacturer_htc_desc_string);
      $contents[] = array('text' => '<br>' . 'Header Tags Manufacturer Keywords' . $manufacturer_htc_keywords_string);
      $contents[] = array('text' => '<br>' . 'Header Tags Manufacturer Description' . $manufacturer_htc_description_string);
      $contents[] = array('align' => 'center', 'text' => '<br>' . tep_image_submit('button_save.gif', IMAGE_SAVE) . ' <a href="' . tep_href_link(FILENAME_MANUFACTURERS, 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $mInfo->manufacturers_id) . '">' . tep_image_button('button_cancel.gif', IMAGE_CANCEL) . '</a>');
      break;
    case 'delete':
      $heading[] = array('text' => '<b>' . TEXT_HEADING_DELETE_MANUFACTURER . '</b>');

      $contents = array('form' => tep_draw_form('manufacturers', FILENAME_MANUFACTURERS, 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $mInfo->manufacturers_id . '&action=deleteconfirm'));
      $contents[] = array('text' => TEXT_DELETE_INTRO);
      $contents[] = array('text' => '<br><b>' . $mInfo->manufacturers_name . '</b>');
      $contents[] = array('text' => '<br>' . tep_draw_checkbox_field('delete_image', '', true) . ' ' . TEXT_DELETE_IMAGE);

      if ($mInfo->products_count > 0) {
        $contents[] = array('text' => '<br>' . tep_draw_checkbox_field('delete_products') . ' ' . TEXT_DELETE_PRODUCTS);
        $contents[] = array('text' => '<br>' . sprintf(TEXT_DELETE_WARNING_PRODUCTS, $mInfo->products_count));
      }

      $contents[] = array('align' => 'center', 'text' => '<br>' . tep_image_submit('button_delete.gif', IMAGE_DELETE) . ' <a href="' . tep_href_link(FILENAME_MANUFACTURERS, 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $mInfo->manufacturers_id) . '">' . tep_image_button('button_cancel.gif', IMAGE_CANCEL) . '</a>');
      break;
    default:
      if (isset($mInfo) && is_object($mInfo)) {
        $heading[] = array('text' => '<b>' . $mInfo->manufacturers_name . '</b>');

        $contents[] = array('align' => 'center', 'text' => '<a href="' . tep_href_link(FILENAME_MANUFACTURERS, 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $mInfo->manufacturers_id . '&action=edit') . '">' . tep_image_button('button_edit.gif', IMAGE_EDIT) . '</a> <a href="' . tep_href_link(FILENAME_MANUFACTURERS, 'page=' . $HTTP_GET_VARS['page'] . '&mID=' . $mInfo->manufacturers_id . '&action=delete') . '">' . tep_image_button('button_delete.gif', IMAGE_DELETE) . '</a>');
        $contents[] = array('text' => '<br>' . TEXT_DATE_ADDED . ' ' . tep_date_short($mInfo->date_added));
        if (tep_not_null($mInfo->last_modified)) $contents[] = array('text' => TEXT_LAST_MODIFIED . ' ' . tep_date_short($mInfo->last_modified));
        $contents[] = array('text' => '<br>' . tep_info_image($mInfo->manufacturers_image, $mInfo->manufacturers_name, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT));
        $contents[] = array('text' => '<br>' . TEXT_PRODUCTS . ' ' . $mInfo->products_count);
      }
      break;
  }

  if ( (tep_not_null($heading)) && (tep_not_null($contents)) && ($action=='delete' || empty($action)) ) {
    echo '            <td width="25%" valign="top">' . "\n";

    $box = new box;
    echo $box->infoBox($heading, $contents);

    echo '            </td>' . "\n";
  }
?>
          </tr>
        </table></td>
      </tr>

<?php
	if($action=='new' || $action=='edit'){
?>
	  <tr><td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td></tr>
      <tr><td colspan="2">
<?php
		$box = new box;
   		echo $box->infoBox($heading, $contents);
?>
      </td></tr>
<?php
	}
?>

    </table></td>
<!-- body_text_eof //-->
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
