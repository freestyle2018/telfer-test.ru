<form>
  <?php if (!isset($status['shipping'])) { ?>
	<div class="checkbox smart-hide">
	  <label><input type="checkbox" name="shipping_address" value="new" checked="checked" /></label>
	</div>
  <?php } ?>
  <br />
  <div id="payment-new">
	<?php if ($fields) { ?>
	  <?php foreach ($fields as $name => $field) { ?>
		<?php if ($name == 'firstname' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-payment-firstname"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_firstname; ?><?php } ?></label>
			<input type="text" name="firstname" value="" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_firstname; ?><?php } ?>" id="input-payment-firstname" class="form-control" />
		  </div>
		<?php } ?>
		<?php if ($name == 'lastname' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-payment-lastname"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_lastname; ?><?php } ?></label>
			<input type="text" name="lastname" value="" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_lastname; ?><?php } ?>" id="input-payment-lastname" class="form-control" />
		  </div>
		<?php } ?>
		<?php if ($name == 'email' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-payment-email"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_email; ?><?php } ?></label>
			<input type="text" name="email" value="" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_email; ?><?php } ?>" id="input-payment-email" class="form-control" />
		  </div>
		<?php } ?>
		<?php if ($name == 'phone' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-payment-telephone"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_telephone; ?><?php } ?></label>
			<input type="text" name="telephone" value="" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_telephone; ?><?php } ?>" id="input-payment-telephone" class="form-control" />
		  </div>
		<?php } ?>
		<?php if ($name == 'company' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-payment-company"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_company; ?><?php } ?></label>
			<input type="text" name="company" value="" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_company; ?><?php } ?>" id="input-payment-company" class="form-control" />
		  </div>
		<?php } ?>
		<?php if ($name == 'address_1' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-payment-address-1"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_address_1; ?><?php } ?></label>
			<input type="text" name="address_1" value="" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_address_1; ?><?php } ?>" id="input-payment-address-1" class="form-control" />
		  </div>
		<?php } ?>
		<?php if ($name == 'address_2' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-payment-address-2"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_address_2; ?><?php } ?></label>
			<input type="text" name="address_2" value="" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_address_2; ?><?php } ?>" id="input-payment-address-2" class="form-control" />
		  </div>
		<?php } ?>
		<?php if ($name == 'city' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-payment-city"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_city; ?><?php } ?></label>
			<input type="text" name="city" value="" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_city; ?><?php } ?>" id="input-payment-city" class="form-control" />
		  </div>
		<?php } ?>
		<?php if ($name == 'postcode' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-payment-postcode"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_postcode; ?><?php } ?></label>
			<input type="text" name="postcode" value="" placeholder="<?php if ($field['placeholder'][$language_id]) { ?><?php echo $field['placeholder'][$language_id]; ?><?php } else { ?><?php echo $entry_postcode; ?><?php } ?>" id="input-payment-postcode" class="form-control" />
		  </div>
		<?php } ?>
		<?php if ($name == 'country_id') { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?><?php if (count($countries) == 1 or !$field['show']) { ?> smart-hide<?php } ?>">
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
		<?php if ($name == 'zone_id' and $field['show']) { ?>
		  <div class="form-group<?php if ($field['required']) { ?> required<?php } ?>">
			<label class="control-label" for="input-payment-zone"><?php if ($field['name'][$language_id]) { ?><?php echo $field['name'][$language_id]; ?><?php } else { ?><?php echo $entry_zone; ?><?php } ?></label>
			<select name="light_zone_id" id="input-payment-zone" class="form-control">
			<?php if ($zones) { ?>
			  <option value="0" selected="selected"><?php echo $text_none; ?></option>
			  <?php foreach ($zones as $zone) { ?>
				<option value="<?php echo $zone['zone_id']; ?>"<?php if ($zone['zone_id'] == zone_id) { ?> selected="selected"<?php } ?>><?php echo $zone['name']; ?></option>
			  <?php } ?>
			<?php } ?>
			</select>
		  </div>
		<?php } ?>
		<?php if ($name == 'custom_account' and $field['show']) { ?>
		  <?php foreach ($custom_fields as $custom_field) { ?>
			<?php if ($custom_field['type'] == 'select') { ?>
			<div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
			  <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
			  <select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
				  <option value=""><?php echo $text_select; ?></option>
				  <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
				  <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
				  <?php } ?>
			  </select>
			</div>
			<?php } ?>
			<?php if ($custom_field['type'] == 'radio') { ?>
			<div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
			  <label class="control-label"><?php echo $custom_field['name']; ?></label>
			  <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
				  <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
				  <div class="radio">
					<label>
					  <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
					  <?php echo $custom_field_value['name']; ?></label>
				  </div>
				  <?php } ?>
			  </div>
			</div>
			<?php } ?>
			<?php if ($custom_field['type'] == 'checkbox') { ?>
			<div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
			  <label class="control-label"><?php echo $custom_field['name']; ?></label>
			  <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
				  <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
				  <div class="checkbox">
					<label>
					  <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
					  <?php echo $custom_field_value['name']; ?></label>
				  </div>
				  <?php } ?>
			  </div>
			</div>
			<?php } ?>
			<?php if ($custom_field['type'] == 'text') { ?>
			<div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
			  <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
			  <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
			</div>
			<?php } ?>
			<?php if ($custom_field['type'] == 'textarea') { ?>
			<div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
			  <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
			  <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo $custom_field['value']; ?></textarea>
			</div>
			<?php } ?>
			<?php if ($custom_field['type'] == 'file') { ?>
			<div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
			  <label class="control-label"><?php echo $custom_field['name']; ?></label>
			  <button type="button" id="button-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
				<input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
			</div>
			<?php } ?>
			<?php if ($custom_field['type'] == 'date') { ?>
			<div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
			  <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
			  <div class="input-group date">
				  <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
				  <span class="input-group-btn">
				  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
				  </span></div>
			</div>
			<?php } ?>
			<?php if ($custom_field['type'] == 'time') { ?>
			<div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
			  <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
			  <div class="input-group time">
				  <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
				  <span class="input-group-btn">
				  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
				  </span></div>
			</div>
			<?php } ?>
			<?php if ($custom_field['type'] == 'time') { ?>
			<div class="form-group<?php if ($custom_field['required']) { ?> required <?php } ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
			  <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
			  <div class="input-group datetime">
				  <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
				  <span class="input-group-btn">
				  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
				  </span></div>
			</div>
			<?php } ?>
		  <?php } ?>
		<?php } ?>
	  <?php } ?>
	<?php } ?>
    </div>
  </div>
</form>
<script type="text/javascript"><!--
$('input[name=\'payment_address\']').on('change', function() {
	if (this.value == 'new') {
		$('#payment-existing').hide();
		$('#payment-new').show();
	} else {
		$('#payment-existing').show();
		$('#payment-new').hide();
	}
});
//--></script>
<script type="text/javascript"><!--
// Sort the custom fields
$('#collapse-payment-address .form-group[data-sort]').detach().each(function() {
	if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#collapse-payment-address .form-group').length-2) {
		$('#collapse-payment-address .form-group').eq(parseInt($(this).attr('data-sort'))+2).before(this);
	}

	if ($(this).attr('data-sort') > $('#collapse-payment-address .form-group').length-2) {
		$('#collapse-payment-address .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') == $('#collapse-payment-address .form-group').length-2) {
		$('#collapse-payment-address .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') < -$('#collapse-payment-address .form-group').length-2) {
		$('#collapse-payment-address .form-group:first').before(this);
	}
});
//--></script>
<script type="text/javascript"><!--
$('#collapse-payment-address button[id^=\'button-payment-custom-field\']').on('click', function() {
	var element = this;

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
					$(element).button('loading');
				},
				complete: function() {
					$(element).button('reset');
				},
				success: function(json) {
					$(element).parent().find('.text-danger').remove();

					if (json['error']) {
						$(element).parent().find('input[name^=\'custom_field\']').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(element).parent().find('input[name^=\'custom_field\']').val(json['code']);
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

$('#collapse-payment-separator-address select[name=\'light_country_id\']').trigger('change');
//--></script>
