<?php
// Since register global is disabled request values are copyed to HTTP_* and global vars

$REGISTER_REQUEST_ARRAY = array('0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23'
		,'Customer_nr','HTDA_1','HTDA_3','HTDA_5','HTDA_6','HTDA_7','HTKA_1','HTKA_3','HTKA_5','HTKA_6','HTKA_7','HTTA_1','HTTA_3','HTTA_5','HTTA_6','HTTA_7'
		,'action','action_check','action_delete','address_format_id','attribute_page','bID','banners_group','banners_html_text','banners_image_local','banners_image_target','banners_title','banners_url','block','cID','cPath','categories_description'
		,'categories_htc_desc_tag','categories_htc_keywords_tag','categories_htc_title_tag','categories_id','categories_name','categories_seo_url','city','code','company','configuration'
		,'configuration_value','confirmation','content','copy_as','countries_iso_code_2','countries_iso_code_3','countries_name','country','coupons_id','coupons_min_order','coupons_notice','coupons_value','customers_email_address','customers_email_address','customers_fax','customers_firstname','customers_gender','customers_lastname','customers_newsletter','customers_telephone','date_from','date_scheduled','date_to','day','decimal_places','decimal_point','default_address_id','delete_image','delete_image2','delete_image3','delete_image4','delete_page','desc','directory','edit.x','edit.y','edit_x','edit_y','email_address','endDate','entry_city','entry_company','entry_country_id','entry_postcode','entry_street_address','expires_date','expires_impressions','fax','file_contents','filename','fillMetaDescrlength','fill_language','filter','firstname','flag','folder_name','from','gID','gender','geo_zone_description','geo_zone_name','goto','group1','group2','group3','group4','image','info','information_action','information_description','information_id','information_title','keyword','lID','language','language'
		,'language_id','lastname','lngdir','lngdir','mID','mail_sent_to','main_desc','main_keyword','main_title','manufacturers_country','manufacturers_description','manufacturers_htc_desc_tag','manufacturers_htc_description','manufacturers_htc_keywords_tag','manufacturers_htc_title_tag','manufacturers_id','manufacturers_name','manufacturers_region','manufacturers_url','message','module','month','move_to_category_id','nID','name','new_banners_group','newsletter','oID','option_id','option_order_by','option_page','options_id','orders_status_name','origin','osCAdminID','osCAdminID'
		,'pID','page','parent_id','password','postcode','price_prefix','products_date_added','products_date_available','products_description'
		,'products_head_desc_tag','products_head_keywords_tag','products_head_title_tag','products_id','products_image','products_image2','products_image3','products_image4','products_model','products_name'
		,'products_previous_image','products_previous_image2','products_previous_image3','products_previous_image4','products_price','products_price_gross','products_quantity','products_seo_url'
		,'products_status','products_tax_class_id','products_url','products_weight','read','report','sID','search','search_terms','selected_box','set','sort_order','sortorder','specials_price','startDate','status','street_address','subject','symbol_left','symbol_right','tID','tax_class_description','tax_class_id','tax_class_title','tax_description','tax_priority','tax_rate','tax_zone_id','telephone','thousands_point','title','unlink_image','unlink_image2','unlink_image3','unlink_image4','value','value_id','value_name','value_page','value_price','values_id','visible','wert','x','y','y'
		,'year','zID','zone_code','zone_country_id','zone_name','zpage'
		,'Customer','update_customer_name','update_customer_company','update_customer_street_address','update_customer_suburb','update_customer_city','update_customer_zone_id','update_customer_state','update_customer_postcode','update_customer_country_id','update_customer_telephone','update_customer_email_address','update_delivery_name','update_delivery_company','update_delivery_street_address','update_delivery_suburb','update_delivery_city','update_delivery_zone_id','update_delivery_state','update_delivery_postcode','update_delivery_country_id','update_billing_name','update_billing_company','update_billing_street_address','update_billing_suburb','update_billing_city','update_billing_zone_id','update_billing_state','update_billing_postcode','update_billing_country_id','update_info_payment_method','update_info_payment_currency','update_info_payment_currency_value','update_info_cc_type','update_info_cc_owner','update_info_cc_number','update_info_cc_expires','update_products','subaction','update_totals','update_shipping','shipping','update_comments','status','comments'
);

for ($i = 0; $i < count( $REGISTER_REQUEST_ARRAY ); $i++) {
	if( isset( $_REQUEST[ $REGISTER_REQUEST_ARRAY[$i]] ) ) {
		$$REGISTER_REQUEST_ARRAY[$i] = $_REQUEST[$REGISTER_REQUEST_ARRAY[$i]]; // ?action=update => $action = 'update'
		if( isset( $_GET[$REGISTER_REQUEST_ARRAY[$i]] ) ) {
			$HTTP_GET_VARS[$REGISTER_REQUEST_ARRAY[$i]] = $_REQUEST[$REGISTER_REQUEST_ARRAY[$i]];
		} elseif( isset( $_POST[$REGISTER_REQUEST_ARRAY[$i]] ) ) {
			$HTTP_POST_VARS[$REGISTER_REQUEST_ARRAY[$i]] = $_REQUEST[$REGISTER_REQUEST_ARRAY[$i]];
		} else {
			$HTTP_POST_VARS[$REGISTER_REQUEST_ARRAY[$i]] = $_REQUEST[$REGISTER_REQUEST_ARRAY[$i]];
			$HTTP_GET_VARS[$REGISTER_REQUEST_ARRAY[$i]] = $_REQUEST[$REGISTER_REQUEST_ARRAY[$i]];
		}
	}
}

