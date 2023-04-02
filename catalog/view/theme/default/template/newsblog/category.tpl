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
        <div id="newsblog" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <h2><?php echo $heading_title; ?></h2>
            <?php if ($thumb || $description) { ?>
            <div class="row">
                <?php if ($thumb) { ?>
                <div class="col-sm-2"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail" /></div>
                <?php } ?>
                <?php if ($description) { ?>
                <div class="col-sm-10"><?php echo $description; ?></div>
                <?php } ?>
            </div>
            <hr>
            <?php } ?>
            <?php if ($categories) { ?>
            <h3><?php echo $text_refine; ?></h3>
            <?php if (count($categories) <= 5) { ?>
            <div class="row">
                <div class="col-sm-3">
                    <ul>
                        <?php foreach ($categories as $category) { ?>
                        <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                        <?php } ?>
                    </ul>
                </div>
            </div>
            <?php } else { ?>
            <div class="row">
                <?php foreach (array_chunk($categories, ceil(count($categories) / 4)) as $categories) { ?>
                <div class="col-sm-3">
                    <ul>
                        <?php foreach ($categories as $category) { ?>
                        <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                        <?php } ?>
                    </ul>
                </div>
                <?php } ?>
            </div>
            <?php } ?>
            <?php } ?>
            <?php if ($articles) { ?>
            <div class="row">
                <div class="col-sm-8">
                    <?php foreach ($articles as $article) { ?>                    
                    <div class="card mb-3">
                        <div class="card-body">
                            <h3 class="card-title"><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></h3>
                            <p class="card-text"><a href="<?php echo $article['href']; ?>"><?php echo $article['preview']; ?></a></p>
                            
                            
                        </div>
                        <div class="card-footer">
                            <font style="font-size: 12px; color: #777"><?php echo $article['date']; ?></font>
                        </div>
                    </div>
                    <?php } ?>
                </div>
                <div class="col-sm-4">                    
                    <div class="list-group">
                        <a class="list-group-item active">
                            Тематические публикации 
                        </a>
                        <?php foreach ($allcategories as $category) { ?>
                        
                            <a href="<?php echo $category['href']; ?>" class="list-group-item"><?php echo $category['name']; ?></a>
                            <?php } ?>
                        
                    </div>                
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
                <div class="col-sm-6 text-right"><?php echo $results; ?></div>
            </div>
            <?php } ?>
            <?php if (!$categories && !$articles) { ?>
            <p><?php echo $text_empty; ?></p>
            <div class="buttons">
                <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
            </div>
            <?php } ?>
            
            <?php echo $content_bottom; ?></div>
        <?php echo $column_right; ?></div>
</div>
</div>
<?php echo $footer; ?>