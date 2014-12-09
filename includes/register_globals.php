<?php
// Since register global is disabled request values are copyed to HTTP_* and global vars

$REGISTER_REQUEST_ARRAY = array( 'action','address','agree','cPath','cart_delete','cart_delete[]','cart_quantity','cart_quantity[]'
		,'categories_id','city','comments','company','confirmation','country','coupon_code','currency','dfrom','dto','email','email_address'
		,'enquiry','fax','firstname','gender','guest','id','inc_subcat','keywords','language','language_id','lastname','manufacturers_id','name'
		,'newsletter','newsletter_general','notify[]','number_of_uploads','order_id','osCsid','page','password','payment','pfrom','postcode','product_global'
		,'products_id','products_id[]','pto','search_in_description','shipping','sort','street_address','telephone','x','y' );

for ($i = 0; $i < count( $REGISTER_REQUEST_ARRAY ); $i++) {
	if( isset( $_REQUEST[ $REGISTER_REQUEST_ARRAY[$i]] ) ) {
		$$REGISTER_REQUEST_ARRAY[$i] = $_REQUEST[$REGISTER_REQUEST_ARRAY[$i]]; // ?action=update => $action = 'update'
		if( isset( $_GET[$REGISTER_REQUEST_ARRAY[$i]] ) )
			$HTTP_GET_VARS[$REGISTER_REQUEST_ARRAY[$i]] = $_REQUEST[$REGISTER_REQUEST_ARRAY[$i]];
		if( isset( $_POST[$REGISTER_REQUEST_ARRAY[$i]] ) )
			$HTTP_POST_VARS[$REGISTER_REQUEST_ARRAY[$i]] = $_REQUEST[$REGISTER_REQUEST_ARRAY[$i]];
	}
}
$REMOTE_ADDR = $_SERVER['REMOTE_ADDR'];