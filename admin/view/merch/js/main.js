$(function() {
	$(".mytabs a").live('click' , function(e) {
		$('.store-goods').html('');
		$('.module-goods').html('');
	
		module_id = $(this).attr('id-module');
		$(".mytabs a").removeClass('selected');
		$(this).addClass('selected');
		tab = $(this).attr('href');
		e.preventDefault();
		$(".tab").hide();
		$(tab).show();


		$('#store-goods-container-'+module_id).html(loading);
		$('#module-goods-container-'+module_id).html(loading);
		$.ajax({
			type: 'POST',
			dataType: 'html',
			url:  'index.php?route=module/merch/getStoreGoods&token=' + token,
			data: 'id_module='+module_id+'&selected_goods='+$("#merch_product_"+module_id).val(),
			success: function(data) {
				$('#store-goods-container-'+module_id).html(data);
			}
		});
		$.ajax({
			type: 'POST',
			dataType: 'html',
			url:  'index.php?route=module/merch/getModuleGoods&token=' + token,
			data: 'id_module='+module_id+'&selected_goods='+$("#merch_product_"+module_id).val(),
			success: function(data) {
				$('#module-goods-container-'+module_id).html(data);
			}
		});
	});
});