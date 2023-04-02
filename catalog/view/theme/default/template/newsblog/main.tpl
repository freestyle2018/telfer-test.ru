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
            <h1><?php echo $heading_title; ?></h1>
            <div class="row">
                <?php if ($isset_main) { ?>
                <div class="col-sm-8">       
                    <div class="card bg-dark text-white mb-3 min-h" style="background-image: url('image/bg-newsblog.jpg')">
                        <div class="card-body">
                            <h2 class="card-title"><a href="<?php echo $href; ?>"><?php echo $name_main_news; ?></a></h2>
                            <p class="card-text"><a href="<?php echo $href; ?>"><?php echo $preview; ?></a></p>
                            <p class="card-text"><?php echo $affiliate_lastname; ?> <?php echo $affiliate_firstname; ?> | <i class="fa fa-eye"></i> <?php echo $viewed; ?></p>
                        </div>
                    </div></div>
                <?php } ?>
                <?php if ($articles) { ?>
                <?php foreach ($articles as $article) { ?>
                <div class="col-sm-4">
                    <div class="card bg-secondary text-white mb-3 min-h" style="background-image: url('image/bg2-newsblog.jpg')">
                        <div class="card-body">
                            <h3 class="card-title"><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></h3>
                            <p class="card-text"><a href="<?php echo $article['href']; ?>"><?php echo $article['preview']; ?></a></p>
                            <p class="card-text"><?php echo $article['affiliate_lastname']; ?> <?php echo $article['affiliate_firstname']; ?> | <i class="fa fa-eye"></i> <?php echo $article['viewed']; ?></p>

                        </div>

                    </div>
                </div>            
                <?php } ?>
                <?php } ?>
            </div>
            <div class="nb-body">
                <div class="row">
                    <div class="col-sm-8">       
                        <?php echo $content_top; ?>
                    </div>                
                    <div class="col-sm-4">
                        <?php if ($categories) { ?>
                        <div class="list-group">
                            <a href="#" class="list-group-item active">
                                Тематические публикации 
                            </a>
                            <?php foreach ($categories as $category) { ?>                            
                                <a href="<?php echo $category['href']; ?>" class="list-group-item"><?php echo $category['name']; ?></a>
                            <?php } ?>                        
                        </div>
                        <?php } ?>
                    </div>
                </div>
            </div>

        </div>



        <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>

<?php echo $footer; ?>