<style>
.widget_account_icons_links
{
	padding-left: 5px;
	padding-right: 5px;
	padding-top: 15px;
	float: left;
}
</style>
<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
      <?php if (!$logged) { ?>
	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td><?php echo $entry_email; ?></td>
		</tr>
		<tr>
			<td><input type="text" name="email" value=""></td>
		</tr>
		<tr>
			<td><?php echo $entry_password; ?></td>
		</tr>
		<tr>
			<td><input type="password" name="password"></td>
		</tr>
		<tr>
			<td>
				<input type="submit" value="<?php echo $text_login; ?>" class="button" />
			</td>
		</tr>
	</table>
	
	
<?php if( $socnetauth2_widget_format == 'kvadrat' ) { ?>
<br>
<div class="content widget_account_socnetauth_kvadrat_content">		
		<div class="widget_account_kvadrat_right">
		<table>
			<tr>
				<?php if( !empty($socnetauth2_socnets[0]) ) { ?><td style="padding: 5px;"><a class="socnetauth2_buttons" 
				href="/socnetauth2/<?php echo $socnetauth2_socnets[0]['key']; ?>.php?first=1"
				><img src="/socnetauth2/icons/<?php echo $socnetauth2_socnets[0]['short']; ?>45.png"></a></td><?php } ?>
				
				<?php if( !empty($socnetauth2_socnets[1]) ) { ?><td style="padding: 5px;"><a class="socnetauth2_buttons" 
				href="/socnetauth2/<?php echo $socnetauth2_socnets[1]['key']; ?>.php?first=1"
				><img src="/socnetauth2/icons/<?php echo $socnetauth2_socnets[1]['short']; ?>45.png"></a></td><?php } ?>
				
				<?php if( !empty($socnetauth2_socnets[2]) ) { ?><td style="padding: 5px;"><a class="socnetauth2_buttons" 
				href="/socnetauth2/<?php echo $socnetauth2_socnets[2]['key']; ?>.php?first=1"
				><img src="/socnetauth2/icons/<?php echo $socnetauth2_socnets[2]['short']; ?>45.png"></a></td><?php } ?>
			</tr>
			<tr>
				<?php if( !empty($socnetauth2_socnets[3]) ) { ?><td style="padding: 5px;"><a class="socnetauth2_buttons" 
				href="/socnetauth2/<?php echo $socnetauth2_socnets[3]['key']; ?>.php?first=1"
				><img src="/socnetauth2/icons/<?php echo $socnetauth2_socnets[3]['short']; ?>45.png"></a></td><?php } ?>
				
				<?php if( !empty($socnetauth2_socnets[4]) ) { ?><td style="padding: 5px;"><a class="socnetauth2_buttons" 
				href="/socnetauth2/<?php echo $socnetauth2_socnets[4]['key']; ?>.php?first=1"
				><img src="/socnetauth2/icons/<?php echo $socnetauth2_socnets[4]['short']; ?>45.png"></a></td><?php } ?>
				
				<?php if( !empty($socnetauth2_socnets[5]) ) { ?><td style="padding: 5px;"><a class="socnetauth2_buttons" 
				href="/socnetauth2/<?php echo $socnetauth2_socnets[5]['key']; ?>.php?first=1"
				><img src="/socnetauth2/icons/<?php echo $socnetauth2_socnets[5]['short']; ?>45.png"></a></td><?php } ?>
			</tr>
		</table>
		</div>
</div>			
<? } ?>		  
<? if( $socnetauth2_widget_format == 'lline' ) { ?>  
		<div class="widget_account_lline_links">
		<table>
			<tr>
				<?php if( !empty($socnetauth2_socnets[0]) ) { ?><td style="padding: 5px;"><a class="socnetauth2_buttons" 
				href="/socnetauth2/<?php echo $socnetauth2_socnets[0]['key']; ?>.php?first=1"
				><img src="/socnetauth2/icons/<?php echo $socnetauth2_socnets[0]['short']; ?>16.png"></a></td><?php } ?>
				<?php if( !empty($socnetauth2_socnets[1]) ) { ?><td style="padding: 5px;"><a class="socnetauth2_buttons" 
				href="/socnetauth2/<?php echo $socnetauth2_socnets[1]['key']; ?>.php?first=1"
				><img src="/socnetauth2/icons/<?php echo $socnetauth2_socnets[1]['short']; ?>16.png"></a></td><?php } ?>
				<?php if( !empty($socnetauth2_socnets[2]) ) { ?><td style="padding: 5px;"><a class="socnetauth2_buttons" 
				href="/socnetauth2/<?php echo $socnetauth2_socnets[2]['key']; ?>.php?first=1"
				><img src="/socnetauth2/icons/<?php echo $socnetauth2_socnets[2]['short']; ?>16.png"></a></td><?php } ?>
				
				<?php if( !empty($socnetauth2_socnets[3]) ) { ?><td style="padding: 5px;"><a class="socnetauth2_buttons" 
				href="/socnetauth2/<?php echo $socnetauth2_socnets[3]['key']; ?>.php?first=1"
				><img src="/socnetauth2/icons/<?php echo $socnetauth2_socnets[3]['short']; ?>16.png"></a></td><?php } ?>
				
				<?php if( !empty($socnetauth2_socnets[4]) ) { ?><td style="padding: 5px;"><a class="socnetauth2_buttons" 
				href="/socnetauth2/<?php echo $socnetauth2_socnets[4]['key']; ?>.php?first=1"
				><img src="/socnetauth2/icons/<?php echo $socnetauth2_socnets[4]['short']; ?>16.png"></a></td><?php } ?>
				
				<?php if( !empty($socnetauth2_socnets[5]) ) { ?><td style="padding: 5px;"><a class="socnetauth2_buttons" 
				href="/socnetauth2/<?php echo $socnetauth2_socnets[5]['key']; ?>.php?first=1"
				><img src="/socnetauth2/icons/<?php echo $socnetauth2_socnets[5]['short']; ?>16.png"></a></td><?php } ?>
			</tr>
		</table>
		</div>		  
<? } ?>	
	</form>
    <ul>
      <li><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a> / <a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
      <li><a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></li>
    </ul>
    <?php } ?>
    
	<?php if ($logged) { ?>
    <ul>
      <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
      <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
      <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
      <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
      <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
      <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
      <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
      <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
      <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
      <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
    </ul>
    <?php } ?>
  </div>
</div>
<?php 
	if( !$this->customer->isLogged() ) 
		{			
			if( !empty($this->session->data['socnetauth2_confirmdata']) && 
				!empty($socnetauth2_confirmdata_show) )
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
		} 
?>