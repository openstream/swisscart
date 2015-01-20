<?php
/*
  $Id: gzip_compression.php,v 1.3 2003/02/11 01:31:02 hpdl Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Customized by swisscart�, Swiss Webshop Solutions
  http://www.swisscart.com

  Copyright (c) 2003-2007 osCommerce

  Released under the GNU General Public License
*/

  function tep_check_gzip() {
    $HTTP_ACCEPT_ENCODING = $_SERVER['HTTP_ACCEPT_ENCODING'];

    if (headers_sent() || connection_aborted()) {
      return false;
    }

    if (strpos($HTTP_ACCEPT_ENCODING, 'x-gzip') !== false) return 'x-gzip';

    if (strpos($HTTP_ACCEPT_ENCODING,'gzip') !== false) return 'gzip';

    return false;
  }

/* $level = compression level 0-9, 0=none, 9=max */
  function tep_gzip_output($level = 5) {
    if ($encoding = tep_check_gzip()) {
      $contents = ob_get_contents();
      ob_end_clean();

      header('Content-Encoding: ' . $encoding);

      $size = strlen($contents);
      $crc = crc32($contents);

      $contents = gzcompress($contents, $level);
      $contents = substr($contents, 0, strlen($contents) - 4);

      echo "\x1f\x8b\x08\x00\x00\x00\x00\x00";
      echo $contents;
      echo pack('V', $crc);
      echo pack('V', $size);
    } else {
      ob_end_flush();
    }
  }
?>
