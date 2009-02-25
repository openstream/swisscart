/**theme_advanced_buttons1_add : "emotions"
 * Plug-in used to toggle ON or OFF the default self-closing tags
 * (area, br, col, hr, img, input, link, meta, param)
 * 
 * Usage:
 * 		1. Add 'selfclosetags' to the list of plug-ins to be loaded
 * 
 * 		2. [optional] Tell tinyMCE where to show the Self-close toggle button
 * 				by adding 'selfclosetags' when you define your toolbars with 'theme_advanced_buttons1' 
 * 			OR
 * 				by using 'theme_advanced_buttons1_add : "selfclosetags"' command
 * 			WHERE you can replace '1' with any number from 1 to 4
 * 
 * 		3. [optional] Set the default closing mode: '>' or ' />' (defaults to '>')
 * 				by setting the 'selfclosetags' variable in the object passed to 'tinyMCE.init()' function (recommended)
 * 			OR
 * 				by setting the 'tinyMCE.settings.selfclosetags' variable to the desired value
 * 
 *
 * @author Ionut Botizan <ionut.botizan@webness.ro> a.k.a. prafuitu
 * @copyright Copyright © 2008, Ionut Botizan, All rights reserved.
 */
(function(){
	tinymce.create('tinymce.plugins.selfCloseTags', {
		init: function(ed, url){

			// Set initial value if not already set
			if (tinyMCE.settings.selfclosetags != ' />' && tinyMCE.settings.selfclosetags != '>') {
				tinyMCE.settings.selfclosetags = '>';
			}

			// Register function to modify self-closing tags
			ed.onPostProcess.add(function(ed, o) {
				o.content = o.content.replace(/<(area|base|br|col|hr|img|input|link|meta|param)([^>]*)\s+\/+>/g, '<$1$2' + tinyMCE.settings.selfclosetags);
			});

			// Register command to execute on button click
			ed.addCommand('c_selfclosetags', function(){
				tinyMCE.settings.selfclosetags = (tinyMCE.settings.selfclosetags == ' />') ? '>' : ' />';
			});

			// Register button to toggle self-closing tags
			ed.addButton('selfclosetags', {
				title: 'Enable xHTML self-close tags',
				cmd: 'c_selfclosetags',
				image: url + '/selfclosetags.gif'
			});

			// Register function to update button state
			ed.onNodeChange.add(function(ed, cm){
				cm.setActive('selfclosetags', tinyMCE.settings.selfclosetags == ' />');
			});

		},

		getInfo: function(){
			return {
				longname: 'HTML self-close tags toggle',
				author: 'Ionut Botizan <ionut.botizan@webness.ro>',
				authorurl: 'http://ionut-botizan.webness.ro',
				version: '1.0'
			};
		}
	});

	// Register plugin
	tinymce.PluginManager.add('selfclosetags', tinymce.plugins.selfCloseTags);
})();