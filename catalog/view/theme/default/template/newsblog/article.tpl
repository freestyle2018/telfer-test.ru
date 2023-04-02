<?php echo $header; ?>
<div class="container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>

        <div id="newsblog" class="<?php echo $class; ?>">
            <?php echo $content_top; ?>
            <h1><?php echo $heading_title; ?></h1>

            <div class="row">
                <div class="col-sm-8">
                    <div class="jumbotron" style="background: url('<?php echo $thumb; ?>') no-repeat; background-color: #444">                       
                    </div>
                    <?php echo $description; ?>               
                    <br>                    
                    <?php if ($images) { ?>
                    <div class="panel panel-default">                      
                        <div class="carousel slide" id="carousel-example-captions" data-ride="carousel">
                            <!--<ol class="carousel-indicators">
                                <li data-target="#carousel-example-captions" data-slide-to="0" class=""></li>
                                <li data-target="#carousel-example-captions" data-slide-to="1" class="active"></li>
                                <li data-target="#carousel-example-captions" data-slide-to="2" class=""></li>
                            </ol>-->
                            <div class="carousel-inner" role="listbox"> 
                                <?php foreach ($images as $image) { ?>
                                <div class="item">
                                    <img src="<?php echo $image['popup']; ?>" data-holder-rendered="true">
                                    <!--<div class="carousel-caption">
                                        <h3><?php echo $heading_title; ?></h3>
                                        <p>...</p>
                                    </div>-->
                                </div>
                                <?php } ?>
                                <a href="#carousel-example-captions" class="left carousel-control" role="button" data-slide="prev">
                                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a href="#carousel-example-captions" class="right carousel-control" role="button" data-slide="next">
                                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> <span class="sr-only">Next</span> </a>
                            </div>
                        </div>
                    </div>
                    <?php } ?>               
                    <script type="text/javascript"><!--
$(".item:first").addClass("active");
//--></script>
                    <br>
                    <!--<?php if ($tags) { ?>
                    <p><?php echo $text_tags; ?>
                        <?php for ($i = 0; $i < count($tags); $i++) { ?>
                        <?php if ($i < (count($tags) - 1)) { ?>
                        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
                        <?php } else { ?>
                        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
                        <?php } ?>
                        <?php } ?>
                    </p>
                    <?php } ?>-->
                    <hr>
                    
                    <p class="card-text"><?php echo $date; ?></p>


                    <?php if ($articles) { ?>
                    <h3><?php echo $text_related; ?></h3>
                    <div class="row">
                        <?php foreach ($articles as $article) { ?>
                        <div class="col-sm-4">
                            <div class="card text-black mb-3 min-h">
                                <div class="card-body">
                                    <h4 class="card-title"><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></h4>
                                    <p class="card-text"><?php echo $article['preview']; ?></p>
                                </div>
                                <div class="card-footer">

                                </div>
                            </div>
                        </div>
                        <?php } ?>
                    </div>
                    <?php } ?>

                </div>
                <div class="col-sm-4">
                </div>
            </div>
            <?php echo $content_bottom; ?></div>
        <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>