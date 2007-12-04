<?php
/* -----------------------------------------------------------------------------------------
   $Id: saferpay.php 1308 2005-10-15 14:22:18Z af $

   Copyright (c) 2006 Alexander Federau
   -----------------------------------------------------------------------------------------

   Released under the GNU General Public License 
   ---------------------------------------------------------------------------------------*/
   
require('includes/application_top.php');
define('FILENAME_SAFERPAY', __FILE__);
define('TABLE_SAFERPAY_TRANSACTIONS', 'saferpay_transactions');
define('MODULE_PAYMENT_SAFERPAYGW_TEST_ACCOUNT', '99867-94913159');
if ( !defined('MODULE_PAYMENT_SAFERPAYGW_PASSWORD') ) {
	define('MODULE_PAYMENT_SAFERPAYGW_PASSWORD', 'XAjc3Kna');
}
define('SAFERPAY_TERMINAL_URL', 'https://www.saferpay.com/user/JournalDetail.asp');

if(!function_exists('format_price')){
	  function format_price($price_string, $price_special, $currency, $allow_tax, $tax_rate) {
		// calculate currencies
		$currencies_query = tep_db_query("SELECT
		                                          symbol_left,
		                                          symbol_right,
		                                          decimal_places,
		                                          value
		                                      FROM
		                                          ".TABLE_CURRENCIES."
		                                      WHERE
		                                          code = '".$currency."'");
		$currencies_value = tep_db_fetch_array($currencies_query);
		$currencies_data = array ();
		$currencies_data = array ('SYMBOL_LEFT' => $currencies_value['symbol_left'], 'SYMBOL_RIGHT' => $currencies_value['symbol_right'], 'DECIMAL_PLACES' => $currencies_value['decimal_places'], 'VALUE' => $currencies_value['value']);

		// round price
		if ($allow_tax == 1)
			$price_string = $price_string / ((100 + $tax_rate) / 100);
		$price_string = precision($price_string, $currencies_data['DECIMAL_PLACES']);
		if ($price_special == '1') {
			$price_string = $currencies_data['SYMBOL_LEFT'].' '.$price_string.' '.$currencies_data['SYMBOL_RIGHT'];
		}
		return $price_string;
	}
}

if(!function_exists('precision')){
	function precision($number, $places) {
		$number = number_format($number, $places, '.', '');
		return $number;
	}	
}

require_once(DIR_FS_CATALOG_MODULES . 'payment/saferpaygw.php');  

  if (tep_not_null($action)) {
    switch ($action) {
      case 'update':
      	  
		//delete items
		if(isset($_POST['sub_delete_x']) && isset($_POST['trans_ids'])){
			for($i=0; $i<count($_POST['trans_ids']); $i++){
				$query_raw = "DELETE FROM ". TABLE_SAFERPAY_TRANSACTIONS ." WHERE trans_id=".$_POST['trans_ids'][$i];
				$query_res = tep_db_query($query_raw);		
			}
		}

		//complete items
		if(isset($_POST['sub_complete_x']) && isset($_POST['trans_ids'])){
			for($i=0; $i<count($_POST['trans_ids']); $i++){

				$query_raw = "select st.*, ot.text as order_total from ". TABLE_SAFERPAY_TRANSACTIONS ." st left join ". TABLE_ORDERS ." o on st.orders_id=o.orders_id left join ".TABLE_ORDERS_TOTAL." ot on (st.orders_id = ot.orders_id and ot.class = 'ot_total') WHERE trans_id=".$_POST['trans_ids'][$i];
				$query_res = tep_db_query($query_raw);

				if($record = tep_db_fetch_array($query_res)){
					// if test account than use Password
					$spPassword = '';
					if ( defined('MODULE_PAYMENT_SAFERPAYGW_ACCOUNT_ID') && MODULE_PAYMENT_SAFERPAYGW_ACCOUNT_ID == MODULE_PAYMENT_SAFERPAYGW_TEST_ACCOUNT ) {
						$spPassword = '&spPassword='.MODULE_PAYMENT_SAFERPAYGW_PASSWORD;
					}
					$url = MODULE_PAYMENT_SAFERPAYGW_COMPLETE_URL."?ACCOUNTID=".MODULE_PAYMENT_SAFERPAYGW_ACCOUNT_ID."&ID=".$record['saferpay_ID']."&TOKEN==(unused)".$spPassword;
					// debug
					//error_log('PayComplete: '.var_export($url, true)."\n", 3, DIR_FS_CATALOG.'tmp/saferpay_'.date('Ymd').'.log');

					/* complete payment by hosting server */
					$result = saferpaygw::process_url($url);
					// debug
					//error_log(var_export($result, true)."\n", 3, DIR_FS_CATALOG.'tmp/saferpay_'.date('Ymd').'.log');
			
					if (substr($result, 0, 2) == "OK") {
						$sql_data_array = array( 'saferpay_complete' => '1',
												 'saferpay_complete_result' => $result,
												 'last_modified' => 'now()');
					}
					else {
						// payment could not be completed
						$sql_data_array = array( 'saferpay_complete_result' => $result,
												 'last_modified' => 'now()');
					}
					tep_db_perform(TABLE_SAFERPAY_TRANSACTIONS, $sql_data_array, 'update', "trans_id=". $_POST['trans_ids'][$i]);
		
				}
			}
		}
        break;
        
      default:

    }
  }
?>
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">
<html <?php echo HTML_PARAMS; ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>">
<title><?php echo TITLE; ?></title>
<link rel="stylesheet" type="text/css" href="includes/stylesheet.css">
<link rel="stylesheet" type="text/css" href="includes/javascript/spiffyCal/spiffyCal_v2_1.css">
<script language="javascript" src="includes/general.js"></script>
<script type="text/javascript" src="includes/javascript/spiffyCal/spiffyCal_v2_1.js"></script>
<script type="text/javascript">
  var dateFrom = new ctlSpiffyCalendarBox("dateFrom", "form_search", "date_from", "btnDate1", "<?php echo ((isset($_GET['date_from']) && trim($_GET['date_from']) != '') ? $_GET['date_from'] : '') ?>", scBTNMODE_CUSTOMBLUE);
  var dateTo = new ctlSpiffyCalendarBox("dateTo", "form_search", "date_to", "btnDate2", "<?php echo ((isset($_GET['date_to'])) ? $_GET['date_to'] : '') ?>", scBTNMODE_CUSTOMBLUE);
</script>
</head>
<body marginwidth="0" marginheight="0" topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0" bgcolor="#FFFFFF">
<div id="spiffycalendar" class="text"></div>
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
        <td><table border="0" width="100%" cellspacing="0" cellpadding="0">
         <?php echo tep_draw_form('form_search', $current_page, '', 'get'); ?>
          <tr>
		    <td width="80" rowspan="2"><?php echo tep_image(DIR_WS_ICONS.'logo_saferpay.gif'); ?></td>
    		<td class="pageHeading"><?php echo HEADING_TITLE; ?></td>
    		<td class="main" align="right">
	<?php
		
		echo HEADING_TITLE_DATE_FROM . '  ' . '<script type="text/javascript">dateFrom.writeControl(); dateFrom.dateFormat="yyyy-MM-dd";</script>';
		echo HEADING_TITLE_DATE_TO . '  ' . '<script type="text/javascript">dateTo.writeControl(); dateTo.dateFormat="yyyy-MM-dd";</script>'.'&nbsp;'.HEADING_TITLE_DATE_FORMAT.'&nbsp;';
		
	?>
   	
    	</td>
  </tr>
  <tr> 
    <td colspan=3 class="main" valign="top" align="right"><table border="0" cellspacing="0" cellpadding="2"> 
      <tr> 
        <td class="main" valign="middle" align="right"><?php echo HEADING_TITLE_STATUS . ' ' . tep_draw_pull_down_menu('status', array( array('id' => '', 'text' => TEXT_ALL_TRANSACTIONS), array('id' => '0', 'text' => TEXT_RESERVED), array('id' => '1', 'text' => TEXT_COMPLETED)), $_GET['status'], '').tep_draw_hidden_field(tep_session_name(), tep_session_id()); ?>
              </td>
        <td class="smallText" valign="middle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>        	
        <td><?php echo tep_image_submit('button_search.gif', IMAGE_SEARCH); ?> 
            </td>
      </tr> 
    </table></td>
  </tr>		  
</form>
			</tr>
        </table></td>
      </tr>
      <tr>
        <td><?php echo tep_draw_form('saferpay', $current_page, tep_get_all_get_params(array('action')).'action=update', 'post'); ?>
        	<table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td valign="top"><table border="0" width="100%" cellspacing="1" cellpadding="2">
              <tr class="dataTableHeadingRow">
                <td class="dataTableHeadingContent">&nbsp;</td>
                <td class="dataTableHeadingContent"><?php echo TABLE_HEADING_ORDER_ID; ?></td>
                <td class="dataTableHeadingContent" align="center"><?php echo TABLE_HEADING_TRANSACTION_DATE; ?></td>
            	<td class="dataTableHeadingContent" align="center"><?php echo TABLE_HEADING_PROVIDER; ?></td>
                <td class="dataTableHeadingContent" align="center"><?php echo TABLE_HEADING_SAFERPAY_ID; ?></td>
                <!--<td class="dataTableHeadingContent" align="center"><?php echo TABLE_HEADING_ORDER_TOTAL; ?></td>-->
                <td class="dataTableHeadingContent" align="center"><?php echo TABLE_HEADING_SAFERPAY_AMOUNT; ?></td>
                <td class="dataTableHeadingContent" align="center"><?php echo TABLE_HEADING_SAFERPAY_STATUS; ?></td>
              </tr>
 
 <?php
$where_str = '';

if ( tep_not_null($_GET['status']) ) {
	$where_str .= " and st.saferpay_complete='".$_GET['status']."' ";
}

if ( tep_not_null($_GET['tID']) ) {
	$where_str .= " and st.saferpay_ID like '%".$_GET['tID']."%' ";
}

if(isset($_GET['date_from']) && trim($_GET['date_from']) != ""){
	$xDateF = $_GET['date_from'];
    $where_str .= " and st.date_added >= \"$xDateF 00:00:00\"";
}
if(isset($_GET['date_to']) && trim($_GET['date_to']) != ""){
	$xDateT = $_GET['date_to'];	
	$where_str .= " and st.date_added <= \"$xDateT 23:59:59\"";
}

//-----

if ( strlen($where_str) > 0 ) {
	$where_str = ' where 1=1 '. $where_str .' ';
}

$query_raw = "select st.*, ot.text as order_total from ". TABLE_SAFERPAY_TRANSACTIONS ." st left join ". TABLE_ORDERS ." o on st.orders_id=o.orders_id left join ".TABLE_ORDERS_TOTAL." ot on (st.orders_id = ot.orders_id and ot.class = 'ot_total') ". $where_str ." order by st.orders_id DESC";
$query_res = tep_db_query($query_raw);
$xSize = tep_db_num_rows($query_res);
(($xSize) ? $query_split = new splitPageResults($_GET['page'], '20', $query_raw, $query_numrows) : $query_split = "");
$query_res = tep_db_query($query_raw);
$xSize = tep_db_num_rows($query_res);

while ( $record = tep_db_fetch_array($query_res) ) {
	
?>
              <tr class="dataTableRow">
                <td class="dataTableContent" align=center>
    <?php echo tep_draw_checkbox_field('trans_ids[]', $record['trans_id']) . tep_draw_hidden_field('trans_page[]', $record['trans_id']); ?>
</td>
                <td class="dataTableContent" align="right"><?php echo $record['orders_id']; ?></td> 
                <td class="dataTableContent" align="center"><?php echo $record['date_added']; ?></td>
    			<td class="dataTableContent" align="center"><?php echo $record['saferpay_provider_name']; ?>&nbsp;</td>
                <td class="dataTableContent" align="center"><?php echo '<a href="'.SAFERPAY_TERMINAL_URL.'?GXID='.$record['saferpay_ID'].'" target="_blank">'.$record['saferpay_ID'].'</a>'; ?></td>
                <!--<td class="dataTableContent" align="right"><?php echo strip_tags($record['order_total']); ?></td>-->
                <td class="dataTableContent" align="right"><?php echo format_price($record['saferpay_amount'], 1, $record['saferpay_currency'], 0, 0); ?></td>
                <td class="dataTableContent" align="center"><?php
	if ($record['saferpay_complete'] == '1') {
		echo tep_image(DIR_WS_IMAGES . 'icon_status_green.gif', IMAGE_ICON_STATUS_GREEN, 10, 10);
	} else {
		echo tep_image(DIR_WS_IMAGES . 'icon_status_red.gif', IMAGE_ICON_STATUS_RED, 10, 10);
	}
?>
                </td>
              </tr>
<?php } ?>
              <tr>
                <td colspan="7" class="smallText" align=left><?php echo TEXT_SAFERPAY_ID_LINK; ?></td>
              </tr>	
              <tr>
                <td colspan="8" align=left><table border="0" cellspacing="0" cellpadding="2">
                  <tr>
                    <td class="smallText" valign="top" align="left"><?php echo '<a href="' . tep_href_link(FILENAME_MODULES, 'set=payment&module=saferpaygw') . '">' . tep_image_button('button_back.gif', IMAGE_BACK) . '</a>'; ?></td>
                    <td class="smallText" valign="top" align="center"><?php if ($xSize != 0) { echo tep_image_submit('button_complete.gif', IMAGE_COMPLETE, " name='sub_complete' value='sub_complete'"); } ?></td>
                    <td class="smallText" align="right"><?php if ($xSize != 0) { echo tep_image_submit('button_del_list_item.gif', IMAGE_DELETE, " name='sub_delete' value='sub_delete'"); } ?></td>
                  </tr>
                  	  
                </table></form></td>
              </tr>


              <tr>
                <td colspan="8"><table border="0" width="100%" cellspacing="0" cellpadding="2">
                  <tr>
                    <td class="smallText" valign="top"><?php echo (($xSize) ? $query_split->display_count($query_numrows, '20', $_GET['page'], TEXT_DISPLAY_NUMBER_OF_ORDERS) : ""); ?></td>
                    <td class="smallText" align="right"><?php echo (($xSize) ? $query_split->display_links($query_numrows, '20', MAX_DISPLAY_PAGE_LINKS, $_GET['page'], tep_get_all_get_params(array('page', 'tID', 'action'))) : ""); ?></td>
                    	
                  </tr>
                </table></td>
              </tr>
 

            </table></td>
          </tr>
        </table></td>
      </tr>
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