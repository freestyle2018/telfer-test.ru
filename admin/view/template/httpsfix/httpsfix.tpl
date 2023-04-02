<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">

	<div class="scp_grad" style="overflow: hidden;">
	    <div style="float:left; margin-top: 10px;" >
	    	<img src="view/image/httpsfix/httpsfix-icon.png" style="height: 21px; margin-left: 10px; " >
	    </div>

		<div style="margin-left: 10px; float:left; margin-top: 10px;  color: #777;">
		<ins id="heading_title"style="padding-top: 17px; text-shadow: 0 2px 1px #FFFFFF; padding-left: 3px;  font-weight: normal;  text-decoration: none; ">
		<?php echo strip_tags($heading_title); ?>
		</ins><ins id="heading_version"> ver.: <?php echo $httpsfix_version; ?></ins>

		</div>

		<div class="scp_grad_green" style=" height: 40px; float:right; ">
	      <div style="color: #555;margin-top: 2px; line-height: 18px; margin-left: 9px; margin-right: 9px; overflow: hidden;"><?php echo $language->get('heading_dev'); ?></div>
	    </div>
	</div>

  	<div id="content_httpsfix" class="container-fluid">

			<?php if ($error_warning) { ?>
			    <div class="alert alert-danger warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			      <button type="button" class="close sc_button" data-dismiss="alert">&times;</button>
			    </div>
			<?php } ?>

			<?php if ($success) { ?>
			    <div class="alert alert-success success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
			      <button type="button" class="close sc_button" data-dismiss="alert">&times;</button>
			    </div>
			<?php } ?>

				<div class="content">

					<div style="margin:5px; float:right;">
					   <a href="#" class="mbutton httpsfix_save sc_button"><?php echo $button_save; ?></a>
					   <a onclick="location = '<?php echo $cancel; ?>';" class="mbutton nohref sc_button"><?php echo $button_cancel; ?></a>
					</div>

					<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">

					<script type="text/javascript">
					function delayer(){
					    window.location = 'index.php?route=module/httpsfix&<?php echo $token_name; ?>=<?php echo $token; ?>';
					}
					</script>

					<div id="tabs" class="htabs">
						<a href="#tab-options"><?php echo $language->get('entry_tab_options'); ?></a>
						<a href="#tab-doc"><?php echo $language->get('entry_tab_doc'); ?></a>
					</div>


					<div id="tab-options">

					  <?php echo $text_new_version; ?>


						<div style="margin-top:10px;">
								<a onclick="$('.pro').toggle('slow', function() {

								        if ($('.pro_updown').hasClass('pro_button_hidden')) {

								            $('.pro_updown').removeClass('pro_button_hidden').addClass('pro_button_show');
								            $('.pro_up_down').removeClass('pro_button_active');
								            $('.pro_updown').html('<?php echo $language->get('entry_show_pro'); ?>');

								        } else {

								            $('.pro_updown').html('<?php echo $language->get('entry_hidden_pro'); ?>');
								            $('.pro_updown').removeClass('pro_button_show').addClass('pro_button_hidden');
								            $('.pro_up_down').addClass('pro_button_active');

								        }
								    });" style="float: right;" class="pro_up_down pro_button sc_button">


								    <div class="pro_updown pro_button_show"><?php echo $language->get('entry_show_pro'); ?></div>
								</a>
						</div>


						<div style="margin-top: 10px;">
							<div id="tab-list">

									<div id="mytabs" class="vtabs" style="padding-top: 0px;">
						  				<a href='#mytabs_default' id='#mytabs_id_default'><?php echo $language->get('entry_tab_settings_default'); ?></a>
						  				<a href='#mytabs_url' id='#mytabs_id_url'><?php echo $language->get('entry_tab_settings_url'); ?></a>
						  				<a href='#mytabs_force' id='#mytabs_id_url'><?php echo $language->get('entry_tab_settings_force'); ?></a>
						  				<a href='#mytabs_www' id='#mytabs_id_url'><?php echo $language->get('entry_tab_settings_www'); ?></a>
						  				<a href='#mytabs_path' id='#mytabs_id_url'><?php echo $language->get('entry_tab_settings_path'); ?></a>
						  				<a href='#mytabs_cache' id='#mytabs_id_cache'><?php echo $language->get('entry_tab_settings_cache'); ?></a>
						  				<a href='#mytabs_pagespeed' id='#mytabs_id_cache'><?php echo $language->get('entry_tab_settings_pagespeed'); ?></a>
									</div>

									<div id="mytabs_default">
									<div class="tabcontent" style="padding-left: 220px;" id="list_default">

										<table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">

                                                <!--
                                                <?php if (isset($text_redirect) && $text_redirect != '') { ?>
										          <tr>
										              <td style="width: 220px;"></td>
										              <td>
										              	<div class="input-group">
                                                        <?php echo $text_redirect; ?>
										                </div>
										                </td>
										          </tr>
                                                <?php } ?>
                                                 -->


										          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_httpsfix_module_status'); ?></td>
										              <td>
										              <div class="input-group">
										              <select class="form-control" name="settings_httpsfix[httpsfix_module_status]">
										                  <?php if (isset($settings_httpsfix['httpsfix_module_status']) && $settings_httpsfix['httpsfix_module_status']) { ?>
										                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										                  <option value="0"><?php echo $text_disabled; ?></option>
										                  <?php } else { ?>
										                  <option value="1"><?php echo $text_enabled; ?></option>
										                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										                  <?php } ?>
										                </select>
										                </div>
										                </td>
										            </tr>
										          <tr colspan="2">

										              <td colspan="2">

														<div style="margin-bottom: 5px;">
														    <a href="#" id="sc_install_common" onclick="
																$.ajax({
																	url: '<?php echo $url_create; ?>',
																	dataType: 'html',
																	beforeSend: function()
																	{
														               $('#create_tables').html('<?php echo $text_loading_main; ?>');
																	},
																	success: function(json) {
																		$('#create_tables').html(json);
																		setTimeout('delayer()', 2000);
																	},
																	error: function(json) {
																	$('#create_tables').html('error');
																	}
																}); return false;" class="markbuttono widthbutton sc_button" style="text-align: center;"><?php echo $url_create_text; ?></a>
														</div>
                                                        <div id="create_tables" style="color: green;"></div>

										              </td>
										            </tr>

<?php if (version_compare(VERSION, '1.5.7', '>')) { ?>

										          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_httpsfix_admin_menu_status'); ?></td>
										              <td>
										              <div class="input-group">
										              <select class="form-control" name="settings_httpsfix[httpsfix_admin_menu_status]">
										                  <?php if (isset($settings_httpsfix['httpsfix_admin_menu_status']) && $settings_httpsfix['httpsfix_admin_menu_status']) { ?>
										                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										                  <option value="0"><?php echo $text_disabled; ?></option>
										                  <?php } else { ?>
										                  <option value="1"><?php echo $text_enabled; ?></option>
										                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										                  <?php } ?>
										                </select>
										                </div>
										                </td>
										          </tr>

										          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_httpsfix_admin_replace_status'); ?></td>
										              <td>
										              <div class="input-group">
										              <select class="form-control" name="settings_httpsfix[httpsfix_admin_replace_status]">
										                  <?php if (isset($settings_httpsfix['httpsfix_admin_replace_status']) && $settings_httpsfix['httpsfix_admin_replace_status']) { ?>
										                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										                  <option value="0"><?php echo $text_disabled; ?></option>
										                  <?php } else { ?>
										                  <option value="1"><?php echo $text_enabled; ?></option>
										                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										                  <?php } ?>
										                </select>
										                </div>
										                </td>
										          </tr>

<?php } else { ?>
<style>
.content {
	/* font-family: "Roboto",sans-serif; */
	padding-left: 10px;
	padding-right: 10px;
}
</style>
<?php } ?>
										          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_httpsfix_version_check'); ?></td>
										              <td>
															<div style="margin-bottom: 5px;">
															    <a href="#" id="httpsfix_version_check" onclick="
																	$.ajax({
																		url: '<?php echo $url_version_check; ?>',
																		dataType: 'html',
																		beforeSend: function()
																		{
															               $('#div_version_check').html('<?php echo $language->get('text_loading_main'); ?>');
																		},
																		success: function(json) {
																			$('#div_version_check').html(json);
																			//setTimeout('delayer()', 2000);
																		},
																		error: function(json) {
																			$('#div_version_check').html('error');
																		}
																	}); return false;" class="markbuttono sc_button" style=""><?php echo $language->get('text_url_version_check'); ?></a>
															<div id="div_version_check"></div>
															</div>

										                </td>
										            </tr>


										   </table>

									</div>
									</div>


									<div id="mytabs_url">
									<div class="tabcontent" style="padding-left: 220px;" id="list_default">

										<table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">

										<tr>
											<td class="left">
												<?php echo $language->get('entry_add_url_types'); ?>
											</td>
												<td>
													<div style="float: left;">

									   <table id="add_url_types" class="list">
										   <thead>
									             <tr>
									                <td class="left"><?php echo $language->get('entry_add_url_type_id'); ?></td>
									                <td class="left"><?php echo $language->get('entry_add_url_url'); ?></td>
									                <td class="left"><?php echo $language->get('entry_add_url_url_replace'); ?></td>
									                <td class="left"><?php echo $language->get('entry_add_url_url_comment'); ?></td>
									                <td></td>
									             </tr>
									      </thead>

									      <?php if (isset($settings_httpsfix['add_url_type']) && !empty($settings_httpsfix['add_url_type'])) { ?>
									      <?php foreach ($settings_httpsfix['add_url_type'] as $add_url_type_id => $add_url_type) { ?>
									      <?php $add_url_type_row = $add_url_type_id; ?>
									      <tbody id="add_url_type_row<?php echo $add_url_type_row; ?>">
									          <tr>
									               <td class="left">
													<div class="input-group">
													<input type="text" class="form-control" name="settings_httpsfix[add_url_type][<?php echo $add_url_type_id; ?>][type_id]" value="<?php if (isset($add_url_type['type_id'])) echo $add_url_type['type_id']; ?>" style="width: 50px;">
									                </div>
									               </td>

									               <td class="left">
													<div class="input-group">
													<input type="text" class="form-control" name="settings_httpsfix[add_url_type][<?php echo $add_url_type_id; ?>][url]" value="<?php if (isset($add_url_type['url'])) echo $add_url_type['url']; ?>" style="width: 150px;">
									               </div>
									               </td>

									               <td class="left">
													<div class="input-group">
													<input type="text" class="form-control" name="settings_httpsfix[add_url_type][<?php echo $add_url_type_id; ?>][url_replace]" value="<?php if (isset($add_url_type['url_replace'])) echo $add_url_type['url_replace']; ?>" style="width: 150px;">
									               </div>
									               </td>

													<td class="right">
													 <?php foreach ($languages as $lang) { ?>
												<div class="input-group">
												<span class="input-group-addon"><?php echo strtoupper($lang['code']); ?>&nbsp;&nbsp;<img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" ></span>
															<input type="text" class="form-control" name="settings_httpsfix[add_url_type][<?php echo $add_url_type_id; ?>][title][<?php echo $lang['language_id']; ?>]" value="<?php if (isset($add_url_type['title'][$lang['language_id']])) echo $add_url_type['title'][$lang['language_id']]; ?>" style="width: 160px;">
					 							</div>


									                 <?php } ?>
													</td>

									                <td class="left"><a onclick="$('#add_url_type_row<?php echo $add_url_type_row; ?>').remove();" class="markbutton button_purple nohref  sc_button"><?php echo $button_remove; ?></a></td>
									              </tr>
									            </tbody>

									            <?php } ?>
									            <?php } ?>
									            <tfoot>
									              <tr>
					                                <td colspan="6" class="left" style="text-align: right;"><div style="text-align: center;"><a onclick="addadd_urlType();" class="markbutton nohref sc_button"><?php echo $language->get('entry_add_add_url_type'); ?></a></div></td>
									              </tr>
									            </tfoot>
									          </table>



					<script type="text/javascript">

					var array_add_url_type_row = Array();
					array_add_url_type_row.push(0);
					<?php
					 foreach ($settings_httpsfix['add_url_type'] as $indx => $add_url_type) {
					?>
					array_add_url_type_row.push(<?php echo $indx; ?>);
					<?php
					}
					?>

					var add_url_type_row = <?php echo $add_url_type_row + 1; ?>;

					function addadd_urlType() {

						var aindex = -1;
						for(i = 0; i < array_add_url_type_row.length; i++) {
						 flg = jQuery.inArray(i, array_add_url_type_row);
						 if (flg == -1) {
						 	aindex = i;
						 }
						}
						if (aindex == -1) {
							aindex = array_add_url_type_row.length;
						}
						add_url_type_row = aindex;
						array_add_url_type_row.push(aindex);

					    html  = '<tbody id="add_url_type_row' + add_url_type_row + '">';
						html += '  <tr>';

					    html += '  <td class="left">';
						html += ' 	<div class="input-group"><input type="text" class="form-control" name="settings_httpsfix[add_url_type]['+ add_url_type_row +'][type_id]" value="'+ add_url_type_row +'"></div>';
					    html += '  </td>';


					    html += '  <td class="left">';
						html += ' 	<div class="input-group"><input class="form-control" type="text" name="settings_httpsfix[add_url_type]['+ add_url_type_row +'][url]" value=""></div>';
					    html += '  </td>';

					    html += '  <td class="left">';
						html += ' 	<div class="input-group"><input type="text" class="form-control" name="settings_httpsfix[add_url_type]['+ add_url_type_row +'][url_replace]" value=""></div>';
					    html += '  </td>';


					 	html += '  <td class="right">';
					 	<?php foreach ($languages as $lang) { ?>

						html += '	<div class="input-group">';
						html += '	<span class="input-group-addon"><?php echo strtoupper($lang['code']); ?>&nbsp;&nbsp;<img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" ></span>';
						html += '		<input type="text" class="form-control" name="settings_httpsfix[add_url_type]['+ add_url_type_row +'][title][<?php echo $lang['language_id']; ?>]" value="">';
						html += '	</div>';


						<?php } ?>
					    html += '  </td>';
					    html += '  <td class="left"><a onclick="$(\'#add_url_type_row'+add_url_type_row+'\').remove(); array_add_url_type_row.remove(add_url_type_row);" class="markbutton button_purple nohref sc_button"><?php echo $button_remove; ?></a></td>';




						html += '  </tr>';
						html += '</tbody>';

						$('#add_url_types tfoot').before(html);

						add_url_type_row++;
					}
					</script>




													</div>
												</td>
										</tr>





										   </table>

									</div>
									</div>
									<div id="mytabs_path">
										<div class="tabcontent" style="padding-left: 220px;" id="list_default">

											<table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">

											          <tr>
											              <td style="width: 220px;"><?php echo $language->get('entry_httpsfix_path_status'); ?></td>
											              <td>
											              <div class="input-group">
											              <select class="form-control" name="settings_httpsfix[httpsfix_path_status]">
											                  <?php if (isset($settings_httpsfix['httpsfix_path_status']) && $settings_httpsfix['httpsfix_path_status']) { ?>
											                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
											                  <option value="0"><?php echo $text_disabled; ?></option>
											                  <?php } else { ?>
											                  <option value="1"><?php echo $text_enabled; ?></option>
											                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
											                  <?php } ?>
											                </select>
											                </div>
											                </td>
											            </tr>


											   </table>

										</div>
									</div>

									<div id="mytabs_force">
										<div class="tabcontent" style="padding-left: 220px;" id="list_default">
											<table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">
											          <tr>
											              <td style="width: 220px;"><?php echo $language->get('entry_httpsfix_force'); ?></td>
											              <td>
											              <div class="input-group">
												              <select class="form-control" name="settings_httpsfix[httpsfix_force]">
																<?php foreach ($url_force as $value => $name) { ?>
													              	<option value="<?php echo $value; ?>" <?php if (isset($settings_httpsfix['httpsfix_force']) && $settings_httpsfix['httpsfix_force'] == $value) { ?> selected="selected" <?php } ?>><?php echo $name; ?></option>
													            <?php } ?>
					  							                </select>
											                </div>
											                </td>
											            </tr>
											   </table>
										</div>
									</div>



									<div id="mytabs_cache">
									<div class="tabcontent" style="padding-left: 220px;" id="list_default">

										<table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">
					  					          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_httpsfix_ocmod_refresh'); ?></td>
										              <td>
															<div style="margin-bottom: 5px;">
															    <a href="#" id="httpsfix_ocmod_refresh" onclick="
																	$.ajax({
																		url: '<?php echo $url_ocmod_refresh; ?>',
																		dataType: 'html',
																		beforeSend: function()
																		{
															               $('#div_ocmod_refresh').html('<?php echo $language->get('text_loading_main'); ?>');
																		},
																		success: function(content) {
																			if (content) {
																				$('#div_ocmod_refresh').html('<span style=\'color:green\'><?php echo $language->get('text_ocmod_refresh_success'); ?><\/span>');
																				//setTimeout('delayer()', 2000);
																			}
																		},
																		error: function(content) {
																			$('#div_ocmod_refresh').html('<span style=\'color:red\'><?php echo $language->get('text_ocmod_refresh_fail'); ?><\/span>');
																		}
																	}); return false;" class="markbuttono sc_button" style=""><?php echo $language->get('text_url_ocmod_refresh'); ?></a>
															<div id="div_ocmod_refresh"></div>
															</div>
										                </td>
										            </tr>

					  					          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_httpsfix_cache_remove'); ?></td>
										              <td>
															<div style="margin-bottom: 5px;">
															    <a href="#" id="httpsfix_cache_remove" onclick="
																	$.ajax({
																		url: '<?php echo $url_cache_remove; ?>',
																		dataType: 'html',
																		beforeSend: function()
																		{
															               $('#div_cache_remove').html('<?php echo $language->get('text_loading_main'); ?>');
																		},
																		success: function(content) {
																			if (content) {
																				$('#div_cache_remove').html('<span style=\'color:green\'>'+content+'<\/span>');
																				//setTimeout('delayer()', 2000);
																			}
																		},
																		error: function(content) {
																			$('#div_cache_remove').html('<span style=\'color:red\'><?php echo $language->get('text_cache_remove_fail'); ?><\/span>');
																		}
																	}); return false;" class="markbuttono sc_button" style=""><?php echo $language->get('text_url_cache_remove'); ?></a>
															<div id="div_cache_remove"></div>
															</div>
										                </td>
										            </tr>

					  					          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_httpsfix_cache_image_remove'); ?></td>
										              <td>
															<div style="margin-bottom: 5px;">
															    <a href="#" id="httpsfix_cache_image_remove" onclick="
																	$.ajax({
																		url: '<?php echo $url_cache_image_remove; ?>',
																		dataType: 'html',
																		beforeSend: function()
																		{
															               $('#div_cache_image_remove').html('<?php echo $language->get('text_loading_main'); ?>');
																		},
																		success: function(content) {
																			if (content) {
																				$('#div_cache_image_remove').html('<span style=\'color:green\'>'+content+'<\/span>');
																				//setTimeout('delayer()', 2000);
																			}
																		},
																		error: function(content) {
																			$('#div_cache_image_remove').html('<span style=\'color:red\'><?php echo $language->get('text_cache_remove_fail'); ?><\/span>');
																		}
																	}); return false;" class="markbuttono sc_button" style=""><?php echo $language->get('text_url_cache_image_remove'); ?></a>
															<div id="div_cache_image_remove"></div>
															</div>
										                </td>
										            </tr>

										   </table>

									</div>
									</div>



									<div id="mytabs_www">
										<div class="tabcontent" style="padding-left: 220px;" id="list_default">
											<table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">
												<tr>
											        	<td style="width: 220px;"><?php echo $language->get('entry_httpsfix_www'); ?></td>
											            <td>
											            <div class="input-group">
												        	<select class="form-control" name="settings_httpsfix[httpsfix_www]">
																<?php foreach ($url_www as $value => $name) { ?>
													              	<option value="<?php echo $value; ?>" <?php if (isset($settings_httpsfix['httpsfix_www']) && $settings_httpsfix['httpsfix_www'] == $value) { ?> selected="selected" <?php } ?>><?php echo $name; ?></option>
													           	<?php } ?>
					  							           	</select>
											            </div>
											    	</td>
												</tr>
											</table>
										</div>
									</div>




									<div id="mytabs_pagespeed">
										<div class="tabcontent" style="padding-left: 220px;" id="list_default">
											<table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">

										          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_pagespeed_lic'); ?></td>
										              <td>
                                                       <?php echo $language->get('text_pagespeed_lic'); ?>
										              </td>
										            </tr>


										          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_pagespeed_js'); ?></td>
										              <td>
										              <div class="input-group">
										              <select class="form-control" name="settings_httpsfix[httpsfix_pagespeed_js]">
										                  <?php if (isset($settings_httpsfix['httpsfix_pagespeed_js']) && $settings_httpsfix['httpsfix_pagespeed_js']) { ?>
										                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										                  <option value="0"><?php echo $text_disabled; ?></option>
										                  <?php } else { ?>
										                  <option value="1"><?php echo $text_enabled; ?></option>
										                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										                  <?php } ?>
										                </select>
										                </div>
										                </td>
										            </tr>

										          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_pagespeed_css'); ?></td>
										              <td>
										              <div class="input-group">
										              <select class="form-control" name="settings_httpsfix[httpsfix_pagespeed_css]">
										                  <?php if (isset($settings_httpsfix['httpsfix_pagespeed_css']) && $settings_httpsfix['httpsfix_pagespeed_css']) { ?>
										                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										                  <option value="0"><?php echo $text_disabled; ?></option>
										                  <?php } else { ?>
										                  <option value="1"><?php echo $text_enabled; ?></option>
										                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										                  <?php } ?>
										                </select>
										                </div>
										                </td>
										            </tr>

										          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_pagespeed_css_first'); ?></td>
										              <td>
										              <div class="input-group">
										              <select class="form-control" name="settings_httpsfix[httpsfix_pagespeed_css_first]">
										                  <?php if (isset($settings_httpsfix['httpsfix_pagespeed_css_first']) && $settings_httpsfix['httpsfix_pagespeed_css_first']) { ?>
										                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										                  <option value="0"><?php echo $text_disabled; ?></option>
										                  <?php } else { ?>
										                  <option value="1"><?php echo $text_enabled; ?></option>
										                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										                  <?php } ?>
										                </select>
										                </div>
										                </td>
										            </tr>


										          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_pagespeed_mini'); ?></td>
										              <td>
										              <div class="input-group">
										              <select class="form-control" name="settings_httpsfix[httpsfix_pagespeed_mini]">
										                  <?php if (isset($settings_httpsfix['httpsfix_pagespeed_mini']) && $settings_httpsfix['httpsfix_pagespeed_mini']) { ?>
										                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										                  <option value="0"><?php echo $text_disabled; ?></option>
										                  <?php } else { ?>
										                  <option value="1"><?php echo $text_enabled; ?></option>
										                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										                  <?php } ?>
										                </select>
										                </div>
										                </td>
										            </tr>

										<tr>
											<td class="left">
												<?php echo $language->get('entry_ps_ex_js'); ?>
											</td>
												<td>
													<div style="float: left; width: 100%;">
														<div class="input-group">
															<span class="input-group-addon">
																<textarea name="settings_httpsfix[ps_ex_js]" style="width: 100%;  min-height: 160px;"><?php if (isset($settings_httpsfix['ps_ex_js'])) echo $settings_httpsfix['ps_ex_js']; ?></textarea>
															</span>
							 							</div>

													</div>
											</td>
										</tr>
										<tr>
											<td class="left">
												<?php echo $language->get('entry_ps_ex_css'); ?>
											</td>
												<td>
													<div style="float: left; width: 100%;">
														<div class="input-group">
															<span class="input-group-addon">
																<textarea name="settings_httpsfix[ps_ex_css]" style="width: 100%;  min-height: 160px;"><?php if (isset($settings_httpsfix['ps_ex_css'])) echo $settings_httpsfix['ps_ex_css']; ?></textarea>
															</span>
							 							</div>

													</div>
											</td>
										</tr>
										<tr>
											<td class="left">
												<?php echo $language->get('entry_ps_ex_route'); ?>
											</td>
												<td>
													<div style="float: left; width: 100%;">
														<div class="input-group">
															<span class="input-group-addon">
																<textarea name="settings_httpsfix[ps_ex_route]" style="width: 100%;  min-height: 160px;"><?php if (isset($settings_httpsfix['ps_ex_route'])) echo $settings_httpsfix['ps_ex_route']; ?></textarea>
															</span>
							 							</div>

													</div>
											</td>
										</tr>



											</table>
										</div>
									</div>




								</div>
								<script>
									$('#mytabs a').tabs();
								</script>
							</div>

					</div>


					<div id="tab-doc">


<div style="text-align: center; text-decoration: none; margin-bottom: 5px;">
	<a href="https://opencartadmin.com/doc/index.<?php echo substr(strtolower($config->get('config_admin_language')), 0,2); ?>.seohttpsfixpro.html" target="_blank" class="markbuttono widthbutton sc_button asc_blinking" style=""><?php echo $language->get('entry_docs'); ?></a>
</div>




						<?php echo $language->get('entry_settings_delete'); ?>


						<div id="delete_button_main" style="margin-top: 20px;">
						    <a href="#" onclick="$('#delete_button').toggle('slow'); $('#delete_button_main').hide('slow'); return false;" class="markbuttono  sc_button" style=""><?php echo $language->get('text_settings_delete_show'); ?></a>
						</div>


						<div id="delete_button" style="margin-top: 20px; display: none;">
							<div style="margin-top: 20px;">
							    <a href="#" onclick="
									$.ajax({
										url: '<?php echo $url_delete_settings; ?>',
										dataType: 'html',
										beforeSend: function()
										{
							               $('#id_delete_settings').html('<?php echo $language->get('text_loading_main'); ?>');
										},
										success: function(json) {
											$('#id_delete_settings').html(json);
										},
										error: function(json) {
										$('#id_delete_settings').html('error');
										}
									}); return false;" class="mbutton button_purple  sc_button" style=""><?php echo $language->get('text_url_delete_settings'); ?></a>
							</div>
						<div id="id_delete_settings"></div>


						<div id="delete_button_bottom" style="margin-top: 20px;">
						    <a href="#" onclick="$('#delete_button').toggle('slow'); $('#delete_button_main').show('slow'); return false;" class="markbuttono  sc_button" style=""><?php echo $language->get('text_settings_delete_hide'); ?></a>
						</div>


						</div>

					</div>

		         </form>
			 </div>



		<script type="text/javascript">
			 form_submit = function() {
				$('#form').submit();
				return false;
			}
			$('.httpsfix_save').bind('click', form_submit);
		</script>

		<script type="text/javascript">
			$('#tabs a').tabs();
		</script>





	</div>


<?php
if ($text_currnent_version != $text_server_version) {
?>
<script>
$('#heading_version').addClass('hf_red');
</script>
<?php
}
?>

<script type="text/javascript">

function odd_even() {	var kz = 0;
	$('table tr').each(function(i,elem) {
	$(this).removeClass('odd');
	$(this).removeClass('even');
		if ($(this).is(':visible')) {
			kz++;
			if (kz % 2 == 0) {
				$(this).addClass('odd');
			}
		}
	});
}

$(document).ready(function(){
	odd_even();

	$('.htabs a').click(function() {
		odd_even();
	});

	$('.vtabs a').click(function() {
		odd_even();
	});
});

function select_this(ithis) {

if (!$(ithis).hasClass('no_change')) {
	        $(ithis).removeClass('sc_select_enable');
	        $(ithis).removeClass('sc_select_disable');

			this_val = $(ithis).find('option:selected').val()

			if (this_val == '1' ) {
				$(ithis).addClass('sc_select_enable');
			}

			if (this_val == '0' || this_val == '' ) {
				$(ithis).addClass('sc_select_disable');
			}

			if (this_val != '0' && this_val != '1' && this_val != '') {
				$(ithis).addClass('sc_select_other');
			}
		}
}

function input_this(ithis) {

		if (!$(ithis).hasClass('no_change')) {
	        $(ithis).removeClass('sc_select_enable');
	        $(ithis).removeClass('sc_select_disable');

			if ( $(ithis).val() != '' ) {
				$(ithis).addClass('sc_select_enable');
			} else {
				$(ithis).addClass('sc_select_disable');
			}
		}
}

function input_select_change() {
	$('input').each(function(){
		input_this(this);
	});

	$('select').each(function(){
		select_this(this);
	});
}

$(document).ready(function(){

$(document).on('change', 'select', function(event) {
		select_this(this);
	  });

$(document).on('blur', 'input', function(event) {
		input_this(this)
	  });
input_select_change();
});

</script>

</div>
<?php echo $footer; ?>
