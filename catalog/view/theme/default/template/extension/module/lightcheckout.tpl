<?php echo $header; ?>
<div id="checkout-checkout" class="container">
  <?php if ($heading_title_light_empty) { ?>
  <noindex><div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> <?php echo $heading_title_light_empty; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div></noindex>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left or $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <noindex><span class="panel-title"><?php echo $error_title_light_empty; ?></span><br /><br /></noindex>
      <div class="panel-group" id="accordion">
        <div class="panel panel-default">
          <div class="panel-heading">
            <noindex><span><?php echo $help_title_light_empty; ?></span><br /></noindex>
          </div>
          <div class="panel-collapse collapse" id="collapse-checkout-option">
            <div class="panel-body"></div>
          </div>
        </div>
      </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>