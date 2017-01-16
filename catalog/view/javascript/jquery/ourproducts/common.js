$(document).ready(function() {
	$('.poshytips').poshytip({
		className: 'tip-twitter',
		showTimeout: 1,
		alignTo: 'target',
		alignX: 'center',
		offsetY: 5,
		allowTipHover: false
	});
	
	$('.poshytips-bottom').poshytip({
		className: 'tip-twitter',
		showTimeout: 1,
		alignTo: 'target',
		alignX: 'center',
		alignY:	'bottom',
		offsetX: 5,
		allowTipHover: false
	});
	
	$('.poshytips-left').poshytip({
		className: 'tip-twitter',
		showTimeout: 1,
		alignTo: 'target',
		alignX: 'left',
		alignY:	'center',
		offsetX: 5,
		allowTipHover: false
	});
	
	$('.poshytips-right').poshytip({
		className: 'tip-twitter',
		showTimeout: 1,
		alignTo: 'target',
		alignX: 'right',
		alignY:	'center',
		offsetX: 5,
		allowTipHover: false
	});
	
	$('.colorbox').colorbox({
		overlayClose: true,
		opacity: 0.5,
		width:"1050px",
		height:"760px",
		fixed:true,
		rel: "colorbox"
	});
});
function addToCartQuick(product_id, quantity) {
	quantity = typeof(quantity) != 'undefined' ? quantity : 1;

	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: 'product_id=' + product_id + '&quantity=' + quantity,
		dataType: 'json',
		success: function(json) {
			$('.message-success, .message-warning, .message-attention, .message-information, .message-error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}	
			
			if (json['success']) {
				$('#message-success').after('<div class="message-success" style="display: none;">' + json['success'] + '</div>');
				
				$('.message-success').fadeIn(500).delay(4000).fadeOut(1000);

				$('#cart-total').html(json['total']);
			}	
		}
	});
}
function addToWishListQuick(product_id) {
	$.ajax({
		url: 'index.php?route=account/wishlist/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.message-success, .message-warning, .message-attention, .message-information').remove();

			if (json['success']) {
				$('#message-success').after('<div class="message-success" style="display: none;">' + json['success'] + '</div>');
				
				$('.message-success').fadeIn(500).delay(4000).fadeOut(1000);

				$('#wishlist-total').html(json['total']);
			}	
		}
	});
}
function addToCompareQuick(product_id) { 
	$.ajax({
		url: 'index.php?route=product/compare/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.message-success, .message-warning, .message-attention, .message-information').remove();

			if (json['success']) {
				$('#message-success').after('<div class="message-success" style="display: none;">' + json['success'] + '</div>');
				
				$('.message-success').fadeIn(500).delay(4000).fadeOut(1000);

				$('#compare-total').html(json['total']);
				$('#compare-total-header').html(json['total']);
			}				
		}
	});
}