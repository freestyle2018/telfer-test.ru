<?php echo $header; ?>
<style>
  /*for screens with 1280px - 1440px*/
  @media (max-width: 1440px) {
    .col-sm-2 {
      width: 25%;
    }
  }
  fieldset {
    border: 1px solid #ccc;
    padding: 0 15px 15px 15px;
    margin-bottom: 30px;
    
  }
  
  fieldset legend {
    border-bottom: 0;
    padding-left: 15px;
    padding-right: 15px;
    width: auto;
    font-size: 18px;
  }
  
  .checkbox input {
    display: inline-block;
    margin-right: 7px;
  }
	
	.hidden-toggle {
    display: none;
  }
</style>
<?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-branched-sitemap" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($text_success) { ?>
    <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $text_success; ?>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-branched-sitemap" class="form-horizontal">
          <!-- Licence -->
          <?php if(!$valid_licence) { ?>
          <div class="form-group required" id="input-licence-wrapper">
            <label class="col-sm-2 control-label" for="input-licence"><?php echo $entry_licence; ?></label>
            <div class="col-sm-8">
              <input type="text" name="branched_sitemap_licence" value="<?php echo $branched_sitemap_licence; ?>" placeholder="<?php echo $entry_licence; ?>" id="input-licence" class="form-control" />
              <?php if (isset($errors['licence'])) { ?><div class="text-danger"><?php echo $errors['licence']; ?></div><?php } ?>
            </div>
            <div class="col-sm-2">
              <button id="save-licence" class="btn btn-danger"><?php echo $button_save_licence; ?></button>
            </div>
          </div>
          <?php } else { ?>
          <input type="hidden" name="branched_sitemap_licence" value="<?php echo $branched_sitemap_licence; ?>" id="input-licence" />
          <?php } ?>
          <div id="module-work-area" <?php echo !$valid_licence ? 'style="display: none;"' : ''; ?>>
						
						
						<!-- Main Setting
            =================================================================-->
            <fieldset>
              <legend><?php echo $fieldset_main; ?></legend>
							<!-- Status -->
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
								<div class="col-sm-2">
									<select name="branched_sitemap_status" id="input-status" class="form-control">
										<?php if ($branched_sitemap_status) { ?>
										<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										<option value="0"><?php echo $text_disabled; ?></option>
										<?php } else { ?>
										<option value="1"><?php echo $text_enabled; ?></option>
										<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<!-- System -->
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-system"><?php echo $entry_system; ?></label>
								<div class="col-sm-2">
									<select name="branched_sitemap_system" id="input-system" class="form-control">
										<?php	foreach ($systems as $system) { ?>
										<option value="<?php echo $system; ?>" <?php echo  $branched_sitemap_system == $system ? 'selected' : ''; ?>><?php echo $system; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<!-- Сachetime -->
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-cachetime"><?php echo $entry_cachetime; ?></label>
								<div class="col-sm-2">
									<select name="branched_sitemap_cachetime" id="input-cachetime" class="form-control">
										<?php	foreach ($cachetime_values as $cachetime_value) { ?>
										<option value="<?php echo $cachetime_value['value']; ?>" <?php echo $branched_sitemap_cachetime == $cachetime_value['value'] ? 'selected' : ''; ?>><?php echo $cachetime_value['text']; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<!-- Multishop -->
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-multishop"><?php echo $entry_multishop; ?></label>
								<div class="col-sm-2">
									<select name="branched_sitemap_multishop" id="input-multishop" class="form-control">
										<?php if ($branched_sitemap_multishop) { ?>
										<option value="1" selected="selected"><?php echo $text_yes; ?></option>
										<option value="0"><?php echo $text_no; ?></option>
										<?php } else { ?>
										<option value="1"><?php echo $text_yes; ?></option>
										<option value="0" selected="selected"><?php echo $text_no; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
						</fieldset>


            <!-- Feed
            =================================================================-->
            <fieldset>
              <legend><?php echo $fieldset_feed; ?></legend>
							
							<!-- Priority Category Level 1 -->
							
							<div class="form-group">
                
                <!-- Level 1 -->
                <label class="col-sm-2 control-label" for="input-priority-category-level-1" style="padding-top: 0;"><?php echo $entry_priority_category_level_1; ?></label>
                <div class="col-sm-1">
                  <select name="branched_sitemap_priority_category_level_1" id="input-priority-category-level-1" class="form-control">
										<?php	foreach ($a_priority_possible as $priority) { ?>
                    <option value="<?php echo $priority; ?>" <?php echo $branched_sitemap_priority_category_level_1 == $priority ? 'selected' : ''; ?>><?php echo $priority; ?></option>
                    <?php } ?>
                  </select>
                </div>
								
							</div>
							
							<!-- Priority Product -->
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-priority-product" style="padding-top: 0;"><?php echo $entry_priority_product; ?></label>
                <div class="col-sm-1">
                  <select name="branched_sitemap_priority_product" id="input-priority-product" class="form-control">
										<?php	foreach ($a_priority_possible as $priority) { ?>
                    <option value="<?php echo $priority; ?>" <?php echo $branched_sitemap_priority_product == $priority ? 'selected' : ''; ?>><?php echo $priority; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
							
							<!-- Priority Manufacturer -->
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-priority-manufacturer" style="padding-top: 0;"><?php echo $entry_priority_manufacturer; ?></label>
                <div class="col-sm-1">
                  <select name="branched_sitemap_priority_manufacturer" id="input-priority-manufacturer" class="form-control">
                    <?php	foreach ($a_priority_possible as $priority) { ?>
                    <option value="<?php echo $priority; ?>" <?php echo $branched_sitemap_priority_manufacturer == $priority ? 'selected' : ''; ?>><?php echo $priority; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
							
							<?php	if ($blog_are_present) { ?>
              <!-- Priority Blog -->
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-priority-blog" style="padding-top: 0;"><?php echo $entry_priority_blog; ?></label>
                <div class="col-sm-1">
                  <select name="branched_sitemap_priority_blog" id="input-priority-blog" class="form-control">
                    <?php	foreach ($a_priority_possible as $priority) { ?>
                    <option value="<?php echo $priority; ?>" <?php echo $branched_sitemap_priority_blog == $priority ? 'selected' : ''; ?>><?php echo $priority; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <?php } ?>
							
							<!-- Priority Other -->
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-priority-other" style="padding-top: 0;"><?php echo $entry_priority_other; ?></label>
                <div class="col-sm-1">
                  <select name="branched_sitemap_priority_other" id="input-priority-other" class="form-control">
                    <?php	foreach ($a_priority_possible as $priority) { ?>
                    <option value="<?php echo $priority; ?>" <?php echo $branched_sitemap_priority_other == $priority ? 'selected' : ''; ?>><?php echo $priority; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
							
							<!-- Feeds Urls -->
							<input type="hidden" name="branched_sitemap_url" value="<?php echo $branched_sitemap_url; ?>" class="form-control" id="input-branched-sitemap-url" />
							<?php foreach ($languages as $language) { ?>
              <input type="hidden" readonly="" name="branched_sitemap_lang_flags[<?php echo $language['language_id']; ?>]" value="<?php echo $branched_sitemap_lang_flags[$language['language_id']] ? $branched_sitemap_lang_flags[$language['language_id']] : ''; ?>" id="feed-lang-flags-<?php echo $language['language_id']; ?>" />
              <?php } ?>
              
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-data-feed"><?php echo $entry_data_feed; ?></label>
                <div class="col-sm-8">
                  <div id="feeds-urls">
										<?php foreach ($languages as $language) { ?>
                    <div class="input-group <?php echo $branched_sitemap_urls[$language['language_id']] ? '' : 'hidden'; ?>"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                      <input type="text" readonly="" name="branched_sitemap_urls[<?php echo $language['language_id']; ?>]" value="<?php echo $branched_sitemap_urls[$language['language_id']]; ?>" class="form-control"  id="feed-url-<?php echo $language['language_id']; ?>" />
                    </div>
										<?php } ?>
										<button class="btn <?php echo $sitemap_urls_are_defined ? 'btn-warning' : 'btn-success'; ?> btn-sm" id="set-sitemap"><?php echo $sitemap_urls_are_defined ? $rewrite_url_btn_2 : $rewrite_url_btn_1; ?></button>
                  </div>                
                </div>
              </div>
							
							<!-- Sitemapindex Status -->
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-sitemapindex-status"><span data-toggle="toggle" title="<?php echo $help_sitemapindex_status; ?>"><?php echo $entry_sitemapindex_status; ?></span></label>
                <div class="col-sm-2">
                  <select name="branched_sitemap_sitemapindex_status" id="input-sitemapindex-status" class="form-control">
                    <?php if ($branched_sitemap_sitemapindex_status) { ?> 
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?> 
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
							
							<!-- Limit -->
							<div class="form-group depends-on-sitemapindex <?php echo (!$branched_sitemap_sitemapindex_status) ? 'hidden-toggle' : ''; ?>">
								<label class="col-sm-2 control-label" for="input-limit"><span data-toggle="toggle" title="<?php echo $help_limit; ?>"><?php echo $entry_limit; ?></label>
								<div class="col-sm-2">
									<select name="branched_sitemap_limit" id="input-limit" class="form-control">
										<?php	foreach ($limits as $limit) { ?>
										<option value="<?php echo $limit; ?>" <?php echo $branched_sitemap_limit == $limit ? 'selected' : ''; ?>><?php echo $limit; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							
							<!-- Off Description -->
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-off_description" style="padding-top: 0;"><span data-toggle="toggle" title="<?php echo $help_off_description; ?>"><?php echo $entry_off_description; ?></span></label>
								<div class="col-sm-2">
									<select name="branched_sitemap_off_description" id="input-off_description" class="form-control">
										<?php if ($branched_sitemap_off_description) { ?>
										<option value="1" selected="selected"><?php echo $text_yes; ?></option>
										<option value="0"><?php echo $text_no; ?></option>
										<?php } else { ?>
										<option value="1"><?php echo $text_yes; ?></option>
										<option value="0" selected="selected"><?php echo $text_no; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							
							<?php if ($blog_are_present) { ?>
							<!-- Blogs -->
							<div class="form-group">
								<label class="col-sm-2 control-label"><?php echo $entry_blogs; ?></label>
								<div class="col-sm-4">
									<div class="well" style="max-height: 300px; overflow: auto;">
										<?php foreach ($blogs_possible as $key => $value) { ?>
										<div class="checkbox"><label><input type="checkbox" name="branched_sitemap_blogs[<?php echo $key; ?>]" value="1" <?php echo ($branched_sitemap_blogs[$key] == 1) ? 'checked="checked"' : ''; ?> /><?php echo $value; ?></label></div>
										<?php } ?>
									</div>
								</div>
							</div>
							<?php } ?>
							
            </fieldset>
						
						
						<!-- Feed With Image 
            =================================================================-->
            <fieldset>
              <legend><?php echo $fieldset_feed_image; ?></legend>
              <div class="row">
                <div class="col-sm-10"><div class="alert alert-info"><?php echo $alert_feed_image; ?></div></div>
              </div>
							
							<!-- Image Status -->
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-image-status"><?php echo $entry_image_status; ?></label>
                <div class="col-sm-2">
                  <select name="branched_sitemap_image_status" id="input-image-status" class="form-control">
                    <?php if ($branched_sitemap_image_status) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?> 
                  </select>
                </div>
              </div>
							
							<!-- Off Check Image File -->
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-off_check_image_file" style="padding-top: 0;"><span data-toggle="toggle" title="<?php echo $help_off_check_image_file; ?>"><?php echo $entry_off_check_image_file; ?></span></label>
								<div class="col-sm-2">
									<select name="branched_sitemap_off_check_image_file" id="input-off_check_image_file" class="form-control">
										<?php if ($branched_sitemap_off_check_image_file) { ?>
										<option value="1" selected="selected"><?php echo $text_yes; ?></option>
										<option value="0"><?php echo $text_no; ?></option>
										<?php } else { ?>
										<option value="1"><?php echo $text_yes; ?></option>
										<option value="0" selected="selected"><?php echo $text_no; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							
							<!-- WebP Status -->
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-webp-status"><span data-toggle="toggle" title="<?php echo $help_webp_status; ?>"><?php echo $entry_webp_status; ?></span></label>
                <div class="col-sm-2">
                  <select name="branched_sitemap_webp_status" id="input-webp-status" class="form-control">
                    <?php if ($branched_sitemap_webp_status) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
                  
							<!-- Require Image Caption -->
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-require_image_caption" style="padding-top: 0;"><span data-toggle="toggle" title="<?php echo $help_require_image_caption; ?>"><?php echo $entry_require_image_caption; ?></span></label>
								<div class="col-sm-2">
									<select name="branched_sitemap_require_image_caption" id="input-require_image_caption" class="form-control">
										<?php if ($branched_sitemap_require_image_caption) { ?>
										<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										<option value="0"><?php echo $text_disabled; ?></option>
										<?php } else { ?>
										<option value="1"><?php echo $text_enabled; ?></option>
										<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>						

            </fieldset>
            
          </div>
        </form>
      </div>
    </div>
    <div class="copywrite" style="padding: 10px 10px 0 10px; border: 1px dashed #ccc;">
    	<p>
    		&copy; <?php echo $text_author; ?>: <a href="https://bit.ly/3QVQqwd" target="_blank">Serge Tkach</a>
    		<br/>
				<?php echo $text_author_support; ?>: <a href="https://support.sergetkach.com/category/details/3.html" target="_blank">https://support.sergetkach.com/category/details/3.html</a>
    		<br/>
				<?php echo $text_module_version; ?>: <span style="font-weight: bold;">1.13.2</span>
    		<br/>
				<?php echo $text_system_version; ?>: <span style="font-weight: bold;">2.3.x</span>
    	</p>
    </div>
  </div>
</div>
<!-- Modal -->
<div class="modal fade" id="sitemapModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title"><?php echo $modal_title; ?></h4>
      </div>
      <div class="modal-body">
        <div id="form-set-sitemap-answer"></div>
        <form id="form-set-sitemap" class="form hide-if-success-response" method="post">
          <!-- Sitemap Url -->
          <div class="form-group">
            <label class="control-label" for="input-sitemap-url"><?php echo $modal_input_seo_url; ?></label>
            <input type="text" name="sitemap_url" value="" class="form-control" id="input-sitemap-url" />
          </div>
          <?php if ($is_multilingual == true) { ?>
          <!-- Language URL -->
          <div class="form-group">
            <label class="control-label" for="input-language-flag"><?php echo $modal_language_url; ?></label>
            <div class="">
              <?php foreach ($languages as $language) { ?>
              <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                <input type="text" name="language_url[<?php echo $language['language_id']; ?>]" value="<?php echo $branched_sitemap_home_urls[$language['language_id']]; ?>" class="form-control" />
              </div>
              <?php } ?>
            </div>
          </div>
          <?php } ?>
					<div class="row">
						<div class="col-sm-12">
							<button type="button" class="btn btn-primary pull-right" id="add-sitemap-to-htaccess"><?php echo $modal_btn; ?></button>
						</div>
					</div>
        </form>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script>
  var target_feed_id = '';
  
  $('#set-sitemap').click(function(e) {
    e.preventDefault();
		
		$('.hide-if-success-response').show();
    
    $('#form-set-sitemap-answer').html('');

    $('#input-sitemap-url').val('<?php echo $branched_sitemap_url; ?>');
    target_feed_id = '#feed-url-';
    
    $('#sitemapModal').modal('toggle');
  });
  
  $('#add-sitemap-to-htaccess').click(function(e) {
    e.preventDefault();
		
		$('#input-branched-sitemap-url').val($('#input-sitemap-url').val());
    
    var serializeFormData = $('#form-set-sitemap').serialize();

    $.ajax({
      url: 'index.php?route=extension/feed/branched_sitemap/addSitemapRewriteUrl&token=<?php echo $token; ?>',
      type: 'POST',
      dataType: 'json',
      data: serializeFormData,
			beforeSend: function() {
        $('#add-sitemap-to-htaccess').prop('disabled', true);
      },
      success: function (json) {
        console.log('success ajax request');
        if (json['success']) {
					console.log('success result');
          
          $('.hide-if-success-response').hide();
					
          $('#form-set-sitemap-answer').html('<div class="alert alert-success">' + json['success'] + '</div>');
          
          console.log('feeds_urls');
          console.debug(json['feeds_urls']);
          
          $.each( json['feeds_urls'], function(language_id, feed) {
            $(target_feed_id + language_id).parent('.input-group').removeClass('hidden');
            
            console.log('---');
            console.log('language_id: ' + language_id);
            console.log('feed: ' + feed);
            $(target_feed_id + language_id).val(feed);
          });
					
					if (undefined !== json['lang_flags']) {        
            $.each( json['lang_flags'], function(language_id, flag) {
              $('#feed-lang-flags-' + language_id).val(flag);
            });          
          }          
					
          setTimeout(function() {
            autoSave();
          }, 100);
					
        } else {
          console.log('error');
          $('#form-set-sitemap-answer').html('<div class="alert alert-danger"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i> ' + json['error'] + '</div>');
        }
      },
      error: function (jqXHR, textStatus, errorThrown) {
        // Error ajax query
        console.log('AJAX query Error: ' + textStatus);
      },
			complete: function() {
        $('#add-sitemap-to-htaccess').prop('disabled', false);
      }
    });
  });
	
	
	function autoSave() {
    var serializeFormData = $('#form-branched-sitemap').serialize();
    
    $.ajax({
      url: 'index.php?route=extension/feed/branched_sitemap/autoSave&token=<?php echo $token; ?>',
      type: 'POST',
      data: serializeFormData
    });
  }
	
	$('#input-sitemapindex-status').change(function() {
    if ($(this).val() != 1) {
      $('.depends-on-sitemapindex').slideUp();
    } else {
      $('.depends-on-sitemapindex').slideDown();
    }
  });
</script>
<?php echo $footer; ?>