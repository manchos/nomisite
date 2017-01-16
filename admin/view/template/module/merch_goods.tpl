<table class="merch-goods-table" width="100%" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<th><?php echo $text_instore ?></th>
		<th><?php echo $text_inmodule ?></th>
	</tr>
	<tr>
	<td align="left" valign="top" width="50%">
		<div id="store-goods-container">
		</div>
	</td>
	<td align="left" valign="top" width="50%">
		<div id="module-goods-container">
		</div>
	</td>
	</tr>
	<tr>
	<td align="left" valign="top" width="50%">
	</td>
	<td align="left" valign="top" width="50%">
	</td>
	</tr>
</table>
<script type="text/javascript">
$(function() {
	$(".pagination a").click(function() {
	$('#store-goods-container').html(loading);
		$.post('index.php?route=module/merch/getStoreProducts&token=' + token, function(html) {
			$('#store-goods-container').html(html);
		});	
	});
});
</script>