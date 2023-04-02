<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
</div>
<div id="checkout-checkout" class="container <?php echo $theme; ?>">
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left and $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left or $column_right) { ?>
    <?Php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
	  <?php echo $cart; ?>
      <h1><?php echo $heading_title_light; ?></h1>
	  <div class="row">		  
		  <div class="panel-group" id="accordion">
		    <div class="col-sm-12"><?php echo $htmls['top'][$language_id]; ?></div>
			<div class="col-sm-12"><div id="mobile-cart"></div></div>
			<div class="col-lg-<?php echo $columns[1]; ?> col-md-<?php echo $columns[1]; ?> col-sm-6" id="light-left">
			  <?php if (isset($status['alogin']) and ($fields['register']['show'] or $fields['guest']['show'] or $fields['alogged']['show'])) { ?>
				<div id="register-guest">
				  <div class="panel panel-default">
					<ul class="nav nav-tabs panel-heading<?php if (!$logged) { ?> padding-bottom-0<?php } ?> margin-bottom-0" id="light-tab">
						<?php if ($fields['register']['show'] or $fields['guest']['show']) { ?>
						  <li class="active <?php if (!$logged) { ?>light-not-logged<?php } else { ?>light-logged<?php } ?>">
						    <a href="#tab-register" data-toggle="tab"><?php if ($fields['register']['show']) { ?><?php if ($fields['register']['name'][$language_id]) { ?><?php echo $fields['register']['name'][$language_id]; ?><?php } else { ?><?php echo $text_register; ?><?php } ?><?php } elseif ($fields['guest']['show']) { ?><?php echo $text_checkout_guest; ?><?php } ?></a>
						  </li>
						<?php } ?>
						<?php if ($fields['alogged']['show']) { ?>
						  <li class="<?php if (!$logged) { ?>light-not-logged<?php } else { ?>light-logged<?php } ?><?php if (!$fields['register']['show'] and !$fields['guest']['show']) { ?> active<?php } ?>">
						    <a href="#tab-login" data-toggle="tab"><?php if ($fields['alogged']['name'][$language_id]) { ?><?php echo $fields['alogged']['name'][$language_id]; ?><?php } else { ?><?php echo $text_login_light_checkout; ?><?php } ?></a>
						  </li>
						<?php } ?>
						<li class="<?php if ($logged) { ?>light-not-logged<?php } else { ?>light-logged<?php } ?>"><span class="light-float-left margin-right-15"><?php echo $text_enter_login; ?></span><span onClick="location = '<?php echo $href_account; ?>'" class="light-float-left btn-link"><?php echo $log_firstname; ?> <?php echo $log_lastname; ?></span></li>
						<li class="<?php if ($logged) { ?>light-not-logged<?php } else { ?>light-logged<?php } ?> pull-right btn-link" onClick="location = '<?php echo $hrer_logout; ?>'"><span><?php echo $text_login_exit; ?></span></li>
					</ul><div class="clearfix"></div>
					<div class="panel-collapse tab-content panel-body" style="<?php if (!$logged) { ?>display: block<?php } else { ?>display: none;<?php } ?>" id="collapse-checkout-option"></div>
				  </div>
				</div>
			  <?php } ?>
			</div>
			<div class="col-lg-<?php echo $columns[2]; ?> col-md-<?php echo $columns[2]; ?> col-sm-6" id="light-right">
			  <div class="row">
				<div class="col-lg-<?php echo $columns[3]; ?> col-md-<?php echo $columns[3]; ?>"><div id="light-right-1"></div></div>
				<div class="col-lg-<?php echo $columns[4]; ?> col-md-<?php echo $columns[4]; ?>"><div id="light-right-2"></div></div>
				<div class="col-lg-12"><div id="light-right-3"></div></div>
			  </div>
			</div>
			<div id="mobile-light"></div>
			<?php if (!$logged) { ?>
			<div class="col-lg-6">
			  <?php if (isset($status['payment_address'])) { ?>
				<div id="payment-address">
					<div class="panel panel-default">
					  <div class="panel-heading">
						<h4 class="panel-title"><?php echo $text_your_address; ?></h4>
					  </div>
					  <div class="panel-collapse" id="collapse-payment-separator-address">
						<div class="panel-body"></div>
					  </div>
					</div>
				</div>
			  <?php } ?>
			</div>
			<?php } ?>
			<?php if ($shipping_required) { ?>
			<div class="<?php if (!$logged) { ?>col-lg-6<?php } else { ?>col-sm-6<?php } ?>">
			  <?php if (isset($status['shipping'])) { ?>
				<div id="shipping-address">
					<div class="panel panel-default">
					  <div class="panel-heading">
						<h4 class="panel-title"><?php echo $text_checkout_shipping_address; ?></h4>
					  </div>
					  <div class="panel-collapse" id="collapse-shipping-address">
						<div class="panel-body"></div>
					  </div>
					</div>
				</div>
			  <?php } ?>
			</div>
			<div class="<?php if (!$logged) { ?>col-lg-6<?php } else { ?>col-sm-6<?php } ?>">
				<?php if (isset($status['shipping_method']) and $shipping_required) { ?>
					<div id="shipping_method"<?php if (!$shipping_required) { ?> style="display: none;"<?php } ?>>
						<div class="panel panel-default">
						  <div class="panel-heading">
							<h4 class="panel-title"><?php if ($fields_shipping_methods['shipping_method']['name'][$language_id]) { ?><?php echo $fields_shipping_methods['shipping_method']['name'][$language_id]; ?><?php } else { ?><?php echo $text_checkout_shipping_method; ?><?php } ?></h4>
						  </div>
						  <div class="panel-collapse" id="collapse-shipping-method">
							<div class="panel-body"></div>
						  </div>
						</div>
					</div>
				<?php } ?>
			</div>
			<?php } ?>
			<div class="<?php if (!$logged) { ?>col-lg-6<?php } else { ?>col-sm-6<?php } ?>">
				<?php if (isset($status['payment_method'])) { ?>
					<div id="payment-method">
						<div class="panel panel-default">
						  <div class="panel-heading">
							<h4 class="panel-title"><?php if ($fields_payment_methods['payment_method']['name'][$language_id]) { ?><?php echo $fields_payment_methods['payment_method']['name'][$language_id]; ?><?php } else { ?><?php echo $text_checkout_payment_method; ?><?php } ?></h4>
						  </div>
						  <div class="panel-collapse" id="collapse-payment-method">
							<div class="panel-body"></div>
						  </div>
						</div>
					</div>
				<?php } ?>
			</div>
			<div class="<?php if (!$logged) { ?>col-lg-6<?php } else { ?>col-sm-6<?php } ?>">
				<div id="checkout-confirm">
					<div class="panel-default">
					  <div class="panel-collapse in" id="collapse-checkout-confirm">
						<div class="row"><div class="panel-body"></div></div>
					  </div>
					</div>
				</div>
			</div>
			<div class="clearfix"></div>
			<div class="col-sm-12"><?php echo $htmls['bottom'][$language_id]; ?></div>
		  </div>
	  </div>	  
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script type="text/javascript"><!--
<?php if ($fields['guest']['show'] and isset($status['payment_address'])) { ?>
	<?php if (!$fields['register']['show'] and !$fields['alogged']['show']) { ?>
		<!--$('#register-guest').remove();-->
	<?php } ?>
<?php } ?>
<?php if ($results) { ?>
  var register_guest = $('#register-guest');
  var payment_address = $('#payment-address');
  var shipping = $('#shipping-address');
  var shipping_method = $('#shipping_method');
  var payment_method = $('#payment-method');
  var cart = $('#light-cart');
  var confirm = $('#checkout-confirm');
  <?php foreach ($results as $group_id => $result) { ?>
	<?php if ($group_id == 1) { ?>var light_container = '#light-left';<?php } ?>
	<?php if ($group_id == 2) { ?>var light_container = '#light-right-1';<?php } ?>
	<?php if ($group_id == 3) { ?>var light_container = '#light-right-2';<?php } ?>
	<?php if ($group_id == 4) { ?>var light_container = '#light-right-3';<?php } ?>
	<?php foreach ($result as $res) { ?>
	  <?php if ($res['name'] == 'alogin') { ?>$(light_container).append(register_guest);<?php } ?>
	  <?php if ($res['name'] == 'payment_address') { ?>$(light_container).append(payment_address);<?php } ?>
	  <?php if ($res['name'] == 'shipping') { ?>$(light_container).append(shipping);<?php } ?>
	  <?php if ($res['name'] == 'shipping_method') { ?>$(light_container).append(shipping_method);<?php } ?>
	  <?php if ($res['name'] == 'payment_method') { ?>$(light_container).append(payment_method);<?php } ?>
	  <?php if ($res['name'] == 'cart') { ?>$(light_container).append(cart);<?php } ?>
	  <?php if ($res['name'] == 'confirm') { ?>$(light_container).append(confirm);<?php } ?>
	<?php } ?>
  <?php } ?>
<?php } ?>

function DistributionWidth() {
	if (!$('#light-right-1').html()) {
		$('#light-right-2').parent().attr('class', 'col-lg-12');
	}
	if (!$('#light-right-2').html()) {
		$('#light-right-1').parent().attr('class', 'col-lg-12');
	}
	if (!$('#light-left').children().html()) {
		$('#light-left').hide();
		$('#light-right').removeAttr('class').addClass('col-lg-12 col-md-12 col-sm-12 col-xs-12');
	}
}
DistributionWidth();
if ($(window).width() < 992) {
	$('#mobile-light, #mobile-cart').empty();
	$('#mobile-light').prepend($('#shipping_method'));
	$('#mobile-light').prepend($('#payment-method'));
	$('#mobile-light').append($('#checkout-confirm'));
	$('#mobile-light #shipping_method, #mobile-light #payment-method').wrap('<div class="col-sm-6 col-xs-12"></div>');
	$('#mobile-cart').append($('#light-cart'));
	$('#mobile-light #checkout-confirm').wrap('<div class="col-sm-12 col-xs-12"></div>');
	$('.light-colspan').attr('colspan', '3');
	
}
function mobile_light_cart() {
	if ($(window).width() < 768) {
		$('.light-qty').each(function(){
			$(this).after($(this).find('.btn-danger'));
			$(this).parent().find('.btn-danger').removeClass('btn btn-danger').addClass('btn-link redcolor');
			$(this).parent().find('.btn-danger').remove();
		});
	}
}
mobile_light_cart();
// Cart Update
function LightCartUpdate() {
	$('#checkout-cart + .alert-summa').remove();

    $.ajax({
        url: 'index.php?route=lightcheckout/cart/edit',
        type: 'post',
        data: $('#light-cart input[name^=\'quantity\']'),
        dataType: 'json',
        beforeSend: function() {
			$('#light-cart').addClass('lightloadingTop');
		},
		complete: function(json) {
			$.ajax({
				url: 'index.php?route=lightcheckout/cart&updatecart=1',
				dataType: 'html',
				beforeSend: function() {
					
				},
				complete: function() {
					$('#light-cart').removeClass('lightloadingTop');
					LightCheckoutConfirm();
					mobile_light_cart();
				},
				success: function(html) {

					$('#light-cart').empty();
					
					$('#light-cart').html(html);

				},
				error: function(xhr, ajaxOptions, thrownError) {
					/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
				}
			});
			
		},
        success: function(json) {
			if (json['total']) {
				$.each(["#cart-total", "#cart_total", "#menu_wrap #cart-total", "#cart_menu .s_grand_total", "#cart .tb_items", "#cart .tb_total", "button#cart.fm-menu-cart-box.d-flex.align-items-center", "button.us-cart-img"], function(index, id) {
					$(id).html(json['total']);
				});
				<?php if ($htmls_js) { ?>
					<?php echo $htmls_js; ?>
					/*$('#cart > ul').load('index.php?route=common/cart/info ul li');*/
				<?php } ?>
				if (json['theme']){
					LightcheckoutThemes(json['theme'], json['total']);
				}
			}
            if (json['location']){
				location = 'index.php?route=checkout/cart';
			}
        },
        error: function(xhr, ajaxOptions, thrownError) {
            /*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
        }
    });
}
function LightCartRemove(key) {
    $.ajax({
		url: 'index.php?route=checkout/cart/remove',
		type: 'post',
		data: 'key=' + key,
		dataType: 'json',
		beforeSend: function() {
			$('#cart > button').button('loading');
		},
		complete: function() {
			$('#cart > button').button('reset');
		},
		success: function(json) {
			LightCartUpdate();
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
}
$(document).on('change', 'input[name=\'account\']', function() {
	if ($('#collapse-payment-address').parent().find('.panel-heading .panel-title > *').is('a')) {
		if (this.value == 'register') {
			$('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_account; ?></a>');
		} else {
			$('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?></a>');
		}
	} else {
		if (this.value == 'register') {
			$('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_account; ?>');
		} else {
			$('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_address; ?>');
		}
	}
});
$(document).on('change', 'input[name=\'shipping_method\']', function() {
	LightShippingMethodSave('updatecart');	
});
$(document).on('change', 'input[name=\'payment_method\']', function() {
	LightPaymentMethodSave('updatecart');	
});

<?php if ($logged and isset($status['payment_address'])) { ?>
$(document).ready(function() {
    $.ajax({
        url: 'index.php?route=lightcheckout/payment_address',
        dataType: 'html',
        success: function(html) {
            $('#collapse-payment-separator-address .panel-body').html(html);

			$('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');

			$('a[href=\'#collapse-payment-address\']').trigger('click');
        },
        error: function(xhr, ajaxOptions, thrownError) {
            /*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
        }
    });
});
<?php } ?>

// Checkout
function LightCheckout(name) {
    $.ajax({
        url: 'index.php?route=lightcheckout/' + name,
        dataType: 'html',
        beforeSend: function() {
        	$('#register-guest').addClass('lightloadingTop');
		},
        complete: function() {
			$('#register-guest').removeClass('lightloadingTop');
			LightAddBlock('login');
			
			/*if (Payment_Overlap_Shiping()) {
				$('#shipping-address').hide();
				<?php if ($shipping_required) { ?>
					LightMethodShipping();
				<?php } else { ?>
					LightMethodPayment();
				<?php } ?>
			} else {
				LightAddressShipping();
			}*/
        },
        success: function(html) {
            $('.alert-dismissible, .text-danger').remove();
			$('.form-group').removeClass('has-error');

            $('#collapse-payment-address .panel-body').html(html);
			
			<?php if (isset($status['payment_address'])) { ?>
				$('#collapse-payment-separator-address .panel-body').html(html);
				$('#collapse-payment-address #guest-account').remove();
				/*
				if ($('#collapse-payment-address > .panel-body > div').html() == undefined){
					$('a[href="#tab-register"]').parent().remove();
					$('#tab-register').remove();
					$('#light-tab li:first a').tab('show');
				}
				*/				
			<?php } ?>

			$('#collapse-payment-separator-address #register-account, #collapse-payment-separator-address #checkbox-confirm, #collapse-payment-address #register-fields').remove();
			if (name == 'register') {
				$('#tab-register > div > p').show();
			}
			if (name == 'guest') {
				$('.light-guest-help').remove();
				$('#tab-register > div > p').hide();
				if ($('#collapse-payment-address > .panel-body > div').html() == undefined){
					$('#collapse-payment-address > .panel-body').prepend('<span class="light-guest-help""><?php echo $text_empty_guest; ?></span>');
				}				
				DistributionWidth();
			}
			
			/*<?php if (isset($status['payment_address'])) { ?>
				$('#collapse-payment-address #guest-account').remove();
			<?php } ?>*/
        },
        error: function(xhr, ajaxOptions, thrownError) {
            /*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
        }
    });
}

<?php if (isset($status['alogin'])) { ?>
	$(document).ready(function() {
		$.ajax({
			url: 'index.php?route=lightcheckout/login',
			dataType: 'html',
			complete: function(html) {
			    <?php if (isset($status['alogin'])) { ?>
					<?php if ($fields['register']['show']) { ?>
						LightCheckout('register');
					<?php } elseif ($fields['guest']['show']) { ?>
						LightCheckout('guest');
					<?php } else { ?>
						LightAddBlock();
					<?php } ?>
				<?php } ?>				
			},
			success: function(html) {
			   $('#collapse-checkout-option').html(html);

				$('#collapse-checkout-option').parent().find('.panel-heading .panel-title').html('<a data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_option; ?> <i class="fa fa-caret-down"></i></a>');

				$('a[href=\'#collapse-checkout-option\']').trigger('click');

			},
			error: function(xhr, ajaxOptions, thrownError) {
				/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
			}
		});
	});
<?php } ?>

// Status Block
<?php if (isset($status['alogin'])) { ?>
	$('#accordion').addClass('lightloading');
<?php } else { ?>
	LightAddBlock();
<?php } ?>
function LightAddBlock(check){
	// if Status 
		<?php if (isset($status['payment_address'])) { ?>
			if (check == 'login') {
				<?php if (isset($status['payment_method'])) { ?>LightMethodPayment();<?php } ?>
			} else {
				LightPaymentAddress();
			}
		<?php } ?>
		<?php if (isset($status['shipping']) and $shipping_required) { ?>
			if (Payment_Overlap_Shiping()) {
				$('#shipping-address').hide();
				LightMethodShipping();
			} else {
				LightAddressShipping();
			}		
		<?php } ?>
	// ELSE Status 
		<?php if (!isset($status['payment_address'])) { ?>
			<?php if (isset($status['payment_method'])) { ?>
				LightMethodPayment();
			<?php } ?>
		<?php } ?>
		<?php if (!isset($status['shipping'])) { ?>
			<?php if (isset($status['shipping_method']) and $shipping_required) { ?>
				LightMethodShipping();
			<?php } ?>
		<?php } ?>
	// END Status
	if (check == 'login') {
		<?php if ((!isset($status['shipping']) or !$shipping_required) and !isset($status['payment_method']) and !isset($status['shipping_method'])) { ?>
			LightCheckoutConfirm();
		<?php } ?>
	}
}
$(document).delegate('input[name=\'account\']', 'change', function(){
	LightCheckout($(this).val());
});
$(document).delegate('select[name=\'shipping_zone_id\']', 'change', function(){
	LightMethodShipping($(this).val(), $('#collapse-shipping-address select[name=\'shipping_country_id\']').val());
	if ($('select[name=\'light_zone_id\']').html() == undefined) {
		LightMethodPayment($(this).val(), $('#collapse-shipping-address select[name=\'shipping_country_id\']').val());
	}
});
$(document).delegate('select[name=\'light_zone_id\']', 'change', function(){
	LightMethodPayment($(this).val(), $('#collapse-payment-separator-address select[name=\'light_country_id\']').val());
	if ($('select[name=\'shipping_zone_id\']').html() == undefined) {
		LightMethodShipping($(this).val(), $('#collapse-payment-separator-address select[name=\'light_country_id\']').val());
	}
});
function Payment_Overlap_Shiping(){
	var shipping_address_option = $('input[name=\'shipping_address\']:checked').prop('value');
	if (shipping_address_option  == 1) {
		localStorage.setItem('shipping_address', false);
		return shipping_address_option;
	} else {
		localStorage.setItem('shipping_address', '');
	}
	
	var shipping_address_option_shipping = $('input[name=\'shipping_address_shipping\']:checked').prop('value');
	if (shipping_address_option_shipping  == 1) {
		localStorage.setItem('shipping_address', false);
		return shipping_address_option_shipping;
	}
}
<?php if ($shipping_required) { ?>
$(document).delegate('#collapse-payment-address input[name=\'shipping_address\']', 'change', function(){
    if (Payment_Overlap_Shiping()) {
		$('#shipping-address').hide();
		localStorage.setItem('shipping_address', false);
		LightMethodShipping($('#collapse-payment-separator-address select[name=\'light_zone_id\']').val(), $('#collapse-payment-separator-address select[name=\'light_country_id\']').val());
	} else {
		localStorage.setItem('shipping_address', '');
		LightAddressShipping();
	}
});
$(document).delegate('#collapse-payment-separator-address input[name=\'shipping_address\']', 'change', function(){
    if (Payment_Overlap_Shiping()) {
		$('#shipping-address').hide();
		localStorage.setItem('shipping_address', false);
		LightMethodShipping($('#collapse-payment-separator-address select[name=\'light_zone_id\']').val(), $('#collapse-payment-separator-address select[name=\'light_country_id\']').val());
	} else {
		localStorage.setItem('shipping_address', '');
		LightGuestShipping();
	}
});
<?php } ?>
// Login
$(document).delegate('#button-login', 'click', function() {
    $.ajax({
        url: 'index.php?route=lightcheckout/login/save',
        type: 'post',
        data: $('#collapse-checkout-option :input'),
        dataType: 'json',
        beforeSend: function() {
        	$('#button-login').button('loading');
		},
        complete: function() {
            $('#button-login').button('reset');
        },
        success: function(json) {
            $('.alert-dismissible, .text-danger').remove();
            $('.form-group').removeClass('has-error');

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                $('#tab-login').prepend('<div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

				// Highlight any found errors
				<?php if ($light) { ?>
					$('#tab-login input[name=\'email\']').parent().addClass('has-error');
					$('#tab-login input[name=\'password\']').parent().addClass('has-error');
				<?php } ?>
		   }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            /*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
        }
    });
});

function LightAddressShipping() {
	$.ajax({
		url: 'index.php?route=lightcheckout/shipping_address',
		dataType: 'html',
		beforeSend: function() {
        	$('#shipping-address').addClass('lightloadingTop');
			$('#shipping-address').show();
		},
        complete: function() {
			$('#shipping-address').removeClass('lightloadingTop');
			<?php if (isset($status['shipping_method']) and $shipping_required) { ?>LightMethodShipping();<?php } ?>
			<?php if (!isset($status['payment_method'])) { ?>LightCheckoutConfirm();<?php } ?>
        },
		success: function(html) {
			
			$('#collapse-shipping-address .panel-body').html(html);

			$('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?></a>');

			$('a[href=\'#collapse-shipping-address\']').trigger('click');

			$('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<?php if ($fields_shipping_methods['shipping_method']['name'][$language_id]) { ?><?php echo $fields_shipping_methods['shipping_method']['name'][$language_id]; ?><?php } else { ?><?php echo $text_checkout_shipping_method; ?><?php } ?>');
			$('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php if ($fields_payment_methods['payment_method']['name'][$language_id]) { ?><?php echo $fields_payment_methods['payment_method']['name'][$language_id]; ?><?php } else { ?><?php echo $text_checkout_payment_method; ?><?php } ?>');
			$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});		
}

function LightLoginOut() {
	$.ajax({
		url: 'index.php?route=lightaccount/logout',
		dataType: 'html',
		beforeSend: function() {
        	
		},
        complete: function() {
			LightCheckout('register');
			$('#collapse-checkout-option').show();
			
			$('#register-guest > .panel > ul > li').each(function(){
				if ($(this).hasClass('light-logged')) {
					$(this).removeClass('light-logged').addClass('light-not-logged');
				} else {
					$(this).removeClass('light-not-logged').addClass('light-logged');
				}	
				$('#register-guest .panel ul').addClass('padding-bottom-0');
				$('#register-guest').removeAttr('class').addClass('col-lg-5');
			});
        },
		success: function(html) {
			
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
}

function LightMethodShipping(shipping_zone_id, shipping_country_id) {
	var get_text = '';
	if (shipping_zone_id && shipping_country_id) {
		get_text = '&shipping_zone_id=' + shipping_zone_id + '&shipping_country_id=' + shipping_country_id;
	}
	$.ajax({
		url: 'index.php?route=lightcheckout/shipping_method',
		dataType: 'html',
        type: 'post',
		data: get_text,
		beforeSend: function() {
        	$('#shipping_method').addClass('lightloadingTop');
		},
        complete: function() {
			$('#shipping_method').removeClass('lightloadingTop');
			if (shipping_zone_id && shipping_country_id) {
				if (Payment_Overlap_Shiping()) {
					LightMethodPayment(shipping_zone_id, shipping_country_id);
				}
			} else {
				<?php if (!isset($status['payment_method'])) { ?>
					LightCheckoutConfirm();
				<?php } ?>
			}
			/*setTimeout(function(){
				$('input[name=\'shipping_method\']:checked').trigger('change');
			}, 0);*/
        },
		success: function(html) {
			$('#collapse-shipping-method .panel-body').html(html);

			$('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<a data-parent="#accordion" class="accordion-toggle"><?php if ($fields_shipping_methods['shipping_method']['name'][$language_id]) { ?><?php echo $fields_shipping_methods['shipping_method']['name'][$language_id]; ?><?php } else { ?><?php echo $text_checkout_shipping_method; ?><?php } ?></a>');

			$('a[href=\'#collapse-shipping-method\']').trigger('click');

			$('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php if ($fields_payment_methods['payment_method']['name'][$language_id]) { ?><?php echo $fields_payment_methods['payment_method']['name'][$language_id]; ?><?php } else { ?><?php echo $text_checkout_payment_method; ?><?php } ?>');
			$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
			
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
	
}

function LightMethodPaymentAddress(address_id){
	$.ajax({
		url: 'index.php?route=lightcheckout/payment_method/accountaddress',
		type: 'post',
		data: '&address_id=' + address_id,
		dataType: 'json',
		beforeSend: function() {
        	
		},
        complete: function(json) {
			LightMethodPayment(false, false, 'address_id');
        },
		success: function(html) {
			
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
}

function LightMethodShippingAddress(address_id){
	$.ajax({
		url: 'index.php?route=lightcheckout/shipping_method/accountaddress',
		type: 'post',
		data: '&address_id=' + address_id,
		dataType: 'json',
		beforeSend: function() {
        	
		},
        complete: function(json) {
			LightMethodShipping(false, false, 'address_id');
        },
		success: function(html) {
			
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
}

function LightMethodPayment(payment_zone_id, payment_country_id) {
	var get_text = '';
	if (payment_zone_id && payment_country_id) {
		get_text = '&zone_id=' + payment_zone_id + '&country_id=' + payment_country_id;
	}
	$.ajax({
		url: 'index.php?route=lightcheckout/payment_method',
		dataType: 'html',
		type: 'post',
		data: get_text,
		beforeSend: function() {
        	$('#payment-method').addClass('lightloadingTop');
		},
        complete: function() {
			$('#payment-method').removeClass('lightloadingTop');
			if (payment_zone_id && payment_country_id) {} else {
				LightCheckoutConfirm();
			}
        },
		success: function(html) {
			$('#collapse-payment-method .panel-body').html(html);

			$('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a data-parent="#accordion" class="accordion-toggle"><?php if ($fields_payment_methods['payment_method']['name'][$language_id]) { ?><?php echo $fields_payment_methods['payment_method']['name'][$language_id]; ?><?php } else { ?><?php echo $text_checkout_payment_method; ?><?php } ?></a>');

			$('a[href=\'#collapse-payment-method\']').trigger('click');

			$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
}

function LightCheckoutConfirm() {
	$.ajax({
		url: 'index.php?route=lightcheckout/confirm',
		dataType: 'html',
		beforeSend: function() {
        	$('#collapse-checkout-confirm').addClass('lightloadingTop');
		},
		complete: function() {
			$('.lightloadingTop').removeClass('lightloadingTop');
			$('.lightloading').removeClass('lightloading');
		},
		success: function(html) {
			
			$('#collapse-checkout-confirm .panel-body').html(html);

			$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<a data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_confirm; ?></a>');

			$('a[href=\'#collapse-checkout-confirm\']').trigger('click');
			
			$('#button-lightconfirm-false').attr('id', 'button-lightconfirm').removeAttr('disabled');

		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
}
function LightTop() {
	$('html, body').animate({ scrollTop: 0 }, 'slow');
}
function LightPaymentAddress() {
	$.ajax({
		url: 'index.php?route=lightcheckout/payment_address',
		dataType: 'html',
		complete: function() {
		},
		success: function(html) {
			$('#collapse-payment-separator-address .panel-body').html(html);

			$('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');
			
			LightMethodPayment();
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
}
// Register
function LightRegister(confirm) {
    $.ajax({
        url: 'index.php?route=lightcheckout/register/save',
        type: 'post',
        data: $('#collapse-checkout-option input[type=\'radio\']:checked,#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'password\'], #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address textarea, #collapse-payment-address select,#collapse-payment-separator-address input[type=\'text\'], #collapse-payment-separator-address input[type=\'date\'], #collapse-payment-separator-address input[type=\'datetime-local\'], #collapse-payment-separator-address input[type=\'time\'], #collapse-payment-separator-address input[type=\'password\'], #collapse-payment-separator-address input[type=\'hidden\'], #collapse-payment-separator-address input[type=\'checkbox\']:checked, #collapse-payment-separator-address input[type=\'radio\']:checked, #collapse-payment-separator-address textarea, #collapse-payment-separator-address select'),
        dataType: 'json',
        beforeSend: function() {
			$('#button-lightconfirm').button('reset');
		},
		complete: function() {
			setTimeout(function() {
				/*$('#collapse-payment-address #register-account,#collapse-payment-address #checkbox-confirm').remove();*/
			}, 0);			
		},
        success: function(json) {
            $('.alert-dismissible, #collapse-payment-separator-address .text-danger').remove();
            $('#collapse-payment-separator-address .form-group').removeClass('has-error');

            if (json['redirect']) {
                /*location = json['redirect'];*/
            } else if (json['error']) {

                if (json['error']['warning']) {
                    $('#collapse-payment-address .panel-body').prepend('<div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

				for (i in json['error']) {
					var element = $('#input-payment-' + i.replace('_', '-'));

					if ($(element).parent().hasClass('input-group')) {
						$(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
					} else {
						$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
					}
				}

				// Highlight any found errors
				<?php if ($light) { ?>
					$('.text-danger').parent().addClass('has-error');
					$('#collapse-payment-separator-address .text-danger').parent().addClass('has-error');
				<?php } ?>
				$('#collapse-payment-method').removeClass('lightloadingTop');
				$('#accordion').removeClass('lightloading');
            } else {
				
				if (confirm != 'confirm') {
					LightPaymentAddress();
				}
            }
			if (!json['error']){
				if (confirm == 'confirm') {
					<?php if ($shipping_required and isset($status['shipping'])) { ?>
						LightShippingAddressSave(confirm);
					<?php } else { ?>
						<?php if (isset($status['shipping_method']) and $shipping_required) { ?>
							LightShippingMethodSave(confirm);
						<?php } elseif (isset($status['payment_method'])) { ?>
							LightPaymentMethodSave(confirm);
						<?php } else { ?>
							LightConfirmSave();
						<?php } ?>
					<?php } ?>
				}
			}
        },
        error: function(xhr, ajaxOptions, thrownError) {
			
			<?php if ($shipping_required) { ?>
			
                var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').prop('value');

                if (shipping_address) {
                    $.ajax({
                        url: 'index.php?route=lightcheckout/shipping_method',
                        dataType: 'html',
                        success: function(html) {
							// Add the shipping address
                            $.ajax({
                                url: 'index.php?route=lightcheckout/shipping_address',
                                dataType: 'html',
                                success: function(html) {
                                    $('#collapse-shipping-address .panel-body').html(html);

									$('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');
									
									LightPaymentAddressSave('confirm');
                                },
                                error: function(xhr, ajaxOptions, thrownError) {
                                    /*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
                                }
                            });

							$('#collapse-shipping-method .panel-body').html(html);

							$('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<a data-parent="#accordion" class="accordion-toggle"><?php if ($fields_shipping_methods["shipping_method"]["name"][$language_id]) { ?><?php echo $fields_shipping_methods["shipping_method"]["name"][$language_id]; ?><?php } else { ?><?php echo $text_checkout_shipping_method; ?><?php } ?> <i class="fa fa-caret-down"></i></a>');

   							$('a[href=\'#collapse-shipping-method\']').trigger('click');

							$('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<?php if ($fields_shipping_methods["shipping_method"]["name"][$language_id]) { ?><?php echo $fields_shipping_methods["shipping_method"]["name"][$language_id]; ?><?php } else { ?><?php echo $text_checkout_shipping_method; ?><?php } ?>');
							$('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php if ($fields_payment_methods["payment_method"]["name"][$language_id]) { ?><?php echo $fields_payment_methods["payment_method"]["name"][$language_id]; ?><?php } else { ?><?php echo $text_checkout_payment_method; ?><?php } ?>');
							$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
							
							
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            /*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
                        }
                    });
                } else {
                    
                }
            <?php } else { ?>
                
			<?php } ?>
			
            /*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
        }
    });
}

// Payment Address
function LightPaymentAddressSave() {
    $.ajax({
        url: 'index.php?route=lightcheckout/payment_address/save',
        type: 'post',
        data: $('#collapse-payment-separator-address input[type=\'text\'], #collapse-payment-separator-address input[type=\'date\'], #collapse-payment-separator-address input[type=\'datetime-local\'], #collapse-payment-separator-address input[type=\'time\'], #collapse-payment-separator-address input[type=\'password\'], #collapse-payment-separator-address input[type=\'checkbox\']:checked, #collapse-payment-separator-address input[type=\'radio\']:checked, #collapse-payment-separator-address input[type=\'hidden\'], #collapse-payment-separator-address textarea, #collapse-payment-separator-address select'),
        dataType: 'json',
        beforeSend: function() {
        	
		},
        complete: function() {
			
        },
        success: function(json) {
            $('.alert-dismissible, .text-danger').remove();
			$('.form-group').removeClass('has-error');

            if (json['redirect']) {
                /*location = json['redirect'];*/
            } else if (json['error']) {
				$('#button-lightconfirm').button('reset');
                if (json['error']['warning']) {
                    $('#collapse-payment-separator-address .panel-body').prepend('<div class="alert alert-warning alert-dismissible">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

				for (i in json['error']) {
					var element = $('#input-payment-' + i.replace('_', '-'));

					if ($(element).parent().hasClass('input-group')) {
						$(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
					} else {
						$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
					}
				}

				// Highlight any found errors
				<?php if ($light) { ?>
					$('.text-danger').parent().addClass('has-error');
				<?php } ?>
				$('#collapse-payment-method').removeClass('lightloadingTop');
				$('#accordion').removeClass('lightloading');
            } else {
				<?php if (isset($status['shipping']) and $shipping_required) { ?>
					LightShippingAddressSave('confirm');
				<?php } elseif (isset($status['shipping_method']) and $shipping_required) { ?>
					LightShippingMethodSave('confirm');
				<?php } elseif (isset($status['payment_method'])) { ?>
					LightPaymentMethodSave('confirm');
				<?php } else { ?>
					LightConfirmSave();
				<?php } ?>
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            /*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
        }
    });
}

// Shipping Address Save
function LightShippingAddressSave(confirm) {
	var data_payment_separator_address = ', #collapse-payment-address input[type=\'text\'], #collapse-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'password\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address textarea, #collapse-payment-address select, #collapse-payment-separator-address input[type=\'text\'], #collapse-payment-separator-address input[type=\'date\'], #collapse-payment-separator-address input[type=\'datetime-local\'], #collapse-payment-separator-address input[type=\'time\'], #collapse-payment-separator-address input[type=\'password\'], #collapse-payment-separator-address input[type=\'checkbox\']:checked, #collapse-payment-separator-address input[type=\'radio\']:checked, #collapse-payment-separator-address textarea, #collapse-payment-separator-address select';
	
    $.ajax({
        url: 'index.php?route=lightcheckout/shipping_address/save',
        type: 'post',
        data: $('#collapse-shipping-address input[type=\'text\'], #collapse-shipping-address input[type=\'date\'], #collapse-shipping-address input[type=\'datetime-local\'], #collapse-shipping-address input[type=\'time\'], #collapse-shipping-address input[type=\'password\'], #collapse-shipping-address input[type=\'checkbox\']:checked, #collapse-shipping-address input[type=\'radio\']:checked, #collapse-shipping-address textarea, #collapse-shipping-address select, #collapse-shipping-address input[type=\'hidden\']' + data_payment_separator_address),
        dataType: 'json',
        beforeSend: function() {},
		complete: function() {},
        success: function(json) {
            $('.alert-dismissible, #collapse-shipping-address .text-danger').remove();
			$('#collapse-shipping-address .form-group').removeClass('has-error');

            if (json['redirect']) {
                /*location = json['redirect'];*/
            } else if (json['error']) {
				$('#button-lightconfirm').button('reset');
				var text_name_option = 'shipping';
				
				if (json['shipping_address']) {
					text_name_option = 'payment';
				}

                if (json['error']['warning']) {
                    $('#collapse-shipping-address .panel-body').prepend('<div class="alert alert-warning alert-dismissible">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

				for (i in json['error']) {
					var element = $('#input-' + text_name_option + '-' + i.replace('_', '-'));

					if ($(element).parent().hasClass('input-group')) {
						$(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
					} else {
						$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
					}
				}

				// Highlight any found errors				
				<?php if ($light) { ?>
					$('#collapse-shipping-address .text-danger').parent().addClass('has-error');
				<?php } ?>
				$('#collapse-payment-method').removeClass('lightloadingTop');
				$('#accordion').removeClass('lightloading');
            } else {
                if (confirm == 'confirm') {
					<?php if (isset($status['shipping_method']) and $shipping_required) { ?>
						LightShippingMethodSave(confirm);
					<?php } elseif (isset($status['payment_method'])) { ?>
						LightPaymentMethodSave('confirm');
					<?php } else { ?>
						LightConfirmSave();
					<?php } ?>
				}
				
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            /*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
        }
    });
}

function GuestSave() {
    $.ajax({
        url: 'index.php?route=lightcheckout/guest/save',
        type: 'post',
        data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address textarea, #collapse-payment-address select, #collapse-payment-separator-address input[type=\'text\'], #collapse-payment-separator-address input[type=\'date\'], #collapse-payment-separator-address input[type=\'datetime-local\'], #collapse-payment-separator-address input[type=\'time\'], #collapse-payment-separator-address input[type=\'checkbox\']:checked, #collapse-payment-separator-address input[type=\'radio\']:checked, #collapse-payment-separator-address input[type=\'hidden\'], #collapse-payment-separator-address textarea, #collapse-payment-separator-address select'),
        dataType: 'json',
        beforeSend: function() {
       		
	    },
		complete: function() {
       		
	    },
        success: function(json) {
            $('.alert-dismissible, .text-danger').remove();
			$('.form-group').removeClass('has-error');

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                $('#button-lightconfirm').button('reset');
                if (json['error']['warning']) {
                    $('#collapse-payment-separator-address .panel-body').prepend('<div class="alert alert-warning alert-dismissible">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

				for (i in json['error']) {
					var element = $('#input-payment-' + i.replace('_', '-'));

					if ($(element).parent().hasClass('input-group')) {
						$(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
					} else {
						$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
					}
				}

				// Highlight any found errors
				<?php if ($light) { ?>
					$('.text-danger').parent().addClass('has-error');
				<?php } ?>
				$('#collapse-payment-method').removeClass('lightloadingTop');
				$('#accordion').removeClass('lightloading');
            } else {
                <?php if ($shipping_required) { ?>
					/*if (json['no_shipping_address']) {
						LightGuestShipping();
					}*/
                    /*LightGuestShippingSave();*/
                <?php } else { ?>
					LightPaymentMethodSave();
                <?php } ?>				
				<?php if ($shipping_required and isset($status['shipping'])) { ?>
					LightGuestShippingSave();
				<?php } else { ?>
					/*
					<?php if (isset($status['payment_address'])) { ?>
						LightPaymentAddressSave();
					<?php } elseif (isset($status['payment_method'])) { ?>
						LightPaymentMethodSave(confirm);
					<?php } else { ?>
						LightConfirmSave();
					<?php } ?>
					*/
					<?php if (isset($status['shipping_method'])) { ?>
						LightShippingMethodSave('confirm');
					<?php } elseif (isset($status['payment_method'])) { ?>
						LightPaymentMethodSave('confirm');
					<?php } else { ?>
						LightConfirmSave();
					<?php } ?>					
				<?php } ?>
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            /*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
        }
    });
}
function LightGuestShipping() {
	$.ajax({
		url: 'index.php?route=lightcheckout/guest_shipping',
		dataType: 'html',
		success: function(html) {
			$('#collapse-shipping-address .panel-body').html(html);
			
			$('#shipping-address').show();

			$('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
}
// Guest Shipping Save
function LightGuestShippingSave() {
	var data_payment_separator_address = ', #collapse-payment-address input[type=\'text\'], #collapse-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'password\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address textarea, #collapse-payment-address select, #collapse-payment-separator-address input[type=\'text\'], #collapse-payment-separator-address input[type=\'date\'], #collapse-payment-separator-address input[type=\'datetime-local\'], #collapse-payment-separator-address input[type=\'time\'], #collapse-payment-separator-address input[type=\'password\'], #collapse-payment-separator-address input[type=\'checkbox\']:checked, #collapse-payment-separator-address input[type=\'radio\']:checked, #collapse-payment-separator-address textarea, #collapse-payment-separator-address select';
    $.ajax({
        url: 'index.php?route=lightcheckout/guest_shipping/save',
        type: 'post',
        data: $('#collapse-shipping-address input[type=\'text\'], #collapse-shipping-address input[type=\'date\'], #collapse-shipping-address input[type=\'datetime-local\'], #collapse-shipping-address input[type=\'time\'], #collapse-shipping-address input[type=\'password\'], #collapse-shipping-address input[type=\'checkbox\']:checked, #collapse-shipping-address input[type=\'radio\']:checked, #collapse-shipping-address textarea, #collapse-shipping-address select' + data_payment_separator_address),
        dataType: 'json',
        beforeSend: function() {
        	
		},
        success: function(json) {
            $('.alert-dismissible, .text-danger').remove();
			$('.form-group').removeClass('has-error');

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
				$('#button-lightconfirm').button('reset');
                if (json['error']['warning']) {
                    $('#collapse-shipping-address .panel-body').prepend('<div class="alert alert-danger alert-dismissible">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

				for (i in json['error']) {
					var element = $('#input-shipping-' + i.replace('_', '-'));

					if ($(element).parent().hasClass('input-group')) {
						$(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
					} else {
						$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
					}
				}

				// Highlight any found errors
				<?php if ($light) { ?>
					$('.text-danger').parent().addClass('has-error');
				<?php } ?>
				$('#collapse-payment-method').removeClass('lightloadingTop');
				$('#accordion').removeClass('lightloading');
            } else {
                <?php if ($shipping_required and isset($status['shipping_method'])) { ?>			
					LightShippingMethodSave('confirm');
				<?php } elseif (isset($status['payment_method'])) { ?>
					LightPaymentMethodSave(confirm);
				<?php } else { ?>
					LightConfirmSave();
				<?php } ?>
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            /*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
        }
    });
}
function LightShippingMethodSave(confirm) {
	var updatecart = '';
	if (confirm == 'updatecart') {
		updatecart = '&updatecart=1';
	}
	$.ajax({
        url: 'index.php?route=lightcheckout/shipping_method/save' + updatecart,
        type: 'post',
        data: $('#collapse-shipping-method input[type=\'radio\']:checked, #collapse-shipping-method textarea'),
        dataType: 'json',
		beforeSend: function() {
			if (confirm == 'updatecart') {
				$('#accordion').addClass('lightloading');
			}
		},
		complete: function() {
        	if (confirm == 'updatecart') {
				LightCartUpdate();
			}
		},
        success: function(json) {
            $('.alert-dismissible, .text-danger').remove();

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
				$('#button-lightconfirm').button('reset');
                if (json['error']['warning']) {
                    $('#collapse-shipping-method .panel-body').prepend('<div class="alert alert-danger alert-dismissible">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }
				if (json['error']['comment']) {
					$('textarea#shipping-method').after('<div class="text-danger">' + json['error']['comment'] + '</div>');
				}
				$('#collapse-payment-method').removeClass('lightloadingTop');
				$('#accordion').removeClass('lightloading');
            } else {
                if (confirm == 'confirm') {
					<?php if (isset($status['payment_method'])) { ?>
						LightPaymentMethodSave(confirm);
					<?php } else { ?>
						LightConfirmSave();
					<?php } ?>
				}
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            /*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
        }
    });
}

function LightConfirmSave() {
	$.ajax({
		url: 'index.php?route=lightcheckout/confirm&save=1',
		dataType: 'html',
		complete: function() {},
		success: function(html) {
			$('#collapse-checkout-confirm .panel-body').html(html);

			$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<a data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_confirm; ?> <i class="fa fa-caret-down"></i></a>');

			$('a[href=\'#collapse-checkout-confirm\']').trigger('click');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
}
function LightPaymentMethodSave(confirm) {
	var updatecart = '';
	if (confirm == 'updatecart') {
		updatecart = '&updatecart=1';
	}
    $.ajax({
        url: 'index.php?route=lightcheckout/payment_method/save' + updatecart,
        type: 'post',
        data: $('#collapse-payment-method input[type=\'radio\']:checked, #collapse-payment-method input[type=\'checkbox\']:checked, #collapse-payment-method textarea'),
        dataType: 'json',
		beforeSend: function(json) {
			if (json['error']) {} else {
				$('#collapse-payment-method').addClass('lightloadingTop');
				$('#accordion').addClass('lightloading');
			}
			if (confirm == 'updatecart') {
				$('#accordion').addClass('lightloading');
			}
		},
		complete: function() {
        	if (confirm == 'updatecart') {
				LightCartUpdate();
			}
		},        
        success: function(json) {
            $('.alert-dismissible, .text-danger').remove();

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                $('#button-lightconfirm').button('reset');
                if (json['error']['warning']) {
                    $('#collapse-payment-method .panel-body').prepend('<div class="alert alert-danger alert-dismissible">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }
				if (json['error']['comment']) {
				$('textarea#payment-method').after('<div class="text-danger">' + json['error']['comment'] + '</div>');
				}
				$('#collapse-payment-method').removeClass('lightloadingTop');
				$('#accordion').removeClass('lightloading');
            } else {
				if (confirm != 'updatecart') {
					LightConfirmSave();
				}
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            /*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
        }
    });
}
LightcheckoutThemesJs('<?php echo $theme; ?>');
//--></script>
<style>
<?php if (!$error) { ?>
	.text-danger {
		display: none;
	}
<?php } ?>
</style>
<?php echo $footer; ?>