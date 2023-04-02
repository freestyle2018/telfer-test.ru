<div id="guest-account">
	<div class="row">
	  <div class="col-sm-12">
		<fieldset>
		  <div class="form-group" style="display: <?php if (count($customer_groups) > 1) { ?> block <?php } else { ?> none <?php } ?>;">
			<label class="control-label"><?php echo $entry_customer_group; ?></label>
			<?php foreach ($customer_groups as $customer_group) { ?>
			<?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
			<div class="radio">
			  <label>
				<input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
				<?php echo $customer_group['name']; ?></label>
			</div>
			<?php } else { ?>
			<div class="radio">
			  <label>
				<input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" />
				<?php echo $customer_group['name']; ?></label>
			</div>
			<?php } ?>
			<?php } ?>
		  </div>
		  <?php if ($fields) { ?>
		    <?php foreach ($fields as $name => $field) { ?>
			  <?php if ($name == 'guest_firstname' and $field['show']) { ?>
			  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
				<label class="control-label" for="input-payment-firstname"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_firstname; ?><?php } ?></label>
				<input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_firstname; ?><?php } ?>" id="input-payment-firstname" class="form-control" />
			  </div>
			  <?php } ?>
			  <?php if ($name == 'guest_lastname' and $field['show']) { ?>
			  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
				<label class="control-label" for="input-payment-lastname"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_lastname; ?><?php } ?></label>
				<input type="text" name="lastname" value="<?php echo $lastname; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_lastname; ?><?php } ?>" id="input-payment-lastname" class="form-control" />
			  </div>
			  <?php } ?>
			  <?php if ($name == 'guest_email' and $field['show']) { ?>
			  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
				<label class="control-label" for="input-payment-email"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_email; ?><?php } ?></label>
				<input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_email; ?><?php } ?>" id="input-payment-email" class="form-control" />
			  </div>
			  <?php } ?>
			  <?php if ($name == 'guest_phone' and $field['show']) { ?>
			  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
				<label class="control-label" for="input-payment-telephone"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_telephone; ?><?php } ?></label>
				<input type="text" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_telephone; ?><?php } ?>" id="input-payment-telephone" class="form-control" />
			  </div>
			  <?php } ?>
			  <?php if ($name == 'guest_company' and $field['show']) { ?>
			  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
				<label class="control-label" for="input-payment-company"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_company; ?><?php } ?></label>
				<input type="text" name="company" value="<?php echo $company; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_company; ?><?php } ?>" id="input-payment-company" class="form-control" />
			  </div>
			  <?php } ?>
			  <?php if ($name == 'guest_address_1' and $field['show']) { ?>
			  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
				<label class="control-label" for="input-payment-address-1"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_address_1; ?><?php } ?></label>
				<input type="text" name="address_1" value="<?php echo $address_1; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_address_1; ?><?php } ?>" id="input-payment-address-1" class="form-control" />
			  </div>
			  <?php } ?>
			  <?php if ($name == 'guest_address_2' and $field['show']) { ?>
			  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
				<label class="control-label" for="input-payment-address-2"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_address_2; ?><?php } ?></label>
				<input type="text" name="address_2" value="<?php echo $address_2; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_address_2; ?><?php } ?>" id="input-payment-address-2" class="form-control" />
			  </div>
			  <?php } ?>
			  <?php if ($name == 'guest_city' and $field['show']) { ?>
			  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
				<label class="control-label" for="input-payment-city"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_city; ?><?php } ?></label>
				<input type="text" name="city" value="<?php echo $city; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_city; ?><?php } ?>" id="input-payment-city" class="form-control" />
			  </div>
			  <?php } ?>
			  <?php if ($name == 'guest_postcode' and $field['show']) { ?>
			  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
				<label class="control-label" for="input-payment-postcode"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_postcode; ?><?php } ?></label>
				<input type="text" name="postcode" value="<?php echo $postcode; ?>" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_postcode; ?><?php } ?>" id="input-payment-postcode" class="form-control" />
			  </div>
			  <?php } ?>
			  <?php if ($name == 'guest_country_id') { ?>
			  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?><?php if (!$field['show']) { ?> smart-hide<?php } ?>">
				<label class="control-label" for="input-payment-country"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_country; ?><?php } ?></label>
				<select name="light_country_id" id="input-payment-country" class="form-control">
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
			  <?php } ?>
			  <?php if ($name == 'guest_zone_id' and $field['show']) { ?>
			  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
				<label class="control-label" for="input-payment-zone"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_zone; ?><?php } ?></label>
				<select name="light_zone_id" id="input-payment-zone" class="form-control">
					<?php if ($zones) { ?>
					  <option value="0" selected="selected"><?php echo $text_none; ?></option>
					  <?php foreach ($zones as $zone) { ?>
						<option value="<?php echo $zone['zone_id']; ?>"<?php if ($zone['zone_id'] == $zone_id) { ?> selected="selected"<?php } ?>><?php echo $zone['name']; ?></option>
					  <?php } ?>
					<?php } ?>
				</select>
			  </div>
			  <?php } ?>
			  <?php if ($name == 'guest_custom' and $field['show']) { ?>
			    <?php foreach ($custom_fields as $custom_field) { ?>
				  <?php if ($custom_field['location'] == 'account' or $custom_field['location'] == 'address') { ?>
				    <div id="guest">
					  <?php if ($custom_field['type'] == 'select') { ?>
					  <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
						<select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
						  <option value=""><?php echo $text_select; ?></option>
						  <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
						  <?php if ($guest_custom_field[$custom_field['custom_field_id']] and $custom_field_value['custom_field_value_id'] == $guest_custom_field[$custom_field['custom_field_id']]) { ?>
						  <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
						  <?php } else { ?>
						  <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
						  <?php } ?>
						  <?php } ?>
						</select>
					  </div>
					  <?php } ?>
					  <?php if ($custom_field['type'] == 'radio') { ?>
					  <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<label class="control-label"><?php echo $custom_field['name']; ?></label>
						<div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"> <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
						  <div class="radio"> <?php if ($guest_custom_field[$custom_field['custom_field_id']] and $custom_field_value['custom_field_value_id'] == $guest_custom_field[$custom_field['custom_field_id']]) { ?>
							<label>
							  <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
							  <?php echo $custom_field_value['name']; ?></label>
							<?php } else { ?>
							<label>
							  <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
							  <?php echo $custom_field_value['name']; ?></label>
							<?php } ?> </div>
						  <?php } ?> </div>
					  </div>
					  <?php } ?>
					  <?php if ($custom_field['type'] == 'checkbox') { ?>
					  <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<label class="control-label"><?php echo $custom_field['name']; ?></label>
						<div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"> <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
						  <div class="checkbox">
						    <?php if (isset($guest_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $guest_custom_field[$custom_field['custom_field_id']])) { ?>
							<label>
							  <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
							  <?php echo $custom_field_value['name']; ?></label>
							<?php } else { ?>
							<label>
							  <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
							  <?php echo $custom_field_value['name']; ?></label>
							<?php } ?> </div>
						  <?php } ?> </div>
					  </div>
					  <?php } ?>
					  <?php if ($custom_field['type'] == 'text') { ?>
					  <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
						<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php if ($guest_custom_field[$custom_field['custom_field_id']]) { ?> <?php echo $guest_custom_field[$custom_field['custom_field_id']]; ?> <?php } else { ?> <?php echo $custom_field['value']; ?> <?php } ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
					  </div>
					  <?php } ?>
					  <?php if ($custom_field['type'] == 'textarea') { ?>
					  <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
						<textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php if ($guest_custom_field[$custom_field['custom_field_id']]) { ?> <?php echo $guest_custom_field[$custom_field['custom_field_id']]; ?> <?php } else { ?> <?php echo $custom_field['value']; ?> <?php } ?></textarea>
					  </div>
					  <?php } ?>
					  <?php if ($custom_field['type'] == 'file') { ?>
					  <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<label class="control-label"><?php echo $custom_field['name']; ?></label>
						<br />
						<button type="button" id="button-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
						<input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php if ($guest_custom_field[$custom_field['custom_field_id']]) { ?> <?php echo $guest_custom_field[$custom_field['custom_field_id']]; ?> <?php } ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
					  </div>
					  <?php } ?>
					  <?php if ($custom_field['type'] == 'date') { ?>
					  <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
						<div class="input-group date">
						  <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php if ($guest_custom_field[$custom_field['custom_field_id']]) { ?> <?php echo $guest_custom_field[$custom_field['custom_field_id']]; ?> <?php } else { ?> <?php echo $custom_field['value']; ?> <?php } ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
						  <span class="input-group-btn">
						  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
						  </span></div>
					  </div>
					  <?php } ?>
					  <?php if ($custom_field['type'] == 'time') { ?>
					  <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
						<div class="input-group time">
						  <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php if ($guest_custom_field[$custom_field['custom_field_id']]) { ?> <?php echo $guest_custom_field[$custom_field['custom_field_id']]; ?> <?php } else { ?> <?php echo $custom_field['value']; ?> <?php } ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
						  <span class="input-group-btn">
						  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
						  </span></div>
					  </div>
					  <?php } ?>
					  <?php if ($custom_field['type'] == 'time') { ?>
					  <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
						<label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field.name; ?></label>
						<div class="input-group datetime">
						  <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php if ($guest_custom_field[$custom_field['custom_field_id']]) { ?> <?php echo $guest_custom_field[$custom_field['custom_field_id']]; ?> <?php } else { ?> <?php echo $custom_field['value']; ?> <?php } ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
						  <span class="input-group-btn">
						  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
						  </span></div>
					  </div>
					  <?php } ?>
					</div>					
				  <?php } ?>
			    <?php } ?>
			  <?php } ?>
			<?php } ?>
		<?php } ?>
		</fieldset>
	  </div>
	</div>
	<?php if ($shipping_required and isset($status['payment_address']) and isset($status['shipping']) and isset($fields['batches_address']['batches_address']['show'])) { ?>
	<div class="checkbox">
	  <label> <?php if ($shipping_address) { ?>
		<input type="checkbox" name="shipping_address" value="1" checked="checked" />
		<?php } else { ?>
		<input type="checkbox" name="shipping_address" value="1" />
		<?php } ?>
		<?php echo $entry_shipping; ?></label>
	</div>
	<?php } ?>
</div>
<script type="text/javascript"><!--
if (localStorage.getItem('shipping_address') == false) {
	$('input[name=\'shipping_address\']').removeAttr('checked');
}

$('#collapse-payment-address input[name=\'customer_group_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=lightcheckout/checkout/customfield&customer_group_id=' + this.value,
		dataType: 'json',
		success: function(json) {
			$('#collapse-payment-address .custom-field').hide();
			$('#collapse-payment-address .custom-field').removeClass('required');

			for (i = 0; i < json.length; i++) {
				custom_field = json[i];

				$('#payment-custom-field' + custom_field['custom_field_id']).show();

				if (custom_field['required']) {
					$('#payment-custom-field' + custom_field['custom_field_id']).addClass('required');
				} else {
					$('#payment-custom-field' + custom_field['custom_field_id']).removeClass('required');
				}
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
});

$('#collapse-payment-address input[name=\'customer_group_id\']:checked').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$('#collapse-payment-address button[id^=\'button-payment-custom-field\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
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
						$(node).parent().find('input[name^=\'custom_field\']').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input[name^=\'custom_field\']').val(json['code']);
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
$('#collapse-payment-separator-address select[name=\'light_country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=lightcheckout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#collapse-payment-separator-address select[name=\'light_country_id\']').prop('disabled', true);
		},
		complete: function() {
			$('#collapse-payment-separator-address select[name=\'light_country_id\']').prop('disabled', false);
		},
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#collapse-payment-separator-address input[name=\'postcode\']').parent().parent().addClass('required');
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

			$('#collapse-payment-separator-address select[name=\'light_zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
});

/*$('#collapse-payment-separator-address select[name=\'light_country_id\']').trigger('change');*/
//--></script> 