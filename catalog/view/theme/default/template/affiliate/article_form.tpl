<?php echo $header; ?>
<div class="container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>

    <div class="row">
        <?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>    
        <div id="content" class="<?php echo $class; ?>">
            <div class="row">

                <div class="col-sm-12">
                    <div class="pull-right">
                        <button type="submit" form="form-article" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i> <?php echo $button_cancel; ?></a></div>
                    <h1><?php echo $heading_title; ?></h1>
                    <p><?php echo $text_description; ?></p>
                </div>

                <div class="col-sm-12">
                    <?php if ($error_warning) { ?>
                    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                    <?php } ?>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
                        </div>
                        <div class="panel-body">
                            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-article" class="form-horizontal">
                                <?php foreach ($languages as $language) { ?>
                                <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                                    <div class="form-group required">
                                        <label class="col-sm-12" for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_name_article; ?></label>
                                        <div class="col-sm-12">
                                            <input type="text" name="article_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name_article; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control this-input-for-translit" />
                                            <?php if (isset($error_name[$language['language_id']])) { ?>
                                            <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-12" for="input-preview<?php echo $language['language_id']; ?>"><?php echo $entry_preview; ?></label>
                                        <div class="col-sm-12">
                                            <textarea name="article_description[<?php echo $language['language_id']; ?>][preview]" placeholder="<?php echo $entry_preview; ?>" id="input-preview<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['preview'] : ''; ?></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-12" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
                                        <div class="col-sm-12">
                                            <textarea name="article_description[<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" class="form-control summernote"><?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['description'] : ''; ?></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label" for="input-tag<?php echo $language['language_id']; ?>"><span data-toggle="tooltip" title="<?php echo $help_tag; ?>"><?php echo $entry_tag; ?></span></label>
                                        <div class="col-sm-10">
                                            <input type="text" name="article_description[<?php echo $language['language_id']; ?>][tag]" value="<?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['tag'] : ''; ?>" placeholder="<?php echo $entry_tag; ?>" id="input-tag<?php echo $language['language_id']; ?>" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                <?php } ?>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-related"><?php echo $entry_related; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="related" value="" placeholder="<?php echo $entry_related; ?>" id="input-related" class="form-control" />
                                        <div id="article-related" class="well well-sm" style="height: 150px; overflow: auto;">
                                            <?php foreach ($article_relateds as $article_related) { ?>
                                            <div id="article-related<?php echo $article_related['article_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $article_related['name']; ?>
                                                <input type="hidden" name="article_related[]" value="<?php echo $article_related['article_id']; ?>" />
                                            </div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-related"><?php echo $entry_related_products; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="related_products" value="" placeholder="<?php echo $entry_related_products; ?>" id="input-related_products" class="form-control" />
                                        <div id="article-related_products" class="well well-sm" style="height: 150px; overflow: auto;">
                                            <?php foreach ($article_relateds_products as $article_related_products) { ?>
                                            <div id="article-related<?php echo $article_related_products['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $article_related_products['name']; ?>
                                                <input type="hidden" name="article_related_products[]" value="<?php echo $article_related_products['product_id']; ?>" />
                                            </div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>

                                <!--<div class="tab-pane" id="tab-data">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label" for="input-image"><?php echo $entry_image; ?></label>
                                        <div class="col-sm-10">
                                            <a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                                            <input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label" for="input-keyword"><span data-toggle="tooltip" title="<?php echo $help_keyword; ?>"><?php echo $entry_keyword; ?></span></label>
                                        <div class="col-sm-10">
                                            <input type="text" name="keyword" value="<?php echo $keyword; ?>" placeholder="<?php echo $entry_keyword; ?>" id="input-keyword" class="form-control" />
                                            <?php if ($error_keyword) { ?>
                                            <div class="text-danger"><?php echo $error_keyword; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>

                                </div>-->




                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <?php echo $column_right; ?>
    </div>

</div>
<script type="text/javascript"><!--
// Related
       $('input[name=\'related\']').autocomplete({
           'source': function (request, response) {
               $.ajax({
                   url: 'index.php?route=affiliate/article/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                   dataType: 'json',
                   success: function (json) {
                       response($.map(json, function (item) {
                           return {
                               label: item['name'],
                               value: item['article_id']
                                            }
                                       }));
                            }
                      });
                 },
           'select': function (item) {
               $('input[name=\'related\']').val('');

               $('#article-related' + item['value']).remove();

               $('#article-related').append('<div id="article-related' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="article_related[]" value="' + item['value'] + '" /></div>');
            }
           });

       $('#article-related').delegate('.fa-minus-circle', 'click', function() {
           $(this).parent().remove();
       });
//--></script>
    <script type="text/javascript"><!--
// Related products
    $('input[name=\'related_products\']').autocomplete({
        'source': function (request, response) {
            $.ajax({
                url: 'index.php?route=affiliate/article/autocomplete_products&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                dataType: 'json',
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            label: item['name'],
                            value: item['product_id']
                                         }
                                    }));
                         }
                   });
              },
        'select': function(item) {
            $('input[name=\'related\']').val('');

            $('#article-related_products' + item['value']).remove();

            $('#article-related_products').append('<div id="article-related_products' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="article_related_products[]" value="' + item['value'] + '" /></div>');
         }
        });

    $('#article-related_products').delegate('.fa-minus-circle', 'click', function () {
        $(this).parent().remove();    
    });
//--></script> 
    <?php echo $footer; ?>
