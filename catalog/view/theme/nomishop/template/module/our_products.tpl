<div class="box">
  <?php if($module_name_on_off) { ?>
    <div class="box-heading"><?php echo $heading_title; ?></div>
  <?php } else { ?>
    <div class="box-no-heading"></div>
  <?php } ?>
  <div id="our-products-tabs<?php echo $module; ?>" class="our-products-tabs">
    <?php if ($scroll_tabs) { ?>
	  <div id="makeMeScrollable">
	    <?php foreach ($tabs as $id_tab => $tab) { ?>
	      <img src="" class="hidden" /><a href="#mod-<?php echo $id_tab; ?>"><?php echo $tab['tab_name']; ?></a>
	    <?php } ?>
	  </div>
	  <?php } else { ?>
	  <?php foreach ($tabs as $id_tab => $tab) { ?>
	    <a href="#mod-<?php echo $id_tab; ?>"><?php echo $tab['tab_name']; ?></a>
	  <?php } ?>
	<?php } ?>
  </div>
  <div class="box-content">
    <?php foreach ($tabs as $id_tab => $tab) { ?>
	  <div class="box-product" id="mod-<?php echo $id_tab; ?>">
		<?php foreach ($tab['products'] as $product) { ?>
		  <div style="position:relative;">
			<?php if ($product['thumb']) { ?>
			  <div class="image" style="position:relative;"><a href="<?php echo $product['href']; ?>"><img style="position:relative;" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a><?php echo $product['sale']; ?><?php echo $product['new']; ?><?php echo $product['popular']; ?></div>
			  <?php } else { ?>
			  <div class="image" style="position:relative;"><a href="<?php echo $product['href']; ?>"><img style="position:relative;" src="<?php echo $product['no_image']; ?>" alt="<?php echo $product['name']; ?>" /></a><?php echo $product['sale']; ?><?php echo $product['new']; ?><?php echo $product['popular']; ?></div>
			<?php } ?>
			<div class="name our-name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
			<?php if ($description) { ?>
			  <div class="description-box"><?php echo $product['description']; ?></div>
			<?php } ?>
			<?php if ($price || $btn_compare || $btn_wishlist || $btn_cart || $btn_quick_view) { ?>
			  <div class="box-bottom">
			    <?php if ($price) { ?>
			      <?php if ($product['price']) { ?>
				    <div class="price">
				      <?php if (!$product['special']) { ?>
				      <?php echo $product['price']; ?>
				      <?php } else { ?>
				      <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
				      <?php } ?>
				    </div>
			      <?php } ?>
			    <?php } ?>
				<?php if ($rating) { ?>
				  <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
				<?php } ?>
				<?php if ($btn_cart) { ?>
				  <div class="cart"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" /></div>
				<?php } ?>
			    <div class="carts-box">				  
				  <?php if ($btn_quick_view) { ?>
				    <a href="index.php?route=module/quick_view/&product_id=<?php echo $product['product_id']; ?>" class="colorbox poshytips button-quick-view" title="<?php echo $button_quick_view; ?>" /></a>
				  <?php } ?>
				  <?php if ($btn_compare) { ?>
				    <a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="poshytips button-compares" title="<?php echo $button_compare; ?>" /></a>
				  <?php } ?>
				  <?php if ($btn_wishlist) { ?>
				    <a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="poshytips button-wishlists" title="<?php echo $button_wishlist; ?>" /></a>
				  <?php } ?>
			    </div>
			  </div>
			  <?php } else { ?>
			  <div class="bottom-border-name"></div>
			<?php } ?>
		  </div>
		<?php } ?>
	  </div>
	<?php } ?>
  </div>
</div>
<script type="text/javascript"><!--
$('#our-products-tabs<?php echo $module; ?> a').tabs();
//--></script>
<?php if ($scroll_tabs) { ?>
<script type="text/javascript"><!--
$(document).ready(function () {
	$("#makeMeScrollable").smoothDivScroll({
		mousewheelScrolling: "allDirections",
		manualContinuousScrolling: true
	});
});
//--></script>
<?php } ?>
