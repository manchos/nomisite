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
  <?php if ($error) { ?>
  <div class="warning"><?php echo $error; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/product.png" alt="" /> <?php echo $heading_license; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
		<table class="form"
		  <tr>
		    <td class="left" colspan="2"><?php echo $text_license_info; ?></td>
		  </tr>
		  <tr>
			<td class="left"><?php echo $entry_order_id; ?></td>
			<td class="left"><input name="our_products_order_id" type="text" value="<?php echo $our_products_order_id; ?>" size="5" /></td>
		  </tr>
		  <tr>
			<td class="left"><?php echo $entry_product_code; ?></td>
			<td class="left"><input name="product_code" type="text" value="<?php echo $product_code; ?>" size="10" /></td>
		  </tr>
		  <tr>
			<td class="left"><?php echo $entry_license_key; ?></td>
			<td class="left"><input name="our_products_license_key" type="text" value="<?php echo $our_products_license_key; ?>" size="50" /></td>
		  </tr>
		</table>
	  </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>