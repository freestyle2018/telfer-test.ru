<?php $pi = 1; foreach($microdata_products as $product){ ?>{
"@type": "ListItem",
"image": "<?php echo $product['thumb']; ?>",
"url": "<?php echo $product['href']; ?>",
"name": "<?php echo $product['name']; ?>",
"description": "<?php echo $product['microdata_description']; ?>",
"position": "<?php echo $pi; ?>"
}<?php if($pi != count($microdata_products)){ ?>,<?php } ?><?php $pi++; } ?> 