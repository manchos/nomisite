<?php if($hint == 1) { ?>
<script type="text/javascript" src="catalog/view/merch/js/jquery.qtip-1.0.0.min.js"></script>
<script type="text/javascript">
jQuery(function(){
$('.image[title]').qtip({ 
	style: { 
        background: '#<?php echo $hint_background ?>',
        color: '#<?php echo $hint_color ?>',
		border: {
        	width: <?php echo $hint_border_width ?>,
        	radius: <?php echo $hint_border_radius ?>,
         	color: '#<?php echo $hint_border_color ?>',
      	},
 		tip: true, 
 	}, 		
 });
});	
</script>
<?php } ?>
<?php if(count($tabs) > 0) { ?>
<script type="text/javascript">
$(function() {
 $('#merch-tabs-<?php echo $id ?> a').tabs();
});
</script>
<?php } ?>
<div class="box">
<?php if($visible_header == 1) { ?>
  <div class="box-heading"><?php echo $heading ?></div>
<?php } ?> 
      <?php if(count($tabs) > 0) { ?>
      	<div id="merch-tabs-<?php echo $id ?>" class="htabs">
      		<?php $t_count=0; foreach($tabs as $tab) { ?>
      			<a href="#merch-tab-<?php echo $t_count ?>"><?php echo $tab['name'] ?></a>
      		<?php $t_count++; } ?>
      	</div>
      <?php } else { ?>
	  <div class="box-content">
	    <div class="box-product">
		<?php } ?>
      <?php $is_tab = false; $t_count=0; foreach ($products as $product) { ?>

	  <?php if(!isset($product['product_id'])) { ?>
	  	<?php if($is_tab === false) { ?>
	  		<div id="merch-tab-<?php echo $t_count ?>" class="box-content"><div class="box-product">
	  	<?php } else { ?>
	  		</div></div>
	  		<div id="merch-tab-<?php echo $t_count ?>" class="box-content"><div class="box-product">
	  	<?php $is_tab = false; } ?>
	  <?php 
	  	$t_count++; $is_tab = true; 
	  } else { ?>

      <div>
        <?php if ($product['thumb']) { ?>
        <div class="image" title="<?php if($hint == 1) echo $product['description'] ?>"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <?php if ($product['price'] && $show_price==1) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php }  ?>
        </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
        <?php if($show_buy==1) { ?>
        <div class="cart"><a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><span><?php echo $button_cart; ?></span></a></div>
        <?php } ?>
      </div>
      
      <?php } ?>
      <?php } 
      if(count($tabs) > 0) {
      ?>
      </div></div>
      <?php } ?>
    </div>
<?php      if(count($tabs) == 0) { ?>
  </div>
</div>
<?php } ?>
