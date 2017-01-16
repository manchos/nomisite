<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
   <div class="content-title">
       <div class="h2_parangon_left">
           <a class="content-title__a" href="<?php echo $cathref; ?>">
             <?php echo $heading_title; ?>
           </a>
       </div>
       
       <?php 
       //print_r($breadcrumbs);
       if (isset($categories_in_coll) and $categories_in_coll) { ?>
        <nav class="catincollmenu">
           <ul class="catincollmenu__list">
                <?php foreach ($categories_in_coll as $category) { ?>
                <li><a href="<?php echo $category['seopro']; ?>" 
                        > <?php 
                        //echo $category['name'].' ('.$category['count'].')';
                        echo $category['name'];
                        ?></a></li>

                <?php } ?>
            </ul>
        </nav>
       <?php } ?> 
       <?php 
       //print_r($category_not_coll);
       if (!empty($category_not_coll)) { ?>
       
            <nav class="catincollmenu">
            <ul class="catincollmenu__list">
                <?php foreach ($category_not_coll as $key=>$coll) { ?>
                <li>
                    <?php if (!empty($coll['seopro'])){ ?>
                        <a href="<?=$coll['seopro']?>" class="current">
                            <?php echo $coll['coll-name'].' ('.$coll['count'].')'; ?>
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
   
   <?php if ($thumb || $description) { ?>
          <div class="category-info">
             <?php if ($thumb) { ?>
                <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
             <?php } ?>
             <?php if ($description) { ?>
                <?php echo $description; ?>
             <?php } ?>
          </div>
       <?php } ?>
   <?php if (!empty($categories)) { ?>
          <h2><?php echo $text_refine; ?></h2>
          <div class="category-list">
             <?php if (count($categories) <= 5) { ?>
                <ul>
                   <?php foreach ($categories as $category) { ?>
                      <li><a href="<?php echo $category['href']; ?>"><img src="<?php echo $category['thumb']; ?>"><span><?php echo $category['name']; ?></a></span></li>
                   <?php } ?>
                </ul>
             <?php } else { ?>
                <?php for ($i = 0; $i < count($categories);) { ?>
                   <ul>
                      <?php $j = $i + ceil(count($categories) / 4); ?>
                      <?php for (; $i < $j; $i++) { ?>
                         <?php if (isset($categories[$i])) { ?>
                            <li><a href="<?php echo $categories[$i]['href']; ?>"><img src="<?php echo $categories[$i]['thumb']; ?>"><span><?php echo $categories[$i]['name']; ?></span></a></li>
                         <?php } ?>
                      <?php } ?>
                   </ul>
                <?php } ?>
             <?php } ?>
          </div>
       <?php } ?>
   <?php if ($products) { ?>
          <div class="product-filter">
             <div class="display"><b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display('grid');"><?php echo $text_grid; ?></a></div>
             <div class="limit"><b><?php echo $text_limit; ?></b>
                <select onchange="location = this.value;">
                   <?php foreach ($limits as $limits) { ?>
                      <?php if ($limits['value'] == $limit) { ?>
                         <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
                      <?php } else { ?>
                         <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
                      <?php } ?>
                   <?php } ?>
                </select>
             </div>
             <div class="sort"><b><?php echo $text_sort; ?></b>
                <select onchange="location = this.value;">
                   <?php foreach ($sorts as $sorts) { ?>
                      <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                         <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                      <?php } else { ?>
                         <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                      <?php } ?>
                   <?php } ?>
                </select>
             </div>
             <div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>
          </div>
          <div class="product-list">
             <?php foreach ($products as $product) { ?>
                <div>
                   <?php if ($product['thumb']) { ?>
                      <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
                   <?php } ?>
                   <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name'].'<br />'.$product['color']; ?></a></div>
                   <div class="description"><?php echo $product['description']; ?></div>
                   <!-- 2014 (c) Izyum Web System www.izyum.name -->
                      <?php if ($product['price']) { ?>
                         <div class="price">
                            <?php if (!$product['special']) { ?>
                               <?php echo $product['price']; ?>
                            <?php } else { ?>
                               <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
                            <?php } ?>
                            
                         </div>
                      <?php } ?>
<!--                  <div class="cart">
                   
                      <input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" />
                   </div>-->
                   <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');"><?php echo $button_wishlist; ?></a></div>
                   <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');"><?php echo $button_compare; ?></a></div>
                </div>
             <?php } ?>
          </div>
          <!-- <div class="pagination"><?php echo $pagination; ?></div> -->
       <?php } ?>
   <?php if (empty($categories) && empty($products)) { ?>
          <div class="content"><?php echo $text_empty; ?></div>
          <div class="buttons">
             <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
          </div>
       <?php } ?>
   <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
    $('.h2_parangon_left').each( function( index, element ){
               // console.log( $( this ).text() );
                //var our_string = "something";	
                if($( this ).text().indexOf('2014') + 1) {
                    var tt = $( this ).text().replace(/2014/gim, '');
                    //$( this ).text(tt);
                    $( this ).html(tt+"<img src='image/14_icon_43.png' align='middle' />");
                }
              //@TODO сделать с помощью регулярных выражений чтобы 
              //на любой год можно было прикрепить соответствующий img
              //2014  -  2014col.jpg
              //2017  - 2017 col.jpg

                if($( this ).text().indexOf('2015') + 1){
                    var tt = $( this ).text().replace(/2015/gim, '');
                    //$( this ).text(tt);
                    $( this ).html(tt+"<img src='image/15_icon_43.png' align='middle' />");
                }

            });
    
    function display(view) {
      if (view == 'list') {
         $('.product-grid').attr('class', 'product-list');

         $('.product-list > div').each(function(index, element) {
            html = '<div class="right">';
            var price = $(element).find('.price').html();

            if (price != null) {
               html += '<div class="price">' + price + '</div>';
            }
            //html += '  <div class="cart">' + $(element).find('.cart').html() + '</div>';
            html += '  <div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
            html += '  <div class="compare">' + $(element).find('.compare').html() + '</div>';
            html += '</div>';

            html += '<div class="left">';

            var image = $(element).find('.image').html();

            if (image != null) {
               html += '<div class="image">' + image + '</div>';
            }



            html += '  <div class="name">' + $(element).find('.name').html() + '</div>';
            html += '  <div class="description">' + $(element).find('.description').html() + '</div>';

            var rating = $(element).find('.rating').html();

            if (rating != null) {
               html += '<div class="rating">' + rating + '</div>';
            }

            html += '</div>';

            $(element).html(html);
         });

         $('.display').html('<b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display(\'grid\');"><?php echo $text_grid; ?></a>');

         $.totalStorage('display', 'list');
      } else {
         $('.product-list').attr('class', 'product-grid');

         $('.product-grid > div').each(function(index, element) {
            html = '';

            var image = $(element).find('.image').html();

            if (image != null) {
               html += '<div class="image">' + image + '</div>';
            }

            html += '<div class="name">' + $(element).find('.name').html() + '</div>';
            html += '<div class="description">' + $(element).find('.description').html() + '</div>';



            var rating = $(element).find('.rating').html();

            if (rating != null) {
               html += '<div class="rating">' + rating + '</div>';
            }
            var price = $(element).find('.price').html();

            if (price != null) {
               html += '<div class="price">' + price + '</div>';
            }
            //html += '<div class="cart">' + $(element).find('.cart').html() + '</div>';
            html += '<div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
            html += '<div class="compare">' + $(element).find('.compare').html() + '</div>';

            $(element).html(html);
         });

         $('.display').html('<b><?php echo $text_display; ?></b> <a onclick="display(\'list\');"><?php echo $text_list; ?></a> <b>/</b> <?php echo $text_grid; ?>');

         $.totalStorage('display', 'grid');
      }
   }

   view = $.totalStorage('display');

   if (view) {
      display(view);
   } else {
      display('list');
   }
//--></script> 
<?php echo $footer; ?>
 