<?php
	/**
	* debugger class by Claudio
	* date: April, 2009
	*********************************************************************/

	class debugger {
			var $support_address, $support_dept;
			var $script_address, $logdir;
			// class constructor
			function debugger() {
        $this->support_dept = 'Swisscart Support';
        $this->support_address = 'claudio@openstream.ch';
				if(!defined('DIR_WS_ADMIN')){
					$this->script_address = HTTP_SERVER.DIR_WS_HTTP_CATALOG;
				} else {
					$this->script_address = HTTP_SERVER.DIR_WS_ADMIN;
				}
				$this->logdir = DIR_FS_CATALOG.'data/logs/';
				if(!is_dir($this->logdir)){
					@mkdir($this->logdir, 0777, true);
          @chmod($this->logdir, 0777);
				}
        $this->enabled = ($_SESSION['debug_mode']=='yes');

			}

			function support_email($name,$data){
					// send email to support
					$email_subject = 'Error info from '.STORE_NAME.' located at '.$this->script_address;
					$email_content = $email_subject."\n\n".
													 $name."\n".
													 print_r($data, true);
					if(EMAIL_USE_HTML == 'true') {
						 $email_content = nl2br($email_content);
					}
					tep_mail($this->support_dept, $this->support_address,  $email_subject, $email_content, STORE_OWNER, STORE_OWNER_EMAIL_ADDRESS);
			}

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
					if ($this->enabled){
							$this->debug_open_window();
							$captured = explode("\n",$this->debug_capture_print_r($data));
							$captured = str_replace("\r", '',$captured);
							print "<script language='JavaScript'>\n";
							print "debugWindow.document.writeln('<b>$name</b>');\n";
							print "debugWindow.document.writeln('<pre>');\n";
							foreach($captured as $line)
							{
									$line = preg_replace('/\t\r\n/', '', $line);
									print "debugWindow.document.writeln('".$this->debug_colorize_string(htmlentities($line, ENT_QUOTES))."');\n";
							}
							print "debugWindow.document.writeln('</pre>');\n";
							print "self.focus();\n";
							print "</script>\n";
					}
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
					if ($this->enabled){
							$this->debug_open_window();
							print "<script language='JavaScript'>\n";
							print "debugWindow.document.writeln('".addslashes(trim(nl2br($mesg)))."<br>');\n";
							print "self.focus();\n";
							print "</script>\n";
					}
			}

			/**
			* open a debug window for display
			*
			* this function may be called multiple times
			* it will only print the code to open the
			* remote window the first time that it is called.
			*
			* @access private
			* @return null
			* @global
			*/
			function debug_open_window()
			{
					static $window_opened = FALSE;
					if(!$window_opened and ($this->enabled))
					{
							?>
							<script language="JavaScript">
							debugWindow = window.open("","debugWin","toolbar=no,scrollbars,width=600,height=400");
							debugWindow.document.writeln('<html>');
							debugWindow.document.writeln('<head>');
							debugWindow.document.writeln('<title>PHP Remote debug Window</title>');
							debugWindow.document.writeln('<style');
							debugWindow.document.writeln('body{ font-size: 10px; }');
							debugWindow.document.writeln('</style');
							debugWindow.document.writeln('</head>');
							debugWindow.document.writeln('<body><font face="verdana,arial">');
							debugWindow.document.writeln('<hr size=1 width="100%">');
							</script>
							<?php
							$window_opened = TRUE;
					}
			}


			/**
			* catch the contents of a print_r into a string
			*
			* @access private
			* @param $data unknown variable
			* @return string print_r results
			* @global
			*/
			function debug_capture_print_r($data)
			{
					return print_r($data,true);
			}


			/**
			* colorize a string for pretty display
			*
			* @access private
			* @param $string string info to colorize
			* @return string HTML colorized
			* @global
			*/
			function debug_colorize_string($string)
			{
					/* turn array indexes to red */
					$string = str_replace('[','[<font color="red">',$string);
					$string = str_replace(']','</font>]',$string);
					$string = str_replace('\'','\\\'',$string);
					$string = addslashes($string);
					/* turn the word Array blue */
					$string = str_replace('Array','<font color="blue">Array</font>',$string);
					/* turn arrows graygreen */
					$string = str_replace('=>','<font color="#556F55">=></font>',$string);
					return $string;
			}

			function log($title, $info, $filename='syslog_'){
				$logfile = fopen($this->logdir.$filename.date('Y_m_d').'.log','a+');
				fwrite($logfile, "\n".date('H:i:s:u - ').$title."\n".print_r($info,true));
			}

      function debug_email($name,$data){
        // send email to support

        $email_content = 'Error info from '.STORE_NAME.' located at '.$this->script_address."\n\n".
                         $name."\n".
                         print_r($data, true);
        if(EMAIL_USE_HTML == 'true') {
           $email_content = nl2br($email_content);
        }
        tep_mail($this->support_dept, $this->support_address,  'Error at '.STORE_NAME.'. Details inside.', $email_content, STORE_OWNER, STORE_OWNER_EMAIL_ADDRESS);
    	}
  }