<?php if (!isset($redirect)) { ?>
<?php if (isset($payment)) { ?><div class="smart-hide-button"><?php echo $payment; ?></div><?php } ?>
  <div class="buttons">
    <div class="pull-right">
	  <input type="button" value="<?php echo $button_confirm; ?>" id="button-lightconfirm" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary" />
    </div>
  </div>
  <script type="text/javascript"><!--
  $('#button-lightconfirm').on('click', function() {
	var data_payment_separator_address = '';
	if (Payment_Overlap_Shiping()) {} else {
		var data_payment_separator_address = ', #collapse-shipping-address input[type=\'text\'], #collapse-shipping-address input[type=\'date\'], #collapse-shipping-address input[type=\'datetime-local\'], #collapse-shipping-address input[type=\'time\'], #collapse-shipping-address input[type=\'password\'], #collapse-shipping-address input[type=\'hidden\'], #collapse-shipping-address input[type=\'checkbox\']:checked, #collapse-shipping-address input[type=\'radio\']:checked, #collapse-shipping-address textarea, #collapse-shipping-address select';
	}
	$('#content > .alert-summa').remove();
	if (localStorage.getItem('error_close') || localStorage.getItem('error_warning')){
		if (localStorage.getItem('error_close')) {
			$('#content > #checkout-cart').after('<div class="alert alert-danger alert-summa">' + $('.alert-summa').html() + '</div>');
		}
		$('html, body').animate({ scrollTop: 0 }, 'slow');
	} else {
		$.ajax({
			url: 'index.php?route=lightcheckout/confirm/validation',
			type: 'post',
			data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'password\'], #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address textarea, #collapse-payment-address select,#collapse-payment-separator-address input[type=\'text\'], #collapse-payment-separator-address input[type=\'date\'], #collapse-payment-separator-address input[type=\'datetime-local\'], #collapse-payment-separator-address input[type=\'time\'], #collapse-payment-separator-address input[type=\'password\'], #collapse-payment-separator-address input[type=\'hidden\'], #collapse-payment-separator-address input[type=\'checkbox\']:checked, #collapse-payment-separator-address input[type=\'radio\']:checked, #collapse-payment-separator-address textarea, #collapse-payment-separator-address select' + data_payment_separator_address + ', #collapse-checkout-option input[name=\'account\']:checked'),
			dataType: 'json',
			beforeSend: function() {
				$('#button-lightconfirm').button('loading');
			},
			complete: function(json) {
				if (!json['error']) {
					/*ButtonConfirmOrder();*/
				}
			},
			success: function(json) {
				
				$('.alert-dismissible, .text-danger').remove();
				$('.form-group').removeClass('has-error');
				
				if (json['error']) {

					if (json['error']['warning']) {
						$('#collapse-payment-address .panel-body').prepend('<div class="row"><div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div></div>');
					}

					for (i in json['error']) {
						var element = $('#input-payment-' + i.replace('_', '-'));
						
						if ($(element).parent().hasClass('form-group')) {
							$(element).parent().append('<div class="text-danger">' + json['error'][i] + '</div>');
						} else {
							$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
						}
						
						var element_shipping = $('#input-' + i.replace('_', '-').replace('_', '-'));
						
						if ($(element_shipping).parent().hasClass('form-group')) {
							$(element_shipping).parent().append('<div class="text-danger">' + json['error'][i] + '</div>');
						} else {
							$(element_shipping).after('<div class="text-danger">' + json['error'][i] + '</div>');
						}
					}

					// Highlight any found errors
					$('.text-danger').parent().addClass('has-error');
				} else {
					if (json['alogin']) {
						if (json['guest'] && json['no_register']) {
							GuestSave();
						} else {
							LightRegister('confirm');
						}
					} else if (json['payment_address']) {
						LightPaymentAddressSave();
					} else if (json['shipping']) {
						LightShippingAddressSave('confirm');
					} else if (json['shipping_method']) {
						LightShippingMethodSave('confirm');
					} else if (json['payment_method']) {
						LightPaymentMethodSave();
					}					
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
			}
		});
	}
  });
  <?php if ($theme == 'oct_feelmart') { ?>
	$('input#button-lightconfirm').addClass('fm-module-overlay-btn fm-btn').removeClass('btn btn-primary');
  <?php } ?>
  //--></script>
  <?php if (isset($save)) { ?>
  <?php if (isset($nopayment)) { ?>
	<script type="text/javascript"><!--
		$.ajax({
			url: 'index.php?route=lightcheckout/confirm/confirm',
			dataType: 'json',
			beforeSend: function() {
				$('#button-lightconfirm').button('loading');
			},
			complete: function() {
				$('#button-lightconfirm').button('reset');
			},
			success: function(json) {
				if (json['redirect']) {
					location = json['redirect'];	
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
			}
		});
	//--></script>
<?php } ?>
<script type="text/javascript"><!--
setTimeout(function(){
	$('#button-confirm, .smart-hide-button input[type="submit"], .com-rbs2__submit._credit-type-2').trigger('click');
}, 0);
//--></script>
<?php } ?> 
<?php } else { ?> 
<script type="text/javascript"><!--
location = '<?php echo $redirect; ?>';
//--></script>
<?php } ?> 