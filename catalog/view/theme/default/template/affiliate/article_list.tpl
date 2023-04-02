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
            <div class="col-sm-12">
                <div class="row">
                    <div class="pull-right">
                        <a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><?php echo $button_add; ?></a>
                    </div>
                    <h1><?php echo $heading_title; ?></h1>  
                    <p><?php echo $text_description; ?></p>
                </div>
            </div>
            <div class="col-sm-12">
                <div class="row">
                    <?php if ($error_warning) { ?>
                    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                    <?php } ?>
                    <?php if ($success) { ?>
                    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                    <?php } ?>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
                        </div>
                        <div class="panel-body">
                            <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-article">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                            <tr>                                                
                                                <td class="text-left">
                                                    <?php echo $column_name; ?></a>
                                                </td>
                                                <td class="text-left">
                                                    <?php echo $column_status; ?>
                                                </td>
                                                <td class="text-left">
                                                    <?php echo $column_date_available; ?>
                                                </td>
                                                <td class="text-left">
                                                    <?php echo $column_date_modified; ?>
                                                </td>
                                                <td class="text-right">
                                                    <?php echo $column_action; ?>
                                                </td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php if ($articles) { ?>
                                            <?php foreach ($articles as $article) { ?>
                                            <tr>
                                                <td class="text-left"><?php echo $article['name']; ?></td>
                                                <td class="text-left"><?php echo $article['status']; ?></td>
                                                <td class="text-left"><?php echo $article['date_added']; ?></td>
                                                <td class="text-left"><?php echo $article['date_modified']; ?></td>
                                                <td class="text-right"><a href="<?php echo $article['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                                            </tr>
                                            <?php } ?>
                                            <?php } else { ?>
                                            <tr>
                                                <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
                                            </tr>
                                            <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            </form>
                            <div class="row">
                                <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
                                <div class="col-sm-6 text-right"><?php echo $results; ?></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <?php echo $column_right; ?>
    </div>    
</div>
<?php echo $footer; ?>