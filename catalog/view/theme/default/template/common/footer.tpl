<div id="footer">
   <div class="column">
      <div id="logo_footer">
         <a href="http://beautyline/index.php?route=common/home"><img src="/catalog/view/theme/default/image/logo_foot_bl.png" title="BEAUTYLINE" alt="BEAUTYLINE"></a>
      </div>
   </div>
   <?php if ($informations) { ?>
          <div class="column">
             <h3><?php echo $text_information; ?></h3>
             <ul>
                <?php foreach ($informations as $information) { ?>
                   <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                <?php } ?>
             </ul>
          </div>
       <?php } ?>
   <div class="column">
      <h3><?php echo $text_service; ?></h3>
      <ul>
         <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
         <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
         <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
      </ul>
   </div>
   <div class="column">
      <h3><?php echo $text_account; ?></h3>
      <ul>
         <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
         <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
         <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
         <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
      </ul>
   </div>
   <div class="column">
      <div id="social">
         <a href="http://facebook.com"><img src="/catalog/view/theme/default/image/fb_bl.png" title="FACEBOOK" alt="FACEBOOK"></a>
         <a href="http://twitter.com"><img src="/catalog/view/theme/default/image/tw_bl.png" title="Twitter" alt="Twitter"></a>
         <a href="http://vk.com"><img src="/catalog/view/theme/default/image/vk_bl.png" title="ВК" alt="ВК"></a>
         
         <div id="powered"><?php echo $powered; ?></div>
      </div>
      
   </div>
</div>
<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->
<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->
<!-- 2014 (c) Izyum Web System www.izyum.name -->
</div>
</body></html>