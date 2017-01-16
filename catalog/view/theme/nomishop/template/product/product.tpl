<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>

    <div class="content-title">
       <div class="h2_parangon_left"><?php echo $model_name.' '.$model_color; ?></div>
       <div class="catincollmenu">
        <div class="">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
         <?php echo $breadcrumb['separator']; ?><a class="content-title__a" href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
        </div>
       </div>
       <?php 
       //print_r($category_not_coll);
       if (!empty($category_not_coll)) { ?>
       
            <nav class="catincollmenu">
            <ul class="catincollmenu__list">
                <?php foreach ($category_not_coll as $key=>$coll) { ?>
                <li>
                    <?php if (!empty($coll['seopro'])){ ?>
                        <a href="<?=$coll['seopro']?>" class="current">
                            <?php echo $coll['coll-name']; 
                            //.' ('.$coll['count'].')'
                            ?>
                        </a>
                     <?php } else { 
                        echo $coll['coll-name'];
                     } ?> 
                </li>

                <?php }?>
            </ul>
        </nav>
       
       <?php }?> 
       
       
    </div>
   <div class="product-info">
      
      <!-- 2014 (c) Izyum Web System www.izyum.name -->



      <?php if ($thumb || $images) { ?>
             <div class="left">
                <?php if ($thumb) { ?>
                   <img id="zoom_03" src="<?php echo $thumb; ?>" data-zoom-image="<?php echo $iws; ?>" alt="" />
                <?php } ?>


                <?php if (!$images) { ?>
                   <div id="gallery_01">
                      <a href="#" data-image="<?php echo $thumb ?>" data-zoom-image="<?php echo $iws; ?>">
                         <img src="<?php echo $thumb; ?>" style="display: none;" alt=""  />
                      </a>
                   </div>
                <?php } ?>

                <?php if ($images) { ?>
                   <div id="gallery_01" class="image-additional">
                      <?php foreach ($images as $i => $image) { ?>
                         <a href="#" class="colorbox <?php if ($i == 0) echo 'active';?>" data-image="<?php echo $image['thumbimage'] ?>" 
                            data-zoom-image="<?php echo $image['popup']; ?>"  >
                            <img src="<?php echo $image['thumb']; ?>" alt="" /></a>
                      <?php } ?>

                   </div>

                <?php } ?>

             </div>
          <?php } ?>

      <div class="right">
         
         <div class="overflow">
         <div class="description">
            <?php if ($manufacturer) { ?>
                   <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
                <?php } ?>
            <span><?php echo $text_model; ?></span> 
            <?php	
            /* Related Options / Связанные опции */	
            echo "<span id='product_model'>".$model."</span>"; 
            //print_r($options);
            /* >> Related Options / Связанные опции */ 
            ?>
      <br />

            
            
            <?php if ($reward) { ?>
                   <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
                <?php } ?>
            
                <span><?php echo $text_stock; ?></span> 
                       <span id="stock-h"><?php if ($stock)  echo "Есть в наличии"; ?></span>

         </div>
         
         <?php if ($price) { ?>
                     
              
                <div class="price"><?php echo $text_price; ?>
                   <?php if (!$special) { ?>
                      <span id="price_container"><?php echo $price; //echo "'Идет переоценка'"; 
                    ?></span>
                           
                   <?php } else { ?>
                      <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
                   <?php } ?>
                   
                   <?php if ($tax) { ?>
                      <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
                   <?php } ?>
                   <?php if ($points) { ?>
                      <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
                   <?php } ?>
                   <?php if ($discounts) { ?>
                      <br />
                      <div class="discount">
                         <?php foreach ($discounts as $discount) { ?>
                            <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
                         <?php } ?>
                      </div>
                   <?php } ?>
                </div>
         </div>
             <?php } ?>
             <div class="product_info__descr">
                 <div class="product_info__descr__left">
                     <div class="product-info__each-info"><?php echo $tab_description; ?>:</div> 
                 </div>
                 <div class="product_info__descr__right">
                 <?php echo $description; ?>
                 </div>
             </div>
         <?php if ($options) { ?>
                <div class="options product_info__descr">
                    <div class="product_info__descr__caption"><h4 class="product_info__descr__caption__h4"><?php echo $text_option; ?>:</h4></div>
<!-- Related Options / Связанные опции << -->
				<?php
					$this->load->model('module/related_options');
					if (	$this->model_module_related_options->installed() ) {
						$ro_settings = $this->config->get('related_options');
						if (isset($ro_settings['show_clear_options']) && $ro_settings['show_clear_options']) {
							if ((int)$ro_settings['show_clear_options'] == 1) {
				?>
				
				<script type="text/javascript">
				$(document).ready(function(){
					if ($('div.options').find("h2").length) {
						$('div.options').find("h2").after('<a onclick="clear_options();"><?php echo $text_ro_clear_options; ?></a><br>');
					} else {
						$('div.options').find("h3").after('<a onclick="clear_options();"><?php echo $text_ro_clear_options; ?></a><br>');
					}
				});
				</script>	
				<?php
				
							} else {
				
				?>
				<script type="text/javascript">
				$(document).ready(function(){
					//$('.product_info__descr__caption').append('<a onclick="clear_options();"> <br><?php echo $text_ro_clear_options; ?></a><br>');
				});
				</script>	
				<?php
							}
						}
					}
				?>
			
			<!-- >> Related Options / Связанные опции -->
                   
                   <?php foreach ($options as $option) { ?>
                      <?php if ($option['type'] == 'select') { ?>
                         <div id="option-<?php echo $option['product_option_id']; ?>" class="option product_info__descr__row">
                            <div class="product_info__descr__left">
                                <div class="product-info__each-info">
                                    <?php if ($option['required']) { ?>
                                    <span class="required">*</span>
                                    <?php } ?>
                                    <?php echo $option['name']; ?>:</div>

                            </div>
                                  
                            <div class="product_info__descr__right">
                                <select name="option[<?php echo $option['product_option_id']; ?>]">
                                   <option value=""><?php echo $text_select; ?></option>
                                   <?php foreach ($option['option_value'] as $option_value) { ?>
                                      <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                         <?php if ($option_value['price']) { ?>
                                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                         <?php } ?>
                                      </option>
                                   <?php } ?>
                                </select>
                                
                                <span id="stock">
                                  <?php 
                                    if ($stock > 0)  
                                      echo "Есть в наличии";
                                    else {
                                        echo "Нет в наличии";
                                    } 
                                  ?>
                                  </span>
                                <span id="stock_add"></span>
                                <p>
                                    <input type="button" value="таблица размеров" id="show_popup">
                                </p>
                                <div id="quantity-note"></div>
                            </div>



                         </div>

                      <?php } ?>
                      <?php if ($option['type'] == 'radio') { ?>
                         <div id="option-<?php echo $option['product_option_id']; ?>" class="option product_info__descr__row">
                            <div class="product_info__descr__left">
                                <div class="product-info__each-info">
                                    <?php if ($option['required']) { ?>
                                    <span class="required">*</span>
                                    <?php } ?>
                                    <?php echo $option['name']; ?>:</div>
                            </div>
                            <div class="product_info__descr__right">
                            <?php foreach ($option['option_value'] as $option_value) { ?>
                               <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
                               <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                  <?php if ($option_value['price']) { ?>
                                     (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                  <?php } ?>
                               </label>
                               <br />
                            <?php } ?>
                            </div>
                         </div>
                        
                      <?php } ?>
                      <?php if ($option['type'] == 'checkbox') { ?>
                         <div id="option-<?php echo $option['product_option_id']; ?>" class="option product_info__descr__row">
                            <div class="product_info__descr__left">
                                <div class="product-info__each-info">
                                    <?php if ($option['required']) { ?>
                                    <span class="required">*</span>
                                    <?php } ?>
                                    <?php echo $option['name']; ?>:</div>
                            </div>
                            <div class="product_info__descr__right">
                            <?php foreach ($option['option_value'] as $option_value) { ?>
                               <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
                               <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                  <?php if ($option_value['price']) { ?>
                                     (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                  <?php } ?>
                               </label>
                               <br />
                            <?php } ?>
                            </div>
                         </div>
                         
                      <?php } ?>
                      <?php if ($option['type'] == 'image') { ?>
                         <div id="option-<?php echo $option['product_option_id']; ?>" class="option product_info__descr__row">
                            <div class="product_info__descr__left">
                                <div class="product-info__each-info">
                                    <?php if ($option['required']) { ?>
                                    <span class="required">*</span>
                                    <?php } ?>
                                    <?php echo $option['name']; ?>:</div>
                            </div>
                            <div class="product_info__descr__right">
                                <table class="option-image">
                                    <tr>
                                   <?php foreach ($option['option_value'] as $option_value) { ?>
                                      
                                         <td style="width: 1px;">
                                             <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
                                         </td>
                                         <td>
                                             <label class="tooltip" for="option-value-<?php echo $option_value['product_option_value_id']; ?>">
                                                     <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" />
                                                     <span><?php echo $option_value['name']; ?></span>
                                             </label>
                                             <script type="text/javascript"> 
                                             if ($("#option-value-<?php echo $option_value['product_option_value_id']; ?>").prop("checked")) {
                                                 ('#selectimage').text("выбран цвет: "+"<?php echo $option_value['name']; ?>");
                                             } 
                                             $("#option-value-<?php echo $option_value['product_option_value_id']; ?>").click(function(){
                                                 $('#selectimage').text("выбран цвет: "+"<?php echo $option_value['name']; ?>");
                                             });
                                             </script>
                                         </td>
                                         <td>
                                             <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>">
                                               
                                               <?php if ($option_value['price']) { ?>
                                                  (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                               <?php } ?>
                                            </label>
                                         </td>
                                      
                                   <?php } ?>
                                    
                                    </tr>
                                </table>
                                <span id="selectimage"></span>
                            </div>
                         </div>
                         
                      <?php } ?>
                      <?php if ($option['type'] == 'text') { ?>
                         <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                            <div class="product-info__each-info">
                                <?php if ($option['required']) { ?>
                                <span class="required">*</span>
                                <?php } ?>
                                <?php echo $option['name']; ?>:</div>
                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
                         </div>
                         
                      <?php } ?>
                      <?php if ($option['type'] == 'textarea') { ?>
                         <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                            <div class="product-info__each-info">
                                <?php if ($option['required']) { ?>
                                <span class="required">*</span>
                                <?php } ?>
                                <?php echo $option['name']; ?>:</div>
                            <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
                         </div>
                         
                      <?php } ?>
                      <?php if ($option['type'] == 'file') { ?>
                         <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                            <div class="product-info__each-info">
                                <?php if ($option['required']) { ?>
                                <span class="required">*</span>
                                <?php } ?>
                                <?php echo $option['name']; ?>:</div>
                            <input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
                            <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
                         </div>
                        
                      <?php } ?>
                      <?php if ($option['type'] == 'date') { ?>
                         <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                            <div class="product-info__each-info">
                                <?php if ($option['required']) { ?>
                                <span class="required">*</span>
                                <?php } ?>
                                <?php echo $option['name']; ?>:</div>
                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
                         </div>
                         
                      <?php } ?>
                      <?php if ($option['type'] == 'datetime') { ?>
                         <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                            <div class="product-info__each-info">
                                <?php if ($option['required']) { ?>
                                <span class="required">*</span>
                                <?php } ?>
                                <?php echo $option['name']; ?>:</div>
                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
                         </div>
                         
                      <?php } ?>
                      <?php if ($option['type'] == 'time') { ?>
                         <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                            <div class="product-info__each-info">
                                <?php if ($option['required']) { ?>
                                <span class="required">*</span>
                                <?php } ?>
                                <?php echo $option['name']; ?>:</div>
                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
                         </div>
                         <br />
                      <?php } ?>
                   <?php } ?>
                </div>
             <?php } ?>
             <?php if ($attribute_groups) { ?>
             <?php foreach ($attribute_groups as $attribute_group) { ?>
                      <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                         <div class="product_info__descr__row">
                            <div class="product_info__descr__left">
                                <div class="product-info__each-info"><?php echo $attribute['name']; ?>:</div>
                            </div>
                            <div class="product_info__descr__right"><?php echo $attribute['text']; ?></div>
                         </div>
                      <?php } ?>
                <?php } ?>
            <?php } ?> 
         <div class="cart">
            <div><?php //echo $text_qty; ?>
               <input type="hidden" name="quantity"  value="<?php /* echo $minimum; */ echo 1; ?>" />
               <input type="hidden" name="product_id"  value="<?php echo $product_id; ?>" />
               &nbsp;
               <input type="button" value="<?php echo $button_cart; ?>" id="button-cart" class="button" />
               <span>&nbsp;&nbsp;<?php echo $text_or; ?>&nbsp;&nbsp;</span>
               <span class="links"><a onclick="addToWishList('<?php echo $product_id; ?>');"><?php echo $button_wishlist; ?></a><br />
                  <a onclick="addToCompare('<?php echo $product_id; ?>');"><?php echo $button_compare; ?></a></span>
            </div>
            <?php if ($minimum > 1) { ?>
                   <div class="minimum"><?php echo $text_minimum; ?></div>
                <?php } ?>
         </div>
         <?php if ($review_status) { ?>
                <div class="review">
                   <div><img src="catalog/view/theme/default/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a></div>
                   <div class="share">
                      <!-- AddThis Button BEGIN -->
                      <div class="share42init" data-image="<?php echo $thumb; ?>"></div>
                      <script type="text/javascript" src="catalog/view/javascript/jquery/share42/share42.js"></script> 
                      <!-- AddThis Button END --> 
                   </div>
                </div>
             <?php } ?>

      </div>
   </div>
   <div id="tabs" class="htabs">
      <?php if ($products) { ?>
             <a href="#tab-related"><?php echo $tab_related; ?> (<?php echo count($products); ?>)</a>
          <?php } ?>
   </div>
   <?php if ($review_status) { ?>
          <div id="tab-review" class="tab-content">
             <div id="review"></div>
             <h2 id="review-title"><?php echo $text_write; ?></h2>
             <b><?php echo $entry_name; ?></b><br />
             <input type="text" name="name" value="" />
             <br />
             <br />
             <b><?php echo $entry_review; ?></b>
             <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
             <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
             <br />
             <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
             <input type="radio" name="rating" value="1" />
             &nbsp;
             <input type="radio" name="rating" value="2" />
             &nbsp;
             <input type="radio" name="rating" value="3" />
             &nbsp;
             <input type="radio" name="rating" value="4" />
             &nbsp;
             <input type="radio" name="rating" value="5" />
             &nbsp;<span><?php echo $entry_good; ?></span><br />
             <br />
             <b><?php echo $entry_captcha; ?></b><br />
             <input type="text" name="captcha" value="" />
             <br />
             <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
             <br />
             <div class="buttons">
                <div class="right"><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>
             </div>
          </div>
       <?php } ?>
   <?php if ($products) { ?>
          <div id="tab-related" class="tab-content">
             <div class="box-product">
                <?php foreach ($products as $product) { ?>
                   <div>
                      <?php if ($product['thumb']) { ?>
                         <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
                      <?php } ?>
                      <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                      <?php if ($product['price']) { ?>
                         <div class="price">
                            <?php if (!$product['special']) { ?>
                               <?php echo $product['price']; ?>
                            <?php } else { ?>
                               <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
                            <?php } ?>
                         </div>
                      <?php } ?>
                      <?php if ($product['rating']) { ?>
                         <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
                      <?php } ?>
                      <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><?php echo $button_cart; ?></a></div>
                <?php } ?>
             </div>
          </div>
       <?php } ?>
   <?php if ($tags) { ?>
          <div class="tags"><b><?php echo $text_tags; ?></b>
                <?php for ($i = 0; $i < count($tags); $i++) { ?>
                   <?php if ($i < (count($tags) - 1)) { ?>
                   <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
                <?php } else { ?>
                   <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
                <?php } ?>
             <?php } ?>
          </div>
       <?php } ?>
       <div id="popup" style="margin-top: -37px; margin-left: -275px; display: none;">
			<h3>Таблица размеров</h3>
			<?php echo $sizechart; ?>
			<div id="close_popup"></div>
        </div>
       <div id="overlay" style="opacity: 0.5; display: none;"></div>
       
   <?php echo $content_bottom; ?></div>
<!-- Related Options / Связанные опции << -->

			<script type="text/javascript">
				function clear_options() {
					options = $("input[type=radio][name^=option]:checked");
					for (i=0;i<options.length;i++) {
						options[i].checked = false;
					}
					options = $("select[name^=option]");
					for (i=0;i<options.length;i++) {
						options[i].value = '';
					}
					options = $("textarea[name^=option]");
					for (i=0;i<options.length;i++) {
						options[i].value = '';
					}
					options = $("input[type=text][name^=option]");
					for (i=0;i<options.length;i++) {
						options[i].value = '';
					}
					options = $("input[type=checkbox][name^=option]:checked");
					for (i=0;i<options.length;i++) {
						options[i].checked = false;
					}
					options = $("input[type=hidden][name^=option]");
					for (i=0;i<options.length;i++) {
						options[i].value = '';
					}
					
					options_values_access();
					set_block_options();
					set_journal2_options();
				}
			</script>
			
			<?php 
			$this->load->model('module/related_options');
			if (	$this->model_module_related_options->installed() ) {
			
				if (isset($ro_array)) {
					
					?>
					<script type="text/javascript">
					
					var hide_inaccessible = <?php if (isset($ro_settings['hide_inaccessible']) && $ro_settings['hide_inaccessible']) echo "true"; else echo "false"; ?>;
					var options_types = [];
					var variant_product_options = [];
					var ro_step_by_step = <?php if (isset($ro_settings['step_by_step']) && $ro_settings['step_by_step']) echo "true"; else echo "false"; ?>;
					var use_block_options = ($('a[id^=block-option]').length || $('a[id^=block-image-option]').length);
					var use_journal2 = ($('div[id^=option-]').find('li[data-value]').length);
					
					<?php
					
					if (isset($options) && is_array($options)) {
						foreach ($options as $option) {
							echo "options_types[".$option['product_option_id']."]='".$option['type']."';\n";
						}
					}
					if (isset($variant_product_options) && is_array($variant_product_options)) {
						foreach ($variant_product_options as $product_option_id) {
							echo "variant_product_options.push(".$product_option_id.");\n";
						}
					}
					
					if (isset($_GET['filter_name'])) {
						echo "var filter_name=\"".$_GET['filter_name']."\";";
					} elseif (isset($_GET['search'])) {
						echo "var filter_name=\"".$_GET['search']."\";";
					} else {
						echo "var filter_name = false;";
					}
					
					if ( count($ro_array) == 0) {
					
						echo "var ro_array = false;";
					
					} else {
					
						echo "var ro_array = {};";
					
						foreach ($ro_array as $relatedoptions_id => $relatedoptions_options) {
							echo "ro_array[".$relatedoptions_id."] = {};\n";
							foreach ($relatedoptions_options as $product_option_id => $product_option_value_id ) {
								echo "ro_array[".$relatedoptions_id."][".$product_option_id."] = ".$product_option_value_id.";\n";
							}
						}
					}
					
					if ((isset($ro_settings['spec_price']) && $ro_settings['spec_price']) || (isset($ro_settings['spec_model']) && $ro_settings['spec_model'])) {
						echo "ro_prices = {};\n";
					} else {
						echo "ro_prices = false;\n";	
					}
					
					
					
					if (isset($ro_settings['spec_price']) && $ro_settings['spec_price'] && isset($ro_prices) && is_array($ro_prices)) {
						
						foreach ($ro_prices as $relatedoptions_id => $ro_price) {
							echo "ro_prices[".$relatedoptions_id."] = {};\n";
							echo "ro_prices[".$relatedoptions_id."]['price'] = ".$ro_price['price'].";\n";
							if (isset($ro_price['discounts']) && is_array($ro_price['discounts']) ) {
								echo "ro_prices[".$relatedoptions_id."]['discounts'] = [];\n";
								foreach ($ro_price['discounts'] as $ro_discount)	{
									echo "ro_prices[".$relatedoptions_id."]['discounts'].push({quantity: ".$ro_discount['quantity'].", price: ".$ro_discount['price']."});\n";
								}
							} else {
								echo "ro_prices[".$relatedoptions_id."]['discounts'] = false;\n";
							}
						}
					
					}
					
					if (isset($ro_settings['spec_model']) && $ro_settings['spec_model'] && isset($ro_prices) && is_array($ro_prices)) {
						foreach ($ro_prices as $relatedoptions_id => $ro_price) {
							if (!isset($ro_settings['spec_price']) || !$ro_settings['spec_price']) {
							// Не было цен, инициализируем объект
								echo "ro_prices[".$relatedoptions_id."] = {};\n";
							}
							echo "ro_prices[".$relatedoptions_id."]['model'] = \"".$ro_price['model']."\";\n";
						}
					}
					
					if (isset($ro_default)) {
						if ($ro_default === FALSE) {
							echo "var ro_default = false;\n";
						} else {
							echo "var ro_default = ".(int)$ro_default.";\n";
						}
					}
					
					?>
					
					var all_select_ov = {};
					$("select[name^=option\\[]").each( function (si, sel_elem) {
						all_select_ov[sel_elem.name] = [];
						
						$.each(sel_elem.options, function (oi, op_elem) {
							all_select_ov[sel_elem.name].push(op_elem.value);
						});
						
					} );
					
						
					
					
					(function ($) {
						$.fn.toggleOption = function (value, show) {
							/// <summary>Show or hide the desired option</summary>
							return this.filter('select').each(function () {
								var select = $(this);
								if (typeof show === 'undefined') {
									show = select.find('option[value="' + value + '"]').length == 0;
								}
								if (show) {
									select.showOption(value);
								}
								else {
									select.hideOption(value);
								}
							});
						};
						$.fn.showOption = function (value) {
							/// <summary>Show the desired option in the location it was in when hideOption was first used</summary>
							return this.filter('select').each(function () {
								var select = $(this);
								var found = select.find('option[value="' + value + '"]').length != 0;
								if (found) return; // already there
					
								var info = select.data('opt' + value);
								if (!info) return; // abort... hideOption has not been used yet
					
								var targetIndex = info.data('i');
								var options = select.find('option');
								var lastIndex = options.length - 1;
								if (lastIndex == -1) {
									select.prepend(info);
								}
								else {
									options.each(function (i, e) {
										var opt = $(e);
										if (opt.data('i') > targetIndex) {
											opt.before(info);
											return false;
										}
										else if (i == lastIndex) {
											opt.after(info);
											return false;
										}
									});
								}
								return;
							});
						};
						$.fn.hideOption = function (value) {
							/// <summary>Hide the desired option, but remember where it was to be able to put it back where it was</summary>
							return this.filter('select').each(function () {
								var select = $(this);
								var opt = select.find('option[value="' + value + '"]').eq(0);
								if (!opt.length) return;
					
								if (!select.data('optionsModified')) {
									// remember the order
									select.find('option').each(function (i, e) {
										$(e).data('i', i);
									});
									select.data('optionsModified', true);
								}
					
								select.data('opt' + value, opt.detach());
								return;
							});
						};
					})(jQuery);					
					
					function get_main_price(main_price) {
					
						if (ro_prices) {
							ro_id = get_current_ro_id(get_options_values([]));
							if (ro_id != -1 && (ro_id in ro_prices)) {
								if (ro_prices[ro_id]['price'] != 0) {
									return ro_prices[ro_id]['price'];
								}
							}
						}
						return main_price;
					}
					
					function stock_control(add_to_cart) {
					
						<?php  if (!isset($ro_settings['stock_control']) || !$ro_settings['stock_control']) { ?>
						if (add_to_cart) {
							$('#button-cart').attr('allow_add_to_cart','allow_add_to_cart');
							$('#button-cart').click();
						}
						return;
						<?php } ?>
					
						var erros_msg = '<?php echo $entry_stock_control_error; ?>';
						var quantity = 0;
						var options_values = get_options_values([]);
						var roid = get_current_ro_id(options_values);
						
						$('.success, .warning').remove();
						
						if (roid!=-1) {
						
							$.ajax({
									url: '<?php echo HTTP_SERVER; ?>index.php?route=module/related_options/get_to_free_quantity&roid='+roid,
									dataType : "text",                     // тип загружаемых данных
									success: function (data) { // вешаем свой обработчик на функцию success
										//$('#stock_add').text(parseInt(data));
                                                                                if (parseInt(data) > 0){
                                                                                    $('#stock').html('Есть в наличии');
                                                                                    $('#stock').removeClass('red');
                                                                                    $('#stock').addClass('green');
                                                                                    $('#quantity-note').html('');
                                                                                    $('#quantity-note').removeClass('attention')
                                                                                }
                                                                                else {
                                                                                    //$('.product_info__descr__left:contains("Размер") ~ .product_info__descr__right').append('<p >При отсутствии размера, выбранный товар Вы можете приобрести в сети магазинов Perfetta. Более полную информацию о наличии товара, Вы можете узнать по телефонам<a href="http://www.perfetta.ru/moscow/"> магазинов Perfetta:</a> 8 495 730-04-39</p> ');
                                                                                    $('#stock').html('Нет в наличии');
                                                                                    $('#stock').removeClass('green');
                                                                                    $('#stock').addClass('red');
                                                                                    $('#quantity-note').addClass('attention');
                                                                                    $('#quantity-note').html('При отсутствии размера, выбранный товар Вы можете приобрести в сети магазинов Perfetta. Более полную информацию о наличии товара, Вы можете узнать по телефонам<a href="http://www.perfetta.ru/moscow/"> магазинов Perfetta:</a> <br />8 495 730-04-39');
                                                                                }
                                                                                
										if (parseInt(data) < parseInt( $('input[type=text][name=quantity]').val() )) {
											$('.success, .warning').remove();
											$('div.product-info').find('div[class=cart]').after('<div class="warning">'+erros_msg.replace('%s',parseInt(data))+'</div>');
											
										} else {
																					
											if (add_to_cart) {
												$('#button-cart').attr('allow_add_to_cart','allow_add_to_cart');
												$('#button-cart').click();
											}
										}
									} 
							});
						} else { // не определили связанную опцию - пусть срабатывает стандартный алгоритм	
							if (add_to_cart) {
								$('#button-cart').attr('allow_add_to_cart','allow_add_to_cart');
								$('#button-cart').click();
							}
						
						}
						
					}
					
					function get_current_ro_id(options_values) {
						var all_ok;
						for(var ro_key in ro_array) {
							all_ok = true;
							for(var ov_key in ro_array[ro_key]) {
								if (!(ov_key in options_values && options_values[ov_key]==ro_array[ro_key][ov_key])) {
									all_ok = false;
								}
							}
							if (all_ok) return ro_key; 
						}
						return -1;
					}
					
					
					function option_values_access(options_values, option_id) {
						
						
						accessible_values = [];
						
						for(var ro_key in ro_array) {
							
							all_ok = true;
							for(var ov_key in options_values) {
								if (ov_key != option_id) {
									if (options_values[ov_key]) {
										if (ro_array[ro_key][ov_key] != options_values[ov_key]) {
											all_ok = false;
										}
									}
								}
							}
							
							if (all_ok &&  ($.inArray(ro_array[ro_key][option_id], accessible_values) == -1 )) accessible_values.push(ro_array[ro_key][option_id]);
							
						}
						
						set_accessible_values(option_id, accessible_values);
						
					}
					
					function set_accessible_values(option_id, accessible_values) {
					
						var current_value = ($('input[type=radio][name=option\\['+option_id+'\\]]:checked').val() || $('select[name=option\\['+option_id+'\\]]').val());
					
						if ($("select[name=option\\["+option_id+"\\]]").length) {
						//if (options_types[option_id] == 'select' || (use_block_options && options_types[option_id] == 'radio')) {
						
							if (current_value && $.inArray(parseInt(current_value), accessible_values)==-1) {
								$("select[name=option\\["+option_id+"\\]]").val("");
							}
							
							if (hide_inaccessible) {
							
								select_options = all_select_ov["option["+option_id+"]"];
								for (var i=0;i<select_options.length;i++) {
									if (select_options[i]) {
										option_value_disabled = ($.inArray(parseInt(select_options[i]),accessible_values) == -1);
										// hiding options for IE
										$("select[name=option\\["+option_id+"\\]]").toggleOption(parseInt(select_options[i]), !option_value_disabled);
										//$("select[name=option\\["+option_id+"\\]]").find('option[value='+parseInt(select_options[i])+']').toggle(!option_value_disabled);
										
									}
								}
								
							} else {
							
								select_options = $("select[name=option\\["+option_id+"\\]]")[0].options;
								for (var i=0;i<select_options.length;i++) {
									if (select_options[i].value) {
										option_value_disabled = ($.inArray(parseInt(select_options[i].value),accessible_values) == -1);
										select_options[i].disabled = option_value_disabled;
									}
								}
								
							}
							
						} else if ($("input[type=radio][name=option\\["+option_id+"\\]]").length) {	
						//} else if (options_types[option_id] == 'radio' || options_types[option_id] == 'image') {	
							
							if (current_value && $.inArray(parseInt(current_value), accessible_values)==-1) {
								$("input[type=radio][name=option\\["+option_id+"\\]]:checked")[0].checked=false;
							}
							
							radio_options = $("input[type=radio][name=option\\["+option_id+"\\]]");
							for (var i=0;i<radio_options.length;i++) {
								option_value_disabled = ($.inArray(parseInt(radio_options[i].value),accessible_values) == -1);
								if (hide_inaccessible) {
									$("#option-value-"+radio_options[i].value+"").toggle(!option_value_disabled);
									
									//radio_options[i].hidden = option_value_disabled;
									$("label[for=option-value-"+radio_options[i].value+"]").toggle(!option_value_disabled);
									
									var radio_next_br = $("label[for=option-value-"+radio_options[i].value+"]").next();
									if (radio_next_br.length && radio_next_br[0].tagName == "BR") {
										$(radio_next_br[0]).toggle(!option_value_disabled);
									}
									
								} else {
									radio_options[i].disabled = option_value_disabled;
								}
							}
							
							
							
						}
					
					}
					
					function get_options_values(options_keys) {
						var options_values = {};
						
						for (var i=0;i<$("select[name^=option]").length;i++) {
						
							option_id = parseInt( $("select[name^=option]")[i].name.substr(7,$("select[name^=option]")[i].name.length-8) );
							if ($.inArray(option_id,variant_product_options) != -1) {
								options_values[option_id] = $("select[name^=option]")[i].value;
								options_keys.push(option_id);
							}
						}
						
						// сначала все радио
						for (var i=0;i<$("input[type=radio][name^=option]").length;i++) {
						
							option_id = parseInt( $("input[type=radio][name^=option]")[i].name.substr(7,$("input[type=radio][name^=option]")[i].name.length-8) );
							if ($.inArray(option_id,variant_product_options) != -1) {
								options_values[option_id] = 0;
								if ($.inArray(option_id,options_keys) == -1) {
									options_keys.push(option_id);
								}
							}
						}
						
						// затем только выбранные
						for (var i=0;i<$("input[type=radio][name^=option]:checked").length;i++) {
							option_id = parseInt( $("input[type=radio][name^=option]:checked")[i].name.substr(7,$("input[type=radio][name^=option]:checked")[i].name.length-8) );
							if ($.inArray(option_id,variant_product_options) != -1) {
								options_values[option_id] = $("input[type=radio][name^=option]:checked")[i].value;
							}
						}
						
						return options_values;
					}
					
					// автовыбор корректных начальных значений опций, если уже выбраны какие-то значения
					function use_first_values(set_anyway) {
						
						var options_values = get_options_values([]);
						
						var has_selected = false;
						for (var optkey in options_values) {
							if (options_values[optkey]) {
								has_selected = true;
								break;
							}
						}
						
						if ((has_selected || set_anyway) && ro_array && Object.keys(ro_array).length > 0) {
							ro_key = Object.keys(ro_array)[0];
							setSelectedRO(ro_key);
						}
						
					}
					
					function setSelectedRO(ro_key) {
					
						if (ro_array && ro_array[ro_key]) {
							
							var last_opt_id = "";
							for (var opt_id in ro_array[ro_key]) {
								
								if ($('select[name=option\\['+opt_id+'\\]]').length > 0) {
									$('[name=option\\['+opt_id+'\\]]').val(ro_array[ro_key][opt_id]);
								} else if ($('input[type=radio][name=option\\['+opt_id+'\\]]').length > 0) {
									$('input[type=radio][name=option\\['+opt_id+'\\]][value='+ro_array[ro_key][opt_id]+']').prop('checked', true);
								}
								
								last_opt_id = opt_id;
							
							}
							
							if (last_opt_id != "") {
								if ($('select[name=option\\['+last_opt_id+'\\]]').length > 0) {
									$('[name=option\\['+last_opt_id+'\\]]').change();
								} else if ($('input[type=radio][name=option\\['+last_opt_id+'\\]]').length > 0) {
									$('input[type=radio][name=option\\['+last_opt_id+'\\]][value='+ro_array[ro_key][last_opt_id]+']').change();
								}
							}
							
						}
						set_block_options();
						set_journal2_options();
					}
					
					
					// для пошагового варианта
					function get_options_steps() {
						var options_steps = [];
						var product_option_id = "";
						
						for (var i=0;i<$('[name^=option\\[]').length;i++) {
						
							product_option_id = $('[name^=option\\[]')[i].name.substr(7, $('[name^=option\\[]')[i].name.length-8);
							if (!isNaN(product_option_id)) product_option_id = parseInt(product_option_id);
							if ($.inArray(product_option_id, variant_product_options) != -1) {
								if ($.inArray(product_option_id, options_steps) == -1) {
									options_steps.push(product_option_id);
								}
							}
						}
						
						return options_steps;
					}
					
					function options_values_access() {
						
						if (!ro_array) return;
						
						if (ro_step_by_step) {
						
							var options_steps = get_options_steps();
							var prev_options_values = {};
							var prev_options = [];
							
							for (var i=0;i<options_steps.length;i++) {
								if (i>0) {
									if (prev_options[i-1]) {
										// ограничения по предыдущим
										option_values_access(prev_options_values, options_steps[i]);
										
									} else {
										// откл все
										set_accessible_values(options_steps[i], []);
									}
								}
								prev_options.push( ($('input[type=radio][name=option\\['+options_steps[i]+'\\]]:checked').val() || $('select[name=option\\['+options_steps[i]+'\\]]').val()) );
								prev_options_values[options_steps[i]] = prev_options[prev_options.length-1];
							}
						
						} else {
						
							var options_keys = [];
							var options_values = get_options_values(options_keys);
							for (var i=0;i<options_keys.length;i++) {
								option_values_access(options_values, options_keys[i]);
							}
							
						}
						
						stock_control(0);
						
						<?php
						if (isset($ro_settings['spec_model']) && $ro_settings['spec_model']) {
						?>
						set_model();
						<?php
						}
						?>
						
						check_block_options();
						
					}
					
					function set_model() {
						
						var options_values = get_options_values([]);
						var roid = get_current_ro_id(options_values);
						
						if (roid!=-1 && ro_prices[roid]['model']!='') {
							$('#product_model').html(ro_prices[roid]['model']);
							
						} else {
							$('#product_model').html("<?php	/* Related Options / Связанные опции */	echo "<span id='product_model'>".$model."</span>"; /* >> Related Options / Связанные опции */ ?>
      ");
						}
					}
					
					
					function setRObyModel(model) {
						if (model && ro_array && ro_prices) {
						
							for (var ro_key in ro_prices) {
							
								if (ro_prices[ro_key]['model'] && ro_prices[ro_key]['model'] != '') {
									if (model.toLowerCase() == ro_prices[ro_key]['model'].toLowerCase()) {
										setSelectedRO(ro_key);
										return true;
									}
								}
							}
						}
						return false;
					}
					
					// Block Option compatibility
					function check_block_options() {
				
						if (use_block_options || use_journal2) {
							
							var available_values = [];
							
							// block options use SELECTs for select & radio
							$('select[name^=option\\[]').find('option').each( function () {
								
								if ($(this).val()) {
									if (hide_inaccessible) {
										available_values.push( $(this).val() );
									} else {
										if (! $(this).attr('disabled')) {
											available_values.push( $(this).val() );
										}
									}
								}
								
							});
							
							// block options use RADIOs for images
							$('input[type=radio][name^=option\\[]').each( function () {
								
								if (hide_inaccessible) {
									if ($(this)[0].style.display != 'none') {
										available_values.push( $(this).val() );
									}
								} else {
									if (!$(this).attr('disabled')) {
										available_values.push( $(this).val() );
									}
								}
								
							});
							
							// Product Block Option Module
							if (use_block_options) {
								//console.debug(available_values);
								$('a[id^=block-option],a[id^=block-image-option]').each( function () {
									//console.debug($(this).attr('option-value'));
									if ($.inArray($(this).attr('option-value'), available_values) == -1) {
										$(this).removeClass('block-active');
										if (hide_inaccessible) {
											$(this).hide();
										} else {
											$(this).attr('disabled', true);
											$(this).fadeTo("fast", 0.2);
										}
									} else {
										if (hide_inaccessible) {
											$(this).show();
										} else {
											$(this).attr('disabled', false);
											$(this).fadeTo("fast", 1);
										}
									}
									
								} );
							}
							
							// Journal2
							if (use_journal2) {
								$('div[id^=option-]').find('li[data-value]').each(function() {
									if ($.inArray($(this).attr('data-value'), available_values) == -1) {
										$(this).removeClass('selected');
										if (hide_inaccessible) {
											$(this).hide();
										} else {
											$(this).attr('disabled', true);
											$(this).fadeTo("fast", 0.2);
										}
									} else {
										if (hide_inaccessible) {
											$(this).show();
										} else {
											$(this).attr('disabled', false);
											$(this).fadeTo("fast", 1);
										}
									}
									
									// change standart Journal2 function
									$(this).unbind('click');
									$(this).click(function () {
										if ($(this).attr('disabled')) {
											return;
										}
										$(this).siblings().removeClass('selected');
										$(this).addClass('selected');
										$(this).parent().siblings('select').find('option[value=' + $(this).attr('data-value') + ']').attr('selected', 'selected');
										$(this).parent().siblings('select').trigger('change');
									});
									
									
								});
								
							}
							
						}
						
					}
					
					// Block Option compatibility
					function set_block_options() {
						
						if (use_block_options) {
							
							$('select[name^=option\\[]').find('option').each( function () {
								var poid = $(this).parent().attr('name').substr(7, $(this).parent().attr('name').length-8);
								
								// выключаем все блоки для SELECT
								$('div[id=option-'+poid+']').find('a[id^=block-]').removeClass('block-active');
								
								if ($(this).parent().val()) {
									$('div[id=option-'+poid+']').find('a[id^=block-][option-value='+$(this).parent().val()+']').addClass('block-active');
								}
								
							});
							
							// block options use RADIOs for images
							$('input[type=radio][name^=option\\[]').each( function () {
								var poid = $(this).attr('name').substr(7, $(this).attr('name').length-8);
								
								// выключаем только текущий блок для RADIO
								$('div[id=option-'+poid+']').find('a[id^=block-][option-value='+$(this).val()+']').removeClass('block-active');
								
								if ($(this).is(':checked')) {
									$('div[id=option-'+poid+']').find('a[id^=block-][option-value='+$(this).val()+']').addClass('block-active');
								}
								
							});
							
						}
						
					}
					
					// Journal2 compatibility
					function set_journal2_options() {
						
						if (use_journal2) {
							
							$('select[name^=option\\[]').find('option').each( function () {
								var poid = $(this).parent().attr('name').substr(7, $(this).parent().attr('name').length-8);
								
								// выключаем все блоки для SELECT
								$('div[id=option-'+poid+']').find('li[data-value]').removeClass('selected');
								
								if ($(this).parent().val()) {
									$('div[id=option-'+poid+']').find('li[data-value='+$(this).parent().val()+']').addClass('selected');
								}
								
							});
							
							// block options use RADIOs for images
							$('input[type=radio][name^=option\\[]').each( function () {
								var poid = $(this).attr('name').substr(7, $(this).attr('name').length-8);
								
								// выключаем только текущий блок для RADIO
								$('div[id=option-'+poid+']').find('li[data-value]').removeClass('selected');
																
								if ($(this).is(':checked')) {
									$('div[id=option-'+poid+']').find('li[data-value='+$(this).val()+']').addClass('selected');
								}
								
							});
							
						}
						
					}
					
					
					$("select[name^=option]").each(function (i) {
						$(this).change(function(){
							options_values_access();
						})
					})
					
					$("input[type=radio][name^=option]").each(function (i) {
						$(this).change(function(){
							options_values_access();
						})
					})
					
					$("input[type=text][name=quantity]").each(function (i) {
						$(this).change(function(){
							stock_control(0);
						})
					})
					
					// если задан фильтр и он совпадает с моделью из связанных опций - должно быть выбрано именно это сочетание
					if (!setRObyModel(filter_name)) { // нет по фильтру, или нет самого фильтра, тогда...
						// если при открытии выбрана опция - надо перевыбрать доступное сочетание
						if (ro_default !== false) {
							setSelectedRO(ro_default);
						}
					}
					
					
					
					options_values_access();
					
					
					</script>
					<?php
					
				}
			
			?>
			

			
			<?php } ?>

<!-- >> Related Options / Связанные опции -->
<script type="text/javascript">
/*$(document).ready(function() {
    $('.colorbox').colorbox({
         overlayClose: true,
         opacity: 0.5,
        rel: "colorbox"
     });
   });*/

$(document).ready(function() {
            // $('.product_info__descr__left:contains("Размер") ~ .product_info__descr__right').append('');
   
    
 });

</script> 
<script type="text/javascript"><!--
    $(document).ready(function() {
    $('#overlay').css({opacity: 0.5}); // Делаем затемняющий фон кроссбраузерным
    positionCenter($('#popup')); // Позиционируем всплывающее окно по центру
	
    $('#show_popup').click(function() { // При клике по ссылке, показываем всплывающее окно
        $('#popup, #overlay').fadeIn(300);
    });
	
    $('#close_popup').click(function() { // Скрываем всплывающее окно при клике по кнопке закрыть
		$('#popup, #overlay').fadeOut(300);
    });
	
    function positionCenter(elem) { // Функция, которая позиционирует всплывающее окно по центру
        elem.css({
            marginTop: '-' + elem.height() / 2 + 'px',
			marginLeft: '-' + elem.width() / 2 + 'px'
        });
    }
            var option_prefix = "option";
         // var asel = $('.option-image input:radio:checked'); 
            var asel = $(".option-image input:radio:checked[name^="+option_prefix+"\\[]");
            asel.name = $(".option-image input:radio:checked[name^="+option_prefix+"\\[]").attr('name');
            asel.value = $(".option-image input:radio:checked[name^="+option_prefix+"\\[]").attr('value');
            poip_option_value_selected(asel);
        
    
});
    //var ttt = $(".parangon__h3").text().toUpperCase();
    //$(".parangon__h3").text(ttt); 
   $('#button-cart').bind('click', function() {

      $.ajax({
         url: 'index.php?route=checkout/cart/add',
         type: 'post',
         data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
         dataType: 'json',
         success: function(json) {
            $('.success, .warning, .attention, information, .error').remove();

            if (json['error']) {
               if (json['error']['option']) {
                  for (i in json['error']['option']) {
                     $('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
                  }
               }
            }

            if (json['success']) {
               $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

               $('.success').fadeIn('slow');

               $('#cart-total').html(json['total']);

               $('html, body').animate({scrollTop: 0}, 'slow');
            }
         }
      });
   });
//--></script>
<?php if ($options) { ?>
       <script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
       <?php foreach ($options as $option) { ?>
          <?php if ($option['type'] == 'file') { ?>
             <script type="text/javascript"><!--
             new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
                   action: 'index.php?route=product/product/upload',
                   name: 'file',
                   autoSubmit: true,
                   responseType: 'json',
                   onSubmit: function(file, extension) {
                      $('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" alt="" />');
                      $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
                   },
                   onComplete: function(file, json) {
                      $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);

                      $('.error').remove();

                      if (json['success']) {
                         alert(json['success']);

                         $('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
                      }

                      if (json['error']) {
                         $('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
                      }

                      $('.loading').remove();
                   }
                });
             //--></script>
          <?php } ?>
       <?php } ?>
    <?php } ?>
<script type="text/javascript"><!--
   $('#review .pagination a').live('click', function() {
      $('#review').fadeOut('slow');

      $('#review').load(this.href);

      $('#review').fadeIn('slow');

      return false;
   });

   $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

   $('#button-review').bind('click', function() {
      $.ajax({
         url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
         type: 'post',
         dataType: 'json',
         data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
         beforeSend: function() {
            $('.success, .warning').remove();
            $('#button-review').attr('disabled', true);
            $('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
         },
         complete: function() {
            $('#button-review').attr('disabled', false);
            $('.attention').remove();
         },
         success: function(data) {
            if (data['error']) {
               $('#review-title').after('<div class="warning">' + data['error'] + '</div>');
            }

            if (data['success']) {
               $('#review-title').after('<div class="success">' + data['success'] + '</div>');

               $('input[name=\'name\']').val('');
               $('textarea[name=\'text\']').val('');
               $('input[name=\'rating\']:checked').attr('checked', '');
               $('input[name=\'captcha\']').val('');
            }
         }
      });
   });
//--></script> 
<script type="text/javascript"><!--
   $('#tabs a').tabs();
//--></script> 
<script type="text/javascript"><!--
   $("#zoom_03").elevateZoom({gallery: 'gallery_01', cursor: 'pointer', galleryActiveClass: 'active', imageCrossfade: true, loadingIcon: '/image/data/iws-loader.gif'});

//pass the images to Fancybox
   $("#zoom_03").bind("click", function(e) {
      var ez = $('#zoom_03').data('elevateZoom');
      $.fancybox(ez.getGalleryList());
      return false;
   });
//--></script> 


<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
      if ($.browser.msie && $.browser.version == 6) {
         $('.date, .datetime, .time').bgIframe();
      }

      $('.date').datepicker({dateFormat: 'yy-mm-dd'});
      $('.datetime').datetimepicker({
         dateFormat: 'yy-mm-dd',
         timeFormat: 'h:m'
      });
      $('.time').timepicker({timeFormat: 'h:m'});
   });
//--></script>

      <!-- Product Option Image PRO module << -->
      <?php  if ($poip_installed) {  ?>
        
      <script type="text/javascript"><!--
      var console=console||{"log":function(){},"debug":function(){}};
      var poip_options_settings = <?php echo json_encode($poip_product_settings); ?>;
      var poip_settings = <?php echo json_encode($poip_settings); ?>;
      var poip_images = <?php echo json_encode($poip_images); ?>;
      var poip_images_by_options = <?php echo json_encode($poip_images_by_options); ?>;
      var poip_product_option_ids = <?php echo json_encode($poip_product_option_ids); ?>;
      
			var option_prefix = "option";
			if ($('[name^=option_oc\\[]').length) {
				option_prefix = "option_oc";
			}
			var option_prefix_length = option_prefix.length;
			
      //var 
      
			function poip_get_product_option_id_from_name(name) {
				return name.substr(option_prefix_length+1, name.indexOf(']')-(option_prefix_length+1) )
			}
			
      // 1 - без checkbox, 2 - только чекбокс
      function get_selected_values(checkbox_variant) {
        
        var values = [];
        
        if (!checkbox_variant || checkbox_variant==1) {
          var options = $("select[name^="+option_prefix+"\\[]");
          for (var i=0; i<options.length; i++) {
						if ($.inArray(poip_get_product_option_id_from_name($(options[i]).attr('name')), poip_product_option_ids) != -1) {
							if (options[i].value) {
								values.push(options[i].value);
							}
						}
          }
          
          var options = $("input[type=radio][name^="+option_prefix+"\\[]:checked");
          for (var i=0; i<options.length; i++) {
						if ($.inArray(poip_get_product_option_id_from_name($(options[i]).attr('name')), poip_product_option_ids) != -1) {
							if (options[i].value) {
								values.push(options[i].value);
							}
						}
          }
        }
        
        if (!checkbox_variant || checkbox_variant==2) {
          var options = $("input[type=checkbox][name^="+option_prefix+"\\[]:checked");
          for (var i=0; i<options.length; i++) {
						if ($.inArray(poip_get_product_option_id_from_name($(options[i]).attr('name')), poip_product_option_ids) != -1) {
							if (options[i].value) {
								values.push(options[i].value);
							}
						}
          }
        }
        
        return values;
        
      }
      
      function poip_get_global_visible_images() {
        // изображения которые должны быть видны до применения фильтра
        var global_visible_images = [];
        var images_by_settings = [];
        var selected_values = get_selected_values(); 
        
        for (var i=0; i<poip_images.length; i++) {
          if (poip_images[i]['product_image_id']) { // стандартное доп.изображение
            global_visible_images.push(poip_images[i]['popup']);
          } else {
            for (var product_option_id in poip_options_settings) {
              if (poip_options_settings[product_option_id]['img_use'] == 1) { // вкл изображения всех значений
                global_visible_images.push(poip_images[i]['popup']);
              } else if (poip_options_settings[product_option_id]['img_use'] == 2) { // вкл изображения только выбранных значений
                for (var j=0; j<selected_values.length; j++) {
                  if ($.inArray(selected_values[j], poip_images[i]['product_option_value_id'])!=-1) {
                    global_visible_images.push(poip_images[i]['popup']);
                  }
                }
              }
            }
          }
          
        }
        
        return global_visible_images;
        
      }
      
      function poip_array_intersection(arr1, arr2) {
        
        var match = [];
        
        $.each(arr1, function (i, val1) {
          if ($.inArray(val1, arr2) != -1) {
            match.push(val1);
          }
        });
        
        return match;
      }
      
      function poip_change_available_images(product_option_id) {
          
        if ($.inArray(product_option_id, poip_product_option_ids)==-1) {
          return;
        }
        
        var global_visible_images = poip_get_global_visible_images();
        var selected_values = get_selected_values(1);
        var selected_checks = get_selected_values(2);
        
        
        if (poip_options_settings[product_option_id]['img_limit'] && poip_options_settings[product_option_id]['img_use']) {
        
          // соберем все изображения подходящие для чекбоксов
          var images_for_checks = [];
          
          if (selected_checks.length) {
            for (var j=0; j<poip_images.length; j++) {
              var image_ok_all = true;
              for (var i=0; i<poip_product_option_ids.length; i++) {
                var check_option_id = poip_product_option_ids[i];
                
                if ($('input[type=checkbox][name^='+option_prefix+'\\['+check_option_id+'\\]]:checked').length) {
                  var image_ok_one = false;
                  $('input[type=checkbox][name^='+option_prefix+'\\['+check_option_id+'\\]]:checked').each( function() {
                    image_ok_one = (image_ok_one || ($.inArray($(this).val(), poip_images[j]['product_option_value_id'])!=-1));
                  });
                  image_ok_all = image_ok_all && image_ok_one;
                }
              }
              
              if (image_ok_all) {
                images_for_checks.push(poip_images[j]['popup']);
              }
            }
          }
          
          // из изображений для чекбоксов отфильтруем остальные
          var images_to_show = [];
          if (selected_values.length ) {
          
            for (var i=0;i<poip_images.length;i++) {
              if (poip_images[i]['product_option_value_id']) {
                var show_image = true;
                for (var j=0;j<selected_values.length;j++) {
                  if ($.inArray(selected_values[j], poip_images[i]['product_option_value_id'])==-1) {
                    show_image = false;
                    break;
                  }
                }
                if (show_image) {
                  if (!selected_checks.length || $.inArray(poip_images[i]['popup'], images_for_checks)!=-1 ) {
                    images_to_show.push(poip_images[i]['popup']);
                  }
                }
              }
            }
            
          } else {
            if (selected_checks.length) {
              images_to_show = images_for_checks;
            }
          }
          
          if (images_to_show.length == 0) {
            images_to_show = global_visible_images;
          } else {
            images_to_show = poip_array_intersection(images_to_show, global_visible_images);
          }
          
        } else {
          images_to_show = global_visible_images;
          
        }
        
        poip_set_visible_images(images_to_show);
        
        
        return images_to_show;
      }
      
      function poip_set_visible_images(images) {
        
        $('div[class=image-additional]').children('a').each( function(){
          // Учтем возможность спец символов типа пробела %20
          var href = $(this).attr('data-image');
          if ($.inArray( href, images) != -1 || $.inArray(decodeURIComponent(href), images) != -1) {
            $(this).show();
          } else {
            $(this).hide();
          }
        });
        
      }
      
			//
			
      function poip_change_images(option) {
			
        var product_option_id = option.name.substr(option_prefix_length+1, option.name.indexOf(']')-(option_prefix_length+1) );
        
				if ($.inArray(product_option_id, poip_product_option_ids)==-1) {
          return;
        }
				
        images_to_show = poip_change_available_images(product_option_id);
        
        var value = option.value;
				
        // сначала по сочетанию опций
        // если используется фильтрация - то берем первое изображение из прошедших фильтр, иначе первое изображение опции
        var main_image_switched = false;
        if (images_to_show && poip_options_settings[product_option_id]['img_limit'] && poip_options_settings[product_option_id]['img_use']) {
          for (var i=0;i<poip_images.length;i++) {
            if (images_to_show[0] == poip_images[i]['popup']) {
              $('#zoom_03').attr('src', poip_images[i]['main']);
              $('#zoom_03').closest('a').attr('href', poip_images[i]['popup']);
              $('.zoomWindowContainer .zoomWindow').css('background-image', 'url("/image/'+poip_images[i]['image']+'"');
              var main_image_switched = true;
            }
          }
          
        }
				
        if (!main_image_switched) {
				
          // потом по выбранной опции
          var selected_values = get_selected_values();
          
          if (value && $.inArray(value, selected_values)!=-1) {
          
            // смена главного изображения
            if (poip_options_settings[product_option_id] && poip_options_settings[product_option_id]['img_change'] ) {
            
              if (poip_images_by_options[value]) {
              
                image = poip_images_by_options[value][0]['image'];
                
                for (var i=0;i<poip_images.length;i++) {
                
                  if (image == poip_images[i]['image']) {
                    $('#zoom_03').attr('src', poip_images[i]['main']);
                    $('#zoom_03').closest('a').attr('href', poip_images[i]['popup']);
                    break;
                  }
                }
              }
                      
            }
          }
        }
        
        // отображение картинок под опцией
        if (poip_options_settings[product_option_id] && poip_options_settings[product_option_id]['img_option'] ) {
          if (!$('product_option_images'+product_option_id).length) {

            // у чекбоксов может быть много значений
            if ($(option).prop('tagName')=='INPUT' && $(option).prop('type')=='checkbox' ) {
              var values = [];
              $('input[type=checkbox][name^='+option_prefix+'\\['+product_option_id+'\\]]:checked').each( function() {
                values.push($(this).val());
              });
            } else {
              var values = [value];
            }
            
            $('#option-images-'+product_option_id).remove();
            if (!$('#option-images-'+product_option_id).length) {
              $('#option-'+product_option_id).append('<div id="option-images-'+product_option_id+'"></div>');
            }
            
            $('#option-images-'+product_option_id).html('');
            for (var i=0; i<poip_images.length; i++) {
              for (var j=0; j<values.length; j++) {
                if (poip_images[i]['product_option_value_id'] && $.inArray(values[j], poip_images[i]['product_option_value_id']) != -1) {
                  var html_image = '<a href="'+poip_images[i]['popup']+'" class="image-additional" style="margin: 5px;"><img src="'+poip_images[i]['thumb']+'" alt="" ></a>';
                  $('#option-images-'+product_option_id).append(html_image);
                }
              }
            }

          }
        }
        
      }
      
      function poip_option_value_selected(option) {
        
        poip_change_images(option);
        
        refresh_colorbox();
        
      }
      
      function refresh_colorbox() {
        
        if (poip_settings['img_gal']) {
        
          $('#poip_colorbox').remove();
          
          $('div[class=image-additional]').after('<div style="display: none" id="poip_colorbox"></div>');
          
          var colorbox_images = [];
          $('div[class=image-additional]').children('a:visible').each(function(){
            if ($.inArray( $(this).attr('href'), colorbox_images) == -1) {
              $('#poip_colorbox').append( $(this).clone().wrap('<div></div>').parent().html().replace('colorbox', 'poip_colorbox') );
              colorbox_images.push($(this).attr('href'));
            }
          });
          
          if ($.inArray($('#zoom_03').parent().attr('href'), colorbox_images) == -1) {
            $('#poip_colorbox').append( $('#zoom_03').parent().clone().wrap('<div></div>').parent().html().replace('colorbox', 'poip_colorbox') );
          }
          
          $.colorbox.remove();
          
          var colorbox_settings = false;
          try {
            var scripts = $('script:contains(".colorbox")');
            for (var i=0; i<scripts.length; i++) {
              var script_html  =$(scripts[i]).html();
              if (script_html.indexOf('$(\'.colorbox\').colorbox(') != -1 ) {
                var str_pos = script_html.indexOf('$(\'.colorbox\').colorbox(');
                var str = script_html.substr(str_pos+24);
                str_pos = str.indexOf('});');
                str = str.substr(0,str_pos+1);
                colorbox_settings = eval('('+str+')');
                break;
              }
            }
          } catch (e) {
            console.debug(e);
            colorbox_settings = false
          }
          
          if (!colorbox_settings || (typeof colorbox_settings) != 'object') {
            console.log('colorbox settings not found');
            colorbox_settings = {
              overlayClose: true,
              opacity: 0.5,
              rel: "colorbox"
            };
          }
          
          $('.poip_colorbox').colorbox(colorbox_settings);
          
          try {
            $('[id^=option-images-]').each( function() {
              
              colorbox_settings['rel'] = $(this).attr('id');
              $(this).children('a').colorbox(colorbox_settings);
              
            });
          } catch(e) {
            console.debug(e);
            console.debug("Ошибка установки colorbox для изображений под опциями");
          }
          
          $('.colorbox').click( function(event) {
            event.preventDefault();
            var poip_colorbox = $('.poip_colorbox');
            for (var i=0; i<poip_colorbox.length; i++) {
              if ($(this).attr('href') == poip_colorbox[i].href) {
                $(poip_colorbox[i]).trigger('click');
                break;
              }
            }
          });
        }
      }
      
      function poip_image_mouseover(image_a) {
        href = $(image_a).attr('href');
        
        for (var i=0;i<poip_images.length;i++) {
          if (poip_images[i]['popup'] && poip_images[i]['popup'] == href) {
            $('#zoom_03').attr('src', poip_images[i]['main']);
            $('#zoom_03').closest('a').attr('href', poip_images[i]['popup']);
            break;
          }
        }
        refresh_colorbox();
      }
      
      function set_option_value(value) {
        
        var options = $('select[name^='+option_prefix+'\\[]').children('option');
        for (var i=0; i<options.length;i++) {
          if (options[i].value == value) {
            $(options[i]).parent().val(value);
            $(options[i]).parent().trigger('change');
            return;
          }
        }
        
        var options = $('input[type=radio][name^='+option_prefix+'\\[]');
        for (var i=0; i<options.length;i++) {
          if (options[i].value == value) {
            options[i].checked = true;
            $(options[i]).trigger('change');
            return;
          }
        }
        
        var options = $('input[type=checkbox][name^='+option_prefix+'\\[]');
        for (var i=0; i<options.length;i++) {
          if (options[i].value == value) {
            options[i].checked = true;
            $(options[i]).trigger('change');
            return;
          }
        }
        
      }
      
      
      
      $("select[name^="+option_prefix+"\\[]").each(function (i) {
        $(this).change(function(){
          poip_option_value_selected(this);
        })
      })
      
      $("input[type=radio][name^="+option_prefix+"\\[]").each(function (i) {
        $(this).change(function(){
          poip_option_value_selected(this);
        })
      })
      
      $("input[type=checkbox][name^="+option_prefix+"\\[]").each(function (i) {
        $(this).change(function(){
          poip_option_value_selected(this);
        })
      })
      
      //images_to_mouseover();
      if (poip_settings['img_hover']) {
        $('div[class=image-additional]').children('a').each(function(i) {
          $(this).mouseover(function(){
            poip_image_mouseover(this);
          });
        });
      }
      
       $(document).ready(function(){
            //poip_set_visible_images(poip_get_global_visible_images());
           // refresh_colorbox();

      <?php
        if (isset($poip_ov) && $poip_ov) {
          echo "set_option_value(\"".(int)$poip_ov."\");";
        }
      ?>
			
			});
      
      //--></script>  
        
      <?php  }  ?>
      <!-- >> Product Option Image PRO module -->
      
<?php echo $footer; ?>