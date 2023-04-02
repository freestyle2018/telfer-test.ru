<?php if ($heading_title) { ?>
<div class="pull-right">
    <?php if ($link_to_category) { ?>
<a href="<?php echo $link_to_category; ?>"><?php echo $text_more; ?></a>
<?php } ?>
</div>
<h2><?php echo $heading_title; ?></h2>
<?php } ?>
<?php if ($html) { ?>
<?php echo $html; ?>
<?php } ?>

<div class="row">    
  <?php foreach ($articles as $article) { ?>    
  <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 art-1 ">
    <div class="card text-black mb-3 min-h">      
      <div class="card-body">
		<p><img class="card-img" src="<?php echo $article['thumb']; ?>"></p>
		<h4 class="card-title"><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></h4>
		<p class="card-text"><?php echo $article['preview']; ?></p>
      </div>
    </div>
  </div>
  <?php } ?>
</div>