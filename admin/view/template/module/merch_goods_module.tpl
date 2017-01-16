		<?php foreach($products as $item) { ?>
		<?php if(isset($item['product_id'])) { ?>
	   					<div class="merch-product-item-module" product-id="<?php echo $item['product_id']; ?>" product-name="<?php echo $item['name']; ?>">
	   					<div class="module-control-panel">
	   						<a class="merch-up-item"><img src="view/merch/image/arrow-up.png"/></a>
	   						<a class="merch-down-item"><img src="view/merch/image/arrow-down.png"/></a>
	   						<a class="merch-delete-item"><img src="view/merch/image/delete.png"/></a>
	   					</div>
	   					<table width="100%" cellspacing="0" cellpadding="3" border="0">
	   						<tr>
	   							<td align="left" valign="middle" width="1">
	   								<img width="40" id="thumb-<?php echo $item['product_id']; ?>" class="thumb" style="border:1px silver solid;" src="<?php echo $item['image']; ?>"/>
	   							</td>
	   							<td align="left" valign="middle" width="100%">
	   								<span class="product-name"><?php echo $item['name']; ?></span>
	   							</td>
	   						</tr>
	   					</table>
	   					<input type="hidden" value="<?php echo $item['product_id']; ?>"/>
	   					</div>	
	   	<?php } else { ?>
	   					<div class="merch-tab-item-module" style="text-align:center;height:40px;">
	   					<div class="module-control-panel">
	   						<a class="merch-up-item"><img src="view/merch/image/arrow-up.png"/></a>
	   						<a class="merch-down-item"><img src="view/merch/image/arrow-down.png"/></a>
	   						<a class="merch-delete-item"><img src="view/merch/image/delete.png"/></a>
	   					</div>
	   						<span class="tab-name">Tab: <?php echo $item['name']; ?></span>
	   						<input type="hidden" value="tab:<?php echo $item['name']; ?>"/>
	   					</div>	
	   	<?php } ?>				
		<?php } ?>
<script type="text/javascript"><!--
$(function() {
});
</script>
