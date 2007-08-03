<?php
if(!isset($PHP_AUTH_USER)) 
{	header('WWW-Authenticate: Basic realm="' . html_entity_decode(TITLE) . '"');
	header('HTTP/1.0 401 Unauthorized');
	echo $SERVER_NAME . ' Authorization Required.';
	exit;
} 
else
{	if (($PHP_AUTH_USER != ADMIN_USERNAME) || ($PHP_AUTH_PW != ADMIN_PASSWORD)) 
	{	header('WWW-Authenticate: Basic realm="' . html_entity_decode(TITLE) . '"');
		header('HTTP/1.0 401 Unauthorized');
		echo $SERVER_NAME . ' Authorization Required.';
		exit;
	}
}
?>