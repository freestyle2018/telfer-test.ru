<div class="col-sm-12">
<form class="form-horizontal">
	<?php if ($fields) { ?>
		<?php foreach ($fields as $name => $field) { ?>
		  <?php if ($name == 'shipping_firstname' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-shipping-firstname"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_firstname; ?><?php } ?></label>
			  <input type="text" name="shipping_firstname" value="<?php echo $firstname; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_firstname; ?><?php } ?>" id="input-shipping-firstname" class="form-control" />
		  </div>
		  <?php } ?>
		  <?php if ($name == 'shipping_lastname' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-shipping-lastname"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_lastname; ?><?php } ?></label>
			  <input type="text" name="shipping_lastname" value="<?php echo $lastname; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_lastname; ?><?php } ?>" id="input-shipping-lastname" class="form-control" />
		  </div>
		  <?php } ?>
		  <?php if ($name == 'shipping_company' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-shipping-company"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_company; ?><?php } ?></label>
			  <input type="text" name="shipping_company" value="<?php echo $company; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_company; ?><?php } ?>" id="input-shipping-company" class="form-control" />
		  </div>
		  <?php } ?>
		  <?php if ($name == 'shipping_address_1' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-shipping-address-1"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_address_1; ?><?php } ?></label>
			  <input type="text" name="shipping_address_1" value="<?php echo $address_1; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_address_1; ?><?php } ?>" id="input-shipping-address-1" class="form-control" />
		  </div>
		  <?php } ?>
		  <?php if ($name == 'shipping_address_2' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-shipping-address-2"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_address_2; ?><?php } ?></label>
			  <input type="text" name="shipping_address_2" value="<?php echo $address_2; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_address_2; ?><?php } ?>" id="input-shipping-address-2" class="form-control" />
		  </div>
		  <?php } ?>
		  <?php if ($name == 'shipping_city' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-shipping-city"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_city; ?><?php } ?></label>
			  <input type="text" name="shipping_city" value="<?php echo $city; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_city; ?><?php } ?>" id="input-shipping-city" class="form-control" />
		  </div>
		  <?php } ?>
		  <?php if ($name == 'shipping_postcode' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-shipping-postcode"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_postcode; ?><?php } ?></label>
			  <input type="text" name="shipping_postcode" value="<?php echo $postcode; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_postcode; ?><?php } ?>" id="input-shipping-postcode" class="form-control" />
		  </div>
		  <?php } ?>
		  <?php if ($name == 'shipping_country_id') { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?><?php if (!$field['show']) { ?> smart-hide<?php } ?>">
			<label class="control-label" for="input-shipping-country"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_country; ?><?php } ?></label>
			  <select name="shipping_country_id" id="input-shipping-country" class="form-control">
				<option value=""><?php echo $text_select; ?></option>
				<?php foreach ($countries as $country) { ?>
				<?php if ($country['country_id'] == $country_id) { ?>
				<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
				<?php } else { ?>
				<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
				<?php } ?>
				{% endfor) { ?>
			  </select>
		  </div>
		  <?php } ?>
		  <?php if ($name == 'shipping_zone_id' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-shipping-zone"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_zone; ?><?php } ?></label>
			  <select name="shipping_zone_id" id="input-shipping-zone" class="form-control">
			  </select>
		  </div>
		  <?php } ?>
		  <?php if ($name == 'shipping_custom' and $field['show']) { ?>
		  <?php foreach ($custom_fields as $custom_field) { ?>
			  <?php if ($custom_field['location'] == 'address') { ?>
				  <?php if ($custom_field['type'] == 'select') { ?>
				  <div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					<label class="control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
					  <select name="shipping_custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
						<option value=""><?php echo $text_select; ?></option>
						<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
						<?php if ($address_custom_field[$custom_field['custom_field_id']] and $custom_field_value['custom_field_value_id'] == $address_custom_field[$custom_field['custom_field_id']]) { ?>
						<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
						<?php } ?>
						<?php } ?>
					  </select>
				  </div>
				  <?php } ?>
				  <?php if ($custom_field['type'] == 'radio') { ?>
				  <div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					<label class="control-label"><?php echo $custom_field['name']; ?></label>
					  <div id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"> <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
						<div class="radio"> <?php if ($address_custom_field[$custom_field['custom_field_id']] and $custom_field_value['custom_field_value_id'] == $address_custom_field[$custom_field['custom_field_id']]) { ?>
						  <label>
							<input type="radio" name="shipping_custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
							<?php echo $custom_field_value['name']; ?></label>
						  <?php } else { ?>
						  <label>
							<input type="radio" name="shipping_custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
							<?php echo $custom_field_value['name']; ?></label>
						  <?php } ?> </div>
						<?php } ?></div>
				  </div>
				  <?php } ?>
				  <?php if ($custom_field['type'] == 'checkbox') { ?>
				  <div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					<label class="control-label"><?php echo $custom_field['name']; ?></label>
					  <div id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"> <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
						<div class="checkbox">
						  <?php if (isset($guest_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $guest_custom_field[$custom_field['custom_field_id']])) { ?>
						  <label>
							<input type="checkbox" name="shipping_custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
							<?php echo $custom_field_value['name']; ?></label>
						  <?php } else { ?>
						  <label>
							<input type="checkbox" name="shipping_custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
							<?php echo $custom_field_value['name']; ?></label>
						  <?php } ?> </div>
						{% endfor) { ?> </div>
				  </div>
				  <?php } ?>
				  <?php if ($custom_field['type'] == 'text') { ?>
				  <div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					<label class="control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
					  <input type="text" name="shipping_custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php if ($address_custom_field[custom_field['custom_field_id']]) { ?><?php echo $address_custom_field[$custom_field['custom_field_id']]; ?><?php } else { ?><?php echo $custom_field['value']; ?><?php } ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
				  </div>
				  <?php } ?>
				  <?php if ($custom_field['type'] == 'textarea') { ?>
				  <div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					<label class="control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
					  <textarea name="shipping_custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php if ($address_custom_field[$custom_field['custom_field_id']]) { ?><?php echo $address_custom_field[$custom_field['custom_field_id']]; ?><?php } else { ?><?php echo $custom_field['value']; ?><?php } ?></textarea>
				  </div>
				  <?php } ?>
				  <?php if ($custom_field['type'] == 'file') { ?>
				  <div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					<label class="control-label"><?php echo $custom_field['name']; ?></label>
					  <button type="button" id="button-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
					  <input type="hidden" name="shipping_custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php if ($address_custom_field[$custom_field['custom_field_id']]) { ?>  <?php echo $address_custom_field[$custom_field['custom_field_id']]; ?> <?php } ?>" />
				  </div>
				  <?php } ?>
				  <?php if ($custom_field['type'] == 'date') { ?>
				  <div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					<label class="control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
					  <div class="input-group date">
						<input type="text" name="shipping_custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php if ($address_custom_field[$custom_field['custom_field_id']]) { ?><?php echo $address_custom_field[$custom_field['custom_field_id']]; ?><?php } else { ?><?php echo $custom_field['value']; ?><?php } ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
						<span class="input-group-btn">
						<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
						</span></div>
				  </div>
				  <?php } ?>
				  <?php if ($custom_field['type'] == 'time') { ?>
				  <div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					<label class="control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
					  <div class="input-group time">
						<input type="text" name="shipping_custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php if ($address_custom_field[$custom_field['custom_field_id']]) { ?><?php echo $address_custom_field[$custom_field['custom_field_id']]; ?><?php } else { ?><?php echo $custom_field['value']; ?><?php } ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
						<span class="input-group-btn">
						<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
						</span></div>
				  </div>
				  <?php } ?>
				  <?php if ($custom_field['type'] == 'time') { ?>
				  <div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					<label class="control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
					  <div class="input-group datetime">
						<input type="text" name="shipping_custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php if ($address_custom_field[$custom_field['custom_field_id']]) { ?><?php echo $address_custom_field[$custom_field['custom_field_id']]; ?><?php } else { ?><?php echo $custom_field['value']; ?><?php } ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
						<span class="input-group-btn">
						<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
						</span></div>
				  </div>
				  <?php } ?>
			  <?php } ?>
		    <?php } ?>
		  <?php } ?>
		<?php } ?>
	<?php } ?>
</form>
</div>
<script type="text/javascript"><!--
// Sort the custom fields
$('#collapse-shipping-address .form-group[data-sort]').detach().each(function() {
	if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#collapse-shipping-address .form-group').length-2) {
		$('#collapse-shipping-address .form-group').eq(parseInt($(this).attr('data-sort'))+2).before(this);
	}

	if ($(this).attr('data-sort') > $('#collapse-shipping-address .form-group').length-2) {
		$('#collapse-shipping-address .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') == $('#collapse-shipping-address .form-group').length-2) {
		$('#collapse-shipping-address .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') < -$('#collapse-shipping-address .form-group').length-2) {
		$('#collapse-shipping-address .form-group:first').before(this);
	}
});
//--></script> 
<script type="text/javascript"><!--
$('#collapse-shipping-address button[id^=\'button-shipping-custom-field\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="shipping_file" /></form>');

	$('#form-upload input[name=\'shipping_file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'shipping_file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$(node).parent().find('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input[name^=\'shipping_custom_field\']').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input[name^=\'shipping_custom_field\']').attr('value', json['file']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
				}
			});
		}
	}, 500);
});
//--></script> 
<script type="text/javascript"><!--
$('.date').datetimepicker({
	language: '<?php echo $datepicker; ?>',
	pickTime: false
});

$('.time').datetimepicker({
	language: '<?php echo $datepicker; ?>',
	pickDate: false
});

$('.datetime').datetimepicker({
	language: '<?php echo $datepicker; ?>',
	pickDate: true,
	pickTime: true
});
//--></script> 
<script type="text/javascript"><!--
$('#collapse-shipping-address select[name=\'shipping_country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=lightcheckout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#collapse-shipping-address select[name=\'shipping_country_id\']').prop('disabled', true);
		},
		complete: function() {
			$('#collapse-shipping-address select[name=\'shipping_country_id\']').prop('disabled', false);
		},
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#collapse-shipping-address input[name=\'shipping_postcode\']').parent().parent().addClass('required');
			}

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

			$('#collapse-shipping-address select[name=\'shipping_zone_id\']').html(html);
			
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
});

/*$('#collapse-shipping-address select[name=\'shipping_country_id\']').trigger('change');*/
//--></script>