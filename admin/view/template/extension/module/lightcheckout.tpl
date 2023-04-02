<?php if (!$id) { ?>
<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button onClick="lightrequestpost(); return false;" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
	<?php if (isset($debugging)) { ?><div class="alert alert-warning alert-dismissible"><i class="fa fa-check-circle"></i> <?php echo $debugging; ?><button data-dismiss="alert" class="close" type="button">×</button></div><?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-module" class="form-horizontal">
		  <ul class="nav nav-tabs">
            <li><a href="#tab-settings" data-toggle="tab"><i class="fa fa-cogs" aria-hidden="true"></i> <?php echo $text_settings; ?></a></li>
			<li class="active"><a href="#tab-structure" data-toggle="tab"><i class="fa fa-sliders" aria-hidden="true"></i> <?php echo $text_structure; ?></a></li>
			<li><a href="#tab-html" data-toggle="tab"><i class="fa fa-code" aria-hidden="true"></i> <?php echo $text_html; ?></a></li>
			<li><a href="#tab-localisation" data-toggle="tab"><i class="fa fa-map-marker" aria-hidden="true"></i> <?php echo $text_localisation; ?></a></li>
			<li><a href="#tab-seo-url" data-toggle="tab"><i class="fa fa-tags" aria-hidden="true"></i> <?php echo $text_seo_url; ?></a></li>
			<li><a href="#tab-restrictions" data-toggle="tab"><i class="fa fa-glass" aria-hidden="true"></i> <?php echo $text_restrictions; ?></a></li>
			<li><a href="#tab-template" data-toggle="tab"><i class="fa fa-puzzle-piece" aria-hidden="true"></i> <?php echo $text_template; ?></a></li>
			<li><a href="#tab-payment" data-toggle="tab"><i class="fa fa-credit-card" aria-hidden="true"></i> <?php echo $text_payment; ?></a></li>
		  </ul>
		  <div class="tab-content">
            <div class="tab-pane" id="tab-settings">
			  <div class="col-sm-12">
				<div class="row">
				  <div class="col-sm-5 text-center">
					<div class="alert alert-info margin-auto"><i class="fa fa-info" aria-hidden="true"></i> <?php echo $text_info_system; ?></div>
				  </div>
				  <div class="col-sm-7 text-center">
					<div class="alert alert-info margin-auto"><i class="fa fa-info" aria-hidden="true"></i> <?php echo $text_info_more; ?></div>
				  </div>
				</div>
			  <div class="form-group">
				<div class="col-sm-5">
				  <label class="col-sm-6 control-label" for="input-status"><?php echo $entry_status; ?> <span data-toggle="tooltip" title="<?php echo $entry_help_status; ?>"></span></label>
				  <div class="col-sm-6 text-left">
				    <div class="lightOnOff settings">  
					  <input type="checkbox" value="1" id="lightcheckout_status" name="lightcheckout_status"<?php if ($lightcheckout_status) { ?> checked=""<?php } ?> data-name="lightcheckout_status">
					  <label for="lightcheckout_status"></label>
					  <input type="hidden" name="lightcheckout_code" value="<?php if ($lightcheckout_code) { ?><?php echo $lightcheckout_code; ?><?php } ?>" />
					</div>
				  </div>
				</div>
				<div class="col-sm-7">
				  <label class="col-sm-6 control-label" for="input-status"><?php echo $entry_qty; ?> <span data-toggle="tooltip" title="<?php echo $entry_help_qty; ?>"></span></label>
				  <div class="col-sm-6 text-left">
				    <div class="lightOnOff settings">  
					  <input type="checkbox" value="1" id="qty" name="lightsettings[qty]"<?php if ($qty) { ?> checked=""<?php } ?> data-name="qty">
					  <label for="qty"></label>
					</div>
				  </div>
				</div>
			  </div>
			  <div class="form-group">
				<div class="col-sm-5">
				  <label class="col-sm-6 control-label" for="input-status"><?php echo $entry_debugging; ?> <span data-toggle="tooltip" title="<?php echo $entry_help_debugging; ?>"></span><br /><a target="_blank" href="<?php echo $tech_address; ?>" alt="" title=""><?php echo $entry_help_debugging_domen; ?></a></label>
				  <div class="col-sm-6 text-left">
				    <div class="lightOnOff settings">  
					  <input type="checkbox" value="1" id="lightcheckout_debugging" name="lightcheckout_debugging"<?php if ($lightcheckout_debugging) { ?> checked=""<?php } ?> data-name="lightcheckout_debugging">
					  <label for="lightcheckout_debugging"></label>
					</div>
				  </div>
				</div>
				<div class="col-sm-7">
				  <label class="col-sm-6 control-label" for="input-status"><?php echo $entry_light; ?> <span data-toggle="tooltip" title="<?php echo $entry_help_light; ?>"></span></label>
				  <div class="col-sm-6 text-left">
				    <div class="lightOnOff settings">  
					  <input type="checkbox" value="1" id="light" name="lightsettings[light]"<?php if ($light) { ?> checked=""<?php } ?> data-name="light">
					  <label for="light"></label>
					</div>
				  </div>
				</div>
			  </div>
			  <div class="form-group">
				<div class="col-sm-5">
				  <label class="col-sm-6 control-label" for="input-status"><?php echo $entry_skip_cart; ?> <span data-toggle="tooltip" title="<?php echo $entry_help_skip_cart; ?>"></span></label>
				  <div class="col-sm-6 text-left">
				    <div class="lightOnOff settings">  
					  <input type="checkbox" value="1" id="lightcheckout_skipcart" name="lightcheckout_skipcart"<?php if ($lightcheckout_skipcart) { ?> checked=""<?php } ?> data-name="lightcheckout_skipcart">
					  <label for="lightcheckout_skipcart"></label>
					</div>
				  </div>
				</div>
				<div class="col-sm-7">
				  <label class="col-sm-6 control-label" for="input-status"><?php echo $entry_error; ?> <span data-toggle="tooltip" title="<?php echo $entry_help_error; ?>"></span></label>
				  <div class="col-sm-6 text-left">
				    <div class="lightOnOff settings">  
					  <input type="checkbox" value="1" id="error" name="lightsettings[error]"<?php if ($error) { ?> checked=""<?php } ?> data-name="error">
					  <label for="error"></label>
					</div>
				  </div>
				</div>
			  </div>
			  </div>
			</div>
			<div class="tab-pane lightmodule active" id="tab-structure">
			  <div class="row">
			    <div class="col-lg-2 col-sm-3 col-xs-12">
				  <div class="input-group lighthelp">
				    <span class="input-group-addon">
					  <i class="fa fa-info " aria-hidden="true"></i>
				    </span>
				    <label class="form-control control-label">
					  <span data-toggle="tooltip" title="" data-original-title="<?php echo $text_structure_toggle_help; ?>"><?php echo $text_structure_help; ?></span>
				    </label>
				  </div><br />
				  <div class="input-group lighthelp">
				    <span class="input-group-addon">
					  <i class="fa fa-info " aria-hidden="true"></i>
				    </span>
				    <label class="form-control control-label">
					  <span data-toggle="tooltip" title="" data-original-title="<?php echo $text_width_toggle_help; ?>"><?php echo $text_width_help; ?></span>
				    </label>
				  </div>
			    </div>
			    <div class="col-lg-10 col-sm-9 col-xs-12">
				  <div class="row">
				    <div class="light-design">
					  <input name="light_checkout[column][1]" id="light-left-design" data-slider-id='light-design' type="text" data-slider-min="0" data-slider-max="12" data-slider-step="1" data-slider-value="<?php echo $columns[1]; ?>"/>
				    </div>	  
				    <div class="col-sm-4">
					  <div id="light-left" class="table-bordered padding numeration-bg">
					    <ol class="light-left list-unstyled" data-group-id="1">
						  <?php if ($results and isset($results[1])) { ?>
						    <?php foreach ($results[1] as $name => $result) { ?>
							  <li id="light-<?php echo $name; ?>" class="cursor-move margin-bottom">
							    <div class="text-center">
								  <div class="input-group-addon"><i class="fa <?php echo $result['icon']; ?>"></i> <strong><?php echo $result['text']; ?></strong>
								    <?php if ($name != 'cart' and $name != 'confirm') { ?><div class="lightOnOff">  
								      <input type="checkbox" value="1" id="lightOnOff_<?php echo $name; ?>" name="light_checkout[status][<?php echo $name; ?>]"<?php if ($result['status']) { ?> checked=""<?php } ?> data-name="light-<?php echo $name; ?>">
								      <label for="lightOnOff_<?php echo $name; ?>"></label>
								    </div><?php } ?>
								  </div>
								  <span class="clearfix"></span>
								  <b class="input-group">
									  <label class="form-control">
									    <br /><span><?php echo $result['text_help']; ?></span><br /><br />
									  </label>
									  <span class="input-group-addon"><i class="fa fa-edit" data-toggle="tooltip" title="<?php echo $text_help_setting_element; ?>" onClick="CheckedFields('<?php echo $result['name']; ?>');"></i></span>
								  </b>
								  <input type="hidden" name="light_checkout[sort][1][<?php echo $name; ?>]" value="<?php echo $result['sort']; ?>" data-name="<?php echo $name; ?>" />
							    </div>
							  </li>
						    <?php } ?>
						  <?php } ?>
					    </ol>
					  </div>
				    </div>
				    <div class="col-sm-8">
					  <div class="light-design-right">
					    <input name="light_checkout[column][3]" id="light-right-design" data-slider-id='light-design-right' type="text" data-slider-min="0" data-slider-max="12" data-slider-step="1" data-slider-value="<?php echo $columns[3]; ?>"/>
					  </div>
				      <div id="light-right">
					    <div class="row">
						  <div class="col-sm-6 margin-bottom numeration-bg" id="light-right-1">
						    <ol class="light-left padding table-bordered list-unstyled" data-group-id="2">
							  <?php if ($results and isset($results[2])) { ?>
							    <?php foreach ($results[2] as $name => $result) { ?>
								  <li id="light-<?php echo $name; ?>" class="cursor-move margin-bottom">
								    <div class="text-center">
									  <div class="input-group-addon"><i class="fa <?php echo $result['icon']; ?>"></i> <strong><?php echo $result['text']; ?></strong>
									  <?php if ($name != 'cart' and $name != 'confirm') { ?><div class="lightOnOff">  
									    <input type="checkbox" value="1" id="lightOnOff_<?php echo $name; ?>" name="light_checkout[status][<?php echo $name; ?>]"<?php if ($result['status']) { ?> checked=""<?php } ?> data-name="light-<?php echo $name; ?>">
									    <label for="lightOnOff_<?php echo $name; ?>"></label>
									  </div><?php } ?>
									  </div>									
									  <span class="clearfix"></span>
									  <b class="input-group">
										<label class="form-control">
										  <br /><span><?php echo $result['text_help']; ?></span><br /><br />
										</label>
										<span class="input-group-addon"><i class="fa fa-edit" data-toggle="tooltip" title="<?php echo $text_help_setting_element; ?>" onClick="CheckedFields('<?php echo $result['name']; ?>');"></i></span>
									  </b>
									  <input type="hidden" name="light_checkout[sort][2][<?php echo $name; ?>]" value="<?php echo $result['sort']; ?>" data-name="<?php echo $name; ?>" />
								    </div>
								  </li>
							    <?php } ?>
							  <?php } ?>
						    </ol>
						  </div>
						  <div class="col-sm-6 margin-bottom numeration-bg" id="light-right-2">
						    <ol class="light-left padding table-bordered list-unstyled" data-group-id="3">
							  <?php if ($results and isset($results[3])) { ?>
							    <?php foreach ($results[3] as $name => $result) { ?>
								  <li id="light-<?php echo $name; ?>" class="cursor-move margin-bottom">
								    <div class="text-center">
									  <div class="input-group-addon"><i class="fa <?php echo $result['icon']; ?>"></i> <strong><?php echo $result['text']; ?></strong>
									  <?php if ($name != 'cart' and $name != 'confirm') { ?><div class="lightOnOff">  
									  <input type="checkbox" value="1" id="lightOnOff_<?php echo $name; ?>" name="light_checkout[status][<?php echo $name; ?>]"<?php if ($result['status']) { ?> checked=""<?php } ?> data-name="light-<?php echo $name; ?>">
									    <label for="lightOnOff_<?php echo $name; ?>"></label>
									    </div><?php } ?>
									  </div>									
									  <span class="clearfix"></span>
									  <b class="input-group">
										<label class="form-control">
										  <br /><span><?php echo $result['text_help']; ?></span><br /><br />
										</label>
										<span class="input-group-addon"><i class="fa fa-edit" data-toggle="tooltip" title="<?php echo $text_help_setting_element; ?>" onClick="CheckedFields('<?php echo $result['name']; ?>');"></i></span>
									  </b>
									  <input type="hidden" name="light_checkout[sort][3][<?php echo $name; ?>]" value="<?php echo $result['sort']; ?>" data-name="<?php echo $name; ?>" />
								    </div>
								  </li>
							    <?php } ?>
							  <?php } ?>
						    </ol>
						  </div>
						  <div class="col-sm-12">	
							<div class="col-sm-12 margin-bottom table-bordered padding numeration-bg" id="light-right-3">
							  <ol class="light-left list-unstyled" data-group-id="4">
								<?php if ($results and isset($results[4])) { ?>
								  <?php foreach ($results[4] as $name => $result) { ?>
									<li id="light-<?php echo $name; ?>" class="cursor-move margin-bottom">
									  <div class="text-center">
										<div class="input-group-addon"><i class="fa <?php echo $result['icon']; ?>"></i> <strong><?php echo $result['text']; ?></strong>
										<?php if ($name != 'cart' and $name != 'confirm') { ?><div class="lightOnOff">  
										  <input type="checkbox" value="1" id="lightOnOff_<?php echo $name; ?>" name="light_checkout[status][<?php echo $name; ?>]"<?php if ($result['status']) { ?> checked=""<?php } ?> data-name="light-<?php echo $name; ?>">
										  <label for="lightOnOff_<?php echo $name; ?>"></label>
										</div><?php } ?>
										</div>										
										<span class="clearfix"></span>
										<b class="input-group">
											<label class="form-control">
											  <br /><span><?php echo $result['text_help']; ?></span><br /><br />
											</label>
											<span class="input-group-addon"><i class="fa fa-edit" data-toggle="tooltip" title="<?php echo $text_help_setting_element; ?>" onClick="CheckedFields('<?php echo $result['name']; ?>');"></i></span>
										</b>
										<input type="hidden" name="light_checkout[sort][4][<?php echo $name; ?>]" value="<?php echo $result['sort']; ?>" data-name="<?php echo $name; ?>" />
									  </div>									</li>
								  <?php } ?>
								<?php } ?>
							  </ol>
							</div>
						  </div>
					    </div>
				      </div>
				    </div>
				  </div>
			    </div>
			  </div>
			</div>
			<div class="tab-pane" id="tab-html">
			  <div class="form-group">
				<label class="col-sm-3 control-label" for="input-status"><?php echo $entry_html_top; ?> <span data-toggle="tooltip" title="<?php echo $entry_help_html_top; ?>"></span></label>
				<div class="col-sm-9 text-left">
				  <ul class="nav nav-tabs" id="languagetop">
					<?php foreach ($languages as $language) { ?>
					<li><a href="#languagetop<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
					<?php } ?>
				  </ul>
				  <div class="tab-content">
					<?php foreach ($languages as $language) { ?>
					  <div class="tab-pane" id="languagetop<?php echo $language['language_id']; ?>">
					    <textarea value="1" id="masterhtml[top]" name="masterhtml[top][<?php echo $language['language_id']; ?>]" class="form-control summernote"><?php if (isset($htmls['top'][$language['language_id']])) { ?><?php echo $htmls['top'][$language['language_id']]; ?><?php } ?></textarea>
					  </div>
					<?php } ?>
				  </div>
				</div>				  
			  </div>
			  <div class="form-group">
				<label class="col-sm-3 control-label" for="input-status"><?php echo $entry_html_bottom; ?> <span data-toggle="tooltip" title="<?php echo $entry_help_html_bottom; ?>"></span></label>
				<div class="col-sm-9 text-left">
				  <ul class="nav nav-tabs" id="languagebottom">
					<?php foreach ($languages as $language) { ?>
					<li><a href="#languagebottom<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
					<?php } ?>
				  </ul>
				  <div class="tab-content">
					<?php foreach ($languages as $language) { ?>
					  <div class="tab-pane" id="languagebottom<?php echo $language['language_id']; ?>">
					    <textarea value="1" id="masterhtml[bottom]" name="masterhtml[bottom][<?php echo $language['language_id']; ?>]" class="form-control summernote"><?php if (isset($htmls['bottom'][$language['language_id']])) { ?><?php echo $htmls['bottom'][$language['language_id']]; ?><?php } ?></textarea>
					  </div>
					<?php } ?>
				  </div>
				</div>
			  </div>
			</div>
			<div class="tab-pane" id="tab-localisation">
			  <div class="alert alert-info"><i class="fa fa-info" aria-hidden="true"></i> <?php echo $text_help_localization; ?></div>
			  <div class="form-group">
				<label class="col-sm-2 control-label" for="input-country"><?php echo $entry_default_country_id; ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $entry_help_localization; ?>"></span></label>
				<div class="col-sm-10">
				  <select name="lightsettings[country_id]" id="input-country" class="form-control">
					<option value=""><?php echo $text_select; ?></option>
					<?php foreach ($countries as $country) { ?>
					  <?php if ($country['country_id'] == $country_id) { ?>
					  <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
					  <?php } else { ?>
					  <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
					  <?php } ?>
					<?php } ?>
				  </select>
				</div>
			  </div>
			  <div class="form-group">
				<label class="col-sm-2 control-label" for="input-zone"><?php echo $entry_default_zone_id; ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $entry_help_localization; ?>"></span></label>
				<div class="col-sm-10">
				  <select name="lightsettings[zone_id]" id="input-zone" class="form-control">
					<option value=""><?php echo $text_select; ?></option>
					<?php if ($zones) { ?>
				      <option value="0" selected="selected"><?php echo $text_none; ?></option>
				      <?php foreach ($zones as $zone) { ?>
					    <option value="<?php echo $zone['zone_id']; ?>"<?php if ($zone['zone_id'] == $zone_id) { ?> selected="selected"<?php } ?>><?php echo $zone['name']; ?></option>
				      <?php } ?>
				    <?php } ?>
				  </select>
				</div>
			  </div>
			</div>
			<div class="tab-pane" id="tab-seo-url">
			  <div class="col-sm-12">
			  <div class="form-group">
				  <div class="alert alert-info"><i class="fa fa-info" aria-hidden="true"></i> <?php echo $text_help_seo_url_on_2; ?></div>
				  <div class="form-group">
						<label class="col-sm-3 control-label" for="input-zone"><?php echo $entry_seo_url; ?></label>
						<div class="col-sm-9">
							<span class="input-group" id="keyword-language">
							  <input type="text" name="lightseo[keyword]" value="<?php if (isset($lightseo['name'])) { ?><?php echo $lightseo['name']; ?><?php } else { ?>checkout<?php } ?>" placeholder="checkout" class="form-control" />
							</span>
						  <br />
						</div>
				    </div>
				</div>
			  </div>
			</div>
			<div class="tab-pane" id="tab-restrictions">
			  <div class="alert alert-info"><i class="fa fa-info" aria-hidden="true"></i> <?php echo $text_alert_restrictions; ?></div>
			  <div class="col-sm-12">
				<div class="form-group">
				  <div class="table-responsive" id="tab-restriction">
					<table class="table table-striped table-bordered table-hover">
					  <thead>
						<tr>
						  <td class="text-left"><?php echo $entry_restriction; ?></td>
						  <td class="text-left"><?php echo $entry_group_customer; ?></td>
						  <td class="text-left"><?php echo $entry_restriction_value; ?></td>
						  <td class="text-left"></td>
						</tr>
					  </thead>
					  <tbody>
					  <?php $restriction_row = 0; ?>
					  <?php foreach ($settings_restrictions as $settings_restriction) { ?>
					  <tr id="restriction-row<?php echo $restriction_row; ?>">
						<td class="text-left">
						  <select name="lightrestrictions[<?php echo $restriction_row; ?>][type]" class="form-control">
						    <?php foreach ($restrictions as $restriction) { ?>
							  <?php if ($settings_restriction['type'] == $restriction['type']) { ?>
							    <option value="<?php echo $restriction['type']; ?>" selected="selected"><?php echo $restriction['name_type']; ?></option>
							  <?php } else { ?>
							    <option value="<?php echo $restriction['type']; ?>"><?php echo $restriction['name_type']; ?></option>
							  <?php } ?>
						    <?php } ?>
						  </select>
						</td>
						<td class="text-left">
						  <select name="lightrestrictions[<?php echo $restriction_row; ?>][customer_group_id]" class="form-control">
						    <?php foreach ($customer_groups as $customer_group) { ?>
							  <?php if ($customer_group['customer_group_id'] == $settings_restriction['customer_group_id']) { ?>
								<option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
							  <?php } else { ?>
								<option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
							  <?php } ?>
						    <?php } ?>
						  </select>
						</td>
						<td class="text-left" id="lightrestrictions-value-row<?php echo $restriction_row; ?>">
						  <input type="text" class="form-control" name="lightrestrictions[<?php echo $restriction_row; ?>][value]" value="<?php echo $settings_restriction['value']; ?>"  />
						</td>
						<td class="text-left"><button type="button" onclick="$('#restriction-row<?php echo $restriction_row; ?>').remove()" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
					  </tr>
					  <?php $restriction_row = $restriction_row + 1; ?>
					  <?php } ?>
					  </tbody>
					  <tfoot>
						<tr>
						  <td colspan="3"></td>
						  <td class="text-left"><button type="button" onclick="addRestriction();" data-toggle="tooltip" title="<?php echo $button_recurring_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
						</tr>
					  </tfoot>
					</table>
				  </div>
				</div>
			  </div>
			</div>
			<div class="tab-pane" id="tab-template">
			  <div class="alert alert-info">1. <?php echo $text_alert_cart_template_start; ?></div>
			  <div class="form-group">
				<div class="col-sm-4">
				  <label class="col-sm-6 control-label" for="input-status"><?php echo $entry_bootstrap; ?> <span data-toggle="tooltip" title="<?php echo $entry_help_bootstrap; ?>"></span><br /><br /><br /></label>
				  <div class="col-sm-6 text-left">
				    <div class="lightOnOff settings">  
					  <input type="checkbox" value="1" id="bootstrap" name="lightsettings[bootstrap]"<?php if ($bootstrap) { ?> checked=""<?php } ?> data-name="bootstrap">
					  <label for="bootstrap"></label>
					</div>
				  </div>
				</div>
				<div class="col-sm-4">
				  <label class="col-sm-6 control-label" for="input-status"><?php echo $entry_font; ?> <span data-toggle="tooltip" title="<?php echo $entry_help_font; ?>"></span></label>
				  <div class="col-sm-6 text-left">
				    <div class="lightOnOff settings">  
					  <input type="checkbox" value="1" id="font" name="lightsettings[font]"<?php if ($font) { ?> checked=""<?php } ?> data-name="font">
					  <label for="font"></label>
					</div>
				  </div>
				</div>
				<div class="col-sm-4">
				  <label class="col-sm-6 control-label" for="input-status"><?php echo $entry_jquery; ?> <span data-toggle="tooltip" title="<?php echo $entry_help_jquery; ?>"></span></label>
				  <div class="col-sm-6 text-left">
				    <div class="lightOnOff settings">  
					  <input type="checkbox" value="1" id="jquery" name="lightsettings[jquery]"<?php if ($jquery) { ?> checked=""<?php } ?> data-name="jquery">
					  <label for="jquery"></label>
					</div>
				  </div>
				</div>
			  </div>
			  <div class="alert alert-info">2. <?php echo $text_alert_cart_template; ?></div>
			  <?php echo $text_help_cart_template_1; ?><br />
			  <div class="row">
				<div class="col-sm-12">
			      <div class="well well-sm" style="overflow: auto;">
				   - <?php echo $text_help_cart_template_5; ?><br />
			       - <?php echo $text_help_cart_template_6; ?><br />
				   - <?php echo $text_help_cart_template_2; ?><br /><br />
				   <?php echo $text_help_cart_template_3; ?>
				  </div>
				  <?php echo $text_help_cart_template_4; ?><br /><br />
				  <?php foreach ($languages as $language) { ?>
					<span class="input-group">
					  <span class="input-group-addon">
						<img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" />
					  </span>
					  <input type="text" name="masterhtml[items][<?php echo $language['language_id']; ?>]" value='<?php if (isset($htmls['items'][$language['language_id']])) { ?><?php echo $htmls['items'][$language['language_id']]; ?><?php } else { ?><?php if ($text_items_placeholder[$language['language_id']]) { ?><?php echo $text_items_placeholder[$language['language_id']]; ?><?php } ?><?php } ?>' placeholder='<?php if (isset($htmls['items'][$language['language_id']])) { ?><?php echo $htmls['items'][$language['language_id']]; ?><?php } else { ?><?php if ($text_items_placeholder[$language['language_id']]) { ?><?php echo $text_items_placeholder[$language['language_id']]; ?><?php } ?><?php } ?>' class="form-control" />
					</span>
				  <?php } ?><br />
				  <div class="alert alert-danger"><?php echo $text_help_cart_template_7; ?></div>
			    </div>
			  </div><br />
			  <div class="alert alert-info">3. <?php echo $text_alert_cart_js_template; ?></div>
			  <?php echo $text_alert_cart_js_template_1; ?><br />
			  <div class="well well-sm" style="overflow: auto;">
			  &lt;script&gt;
			   <textarea name="masterhtml[js][0]" class="form-control"><?php if ($htmls_js) { ?><?php echo $htmls_js; ?><?php } ?></textarea>
			   &lt;/script&gt;
			  </div>
			  <div class="alert alert-danger"><?php echo $text_help_cart_template_8; ?></div><br />
			  <div class="alert alert-info">4. <?php echo $text_alert_cart_css_template; ?></div>
			  <?php echo $text_alert_cart_js_template_2; ?><br />
			  <div class="well well-sm" style="overflow: auto;">
			  &lt;style&gt;
			   <textarea name="masterhtml[css][0]" class="form-control"><?php if ($htmls_css) { ?><?php echo $htmls_css; ?><?php } ?></textarea>
			   &lt;/style&gt;
			  </div><br />
			</div>
			<div class="tab-pane" id="tab-payment">
			  <div class="alert alert-info"><i class="fa fa-info" aria-hidden="true"></i> <?php echo $text_alert_payment; ?></div>
			  <div class="alert alert-info"><i class="fa fa-info" aria-hidden="true"></i> <?php echo $text_alert_payment_status; ?></div>
			  <div class="form-group">
				<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_payment_status; ?> <span data-toggle="tooltip" title="<?php echo $entry_help_payment_status; ?>"></span></label>
				<div class="col-sm-10 text-left">
				  <select name="lightsettings[payment_status]" id="input-payment-status" class="form-control">
					<?php foreach ($order_statuses as $order_status) { ?>
					<?php if ($order_status['order_status_id'] == $payment_status) { ?>
					<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
					<?php } else { ?>
					<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
					<?php } ?>
					<?php } ?>
				  </select>
				</div>
			  </div>
			</div>
        </form>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="modal-bg"></div>
<script>
$('#languagetop a:first').tab('show');
$('#languagebottom a:first').tab('show');
function lightrequestpost(){
	$.ajax({
		url: 'index.php?route=extension/module/lightcheckout/lightrequestpost&token=<?php echo $token; ?>',
		type: 'post',
		data: $('#form-module select, #form-module input[type=\'checkbox\']:checked, #form-module input[type=\'hidden\'], #form-module input[type=\'text\'], #form-module textarea'),
		dataType: 'json',
		beforeSend: function() {},
		complete: function() {
			$('.alert-success').fadeIn(1000).delay(5000).fadeOut(1000);
		},
		success: function(json){
			$('.alert-success, .alert-danger, #content > .container-fluid > .alert-warning, .text-danger').remove();
			$('.has-error').removeClass('has-error');
			var html = '';
			if (json['success']) {
				html += '<div class="alert alert-success alert-dismissible"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button data-dismiss="alert" class="close" type="button">×</button></div>';
			}
			if (json['warning']) {
				html += '<div class="alert alert-danger alert-dismissible"><i class="fa fa-check-circle"></i> ' + json['warning'] + '<button data-dismiss="alert" class="close" type="button">×</button></div>';
			}
			if (json['warning_store']) {
				$('#seo_store').after('<div class="text-danger"><i class="fa fa-check-circle"></i> ' + json['warning_store'] + '<button data-dismiss="alert" class="close" type="button">×</button></div>');
				$('a[href^=#tab-seo-url]').trigger('click');
			}
			if (json['warning_keyword']) {
				for (var key in json['warning_keyword']) {
					$('#keyword-language-' + key).after('<div class="text-danger">' + json['warning_keyword'][key] + '</div>');
					$('#keyword-language-' + key).addClass('has-error');
				}
				$('a[href^=#tab-seo-url]').trigger('click');
				
			}
			if (!json['warning']){
				if (json['debugging']) {
					html += '<div class="alert alert-warning alert-dismissible"><i class="fa fa-check-circle"></i> ' + json['debugging'] + '<button data-dismiss="alert" class="close" type="button">×</button></div>';
					
					$('a[href^=#tab-settings]').trigger('click');
				}
			}
			
			if (json['warning']){
				if (json['rows_error']) {
					for (var item of json['rows_error']) {
						$('#restriction-row' + item).addClass('has-error');
					}
					$('a[href^=#tab-restrictions]').trigger('click');
				}
				if (json['rows_empty_max']) {
					for (var item of json['rows_empty_max']) {
						$('#lightrestrictions-value-row' + item).addClass('has-error');
					}
					$('a[href^=#tab-restrictions]').trigger('click');
				}
			}
			
			$('#content > .container-fluid').prepend(html);
		},
		error: function(xhr, ajaxOptions, thrownError){
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}
$("#light-left-design").slider({
	tooltip: 'always',
	formatter: function(value) {
		$('#light-left').parent().attr('class','col-sm-' + value);
		$('#light-right').parent().attr('class','col-sm-' + parseInt(12 - value));
		value = value - 1; 
		if (value < 0){value = 0;}
		allHeightBlock(value, 'left');
	},
});
$("#light-right-design").slider({
	tooltip: 'always',
	formatter: function(value) {
		$('#light-right-1').attr('class','col-sm-' + value);
		$('#light-right-2').attr('class','col-sm-' + parseInt(12 - value));
		
		if (value == 2 || value == 1) {value = parseInt(value - 1);}
		if (value < 0){value = 0;}
		if (value == 11 || value == 10) {value = 1;}
		
		allHeightBlock(value, 'right');
	},
});
function allHeightBlock(value, id) {
	/*if ($(window).width() < 767) {*/
		$('#light-' + id + ' .cursor-move > div > .input-group-addon').each(function() {
			
			var width_div = $(this).outerWidth();
			var width_parent = $(this).parent().outerWidth();
			
			if (width_div > width_parent) {
				$(this).find('strong').css('display', 'none');
				$(this).parent().addClass('classheight');
				$(this).parent().find('.input-group .form-control').before($(this).parent().find('.input-group .input-group-addon'));
				if (value == 1 || value == 0){
					$(this).parent().find('.input-group .form-control').hide();
					if (value == 0){$(this).find('.lightOnOff').css('width', 'auto');}
					if (value == 1){$(this).find('.lightOnOff').removeAttr('style');}
				} else {
					$(this).find('.lightOnOff').removeAttr('style');
				}
			} else {
				$(this).find('strong').removeAttr('style');
				$(this).parent().removeClass('classheight');
				$(this).parent().find('.input-group .form-control').after($(this).parent().find('.input-group .input-group-addon'));
				$(this).parent().find('.input-group .form-control').removeAttr('style');
			}
		});
	/*}*/
}
var adjustment;
$("ol.light-left").sortable({
  group: 'light-left',
  pullPlaceholder: true,
  // animation on drop
  onDrop: function  ($item, container, _super) {
    var $clonedItem = $('<li/>').css({height: 0});
    $item.before($clonedItem);
    $clonedItem.animate({'height': $item.height()});
    $item.animate($clonedItem.position(), function  () {
      $clonedItem.detach();
      _super($item, container);
    });
	
	var group_id = $item.parent().attr('data-group-id');
	var name_group = $item.find('input[name^=\'light_checkout[sort]\']').attr('data-name');
	$item.find('input[name^=\'light_checkout[sort]\']').attr('name', 'light_checkout[sort][' + group_id + '][' + name_group +']');
	
	$('.light-left').each(function(){
		var id = 0;
		$(this).find('li.cursor-move').each(function(id){
			id = id + 1;
			$(this).find('input[name^=\'light_checkout[sort]\']').attr('value', id);
		});
	});
	
  },

  // set $item relative to cursor position
  onDragStart: function ($item, container, _super) {
    var offset = $item.offset(),
        pointer = container.rootGroup.pointer;

    adjustment = {
      left: pointer.left - offset.left,
      top: pointer.top - offset.top
    };

    _super($item, container);
  },
  onDrag: function ($item, position) {
    $item.css({
      left: position.left - adjustment.left,
      top: position.top - adjustment.top
    });
  }
});
function centering(diving){
	var wsize = windowWorkSize(),
	testElem = $(diving),
	testElemWid =  testElem.outerWidth(),
	testElemHei =  testElem.outerHeight();
	
	var top = wsize[1]/2 - testElemHei/2 + (document.body.scrollTop || document.documentElement.scrollTop);
	
	if (top < 80) {
		top = 80;
	}
			
	testElem.css('top', top + 'px');

	function windowWorkSize(){
	var wwSize = new Array();
		if (window.innerHeight !== undefined) {wwSize= [window.innerWidth,window.innerHeight]} else {
			wwSizeIE = (document.body.clientWidth) ? document.body : document.documentElement; 
			wwSize= [wwSizeIE.clientWidth, wwSizeIE.clientHeight];
		};
		return wwSize;
	};
}
function CheckedFields(id) {	
	var htm = '<div class="text-right"><button class="btn btn-primary" title="" data-toggle="tooltip" data-original-title="Сохранить" onClick="SaveCheckedFieldsLogin();"><i class="fa fa-save"></i></button>&nbsp;&nbsp;<button class="btn btn-default" title="" data-toggle="tooltip" title="Отмена" onClick="DeleteCheckedFields(\'#' + id + '\');"><i class="fa fa-reply"></i></button></div>';
	
	$('body').prepend('<div class="divshadow"></div>');
	$('#light-' + id.replace('checked_', '')).addClass('load');
	
	setTimeout(function(){
		$.ajax({
			url: 'index.php?route=extension/module/lightcheckout/getfields&token=<?php echo $token; ?>&id=' + id,
			type: 'post',
			data: $('.divshadow #' + id + ' input[type=\'text\'], .divshadow #' + id + ' input[type=\'checkbox\']:checked'),
			dataType: 'html',
			beforeSend: function() {
				$('.modal-bg').addClass("show");
			},
			complete: function() {
				$('body > .divshadow').prepend(htm);
				centering('.divshadow');
				$('body > .divshadow').addClass('show col-lg-offset-2 col-lg-8 col-sm-offset-3 col-sm-6 col-xs-offset-1 col-xs-10 animated bounceIn');
				$('#light-' + id.replace('checked_', '')).removeClass('load');
			},
			success: function(html) {
				$('body > .divshadow').prepend(html);
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}, 1000);
	
	$('[data-toggle=\'tooltip\']').tooltip({container: 'body', html: true});
}
$('input[name^=\'light_checkout[status]\']').each(function(){
	if ($(this).is(':checked')) {
		$('#' + $(this).attr('data-name')).removeClass('opacity');
	} else {
		$('#' + $(this).attr('data-name')).addClass('opacity');
	}
});
$('input[name^=\'light_checkout[status]\']').change(function(){
	if ($(this).is(':checked')) {
		$('#' + $(this).attr('data-name')).removeClass('opacity');
	} else {
		$('#' + $(this).attr('data-name')).addClass('opacity');
	}
});
$('select#input-country').on('change', function(){
	$.ajax({
		url: 'index.php?route=extension/module/lightcheckout/country&country_id=' + this.value + '&token=<?php echo $token; ?>',
		dataType: 'json',
		beforeSend: function() {
			$('select#input-country').prop('disabled', true);
		},
		complete: function() {
			$('select#input-country').prop('disabled', false);
		},
		success: function(json) {
			
			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json['zone'] && json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
					html += '<option value="' + json['zone'][i]['zone_id'] + '"';

					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
						html += ' selected="selected"';
					}

					html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}

			$('select#input-zone').html(html);
			
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});
$('i[onClick="CheckedFields(\'checked_confirm\');"]').parent().remove();

var restriction_row = <?php echo $restriction_row; ?>;
function addRestriction() {
	html  = '<tr id="restriction-row' + restriction_row + '">';
	html += '  <td class="left">';
	html += '    <select name="lightrestrictions[' + restriction_row + '][type]" class="form-control">>';
	<?php foreach ($restrictions as $restriction) { ?>
	html += '      <option value="<?php echo $restriction['type']; ?>"><?php echo $restriction['name_type']; ?></option>';
	<?php } ?>
	html += '    </select>';
	html += '  </td>';
	html += '  <td class="left">';
	html += '    <select name="lightrestrictions[' + restriction_row + '][customer_group_id]" class="form-control">>';
	<?php foreach ($customer_groups as $customer_group) { ?>
	html += '      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>';
	<?php } ?>
	html += '    <select>';
	html += '  </td>';
	html += '  <td class="left" id="lightrestrictions-value-row' + restriction_row + '">';
	html += '    <input type="text" class="form-control" name="lightrestrictions[' + restriction_row + '][value]" value="0" />';
	html += '  </td>';
	html += '  <td class="left">';
	html += '    <a onclick="$(\'#restriction-row' + restriction_row + '\').remove()" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></a>';
	html += '  </td>';
	html += '</tr>';

	$('#tab-restriction table tbody').append(html);

	restriction_row++;
}
</script>
<?php } ?>
<?php if ($id) { ?>
<div id="<?php echo $id; ?>">
	<div class="text-center"><i class="fa fa-user"></i> <?php echo $name_id; ?></div>
	<?php if ($id == 'checked_alogin') { ?>
		<div class="alert alert-info"><i class="fa fa-info" aria-hidden="true"></i> <?php echo $tooltip_register; ?></div>
		<div class="alert alert-info"><i class="fa fa-info" aria-hidden="true"></i> <?php echo $tooltip_guest; ?></div>
	<?php } ?>
	<?php if ($id == 'checked_payment_address') { ?>
		<div class="alert alert-info"><i class="fa fa-info" aria-hidden="true"></i> <?php echo $text_checked_payment_address_1; ?></div>
		<div class="alert alert-info"><i class="fa fa-info" aria-hidden="true"></i> <?php echo $text_checked_payment_address_2; ?></div>
	<?php } ?>
	<?php if ($id == 'checked_cart') { ?>
		<div class="alert alert-info"><i class="fa fa-info" aria-hidden="true"></i> <?php echo $text_checked_cart; ?></div>
		<div class="alert alert-info"><i class="fa fa-info" aria-hidden="true"></i> <?php echo $text_checked_cart_dop; ?></div>
	<?php } ?>	
	<div class="checked-fields">
	  <table class="table table-bordered table-hover">
		<?php if ($id != 'checked_cart') { ?>
		<thead>
		  <tr>
			<td><?php echo $text_name_porpose; ?></td>
			<td class="text-center"><?php echo $text_show; ?></td>
			<td class="text-center"><?php echo $text_required; ?></td>
			<td><?php echo $text_name_fields; ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $tooltip_rename_help; ?>"></span></td>
			<?php if ($id != 'checked_payment_method' and $id != 'checked_shipping_method') { ?>
			  <td><?php echo $text_placeholder_fields; ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $tooltip_rename_help; ?>"></span></td>
			  <td><?php echo $text_sort; ?></td>
			<?php } ?>
		  </tr>
		</thead>
		<tbody>
		<?php foreach ($groups as $name => $group) { ?>
		  <tr<?php echo $group['class_name']; ?><?php if ($register_show and isset($status['alogin'])) { ?><?php if ($group['group_name_id'] == 'payment_address') { ?><?php if ($name == 'firstname' or $name == 'lastname' or $name == 'phone' or $name == 'email') { ?> class="light-hide"<?php } ?><?php } ?><?php } ?><?php if ($name == 'register') { ?> class="register"<?php } ?><?php if ($name == 'guest') { ?> class="guest"<?php } ?>>
			<td<?php if ($group['class_name']) { ?> class="text-right"<?php } ?>>
			  <?php echo $group['text_name_porpose']; ?>&nbsp;<?php if ($name == 'custom' or $name == 'guest_custom' or $name == 'custom_account' or $name == 'shipping_custom') { ?>(<span data-toggle="tooltip" title="<?php echo $help_text_custom; ?>"></span>)<?php } ?> 
			  <?php if ($group['tooltip']) { ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $group['tooltip']; ?>"></span><?php } ?>
			  <?php if ($name == 'register' or $name == 'guest') { ?><br /><a onClick="Checked<?php echo $name; ?>();" alt="" title="" class="text_checked_fields"><?php echo $text_checked_fields; ?></a><?php } ?>
			  <?php if ($name == 'register') { ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $tooltip_register; ?>"></span><?php } ?>
			  <?php if ($name == 'guest') { ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $tooltip_guest; ?>"></span><?php } ?>
			  <?php if ($name == 'payment_method') { ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $tooltip_payment_methods; ?>"></span><br /><a href="<?php echo $href_payment_method; ?>" target="_blank"><strong><?php echo $text_checked_payment_method; ?></strong></a><?php } ?>
			  <?php if ($name == 'shipping_method') { ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $tooltip_shipping_methods; ?>"></span><br /><a href="<?php echo $href_shipping_method; ?>" target="_blank"><strong><?php echo $text_checked_shipping_method; ?></strong></a><?php } ?>
			</td>
			<td class="text-center">
			<?php if (!$group['payment_method'] and !$group['shipping_method'] and $group['name_id'] != 'payment_method' and $group['name_id'] != 'shipping_method') { ?>
			  <input id="group-<?php echo $name; ?>-show" type="checkbox" name="<?php echo $id; ?>[<?php echo $group['group_name_id']; ?>][<?php echo $name; ?>][show]" value="1"<?php if ($group['show']) { ?> checked="checked"<?php } ?>>
			  <label class="light-checked" for="group-<?php echo $name; ?>-show"></label>
			  <?php if ($name == 'custom' or $name == 'custom_account') { ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $help_show_custom_account; ?>"></span><?php } ?>
			  <?php if ($name == 'guest_custom' or $name == 'shipping_custom') { ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $help_show_custom; ?>"></span><?php } ?>
			  <?php if ($name == 'payment_agree') { ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $text_help_payment_agree; ?>"></span><?php } ?>
			<?php } ?>
			</td>
			<td class="text-center">
			<?php if (!$group['payment_method'] and !$group['shipping_method'] and $group['name_id'] != 'payment_method' and $group['name_id'] != 'shipping_method') { ?>
			  <?php if ($group['test_required']) { ?>
				<input id="group-<?php echo $name; ?>-required" type="checkbox" name="<?php echo $id; ?>[<?php echo $group['group_name_id']; ?>][<?php echo $name; ?>][required]" value="1"<?php if ($group['required']) { ?> checked="checked"<?php } ?>>
			    <label class="light-checked" for="group-<?php echo $name; ?>-required"></label>
				<?php if ($name == 'postcode' or $name == 'guest_postcode') { ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $help_postcode; ?>"></span><?php } ?>
			  <?php } else { ?>-<?php if ($name == 'custom' or $name == 'guest_custom' or $name == 'shipping_custom') { ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $help_custom; ?>"></span><?php } ?><?php } ?><?php if ($name == 'batches_address') { ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $text_help_batches_address; ?>"></span><?php } ?></td>
			<?php } ?>
			<td class="text-center">
			<?php if ($group['name_id'] != 'payment_agree') { ?>
			  <?php foreach ($languages as $language) { ?>
				<span class="input-group">
				  <span class="input-group-addon">
					<img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" />
				  </span>
				  <input type="text" name="<?php echo $id; ?>[<?php echo $group['group_name_id']; ?>][<?php echo $name; ?>][name][<?php echo $language['language_id']; ?>]" value="<?php echo $group['name'][$language['language_id']]; ?>" placeholder="<?php if ($group['group_name_id'] == 'alogged') { ?><?php echo $text_placeholder_alogged; ?><?php } elseif ($group['placeholder'][$language['language_id']]) { ?><?php echo $group['placeholder'][$language['language_id']]; ?><?php } else { ?><?php echo $group['text_placeholder_porpose']; ?><?php } ?>" class="form-control" />
				</span>
			  <?php } ?>
			<?php } else { ?><br /><br /><br /><input type="hidden" name="<?php echo $id; ?>[<?php echo $group['group_name_id']; ?>][<?php echo $name; ?>][name][<?php echo $language['language_id']; ?>]" value="<?php echo $group['name'][$language['language_id']]; ?>" placeholder="<?php if ($group['group_name_id'] == 'alogged') { ?><?php echo $text_placeholder_alogged; ?><?php } elseif ($group['placeholder'][$language['language_id']]) { ?><?php echo $group['placeholder'][$language['language_id']]; ?><?php } else { ?><?php echo $group['text_placeholder_porpose']; ?><?php } ?>" class="form-control" /><?php } ?>
			</td>
			<?php if ($id != 'checked_payment_method' and $id != 'checked_shipping_method') { ?>
			  <td class="text-center">
				<?php if (!$group['payment_method'] and !$group['shipping_method']) { ?>
				<?php if ($group['test_required']) { ?>
				  <?php foreach ($languages as $language) { ?>
					<span class="input-group">
					  <span class="input-group-addon">
						<img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" />
					  </span>
					  <input type="text" name="<?php echo $id; ?>[<?php echo $group['group_name_id']; ?>][<?php echo $name; ?>][placeholder][<?php echo $language['language_id']; ?>]" value="<?php echo $group['placeholder'][$language['language_id']]; ?>" placeholder="<?php if ($group['text_placeholder_porpose']) { ?><?php echo $group['text_placeholder_porpose']; ?><?php } else { ?><?php echo $group['placeholder'][$language['language_id']]; ?><?php } ?>" class="form-control" />
					</span>
				  <?php } ?>
				<?php } else { ?>-<?php } ?>
				<?php } ?>
			  </td>
			  <td class="text-center">
				<?php if (!$group['payment_method'] and !$group['shipping_method']) { ?>
				  <?php if ($group['test_required_sort']) { ?>
					<input type="text" name="<?php echo $id; ?>[<?php echo $group['group_name_id']; ?>][<?php echo $name; ?>][sort]" value="<?php echo $group['sort']; ?>" placeholder="" class="form-control one-input" />
				  <?php } else { ?>
				  - <input type="hidden" name="<?php echo $id; ?>[<?php echo $group['group_name_id']; ?>][<?php echo $name; ?>][sort]" value="<?php echo $group['sort']; ?>" placeholder="" class="form-control one-input" />
				  <?php } ?>
				<?php } ?>
			  </td>
			<?php } ?>
		  </tr>
		<?php } ?>
		</tbody>
		<?php } else { ?>
		<tbody class="form-horizontal">
		  <tr>
			<td>
			  <div class="col-sm-4">
			    <div class="form-group">
				  <label class="col-sm-5 control-label" for="input-zone"><?php echo $entry_coupon; ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $entry_help_coupon; ?>"></span></label>
				  <div class="col-sm-7">
					<div class="lightOnOff settings">
					  <input type="checkbox" value="1" id="coupon" name="lightcart[coupon]"<?php if ($coupon) { ?> checked=""<?php } ?> data-name="coupon">
					  <label for="coupon"></label>
					</div>
				  </div>
				</div>
			  </div>
			  <div class="col-sm-4">
			    <div class="form-group">
				  <label class="col-sm-7 control-label" for="input-zone"><?php echo $entry_reward; ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $entry_help_reward; ?>"></span></label>
				  <div class="col-sm-5">
					<div class="lightOnOff settings">
					  <input type="checkbox" value="1" id="reward" name="lightcart[reward]"<?php if ($reward) { ?> checked=""<?php } ?> data-name="reward">
					  <label for="reward"></label>
					</div>
				  </div>
				</div>
			   </div>
			  <div class="col-sm-4">
			    <div class="form-group">
				  <label class="col-sm-7 control-label" for="input-zone"><?php echo $entry_voucher; ?>&nbsp;<span data-toggle="tooltip" title="<?php echo $entry_help_voucher; ?>"></span></label>
				  <div class="col-sm-5">
					<div class="lightOnOff settings">
					  <input type="checkbox" value="1" id="voucher" name="lightcart[voucher]"<?php if ($voucher) { ?> checked=""<?php } ?> data-name="voucher">
					  <label for="voucher"></label>
					</div>
				  </div>
				</div>
			  </div>
			  <input type="hidden" value="1" name="lightcart[test]" />
			</td>
		  </tr>
		</tbody>
		<?php } ?>
	  </table>
	</div>
</div>
<script><!--
function DeleteCheckedFields() {
	$('body .divshadow').removeClass('animated').removeClass('bounceIn').addClass('animated bounceOut');
	setTimeout(function() {
		$('.divshadow').remove();
	},700);
	setTimeout(function() {
		$('.modal-bg').removeClass("show");
	}, 1000);
}
function SaveCheckedFieldsLogin() {
	$.ajax({
		url: 'index.php?route=extension/module/lightcheckout/addfields&token=<?php echo $token; ?>',
		type: 'post',
		data: $('.divshadow #<?php echo $id; ?> input[type=\'text\'], .divshadow #<?php echo $id; ?> input[type=\'checkbox\']:checked, .divshadow #<?php echo $id; ?> input[type=\'hidden\']'),
		dataType: 'json',
		beforeSend: function(){},
        complete: function(){},
		success: function(json) {
		  $('.divshadow .alert-success, .divshadow .alert-danger').remove();
		  if (json['success']) {
			$('.checked-fields').before('<div class="alert alert-success" style="display: none;">' + json['success'] + '</div>');
			$('.divshadow .alert-success').fadeIn(500).delay(10000).fadeOut(1000);
		  }
		  if (json['warning']) {
			$('.checked-fields').before('<div class="alert alert-danger" style="display: none;">' + json['warning'] + '</div>');
			$('.divshadow .alert-danger').fadeIn(500).delay(10000).fadeOut(1000);
		  }
		  if (json['error']) {
			  if (json['error']['register']) {
				$('.checked-fields').before('<div class="alert alert-warning alert-register" style="display: none;">' + json['error']['register'] + '</div>');
				setTimeout(function(){
					$('.alert-register').fadeIn(500).delay(5000).fadeOut(1000);
				}, 500);
				setTimeout(function(){
					if ($('input[name=\'checked_alogin[register][show]\']').is(':checked')) {
						$('input[name=\'checked_alogin[register][show]\']').trigger('click');
					}
				}, 5000);
			  }
			  var time_out_1 = 500; var time_out_2 = 5000;
			  if (json['error']['register']) {time_out_1 = 2500; time_out_2 = 7000;}
			  if (json['error']['guest']) {
				$('.checked-fields').before('<div class="alert alert-warning alert-guest" style="display: none;">' + json['error']['guest'] + '</div>');
				setTimeout(function(){
					$('.alert-guest').fadeIn(500).delay(5000).fadeOut(1000);
				}, time_out_1);
				setTimeout(function(){
					if ($('input[name=\'checked_alogin[guest][show]\']').is(':checked')) {
						$('input[name=\'checked_alogin[guest][show]\']').trigger('click');
					}
				}, time_out_2);
			  }
		  }			  
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}
$('tr.tr-register').hide(0);
$('tr.tr-guest').hide(0);
function Checkedregister() {
	$('tr.tr-register').slideToggle(700);
}
function Checkedguest() {
	$('tr.tr-guest').slideToggle(700);
}
$('input[name=\'checked_alogin[register][register][show]\']').change(function(){
	if ($(this).is(':checked')) {
		$('tr.tr-register').show(700);
	} else {
		$('tr.tr-register').hide(700);
	}
});
$('input[name=\'checked_alogin[guest][guest][show]\']').change(function(){
	if ($(this).is(':checked')) {
		$('tr.tr-guest').show(700);
	} else {
		$('tr.tr-guest').hide(700);
	}
});

$('tr.tr-register').wrapAll('<span class="tr-register"></span>')
$('tr.register').after($('span.tr-register'));
$('tr.tr-register').unwrap();

$('tr.tr-guest').wrapAll('<span class="tr-guest"></span>')
$('tr.guest').after($('span.tr-guest'));
$('tr.tr-guest').unwrap();

$('tr.tr-methods').wrapAll('<span class="tr-payment-methods"></span>')
$('.tr-h4-methods').after($('.tr-payment-methods'));
$('tr.tr-methods').unwrap();
//--></script>
<?php } ?>
<?php if (isset($footer)){ ?><?php echo $footer; ?><?php } ?>