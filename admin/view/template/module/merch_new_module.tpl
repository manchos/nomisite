     		<div class="tab" id="module-<?php echo $id; ?>" style="display:none">
      			<a class="setting-link" href="javascript:toggleSetting(<?php echo $id ?>)" id="module-set-link-<?php echo $id ?>"><?php echo $text_hidesetting ?></a>
      			<div class="module-settings" id="module-setting-container-<?php echo $id; ?>">
    			    <input type="hidden" id="merch_product_<?php echo $id; ?>" name="merch_product[<?php echo $id ?>]"/>
    			    <input type="hidden"  name="merch_module[<?php echo $id; ?>][id]" value="<?php echo $id ?>"/>
      				<table width="100%" border="0" cellpadding="5" cellspacing="0">
      					<tr>
      						<td width="50%" valign="top" align="left">
      							<table width="100%" border="0" cellpadding="5" cellspacing="0">
      								<tr>
      									<td width="1" valign="middle" align="left">
      										<label><?php echo $entry_header; ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
      										<input type="text" name="merch_module[<?php echo $id; ?>][header]" value="<?php echo $name; ?>"/>
											<select name="merch_module[<?php echo $id; ?>][visible_header]">
					  			              <?php if ($module['visible_header']) { ?>
						  			              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						  			              <option value="0"><?php echo $text_disabled; ?></option>
					  			              <?php } else { ?>
						  			              <option value="1"><?php echo $text_enabled; ?></option>
						  			              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					  			              <?php } ?>
					  			            </select> 
					  			        </td>
      								</tr>
      								<tr>
      									<td width="1" valign="middle" align="left">
      										<label><?php echo $entry_image ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
											<input type="text" name="merch_module[<?php echo $id; ?>][image_width]" size="3" />x<input type="text" name="merch_module[<?php echo $id; ?>][image_height]" size="3" />
  			            						<?php if (isset($error_image[$id])) { ?>
  			            							<span class="error"><?php echo $error_image[$id]; ?></span>
  			            						<?php } ?>      									
  			            				</td>
      								</tr>
      								<tr>
      									<td width="1" valign="middle" align="left">
      										<label><?php echo $entry_layout; ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
											<select name="merch_module[<?php echo $id; ?>][layout_id]">
					  			              <?php foreach ($layouts as $layout) { ?>
						  			              <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
					  			              <?php } ?>
				  			            </select>      									
				  			           </td>
      								</tr>
      								<tr>
      									<td width="1" valign="middle" align="left">
      										<label><?php echo $entry_position; ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
											<select name="merch_module[<?php echo $id; ?>][position]">
  			              							<option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
  			             							<option value="content_top"><?php echo $text_content_top; ?></option>
  			              							<option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
  			              							<option value="content_bottom"><?php echo $text_content_bottom; ?></option>
  			              							<option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
  			              							<option value="column_left"><?php echo $text_column_left; ?></option>
  			              							<option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
  			              							<option value="column_right"><?php echo $text_column_right; ?></option>
  			            					</select>     									
				  			           </td>
      								</tr>
      								<tr>
      									<td width="1" valign="middle" align="left">
      										<label><?php echo $entry_status; ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
											<select name="merch_module[<?php echo $id; ?>][status]">
						  			              <option value="0"><?php echo $text_disabled; ?></option>
						  			              <option value="1"><?php echo $text_enabled; ?></option>
					  			            </select>    									
				  			           </td>
      								</tr>
      								<tr>
      									<td width="1" valign="middle" align="left">
      										<label><?php echo $entry_sort_order; ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
      										<input type="text" name="merch_module[<?php echo $id; ?>][sort_order]"/>
      									</td>
      								</tr>
      								<tr>
      									<td width="1" valign="middle" align="left">
      										<label><?php echo $entry_price; ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
											<select name="merch_module[<?php echo $id; ?>][price]">
						  			              <option value="0"><?php echo $text_disabled; ?></option>
						  			              <option value="1"><?php echo $text_enabled; ?></option>
					  			            </select>    									
				  			           </td>
      								</tr>
      								<tr>
      									<td width="1" valign="middle" align="left">
      										<label><?php echo $entry_buy; ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
											<select name="merch_module[<?php echo $id; ?>][buy]">
						  			              <option value="0"><?php echo $text_disabled; ?></option>
						  			              <option value="1"><?php echo $text_enabled; ?></option>
					  			            </select>    									
				  			           </td>
      								</tr>
      							</table>
      						</td>
      						<td width="50%" valign="top" align="left">
      							<table width="100%" border="0" cellpadding="5" cellspacing="0">
      								<tr>
      									<td width="1" align="left" valign="middle">
      										<label style="white-space:nowrap;"><?php echo $text_hint; ?></label>			
      									</td>
      									<td width="100%" align="left" valign="middle">
											<select name="merch_module[<?php echo $id; ?>][hint]">
					  			              <?php if ($module['hint']) { ?>
						  			              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						  			              <option value="0"><?php echo $text_disabled; ?></option>
					  			              <?php } else { ?>
						  			              <option value="1"><?php echo $text_enabled; ?></option>
						  			              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					  			              <?php } ?>
					  			            </select> 								      									
      									</td>
      								</tr>
      								<tr>
      									<td width="1" align="left" valign="middle">
      										<label style="white-space:nowrap;"><?php echo $text_hint_max_chars ?></label>			
      									</td>
      									<td width="100%" align="left" valign="middle">
											<input type="text" name="merch_module[<?php echo $id; ?>][max_hint_char]" value="<?php if(isset($module['max_hint_char'])) echo $module['max_hint_char']; ?>"/>
      									</td>
      								</tr>
      								<tr>
      									<td width="1" align="left" valign="middle">
      										<label style="white-space:nowrap;"><?php echo $text_border_width ?></label>			
      									</td>
      									<td width="100%" align="left" valign="middle">
											<input type="text" name="merch_module[<?php echo $id; ?>][hint_border_width]" value="<?php if(isset($module['hint_border_width'])) echo $module['hint_border_width']; ?>"/>
      									</td>
      								</tr>
      								<tr>
      									<td width="1" align="left" valign="middle">
      										<label style="white-space:nowrap;"><?php echo $text_border_radius ?></label>			
      									</td>
      									<td width="100%" align="left" valign="middle">
											<input type="text" name="merch_module[<?php echo $id; ?>][hint_border_radius]" value="<?php if(isset($module['hint_border_radius'])) echo $module['hint_border_radius']; ?>"/>
      									</td>
      								</tr>
      								<tr>
      									<td width="1" align="left" valign="middle">
      										<label style="white-space:nowrap;"><?php echo $text_border_color ?></label>			
      									</td>
      									<td width="100%" align="left" valign="middle">
											<input id="hint-border-color-<?php echo $id; ?>" class="iColorPicker" type="text" name="merch_module[<?php echo $id; ?>][hint_border_color]" value="<?php if(isset($module['hint_border_color'])) echo $module['hint_border_color']; else echo '000000'; ?>"/>
      									</td>
      								</tr>
      								<tr>
      									<td width="1" align="left" valign="middle">
      										<label style="white-space:nowrap;"><?php echo $text_color ?></label>			
      									</td>
      									<td width="100%" align="left" valign="middle">
											<input id="hint-color-<?php echo $id; ?>" class="iColorPicker" type="text" name="merch_module[<?php echo $id; ?>][hint_color]" value="<?php if(isset($module['hint_color'])) echo $module['hint_color']; else echo '000000'; ?>"/>
      									</td>
      								</tr>
      								<tr>
      									<td width="1" align="left" valign="middle">
      										<label style="white-space:nowrap;"><?php echo $text_background ?></label>			
      									</td>
      									<td width="100%" align="left" valign="middle">
											<input id="hint-background-<?php echo $id; ?>" class="iColorPicker" type="text" name="merch_module[<?php echo $id; ?>][hint_background]" value="<?php if(isset($module['hint_background'])) echo $module['hint_background']; else echo 'FFFFFF'; ?>"/>
      									</td>
      								</tr>      								
      							</table>
      						</td>
      					</tr>
      				</table>
      			</div>
      				<table width="100%" border="0" cellpadding="5" cellspacing="0">
      					<tr>
      						<td width="50%" align="left" valign="top">
      							<h2 style="text-align:center;"><?php echo $text_instore ?><a class="filter-link"><?php echo $filter_text ?></a></h2>
						<div class="merch-filter" id="merch-filter-<?php echo $id ?>">
	   						<table width="100%" border="0" cellspacing="0" cellpadding="5">
	   							<tr>
	   								<td align="left" valign="middle" width="1" nowrap="nowrap">
						   				<label><?php echo $text_name ?></label>
	   								</td>
	   								<td align="left" valign="middle" width="100%" nowrap="nowrap">
						   				<input style="width:90%" type="text" name="filter_name" value="<?php if(isset($filter_name)) echo $filter_name; ?>" />
	   								</td>
	   							</tr>
	   							<tr>	
	   								<td align="left" valign="middle" width="1" nowrap="nowrap">
						   				<label><?php echo $text_artikul ?></label>
	   								</td>
	   								<td align="left" valign="middle" width="100%" nowrap="nowrap">
						   				<input style="width:90%" type="text" name="filter_artikul" value="<?php if(isset($filter_artikul)) echo $filter_artikul; ?>" />
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
      							<div class="store-goods" id="store-goods-container-<?php echo $id ?>">
      							</div>
      						</td>
      						<td width="50%" align="left" valign="top">
      							<h2 style="text-align:center;"><?php echo $text_inmodule ?><a class="new-tab-link"><?php echo $text_new_tab ?></a></h2>
      							<div class="module-goods" id="module-goods-container-<?php echo $id ?>">
      							</div>
      						</td>
      					</tr>
      				</table>      			
      		</div>
<script type="text/javascript">
$('.iColorPicker').ColorPicker({
	onSubmit: function(hsb, hex, rgb, el) {
		$(el).val(hex);
		$(el).ColorPickerHide();
	},
	onBeforeShow: function () {
		$(this).ColorPickerSetColor(this.value);
	}
})
.bind('keyup', function(){
	$(this).ColorPickerSetColor(this.value);
});

</script>      		
