<?php echo $header; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <?php $element = 1; ?>
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">			
		  <div class="vtabs">
			<?php $module_row = 1; ?>
			<?php foreach ($modules as $module) { ?>
			  <a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>"><?php echo $tab_module . ' ' . $module_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" /></a>
			  <?php $module_row++; ?>
			<?php } ?>
			<span id="module-add"><?php echo $button_add_module; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModule();" /></span> 
		  </div>		
		  <?php $module_row = 1; ?>
		  <?php foreach ($modules as $module) { ?>
			<div id="tab-module-<?php echo $module_row; ?>" class="vtabs-content">
			  <div id="tabs_our_product_<?php echo $module_row; ?>" class="htabs">
				<a href="#tab_our_product_<?php echo $module_row; ?>_tab"><?php echo $tab_products; ?></a>
				<a href="#tab_our_product_<?php echo $module_row; ?>_setting"><?php echo $tab_setting; ?></a>
			  </div>
			  <div id="tab_our_product_<?php echo $module_row; ?>_tab" style="padding:20px">
				<table class="list">
				  <thead>
					<tr>
					  <td class="left"><?php echo $column_tab_type; ?></td>
					  <td class="left"><?php echo $column_tab_name; ?></td>
					  <td class="center" width="60"><?php echo $column_tab_action; ?></td>
					</tr>
				  </thead>
				  <?php if(isset($module['tabs'])) { foreach($module['tabs'] as $tab) { ?>
				  <tbody id="module-tabs-<?php echo $module_row; ?>-<?php echo $element; ?>">
					<tr>
					  <td class="left">
						<select name="our_products_module[<?php echo $module_row; ?>][tabs][<?php echo $element; ?>][title]" title="<?php echo $module_row; ?>_<?php echo $element; ?>" class="tab-type-selector">
						<?php if ($tab['title'] == 'bestseller') { ?>
						  <option value="bestseller" selected="selected"><?php echo $text_bestseller; ?></option>
						  <?php } else { ?>
						  <option value="bestseller"><?php echo $text_bestseller; ?></option>
						<?php } ?>
						<?php if ($tab['title'] == 'products') { ?>
						  <option value="products" selected="selected"><?php echo $text_featured; ?></option>
						  <?php } else { ?>
						  <option value="products"><?php echo $text_featured; ?></option>
						<?php } ?>
						<?php if ($tab['title'] == 'latest') { ?>
						  <option value="latest" selected="selected"><?php echo $text_latest; ?></option>
						  <?php } else { ?>
						  <option value="latest"><?php echo $text_latest; ?></option>
						<?php } ?>
						<?php if ($tab['title'] == 'special') { ?>
						  <option value="special" selected="selected"><?php echo $text_special; ?></option>
						  <?php } else { ?>
						  <option value="special"><?php echo $text_special; ?></option>
						<?php } ?>
						<?php if ($tab['title'] == 'popular') { ?>
						  <option value="popular" selected="selected"><?php echo $text_popular; ?></option>
						  <?php } else { ?>
						  <option value="popular"><?php echo $text_popular; ?></option>
						<?php } ?>
						<?php if ($tab['title'] == 'category_id') { ?>
						  <option value="category_id" selected="selected"><?php echo $text_category; ?></option>
						  <?php } else { ?>
						  <option value="category_id"><?php echo $text_category; ?></option>
						<?php } ?>
						</select>
						<div class="our_product_module_<?php echo $module_row; ?>_<?php echo $element; ?>_products panel-box-products"<?php if($tab['title'] != 'products') { echo ' style="display:none"'; } ?>>
						  <div class="box-products">
							<div class="select-product"><?php echo $text_product; ?></div>
							<div><input type="text" alt="<?php echo $module_row; ?>" title="<?php echo $element; ?>" name="our_products_module[<?php echo $module_row; ?>][tabs][<?php echo $element; ?>][product]" value="" size="65" /></div>
						  </div>
						  <div class="scrollbox">
							<?php $products = explode(',', $tab['products']); ?>
							<?php $class = 'odd'; ?>
							<?php foreach ($products as $product) { if($product > 0) { ?>
							  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
							  <?php 
								$product_info = $this->model_catalog_product->getProduct($product); 
								$product_name = false;
								if($product_info) { 
								  $product_name = $product_info['name'];
								} 
							  ?>
							  <div id="product-<?php echo $module_row; ?>-<?php echo $element; ?>-<?php echo $product; ?>" class="<?php echo $class; ?>"><?php echo $product_name; ?> <img src="view/image/delete.png" alt="<?php echo $module_row; ?>" title="<?php echo $element; ?>" />
								<input type="hidden" value="<?php echo $product; ?>" />
							  </div>
							<?php } } ?>
						  </div>
						  <input type="hidden" name="our_products_module[<?php echo $module_row; ?>][tabs][<?php echo $element; ?>][products]" value="<?php echo $tab['products']; ?>" />
						</div>
						<script type="text/javascript">
						$('input[name=\'our_products_module[<?php echo $module_row; ?>][tabs][<?php echo $element; ?>][product]\']').autocomplete({
							delay: 200,
							source: function(request, response) {
								$.ajax({
									url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
									dataType: 'json',
									success: function(json) {		
										response($.map(json, function(item) {
											return {
												label: item.name,
												value: item.product_id
											}
										}));
									}
								});
							}, 
							select: function(event, ui) {
								$('#product-' + $(this).attr("alt") + '-' + $(this).attr("title") + '-' + ui.item.value).remove();
															
								$('.our_product_module_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_products .scrollbox').append('<div id="product-' + $(this).attr("alt") + '-' + $(this).attr("title") + '-' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="' + $(this).attr("alt") + '" title="' + $(this).attr("title") + '" /><input type="hidden" value="' + ui.item.value + '" /></div>');
													
								$('.our_product_module_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_products .scrollbox div:odd').attr('class', 'odd');
								$('.our_product_module_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_products .scrollbox div:even').attr('class', 'even');
															
								data = $.map($('.our_product_module_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_products .scrollbox input'), function(element){
									return $(element).attr('value');
								});
																			
								$('input[name=\'our_products_module[' + $(this).attr("alt") + '][tabs][' + $(this).attr("title") + '][products]\']').attr('value', data.join());
																		
								return false;
							},
							focus: function(event, ui) {
								return false;
							}
						});
						</script>
						<div class="our_product_module_<?php echo $module_row; ?>_<?php echo $element; ?>_category_id"<?php if($tab['title'] != 'category_id') { echo ' style="display:none"'; } ?>>
						  <div class="box-products">
							<div class="select-product"><?php echo $text_category_select; ?></div>							
						    <select name="our_products_module[<?php echo $module_row; ?>][tabs][<?php echo $element; ?>][category_id]">
							  <?php foreach ($cats as $cat) { ?>
								<?php if($cat['category_id'] == $tab['category_id']){ ?>
								  <option value="<?php echo $cat['category_id']; ?>" selected="selected"><?php echo $cat['name']; ?></option>
								  <?php }else{ ?>
								  <option value="<?php echo $cat['category_id']; ?>"><?php echo $cat['name']; ?></option>
								<?php } ?>
							  <?php } ?>
							</select>						    
						  </div>
						</div>
					  </td>
					  <td class="left">
						<?php foreach ($languages as $language) { $lang_id = $language['language_id']; ?>
						  <div class="language"><input type="text" name="our_products_module[<?php echo $module_row; ?>][tabs][<?php echo $element; ?>][tab_name][<?php echo $language['language_id']; ?>]" value="<?php if(isset($tab['tab_name'][$lang_id])) { echo $tab['tab_name'][$lang_id]; } ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></div>
						<?php } ?>
					  </td>
					  <td class="center" width="60"><a onclick="$('#module-tabs-<?php echo $module_row; ?>-<?php echo $element; ?>').remove();" class="button-remove-tab tooltip" title="<?php echo $button_remove_tab; ?>"></a></td>
					</tr>
				  </tbody>
				  <?php $element++; } } ?>
				  <tfoot>
					<tr>
					  <td colspan="2"></td>
					  <td class="center" width="60"><a onclick="addTabs(<?php echo $module_row; ?>);" class="button-add-tab tooltip" title="<?php echo $button_add_tab; ?>"></a></td>
					</tr>
				  </tfoot>
				</table>
			  </div>
			  <div id="tab_our_product_<?php echo $module_row; ?>_setting">
				<table class="list">
				  <thead>
					<tr>
					  <td class="left" width="300"><?php echo $column_tab_data_name; ?></td>
					  <td class="left"><?php echo $column_tab_data_value; ?></td>
					</tr>
				  </thead>
				  <tbody>
				    <tr>
					  <td class="left"><?php echo $entry_module_name; ?></td>
					  <td class="left">
					    <?php foreach ($languages as $language) { $lang_id = $language['language_id']; ?>
					      <div class="language"><input size="50" type="text" name="our_products_module[<?php echo $module_row; ?>][module_name][<?php echo $language['language_id']; ?>]" value="<?php if(isset($module['module_name'][$lang_id])) { echo $module['module_name'][$lang_id]; } ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></div>
					    <?php } ?>
				      </td>
				    </tr>
				    <tr>
					  <td class="left"><?php echo $entry_module_name_on_off; ?></td>
					  <td class="left">		
					    <div class="checkbox">
                          <input type="hidden" name="our_products_module[<?php echo $module_row; ?>][module_name_on_off]" value="0" />
                          <input type="checkbox" name="our_products_module[<?php echo $module_row; ?>][module_name_on_off]"<?php echo $module['module_name_on_off'] ? ' checked="checked"' : '' ?>  value="1" />
                          <span class="checkbox-label"></span>
                        </div>
					  </td>
				    </tr>
					<tr>
					  <td class="left"><?php echo $entry_price; ?></td>
					  <td class="left">
						<div class="checkbox">
						  <input type="hidden" name="our_products_module[<?php echo $module_row; ?>][price]" value="0" />
						  <input type="checkbox" name="our_products_module[<?php echo $module_row; ?>][price]"<?php echo $module['price'] ? ' checked="checked"' : '' ?>  value="1" />
						  <span class="checkbox-label"></span>
						</div>
					  </td>
					</tr>
					<tr>
					  <td class="left"><?php echo $entry_description; ?></td>
					  <td class="left">
						<div class="checkbox">
						  <input type="hidden" name="our_products_module[<?php echo $module_row; ?>][description]" value="0" />
						  <input type="checkbox" name="our_products_module[<?php echo $module_row; ?>][description]"<?php echo $module['description'] ? ' checked="checked"' : '' ?>  value="1" />
						  <span class="checkbox-label"></span>
						</div>
					  </td>
					</tr>
					<tr>
					  <td class="left"><?php echo $entry_symbol_description; ?></td>
					  <td class="left"><input type="text" name="our_products_module[<?php echo $module_row; ?>][symbol_description]" value="<?php echo $module['symbol_description']; ?>" size="5" /></td>
					</tr>
					<tr>
					  <td class="left"><?php echo $entry_rating; ?></td>
					  <td class="left">
						<div class="checkbox">
						  <input type="hidden" name="our_products_module[<?php echo $module_row; ?>][rating]" value="0" />
						  <input type="checkbox" name="our_products_module[<?php echo $module_row; ?>][rating]"<?php echo $module['rating'] ? ' checked="checked"' : '' ?>  value="1" />
						  <span class="checkbox-label"></span>
						</div>
					  </td>
					</tr>
					<tr>
					  <td class="left"><?php echo $entry_button_cart; ?></td>
					  <td class="left">
						<div class="checkbox">
						  <input type="hidden" name="our_products_module[<?php echo $module_row; ?>][button_cart]" value="0" />
						  <input type="checkbox" name="our_products_module[<?php echo $module_row; ?>][button_cart]"<?php echo $module['button_cart'] ? ' checked="checked"' : '' ?>  value="1" />
						  <span class="checkbox-label"></span>
						</div>
					  </td>
					</tr>
					<tr>
					  <td class="left"><?php echo $entry_button_wishlist; ?></td>
					  <td class="left">
						<div class="checkbox">
						  <input type="hidden" name="our_products_module[<?php echo $module_row; ?>][button_wishlist]" value="0" />
						  <input type="checkbox" name="our_products_module[<?php echo $module_row; ?>][button_wishlist]"<?php echo $module['button_wishlist'] ? ' checked="checked"' : '' ?>  value="1" />
						  <span class="checkbox-label"></span>
						</div>
					  </td>
					</tr>
					<tr>
					  <td class="left"><?php echo $entry_button_compare; ?></td>
					  <td class="left">
						<div class="checkbox">
						  <input type="hidden" name="our_products_module[<?php echo $module_row; ?>][button_compare]" value="0" />
						  <input type="checkbox" name="our_products_module[<?php echo $module_row; ?>][button_compare]"<?php echo $module['button_compare'] ? ' checked="checked"' : '' ?>  value="1" />
						  <span class="checkbox-label"></span>
						</div>
					  </td>
					</tr>
					<tr>
					  <td class="left"><?php echo $entry_button_quick_view; ?></td>
					  <td class="left">
						<div class="checkbox">
						  <input type="hidden" name="our_products_module[<?php echo $module_row; ?>][button_quick_view]" value="0" />
						  <input type="checkbox" name="our_products_module[<?php echo $module_row; ?>][button_quick_view]"<?php echo $module['button_quick_view'] ? ' checked="checked"' : '' ?>  value="1" />
						  <span class="checkbox-label"></span>
						</div>
					  </td>
					</tr>
					<tr>
					  <td class="left"><?php echo $entry_sticker_special; ?></td>
					  <td class="left">
						<div class="checkbox">
						  <input type="hidden" name="our_products_module[<?php echo $module_row; ?>][sticker_special]" value="0" />
						  <input type="checkbox" name="our_products_module[<?php echo $module_row; ?>][sticker_special]"<?php echo $module['sticker_special'] ? ' checked="checked"' : '' ?>  value="1" />
						  <span class="checkbox-label"></span>
						</div>
					  </td>
					</tr>
					<tr>
					  <td class="left"><?php echo $entry_sticker_new; ?></td>
					  <td class="left">
						<div class="checkbox">
						  <input type="hidden" name="our_products_module[<?php echo $module_row; ?>][sticker_new]" value="0" />
						  <input type="checkbox" name="our_products_module[<?php echo $module_row; ?>][sticker_new]"<?php echo $module['sticker_new'] ? ' checked="checked"' : '' ?>  value="1" />
						  <span class="checkbox-label"></span>
						</div>
					  </td>
					</tr>
					<tr>
				      <td class="left"><?php echo $entry_day_new; ?></td>
				      <td class="left"><input type="text" name="our_products_module[<?php echo $module_row; ?>][day_new]" value="<?php echo $module['day_new']; ?>" size="5" /></td>
				    </tr>
					<tr>
					  <td class="left"><?php echo $entry_sticker_popular; ?></td>
					  <td class="left">
						<div class="checkbox">
						  <input type="hidden" name="our_products_module[<?php echo $module_row; ?>][sticker_popular]" value="0" />
						  <input type="checkbox" name="our_products_module[<?php echo $module_row; ?>][sticker_popular]"<?php echo $module['sticker_popular'] ? ' checked="checked"' : '' ?>  value="1" />
						  <span class="checkbox-label"></span>
						</div>
					  </td>
					</tr>
					<tr>
				      <td class="left"><?php echo $entry_view_popular; ?></td>
				      <td class="left"><input type="text" name="our_products_module[<?php echo $module_row; ?>][view_popular]" value="<?php echo $module['view_popular']; ?>" size="5" /></td>
				    </tr>
				    <tr>
					  <td class="left"><?php echo $entry_image; ?></td>
					  <td class="left"><input type="text" name="our_products_module[<?php echo $module_row; ?>][width]" value="<?php echo $module['width']; ?>" size="5" />&nbsp; <input type="text" name="our_products_module[<?php echo $module_row; ?>][height]" value="<?php echo $module['height']; ?>" size="5" /></td>
				    </tr>
				    <tr>
					  <td class="left"><?php echo $entry_scroll_tabs; ?></td>
					  <td class="left">		
					    <div class="checkbox">
                          <input type="hidden" name="our_products_module[<?php echo $module_row; ?>][scroll_tabs]" value="0" />
                          <input type="checkbox" name="our_products_module[<?php echo $module_row; ?>][scroll_tabs]"<?php echo $module['scroll_tabs'] ? ' checked="checked"' : '' ?>  value="1">
                          <span class="checkbox-label"></span>
                        </div>
					  </td>
				    </tr>
				    <tr>
				      <td class="left"><?php echo $entry_limit; ?></td>
				      <td class="left"><input type="text" name="our_products_module[<?php echo $module_row; ?>][limit]" value="<?php echo $module['limit']; ?>" size="5" /></td>
				    </tr>
				    <tr>
				      <td class="left"><?php echo $entry_layout; ?></td>
				      <td class="left">
					    <select name="our_products_module[<?php echo $module_row; ?>][layout_id]">
					      <?php foreach ($layouts as $layout) { ?>
						    <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
						    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
						    <?php } else { ?>
						    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
						    <?php } ?>
						  <?php } ?>
					    </select>
					  </td>
				    </tr>
				    <tr>
				      <td class="left"><?php echo $entry_position; ?></td>
				      <td class="left">
					    <select name="our_products_module[<?php echo $module_row; ?>][position]">
					      <?php if ($module['position'] == 'content_top') { ?>
							<option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
							<?php } else { ?>
							<option value="content_top"><?php echo $text_content_top; ?></option>
							<?php } ?>
							<?php if ($module['position'] == 'content_bottom') { ?>
							<option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
							<?php } else { ?>
							<option value="content_bottom"><?php echo $text_content_bottom; ?></option>
					      <?php } ?>
					    </select>
					  </td>
				    </tr>
				    <tr>
				      <td class="left"><?php echo $entry_status; ?></td>
				      <td class="left">		
					    <div class="checkbox">
                          <input type="hidden" name="our_products_module[<?php echo $module_row; ?>][status]" value="0" />
                          <input type="checkbox" name="our_products_module[<?php echo $module_row; ?>][status]"<?php echo $module['status'] ? ' checked="checked"' : '' ?>  value="1">
                          <span class="checkbox-label"></span>
                        </div>
					  </td>
				    </tr>
				    <tr>
				      <td class="left"><?php echo $entry_sort_order; ?></td>
				      <td class="left"><input type="text" name="our_products_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
				    </tr>
				  </tbody>
			    </table>
			  </div>
		    </div>
		    <script type="text/javascript">
			$('#tabs_our_product_<?php echo $module_row; ?> a').tabs();
		    </script>
		    <?php $module_row++; ?>
		  <?php } ?>
	  </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('.vtabs a').tabs();
//--></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
<?php $module_row++; ?>
<?php } ?>
//--></script> 
<script type="text/javascript">
$(document).ready(function() {
	$("select.select-type").live("change", function () {
		var id_module = $(this).attr("id");
		$("#" + id_module +" option:selected").each(function() {
			if($(this).val() == 1) {
				$(".html" + id_module + "").hide();
				$(".block" + id_module + "").show();
			} else {
				$(".html" + id_module + "").show();
				$(".block" + id_module + "").hide();
			}
		});
	});
});
</script>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = ' <div id="tab-module-' + module_row + '" class="vtabs-content">';
	html += '	<div id="tabs_our_product_' + module_row + '" class="htabs">'; 
	html += '	  <a href="#tab_our_product_' + module_row + '_tab"><?php echo $tab_products; ?></a>';
	html += '	  <a href="#tab_our_product_' + module_row + '_setting"><?php echo $tab_setting; ?></a>';
	html += '	</div>';	
	html += '	<div id="tab_our_product_' + module_row + '_tab">';
	html += '	  <table class="list">';
	html += '	    <thead>';
	html += '		  <tr>';
	html += '			<td class="left"><?php echo $column_tab_type; ?></td>';
	html += '			<td class="left"><?php echo $column_tab_name; ?></td>';
	html += '			<td class="center" width="60"><?php echo $column_tab_action; ?></td>';
	html += '		  </tr>';
	html += '		</thead>';
	html += '		<tfoot>';
	html += '		  <tr>';
	html += '			<td colspan="2"></td>';	
	html += '			<td class="center" width="60"><a onclick="addTabs(' + module_row + ');" class="button-add-tab tooltip" title="<?php echo $button_add_tab; ?>"></a></td>';
	html += '		  </tr>';
	html += '		</tfoot>';
	html += '	  </table>';
	html += '	</div>';	
	html += '	<div id="tab_our_product_' + module_row + '_setting">';
	html += '     <table class="list">';
	html += '       <thead>';
	html += '         <tr>';
	html += '           <td class="left" width="300"><?php echo $column_tab_data_name; ?></td>';
	html += '           <td class="left"><?php echo $column_tab_data_value; ?></td>';
	html += '         </tr>';
	html += '       </thead>';
	html += '       <tbody>';
	html += '         <tr>';	
	html += '           <td class="left"><?php echo $entry_module_name; ?></td>';
	html += '           <td class="left">';
	<?php foreach ($languages as $language) { ?>
	html += '		      <div class="language"><input size="50"type="text" value="" name="our_products_module[' + module_row + '][module_name][<?php echo $language['language_id']; ?>]"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></div>';
	<?php } ?>
	html += '           <td>';
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_module_name_on_off; ?></td>';
	html += '	        <td class="left">';
    html += '	          <div class="checkbox">';
    html += '	            <input type="hidden" name="our_products_module['+ module_row +'][module_name_on_off]" value="0" />';
    html += '	            <input type="checkbox" name="our_products_module['+ module_row +'][module_name_on_off]" value="1" checked="checked" />';
    html += '	            <span class="checkbox-label"></span>';
    html += '	          </div>';
    html += '	        </td>';	
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_price; ?></td>';
	html += '	        <td class="left">';
    html += '	          <div class="checkbox">';
	html += '      		    <input type="hidden" name="our_products_module['+ module_row +'][price]" value="0" />';
	html += '      		    <input type="checkbox" name="our_products_module['+ module_row +'][price]" value="1" checked="checked" />';
	html += '      		    <span class="checkbox-label"></span>';
	html += '	          </div>';
	html += '	  	    </td>';	
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_description; ?></td>';
	html += '	        <td class="left">';
    html += '	          <div class="checkbox">';
	html += '      		    <input type="hidden" name="our_products_module['+ module_row +'][description]" value="0" />';
	html += '      		    <input type="checkbox" name="our_products_module['+ module_row +'][description]" value="1" checked="checked" />';
	html += '      		    <span class="checkbox-label"></span>';
	html += '	          </div>';
	html += '	  	    </td>';	
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_symbol_description; ?></td>';
	html += '           <td class="left"><input type="text" name="our_products_module[' + module_row + '][symbol_description]" value="100" size="5" /></td>';
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_rating; ?></td>';
	html += '	        <td class="left">';
    html += '	          <div class="checkbox">';
	html += '      		    <input type="hidden" name="our_products_module['+ module_row +'][rating]" value="0" />';
	html += '      		    <input type="checkbox" name="our_products_module['+ module_row +'][rating]" value="1" checked="checked" />';
	html += '      		    <span class="checkbox-label"></span>';
	html += '	          </div>';
	html += '	  	    </td>';	
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_button_cart; ?></td>';
	html += '	        <td class="left">';
    html += '	          <div class="checkbox">';
	html += '      		    <input type="hidden" name="our_products_module['+ module_row +'][button_cart]" value="0" />';
	html += '      		    <input type="checkbox" name="our_products_module['+ module_row +'][button_cart]" value="1" checked="checked" />';
	html += '      		    <span class="checkbox-label"></span>';
	html += '	          </div>';
	html += '	  	    </td>';	
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_button_wishlist; ?></td>';
	html += '	        <td class="left">';
    html += '	          <div class="checkbox">';
	html += '      		    <input type="hidden" name="our_products_module['+ module_row +'][button_wishlist]" value="0" />';
	html += '      		    <input type="checkbox" name="our_products_module['+ module_row +'][button_wishlist]" value="1" checked="checked" />';
	html += '      		    <span class="checkbox-label"></span>';
	html += '	          </div>';
	html += '	  	    </td>';	
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_button_compare; ?></td>';
	html += '	        <td class="left">';
    html += '	          <div class="checkbox">';
	html += '      		    <input type="hidden" name="our_products_module['+ module_row +'][button_compare]" value="0" />';
	html += '      		    <input type="checkbox" name="our_products_module['+ module_row +'][button_compare]" value="1" checked="checked" />';
	html += '      		    <span class="checkbox-label"></span>';
	html += '	          </div>';
	html += '	  	    </td>';	
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_button_quick_view; ?></td>';
	html += '	        <td class="left">';
    html += '	          <div class="checkbox">';
	html += '      		    <input type="hidden" name="our_products_module['+ module_row +'][button_quick_view]" value="0" />';
	html += '      		    <input type="checkbox" name="our_products_module['+ module_row +'][button_quick_view]" value="1" checked="checked" />';
	html += '      		    <span class="checkbox-label"></span>';
	html += '	          </div>';
	html += '	  	    </td>';	
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_sticker_special; ?></td>';
	html += '	        <td class="left">';
    html += '	          <div class="checkbox">';
	html += '      		    <input type="hidden" name="our_products_module['+ module_row +'][sticker_special]" value="0" checked="checked" />';
	html += '      		    <input type="checkbox" name="our_products_module['+ module_row +'][sticker_special]" value="1" />';
	html += '      		    <span class="checkbox-label"></span>';
	html += '	          </div>';
	html += '	  	    </td>';	
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_sticker_new; ?></td>';
	html += '	        <td class="left">';
    html += '	          <div class="checkbox">';
	html += '      		    <input type="hidden" name="our_products_module['+ module_row +'][sticker_new]" value="0" checked="checked" />';
	html += '      		    <input type="checkbox" name="our_products_module['+ module_row +'][sticker_new]" value="1" />';
	html += '      		    <span class="checkbox-label"></span>';
	html += '	          </div>';
	html += '	  	    </td>';	
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_day_new; ?></td>';
	html += '           <td class="left"><input type="text" name="our_products_module[' + module_row + '][day_new]" value="30" size="5" /></td>';
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_sticker_popular; ?></td>';
	html += '	        <td class="left">';
    html += '	          <div class="checkbox">';
	html += '      		    <input type="hidden" name="our_products_module['+ module_row +'][sticker_popular]" value="0" checked="checked" />';
	html += '      		    <input type="checkbox" name="our_products_module['+ module_row +'][sticker_popular]" value="1" />';
	html += '      		    <span class="checkbox-label"></span>';
	html += '	          </div>';
	html += '	  	    </td>';	
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_view_popular; ?></td>';
	html += '           <td class="left"><input type="text" name="our_products_module[' + module_row + '][view_popular]" value="50" size="5" /></td>';
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_image; ?></td>';
	html += '           <td class="left"><input type="text" name="our_products_module[' + module_row + '][width]" value="220" size="5" />&nbsp; <input type="text" name="our_products_module[' + module_row + '][height]" value="220" size="5" /></td>';
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_scroll_tabs; ?></td>';
	html += '	        <td class="left">';
    html += '	          <div class="checkbox">';
    html += '	            <input type="hidden" name="our_products_module['+ module_row +'][scroll_tabs]" value="0" checked="checked" />';
    html += '	            <input type="checkbox" name="our_products_module['+ module_row +'][scroll_tabs]" value="1" />';
    html += '	            <span class="checkbox-label"></span>';
    html += '	          </div>';
    html += '	        </td>';	
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_limit; ?></td>';
	html += '           <td class="left"><input type="text" name="our_products_module[' + module_row + '][limit]" value="20" size="5" /></td>';
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_layout; ?></td>';
	html += '           <td class="left"><select name="our_products_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '             <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '             </select></td>';
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_position; ?></td>';
	html += '           <td class="left"><select name="our_products_module[' + module_row + '][position]">';
	html += '             <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '             <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '             </select></td>';
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_status; ?></td>';
	html += '	        <td class="left">';
    html += '	          <div class="checkbox">';
    html += '	            <input type="hidden" name="our_products_module['+ module_row +'][status]" value="0" />';
    html += '	            <input type="checkbox" name="our_products_module['+ module_row +'][status]" value="1" checked="checked" />';
    html += '	            <span class="checkbox-label"></span>';
    html += '	          </div>';
    html += '	        </td>';
	html += '         </tr>';
	html += '         <tr>';
	html += '           <td class="left"><?php echo $entry_sort_order; ?></td>';
	html += '           <td class="left"><input type="text" name="our_products_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '         </tr>';
	html += '       </body>';
	html += '     </table>'; 
	html += '   </div>';
	html += ' </div>';
	
	$('#form').append(html);
	
	$('#tabs_our_product_' + module_row + ' a').tabs();

	$('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_module; ?> ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
	
	$('.vtabs a').tabs();
	
	$('#module-' + module_row).trigger('click');
	
	module_row++;
}
//--></script> 
<script type="text/javascript">
var element = <?php echo $element; ?>;
function addTabs(module_row) {
	html  = '  <tbody id="module-tabs-' + module_row + '-' + element + '">';
	html += '    <tr>';
	html += '	   <td class="left">';
	html += '		  <select name="our_products_module[' + module_row + '][tabs][' + element + '][title]" title="' + module_row + '_' + element + '" class="tab-type-selector">';
	html += '		    <option value="bestseller"><?php echo $text_bestseller; ?></option>';
	html += '			<option value="products"><?php echo $text_featured; ?></option>';
	html += '			<option value="latest"><?php echo $text_latest; ?></option>';
	html += '			<option value="special"><?php echo $text_special; ?></option>';
	html += '			<option value="popular"><?php echo $text_popular; ?></option>';
	html += '			<option value="category_id"><?php echo $text_category; ?></option>';
	html += '		  </select>';
	html += '		  <div class="our_product_module_' + module_row + '_' + element + '_products panel-box-products" style="display: none">';
	html += '		    <div class="box-products">';
	html += '			  <div class="select-product"><?php echo $text_product; ?></div>';
	html += '			  <div><input type="text" alt="' + module_row + '" title="' + element + '" name="our_products_module[' + module_row + '][tabs][' + element + '][product]" value="" /></div>';
	html += '		    </div>';
	html += '		    <div class="scrollbox">';
	html += '		    </div>';
	html += '		    <input type="hidden" name="our_products_module[' + module_row + '][tabs][' + element + '][products]" value="" />';
	html += '		  </div>';
	html += '	 	  <div class="our_product_module_' + module_row + '_' + element + '_category_id" style="display:none">';
	html += '		    <div class="box-products">';
	html += '		      <div class="select-product"><?php echo $text_category_select; ?></div>';
	html += '	      	  <select name="our_products_module['+ module_row + '][tabs]['+ element +'][category_id]">';
	<?php foreach ($cats as $cat) { ?>
	html += '	   		    <option value="<?php echo $cat['category_id']; ?>"><?php echo $cat['name']; ?></option>';
	<?php } ?>
	html += '	 	      </select>';
	html += '		   </div>';
	html += '	     </div>';
	html += '      </td>';
	html += '      <td class="left">';
	<?php foreach ($languages as $language) { ?>
	html += '		  <div class="language"><input type="text" value="" name="our_products_module[' + module_row + '][tabs][' + element + '][tab_name][<?php echo $language['language_id']; ?>]"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></div>';
	<?php } ?>
	html += '      </td>';
	html += '      <td class="center" width="60"><a onclick="$(\'#module-tabs-' + module_row + '-' + element + '\').remove();" class="button-remove-tab tooltip" title="<?php echo $button_remove_tab; ?>"></a></td>';
	html += '    </tr>';
	html += '  </tbody>';
	
	$('#tab_our_product_' + module_row + '_tab .list tfoot').before(html);
	
	$('input[name=\'our_products_module[' + module_row + '][tabs][' + element + '][product]\']').autocomplete({
		delay: 500,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {		
					response($.map(json, function(item) {
						return {
							label: item.name,
							value: item.product_id
						}
					}));
				}
			});
		}, 
		select: function(event, ui) {
			$('#product-' + $(this).attr("alt") + '-' + $(this).attr("title") + '-' + ui.item.value).remove();
			
			$('.our_product_module_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_products .scrollbox').append('<div id="product-' + $(this).attr("alt") + '-' + $(this).attr("title") + '-' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="' + $(this).attr("alt") + '" title="' + $(this).attr("title") + '" /><input type="hidden" value="' + ui.item.value + '" /></div>');
	
			$('.our_product_module_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_products .scrollbox div:odd').attr('class', 'odd');
			$('.our_product_module_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_products .scrollbox div:even').attr('class', 'even');
			
			data = $.map($('.our_product_module_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_products .scrollbox input'), function(element){
				return $(element).attr('value');
			});
							
			$('input[name=\'our_products_module[' + $(this).attr("alt") + '][tabs][' + $(this).attr("title") + '][products]\']').attr('value', data.join());
						
			return false;
		},
		focus: function(event, ui) {
	      	return false;
	   	}
	});
	
	element++;
}

$('.panel-box-products .scrollbox img').live('click', function() {
	$(this).parent().remove();
	
	$('.our_product_module_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_products .scrollbox div:odd').attr('class', 'odd');
	$('.our_product_module_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_products .scrollbox div:even').attr('class', 'even');

	data = $.map($('.our_product_module_' + $(this).attr("alt") + '_' + $(this).attr("title") + '_products .scrollbox input'), function(element){
		return $(element).attr('value');
	});
					
	$('input[name=\'our_products_module[' + $(this).attr("alt") + '][tabs][' + $(this).attr("title") + '][products]\']').attr('value', data.join());
});

$(document).ready(function() {
	$("select.tab-type-selector").live("change", function () {
		var modules = $(this).attr("title");
		$('.our_product_module_' + modules + '_products').hide();
		$('.our_product_module_' + modules + '_category_id').hide();
		if($(this).find("option:selected").val() == 'products') {
			$('.our_product_module_' + modules + '_products').show();
		}
		if($(this).find("option:selected").val() == 'category_id') {
			$('.our_product_module_' + modules + '_category_id').show();
		}
	});
});
</script>
<?php echo $footer; ?>