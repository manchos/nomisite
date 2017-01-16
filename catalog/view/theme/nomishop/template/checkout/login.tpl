<?php
/* start socnetauth2 */
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

			$socnetauth2_code = $this->config->get('socnetauth2_checkout_code_'.$this->config->get('socnetauth2_checkout_format'));
			
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
								'<div class="checkout_socnetauth2_'.$this->config->get('socnetauth2_checkout_format').'_header">'.$socnetauth2_label[ $this->config->get('config_language_id') ]."</div>", 
								$socnetauth2_code );
			}
			else
			{
				$socnetauth2_code = str_replace("#socnetauth2_label#", "", $socnetauth2_code );
			}
			
			$SOCNETAUTH2_CODE = $socnetauth2_code;
		} 
	}
/* end socnetauth2 */ ?>

<div class="left">
  <h2><?php echo $text_new_customer; ?></h2>
  <p><?php echo $text_checkout; ?></p>
  <label for="register">
    <?php if ($account == 'register') { ?>
    <input type="radio" name="account" value="register" id="register" checked="checked" />
    <?php } else { ?>
    <input type="radio" name="account" value="register" id="register" />
    <?php } ?>
    <b><?php echo $text_register; ?></b></label>
  <br />
  <?php if ($guest_checkout) { ?>
  <label for="guest">
    <?php if ($account == 'guest') { ?>
    <input type="radio" name="account" value="guest" id="guest" checked="checked" />
    <?php } else { ?>
    <input type="radio" name="account" value="guest" id="guest" />
    <?php } ?>
    <b><?php echo $text_guest; ?></b></label>
  <br />
  <?php } ?>
  <br />
  <p><?php echo $text_register_account; ?></p>
  <P>После оформления заказа, с Вами свяжется наш менеджер, для подтверждения заказа и уточнения нюансов.</P>
  <!-- <input type="button" value="<?php echo $button_continue; ?>" id="button-account" class="button" /> -->
  <br />
  <br />
</div>
<div id="login" class="right">
  <h2><?php echo $text_returning_customer; ?></h2>
  <? /* start socnetauth2 code */ ?>
<table>
		<tr>
		<td>
<? /* end socnetauth2 code */ ?>
  <p><?php echo $text_i_am_returning_customer; ?></p>
  <b><?php echo $entry_email; ?></b><br />
  <input type="text" name="email" value="" />
  <br />
  <br />
  <b><?php echo $entry_password; ?></b><br />
  <input type="password" name="password" value="" />
  <br />
  <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />
  <br />
  <input type="button" value="<?php echo $button_login; ?>" id="button-login" class="button" /><br />
  <br />
  <? /* start socnetauth code */ ?>			
<?php if( $this->config->get('socnetauth2_status') && 
		  $this->config->get('socnetauth2_checkout_format')=='kvadrat' ) { ?>

		  </td>
		  <td>
				<?php echo $SOCNETAUTH2_CODE; ?>
		  </td>
		   </tr>
		</table>
<?php } ?>
<? /* end socnetauth2 code */ ?> 
</div>
<? /* start socnetauth2 code */ ?>
<?php if( $this->config->get('socnetauth2_status') && 
		  ($this->config->get('socnetauth2_checkout_format')=='bline' || 
		   $this->config->get('socnetauth2_checkout_format')=='lline'
		  ) ) { ?>
		  
		  <?php echo $SOCNETAUTH2_CODE; ?>
		  
<?php } ?>
<? /* end socnetauth2 code */ ?> 