<?php if ($error_warning) { ?>
<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($shipping_methods) { ?>
<p><?php echo $text_shipping_method; ?></p>
<?php foreach ($shipping_methods as $key => $shipping_method) { ?>
<p><strong><?php echo $shipping_method['title']; ?></strong></p>
<?php if (!$shipping_method['error']) { ?>
<?php foreach ($shipping_method['quote'] as $quote) { ?>
<div class="radio">
  <label>
	<?php if ($quote['code'] == $code || !$code) { ?>
    <?php $code = $quote['code']; ?>
    <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" checked="checked" />
    <?php } else { ?>
    <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" />
    <?php } ?>
	<?php if (isset($fields[$key]['name'][$language_id])) { ?>
		<?php echo $fields[$key]['name'][$language_id]; ?>
	<?php } else { ?>
		<?php echo $quote['title']; ?>
	<?php } ?>
     - <?php echo $quote['text']; ?></label>
</div>
<?php } ?>
<?php } else { ?>
<div class="alert alert-danger alert-dismissible"><?php echo $shipping_method['error']; ?></div>
<?php } ?>
<?php } ?>
<?php } ?>
<?php if ($fields['shipping_comment']['show']) { ?>
<div<?php if ($fields['shipping_comment']['required']) { ?> class="required"<?php } ?>>
	<label class="control-label"><strong><?php if ($fields['shipping_comment']['name'][$language_id]) { ?><?php echo $fields['shipping_comment']['name'][$language_id]; ?><?php } else { ?><?php echo $text_comments; ?><?php } ?></strong></label>
	<p>
	  <textarea name="comment" rows="3" class="form-control" id="shipping-method"><?php echo $comment; ?></textarea>
	</p>
</div>
<?php } ?>
