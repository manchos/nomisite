<!-- 2014 (c) Izyum Web System www.izyum.name -->
<?php //echo $header; ?>
<?php //echo $column_left; ?>
<?php //echo $column_right; ?>

<?php if ($products) { ?>
          <div class="product-filter">
             <div class="display"><b><?php echo $text_display; ?></b> <a onclick="display('list');"><?php echo $text_list; ?></a> <b>/</b> <?php echo $text_grid; ?></div>
             <div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>
          </div>
          <div class="product-grid">
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
                   <div class="cart">
                   
                      <input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" />
                   </div>
                   <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');"><?php echo $button_wishlist; ?></a></div>
                   <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');"><?php echo $button_compare; ?></a></div>
                </div>
             <?php } ?>
          </div>
          <?php if (!empty($pagination)){ ?>
          <div class="pagination"><?php echo $pagination; ?></div>
          <?php } ?>
       <?php } ?>
<script type="text/javascript"><!--
    function display(view) {
      if (view == 'list') {
         $('.product-grid').attr('class', 'product-list');

         $('.product-list > div').each(function(index, element) {
            html = '<div class="right">';
            var price = $(element).find('.price').html();

            if (price != null) {
               html += '<div class="price">' + price + '</div>';
            }
            html += '  <div class="cart">' + $(element).find('.cart').html() + '</div>';
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
            html += '<div class="cart">' + $(element).find('.cart').html() + '</div>';
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
<?php //echo $footer; ?>
 
