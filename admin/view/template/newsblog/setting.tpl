<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-newsblog" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-newsblog" class="form-horizontal">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                        <li><a href="#tab-yandex-turbo" data-toggle="tab"><?php echo $tab_yandex_turbo; ?></a></li>
                        <li><a href="#tab-about" data-toggle="tab"><?php echo $tab_about; ?></a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">

                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-news">Введите главную новость </label>
                                <div class="col-sm-10">
                                    <select id="input-news" name="main_news_id" class="form-control">
                                        <option value="23" selected="selected"><?php echo $text_none; ?></option>
                                        <?php foreach($news as $new) { ?>
                                        <?php if ($new['article_id'] == $main_news_id) { ?>
                                        <option value="<?php echo $new['article_id']; ?>" selected="selected"><?php echo $new['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $new['article_id']; ?>"><?php echo $new['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>

                            <!--<div class="form-group">
                                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                                <div class="col-sm-10">
                                    <select name="newsblog_status" id="input-status" class="form-control">
                                        <?php if ($newsblog_status) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>-->
                        </div>
                        <div class="tab-pane" id="tab-yandex-turbo">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
                                </div>
                                <div class="panel-body">
                                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-yandex_turbo" class="form-horizontal">
                                        <div id="category"></div>
                                        <br />
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="input-data-feed"><?php echo $entry_yandex_category; ?></label>
                                            <div class="col-sm-10">                  
                                                <div class="input-group">
                                                    <input type="text" name="category" value="" placeholder="<?php echo $entry_category; ?>" id="input-category" class="form-control" />
                                                    <input type="hidden" name="category_id" value="" />
                                                    <span class="input-group-btn"><button type="button" id="button-category-add" data-toggle="tooltip" title="<?php echo $button_category_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></button></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="input-data-feed"><?php echo $entry_data_feed; ?></label>
                                            <div class="col-sm-10">
                                                <textarea rows="5" id="input-data-feed" class="form-control" readonly><?php echo $data_feed; ?></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                                            <div class="col-sm-10">
                                                <select name="yandex_turbo_status" id="input-status" class="form-control">
                                                    <?php if ($yandex_turbo_status) { ?>
                                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                                    <option value="0"><?php echo $text_disabled; ?></option>
                                                    <?php } else { ?>
                                                    <option value="1"><?php echo $text_enabled; ?></option>
                                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                                    <?php } ?>
                                                </select>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <script type="text/javascript"><!--

// Category
      $('input[name=\'category\']').autocomplete({
          'source': function (request, response) {
              $.ajax({
                  url: 'index.php?route=newsblog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                  dataType: 'json',
                  success: function (json) {
                      response($.map(json, function (item) {
                          return {
                              label: item['name'],
                              value: item['category_id']
                          }
                      }));
                  },
                  error: function (xhr, ajaxOptions, thrownError) {
                      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                  }
              });
          },
          'select': function (item) {
              $(this).val(item['label']);
              $('input[name="category_id"]').val(item['value']);
          }
      });

      $('#category').delegate('.pagination a', 'click', function (e) {
          e.preventDefault();

          $('#category').load(this.href);
      });

      $('#category').load('index.php?route=newsblog/setting/category&token=<?php echo $token; ?>');

      $('#button-category-add').on('click', function () {
          $.ajax({
              url: 'index.php?route=newsblog/setting/addcategory&token=<?php echo $token; ?>',
              type: 'post',
              dataType: 'json',
              data: 'category_id=' + $('input[name=\'category_id\']').val(),
              beforeSend: function () {
                  $('#button-category-add').button('loading');
              },
              complete: function () {
                  $('#button-category-add').button('reset');
              },
              success: function (json) {
                  $('.alert').remove();

                  if (json['error']) {
                      $('#category').before('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                  }

                  if (json['success']) {
                      $('#category').load('index.php?route=newsblog/setting/category&token=<?php echo $token; ?>');

                      $('#category').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

                      $('input[name=\'category\']').val('');
                      $('input[name=\'category_id\']').val('');
                  }
              },
              error: function (xhr, ajaxOptions, thrownError) {
                  alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
          }
          });
      });

      $('#category').delegate('.btn-danger', 'click', function () {
          var node = this;

          $.ajax({
              url: 'index.php?route=newsblog/setting/removecategory&token=<?php echo $token; ?>',
              type: 'post',
              data: 'category_id=' + encodeURIComponent(this.value),
              dataType: 'json',
              crossDomain: true,
              beforeSend: function () {
                  $(node).button('loading');
              },
              complete: function () {
                  $(node).button('reset');
              },
              success: function (json) {
                  $('.alert').remove();

                  // Check for errors
                  if (json['error']) {
                      $('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button><                  /div>');
                  }

                  if (json['success']) {
                      $('#category').load('index.php?route=newsblog/setting/category&token=<?php echo $token; ?>');

                      $('#category').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                  }
              },
              error: function (xhr, ajaxOptions, thrownError) {
                  alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
              }
          });
      });

//--></script>
     
                        </div>
                        <div class="tab-pane" id="tab-about">
                            <p>Здравствуйте. Модуль предназначен для версии ocStore 2.3</p>
                            <p>Дальнейшее развитие модуля будет зависеть от интереса подписчиков.</p>
                            <p>Ошибки и предложения высылать по адресу: dev@cekyp.ru </p>
                        </div>
                    </div>
                </form>
                
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>