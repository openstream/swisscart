<?php
	$this_dir = getcwd();
	chdir('../../');
	require('includes/application_top.php');
	//print_r($_POST);
	if(isset($_POST['setStatus']) && isset($_POST['catID']) && (int)$_POST['catID'] ) {
		tep_set_categories_status((int)$_POST['catID'], (int)$_POST['setStatus']);
		if((int)$_POST['setStatus']==0){
			echo '<a href="'.tep_href_link(CURRENT_PAGE, tep_get_all_get_params(array('action', 'catID')).'action=setflag_cat&flag=1&catID='.(int)$_POST['catID']).'" onclick="setCategoryStatus(\''. (int)$_POST['catID'] .'\', 1); return false;">' . tep_image(DIR_WS_IMAGES . 'icon_status_green_light.gif', IMAGE_ICON_STATUS_GREEN_LIGHT, 10, 10) . '</a>&nbsp;&nbsp;' . tep_image(DIR_WS_IMAGES . 'icon_status_red.gif', IMAGE_ICON_STATUS_RED, 10, 10) ;
		} else {
			echo tep_image(DIR_WS_IMAGES . 'icon_status_green.gif', IMAGE_ICON_STATUS_GREEN, 10, 10) . '&nbsp;&nbsp;<a href="'.tep_href_link(CURRENT_PAGE, tep_get_all_get_params(array('action', 'catID')).'action=setflag_cat&flag=0&catID='.(int)$_POST['catID']).'" onclick="setCategoryStatus(\''.(int)$_POST['catID'].'\', 0); return false;">' . tep_image(DIR_WS_IMAGES . 'icon_status_red_light.gif', IMAGE_ICON_STATUS_RED_LIGHT, 10, 10) . '</a>';
		}
	}
	if(isset($_POST['setStatus']) && isset($_POST['prodID']) && (int)$_POST['prodID'] ) {
		tep_set_product_status((int)$_POST['prodID'], (int)$_POST['setStatus']);
		if((int)$_POST['setStatus']==0){
			echo '<a href="'.tep_href_link(CURRENT_PAGE, tep_get_all_get_params(array('action', 'prodID')).'action=setflag&flag=1&catID='.(int)$_POST['catID']).'" onclick="setProductStatus(\''. (int)$_POST['prodID'] .'\', 1); return false;">' . tep_image(DIR_WS_IMAGES . 'icon_status_green_light.gif', IMAGE_ICON_STATUS_GREEN_LIGHT, 10, 10) . '</a>&nbsp;&nbsp;' . tep_image(DIR_WS_IMAGES . 'icon_status_red.gif', IMAGE_ICON_STATUS_RED, 10, 10) ;
		} else {
			echo tep_image(DIR_WS_IMAGES . 'icon_status_green.gif', IMAGE_ICON_STATUS_GREEN, 10, 10) . '&nbsp;&nbsp;<a href="'.tep_href_link(CURRENT_PAGE, tep_get_all_get_params(array('action', 'catID')).'action=setflag&flag=0&catID='.(int)$_POST['prodID']).'" onclick="setProductStatus(\''.(int)$_POST['prodID'].'\', 0); return false;">' . tep_image(DIR_WS_IMAGES . 'icon_status_red_light.gif', IMAGE_ICON_STATUS_RED_LIGHT, 10, 10) . '</a>';
		}
	}
	//error_log($ret, 3, DIR_FS_CATALOG.'data/logs/ajaxcategories.txt');
?>