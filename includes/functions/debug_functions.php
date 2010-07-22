<?php
if (isset($_GET['debug_mode'])){
	 if ($_GET['debug_mode']=='yes'){
			if (!tep_session_is_registered('debug_mode')) {
				 tep_session_register('debug_mode');
				 $_SESSION['debug_mode']= $debug_mode = $_GET['debug_mode'];
			}
	 } else {
			unset($_SESSION['debug_mode']);
	 }
}

include_once(DIR_FS_CATALOG . DIR_WS_CLASSES . 'debugger.php');
$debugger = new debugger();

/**
* print debug information to the current debug window
*
* @access public
* @param $name string variable name
* @param $data unknown variable
* @return null
* @global
*/

function debug_var($name,$data){
		global $debugger;

		$debugger->debug_var($name,$data);
}

/**
* print a message to the debug window
*
* @access public
* @param $mesg string message to display
* @return null
* @global
*/
function debug_msg($mesg)
{
		global $debugger;

		$debugger->debug_msg($mesg);
}

	function debug_email($name,$data){
		global $debugger;

		$debugger->debug_email($name,$data);
	}

function debug_log($title, $info = '', $filename='syslog_'){
		global $debugger;

		$debugger->log($title, $info, $filename='syslog_');
}
