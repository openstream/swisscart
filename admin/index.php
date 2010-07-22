<?php
/*
	$Id: index.php,v 1.19 2003/06/27 09:38:31 dgw_ Exp $

	osCommerce, Open Source E-Commerce Solutions
	http://www.oscommerce.com

	Copyright (c) 2006 osCommerce

	Released under the GNU General Public License
*/

	require('includes/application_top.php');
?>
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">
<html <?php echo HTML_PARAMS; ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>">
<title><?php echo TITLE; ?></title>
<style type="text/css">
<!--
.infoBox {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #080381;
	background-color: #f2f4ff;
	border-color: #7187bb;
	border-style: solid;
	border-width: 1px;
}
.smallText {
	font-family: Verdana, Arial, sans-serif;
	font-size: 10px;
}
-->
</style>
<link rel="stylesheet" type="text/css" href="includes/stylesheet.css">
<script language="javascript" src="includes/general.js"></script>
</head>
<body marginwidth="0" marginheight="0" topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0" bgcolor="#FFFFFF">
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
		<td valign="top" class="main"><?php echo TEXT_ADMIN_FRONTPAGE ?></td>
		<!-- body_text_eof //-->
		<!-- column_right //-->
		<td width="200" valign="top" style="padding-right: 50px; "><br />
			<?php
	if(BOX_NEWS_RSS_SOURCE) {
		require(DIR_WS_CLASSES . 'rss/rss_php.php');

		$rss = new rss_php;
			$rss->load(BOX_NEWS_RSS_SOURCE);
		$items = $rss->getRSS(); #returns all rss items

//	  echo '<pre>'; print_r($items); echo '</pre>';

		$rss_content = '<ul class="rssfeed">';
		for ($i=0;$i<3;$i++) $rss_content .= '<li><a href="' . $items['rss']['channel']["item:$i"]['link'] . '">' . $items['rss']['channel']["item:$i"]['title'] . '</a></li>';
		$rss_content .= '</ul>';

		$heading = array();
		$contents = array();

		$heading[] = array('params' => 'class="menuBoxHeading"',
						 'text'  => $items['rss']['channel']['title'] . '&nbsp;<img src="images/icons/feed.png" alt="RSS Feed" />');

		$contents[] = array('params' => 'class="infoBox"',
							'text'  => $rss_content);

		$box = new box;
		echo $box->menuBox($heading, $contents);

		echo '<br>';

	}

	$heading = array();
	$contents = array();

	$heading[] = array('params' => 'class="menuBoxHeading"',
										 'text'  => 'Support');

	$contents[] = array('params' => 'class="infoBox"',
											'text'  => '<a href="http://docu.swisscart.com" target="_blank">' . BOX_ENTRY_DOCUMENTATION . '</a><br>' .
									 '<a href="http://www.swisscart-webshop.ch" target="_blank">' . BOX_ENTRY_SUPPORT_SITE . '</a><br>' .
																 '<a href="http://www.oscommerce.info/" target="_blank">' . BOX_ENTRY_KNOWLEDGE_BASE . '</a><br>' .
																 '<a href="http://forums.oscommerce.com" target="_blank">' . BOX_ENTRY_SUPPORT_FORUMS . '</a><br>' .
								 '<a href="http://addons.oscommerce.com/" target="_blank">' . BOX_ENTRY_CONTRIBUTIONS . '</a>');

	$box = new box;
	echo $box->menuBox($heading, $contents);

	echo '<br>';

	$orders_contents = '';
	$orders_status_query = tep_db_query("select orders_status_name, orders_status_id from " . TABLE_ORDERS_STATUS . " where language_id = '" . $languages_id . "'");
	while ($orders_status = tep_db_fetch_array($orders_status_query)) {
		$orders_pending_query = tep_db_query("select count(*) as count from " . TABLE_ORDERS . " where orders_status = '" . $orders_status['orders_status_id'] . "'");
		$orders_pending = tep_db_fetch_array($orders_pending_query);
		$orders_contents .= '<a href="' . tep_href_link(FILENAME_ORDERS, 'selected_box=customers&status=' . $orders_status['orders_status_id']) . '">' . $orders_status['orders_status_name'] . '</a>: ' . $orders_pending['count'] . '<br>';
	}
	$orders_contents = substr($orders_contents, 0, -4);

	$heading = array();
	$contents = array();

	$heading[] = array('params' => 'class="menuBoxHeading"',
										 'text'  => BOX_TITLE_ORDERS);

	$contents[] = array('params' => 'class="infoBox"',
											'text'  => $orders_contents);

	$box = new box;
	echo $box->menuBox($heading, $contents);

	echo '<br>';

	$customers_query = tep_db_query("select count(*) as count from " . TABLE_CUSTOMERS);
	$customers = tep_db_fetch_array($customers_query);
	$products_query = tep_db_query($q="select count(*) as count from (" . TABLE_PRODUCTS . " p left join ". TABLE_PRODUCTS_TO_CATEGORIES. " p2c using (products_id) left join ". TABLE_CATEGORIES ." c using (categories_id)) where c.categories_status=1 and p.products_status = '1' order by p.products_id");
	debug_msg($q);
	$products = tep_db_fetch_array($products_query);
	$reviews_query = tep_db_query("select count(*) as count from " . TABLE_REVIEWS);
	$reviews = tep_db_fetch_array($reviews_query);

	$heading = array();
	$contents = array();

	$heading[] = array('params' => 'class="menuBoxHeading"',
										 'text'  => BOX_TITLE_STATISTICS);

	$contents[] = array('params' => 'class="infoBox"',
											'text'  => BOX_ENTRY_CUSTOMERS . ' ' . $customers['count'] . '<br>' .
																 BOX_ENTRY_PRODUCTS . ' ' . $products['count'] . '<br>' .
																 BOX_ENTRY_REVIEWS . ' ' . $reviews['count']);

	$box = new box;
	echo $box->menuBox($heading, $contents);

	echo '<br>';

	$contents = array();

	if (getenv('HTTPS') == 'on') {
		$size = ((getenv('SSL_CIPHER_ALGKEYSIZE')) ? getenv('SSL_CIPHER_ALGKEYSIZE') . '-bit' : '<i>' . BOX_CONNECTION_UNKNOWN . '</i>');
		$contents[] = array('params' => 'class="infoBox"',
												'text' => tep_image(DIR_WS_ICONS . 'locked.gif', ICON_LOCKED, '', '', 'align="right"') . sprintf(BOX_CONNECTION_PROTECTED, $size));
	} else {
		$contents[] = array('params' => 'class="infoBox"',
												'text' => tep_image(DIR_WS_ICONS . 'unlocked.gif', ICON_UNLOCKED, '', '', 'align="right"') . BOX_CONNECTION_UNPROTECTED);
	}

	$box = new box;
	echo $box->tableBlock($contents);
?>
		</td>
	</tr>
</table>
<?php require(DIR_WS_INCLUDES . 'footer.php'); ?>
</body>
</html>
