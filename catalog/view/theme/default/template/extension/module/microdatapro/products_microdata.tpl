<?php $pri = 1; foreach($microdata_products as $product){ ?>
<?php if($related_block){ ?>
<span id="related-product-<?php echo $pri; ?>" itemprop="isRelatedTo" itemscope itemtype="http://schema.org/ListItem">
<?php }else{ ?>
<span itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
<?php } ?>
<meta itemprop="name" content="<?php echo $product['name']; ?>" />
<meta itemprop="description" content="<?php echo $product['microdata_description']; ?>" />
<link itemprop="url" href="<?php echo $product['href']; ?>" />
<link itemprop="image" href="<?php echo $product['thumb']; ?>" />
<meta itemprop="position" content="<?php echo $pri; ?>" />
</span>	
<?php $pri++; } ?>