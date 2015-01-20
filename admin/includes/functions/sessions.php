<?php
/*
  $Id: sessions.php,v 1.9 2003/06/23 01:20:05 hpdl Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Customized by swisscart®, Swiss Webshop Solutions
  http://www.swisscart.com

  Copyright (c) 2003-2007 osCommerce

  Released under the GNU General Public License
*/
  if ( (PHP_VERSION >= 4.3) && ((bool)ini_get('register_globals') == false) ) {
    @ini_set('session.bug_compat_42', 1);
    @ini_set('session.bug_compat_warn', 0);
  }

  if (STORE_SESSIONS == 'mysql') {
    if (!$SESS_LIFE = get_cfg_var('session.gc_maxlifetime')) {
      $SESS_LIFE = 1440;
    }

    function _sess_open($save_path, $session_name) {
      return true;
    }

    function _sess_close() {
      return true;
    }

    function _sess_read($key) {
      $qid = tep_db_query("select value from " . TABLE_SESSIONS . " where sesskey = '" . tep_db_input($key) . "' and expiry > '" . time() . "'");

      $value = tep_db_fetch_array($qid);
      if ($value['value']) {
        return $value['value'];
      }

      return false;
    }

    function _sess_write($key, $val) {
      global $SESS_LIFE;

      $expiry = time() + $SESS_LIFE;
      $value = $val;

      $qid = tep_db_query("select count(*) as total from " . TABLE_SESSIONS . " where sesskey = '" . tep_db_input($key) . "'");
      $total = tep_db_fetch_array($qid);

      if ($total['total'] > 0) {
        return tep_db_query("update " . TABLE_SESSIONS . " set expiry = '" . tep_db_input($expiry) . "', value = '" . tep_db_input($value) . "' where sesskey = '" . tep_db_input($key) . "'");
      } else {
        return tep_db_query("insert into " . TABLE_SESSIONS . " values ('" . tep_db_input($key) . "', '" . tep_db_input($expiry) . "', '" . tep_db_input($value) . "')");
      }
    }

    function _sess_destroy($key) {
      return tep_db_query("delete from " . TABLE_SESSIONS . " where sesskey = '" . tep_db_input($key) . "'");
    }

    function _sess_gc($maxlifetime) {
      tep_db_query("delete from " . TABLE_SESSIONS . " where expiry < '" . time() . "'");

      return true;
    }

    session_set_save_handler('_sess_open', '_sess_close', '_sess_read', '_sess_write', '_sess_destroy', '_sess_gc');
  }

  function tep_session_start() {
    global $HTTP_GET_VARS, $HTTP_POST_VARS, $HTTP_COOKIE_VARS;

    $sane_session_id = true;

    if ( isset($HTTP_GET_VARS[tep_session_name()]) ) {
      if ( (SESSION_FORCE_COOKIE_USE == 'True') || (preg_match('/^[a-zA-Z0-9,-]+$/', $HTTP_GET_VARS[tep_session_name()]) == false) ) {
        unset($HTTP_GET_VARS[tep_session_name()]);

        $sane_session_id = false;
      }
//    return session_start();
  	}

	  if ( isset($HTTP_POST_VARS[tep_session_name()]) ) {
	  	if ( (SESSION_FORCE_COOKIE_USE == 'True') || (preg_match('/^[a-zA-Z0-9,-]+$/', $HTTP_POST_VARS[tep_session_name()]) == false) ) {
	  		unset($HTTP_POST_VARS[tep_session_name()]);
	  
	  		$sane_session_id = false;
	  	}
	  }
	  
	  if ( isset($HTTP_COOKIE_VARS[tep_session_name()]) ) {
	  	if ( preg_match('/^[a-zA-Z0-9,-]+$/', $HTTP_COOKIE_VARS[tep_session_name()]) == false ) {
	  		$session_data = session_get_cookie_params();
	  
	  		setcookie(tep_session_name(), '', time()-42000, $session_data['path'], $session_data['domain']);
	  		unset($HTTP_COOKIE_VARS[tep_session_name()]);
	  
	  		$sane_session_id = false;
	  	}
	  }

	  if ($sane_session_id == false) {
	  	tep_redirect(tep_href_link(FILENAME_DEFAULT, '', 'SSL', false));
	  }
	  
	  register_shutdown_function('session_write_close');
	  
	  return session_start();
  }
	   
  function tep_session_register($variable) {
    if (PHP_VERSION < 4.3) {
      return session_register($variable);
    } else {
      if (!isset($GLOBALS[$variable])) {
        $GLOBALS[$variable] = null;
      }

      $_SESSION[$variable] =& $GLOBALS[$variable];
    }
    return false;
 }

 
  function tep_session_is_registered($variable) {
    if (PHP_VERSION < 4.3) {
      return session_is_registered($variable);
    } else {
      return isset($_SESSION) && array_key_exists($variable, $_SESSION);
    }
  }

  function tep_session_unregister($variable) {
    if (PHP_VERSION < 4.3) {
      return session_unregister($variable);
    } else {
      unset($_SESSION[$variable]);
    }
  }

  function tep_session_id($sessid = '') {
    if ($sessid != '') {
      return session_id($sessid);
    } else {
      return session_id();
    }
  }

  function tep_session_name($name = '') {
    if ($name != '') {
      return session_name($name);
    } else {
      return session_name();
    }
  }

  function tep_session_close() {
    if (PHP_VERSION >= '4.0.4') {
      return session_write_close();
    } elseif (function_exists('session_close')) {
      return session_close();
    }
  }

  function tep_session_destroy() {
    global $HTTP_COOKIE_VARS;

    if ( isset($HTTP_COOKIE_VARS[tep_session_name()]) ) {
      $session_data = session_get_cookie_params();

      setcookie(tep_session_name(), '', time()-42000, $session_data['path'], $session_data['domain']);
      unset($HTTP_COOKIE_VARS[tep_session_name()]);
    }

    return session_destroy();
  }

  function tep_session_save_path($path = '') {
    if ($path != '') {
      return session_save_path($path);
    } else {
      return session_save_path();
    }
  }
?>
