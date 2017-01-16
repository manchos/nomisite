<div class="merch-filter">
	   						<table width="100%" border="0" cellspacing="0" cellpadding="5">
	   							<tr>
	   								<td align="left" valign="middle" width="1" nowrap="nowrap">
						   				<label><?php echo $text_name ?></label>
	   								</td>
	   								<td align="left" valign="middle" width="100%" nowrap="nowrap">
						   				<input style="width:180px" type="text" name="filter_name" value="<?php echo $filter_name; ?>" />
	   								</td>
	   							</tr>
	   							<tr>	
	   								<td align="left" valign="middle" width="1" nowrap="nowrap">
						   				<label><?php echo $text_artikul ?></label>
	   								</td>
	   								<td align="left" valign="middle" width="100%" nowrap="nowrap">
						   				<input style="width:180px" type="text" name="filter_artikul" value="<?php echo $filter_artikul; ?>" />
	   								</td>
	   							</tr>
	   							<tr>	
	   								<td align="left" valign="middle" width="1" nowrap="nowrap">
						   				<label><?php echo $text_category ?></label>
	   								</td>
	   								<td align="left" valign="middle" width="100%" nowrap="nowrap">
									<select style="width:260px" name="filter_category">
						                <option value="*" selected="selected"></option>
						                <?php foreach ($categories as $category) { ?>
			            				    <?php if (!is_null($filter_category) && $category['category_id'] == $filter_category) { ?>
			            					    <option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?></option>
			            				    <?php } else { ?>
			            					    <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
			            				    <?php } ?>
			            			    <?php } ?>
			            			  </select>
	   								</td>
	   							</tr>
	   							<tr>	
	   								<td align="left" valign="middle" width="1" nowrap="nowrap">
						   				<label><?php echo $text_status ?></label>
									</td>
	   								<td align="left" valign="middle" width="100%" nowrap="nowrap">
					   				    <select name="filter_status" style="width:100px;">
						                  <option value="*"></option>
						                  <?php if ($filter_status) { ?>
			    				              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
			    				          <?php } else { ?>
							              <option value="1"><?php echo $text_enabled; ?></option>
		        			          <?php } ?>
		        			          <?php if (!is_null($filter_status) && !$filter_status) { ?>
			    			              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
		        			          <?php } else { ?>
			    			              <option value="0"><?php echo $text_disabled; ?></option>
		        			          <?php } ?>
		        			        </select>
		        			        </td>
	   							</tr>
	   						</table>
            			  <hr/>
             			<a style="text-align:right; color:white !important; font-size:12px !important;" onclick="filter();" class="button"><?php echo $filter_text; ?></a>
						</div>
						
		<?php foreach($products as $item) { ?>
				<?php if($item['selected']) { ?>
	   					<div class="merch-product-item-selected" product-id="<?php echo $item['product_id']; ?>" product-name="<?php echo $item['name']; ?>">
				<?php } else { ?>
	   					<div class="merch-product-item-store" product-id="<?php echo $item['product_id']; ?>" product-name="<?php echo $item['name']; ?>">
	   			<?php } ?>		
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
		<?php } ?>
		<div class="pagination"><?php echo $pagination; ?></div>
<script type="text/javascript"><!--
$(function() {

});
</script>