<!-- 2014 (c) Izyum Web System www.izyum.name -->
<?php echo $header; ?><?php //echo $column_left; ?><?php //echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
   <h1 class="h2_parangon_center h3_parangon_upper"><?php echo $heading_title; ?></h1>
   <hr class="content__hr" />
   <br />
   <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
      <div class="contact-info">
        <div class="d-row">  
         <div class="iwsleft_contact">
      <!-- <h2 class="condensed"><?php echo $text_location; ?></h2> -->
            <div class="content">
               <?php //echo $store; ?><br />
                              <?php if ($telephone) { ?>
                      <b><?php echo $text_telephone; ?></b><br />
                      <?php echo $telephone; ?><br />
                      <br />
                      
                   <?php } ?>
               
               <strong>Клиентам:</strong><br />
               Дорогие девушки, у нас действует пропускная система, поэтому, если Вы хотите посетить наш шоу-рум, просим Вас заранее связаться с нами! 
               <br />
               <br />
               <strong>Шоу-рум:</strong><br />
               г. Москва, ст. м. Тушинская, <br />Волоколамское шоссе, д. 89. 
               <br />
               <br />
               <strong>Режим работы:</strong><br />
               Понедельник - Пятница <br />с 12:00 до 20:00
               <br />
               <br />
               <strong>Для оформления заказа или уточнения информации по заказу:</strong><br />
               sales@n-o-m-i.ru
               <br />
               <br />
               <strong>Либо Вы можете воспользоваться формой обратной связи, которая находится справа.</strong>  
               <br />
               <p>
	               <strong>Партнерам:</strong><br />
	            Уважаемые Господа,<br />
				Компания «Н.О.М.И» предлагает взаимовыгодное сотрудничество магазинам и шоу-румам.<br />
				Для получения информации об условиях работы свяжитесь с нами любым удобным для Вас способом:
	               <br />
	            8(495)134-34-37 <br />
	            info@n-o-m-i.ru              
	           </p>
               <b><?php //echo $text_address; ?></b><br />
               <?php //echo $address; ?><br />
               <br />

               <?php if ($fax) { ?>
                      <b><?php echo $text_fax; ?></b><br />
                      <?php echo $fax; ?>
                   <?php } ?>
            </div>


         </div>

         <div class="iwsright_contact">
            <!--<h2 class="condensed"><?php echo $text_contact; ?></h2> -->
            <b><?php echo $entry_name; ?></b><br />
            <input type="text" name="name" value="<?php echo $name; ?>" />
            <br />
            <?php if ($error_name) { ?>
                   <span class="error"><?php echo $error_name; ?></span>
                <?php } ?>
            <br />
            <b><?php echo $entry_email; ?></b><br />
            <input type="text" name="email" value="<?php echo $email; ?>" />
            <br />
            <?php if ($error_email) { ?>
                   <span class="error"><?php echo $error_email; ?></span>
                <?php } ?>
            <br />
            <b><?php echo $entry_enquiry; ?></b><br />
            <textarea name="enquiry" cols="40" rows="10" style="width: 98%;"><?php echo $enquiry; ?></textarea>
            <br />
            <?php if ($error_enquiry) { ?>
                   <span class="error"><?php echo $error_enquiry; ?></span>
                <?php } ?>
            <br />
		    <b><?php echo $entry_captcha; ?></b>

		    <input type="text" name="captcha" value="<?php echo $captcha; ?>" />
		    

		    <img src="index.php?route=information/contact/captcha" alt="" />
		    <?php if ($error_captcha) { ?>
		    <span class="error"><?php echo $error_captcha; ?></span>
		    <?php } ?>
            
                <input type="submit" value="<?php echo $button_continue; ?>" class="button" />

         </div>
        </div>
      </div>


   </form>
   <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
    $(document).ready(function() {
        $("select, input, button").uniform();
    });
-->
</script>
<?php echo $footer; ?>
