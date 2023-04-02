<?php if ($error_warning) { ?>
<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($payment_methods) { ?>
<p><?php echo $text_payment_method; ?></p>
<?php foreach ($payment_methods as $payment_method) { ?>
<div class="radio">
  <label>
    <?php if ($payment_method['code'] == $code || !$code) { ?>
    <?php $code = $payment_method['code']; ?>
    <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" checked="checked" />
    <?php } else { ?>
    <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" />
    <?php } ?>
	<?php if (isset($fields[$payment_method['code']]['name'][$language_id]) && $fields[$payment_method['code']]['name'][$language_id]) { ?>
		<?php echo $fields[$payment_method['code']]['name'][$language_id]; ?>
	<?php } else { ?>
		<?php echo $payment_method['title']; ?>
	<?php } ?>
    <?php if ($payment_method['terms'] and !isset($fields[$payment_method['code']]['name'][$language_id])) { ?>
    (<?php echo $payment_method['terms']; ?>)
    <?php } ?> </label>
</div>
<?php } ?>
<?php } ?>
<?php if ($fields['payment_comment']['show']) { ?>
<div<?php if ($fields['payment_comment']['required']) { ?> class="required"<?php } ?>>
<label class="control-label"><strong><?php if ($fields['payment_comment']['name'][$language_id]) { ?><?php echo $fields['payment_comment']['name'][$language_id]; ?><?php } else { ?><?php echo $text_comments; ?><?php } ?></strong></label>
<p>
  <textarea name="comment" rows="5" class="form-control" id="payment-method"><?php echo $comment; ?></textarea>
</p>
</div>
<?php } ?>
<?php if ($text_agree) { ?>
<div class="buttons">
  <div class="pull-right">
    <?php if ($agree) { ?>
    <input type="checkbox" name="payment_agree" value="1" checked="checked" />
    <?php } else { ?>
    <input type="checkbox" name="payment_agree" value="1" />
    <?php } ?>
    &nbsp;
    <?php echo $text_agree; ?>
  </div><div class="clearfix"></div>
</div>
<?php } ?>