<?php echo $header; ?>
<link type="text/css" rel="stylesheet" href="view/merch/stylesheet/style.css" />
<link type="text/css" rel="stylesheet" href="view/merch/stylesheet/colorpicker.css" />
<script type="text/javascript" src="view/merch/js/main.js"></script>
<script type="text/javascript" src="view/merch/js/colorpicker.js"></script>

<script type="text/javascript">
	var token = '<?php echo $token; ?>';
	var loading = '<img src="view/merch/image/loading.gif" />';
	var module_id = 0;
	var new_module = '<img style="padding:7px" src="view/merch/image/new.png" />';
</script>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><?php echo $heading_title . " " . $version; ?></h1><span class="update"><?php echo $update_action ?></span>
  	  <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="deleteModule()" class="button"><?php echo $text_delete; ?></a></div>
    </div>  
      <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
   	  	<div id="tabs" class="mytabs">
   	  	<?php $count=0; foreach ($modules as $module) { ?>
      		<a href="#module-<?php echo $count; ?>" id-module="<?php echo $count; ?>"<?php if($count==0) echo ' class="selected"' ?>><?php echo $module['header'] ?></a>
      	<?php $count++; } ?>	
      		<span id="new-module-link" module-id="<?php echo $count; ?>"><?php echo $text_new ?></span>
      	</div><hr id="module-menu-del">
   	  	<?php $count=0; foreach ($modules as $module) { ?>      	      
      		<div class="tab" id="module-<?php echo $count; ?>"<?php if($count>0) echo ' style="display:none;"' ?>>
      			<a class="setting-link" href="javascript:toggleSetting(<?php echo $count ?>)" id="module-set-link-<?php echo $count ?>"><?php echo $text_showsetting ?></a>
      			<div class="module-settings" id="module-setting-container-<?php echo $count; ?>" style="display:none">
    			    <input type="hidden" id="merch_product_<?php echo $count; ?>" name="merch_product[<?php echo $count ?>]" value="<?php echo $merch_product[$count] ?>"/>
    			    <input type="hidden"  name="merch_module[<?php echo $count; ?>][id]" value="<?php echo $count ?>"/>
      				<table width="100%" border="0" cellpadding="5" cellspacing="0">
      					<tr>
      						<td width="50%" valign="top" align="left">
      							<table width="100%" border="0" cellpadding="5" cellspacing="0">
      								<tr>
      									<td width="1" valign="middle" align="left">
      										<label><?php echo $entry_header; ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
      										<input type="text" name="merch_module[<?php echo $count; ?>][header]" value="<?php echo $module['header']; ?>"/>
											<select name="merch_module[<?php echo $count; ?>][visible_header]">
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
											<input type="text" name="merch_module[<?php echo $count; ?>][image_width]" value="<?php echo $module['image_width']; ?>" size="3" />x<input type="text" name="merch_module[<?php echo $count; ?>][image_height]" value="<?php echo $module['image_height']; ?>" size="3" />
  			            						<?php if (isset($error_image[$count])) { ?>
  			            							<span class="error"><?php echo $error_image[$count]; ?></span>
  			            						<?php } ?>      									
  			            				</td>
      								</tr>
      								<tr>
      									<td width="1" valign="middle" align="left">
      										<label><?php echo $entry_layout; ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
											<select name="merch_module[<?php echo $count; ?>][layout_id]">
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
      									<td width="1" valign="middle" align="left">
      										<label><?php echo $entry_position; ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
											<select name="merch_module[<?php echo $count; ?>][position]">
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
  			              						<?php if ($module['position'] == 'column_left') { ?>
  			              							<option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
  			              						<?php } else { ?>
  			              							<option value="column_left"><?php echo $text_column_left; ?></option>
  			              						<?php } ?>
  			              						<?php if ($module['position'] == 'column_right') { ?>
  			              							<option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
  			              						<?php } else { ?>
  			              							<option value="column_right"><?php echo $text_column_right; ?></option>
  			              						<?php } ?>
  			            					</select>     									
				  			           </td>
      								</tr>
      								<tr>
      									<td width="1" valign="middle" align="left">
      										<label><?php echo $entry_status; ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
											<select name="merch_module[<?php echo $count; ?>][status]">
					  			              <?php if ($module['status']) { ?>
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
      										<label><?php echo $entry_sort_order; ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
      										<input type="text" name="merch_module[<?php echo $count; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>"/>
      									</td>
      								</tr>
      								<tr>
      									<td width="1" valign="middle" align="left">
      										<label><?php echo $entry_price; ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
											<select name="merch_module[<?php echo $count; ?>][price]">
					  			              <?php if ($module['price']) { ?>
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
      										<label><?php echo $entry_buy; ?></label>
      									</td>
      									<td width="100%" valign="middle" align="left">
											<select name="merch_module[<?php echo $count; ?>][buy]">
					  			              <?php if ($module['buy']) { ?>
						  			              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						  			              <option value="0"><?php echo $text_disabled; ?></option>
					  			              <?php } else { ?>
						  			              <option value="1"><?php echo $text_enabled; ?></option>
						  			              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					  			              <?php } ?>
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
											<select name="merch_module[<?php echo $count; ?>][hint]">
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
											<input type="text" name="merch_module[<?php echo $count; ?>][max_hint_char]" value="<?php if(isset($module['max_hint_char'])) echo $module['max_hint_char']; ?>"/>
      									</td>
      								</tr>
      								<tr>
      									<td width="1" align="left" valign="middle">
      										<label style="white-space:nowrap;"><?php echo $text_border_width ?></label>			
      									</td>
      									<td width="100%" align="left" valign="middle">
											<input type="text" name="merch_module[<?php echo $count; ?>][hint_border_width]" value="<?php if(isset($module['hint_border_width'])) echo $module['hint_border_width']; ?>"/>
      									</td>
      								</tr>
      								<tr>
      									<td width="1" align="left" valign="middle">
      										<label style="white-space:nowrap;"><?php echo $text_border_radius ?></label>			
      									</td>
      									<td width="100%" align="left" valign="middle">
											<input type="text" name="merch_module[<?php echo $count; ?>][hint_border_radius]" value="<?php if(isset($module['hint_border_radius'])) echo $module['hint_border_radius']; ?>"/>
      									</td>
      								</tr>
      								<tr>
      									<td width="1" align="left" valign="middle">
      										<label style="white-space:nowrap;"><?php echo $text_border_color ?></label>			
      									</td>
      									<td width="100%" align="left" valign="middle">
											<input id="hint-border-color-<?php echo $count; ?>" class="iColorPicker" type="text" name="merch_module[<?php echo $count; ?>][hint_border_color]" value="<?php if(isset($module['hint_border_color'])) echo $module['hint_border_color']; else echo '000000'; ?>"/>
      									</td>
      								</tr>
      								<tr>
      									<td width="1" align="left" valign="middle">
      										<label style="white-space:nowrap;"><?php echo $text_color ?></label>			
      									</td>
      									<td width="100%" align="left" valign="middle">
											<input id="hint-color-<?php echo $count; ?>" class="iColorPicker" type="text" name="merch_module[<?php echo $count; ?>][hint_color]" value="<?php if(isset($module['hint_color'])) echo $module['hint_color']; else echo '000000'; ?>"/>
      									</td>
      								</tr>
      								<tr>
      									<td width="1" align="left" valign="middle">
      										<label style="white-space:nowrap;"><?php echo $text_background ?></label>			
      									</td>
      									<td width="100%" align="left" valign="middle">
											<input id="hint-background-<?php echo $count; ?>" class="iColorPicker" type="text" name="merch_module[<?php echo $count; ?>][hint_background]" value="<?php if(isset($module['hint_background'])) echo $module['hint_background']; else echo 'FFFFFF'; ?>"/>
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
						<div class="merch-filter" id="merch-filter-<?php echo $count ?>">
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
						      <div class="store-goods" id="store-goods-container-<?php echo $count ?>">
      							</div>
      						</td>
      						<td width="50%" align="left" valign="top">
      							<h2 style="text-align:center;"><?php echo $text_inmodule ?><a class="new-tab-link"><?php echo $text_new_tab ?></a></h2>
      							<div class="module-goods" id="module-goods-container-<?php echo $count ?>">
      							</div>
      						</td>
      					</tr>
      				</table>
      		</div>
      	<?php $count++; } ?>
      </form>	
      </div>
       
  </div>	   
</div> 
<script type="text/javascript">
$(function() {

	$(".filter-link").live('click',function() {
		   $('#merch-filter-'+module_id).slideToggle('fast');
	});

	$("#new-module-link").live('click', function(e) {
		e.preventDefault();
		id = $(this).attr('module-id');
		idp = parseInt(id,10)+1;
		idm = parseInt(id,10)-1;
		name = prompt("<?php echo $text_newmodule ?>");
		if(name != 'null') {
			$.post('index.php?route=module/merch/getNewModule&token=' + token, {id_module:id,name:name}, function(html) {
				$("#new-module-link").before('<a href="#module-'+id+'" id-module="'+id+'">'+name+'</a>');
				$("#new-module-link").attr('module-id',idp);
				if(idm < 0) $('#module-menu-del').after(html);
				else $('#module-'+(idm)).after(html);
			});
		}
	});
	
	$('.new-tab-link').live('click', function(e) {
		name = prompt("<?php echo $text_name_tab ?>");
		if(name != 'null') {
		    html = '<div class="merch-tab-item-module" style="text-align:center;height:40px;">';
		    html += '<div class="module-control-panel">'
			html += '<a class="merch-up-item"><img src="view/merch/image/arrow-up.png"/></a>';
		   	html += '<a class="merch-down-item"><img src="view/merch/image/arrow-down.png"/></a>';
		   	html += '<a class="merch-delete-item"><img src="view/merch/image/delete.png"/></a>';
		   	html += '</div>';
		   	html += '<span class="tab-name">Tab: '+name+'</span>';
		   	html += '<input type="hidden" value="tab:'+name+'"/>';
		   	html += '</div>';
	
			$("#module-goods-container-"+module_id).prepend(html);
			data = $.map($("#module-goods-container-"+module_id).find("input"), function(element){
				return $(element).attr('value');
			});		
			$('#merch_product_'+module_id).attr('value', data.join());
			
		}
	});
	// Заполняем товарами первую закладку, если она существует
	if($('.mytabs a').length > 0) {
		$('#store-goods-container-0').html(loading);
		$('#module-goods-container-0').html(loading);
		$.ajax({
			type: 'POST',
			dataType: 'html',
			url:  'index.php?route=module/merch/getStoreGoods&token=' + token,
			data: 'id_module=0&selected_goods='+$("#merch_product_0").val(),
			success: function(data) {
				$('#store-goods-container-0').html(data);
			}
		});
		$.ajax({
			type: 'POST',
			dataType: 'html',
			url:  'index.php?route=module/merch/getModuleGoods&token=' + token,
			data: 'id_module=0&selected_goods='+$("#merch_product_0").val(),
			success: function(data) {
				$('#module-goods-container-0').html(data);
			}
		});
	}

	$(".pagination a").live('click',function(e) {
		e.preventDefault();
		page = $(this).attr('href');
		$('#store-goods-container-'+module_id).html(loading);
			$.post(page, {id_module:module_id,selected_goods:$('#merch_product_'+module_id).val()}, function(html) {
				$('#store-goods-container-'+module_id).html(html);
			});	
	});
		
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
	
	$(".merch-product-item-store").live('click',function() {

	    html = '<div class="merch-product-item-module">';
	    html += '<div class="module-control-panel">'
		html += '<a class="merch-up-item"><img src="view/merch/image/arrow-up.png"/></a>';
	   	html += '<a class="merch-down-item"><img src="view/merch/image/arrow-down.png"/></a>';
	   	html += '<a class="merch-delete-item"><img src="view/merch/image/delete.png"/></a>';
	   	html += '</div>';
	   	html += $(this).html();
	   	html += '</div>';

		$("#module-goods-container-"+module_id).append(html);
		data = $.map($("#module-goods-container-"+module_id).find("input"), function(element){
			return $(element).attr('value');
		});		
		$('#merch_product_'+module_id).attr('value', data.join());
		$(this).attr("style","");
		$(this).removeClass();
		$(this).addClass("merch-product-item-selected");		
	});
	$(".merch-product-item-store").live('mouseover',function() {
		$(this).css("cursor","pointer");
		$(this).css("background","#F0F8FF");
	});

	$(".merch-product-item-store").live('mouseout',function() {
		$(this).css("cursor","arrow");
		$(this).css("background","");
	});	
	
	$(".merch-product-item-module").live('mouseover',function() {
		$(this).css("cursor","pointer");
		$(this).css("background","#F0F8FF");
		$(this).find(".module-control-panel").show();
	});

	$(".merch-product-item-module").live('mouseout',function() {
		$(this).css("cursor","arrow");
		$(this).css("background","");
		$(this).find(".module-control-panel").hide();
	});

	$(".merch-tab-item-module").live('mouseover',function() {
		$(this).css("cursor","pointer");
		$(this).find(".module-control-panel").show();
	});

	$(".merch-tab-item-module").live('mouseout',function() {
		$(this).css("cursor","arrow");
		$(this).find(".module-control-panel").hide();
	});
	
	jQuery.fn.putBefore = function(dest){
	   return this.each(function(){
	      $(dest).before($(this));
	   });
	}
	jQuery.fn.putAfter = function(dest){
	   return this.each(function(){
	      $(dest).after($(this));
	   });
	}
		
	$(".merch-up-item").live('click',function() {
		items = $(".merch-product-item-module, .merch-tab-item-module");
		source_idx = $(this).parent().parent().index();
		if(source_idx!=0) {
			dest_idx = source_idx-1;
			$(items[source_idx]).putBefore(items[dest_idx]);

			data = $.map($("#module-goods-container-"+module_id).find("input"), function(element){
				return $(element).attr('value');
			});		
			$('#merch_product_'+module_id).attr('value', data.join());
		}
		
	});
	$(".merch-down-item").live('click',function() {
		items = $(".merch-product-item-module, .merch-tab-item-module");
		source_idx = $(this).parent().parent().index();
		if(source_idx<items.size()) {
			dest_idx = source_idx+1;
			$(items[source_idx]).putAfter(items[dest_idx]);
		}
		
			data = $.map($("#module-goods-container-"+module_id).find("input"), function(element){
				return $(element).attr('value');
			});		
			$('#merch_product_'+module_id).attr('value', data.join());
	});
	$(".merch-delete-item").live('click',function() {
		val = $(this).parent().parent().find("input[type=hidden]").val();
		
		$('#store-goods-container-'+module_id).find("input[value='"+val+"']").parent().removeClass();
		$('#store-goods-container-'+module_id).find("input[value='"+val+"']").parent().addClass("merch-product-item-store");
		
		$(this).parent().parent().remove();
		
			data = $.map($("#module-goods-container-"+module_id).find("input"), function(element){
				return $(element).attr('value');
			});		
			$('#merch_product_'+module_id).attr('value', data.join());
	});
	
	$(".module-goods").sortable({ opacity: 0.8, cursor: 'move', update: function() {	
			data = $.map($("#module-goods-container-"+module_id).find("input"), function(element){
				return $(element).attr('value');
			});		
			$('#merch_product_'+module_id).attr('value', data.join());
		}
	});

});

function toggleSetting(id) {
	$("#module-setting-container-"+id).slideToggle();
	if($('#module-set-link-'+id).html() == '<?php echo $text_showsetting ?>') $('#module-set-link-'+id).html('<?php echo $text_hidesetting ?>');
	else $('#module-set-link-'+id).html('<?php echo $text_showsetting ?>');
}

function filter() {
	url = 'index.php?route=module/merch/getStoreGoods&token='+token;
	
	var filter_name = $('#merch-filter-'+module_id+' input[name=\'filter_name\']').attr('value');
	
	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}

	var filter_artikul = $('#merch-filter-'+module_id+' input[name=\'filter_artikul\']').attr('value');
	
	if (filter_artikul) {
		url += '&filter_artikul=' + encodeURIComponent(filter_artikul);
	}
	
	var filter_model = $('#merch-filter-'+module_id+' input[name=\'filter_model\']').attr('value');
	
	if (filter_model) {
		url += '&filter_model=' + encodeURIComponent(filter_model);
	}
	
	var filter_price = $('#merch-filter-'+module_id+' input[name=\'filter_price\']').attr('value');
	
	if (filter_price) {
		url += '&filter_price=' + encodeURIComponent(filter_price);
	}
	
	var filter_quantity = $('#merch-filter-'+module_id+' input[name=\'filter_quantity\']').attr('value');
	
	if (filter_quantity) {
		url += '&filter_quantity=' + encodeURIComponent(filter_quantity);
	}
	
	var filter_status = $('#merch-filter-'+module_id+' select[name=\'filter_status\']').attr('value');
	
	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}	
	var filter_category = $('#merch-filter-'+module_id+' select[name=\'filter_category\']').attr('value');

	if (filter_category != '*') {
		url += '&filter_category=' + encodeURIComponent(filter_category);
	}	
		$('#store-goods-container-'+module_id).html(loading);
			$.post(url, {id_module:module_id,selected_goods:$('#merch_product_'+module_id).val()}, function(html) {
				$('#store-goods-container-'+module_id).html(html);
			});	
}

function deleteModule() {
	$('.mytabs a.selected').remove();
	$('#module-'+module_id).remove();
}	
</script> 
<?php echo $footer; ?>
