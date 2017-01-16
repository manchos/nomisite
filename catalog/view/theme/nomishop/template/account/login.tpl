<?php echo $header; ?>

<?php //echo $column_left; ?><?php //echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <!--      <div class="breadcrumb">
    <?php //foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php //echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php //} ?>
  </div>-->
  <h1 class="h1_parangon"><?php echo $heading_title; ?></h1>
  <hr class="content__hr" />
  <?php if ($success) { ?>
    <div class="success"><?php echo $success; ?></div>
    <?php } ?>
    <?php if ($error_warning) { ?>
    <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>  
  <div class="login-content">
 <?php
 //echo $this->config->get('socnetauth2_status');  
 //echo (!$this->customer->isLogged()) ? '!isLogged' : 'isLogged';
			/* start socnetauth2 */
			if( !empty($this->request->get['socnetauth2close']) )
		{
			$this->session->data['socnetauth2_confirmdata_show'] = 0;
		}
                
			if( $this->config->get('socnetauth2_status') )
	{
		if( !$this->customer->isLogged() ) 
		{			
			$http = 'http://';
			if( ( isset($_SERVER['SERVER_PORT']) && $_SERVER['SERVER_PORT'] == '443' ) || 
			!empty($_SERVER['HTTPS']) )
			{
				$http = 'https://';
			}
	
			$this->session->data['socnetauth2_lastlink'] = $http.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
			$this->session->data['socnetauth2_lastlink'] = str_replace("checkout/login", "checkout/checkout", $this->session->data['socnetauth2_lastlink']);

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

			$socnetauth2_code = $this->config->get('socnetauth2_account_code_'.$this->config->get('socnetauth2_account_format'));
			
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
								'<div class="account_socnetauth2_'.$this->config->get('socnetauth2_account_format').'_header">'.$socnetauth2_label[ $this->config->get('config_language_id') ]."</div>", 
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
			
			<?php /* start socnetauth2 code */ ?>
<?php if( $this->config->get('socnetauth2_status') && 
		  $this->config->get('socnetauth2_account_format')=='kvadrat' ) { ?>

<?php } ?>
<?php /* end socnetauth2 code */ ?> 
      <div class="a-left">
        <p><?php echo $text_message_account; ?></p>  
      </div>  
    <div>
        <form class="login-form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <div class="content">
 <?php
			/* start socnetauth2 */
			if( !empty($this->request->get['socnetauth2close']) )
		{
			$this->session->data['socnetauth2_confirmdata_show'] = 0;
		}
			if( $this->config->get('socnetauth2_status') )
	{
		if( !$this->customer->isLogged() ) 
		{			
			$http = 'http://';
			if( ( isset($_SERVER['SERVER_PORT']) && $_SERVER['SERVER_PORT'] == '443' ) || 
			!empty($_SERVER['HTTPS']) )
			{
				$http = 'https://';
			}
	
			$this->session->data['socnetauth2_lastlink'] = $http.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
			$this->session->data['socnetauth2_lastlink'] = str_replace("checkout/login", "checkout/checkout", $this->session->data['socnetauth2_lastlink']);

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

			$socnetauth2_code = $this->config->get('socnetauth2_account_code_'.$this->config->get('socnetauth2_account_format'));
			
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
								'<div class="account_socnetauth2_'.$this->config->get('socnetauth2_account_format').'_header">'.$socnetauth2_label[ $this->config->get('config_language_id') ]."</div>", 
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
			
			<?php /* start socnetauth2 code */ ?>
<?php if( $this->config->get('socnetauth2_status') && 
		  $this->config->get('socnetauth2_account_format')=='kvadrat' ) { ?>

<?php } ?>
<?php /* end socnetauth2 code */ ?> 
		
          <p><?php echo $text_i_am_returning_customer; ?></p>

          
          
          <dl data-form-widget="email" class="form__widget">
              <dt class="form__widget-label"><?php echo $entry_email; ?></dt>
              <dd class="form__widget-content">
                  <input type="email" maxlength="50" data-form-control="email" class="text-field" name="email" value="<?php echo $email; ?>" />
                  <div data-form-error="email" class="form__error" style="display: none;"></div>
                  <div style="display:none;" class="form__hint"></div>
              </dd>
          </dl>
          <dl data-form-widget="password" class="form__widget">
              <dt class="form__widget-label"><?php echo $entry_password; ?></dt>
              <dd class="form__widget-content">
                  <input value="<?php echo $password; ?>" type="password" data-form-control="password" class="text-field" name="password" />
                  <div data-form-error="password" class="form__error"></div>
              </dd>
          </dl>

          <input type="submit" value="<?php echo $button_login; ?>" class="button" />

			
			<?php /* start socnetauth code */ ?>			
<?php if( $this->config->get('socnetauth2_status') && 
		  $this->config->get('socnetauth2_account_format')=='kvadrat' ) { ?>


				<?php echo $SOCNETAUTH2_CODE; ?>
	
<?php } ?>
<?php /* end socnetauth2 code */ ?> 
			
			
			
          <?php if ($redirect) { ?>
          <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
          <?php } ?>
    </div>
        <div class="loginevent a-left">
            <br />
            <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br /></span>
            <br />
            <a href="<?php echo $register; ?>"><?php echo $text_register; ?></a><br />
        </div>
      </form>
        <div class='socnet'>
         <div class="socnet-label"><?php echo $text_socialweb; ?>:</div>
         <div class='socnet-icons'>
            <?php /* start socnetauth2 code */ ?>
                <?php if( $this->config->get('socnetauth2_status') && 
                      ($this->config->get('socnetauth2_account_format')=='bline' || 
                       $this->config->get('socnetauth2_account_format')=='lline'
                      ) ) { ?>
                      <?php echo $SOCNETAUTH2_CODE; ?>
                <?php } ?>
            <?php /* end socnetauth2 code */ ?> 
         </div>
        
    </div>

</div>
  </div>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$('#login input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#login').submit();
	}
});
        $(function () {
            $("select, input, button").uniform();
        });
//--></script> 


<?php echo $footer; ?>