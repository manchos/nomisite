
<?php if ($use_scrolling_panel) { ?>
<style type="text/css">
.jcarousel-skin-opencart .jcarousel-container-vertical {
    height: 405px;
}
.jcarousel-skin-opencart .jcarousel-clip-vertical {
    height: 405px;
}
</style>
<div class="box">
    
<div class="box-heading">
    
  <?php if(isset($category_href)): ?>
    <h1 class="h2_parangon_center">
        <a href="<?=$category_href?>">
            <?=$heading_title?>
        </a>
    </h1>
  <?php else: 
  echo '<h1 class="parangon__h1">'.$heading_title.'</h1>';?>
<?php endif; ?>
</div>
   
  <div class="box-content" style="padding:5px;">
      
	<div class="box_column_filter" id="box_column_filter<?php echo $module; ?>">
		<?php if(!empty($products)){?>
		<ul class="jcarousel-skin-opencart">
		  <?php foreach ($products as $product) { ?>
			<li>  <div class="name"><a href="<?php echo $product['href']; ?>" <?php if($product['attribute_groups']) { ?>title="			
				<?php foreach($product['attribute_groups'] as $attribute_group) { ?>				
					<?php foreach($attribute_group['attribute'] as $attribute) { ?>				
					<b><?php echo $attribute['name']; ?>:</b>
					<?php echo $attribute['text']; ?><br>				
					<?php } ?>							
			<?php } ?>"<?php } ?>><?php echo $product['name'].'<br />'.$product['color']; ?></a></div>
				<?php if ($product['thumb']) { ?>
				<div class="image"><a href="<?php echo $product['href']; ?>" title="<?php echo $product['description']; ?>" ><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
				<?php } ?>
				<div class="detail">
				
				<?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php //echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
        <!-- <div class="cart"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" /></div> -->
       	</div>
			</li>
		  <?php } ?>
		</ul>
		<?php } ?>
	</div>
  </div>
</div>
<script type="text/javascript"><!--
$('#box_column_filter<?php echo $module; ?> .jcarousel-skin-opencart').jcarousel({
	vertical: true,
	visible: <?php echo $visible ?>,
	scroll: <?php echo $scroll ?>
});
//--></script>

 <?php } else { ?>

<div class="box">
    
<div class="box-heading">
    
  <?php if(isset($category_href)): ?>
    <div class="content-title">
            <div class="h2_parangon_left">
                <a class="content-title__a" href="<?=$category_href?>">
                    <?=$heading_title?>
                </a>
            </div>
      
    </div>
  <?php else:
  echo '<h1 class="h2_parangon">'.$heading_title.'</h1>';?>
<?php endif; ?>
</div>
<div class="box-content" id="carousel_f">
    <ul class="jcarousel-skin-opencart">
      <?php foreach ($products as $product) { ?>
      <li>
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>" title="<?php echo $product['description']; ?>" ><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>" <?php if($product['attribute_groups']) { ?>title="			
				<?php foreach($product['attribute_groups'] as $attribute_group) { ?>				
					<?php foreach($attribute_group['attribute'] as $attribute) { ?>				
					<b><?php echo $attribute['name']; ?>:</b>
					<?php echo $attribute['text']; ?><br>				
					<?php } ?>							
			<?php } ?>"<?php } ?> ><?php echo $product['name'].'<br />'.$product['color']; ?></a></div>
        
        <div class="sku"><?php echo $product['sku']; ?></div>
       <!-- <div class="description"><?php echo $product['description']; ?></div>-->
        <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php //echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
        <!-- <div class="cart"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" /></div> -->
         </li>
      <?php } ?>
    </ul>
  </div>
 </div>
 <script type="text/javascript">

        
            $('.content-title__a').each( function( index, element ){
               // console.log( $( this ).text() );
                //var our_string = "something";	
                if($( this ).text().indexOf('2014') + 1) {
                    var tt = $( this ).text().replace(/2014/gim, '');
                    $( this ).text(tt);
                    $( this ).after("<img src='image/14_icon_43.png' align='middle' />");
                }
              //@TODO сделать с помощью регулярных выражений чтобы 
              //на любой год можно было прикрепить соответствующий img
              //2014  -  2014col.jpg
              //2017  - 2017 col.jpg
              
              
                if($( this ).text().indexOf('2015') + 1){
                    var tt = $( this ).text().replace(/2015/gim, '');
                    $( this ).text(tt);
                    $( this ).after("<img src='image/15_icon_43.png' align='middle' />");
                }
                //var tt = $( this ).text().replace(/2014/gim, '\<img src="image/14_icon_43.png" \/\>');
                //$( this ).text(tt);
               // var tt = $( this ).text().replace(/2015/gim, 'Текст');
                
                //$( this ).text(tt);
                //console.log( $( this ).text() );
                
            });
</script>
  <script type="text/javascript"><!--
$('#carousel_f ul').jcarousel({
	vertical: false,
	visible: <?php echo $visible ?>,
	scroll: <?php echo $scroll ?>,
        start: 2

});
//--></script>


<?php } ?>
    