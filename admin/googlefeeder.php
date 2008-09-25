<?php
//  Title: Google Base / Froogle Data Feeder 1.20
//  Author: Calvin K
//  Contact: calvink@conceptulanetworking.com
//	Organization: Conceptual Networking
//  Last Update: 2/20/07

require('includes/configure.php');
require(DIR_WS_FUNCTIONS . 'database.php');
  
//  Start TIMER
//  -----------
$stimer = explode( ' ', microtime() );
$stimer = $stimer[1] + $stimer[0];
//  -----------

//START Required Configuration

$OutFile = "../pub/feeds/froogle.txt"; //"CHANGEME-full-path-to-file-with-777-dir-and-file-permissions-your-outfile.txt";
$destination_file = "froogle.txt";  //"CHANGEME-filename-to-upload-to-google.txt" ;
$source_file = $OutFile;
$catalogURL = HTTP_CATALOG_SERVER;
$imageURL = HTTP_CATALOG_SERVER . '/' . DIR_WS_IMAGES;
$productURL = HTTP_CATALOG_SERVER . '/product_info.php?products_id=';
$already_sent = array();

$home = DB_SERVER;
$user = DB_SERVER_USERNAME;
$pass = DB_SERVER_PASSWORD;
$base = DB_DATABASE;

$ftp_server = "uploads.google.com" ;
$ftp_user_name = "CHANGEME-googleFTP-username";
$ftp_user_pass = "CHANGEME-googleFTP-password";
$ftp_directory = ""; // leave blank

$productCondition = ""; //new, used, OR refurbished for ALL products.

//END Required Configuration


//START Optional Advance Configuration

$SEO_FLAG = 0; //default = 0

//Monetary Adjustments for Products in Feed
$taxRate = 0; //default = 0 (e.g. for 17.5% tax use "$taxRate = 17.5;")
$taxCalc = ($taxRate/100) + 1;  //Do not edit
$convertCur = true; //default = false
$curType = "EUR"; // Converts Currency to any defined currency (eg. USD, EUR, GBP)
if($convertCur)
{
$productURL = HTTP_CATALOG_SERVER . "/product_info.php?currency=" . $curType . "&products_id=";  //where CURTYPE is your currency type (eg. USD, EUR, GBP)
}

//END Optional Advance Configuration


//START Optional Advance Feed Attributes

//(0=False 1=True) (optional_sec must be enabled to use any options)
$optional_sec = 0;
$shipping = 0;
	$flatShipping = "";  //this is not binary.  Custom Code is required to provide the shipping cost per product.  ###needs to be an array for per product.
$pickup = 0;
	$pickup_value = "false"; //true or false only.
$price_type = 0;
	$price_type_value = ""; //negotiable or starting.
$payment_accepted = 0;
	$default_payment_methods = ""; //Acceptable values: cash, check, GoogleCheckout, Visa, MasterCard, AmericanExpress, Discover, wiretransfer
$payment_notes = 0;
	$payment_notes_text = ""; //payment policy text
$model_number = 0; //this is for the manufacturer model number, NOT your internal store sku
$feed_quantity = 0;
$tax_percent = 0;
	$tax_percent_additonal_value = 0; //default = 0 (e.g. for 17.5% tax use "$tax_percent_additonal_value = 17.5;")  Please note that this is tax in addition to the taxRate set above.  If the taxRate set above is 0%, then this is your full tax rate for your region.
$tax_region = 0;
	$tax_region_value = "";

//END Optional Advance Feed Attributes



$feed_exp_date = date('Y-m-d', time() + 2592000 );


if (!($link=mysql_connect($home,$user,$pass)))
{
echo "Error when connecting itself to the data base";
exit();
}
if (!mysql_select_db( $base , $link ))
{
echo "Error the data base does not exist";
exit();
}

$sql = "
SELECT concat( '" . $productURL . "' ,products.products_id) AS product_url,
products_model AS prodModel, products_weight,
manufacturers.manufacturers_name AS mfgName,
manufacturers.manufacturers_id,
products.products_id AS id,
products_description.products_name AS name,
products_description.products_description AS description,
products.products_quantity AS quantity,
products.products_status AS prodStatus,
FORMAT( IFNULL(specials.specials_new_products_price, products.products_price) * " . $taxCalc . ",2) AS price,
CONCAT( '" . $imageURL . "' ,products.products_image) AS image_url,
products_to_categories.categories_id AS prodCatID,
categories.parent_id AS catParentID,
categories_description.categories_name AS catName
FROM (categories,
categories_description,
products,
products_description,
products_to_categories)

left join manufacturers on ( manufacturers.manufacturers_id = products.manufacturers_id )
left join specials on ( specials.products_id = products.products_id AND ( ( (specials.expires_date > CURRENT_DATE) OR (specials.expires_date = 0) ) AND ( specials.status = 1 ) ) )

WHERE products.products_id=products_description.products_id
AND products.products_id=products_to_categories.products_id
AND products_to_categories.categories_id=categories.categories_id
AND categories.categories_id=categories_description.categories_id
ORDER BY
products.products_id ASC
";


$catInfo = "
SELECT
categories.categories_id AS curCatID,
categories.parent_id AS parentCatID,
categories_description.categories_name AS catName
FROM
categories,
categories_description
WHERE categories.categories_id = categories_description.categories_id
";

function findCat($curID, $catTempPar, $catTempDes, $catIndex)
{
	if( (isset($catTempPar[$curID])) && ($catTempPar[$curID] != 0) )
	{
		if(isset($catIndex[$catTempPar[$curID]]))
		{
			$temp=$catIndex[$catTempPar[$curID]];
		}
		else
		{
			$catIndex = findCat($catTempPar[$curID], $catTempPar, $catTempDes, $catIndex);
			$temp = $catIndex[$catTempPar[$curID]];
		}
	}
	if( (isset($catTempPar[$curID])) && (isset($catTempDes[$curID])) && ($catTempPar[$curID] == 0) )
	{
		$catIndex[$curID] = $catTempDes[$curID];
	}
	else
	{
		$catIndex[$curID] = $temp . ", " . $catTempDes[$curID];
	}
	return $catIndex;

}

$catIndex = array();
$catTempDes = array();
$catTempPar = array();
$processCat = mysql_query( $catInfo )or die( $FunctionName . ": SQL error " . mysql_error() . "| catInfo = " . htmlentities($catInfo) );
while ( $catRow = mysql_fetch_object( $processCat ) )
{
	$catKey = $catRow->curCatID;
	$catName = $catRow->catName;
	$catParID = $catRow->parentCatID;
	if($catName != "")
	{
		$catTempDes[$catKey]=$catName;
		$catTempPar[$catKey]=$catParID;
	}
}

foreach($catTempDes as $curID=>$des)  //don't need the $des
{
	$catIndex = findCat($curID, $catTempPar, $catTempDes, $catIndex);
}

$_strip_search = array(
"![\t ]+$|^[\t ]+!m", // remove leading/trailing space chars
'%[\r\n]+%m'); // remove CRs and newlines
$_strip_replace = array(
'',
' ');
$_cleaner_array = array(">" => "> ", "&reg;" => "", "®" => "", "&trade;" => "", "™" => "", "\t" => "", "	" => "");

if ( file_exists( $OutFile ) )
unlink( $OutFile );

$output = "brand\tcondition\tlink\ttitle\tdescription\texpiration_date\tprice\timage_link\tproduct_type\tid";

//create optional section
if($optional_sec == 1)
{
	if($shipping == 1)
		$output .= "\tshipping";
	if($pickup == 1)
		$output .= "\tpickup";
	if($price_type == 1)
		$output .= "\tprice_type";
	if($payment_accepted == 1)
		$output .= "\tpayment_accepted";
	if($payment_notes == 1)
		$output .= "\tpayment_notes";
	if($model_number == 1)
		$output .= "\tmodel_number";
	if($feed_quantity == 1)
		$output .= "\tquantity";
	if($tax_percent == 1)
		$output .= "\ttax_percent";
	if($tax_region == 1)
		$output .= "\ttax_region";
}
$output .= "\n";


$result=mysql_query( $sql )or die( $FunctionName . ": SQL error " . mysql_error() . "| sql = " . htmlentities($sql) );

//Currency Information
if($convertCur)
{
	$sql3 = "
	SELECT
	currencies.value AS curUSD
	FROM
	currencies
	WHERE currencies.code = '$curType'
	";

	$result3=mysql_query( $sql3 )or die( $FunctionName . ": SQL error " . mysql_error() . "| sql3 = " . htmlentities($sql3) );
	$row3 = mysql_fetch_object( $result3 );
}

$loop_counter = 0;

while( $row = mysql_fetch_object( $result ) )
{
	if (isset($already_sent[$row->id])) continue; // if we've sent this one, skip the rest of the while loop

	if( $row->prodStatus == 1 || ($optional_sec == 1 && $feed_quantity == 1) )
	{

		if($convertCur)
		{
			$row->price = ereg_replace("[^.0-9]", "", $row->price);
			$row->price = $row->price *  $row3->curUSD;
			$row->price = number_format($row->price, 2, '.', ',');
		}

		//SEO Link Translation Logic: Edit as Neccessary
		$productURL="";
		if($SEO_FLAG)
		{
			$string = ereg_replace("[^a-zA-Z0-9 ]", "", $row->name);
			$string = ereg_replace('  ', ' ', $string);
			$string = ereg_replace(' ', '-', strtolower($string));

			$productURL = $catalogURL . $string . "-p-" . $row->id . ".html";
		}
		else
		{
		$productURL = $row->product_url;
		}

		$output .=
		$row->mfgName . "\t" .
		$productCondition . "\t" .
		$productURL . "\t" .
		preg_replace($_strip_search, $_strip_replace, strip_tags( strtr($row->name, $_cleaner_array) ) ) . "\t" .
		preg_replace($_strip_search, $_strip_replace, strip_tags( strtr($row->description, $_cleaner_array) ) ) . "\t" .
		$feed_exp_date . "\t" .
		$row->price . "\t" .
		$row->image_url . "\t" .
		$catIndex[$row->prodCatID] . "\t" .
		$row->id;

		//optional values section
		if($optional_sec == 1)
		{
			if($shipping == 1)
					$output .= "\t" . $flatShipping;
			if($pickup == 1)
					$output .= "\t" . $pickup_value;
			if($price_type == 1)
					$output .= "\t" . $price_type_value;
			if($payment_accepted == 1)
					$output .= "\t" . $default_payment_methods;
			if($payment_notes == 1)
					$output .= "\t" . $payment_notes_text;
			if($model_number == 1)
					$output .= "\t" . $row->prodModel;
			if($feed_quantity == 1)
					$output .= "\t" . $row->quantity;
			if($tax_percent == 1)
					$output .= "\t" . $tax_percent_additonal_value;
			if($tax_region == 1)
					$output .= "\t" . $tax_region_value;
		}
		$output .= " \n";
		}
		$already_sent[$row->id] = 1;


		$loop_counter++;
		if ($loop_counter>750) {
		$fp = fopen( $OutFile , "a" );
		$fout = fwrite( $fp , $output );
		fclose( $fp );
		$loop_counter = 0;
		$output = "";
	}
}

$fp = fopen( $OutFile , "a" );
$fout = fwrite( $fp , $output );
fclose( $fp );
echo "File completed: <a href=\"" . $OutFile . "\" target=\"_blank\">" . $destination_file . "</a><br>\n";
chmod($OutFile, 0777);


//Start FTP

function ftp_file( $ftpservername, $ftpusername, $ftppassword, $ftpsourcefile, $ftpdirectory, $ftpdestinationfile )
{
// set up basic connection
$conn_id = ftp_connect($ftpservername);
if ( $conn_id == false )
{
echo "FTP open connection failed to $ftpservername <BR>\n" ;
return false;
}

// login with username and password
$login_result = ftp_login($conn_id, $ftpusername, $ftppassword);

// check connection
if ((!$conn_id) || (!$login_result)) {
echo "FTP connection has failed!<BR>\n";
echo "Attempted to connect to " . $ftpservername . " for user " . $ftpusername . "<BR>\n";
return false;
} else {
echo "Connected to " . $ftpservername . ", for user " . $ftpusername . "<BR>\n";
}

if ( strlen( $ftpdirectory ) > 0 )
{
if (ftp_chdir($conn_id, $ftpdirectory )) {
echo "Current directory is now: " . ftp_pwd($conn_id) . "<BR>\n";
} else {
echo "Couldn't change directory on $ftpservername<BR>\n";
return false;
}
}

ftp_pasv ( $conn_id, true ) ;
// upload the file
$upload = ftp_put( $conn_id, $ftpdestinationfile, $ftpsourcefile, FTP_ASCII );

// check upload status
if (!$upload) {
echo "$ftpservername: FTP upload has failed!<BR>\n";
return false;
} else {
echo "Uploaded " . $ftpsourcefile . " to " . $ftpservername . " as " . $ftpdestinationfile . "<BR>\n";
}

// close the FTP stream
ftp_close($conn_id);

return true;
}

//ftp_file( $ftp_server, $ftp_user_name, $ftp_user_pass, $source_file, $ftp_directory, $destination_file);

//End FTP


//  End TIMER
//  ---------
$etimer = explode( ' ', microtime() );
$etimer = $etimer[1] + $etimer[0];
echo '<p style="margin:auto; text-align:center">';
printf( "Script timer: <b>%f</b> seconds.", ($etimer-$stimer) );
echo '</p>';
//  ---------

?>