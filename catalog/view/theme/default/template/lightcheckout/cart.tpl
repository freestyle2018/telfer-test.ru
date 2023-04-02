<?php if (!$updatecart) { ?>
<div id="checkout-cart" class="container">
  <?php if ($attention) { ?>
  <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="alert alert-success alert-dismissible"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="row">
    <div class="col-sm-12">
      <div class="row">
<?php } ?>
      <div id="light-cart"><div class="panel panel-default">
		<?php if (isset($error_close)) { ?><div class="alert alert-danger alert-summa"><i class="fa fa-check-circle"></i> <?php echo $error_close; ?><button data-dismiss="alert" class="close" type="button">×</button></div><?php } ?>
		<?php if (isset($error_warning)) { ?>
		  <div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		  </div>
		<?php } ?>
		<div class="panel-heading">
			<h4 class="panel-title"><a class="accordion-toggle" data-parent="#accordion"><?php echo $heading_title_cart; ?><?php if ($weight) { ?>&nbsp;(<?php echo $weight; ?>)<?php } ?></a></h4>
		</div>		
        <div class="table-responsive panel-collapse">
		  <div class="panel-body">
          <table class="table table-bordered">
            <thead>
              <tr>
                <td class="text-center hidden-xs"><?php echo $column_image; ?></td>
                <td class="text-left"><?php echo $column_name; ?></td>
                <td class="text-center"><?php echo $column_quantity; ?></td>
                <td class="text-right"><?php echo $column_price; ?></td>
                <td class="text-right"><?php echo $column_total; ?></td>
              </tr>
            </thead>
            <tbody>
            <?php foreach ($products as $product) { ?>
            <tr>
              <td class="text-center hidden-xs"><?php if ($product['thumb']) { ?> <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" /></a> <?php } ?></td>
              <td class="text-left"><?php if (!$product['stock']) { ?><span class="text-danger">***</span> <?php } ?> <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail visible-xs" /><?php echo $product['name']; ?></a> 
			  
			  <br /><span class="light-gray"><?php echo $column_model; ?>: <?php echo $product['model']; ?></span>
                <?php if ($product['option']) { ?>
                <?php foreach ($product['option'] as $option) { ?> <br />
                <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small> <?php } ?>
                <?php } ?>
                <?php if ($product['reward']) { ?> <br />
                <small><?php echo $product['reward']; ?></small> <?php } ?>
                <?php if ($product['recurring']) { ?> <br />
                <span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small> <?php } ?></td>
              <td class="text-center">
			    <div class="input-group btn-block light-qty" style="max-width: 200px;">
				  <?php if ($qty) { ?>
					<span class="input-group-btn">
					  <button type="submit" title="<?php echo $button_update; ?>" class="btn btn-light light-minus"><i class="fa fa-minus"></i></button>
					</span>
				  <?php } ?>
				  <input type="text" name="quantity[<?php echo $product['cart_id']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="form-control" id="light-qty"<?php if (!$qty) { ?> disabled="disabled"<?php } ?> />
				  <span class="input-group-btn">
					  <?php if ($qty) { ?>
					    <button type="submit" title="<?php echo $button_update; ?>" class="btn btn-light light-plus"><i class="fa fa-plus"></i></button>
					  <?php } ?>
					  <button type="button" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="LightCartRemove('<?php echo $product['cart_id']; ?>');"><i class="fa fa-times-circle"></i> <span class="visible-xs-inline-block"><?php echo $button_remove; ?></span></button>
				  </span>
				</div></td>
              <td class="text-right"><?php echo $product['price']; ?></td>
              <td class="text-right"><?php echo $product['total']; ?></td>
            </tr>
            <?php } ?>
            <?php foreach ($vouchers as $voucher) { ?>
            <tr>
              <td></td>
              <td class="text-left"><?php echo $voucher['description']; ?></td>
              <td class="text-left"></td>
              <td class="text-left"><div class="input-group btn-block" style="max-width: 200px;">
                  <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="voucher.remove('<?php echo $voucher['key']; ?>');"><i class="fa fa-times-circle"></i></button>
                  </span></div></td>
              <td class="text-right"><?php echo $voucher['amount']; ?></td>
              <td class="text-right"><?php echo $voucher['amount']; ?></td>
            </tr>
            <?php } ?>
			<?php foreach ($totals_cart as $total) { ?>
            <tr>
              <td colspan="4" class="text-right light-colspan"><strong><?php echo $total['title']; ?>:</strong></td>
              <td class="text-right"><?php echo $total['text']; ?></td>
            </tr>
            <?php } ?>
            </tbody>
          </table>
		  </div>
        </div>
        <div class="row">
		  <div class="col-sm-12">
			<div class="panel-group light-module-total<?php if ($modules_cart) { ?> col-sm-7<?php } else { ?> col-sm-12<?php } ?>" id="accordion">
		      <?php foreach ($modules as $module) { ?>
				  <?php echo $module; ?>
              <?php } ?>
			</div>
			<?php if ($modules_cart) { ?>
				<div class="col-sm-5<?php if (!$modules) { ?> col-sm-offset-7<?php } ?>">
				  <table class="table">
					  <?php foreach ($modules_cart as $key => $module) { ?>
						<?php if ($key == 'coupon') { ?>
						  <tr>
							<td class="input-group light-td"><input type="text" name="coupon" value="<?php echo $coupon; ?>" placeholder="<?php echo $entry_lightcoupon; ?>" id="input-coupon" class="form-control" />
							<span class="input-group-btn">
								<input type="button" value="<?php echo $entry_lightapply; ?>" id="button-coupon" data-loading-text="<?php echo $text_loading; ?>"  class="btn btn-primary" />
							</span></td>
						  </tr>
						<?php } ?>
						<?php if ($key == 'voucher') { ?>
						  <tr>
							<td class="input-group light-td"><input type="text" name="voucher" value="<?php echo $voucher; ?>" placeholder="<?php echo $entry_lightvoucher; ?>" id="input-voucher" class="form-control" />
							<span class="input-group-btn">
							  <input type="submit" value="<?php echo $entry_lightapply; ?>" id="button-voucher" data-loading-text="<?php echo $text_loading; ?>"  class="btn btn-primary" />
							</span></td>
						  </tr>
						<?php } ?>
						<?php if ($key == 'reward') { ?>
						  <tr>
							<td class="input-group light-td"><input type="text" name="reward" value="<?php echo $reward; ?>" placeholder="<?php echo $entry_lightreward; ?>" id="input-reward" class="form-control" />
							<span class="input-group-btn">
							  <input type="submit" value="<?php echo $entry_lightapply; ?>" id="button-reward" data-loading-text="<?php echo $text_loading; ?>"  class="btn btn-primary" />
							</span></td>
						  </tr>
						<?php } ?>
					  <?php } ?>
				  </table>
				</div>
			<?php } ?>
		  </div>
        </div>
	  </div></div>
<?php if (!$updatecart) { ?>
	  </div>
	  </div>
    </div>
</div>
<?php } ?>
<script type="text/javascript"><!--
$('.light-qty .light-minus').click(function () {
	var $input = $(this).parent().parent().find('#light-qty');
	var count = parseInt($input.val()) - 1;
	count = count < 1 ? 1 : count;
	$input.val(count);
	$input.change();
	LightCartUpdate();
	return false;
});
$('.light-qty .light-plus').click(function () {
	var $input = $(this).parent().parent().find('#light-qty');
	$input.val(parseInt($input.val()) + 1);
	$input.change();
	LightCartUpdate();
	return false;
});
<?php if (isset($error_close)) { ?>
	localStorage.setItem('error_close', true);
<?php } else { ?>
	localStorage.setItem('error_close', '');
<?php } ?>
<?php if (isset($error_warning)) { ?>
	localStorage.setItem('error_warning', true);
<?php } else { ?>
	localStorage.setItem('error_warning', '');
<?php } ?>
$('#button-coupon').on('click', function() {
	$.ajax({
		url: 'index.php?route=extension/total/coupon/coupon',
		type: 'post',
		data: 'coupon=' + encodeURIComponent($('input[name=\'coupon\']').val()),
		dataType: 'json',
		beforeSend: function() {
			$('#button-coupon').button('loading');
		},
		complete: function() {
			$('#button-coupon').button('reset');
		},
		success: function(json) {
			$('.alert-dismissible').remove();

			if (json['error']) {
				$('.breadcrumb').after('<div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			} else {
				LightCartUpdate();
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
});
$('#button-voucher').on('click', function() {
	$.ajax({
		url: 'index.php?route=extension/total/voucher/voucher',
		type: 'post',
		data: 'voucher=' + encodeURIComponent($('input[name=\'voucher\']').val()),
		dataType: 'json',
		beforeSend: function() {
			$('#button-voucher').button('loading');
		},
		complete: function() {
			$('#button-voucher').button('reset');			
		},
		success: function(json) {
			$('.alert-dismissible').remove();
			
			if (json['error']) {
				$('.breadcrumb').after('<div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				
				$.ajax({
					url: 'index.php?route=lightcheckout/cart/voucheremptydelete',
					type: 'post',
					data: 'voucher=' + encodeURIComponent($('input[name=\'voucher\']').val()),
					dataType: 'json',
					complete: function() {
						LightCartUpdate();		
					},
					success: function(json) {},
					error: function(xhr, ajaxOptions, thrownError) {	}
				});
			} else {
				LightCartUpdate();
			}
			
			
			
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
});
$('#button-reward').on('click', function() {
	$.ajax({
		url: 'index.php?route=extension/total/reward/reward',
		type: 'post',
		data: 'reward=' + encodeURIComponent($('input[name=\'reward\']').val()),
		dataType: 'json',
		beforeSend: function() {
			$('#button-reward').button('loading');
		},
		complete: function() {
			$('#button-reward').button('reset');
		},
		success: function(json) {
			$('.alert-dismissible').remove();

			if (json['error']) {
				$('.breadcrumb').after('<div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				LightTop();
			} else {
				LightCartUpdate();				
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			/*alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	});
});
// Cart add remove functions
var cart = {
	'remove': function(key) {
		LightCartRemove(key);
	}
}
//--></script>