<?php echo $header; ?>

<?php //echo $column_left; ?><?php //echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <h1  class="h1_parangon"><?php echo $heading_title; ?></h1>
  <hr class="content__hr" />
    <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <p><?php echo $text_account_already; ?></p>

		
			
    <?php if ($error_warning) { ?>
    <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
  <form id="SignupForm" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <div class="regstep">
      <h2 class="condensed"><?php echo $text_your_password; ?></h2>
      <table class="form">
        <tr>
          <td><span class="required">*</span> <?php echo $entry_email; ?></td>
          <td class="a-left"><input class="text-field" type="text" name="email" value="<?php echo $email; ?>" />
            <?php if ($error_email) { ?>
            <span class="error"><?php echo $error_email; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_password; ?></td>
          <td class="a-left"><input class="text-field" id="password" type="password" name="password" value="<?php echo $password; ?>" />
            <?php if ($error_password) { ?>
            <span class="error"><?php echo $error_password; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_confirm; ?></td>
          <td class="a-left"><input class="text-field" type="password" name="confirm" value="<?php echo $confirm; ?>" />
            <?php if ($error_confirm) { ?>
            <span class="error"><?php echo $error_confirm; ?></span>
            <?php } ?></td>
        </tr>
      </table>
    </div>
    <div class="regstep">
      <h2 class="condensed"><?php echo $text_your_details; ?></h2>
      <table class="form">
        <tr>
          <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
          <td class="a-left"><input class="text-field" type="text" name="firstname" value="<?php echo $firstname; ?>" />
            <?php if ($error_firstname) { ?>
            <span class="error"><?php echo $error_firstname; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
          <td class="a-left"><input class="text-field" type="text" name="lastname" value="<?php echo $lastname; ?>" />
            <?php if ($error_lastname) { ?>
            <span class="error"><?php echo $error_lastname; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_gender; ?></td>
          <td class="a-left">
            <select name="gender">
                <option value="" selected="selected">Выберите пол</option>
                <option value="F">Женский</option>
                <option value="M">Мужской</option>
            </select>
             <!--  <input class="text-field" type="text" name="gender" value="<?php echo $gender; ?>" /> -->
            <?php if ($error_gender) { ?>
            <span class="error"><?php echo $error_gender; ?></span>
            <?php } ?></td>
          
    <!--
    lamoda        
            <div data-form-control="gender" class="select widget__control">
                <input type="hidden" value="F" name="gender">
                    <span class="button">
                        <span class="button__title">Женский</span>
                    </span>
                <ul class="dropdown">
                    <li data-option-value="F" class="select__item select__item_current">
                        <span class="select__item-label">Женский</span>
                        <i class="select__tick"></i>
                    </li>
                    <li data-option-value="M" class="select__item">
                        <span class="select__item-label">Мужской</span>
                        <i class="select__tick"></i>
                    </li>
                </ul>                                        
            </div>
    -->
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_birthdate; ?></td>
          <td class="a-left"><input class="text-field" type="text" id="birthdate" name="birthdate" value="<?php echo $birthdate; ?>" />
            <?php if ($error_birthdate) { ?>
            <span class="error"><?php echo $error_birthdate; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
          <td class="a-left"><input class="text-field" type="text" id="telephone" name="telephone" value="<?php echo $telephone; ?>" />
            <?php if ($error_telephone) { ?>
            <span class="error"><?php echo $error_telephone; ?></span>
            <?php } ?></td>
        </tr>
<!--         <tr>
          <td><?php echo $entry_fax; ?></td>
          <td class="a-left"><input class="text-field" type="text" name="fax" value="<?php echo $fax; ?>" /></td>
        </tr> -->
      </table>
    </div>
    
    <div class="regstep">
      <h2 class="condensed"><?php echo $text_your_address; ?></h2>
      <table class="form">
<!--         <tr>
          <td><?php echo $entry_company; ?></td>
          <td class="a-left"><input class="text-field" type="text" name="company" value="<?php echo $company; ?>" /></td>
        </tr>  -->       
        <tr style="display: <?php echo (count($customer_groups) > 1 ? 'table-row' : 'none'); ?>;">
          <td><?php echo $entry_customer_group; ?></td>
          <td class="a-left"><?php foreach ($customer_groups as $customer_group) { ?>
            <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
            <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
            <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
            <br />
            <?php } else { ?>
            <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
            <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
            <br />
            <?php } ?>
            <?php } ?></td>
        </tr>      
<!--         <tr id="company-id-display">
          <td><span id="company-id-required" class="required">*</span> <?php echo $entry_company_id; ?></td>
          <td class="a-left"><input class="text-field" type="text" name="company_id" value="<?php echo $company_id; ?>" />
            <?php if ($error_company_id) { ?>
            <span class="error"><?php echo $error_company_id; ?></span>
            <?php } ?></td>
        </tr> -->
        <tr id="tax-id-display">
          <td><span id="tax-id-required" class="required">*</span> <?php echo $entry_tax_id; ?></td>
          <td class="a-left"><input class="text-field" type="text" name="tax_id" value="<?php echo $tax_id; ?>" />
            <?php if ($error_tax_id) { ?>
            <span class="error"><?php echo $error_tax_id; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_address_1; ?></td>
          <td class="a-left"><input class="text-field" type="text" name="address_1" value="<?php echo $address_1; ?>" />
            <?php if ($error_address_1) { ?>
            <span class="error"><?php echo $error_address_1; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $entry_address_2; ?></td>
          <td class="a-left"><input class="text-field" type="text" name="address_2" value="<?php echo $address_2; ?>" /></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_city; ?></td>
          <td class="a-left"><input class="text-field" type="text" name="city" value="<?php echo $city; ?>" />
            <?php if ($error_city) { ?>
            <span class="error"><?php echo $error_city; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span id="postcode-required" class="required">*</span> <?php echo $entry_postcode; ?></td>
          <td class="a-left"><input class="text-field" type="text" name="postcode" value="<?php echo $postcode; ?>" />
            <?php if ($error_postcode) { ?>
            <span class="error"><?php echo $error_postcode; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_country; ?></td>
          <td class="a-left"><select name="country_id">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country) { ?>
              <?php if ($country['country_id'] == $country_id) { ?>
              <option value="<?php echo $country['country_id']; ?>" data-iso2="<?php echo $country['iso_code_2']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $country['country_id']; ?>" data-iso2="<?php echo $country['iso_code_2']; ?>"><?php echo $country['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
            <?php if ($error_country) { ?>
            <span class="error"><?php echo $error_country; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_zone; ?></td>
          <td class="a-left">
            <select name="zone_id">
                <option value=""> --- Выберите --- </option>
                <option value="2761">Москва(в пределах МКАД)</option>
                <option value="2722">Московская область(30км от МКАД)</option>
            </select>
            <?php if ($error_zone) { ?>
            <span class="error"><?php echo $error_zone; ?></span>
            <?php } ?></td>
        </tr>
      </table>
        <div>
          <h2 class="condensed"><?php echo $text_newsletter; ?></h2>
          <table class="form">
            <tr>
              <td><?php echo $entry_newsletter; ?></td>
              <td class="a-left"><?php if ($newsletter) { ?>
                <input type="radio" name="newsletter" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="newsletter" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
          </table>
        </div>
      <?php if ($text_agree) { ?>
    <div class="buttons">
      <div class="left"><?php echo $text_agree; ?>
        <?php if ($agree) { ?>
        <input type="checkbox" name="agree" value="1" checked="checked" />
        <?php } else { ?>
        <input type="checkbox" name="agree" value="1" />
        <?php } ?>
        <br /><br /><input type="submit" value="<?php echo $button_continue; ?>" class="button" />
      </div>
    </div>
    <?php } else { ?>
    <div class="buttons">
      <div class="right">
        <input type="submit" value="<?php echo $button_continue; ?>" class="button" />
      </div>
    </div>
    <?php } ?>
    </div>
  </form>
    
  <?php echo $content_bottom; ?>
</div>
	<?php	/* start socnetauth2 */
		if( !empty($this->request->get['socnetauth2close']) )
		{
			$this->session->data['socnetauth2_confirmdata_show'] = 0;
		}
		$SOCNETAUTH2_CODE = '';
	if( $this->config->get('socnetauth2_status') )
	{
	
		$http = 'http://';
		if( ( isset($_SERVER['SERVER_PORT']) && $_SERVER['SERVER_PORT'] == '443' ) || 
		  !empty($_SERVER['HTTPS']) )
		{
			$http = 'https://';
		}
		$this->session->data['socnetauth2_lastlink'] = $http.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
		$this->session->data['socnetauth2_lastlink'] = str_replace("checkout/login", "checkout/checkout", $this->session->data['socnetauth2_lastlink']);

		if( !$this->customer->isLogged() ) 
		{			
			if( !empty($this->session->data['socnetauth2_confirmdata']) && 
				!empty($this->session->data['socnetauth2_confirmdata_show']) )
			{
				$data = unserialize( $this->session->data['socnetauth2_confirmdata'] );
				$socnetauth2_confirm_block = $this->config->get('socnetauth2_confirm_block');
				$socnetauth2_confirm_block = str_replace("#divframe_height#", (300-(32*(5-(count(unserialize($this->session->data['socnetauth2_confirmdata'])))))), $socnetauth2_confirm_block );
	
				$socnetauth2_confirm_block = str_replace("#frame_height#", (320-(32*(5-(count(unserialize($this->session->data['socnetauth2_confirmdata'])))))), $socnetauth2_confirm_block);
	
				if( strstr($this->session->data['socnetauth2_lastlink'], "?") )
				$socnetauth2_confirm_block = str_replace("#lastlink#", $this->session->data['socnetauth2_lastlink'].'&socnetauth2close=1', $socnetauth2_confirm_block);
				else
				$socnetauth2_confirm_block = str_replace("#lastlink#", $this->session->data['socnetauth2_lastlink'].'?socnetauth2close=1', $socnetauth2_confirm_block);
	
				$socnetauth2_confirm_block = str_replace("#frame_url#", $this->url->link( 'account/socnetauth2/frame' ), $socnetauth2_confirm_block);
	
				echo $socnetauth2_confirm_block;
			}

			$socnetauth2_code = $this->config->get('socnetauth2_reg_code_'.$this->config->get('socnetauth2_reg_format'));
			
			$socnetauth2_label = '';
			
			if( 
				$this->config->get('socnetauth2_label') && !is_array( $this->config->get('socnetauth2_label') ) &&
				stristr($this->config->get('socnetauth2_label'), '{' ) != false &&
				stristr($this->config->get('socnetauth2_label'), '}' ) != false &&
				stristr($this->config->get('socnetauth2_label'), ';' ) != false &&
				stristr($this->config->get('socnetauth2_label'), ':' ) != false
			)
			{
				$socnetauth2_label = unserialize($this->config->get('socnetauth2_label'));
			}
			else
			{
				$socnetauth2_label = $this->config->get('socnetauth2_label');
			}
	
	
			if( !empty($socnetauth2_label[ $this->config->get('config_language_id') ]) )
			{
				$socnetauth2_code = str_replace("#socnetauth2_label#", 
								'<div class="reg_socnetauth2_'.$this->config->get('socnetauth2_reg_format').'_header">'.$socnetauth2_label[ $this->config->get('config_language_id') ]."</div>", 
								$socnetauth2_code );
			}
			else
			{
				$socnetauth2_code = str_replace("#socnetauth2_label#", "", $socnetauth2_code );
			}
			
			$SOCNETAUTH2_CODE = $socnetauth2_code;
			echo $SOCNETAUTH2_CODE;
		} 
	}
/* end socnetauth2 */ ?>
<script type="text/javascript"><!--
           function MakeWizard() {
            $("#SignupForm").formToWizard({ submitButton: 'SaveAccount' })
            $("#makeWizard").hide();
            $("#info").fadeIn(400);
        }    
    
        $(function () {
            $("select, input, button").uniform();
        });    
$('input[name=\'customer_group_id\']:checked').live('change', function() {
	var customer_group = [];
	
<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
<?php } ?>	

	if (customer_group[this.value]) {
		if (customer_group[this.value]['company_id_display'] == '1') {
			$('#company-id-display').show();
		} else {
			$('#company-id-display').hide();
		}
		
		if (customer_group[this.value]['company_id_required'] == '1') {
			$('#company-id-required').show();
		} else {
			$('#company-id-required').hide();
		}
		
		if (customer_group[this.value]['tax_id_display'] == '1') {
			$('#tax-id-display').show();
		} else {
			$('#tax-id-display').hide();
		}
		
		if (customer_group[this.value]['tax_id_required'] == '1') {
			$('#tax-id-required').show();
		} else {
			$('#tax-id-required').hide();
		}	
	}
});

$('input[name=\'customer_group_id\']:checked').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=account/register/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#postcode-required').show();
			} else {
				$('#postcode-required').hide();
			}
			
			html = '<option value="" ><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'country_id\']').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.colorbox').colorbox({
		width: 640,
		height: 480
	}); 
            $("#SignupForm").formToWizard({ submitButton: 'SaveAccount' })
            $("#makeWizard").hide();
            $("#info").fadeIn(400);
});
//--></script> 
<?php echo $footer; ?>