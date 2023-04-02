  <?php if ($fields['register']['show'] or $fields['guest']['show'] or $fields['alogged']['show']) { ?>
  <div class="tab-pane active" id="tab-register">
	<div<?php if ($fields['register']['show'] and $fields['guest']['show']) { ?><?php } else { ?> class="light-hide"<?php } ?>>
	  <div class="radio">
	  <label> <?php if ($account == 'register') { ?>
		<input type="radio" name="account" value="register" checked="checked" />
		<?php } else { ?>
		<input type="radio" name="account" value="register" />
		<?php } ?>
		<?php if ($fields['register']['name'][$language_id]) { ?><?php echo $fields['register']['name'][$language_id ]; ?><?php } else { ?><?php echo $text_register; ?><?php } ?></label>
	  </div>
	  <?php if ($checkout_guest) { ?>
	  <div class="radio">
	    <label> <?php if ($account == 'guest' or !$fields['register']['show']) { ?>
		<input type="radio" name="account" value="guest" checked="checked" />
		<?php } else { ?>
		<input type="radio" name="account" value="guest" />
		<?php } ?>
		<?php if ($fields['guest']['name'][$language_id]) { ?><?php echo $fields['guest']['name'][$language_id]; ?><?php } else { ?><?php echo $text_guest; ?><?php } ?></label>
	  </div>
	  <?php } ?>
	  <p><?php echo $text_register_account; ?></p>
	</div>	
	<div class="panel-collapse" id="collapse-payment-address">
		<div class="panel-body"></div>
	</div>
  </div>
  <?php } ?>
  <?php if ($fields['alogged']['show']) { ?>
  <div class="tab-pane<?php if (!$fields['register']['show'] and !$fields['guest']['show']) { ?> active<?php } ?>" id="tab-login">
	<p><?php echo $text_i_am_returning_customer; ?></p>
	<div class="form-group">
	  <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
	  <input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
	</div>
	<div class="form-group">
	  <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
	  <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
	  <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></div>
	<input type="button" value="<?php echo $button_login; ?>" id="button-login" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary" />
  </div>
  <?php } ?>