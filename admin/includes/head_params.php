<?php
/*******************************************************
* includes/head_params.php
*
* load some common scripts and code to all admin pages
*
* Author: Claudio H. Imai
* 2010.07
*
* Copyright swisscart
********************************************************/
?>

<script type="text/javascript" src="<?php echo DIR_WS_CATALOG.'includes/js/jQuery/'; ?>jquery.min.js"></script>
<!--// load jQuery Plug-ins //-->
<script type="text/javascript" src="<?php echo DIR_WS_CATALOG.'includes/js/jQuery/'; ?>jquery.tools.min.js"></script>
<script type="text/javascript" src="<?php echo DIR_WS_CATALOG.'includes/js/jQuery/'; ?>jquery-ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<?php echo DIR_WS_CATALOG.'includes/js/jQuery/'; ?>smoothness/jquery-ui.css">
<?php
if (file_exists(DIR_FS_CATALOG.'includes/js/jQuery/languages/'.$language.'/jquery.ui.datepicker.js')){
	echo '<script type="text/javascript" src="'. DIR_WS_CATALOG.'includes/js/jQuery/languages/'.$language.'/jquery.ui.datepicker.js"></script>';
}
?>
<?php // do not load this ressource twice ... /* <script language="javascript" src="includes/general.js"></script> */ ?>

<script type="text/javascript">
	jQuery.noConflict();

	jQuery(document).ready(function(){
			jQuery("acronym.tooltips[title],img.tooltips[alt],a.tooltips[title]").tooltip({

				// use single tooltip element for all tips
				tip: '#tooltip',

				// tweak the position
				offset: [0, 0],

				// use "slide" effect
				//effect: 'slide',
				lazy: false

		// add dynamic plugin
		}).dynamic( {

				// customized configuration on bottom edge
				bottom: {

						// slide downwards
						direction: 'down',

						// bounce back when closed
						bounce: true
				}
		});
	});
</script>
