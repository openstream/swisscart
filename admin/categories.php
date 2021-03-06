<?php
/*
	$Id: categories.php,v 1.146 2003/07/11 14:40:27 hpdl Exp $

	osCommerce, Open Source E-Commerce Solutions
	http://www.oscommerce.com

	Copyright (c) 2003 osCommerce

	Released under the GNU General Public License
*/

	require('includes/application_top.php');
	require('includes/functions/categories_description.php');

	require(DIR_WS_CLASSES . 'currencies.php');
	$currencies = new currencies();

	$action = (isset($HTTP_GET_VARS['action']) ? $HTTP_GET_VARS['action'] : '');

    header("X-XSS-Protection: 0");

 if (tep_not_null($action)) {
		// ULTIMATE Seo Urls 5
		// If the action will affect the cache entries
		if ( preg_match_all("/(insert|update|setflag)/", $action) ){
			tep_reset_cache_data_seo_urls('reset');
		}

		switch ($action) {
			case 'beginsort':
				$sorting = true;
				break;
				tep_redirect(tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $HTTP_POST_VARS['cPath']));
			case 'setsortorder':
				for ($i=0, $n=sizeof($HTTP_POST_VARS['products_id']); $i<$n; $i++) {
						tep_set_product_sort_order($HTTP_POST_VARS['products_id'][$i], $HTTP_POST_VARS['sortorder'][$i]);
					}
				$sorting = false;
				tep_redirect(tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $HTTP_POST_VARS['cPath']));
				break;
			case 'setflag':
				if ( ($HTTP_GET_VARS['flag'] == '0') || ($HTTP_GET_VARS['flag'] == '1') ) {
					if (isset($HTTP_GET_VARS['pID'])) {
						tep_set_product_status($HTTP_GET_VARS['pID'], $HTTP_GET_VARS['flag']);
					}

					if (USE_CACHE == 'true') {
						tep_reset_cache_block('categories');
						tep_reset_cache_block('also_purchased');
					}
				}

				tep_redirect(tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $HTTP_GET_VARS['cPath'] . '&pID=' . $HTTP_GET_VARS['pID']));
				break;
			case 'setflag_cat':
				if ( ($_GET['flag'] == '0') || ($_GET['flag'] == '1') ) {
					if (isset($_GET['cID'])) {
						tep_set_categories_status($_GET['cID'], $_GET['flag']);
					}

					if (USE_CACHE == 'true') {
						tep_reset_cache_block('categories');
						tep_reset_cache_block('also_purchased');
					}
				}

				tep_redirect(tep_href_link(CURRENT_PAGE, 'cPath=' . $_GET['cPath'] . '&cID=' . $_GET['cID']));
				break;
		case 'new_category':
			case 'edit_category':
				$HTTP_GET_VARS['action']=$HTTP_GET_VARS['action'] . '_ACD';
				break;
			case 'insert_category':
			case 'update_category':
			if ( ($HTTP_POST_VARS['edit_x']) || ($HTTP_POST_VARS['edit_y']) ) {
					$HTTP_GET_VARS['action'] = 'edit_category_ACD';
				} else {
				if (isset($HTTP_POST_VARS['categories_id'])) $categories_id = tep_db_prepare_input($HTTP_POST_VARS['categories_id']);
		if ($categories_id == '') {
					 $categories_id = tep_db_prepare_input($HTTP_GET_VARS['cID']);
				 }
				$sort_order = tep_db_prepare_input($HTTP_POST_VARS['sort_order']);

				$sql_data_array = array('sort_order' => $sort_order);

				if ($action == 'insert_category') {
					$insert_sql_data = array('parent_id' => $current_category_id,
																	 'date_added' => 'now()');

					$sql_data_array = array_merge($sql_data_array, $insert_sql_data);

					tep_db_perform(TABLE_CATEGORIES, $sql_data_array);

					$categories_id = tep_db_insert_id();
				} elseif ($action == 'update_category') {
					$update_sql_data = array('last_modified' => 'now()');

					$sql_data_array = array_merge($sql_data_array, $update_sql_data);

					tep_db_perform(TABLE_CATEGORIES, $sql_data_array, 'update', "categories_id = '" . (int)$categories_id . "'");
				}

				$languages = tep_get_languages();
				for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
					$categories_name_array = $HTTP_POST_VARS['categories_name'];
					$categories_htc_title_array = $HTTP_POST_VARS['categories_htc_title_tag'];
					$categories_htc_desc_array = $HTTP_POST_VARS['categories_htc_desc_tag'];
					$categories_htc_keywords_array = $HTTP_POST_VARS['categories_htc_keywords_tag'];
					$categories_seo_url_array = $HTTP_POST_VARS['categories_seo_url'];

					$language_id = $languages[$i]['id'];

					$sql_data_array = array('categories_name' => tep_db_prepare_input($categories_name_array[$language_id]),
																	'categories_description' => tep_db_prepare_input($HTTP_POST_VARS['categories_description'][$language_id]),
									'categories_htc_title_tag' => (tep_not_null($categories_htc_title_array[$language_id]) ? tep_db_prepare_input($categories_htc_title_array[$language_id]) :  tep_db_prepare_input($categories_name_array[$language_id])),
									'categories_htc_desc_tag' => (tep_not_null($categories_htc_desc_array[$language_id]) ? tep_db_prepare_input($categories_htc_desc_array[$language_id]) :  tep_db_prepare_input($categories_name_array[$language_id])),
									'categories_htc_keywords_tag' => (tep_not_null($categories_htc_keywords_array[$language_id]) ? tep_db_prepare_input($categories_htc_keywords_array[$language_id]) :  tep_db_prepare_input($categories_name_array[$language_id])),
																	'categories_seo_url' => tep_db_prepare_input($categories_seo_url_array[$language_id]));

					if ($action == 'insert_category') {
						$insert_sql_data = array('categories_id' => $categories_id,
																		 'language_id' => $languages[$i]['id']);

						$sql_data_array = array_merge($sql_data_array, $insert_sql_data);

						tep_db_perform(TABLE_CATEGORIES_DESCRIPTION, $sql_data_array);
					} elseif ($action == 'update_category') {
						tep_db_perform(TABLE_CATEGORIES_DESCRIPTION, $sql_data_array, 'update', "categories_id = '" . (int)$categories_id . "' and language_id = '" . (int)$languages[$i]['id'] . "'");
					}
				}

				$categories_image = new upload('categories_image');
				$categories_image->set_destination(DIR_FS_CATALOG_IMAGES);
				if ($categories_image->parse() && $categories_image->save()) {
					tep_db_query("update " . TABLE_CATEGORIES . " set categories_image = '" . tep_db_input($categories_image->filename) . "' where categories_id = '" . (int)$categories_id . "'");
				}

				if (USE_CACHE == 'true') {
					tep_reset_cache_block('categories');
					tep_reset_cache_block('also_purchased');
				}

				tep_redirect(tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&cID=' . $categories_id));
		}
				break;
			case 'delete_category_confirm':
				if (isset($HTTP_POST_VARS['categories_id'])) {
					$categories_id = tep_db_prepare_input($HTTP_POST_VARS['categories_id']);

					$categories = tep_get_category_tree($categories_id, '', '0', '', true);
					$products = array();
					$products_delete = array();

					for ($i=0, $n=sizeof($categories); $i<$n; $i++) {
						$product_ids_query = tep_db_query("select products_id from " . TABLE_PRODUCTS_TO_CATEGORIES . " where categories_id = '" . (int)$categories[$i]['id'] . "'");

						while ($product_ids = tep_db_fetch_array($product_ids_query)) {
							$products[$product_ids['products_id']]['categories'][] = $categories[$i]['id'];
						}
					}

					reset($products);
					while (list($key, $value) = each($products)) {
						$category_ids = '';

						for ($i=0, $n=sizeof($value['categories']); $i<$n; $i++) {
							$category_ids .= "'" . (int)$value['categories'][$i] . "', ";
						}
						$category_ids = substr($category_ids, 0, -2);

						$check_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS_TO_CATEGORIES . " where products_id = '" . (int)$key . "' and categories_id not in (" . $category_ids . ")");
						$check = tep_db_fetch_array($check_query);
						if ($check['total'] < '1') {
							$products_delete[$key] = $key;
						}
					}

// removing categories can be a lengthy process
					tep_set_time_limit(0);
					for ($i=0, $n=sizeof($categories); $i<$n; $i++) {
						tep_remove_category($categories[$i]['id']);
					}

					reset($products_delete);
					while (list($key) = each($products_delete)) {
						tep_remove_product($key);
					}
				}

				if (USE_CACHE == 'true') {
					tep_reset_cache_block('categories');
					tep_reset_cache_block('also_purchased');
				}

				tep_redirect(tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath));
				break;
			case 'delete_product_confirm':
				if (isset($HTTP_POST_VARS['products_id']) && isset($HTTP_POST_VARS['product_categories']) && is_array($HTTP_POST_VARS['product_categories'])) {
					$product_id = tep_db_prepare_input($HTTP_POST_VARS['products_id']);
					$product_categories = $HTTP_POST_VARS['product_categories'];

					for ($i=0, $n=sizeof($product_categories); $i<$n; $i++) {
						tep_db_query("delete from " . TABLE_PRODUCTS_TO_CATEGORIES . " where products_id = '" . (int)$product_id . "' and categories_id = '" . (int)$product_categories[$i] . "'");
					}

					$product_categories_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS_TO_CATEGORIES . " where products_id = '" . (int)$product_id . "'");
					$product_categories = tep_db_fetch_array($product_categories_query);

					if ($product_categories['total'] == '0') {
						tep_remove_product($product_id);
					}
				}

				if (USE_CACHE == 'true') {
					tep_reset_cache_block('categories');
					tep_reset_cache_block('also_purchased');
				}

				tep_redirect(tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath));
				break;
			case 'move_category_confirm':
				if (isset($HTTP_POST_VARS['categories_id']) && ($HTTP_POST_VARS['categories_id'] != $HTTP_POST_VARS['move_to_category_id'])) {
					$categories_id = tep_db_prepare_input($HTTP_POST_VARS['categories_id']);
					$new_parent_id = tep_db_prepare_input($HTTP_POST_VARS['move_to_category_id']);

					$path = explode('_', tep_get_generated_category_path_ids($new_parent_id));

					if (in_array($categories_id, $path)) {
						$messageStack->add_session(ERROR_CANNOT_MOVE_CATEGORY_TO_PARENT, 'error');

						tep_redirect(tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&cID=' . $categories_id));
					} else {
						tep_db_query("update " . TABLE_CATEGORIES . " set parent_id = '" . (int)$new_parent_id . "', last_modified = now() where categories_id = '" . (int)$categories_id . "'");

						if (USE_CACHE == 'true') {
							tep_reset_cache_block('categories');
							tep_reset_cache_block('also_purchased');
						}

						tep_redirect(tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $new_parent_id . '&cID=' . $categories_id));
					}
				}

				break;
			case 'move_product_confirm':
				$products_id = tep_db_prepare_input($HTTP_POST_VARS['products_id']);
				$new_parent_id = tep_db_prepare_input($HTTP_POST_VARS['move_to_category_id']);

				$duplicate_check_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS_TO_CATEGORIES . " where products_id = '" . (int)$products_id . "' and categories_id = '" . (int)$new_parent_id . "'");
				$duplicate_check = tep_db_fetch_array($duplicate_check_query);
				if ($duplicate_check['total'] < 1) tep_db_query("update " . TABLE_PRODUCTS_TO_CATEGORIES . " set categories_id = '" . (int)$new_parent_id . "' where products_id = '" . (int)$products_id . "' and categories_id = '" . (int)$current_category_id . "'");

				if (USE_CACHE == 'true') {
					tep_reset_cache_block('categories');
					tep_reset_cache_block('also_purchased');
				}

				tep_redirect(tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $new_parent_id . '&pID=' . $products_id));
				break;
			case 'insert_product':
			case 'update_product':
				if (isset($HTTP_POST_VARS['edit_x']) || isset($HTTP_POST_VARS['edit_y'])) {
					$action = 'new_product';
				} else {
		// Modified For Image Delete
						$image_count_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS . " where products_image='" . $HTTP_POST_VARS['products_previous_image'] . "'");
						$image_count = tep_db_fetch_array($image_count_query);

						if (($HTTP_POST_VARS['delete_image'] == 'yes') && ($image_count['total']<= '1')) {
								unlink(DIR_FS_CATALOG_IMAGES . $HTTP_POST_VARS['products_previous_image']);
						}
		// Modified For Image Delete
					if (isset($HTTP_GET_VARS['pID'])) $products_id = tep_db_prepare_input($HTTP_GET_VARS['pID']);
					$products_date_available = tep_db_prepare_input($HTTP_POST_VARS['products_date_available']);

					$products_date_available = (date('Y-m-d') < $products_date_available) ? $products_date_available : 'null';

					$sql_data_array = array('products_quantity' => tep_db_prepare_input($HTTP_POST_VARS['products_quantity']),
																	'products_model' => tep_db_prepare_input($HTTP_POST_VARS['products_model']),
																	'products_price' => tep_db_prepare_input($HTTP_POST_VARS['products_price']),
																	'products_date_available' => $products_date_available,
																	'products_weight' => tep_db_prepare_input($HTTP_POST_VARS['products_weight']),
																	'products_status' => tep_db_prepare_input($HTTP_POST_VARS['products_status']),
																	'products_tax_class_id' => tep_db_prepare_input($HTTP_POST_VARS['products_tax_class_id']),
																	'manufacturers_id' => tep_db_prepare_input($HTTP_POST_VARS['manufacturers_id']));

					// Unlink Images
			if (($HTTP_POST_VARS['unlink_image'] == 'yes') or ($HTTP_POST_VARS['delete_image'] == 'yes')) {
			$sql_data_array['products_image'] = '';
			} else {
				if (isset($HTTP_POST_VARS['products_image']) && tep_not_null($HTTP_POST_VARS['products_image']) && ($HTTP_POST_VARS['products_image'] != 'none'))
				$sql_data_array['products_image'] = tep_db_prepare_input($HTTP_POST_VARS['products_image']);
					}

			if (($HTTP_POST_VARS['unlink_image2'] == 'yes') or ($HTTP_POST_VARS['delete_image2'] == 'yes')) {
			$sql_data_array['products_image2'] = '';
			} else {
						if (isset($HTTP_POST_VARS['products_image2']) && tep_not_null($HTTP_POST_VARS['products_image2']) && ($HTTP_POST_VARS['products_image2'] != 'none'))
							$sql_data_array['products_image2'] = tep_db_prepare_input($HTTP_POST_VARS['products_image2']);
					}

			if (($HTTP_POST_VARS['unlink_image3'] == 'yes') or ($HTTP_POST_VARS['delete_image3'] == 'yes')) {
			$sql_data_array['products_image3'] = '';
			} else {
						if (isset($HTTP_POST_VARS['products_image3']) && tep_not_null($HTTP_POST_VARS['products_image3']) && ($HTTP_POST_VARS['products_image3'] != 'none'))
							$sql_data_array['products_image3'] = tep_db_prepare_input($HTTP_POST_VARS['products_image3']);
					}

			if (($HTTP_POST_VARS['unlink_image4'] == 'yes') or ($HTTP_POST_VARS['delete_image4'] == 'yes')) {
			$sql_data_array['products_image4'] = '';
			} else {
						if (isset($HTTP_POST_VARS['products_image4']) && tep_not_null($HTTP_POST_VARS['products_image4']) && ($HTTP_POST_VARS['products_image4'] != 'none'))
							$sql_data_array['products_image4'] = tep_db_prepare_input($HTTP_POST_VARS['products_image4']);
					}

					if ($action == 'insert_product') {
						$insert_sql_data = array('products_date_added' => 'now()');

						$sql_data_array = array_merge($sql_data_array, $insert_sql_data);

						tep_db_perform(TABLE_PRODUCTS, $sql_data_array);
						$products_id = tep_db_insert_id();

						tep_db_query("insert into " . TABLE_PRODUCTS_TO_CATEGORIES . " (products_id, categories_id) values ('" . (int)$products_id . "', '" . (int)$current_category_id . "')");
					} elseif ($action == 'update_product') {
						$update_sql_data = array('products_last_modified' => 'now()');

						$sql_data_array = array_merge($sql_data_array, $update_sql_data);

						tep_db_perform(TABLE_PRODUCTS, $sql_data_array, 'update', "products_id = '" . (int)$products_id . "'");
					}

					$languages = tep_get_languages();
					for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
						$language_id = $languages[$i]['id'];

							$sql_data_array = array('products_name' => tep_db_prepare_input($HTTP_POST_VARS['products_name'][$language_id]),
																			'products_description' => tep_db_prepare_input($HTTP_POST_VARS['products_description'][$language_id]),
																			'products_url' => tep_db_prepare_input($HTTP_POST_VARS['products_url'][$language_id]),
																			'products_head_title_tag' => ((tep_not_null($HTTP_POST_VARS['products_head_title_tag'][$language_id])) ? tep_db_prepare_input($HTTP_POST_VARS['products_head_title_tag'][$language_id]) : tep_db_prepare_input($HTTP_POST_VARS['products_name'][$language_id])),
																			'products_head_desc_tag' => ((tep_not_null($HTTP_POST_VARS['products_head_desc_tag'][$language_id])) ? tep_db_prepare_input($HTTP_POST_VARS['products_head_desc_tag'][$language_id]) : tep_db_prepare_input($HTTP_POST_VARS['products_name'][$language_id])),
																			'products_head_keywords_tag' => ((tep_not_null($HTTP_POST_VARS['products_head_keywords_tag'][$language_id])) ? tep_db_prepare_input($HTTP_POST_VARS['products_head_keywords_tag'][$language_id]) : tep_db_prepare_input($HTTP_POST_VARS['products_name'][$language_id])),
																			'products_seo_url' => tep_db_prepare_input($HTTP_POST_VARS['products_seo_url'][$language_id]));

						if ($action == 'insert_product') {
							$insert_sql_data = array('products_id' => $products_id,
																			 'language_id' => $language_id);

							$sql_data_array = array_merge($sql_data_array, $insert_sql_data);

							tep_db_perform(TABLE_PRODUCTS_DESCRIPTION, $sql_data_array);
						} elseif ($action == 'update_product') {
							tep_db_perform(TABLE_PRODUCTS_DESCRIPTION, $sql_data_array, 'update', "products_id = '" . (int)$products_id . "' and language_id = '" . (int)$language_id . "'");
						}
					}

					if (USE_CACHE == 'true') {
						tep_reset_cache_block('categories');
						tep_reset_cache_block('also_purchased');
					}

					tep_redirect(tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&pID=' . $products_id));
				}
				break;
			case 'copy_to_confirm':
				if (isset($HTTP_POST_VARS['products_id']) && isset($HTTP_POST_VARS['categories_id'])) {
					$products_id = tep_db_prepare_input($HTTP_POST_VARS['products_id']);
					$categories_id = tep_db_prepare_input($HTTP_POST_VARS['categories_id']);

					if ($HTTP_POST_VARS['copy_as'] == 'link') {
						if ($categories_id != $current_category_id) {
							$check_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS_TO_CATEGORIES . " where products_id = '" . (int)$products_id . "' and categories_id = '" . (int)$categories_id . "'");
							$check = tep_db_fetch_array($check_query);
							if ($check['total'] < '1') {
								tep_db_query("insert into " . TABLE_PRODUCTS_TO_CATEGORIES . " (products_id, categories_id) values ('" . (int)$products_id . "', '" . (int)$categories_id . "')");
							}
						} else {
							$messageStack->add_session(ERROR_CANNOT_LINK_TO_SAME_CATEGORY, 'error');
						}
					} elseif ($HTTP_POST_VARS['copy_as'] == 'duplicate') {
						$product_query = tep_db_query("select products_quantity, products_model, products_image, products_image2, products_image3, products_image4, products_price, products_date_available, products_weight, products_tax_class_id, manufacturers_id from " . TABLE_PRODUCTS . " where products_id = '" . (int)$products_id . "'");
						$product = tep_db_fetch_array($product_query);

						tep_db_query("insert into " . TABLE_PRODUCTS . " (products_quantity, products_model,products_image, products_image2, products_image3, products_image4, products_price, products_date_added, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id) values ('" . tep_db_input($product['products_quantity']) . "', '" . tep_db_input($product['products_model']) . "', '" . tep_db_input($product['products_image']) . "', '" . tep_db_input($product['products_image2']) . "', '" . tep_db_input($product['products_image3']) . "', '" . tep_db_input($product['products_image4']) . "', '" . tep_db_input($product['products_price']) . "',  now(), " . (empty($product['products_date_available']) ? "null" : "'" . tep_db_input($product['products_date_available']) . "'") . ", '" . tep_db_input($product['products_weight']) . "', '0', '" . (int)$product['products_tax_class_id'] . "', '" . (int)$product['manufacturers_id'] . "')");
						$dup_products_id = tep_db_insert_id();

						$description_query = tep_db_query("select language_id, products_name, products_seo_url, products_description, products_head_title_tag, products_head_desc_tag, products_head_keywords_tag, products_url from " . TABLE_PRODUCTS_DESCRIPTION . " where products_id = '" . (int)$products_id . "'");
						while ($description = tep_db_fetch_array($description_query)) {
							tep_db_query("insert into " . TABLE_PRODUCTS_DESCRIPTION . " (products_id, language_id, products_name, products_seo_url, products_description, products_head_title_tag, products_head_desc_tag, products_head_keywords_tag, products_url, products_viewed) values ('" . (int)$dup_products_id . "', '" . (int)$description['language_id'] . "', '" . tep_db_input($description['products_name']) . "', '" . tep_db_input($description['products_seo_url']) . "','" . tep_db_input($description['products_description']) . "', '" . tep_db_input($description['products_head_title_tag']) . "', '" . tep_db_input($description['products_head_desc_tag']) . "', '" . tep_db_input($description['products_head_keywords_tag']) . "', '" . tep_db_input($description['products_url']) . "', '0')");
						}

						tep_db_query("insert into " . TABLE_PRODUCTS_TO_CATEGORIES . " (products_id, categories_id) values ('" . (int)$dup_products_id . "', '" . (int)$categories_id . "')");
						$products_id = $dup_products_id;
					}

					if (USE_CACHE == 'true') {
						tep_reset_cache_block('categories');
						tep_reset_cache_block('also_purchased');
					}
				}

				tep_redirect(tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $categories_id . '&pID=' . $products_id));
				break;
			case 'new_product_preview':
// copy image only if modified
	 if (($HTTP_POST_VARS['unlink_image'] == 'yes') or ($HTTP_POST_VARS['delete_image'] == 'yes')) {
				$products_image = '';
				$products_image_name = '';
				} else {
				$products_image = new upload('products_image');
				$products_image->set_destination(DIR_FS_CATALOG_IMAGES);
				if ($products_image->parse() && $products_image->save()) {
					$products_image_name = $products_image->filename;
				} else {
					$products_image_name = (isset($HTTP_POST_VARS['products_previous_image']) ? $HTTP_POST_VARS['products_previous_image'] : '');
				}
				}

				$products_image2 = new upload('products_image2');
				$products_image2->set_destination(DIR_FS_CATALOG_IMAGES);
				if ($products_image2->parse() && $products_image2->save()) {
					$products_image2_name = $products_image2->filename;
				} else {
					$products_image2_name = (isset($HTTP_POST_VARS['products_previous_image2']) ? $HTTP_POST_VARS['products_previous_image2'] : '');
				}

				$products_image3 = new upload('products_image3');
				$products_image3->set_destination(DIR_FS_CATALOG_IMAGES);
				if ($products_image3->parse() && $products_image3->save()) {
					$products_image3_name = $products_image3->filename;
				} else {
					$products_image3_name = (isset($HTTP_POST_VARS['products_previous_image3']) ? $HTTP_POST_VARS['products_previous_image3'] : '');
				}

				$products_image4 = new upload('products_image4');
				$products_image4->set_destination(DIR_FS_CATALOG_IMAGES);
				if ($products_image4->parse() && $products_image4->save()) {
					$products_image4_name = $products_image4->filename;
				} else {
					$products_image4_name = (isset($HTTP_POST_VARS['products_previous_image4']) ? $HTTP_POST_VARS['products_previous_image4'] : '');
				}

				break;
		}
	}

// check if the catalog image directory exists
	if (is_dir(DIR_FS_CATALOG_IMAGES)) {
		if (!is_writeable(DIR_FS_CATALOG_IMAGES)) $messageStack->add(ERROR_CATALOG_IMAGE_DIRECTORY_NOT_WRITEABLE, 'error');
	} else {
		$messageStack->add(ERROR_CATALOG_IMAGE_DIRECTORY_DOES_NOT_EXIST, 'error');
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
include('includes/head_params.php');
if(preg_match('/edit|new_product/',$action) ){
	// Tiny MCE WYISIWYG detection and include
	$tinymce_imagemanager = (TINYMCE_IMAGEMANAGER_ENABLED == 'true') ? ',imagemanager':'';
	if($_GET['action'] != 'new_product_preview') { // prevent hidden fields to be rendered by TinyMCE in preview
		if (file_exists("tiny_mce/tiny_mce.js")) { $tiny_mce = "tiny_mce/tiny_mce.js"; }
		elseif (file_exists("includes/javascript/tiny_mce/tiny_mce.js")) { $tiny_mce = "includes/javascript/tiny_mce/tiny_mce.js"; }
		else $tiny_mce = '';
		if($tiny_mce) {
		echo '<script language="javascript" type="text/javascript" src="' . $tiny_mce . '"></script>
		<script language="javascript" type="text/javascript">
		tinyMCE.init({
		doctype : "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">",
		element_format : "html",
		relative_urls : false,
		remove_script_host : true,
		mode : "exact",
		elements : "';
		$languages = tep_get_languages();
		for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
			echo 'products_description[' . $languages[$i]['id'] . '],';
			echo 'categories_description[' . $languages[$i]['id'] . '],';
		}
		echo '",
		language : "' . $languages_selected . '",
		theme : "' . TINYMCE_THEME . '",
		plugins : "table,advhr,advimage,advlink,emotions,flash,contextmenu,media,filemanager,paste,' . $tinymce_imagemanager . '",
					paste_auto_cleanup_on_paste : true,
					paste_preprocess : function(pl, o) {
							// Content string containing the HTML from the clipboard
							alert(o.content);
					},
					paste_postprocess : function(pl, o) {
							// Content DOM node containing the DOM structure of the clipboard
							alert(o.node.innerHTML);
					},';
		// theme_advanced_buttons1_add : "fontselect,fontsizeselect",
		echo 'theme_advanced_buttons2_add : "separator,forecolor",
		theme_advanced_buttons2_add_before: "cut,copy,pastetext,pasteword,separator",
		theme_advanced_buttons3_add_before : "tablecontrols,separator",
		theme_advanced_buttons3_add : "emotions,advhr,media",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_path_location : "bottom",
		extended_valid_elements : "a[name|href|target|title|onclick],img[class|src|border=0|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name|style],hr[class|width|size|noshade]",
		external_link_list_url : "example_data/example_link_list.js",
		external_image_list_url : "example_data/example_image_list.js",
		flash_external_list_url : "example_data/example_flash_list.js"
		});
		</script>';
		}
	}
}

?>
<script language="Javascript">
	function setCategoryStatus(categoryID, status){
		jQuery.post('includes/ajax/categories.php',
								{ catID: categoryID, setStatus: status },
								function(data){
									jQuery("#category_status_"+categoryID).html(data);
								}, 'html');
	}
</script>
</head>
<body marginwidth="0" marginheight="0" topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0" bgcolor="#FFFFFF" onLoad="SetFocus();">
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
		<td width="100%" valign="top">
<?php
	if ($action == 'new_product') {
		$parameters = array('products_name' => '',
											 'products_description' => '',
											 'products_url' => '',
											 'products_seo_url' => '',
											 'products_id' => '',
											 'products_quantity' => '',
											 'products_model' => '',
											 'products_image' => '',
											 'products_image2' => '',
											 'products_image3' => '',
											 'products_image4' => '',
											 'products_price' => '',
											 'products_weight' => '',
											 'products_date_added' => '',
											 'products_last_modified' => '',
											 'products_date_available' => '',
											 'products_status' => '',
											 'products_tax_class_id' => '',
											 'manufacturers_id' => '');

		$pInfo = new objectInfo($parameters);

		if (isset($HTTP_GET_VARS['pID']) && empty($HTTP_POST_VARS)) {
			$product_query = tep_db_query("select pd.products_name, pd.products_seo_url, pd.products_description, pd.products_url, p.products_id, p.products_quantity, p.products_model, p.products_image, p.products_image2, p.products_image3, p.products_image4, p.products_price, p.products_weight, p.products_date_added, p.products_last_modified, date_format(p.products_date_available, '%Y-%m-%d') as products_date_available, p.products_status, p.products_tax_class_id, p.manufacturers_id from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_id = '" . (int)$HTTP_GET_VARS['pID'] . "' and p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "'");
			$product = tep_db_fetch_array($product_query);

			$pInfo->objectInfo($product);
		} elseif (tep_not_null($HTTP_POST_VARS)) {
			$pInfo->objectInfo($HTTP_POST_VARS);
			$products_name = $HTTP_POST_VARS['products_name'];
			$products_description = $HTTP_POST_VARS['products_description'];
			$products_url = $HTTP_POST_VARS['products_url'];
			$products_seo_url = $HTTP_POST_VARS['products_seo_url'];
		}

		$manufacturers_array = array(array('id' => '', 'text' => TEXT_NONE));
		$manufacturers_query = tep_db_query("select manufacturers_id, manufacturers_name from " . TABLE_MANUFACTURERS . " order by manufacturers_name");
		while ($manufacturers = tep_db_fetch_array($manufacturers_query)) {
			$manufacturers_array[] = array('id' => $manufacturers['manufacturers_id'],
																		 'text' => $manufacturers['manufacturers_name']);
		}

		$tax_class_array = array(array('id' => '0', 'text' => TEXT_NONE));
		$tax_class_query = tep_db_query("select tax_class_id, tax_class_title from " . TABLE_TAX_CLASS . " order by tax_class_title");
		while ($tax_class = tep_db_fetch_array($tax_class_query)) {
			$tax_class_array[] = array('id' => $tax_class['tax_class_id'],
																 'text' => $tax_class['tax_class_title']);
		}

		$languages = tep_get_languages();

		if (!isset($pInfo->products_status)) $pInfo->products_status = '1';
		switch ($pInfo->products_status) {
			case '0': $in_status = false; $out_status = true; break;
			case '1':
			default: $in_status = true; $out_status = false;
		}
?>
<link rel="stylesheet" type="text/css" href="includes/javascript/spiffyCal/spiffyCal_v2_1.css">
<script language="JavaScript" src="includes/javascript/spiffyCal/spiffyCal_v2_1.js"></script>
<script language="javascript"><!--
	var dateAvailable = new ctlSpiffyCalendarBox("dateAvailable", "new_product", "products_date_available","btnDate1","<?php echo $pInfo->products_date_available; ?>",scBTNMODE_CUSTOMBLUE);
//--></script>
<script language="javascript"><!--
var tax_rates = new Array();
<?php
		for ($i=0, $n=sizeof($tax_class_array); $i<$n; $i++) {
			if ($tax_class_array[$i]['id'] > 0) {
				echo 'tax_rates["' . $tax_class_array[$i]['id'] . '"] = ' . tep_get_tax_rate_value($tax_class_array[$i]['id']) . ';' . "\n";
			}
		}
?>

function doRound(x, places) {
	return Math.round(x * Math.pow(10, places)) / Math.pow(10, places);
}

function getTaxRate() {
	var selected_value = document.forms["new_product"].products_tax_class_id.selectedIndex;
	var parameterVal = document.forms["new_product"].products_tax_class_id[selected_value].value;

	if ( (parameterVal > 0) && (tax_rates[parameterVal] > 0) ) {
		return tax_rates[parameterVal];
	} else {
		return 0;
	}
}

function updateGross() {
	var taxRate = getTaxRate();
	var grossValue = document.forms["new_product"].products_price.value;

	if (taxRate > 0) {
		grossValue = grossValue * ((taxRate / 100) + 1);
	}

	document.forms["new_product"].products_price_gross.value = doRound(grossValue, 4);
}

function updateNet() {
	var taxRate = getTaxRate();
	var netValue = document.forms["new_product"].products_price_gross.value;

	if (taxRate > 0) {
		netValue = netValue / ((taxRate / 100) + 1);
	}

	document.forms["new_product"].products_price.value = doRound(netValue, 4);
}

function toggle(obj) {
	var el = document.getElementById(obj);
	el.style.display = (el.style.display != 'block' ? 'block' : 'none' );
}
//--></script>
		<?php echo tep_draw_form('new_product', FILENAME_CATEGORIES, 'cPath=' . $cPath . (isset($HTTP_GET_VARS['pID']) ? '&pID=' . $HTTP_GET_VARS['pID'] : '') . '&action=new_product_preview', 'post', 'enctype="multipart/form-data"'); ?>
		<table border="0" width="100%" cellspacing="0" cellpadding="2">
			<tr>
				<td><table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td class="pageHeading"><?php echo sprintf(TEXT_NEW_PRODUCT, tep_output_generated_category_path($current_category_id)); ?></td>
						<td class="pageHeading" align="right"><?php echo tep_draw_separator('pixel_trans.gif', HEADING_IMAGE_WIDTH, HEADING_IMAGE_HEIGHT); ?></td>
					</tr>
				</table></td>
			</tr>
			<tr>
				<td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
			</tr>
			<tr>
				<td><table border="0" cellspacing="0" cellpadding="2">
					<tr>
						<td class="main"><?php echo TEXT_PRODUCTS_STATUS; ?></td>
						<td class="main"><?php echo tep_draw_separator('pixel_trans.gif', '24', '15') . '&nbsp;' . tep_draw_radio_field('products_status', '1', $in_status) . '&nbsp;' . TEXT_PRODUCT_AVAILABLE . '&nbsp;' . tep_draw_radio_field('products_status', '0', $out_status) . '&nbsp;' . TEXT_PRODUCT_NOT_AVAILABLE; ?></td>
					</tr>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
					<tr>
						<td class="main"><?php echo TEXT_PRODUCTS_DATE_AVAILABLE; ?><br><small>(YYYY-MM-DD)</small></td>
						<td class="main"><?php echo tep_draw_separator('pixel_trans.gif', '24', '15') . '&nbsp;'; ?><script language="javascript">dateAvailable.writeControl(); dateAvailable.dateFormat="yyyy-MM-dd";</script></td>
					</tr>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
					<tr>
						<td class="main"><?php echo TEXT_PRODUCTS_MANUFACTURER; ?></td>
						<td class="main"><?php echo tep_draw_separator('pixel_trans.gif', '24', '15') . '&nbsp;' . tep_draw_pull_down_menu('manufacturers_id', $manufacturers_array, $pInfo->manufacturers_id); ?></td>
					</tr>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
<?php
		for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
?>
					<tr>
						<td class="main"><?php if ($i == 0) echo TEXT_PRODUCTS_NAME; ?></td>
						<td class="main"><?php echo tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('products_name[' . $languages[$i]['id'] . ']', (isset($products_name[$languages[$i]['id']]) ? stripslashes($products_name[$languages[$i]['id']]) : tep_get_products_name($pInfo->products_id, $languages[$i]['id']))); ?></td>
					</tr>
<?php
		}
?>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>

<?php
		for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
?>
			<tr>
				<td class="main"><?php if ($i == 0) echo TEXT_PRODUCTS_SEO_URL; ?></td>
				<td class="main"><?php echo tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('products_seo_url[' . $languages[$i]['id'] . ']', (isset($products_seo_url[$languages[$i]['id']]) ? $products_seo_url[$languages[$i]['id']] : tep_get_products_seo_url($pInfo->products_id, $languages[$i]['id']))); ?></td>
			 </tr>
<?php
		}
?>
			 <tr>
				 <td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
			 </tr>

					<tr bgcolor="#ebebff">
						<td class="main"><?php echo TEXT_PRODUCTS_TAX_CLASS; ?></td>
						<td class="main"><?php echo tep_draw_separator('pixel_trans.gif', '24', '15') . '&nbsp;' . tep_draw_pull_down_menu('products_tax_class_id', $tax_class_array, $pInfo->products_tax_class_id, 'onchange="updateGross()"'); ?></td>
					</tr>
					<tr bgcolor="#ebebff">
						<td class="main"><?php echo TEXT_PRODUCTS_PRICE_NET; ?></td>
						<td class="main"><?php echo tep_draw_separator('pixel_trans.gif', '24', '15') . '&nbsp;' . tep_draw_input_field('products_price', $pInfo->products_price, 'onKeyUp="updateGross()"'); ?></td>
					</tr>
					<tr bgcolor="#ebebff">
						<td class="main"><?php echo TEXT_PRODUCTS_PRICE_GROSS; ?></td>
						<td class="main"><?php echo tep_draw_separator('pixel_trans.gif', '24', '15') . '&nbsp;' . tep_draw_input_field('products_price_gross', $pInfo->products_price, 'OnKeyUp="updateNet()"'); ?></td>
					</tr>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
<script language="javascript"><!--
updateGross();
//--></script>
<?php
		for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
?>
					<tr>
						<td class="main" valign="top"><?php if ($i == 0) echo TEXT_PRODUCTS_DESCRIPTION; ?></td>
						<td><table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="main" valign="top"><?php echo tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']); ?>&nbsp;</td>
								<td class="main"><?php echo tep_draw_textarea_field('products_description[' . $languages[$i]['id'] . ']', 'soft', '70', '15', (isset($products_description[$languages[$i]['id']]) ? stripslashes($products_description[$languages[$i]['id']]) : tep_get_products_description($pInfo->products_id, $languages[$i]['id'])), 'id="products_description[' . $languages[$i]['id'] . ']"'); ?></td>

							</tr>
						</table></td>
					</tr>

<?php
		}
?>
<!-- HTC BOC //-->
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
					<tr>
						<td colspan="2" class="main"><a href="#htcFields" onClick="toggle('htcFields')" class="bigLink"><?php echo TEXT_PRODUCT_META_INFO; ?></a></td>
					</tr>
				</table>
	<div id="htcFields">
				<table>
					<tr>
						<td colspan="2" class="smallText"><?php echo TEXT_PRODUCTS_META_INFO2; ?></td>
					</tr>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
<?php
		for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
?>

					<tr>
						<td class="main" valign="top"><?php if ($i == 0) echo TEXT_PRODUCTS_PAGE_TITLE; ?></td>
						<td><table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="main" valign="top"><?php echo tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']); ?>&nbsp;</td>
								<td class="main"><?php echo tep_draw_textarea_field('products_head_title_tag[' . $languages[$i]['id'] . ']', 'soft', '70', '5', (isset($products_head_title_tag[$languages[$i]['id']]) ? stripslashes($products_head_title_tag[$languages[$i]['id']]) : tep_get_products_head_title_tag($pInfo->products_id, $languages[$i]['id']))); ?></td>
							</tr>
						</table></td>
					</tr>
<?php
		}
		for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
?>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
					 <tr>
						<td class="main" valign="top"><?php if ($i == 0) echo TEXT_PRODUCTS_HEADER_DESCRIPTION; ?></td>
						<td><table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="main" valign="top"><?php echo tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']); ?>&nbsp;</td>
								<td class="main"><?php echo tep_draw_textarea_field('products_head_desc_tag[' . $languages[$i]['id'] . ']', 'soft', '70', '5', (isset($products_head_desc_tag[$languages[$i]['id']]) ? stripslashes($products_head_desc_tag[$languages[$i]['id']]) : tep_get_products_head_desc_tag($pInfo->products_id, $languages[$i]['id']))); ?></td>
							</tr>
						</table></td>
					</tr>
<?php
		}
		for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
?>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
					 <tr>
						<td class="main" valign="top"><?php if ($i == 0) echo TEXT_PRODUCTS_KEYWORDS; ?></td>
						<td><table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="main" valign="top"><?php echo tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']); ?>&nbsp;</td>
								<td class="main"><?php echo tep_draw_textarea_field('products_head_keywords_tag[' . $languages[$i]['id'] . ']', 'soft', '70', '5', (isset($products_head_keywords_tag[$languages[$i]['id']]) ? stripslashes($products_head_keywords_tag[$languages[$i]['id']]) : tep_get_products_head_keywords_tag($pInfo->products_id, $languages[$i]['id']))); ?></td>
							</tr>
						</table></td>
					</tr>
<?php
		}
?>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
		</table>
	</div>
<!-- HTC EOC //-->
			<table>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
					<tr>
						<td class="main"><?php echo TEXT_PRODUCTS_QUANTITY; ?></td>
						<td class="main"><?php echo tep_draw_separator('pixel_trans.gif', '24', '15') . '&nbsp;' . tep_draw_input_field('products_quantity', $pInfo->products_quantity); ?></td>
					</tr>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
					<tr>
						<td class="main"><?php echo TEXT_PRODUCTS_MODEL; ?></td>
						<td class="main"><?php echo tep_draw_separator('pixel_trans.gif', '24', '15') . '&nbsp;' . tep_draw_input_field('products_model', $pInfo->products_model); ?></td>
					</tr>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
<?php
						$image_count_query = tep_db_query("select count(*) as total from " . TABLE_PRODUCTS . " where products_image='" . $pInfo->products_image . "'");
						$image_count = tep_db_fetch_array($image_count_query);
?>
					<tr>
					 <td class="main" valign="top"><?php echo TEXT_PRODUCTS_IMAGE; ?></td>
					 <td class="main"><?php echo tep_draw_separator('pixel_trans.gif', '24', '15') . '&nbsp;' . tep_draw_file_field('products_image') . '<br>';
					 if (($HTTP_GET_VARS['pID']) && ($pInfo->products_image) != '')
							 echo '<div class="smallText deleteImageBox">' . tep_image(DIR_WS_CATALOG_IMAGES . $pInfo->products_image, $pInfo->products_image, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'align="left" hspace="5" vspace="5"') .
										'<br><input type="checkbox" name="unlink_image" value="yes">' . TEXT_PRODUCTS_IMAGE_REMOVE .
										'<br><input type="checkbox" name="delete_image" value="yes">' . TEXT_PRODUCTS_IMAGE_DELETE .
										tep_draw_hidden_field('products_previous_image', $pInfo->products_image) . '</div>';?>
						 </td>
					</tr>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
					<tr>
						<td class="main" valign="top"><?php echo TEXT_PRODUCTS_IMAGE2; ?></td>
						<td class="main"><?php echo tep_draw_separator('pixel_trans.gif', '24', '15') . '&nbsp;' . tep_draw_file_field('products_image2') . '<br>';
					 if (($HTTP_GET_VARS['pID']) && ($pInfo->products_image2) != '')
							 echo '<div class="smallText deleteImageBox">' . tep_image(DIR_WS_CATALOG_IMAGES . $pInfo->products_image2, $pInfo->products_image2, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'align="left" hspace="5" vspace="5"') .
										'<br><input type="checkbox" name="unlink_image2" value="yes">' . TEXT_PRODUCTS_IMAGE_REMOVE .
										'<br><input type="checkbox" name="delete_image2" value="yes">' . TEXT_PRODUCTS_IMAGE_DELETE .
					tep_draw_hidden_field('products_previous_image2', $pInfo->products_image2); ?>
						</td>
					</tr>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
					<tr>
						<td class="main" valign="top"><?php echo TEXT_PRODUCTS_IMAGE3; ?></td>
						<td class="main"><?php echo tep_draw_separator('pixel_trans.gif', '24', '15') . '&nbsp;' . tep_draw_file_field('products_image3') . '<br>';
					 if (($HTTP_GET_VARS['pID']) && ($pInfo->products_image3) != '')
							 echo '<div class="smallText deleteImageBox">' . tep_image(DIR_WS_CATALOG_IMAGES . $pInfo->products_image3, $pInfo->products_image3, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'align="left" hspace="5" vspace="5"') .
										'<br><input type="checkbox" name="unlink_image3" value="yes">' . TEXT_PRODUCTS_IMAGE_REMOVE .
										'<br><input type="checkbox" name="delete_image3" value="yes">' . TEXT_PRODUCTS_IMAGE_DELETE .
					tep_draw_hidden_field('products_previous_image3', $pInfo->products_image3); ?>
						</td>
					</tr>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
					<tr>
						<td class="main" valign="top"><?php echo TEXT_PRODUCTS_IMAGE4; ?></td>
						<td class="main"><?php echo tep_draw_separator('pixel_trans.gif', '24', '15') . '&nbsp;' . tep_draw_file_field('products_image4') . '<br>';
					 if (($HTTP_GET_VARS['pID']) && ($pInfo->products_image4) != '')
							 echo '<div class="smallText deleteImageBox">' . tep_image(DIR_WS_CATALOG_IMAGES . $pInfo->products_image4, $pInfo->products_image4, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'align="left" hspace="5" vspace="5"') .
										'<br><input type="checkbox" name="unlink_image4" value="yes">' . TEXT_PRODUCTS_IMAGE_REMOVE .
										'<br><input type="checkbox" name="delete_image4" value="yes">' . TEXT_PRODUCTS_IMAGE_DELETE .
					tep_draw_hidden_field('products_previous_image4', $pInfo->products_image4); ?>
						</td>
					</tr>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
<?php
		for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
?>
					<tr>
						<td class="main"><?php if ($i == 0) echo TEXT_PRODUCTS_URL . '<br><small>' . TEXT_PRODUCTS_URL_WITHOUT_HTTP . '</small>'; ?></td>
						<td class="main"><?php echo tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('products_url[' . $languages[$i]['id'] . ']', (isset($products_url[$languages[$i]['id']]) ? stripslashes($products_url[$languages[$i]['id']]) : tep_get_products_url($pInfo->products_id, $languages[$i]['id']))); ?></td>
					</tr>
<?php
		}
?>
					<tr>
						<td colspan="2"><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
					</tr>
					<tr>
						<td class="main"><?php echo TEXT_PRODUCTS_WEIGHT; ?></td>
						<td class="main"><?php echo tep_draw_separator('pixel_trans.gif', '24', '15') . '&nbsp;' . tep_draw_input_field('products_weight', $pInfo->products_weight); ?></td>
					</tr>
				</table></td>
			</tr>
			<tr>
				<td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
			</tr>
			<tr>
				<td class="main" align="right"><?php echo tep_draw_hidden_field('products_date_added', (tep_not_null($pInfo->products_date_added) ? $pInfo->products_date_added : date('Y-m-d'))) . tep_image_submit('button_preview.gif', IMAGE_PREVIEW) . '&nbsp;&nbsp;<a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . (isset($HTTP_GET_VARS['pID']) ? '&pID=' . $HTTP_GET_VARS['pID'] : '')) . '">' . tep_image_button('button_cancel.gif', IMAGE_CANCEL) . '</a>'; ?></td>
			</tr>
		</table></form>
<?php
	} elseif ($action == 'new_product_preview') {
		if (tep_not_null($HTTP_POST_VARS)) {
			$pInfo = new objectInfo($HTTP_POST_VARS);
			$products_name = $HTTP_POST_VARS['products_name'];
			$products_description = $HTTP_POST_VARS['products_description'];
			$products_head_title_tag = $HTTP_POST_VARS['products_head_title_tag'];
			$products_head_desc_tag = $HTTP_POST_VARS['products_head_desc_tag'];
			$products_head_keywords_tag = $HTTP_POST_VARS['products_head_keywords_tag'];
			$products_url = $HTTP_POST_VARS['products_url'];
			$products_seo_url = $HTTP_POST_VARS['products_seo_url'];
		} else {
			$product_query = tep_db_query("select p.products_id, pd.language_id, pd.products_name, pd.products_seo_url, pd.products_description, pd.products_head_title_tag, pd.products_head_desc_tag, pd.products_head_keywords_tag, pd.products_url, p.products_quantity, p.products_model, p.products_image, p.products_image2, p.products_image3, p.products_image4, p.products_price, p.products_weight, p.products_date_added, p.products_last_modified, p.products_date_available, p.products_status, p.manufacturers_id  from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd where p.products_id = pd.products_id and p.products_id = '" . (int)$HTTP_GET_VARS['pID'] . "'");
			$product = tep_db_fetch_array($product_query);

			$pInfo = new objectInfo($product);
			$products_image_name = $pInfo->products_image;
			$products_image2_name = $pInfo->products_image2;
			$products_image3_name = $pInfo->products_image3;
			$products_image4_name = $pInfo->products_image4;
		}

		$form_action = (isset($HTTP_GET_VARS['pID'])) ? 'update_product' : 'insert_product';

		echo tep_draw_form($form_action, FILENAME_CATEGORIES, 'cPath=' . $cPath . (isset($HTTP_GET_VARS['pID']) ? '&pID=' . $HTTP_GET_VARS['pID'] : '') . '&action=' . $form_action, 'post', 'enctype="multipart/form-data"');

		$languages = tep_get_languages();
		for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
			if (isset($HTTP_GET_VARS['read']) && ($HTTP_GET_VARS['read'] == 'only')) {
				$pInfo->products_name = tep_get_products_name($pInfo->products_id, $languages[$i]['id']);
				$pInfo->products_description = tep_get_products_description($pInfo->products_id, $languages[$i]['id']);
				$pInfo->products_head_title_tag = tep_db_prepare_input($products_head_title_tag[$languages[$i]['id']]);
				$pInfo->products_head_desc_tag = tep_db_prepare_input($products_head_desc_tag[$languages[$i]['id']]);
				$pInfo->products_head_keywords_tag = tep_db_prepare_input($products_head_keywords_tag[$languages[$i]['id']]);
				$pInfo->products_url = tep_get_products_url($pInfo->products_id, $languages[$i]['id']);
				$pInfo->products_seo_url = tep_get_products_seo_url($pInfo->products_id, $languages[$i]['id']);
			} else {
				$pInfo->products_name = tep_db_prepare_input($products_name[$languages[$i]['id']]);
				$pInfo->products_description = tep_db_prepare_input($products_description[$languages[$i]['id']]);
				$pInfo->products_head_title_tag = tep_db_prepare_input($products_head_title_tag[$languages[$i]['id']]);
				$pInfo->products_head_desc_tag = tep_db_prepare_input($products_head_desc_tag[$languages[$i]['id']]);
				$pInfo->products_head_keywords_tag = tep_db_prepare_input($products_head_keywords_tag[$languages[$i]['id']]);
				$pInfo->products_url = tep_db_prepare_input($products_url[$languages[$i]['id']]);
				$pInfo->products_seo_url = tep_db_prepare_input($products_seo_url[$languages[$i]['id']]);
			}
?>
		<table border="0" width="100%" cellspacing="0" cellpadding="2">
			<tr>
				<td><table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td class="pageHeading"><?php echo tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . $pInfo->products_name; ?></td>
						<td class="pageHeading" align="right"><?php echo $currencies->format($pInfo->products_price); ?></td>
					</tr>
				</table></td>
			</tr>
			<tr>
				<td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
			</tr>
			<tr>
				<td class="main">
		<?php
			if ($products_image_name) echo tep_image(DIR_WS_CATALOG_IMAGES . $products_image_name, $pInfo->products_name, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'align="right" hspace="5" vspace="5"');
			if ($products_image2_name) echo tep_image(DIR_WS_CATALOG_IMAGES . $products_image2_name, $pInfo->products_name, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'align="right" hspace="5" vspace="5"');
			if ($products_image3_name) echo tep_image(DIR_WS_CATALOG_IMAGES . $products_image3_name, $pInfo->products_name, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'align="right" hspace="5" vspace="5"');
			if ($products_image4_name) echo tep_image(DIR_WS_CATALOG_IMAGES . $products_image4_name, $pInfo->products_name, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT, 'align="right" hspace="5" vspace="5"');
			echo $pInfo->products_description;
		?></td>
			</tr>
<?php
			if ($pInfo->products_url) {
?>
			<tr>
				<td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
			</tr>
			<tr>
				<td class="main"><?php echo sprintf(TEXT_PRODUCT_MORE_INFORMATION, $pInfo->products_url); ?></td>
			</tr>
<?php
			}
?>
			<tr>
				<td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
			</tr>
<?php
			if ($pInfo->products_date_available > date('Y-m-d')) {
?>
			<tr>
				<td align="center" class="smallText"><?php echo sprintf(TEXT_PRODUCT_DATE_AVAILABLE, tep_date_long($pInfo->products_date_available)); ?></td>
			</tr>
<?php
			} else {
?>
			<tr>
				<td align="center" class="smallText"><?php echo sprintf(TEXT_PRODUCT_DATE_ADDED, tep_date_long($pInfo->products_date_added)); ?></td>
			</tr>
<?php
			}
?>
			<tr>
				<td><?php echo tep_draw_separator('pixel_trans.gif', '1', '10'); ?></td>
			</tr>
<?php
		}

		if (isset($HTTP_GET_VARS['read']) && ($HTTP_GET_VARS['read'] == 'only')) {
			if (isset($HTTP_GET_VARS['origin'])) {
				$pos_params = strpos($HTTP_GET_VARS['origin'], '?', 0);
				if ($pos_params != false) {
					$back_url = substr($HTTP_GET_VARS['origin'], 0, $pos_params);
					$back_url_params = substr($HTTP_GET_VARS['origin'], $pos_params + 1);
				} else {
					$back_url = $HTTP_GET_VARS['origin'];
					$back_url_params = '';
				}
			} else {
				$back_url = FILENAME_CATEGORIES;
				$back_url_params = 'cPath=' . $cPath . '&pID=' . $pInfo->products_id;
			}
?>
			<tr>
				<td align="right"><?php echo '<a href="' . tep_href_link($back_url, $back_url_params, 'NONSSL') . '">' . tep_image_button('button_back.gif', IMAGE_BACK) . '</a>'; ?></td>
			</tr>
<?php
		} else {
?>
			<tr>
				<td align="right" class="smallText">
<?php
/* Re-Post all POST'ed variables */
			reset($HTTP_POST_VARS);
			while (list($key, $value) = each($HTTP_POST_VARS)) {
				if (!is_array($HTTP_POST_VARS[$key])) {
					echo tep_draw_hidden_field($key, htmlspecialchars(stripslashes($value)));
				}
			}
			$languages = tep_get_languages();
			for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
				echo tep_draw_hidden_field('products_name[' . $languages[$i]['id'] . ']', htmlspecialchars(stripslashes($products_name[$languages[$i]['id']])));
				echo tep_draw_hidden_field('products_description[' . $languages[$i]['id'] . ']', htmlspecialchars(stripslashes($products_description[$languages[$i]['id']])));
				echo tep_draw_hidden_field('products_head_title_tag[' . $languages[$i]['id'] . ']', htmlspecialchars(stripslashes($products_head_title_tag[$languages[$i]['id']])));
				echo tep_draw_hidden_field('products_head_desc_tag[' . $languages[$i]['id'] . ']', htmlspecialchars(stripslashes($products_head_desc_tag[$languages[$i]['id']])));
				echo tep_draw_hidden_field('products_head_keywords_tag[' . $languages[$i]['id'] . ']', htmlspecialchars(stripslashes($products_head_keywords_tag[$languages[$i]['id']])));
				echo tep_draw_hidden_field('products_url[' . $languages[$i]['id'] . ']', htmlspecialchars(stripslashes($products_url[$languages[$i]['id']])));
				echo tep_draw_hidden_field('products_seo_url[' . $languages[$i]['id'] . ']', htmlspecialchars(stripslashes($products_seo_url[$languages[$i]['id']])));
			}
			echo tep_draw_hidden_field('products_image', stripslashes($products_image_name));
			echo tep_draw_hidden_field('products_image2', stripslashes($products_image2_name));
			echo tep_draw_hidden_field('products_image3', stripslashes($products_image3_name));
			echo tep_draw_hidden_field('products_image4', stripslashes($products_image4_name));

			echo tep_image_submit('button_back.gif', IMAGE_BACK, 'name="edit"') . '&nbsp;&nbsp;';

			if (isset($HTTP_GET_VARS['pID'])) {
				echo tep_image_submit('button_update.gif', IMAGE_UPDATE);
			} else {
				echo tep_image_submit('button_insert.gif', IMAGE_INSERT);
			}
			echo '&nbsp;&nbsp;<a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . (isset($HTTP_GET_VARS['pID']) ? '&pID=' . $HTTP_GET_VARS['pID'] : '')) . '">' . tep_image_button('button_cancel.gif', IMAGE_CANCEL) . '</a>';
?></td>
			</tr>
		</table></form>
<?php
		}
	} else {
?>
		<table border="0" width="100%" cellspacing="0" cellpadding="2">
			<tr>
				<td><table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td class="pageHeading"><?php echo HEADING_TITLE; ?></td>
						<td class="pageHeading" align="right"><?php echo tep_draw_separator('pixel_trans.gif', 1, HEADING_IMAGE_HEIGHT); ?></td>
						<td align="right"><table border="0" width="100%" cellspacing="0" cellpadding="0">
							<tr>
								<td class="smallText" align="right">
<?php
		echo tep_draw_form('search', FILENAME_CATEGORIES, '', 'get');
		echo HEADING_TITLE_SEARCH . ' ' . tep_draw_input_field('search');
		echo '</form>';
?>
								</td>
							</tr>
							<tr>
								<td class="smallText" align="right">
<?php
		echo tep_draw_form('goto', FILENAME_CATEGORIES, '', 'get');
		echo HEADING_TITLE_GOTO . ' ' . tep_draw_pull_down_menu('cPath', tep_get_category_tree(), $current_category_id, 'onChange="this.form.submit();"');
		echo '</form>';
?>
								</td>
							</tr>
						</table></td>
					</tr>
				</table></td>
			</tr>
			<tr>
				<td><table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top"><table border="0" width="100%" cellspacing="0" cellpadding="2"><?php echo tep_draw_form('setsortorder', FILENAME_CATEGORIES, 'action=setsortorder'); ?><input type="hidden" name="cPath" value="<?php echo $cPath; ?>">
							<tr class="dataTableHeadingRow">
								<td class="dataTableHeadingContent"><?php echo TABLE_HEADING_CATEGORIES_PRODUCTS; ?></td>
								<td class="dataTableHeadingContent" align="center"><?php echo TABLE_HEADING_STATUS; ?></td>
				<td class="dataTableHeadingContent" align="center"><?php echo TABLE_HEADING_SORT_ORDER; ?></td>
								<td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_ACTION; ?>&nbsp;</td>
							</tr>
<?php
		$categories_count = 0;
		$rows = 0;
		if (isset($HTTP_GET_VARS['search'])) {
			$search = tep_db_prepare_input($HTTP_GET_VARS['search']);
// added categories status
			$categories_query = tep_db_query("select c.categories_id, cd.categories_name, cd.categories_seo_url, c.categories_image, c.parent_id, c.sort_order, c.date_added, c.categories_status, c.last_modified, cd.categories_htc_title_tag, cd.categories_htc_desc_tag, cd.categories_htc_keywords_tag from " . TABLE_CATEGORIES . " c, " . TABLE_CATEGORIES_DESCRIPTION . " cd where c.categories_id = cd.categories_id and cd.language_id = '" . (int)$languages_id . "' and cd.categories_name like '%" . tep_db_input($search) . "%' order by c.sort_order, cd.categories_name");
		} else {
			$categories_query = tep_db_query("select c.categories_id, cd.categories_name, cd.categories_seo_url, c.categories_image, c.parent_id, c.sort_order, c.date_added, c.categories_status, c.last_modified, cd.categories_htc_title_tag, cd.categories_htc_desc_tag, cd.categories_htc_keywords_tag from " . TABLE_CATEGORIES . " c, " . TABLE_CATEGORIES_DESCRIPTION . " cd where c.parent_id = '" . (int)$current_category_id . "' and c.categories_id = cd.categories_id and cd.language_id = '" . (int)$languages_id . "' order by c.sort_order, cd.categories_name");
		}
		while ($categories = tep_db_fetch_array($categories_query)) {
			$categories_count++;
			$rows++;

// Get parent_id for subcategories if search
			if (isset($HTTP_GET_VARS['search'])) $cPath= $categories['parent_id'];

			if ((!isset($HTTP_GET_VARS['cID']) && !isset($HTTP_GET_VARS['pID']) || (isset($HTTP_GET_VARS['cID']) && ($HTTP_GET_VARS['cID'] == $categories['categories_id']))) && !isset($cInfo) && (substr($action, 0, 3) != 'new')) {
				$category_childs = array('childs_count' => tep_childs_in_category_count($categories['categories_id']));
				$category_products = array('products_count' => tep_products_in_category_count($categories['categories_id']));

				$cInfo_array = array_merge($categories, $category_childs, $category_products);
				$cInfo = new objectInfo($cInfo_array);
			}

			if (isset($cInfo) && is_object($cInfo) && ($categories['categories_id'] == $cInfo->categories_id) ) {
				$onclick = ' onclick="document.location.href=\'' . tep_href_link(FILENAME_CATEGORIES, tep_get_path($categories['categories_id'])) . '\'"';
				//echo '              <tr id="defaultSelected" class="dataTableRowSelected" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)" onclick="document.location.href=\'' . tep_href_link(FILENAME_CATEGORIES, tep_get_path($categories['categories_id'])) . '\'">' . "\n";
				echo '              <tr id="defaultSelected" class="dataTableRowSelected" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)">' . "\n";
			} else {
				$onclick = ' onclick="document.location.href=\'' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&cID=' . $categories['categories_id']) . '\'"';
				//echo '              <tr class="dataTableRow" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)" onclick="document.location.href=\'' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&cID=' . $categories['categories_id']) . '\'">' . "\n";
				echo '              <tr class="dataTableRow" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)">' . "\n";
			}
					echo '<td class="dataTableContent"'.$onclick.'><a href="' . tep_href_link(FILENAME_CATEGORIES, tep_get_path($categories['categories_id'])) . '">' . tep_image(DIR_WS_ICONS . 'folder.gif', ICON_FOLDER) . '</a>&nbsp;<b>' . $categories['categories_name'] . '</b>'.'</td>'."\n";
					echo '<td class="dataTableContent" align="center">'."\n";
						echo '<div id="category_status_'.$categories['categories_id'].'">';
						if ($categories['categories_status'] == '1') {
							echo tep_image(DIR_WS_IMAGES . 'icon_status_green.gif', IMAGE_ICON_STATUS_GREEN, 10, 10) . '&nbsp;&nbsp;<a href="'.tep_href_link(CURRENT_PAGE, tep_get_all_get_params(array('action', 'cID')).'action=setflag_cat&flag=0&cID='.$categories['categories_id']).'" onclick="setCategoryStatus(\''.$categories['categories_id'].'\', 0); return false;">' . tep_image(DIR_WS_IMAGES . 'icon_status_red_light.gif', IMAGE_ICON_STATUS_RED_LIGHT, 10, 10) . '</a>';
						} else {
							echo '<a href="'.tep_href_link(CURRENT_PAGE, tep_get_all_get_params(array('action', 'cID')).'action=setflag_cat&flag=1&cID='.$categories['categories_id']).'" onclick="setCategoryStatus(\''.$categories['categories_id'].'\', 1); return false;">' . tep_image(DIR_WS_IMAGES . 'icon_status_green_light.gif', IMAGE_ICON_STATUS_GREEN_LIGHT, 10, 10) . '</a>&nbsp;&nbsp;' . tep_image(DIR_WS_IMAGES . 'icon_status_red.gif', IMAGE_ICON_STATUS_RED, 10, 10);
						}
						echo "</div>\n";
					echo '</td>'."\n";
					echo '<td class="dataTableContent" align="center"'.$onclick.'>&nbsp;</td>'."\n";
					echo '<td class="dataTableContent" align="right">';
					if (isset($cInfo) && is_object($cInfo) && ($categories['categories_id'] == $cInfo->categories_id) ) {
						echo tep_image(DIR_WS_IMAGES . 'icon_arrow_right.gif', '');
					} else {
						echo '<a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&cID=' . $categories['categories_id']) . '">' . tep_image(DIR_WS_IMAGES . 'icon_info.gif', IMAGE_ICON_INFO) . '</a>';
					}
					echo '&nbsp;</td>'."\n";
					echo '</tr>'."\n";
		}

		$products_count = 0;
		if (isset($HTTP_GET_VARS['search'])) {
			$products_query = tep_db_query("select p.products_id, pd.products_name, pd.products_seo_url, p.products_quantity, p.products_image, p.products_image2, p.products_image3, p.products_image4, p.products_price, p.products_date_added, p.products_last_modified, p.products_date_available, p.products_status, p.products_sort_order, p2c.categories_id from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd, " . TABLE_PRODUCTS_TO_CATEGORIES . " p2c where p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' and p.products_id = p2c.products_id and pd.products_name like '%" . tep_db_input($search) . "%' order by p.products_sort_order, pd.products_name");
		} else {
			$products_query = tep_db_query("select p.products_id, pd.products_name, pd.products_seo_url, p.products_quantity, p.products_image, p.products_image2, p.products_image3, p.products_image4, p.products_price, p.products_date_added, p.products_last_modified, p.products_date_available, p.products_status, p.products_sort_order from " . TABLE_PRODUCTS . " p, " . TABLE_PRODUCTS_DESCRIPTION . " pd, " . TABLE_PRODUCTS_TO_CATEGORIES . " p2c where p.products_id = pd.products_id and pd.language_id = '" . (int)$languages_id . "' and p.products_id = p2c.products_id and p2c.categories_id = '" . (int)$current_category_id . "' order by p.products_sort_order, pd.products_name");
		}
		while ($products = tep_db_fetch_array($products_query)) {
			$products_count++;
			$rows++;

// Get categories_id for product if search
			if (isset($HTTP_GET_VARS['search'])) $cPath = $products['categories_id'];

			if ( (!isset($HTTP_GET_VARS['pID']) && !isset($HTTP_GET_VARS['cID']) || (isset($HTTP_GET_VARS['pID']) && ($HTTP_GET_VARS['pID'] == $products['products_id']))) && !isset($pInfo) && !isset($cInfo) && (substr($action, 0, 3) != 'new')) {
// find out the rating average from customer reviews
				$reviews_query = tep_db_query("select (avg(reviews_rating) / 5 * 100) as average_rating from " . TABLE_REVIEWS . " where products_id = '" . (int)$products['products_id'] . "'");
				$reviews = tep_db_fetch_array($reviews_query);
				$pInfo_array = array_merge($products, $reviews);
				$pInfo = new objectInfo($pInfo_array);
			}

			if (!$sorting){
				if (isset($pInfo) && is_object($pInfo) && ($products['products_id'] == $pInfo->products_id) ) {
					echo '              <tr id="defaultSelected" class="dataTableRowSelected" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)" onclick="document.location.href=\'' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&pID=' . $products['products_id'] . '&action=new_product_preview&read=only') . '\'">' . "\n";
				} else {
					echo '              <tr class="dataTableRow" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)" onclick="document.location.href=\'' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&pID=' . $products['products_id']) . '\'">' . "\n";
				}
			} else{
			if (isset($pInfo) && is_object($pInfo) && ($products['products_id'] == $pInfo->products_id) ) {
					echo '              <tr id="defaultSelected" class="dataTableRowSelected">' . "\n";
				} else {
					echo '              <tr class="dataTableRow">' . "\n";
				}
	}
?>
								<td class="dataTableContent"><?php echo '<a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&pID=' . $products['products_id'] . '&action=new_product_preview&read=only') . '">' . tep_image(DIR_WS_ICONS . 'preview.gif', ICON_PREVIEW) . '</a>&nbsp;' . $products['products_name']; ?></td>
								<td class="dataTableContent" align="center">
<?php
			if ($products['products_status'] == '1') {
				echo tep_image(DIR_WS_IMAGES . 'icon_status_green.gif', IMAGE_ICON_STATUS_GREEN, 10, 10) . '&nbsp;&nbsp;<a href="' . tep_href_link(FILENAME_CATEGORIES, 'action=setflag&flag=0&pID=' . $products['products_id'] . '&cPath=' . $cPath) . '">' . tep_image(DIR_WS_IMAGES . 'icon_status_red_light.gif', IMAGE_ICON_STATUS_RED_LIGHT, 10, 10) . '</a>';
			} else {
				echo '<a href="' . tep_href_link(FILENAME_CATEGORIES, 'action=setflag&flag=1&pID=' . $products['products_id'] . '&cPath=' . $cPath) . '">' . tep_image(DIR_WS_IMAGES . 'icon_status_green_light.gif', IMAGE_ICON_STATUS_GREEN_LIGHT, 10, 10) . '</a>&nbsp;&nbsp;' . tep_image(DIR_WS_IMAGES . 'icon_status_red.gif', IMAGE_ICON_STATUS_RED, 10, 10);
			}
?></td>
				<td class="dataTableContent" align="center">
								<?php
								if (!$sorting){
									echo tep_draw_input_field('sortorder[]', $products['products_sort_order'],  'SIZE=3 Disabled') . '</td>';
								}else{
									echo tep_draw_input_field('sortorder[]', $products['products_sort_order'],  'SIZE=3') . tep_draw_hidden_field('products_id[]', $products['products_id']). '</td>';
								}
								?>
								<td class="dataTableContent" align="right"><?php if (isset($pInfo) && is_object($pInfo) && ($products['products_id'] == $pInfo->products_id)) { echo tep_image(DIR_WS_IMAGES . 'icon_arrow_right.gif', ''); } else { echo '<a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&pID=' . $products['products_id']) . '">' . tep_image(DIR_WS_IMAGES . 'icon_info.gif', IMAGE_ICON_INFO) . '</a>'; } ?>&nbsp;</td>
							</tr>
<?php
		}

		$cPath_back = '';
		if (sizeof($cPath_array) > 0) {
			for ($i=0, $n=sizeof($cPath_array)-1; $i<$n; $i++) {
				if (empty($cPath_back)) {
					$cPath_back .= $cPath_array[$i];
				} else {
					$cPath_back .= '_' . $cPath_array[$i];
				}
			}
		}

		$cPath_back = (tep_not_null($cPath_back)) ? 'cPath=' . $cPath_back . '&' : '';
?>
							<tr>
								<td colspan="4"><table border="0" width="100%" cellspacing="0" cellpadding="2">
									<tr>
										<td class="smallText"><?php echo TEXT_CATEGORIES . '&nbsp;' . $categories_count . '<br>' . TEXT_PRODUCTS . '&nbsp;' . $products_count; ?></td>
										<td align="right" class="smallText">
										<?php
										if ($sorting){
										if (sizeof($cPath_array) > 0) echo '<a href="' . tep_href_link(FILENAME_CATEGORIES, $cPath_back . 'cPath=' . $cPath) . '">' . tep_image_button('button_back.gif', IMAGE_BACK) . '</a>&nbsp;'; if (!isset($HTTP_GET_VARS['search'])) echo tep_image_submit('button_save_sort.gif', IMAGE_SAVE) . '&nbsp;</td>';
										}else{
										if (sizeof($cPath_array) > 0) echo '<a href="' . tep_href_link(FILENAME_CATEGORIES, $cPath_back . 'cID=' . $current_category_id) . '">' . tep_image_button('button_back.gif', IMAGE_BACK) . '</a>&nbsp;'; if (!isset($HTTP_GET_VARS['search'])) echo '<a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&action=new_category') . '">' . tep_image_button('button_new_category.gif', IMAGE_NEW_CATEGORY) . '</a>&nbsp;<a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&action=new_product') . '">' . tep_image_button('button_new_product.gif', IMAGE_NEW_PRODUCT) . '</a>&nbsp;'; if (sizeof($cPath_array) > 0) echo '<a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&action=beginsort') . '">' . tep_image_button('button_sort_order.gif', IMAGE_EDIT) . '</a>&nbsp;</td>';
										}
										?>
									</tr>
								</table></td>
							</tr>
						</table></form></td>
<?php
		$heading = array();
		$contents = array();
		switch ($action) {
			case 'new_category':
				$heading[] = array('text' => '<b>' . TEXT_INFO_HEADING_NEW_CATEGORY . '</b>');

				$contents = array('form' => tep_draw_form('newcategory', FILENAME_CATEGORIES, 'action=insert_category&cPath=' . $cPath, 'post', 'enctype="multipart/form-data"'));
				$contents[] = array('text' => TEXT_NEW_CATEGORY_INTRO);

				$category_inputs_string = '';
				$languages = tep_get_languages();
				for ($i = 0, $n = sizeof($languages); $i < $n; $i++) {
					$category_inputs_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('categories_name[' . $languages[$i]['id'] . ']');
					$category_htc_title_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('categories_htc_title_tag[' . $languages[$i]['id'] . ']');
					$category_htc_desc_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('categories_htc_desc_tag[' . $languages[$i]['id'] . ']');
					$category_htc_keywords_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('categories_htc_keywords_tag[' . $languages[$i]['id'] . ']');
				}

				for ($i = 0, $n = sizeof($languages); $i < $n; $i++) {
					$category_seo_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('categories_seo_url[' . $languages[$i]['id'] . ']');
				}

				$contents[] = array('text' => '<br>' . TEXT_CATEGORIES_NAME . $category_inputs_string);
				$contents[] = array('text' => '<br>' . TEXT_CATEGORIES_SEO_URL . $category_seo_string);
				$contents[] = array('text' => '<br>' . TEXT_CATEGORIES_IMAGE . '<br>' . tep_draw_file_field('categories_image'));
				$contents[] = array('text' => '<br>' . TEXT_SORT_ORDER . '<br>' . tep_draw_input_field('sort_order', '', 'size="2"'));
				$contents[] = array('text' => '<br>' . 'Header Tags Category Title (optional)' . $category_htc_title_string);
				$contents[] = array('text' => '<br>' . 'Header Tags Category Description (optional)' . $category_htc_desc_string);
				$contents[] = array('text' => '<br>' . 'Header Tags Category Keywords (optional)' . $category_htc_keywords_string);
				$contents[] = array('align' => 'center', 'text' => '<br>' . tep_image_submit('button_save.gif', IMAGE_SAVE) . ' <a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath) . '">' . tep_image_button('button_cancel.gif', IMAGE_CANCEL) . '</a>');
				break;
			case 'edit_category':
				$heading[] = array('text' => '<b>' . TEXT_INFO_HEADING_EDIT_CATEGORY . '</b>');

				$contents = array('form' => tep_draw_form('categories', FILENAME_CATEGORIES, 'action=update_category&cPath=' . $cPath, 'post', 'enctype="multipart/form-data"') . tep_draw_hidden_field('categories_id', $cInfo->categories_id));
				$contents[] = array('text' => TEXT_EDIT_INTRO);

				$category_inputs_string = '';
				$languages = tep_get_languages();
				for ($i = 0, $n = sizeof($languages); $i < $n; $i++) {
					$category_inputs_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('categories_name[' . $languages[$i]['id'] . ']', tep_get_category_name($cInfo->categories_id, $languages[$i]['id']));
				}

				for ($i = 0, $n = sizeof($languages); $i < $n; $i++) {
					$category_seo_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('categories_seo_url[' . $languages[$i]['id'] . ']', tep_get_category_seo_url($cInfo->categories_id, $languages[$i]['id']));
					$category_htc_title_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('categories_htc_title_tag[' . $languages[$i]['id'] . ']', tep_get_category_htc_title($cInfo->categories_id, $languages[$i]['id']));
					$category_htc_desc_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('categories_htc_desc_tag[' . $languages[$i]['id'] . ']', tep_get_category_htc_desc($cInfo->categories_id, $languages[$i]['id']));
					$category_htc_keywords_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_input_field('categories_htc_keywords_tag[' . $languages[$i]['id'] . ']', tep_get_category_htc_keywords($cInfo->categories_id, $languages[$i]['id']));
			$category_description_string .= '<br>' . tep_image(DIR_WS_CATALOG_LANGUAGES . $languages[$i]['directory'] . '/images/' . $languages[$i]['image'], $languages[$i]['name']) . '&nbsp;' . tep_draw_textarea_field('categories_description[' . $languages[$i]['id'] . ']', 'soft', '70', '15', (($categories_description[$languages[$i]['id']]) ? stripslashes($categories_description[$languages[$i]['id']]) : tep_get_category_description($cInfo->categories_id, $languages[$i]['id'])), 'id="categories_description[' . $languages[$i]['id'] . ']"');
				}

				$contents[] = array('text' => '<br>' . TEXT_EDIT_CATEGORIES_NAME . $category_inputs_string);
				$contents[] = array('text' => '<br>' . TEXT_EDIT_CATEGORIES_SEO_URL . $category_seo_string);
				$contents[] = array('text' => '<br>' . tep_image(DIR_WS_CATALOG_IMAGES . $cInfo->categories_image, $cInfo->categories_name) . '<br>' . DIR_WS_CATALOG_IMAGES . '<br><b>' . $cInfo->categories_image . '</b>');
				$contents[] = array('text' => '<br>' . TEXT_EDIT_CATEGORIES_IMAGE . '<br>' . tep_draw_file_field('categories_image'));
				$contents[] = array('text' => '<br>' . TEXT_EDIT_SORT_ORDER . '<br>' . tep_draw_input_field('sort_order', $cInfo->sort_order, 'size="2"'));
		$contents[] = array('text' => '<br>' . TEXT_EDIT_CATEGORIES_DESCRIPTION . '<br>' . $category_description_string);
				$contents[] = array('text' => '<br>' . 'Header Tags Category Title (optional)' . $category_htc_title_string);
				$contents[] = array('text' => '<br>' . 'Header Tags Category Description (optional)' . $category_htc_desc_string);
				$contents[] = array('text' => '<br>' . 'Header Tags Category Keywords (optional)' . $category_htc_keywords_string);
				$contents[] = array('align' => 'center', 'text' => '<br>' . tep_image_submit('button_save.gif', IMAGE_SAVE) . ' <a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&cID=' . $cInfo->categories_id) . '">' . tep_image_button('button_cancel.gif', IMAGE_CANCEL) . '</a>');
				break;
			case 'delete_category':
				$heading[] = array('text' => '<b>' . TEXT_INFO_HEADING_DELETE_CATEGORY . '</b>');

				$contents = array('form' => tep_draw_form('categories', FILENAME_CATEGORIES, 'action=delete_category_confirm&cPath=' . $cPath) . tep_draw_hidden_field('categories_id', $cInfo->categories_id));
				$contents[] = array('text' => TEXT_DELETE_CATEGORY_INTRO);
				$contents[] = array('text' => '<br><b>' . $cInfo->categories_name . '</b>');
				if ($cInfo->childs_count > 0) $contents[] = array('text' => '<br>' . sprintf(TEXT_DELETE_WARNING_CHILDS, $cInfo->childs_count));
				if ($cInfo->products_count > 0) $contents[] = array('text' => '<br>' . sprintf(TEXT_DELETE_WARNING_PRODUCTS, $cInfo->products_count));
				$contents[] = array('align' => 'center', 'text' => '<br>' . tep_image_submit('button_delete.gif', IMAGE_DELETE) . ' <a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&cID=' . $cInfo->categories_id) . '">' . tep_image_button('button_cancel.gif', IMAGE_CANCEL) . '</a>');
				break;
			case 'move_category':
				$heading[] = array('text' => '<b>' . TEXT_INFO_HEADING_MOVE_CATEGORY . '</b>');

				$contents = array('form' => tep_draw_form('categories', FILENAME_CATEGORIES, 'action=move_category_confirm&cPath=' . $cPath) . tep_draw_hidden_field('categories_id', $cInfo->categories_id));
				$contents[] = array('text' => sprintf(TEXT_MOVE_CATEGORIES_INTRO, $cInfo->categories_name));
				$contents[] = array('text' => '<br>' . sprintf(TEXT_MOVE, $cInfo->categories_name) . '<br>' . tep_draw_pull_down_menu('move_to_category_id', tep_get_category_tree(), $current_category_id));
				$contents[] = array('align' => 'center', 'text' => '<br>' . tep_image_submit('button_move.gif', IMAGE_MOVE) . ' <a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&cID=' . $cInfo->categories_id) . '">' . tep_image_button('button_cancel.gif', IMAGE_CANCEL) . '</a>');
				break;
			case 'delete_product':
				$heading[] = array('text' => '<b>' . TEXT_INFO_HEADING_DELETE_PRODUCT . '</b>');

				$contents = array('form' => tep_draw_form('products', FILENAME_CATEGORIES, 'action=delete_product_confirm&cPath=' . $cPath) . tep_draw_hidden_field('products_id', $pInfo->products_id));
				$contents[] = array('text' => TEXT_DELETE_PRODUCT_INTRO);
				$contents[] = array('text' => '<br><b>' . $pInfo->products_name . '</b>');

				$product_categories_string = '';
				$product_categories = tep_generate_category_path($pInfo->products_id, 'product');
				for ($i = 0, $n = sizeof($product_categories); $i < $n; $i++) {
					$category_path = '';
					for ($j = 0, $k = sizeof($product_categories[$i]); $j < $k; $j++) {
						$category_path .= $product_categories[$i][$j]['text'] . '&nbsp;&gt;&nbsp;';
					}
					$category_path = substr($category_path, 0, -16);
					$product_categories_string .= tep_draw_checkbox_field('product_categories[]', $product_categories[$i][sizeof($product_categories[$i])-1]['id'], true) . '&nbsp;' . $category_path . '<br>';
				}
				$product_categories_string = substr($product_categories_string, 0, -4);

				$contents[] = array('text' => '<br>' . $product_categories_string);
				$contents[] = array('align' => 'center', 'text' => '<br>' . tep_image_submit('button_delete.gif', IMAGE_DELETE) . ' <a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&pID=' . $pInfo->products_id) . '">' . tep_image_button('button_cancel.gif', IMAGE_CANCEL) . '</a>');
				break;
			case 'move_product':
				$heading[] = array('text' => '<b>' . TEXT_INFO_HEADING_MOVE_PRODUCT . '</b>');

				$contents = array('form' => tep_draw_form('products', FILENAME_CATEGORIES, 'action=move_product_confirm&cPath=' . $cPath) . tep_draw_hidden_field('products_id', $pInfo->products_id));
				$contents[] = array('text' => sprintf(TEXT_MOVE_PRODUCTS_INTRO, $pInfo->products_name));
				$contents[] = array('text' => '<br>' . TEXT_INFO_CURRENT_CATEGORIES . '<br><b>' . tep_output_generated_category_path($pInfo->products_id, 'product') . '</b>');
				$contents[] = array('text' => '<br>' . sprintf(TEXT_MOVE, $pInfo->products_name) . '<br>' . tep_draw_pull_down_menu('move_to_category_id', tep_get_category_tree(), $current_category_id));
				$contents[] = array('align' => 'center', 'text' => '<br>' . tep_image_submit('button_move.gif', IMAGE_MOVE) . ' <a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&pID=' . $pInfo->products_id) . '">' . tep_image_button('button_cancel.gif', IMAGE_CANCEL) . '</a>');
				break;
			case 'copy_to':
				$heading[] = array('text' => '<b>' . TEXT_INFO_HEADING_COPY_TO . '</b>');

				$contents = array('form' => tep_draw_form('copy_to', FILENAME_CATEGORIES, 'action=copy_to_confirm&cPath=' . $cPath) . tep_draw_hidden_field('products_id', $pInfo->products_id));
				$contents[] = array('text' => TEXT_INFO_COPY_TO_INTRO);
				$contents[] = array('text' => '<br>' . TEXT_INFO_CURRENT_CATEGORIES . '<br><b>' . tep_output_generated_category_path($pInfo->products_id, 'product') . '</b>');
				$contents[] = array('text' => '<br>' . TEXT_CATEGORIES . '<br>' . tep_draw_pull_down_menu('categories_id', tep_get_category_tree(), $current_category_id));
				$contents[] = array('text' => '<br>' . TEXT_HOW_TO_COPY . '<br>' . tep_draw_radio_field('copy_as', 'link', true) . ' ' . TEXT_COPY_AS_LINK . '<br>' . tep_draw_radio_field('copy_as', 'duplicate') . ' ' . TEXT_COPY_AS_DUPLICATE);
				$contents[] = array('align' => 'center', 'text' => '<br>' . tep_image_submit('button_copy.gif', IMAGE_COPY) . ' <a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&pID=' . $pInfo->products_id) . '">' . tep_image_button('button_cancel.gif', IMAGE_CANCEL) . '</a>');
				break;
			default:
				if ($rows > 0) {
					if (isset($cInfo) && is_object($cInfo)) { // category info box contents
						$heading[] = array('text' => '<b>' . $cInfo->categories_name . '</b>');

						$contents[] = array('align' => 'center', 'text' => '<a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&cID=' . $cInfo->categories_id . '&action=edit_category') . '">' . tep_image_button('button_edit.gif', IMAGE_EDIT) . '</a> <a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&cID=' . $cInfo->categories_id . '&action=delete_category') . '">' . tep_image_button('button_delete.gif', IMAGE_DELETE) . '</a> <a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&cID=' . $cInfo->categories_id . '&action=move_category') . '">' . tep_image_button('button_move.gif', IMAGE_MOVE) . '</a>');
						$contents[] = array('text' => '<br>' . TEXT_DATE_ADDED . ' ' . tep_date_short($cInfo->date_added));
						if (tep_not_null($cInfo->last_modified)) $contents[] = array('text' => TEXT_LAST_MODIFIED . ' ' . tep_date_short($cInfo->last_modified));
						$contents[] = array('text' => '<br>' . tep_info_image($cInfo->categories_image, $cInfo->categories_name, HEADING_IMAGE_WIDTH, HEADING_IMAGE_HEIGHT) . '<br>' . $cInfo->categories_image);
						$contents[] = array('text' => '<br>' . TEXT_SUBCATEGORIES . ' ' . $cInfo->childs_count . '<br>' . TEXT_PRODUCTS . ' ' . $cInfo->products_count);
					} elseif (isset($pInfo) && is_object($pInfo)) { // product info box contents
						$heading[] = array('text' => '<b>' . tep_get_products_name($pInfo->products_id, $languages_id) . '</b>');

						$contents[] = array('align' => 'center', 'text' => '<a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&pID=' . $pInfo->products_id . '&action=new_product') . '">' . tep_image_button('button_edit.gif', IMAGE_EDIT) . '</a> <a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&pID=' . $pInfo->products_id . '&action=delete_product') . '">' . tep_image_button('button_delete.gif', IMAGE_DELETE) . '</a> <a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&pID=' . $pInfo->products_id . '&action=move_product') . '">' . tep_image_button('button_move.gif', IMAGE_MOVE) . '</a> <a href="' . tep_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&pID=' . $pInfo->products_id . '&action=copy_to') . '">' . tep_image_button('button_copy_to.gif', IMAGE_COPY_TO) . '</a>');
						$contents[] = array('text' => '<br>' . TEXT_DATE_ADDED . ' ' . tep_date_short($pInfo->products_date_added));
						if (tep_not_null($pInfo->products_last_modified)) $contents[] = array('text' => TEXT_LAST_MODIFIED . ' ' . tep_date_short($pInfo->products_last_modified));
						if (date('Y-m-d') < $pInfo->products_date_available) $contents[] = array('text' => TEXT_DATE_AVAILABLE . ' ' . tep_date_short($pInfo->products_date_available));
						$contents[] = array('text' => '<br>' . tep_info_image($pInfo->products_image, $pInfo->products_name, SMALL_IMAGE_WIDTH, SMALL_IMAGE_HEIGHT) . '<br>' . $pInfo->products_image);
						$contents[] = array('text' => '<br>' . TEXT_PRODUCTS_PRICE_INFO . ' ' . $currencies->format($pInfo->products_price) . '<br>' . TEXT_PRODUCTS_QUANTITY_INFO . ' ' . $pInfo->products_quantity);
						$contents[] = array('text' => '<br>' . TEXT_PRODUCTS_AVERAGE_RATING . ' ' . number_format($pInfo->average_rating, 2) . '%');
					}
				} else { // create category/product info
					$heading[] = array('text' => '<b>' . EMPTY_CATEGORY . '</b>');

					$contents[] = array('text' => TEXT_NO_CHILD_CATEGORIES_OR_PRODUCTS);
				}
				break;
		}

		if ( (tep_not_null($heading)) && (tep_not_null($contents)) ) {
			echo '            <td width="25%" valign="top">' . "\n";

			$box = new box;
			echo $box->infoBox($heading, $contents);

			echo '            </td>' . "\n";
		}
?>
					</tr>
				</table></td>
			</tr>
		</table>
<?php
	}
?>
		</td>
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
