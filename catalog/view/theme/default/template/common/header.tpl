<!DOCTYPE html>
<!-- 2014 (c) Izyum Web System www.izyum.name -->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
   <head>
      <meta charset="UTF-8" />
      <title><?php
             echo $title;
             if (isset($_GET['page'])) {
                echo " - " . ((int) $_GET['page']) . " " . $text_page;
             }
         ?></title>
      <base href="<?php echo $base; ?>" />
      <?php if ($description) { ?>
             <meta name="description" content="<?php
             echo $description;
             if (isset($_GET['page'])) {
                echo " - " . ((int) $_GET['page']) . " " . $text_page;
             }
             ?>" />
                <?php } ?>
            <?php if ($keywords) { ?>
             <meta name="keywords" content="<?php echo $keywords; ?>" />
          <?php } ?>
      <meta property="og:title" content="<?php
          echo $title;
          if (isset($_GET['page'])) {
             echo " - " . ((int) $_GET['page']) . " " . $text_page;
          }
      ?>" />
      <meta property="og:type" content="website" />
      <meta property="og:url" content="<?php echo $og_url; ?>" />
      <?php if ($og_image) { ?>
             <meta property="og:image" content="<?php echo $og_image; ?>" />
          <?php } else { ?>
             <meta property="og:image" content="<?php echo $logo; ?>" />
          <?php } ?>
      <meta property="og:site_name" content="<?php echo $name; ?>" />
      <?php if ($icon) { ?>
             <link href="<?php echo $icon; ?>" rel="icon" />
          <?php } ?>
      <?php foreach ($links as $link) { ?>
             <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
          <?php } ?>
      <link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet.css" />
      <?php foreach ($styles as $style) { ?>
             <link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
          <?php } ?>
      <script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
      <script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
      <link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
      <script type="text/javascript" src="catalog/view/javascript/common.js"></script>
      <script type="text/javascript" src="catalog/view/javascript/jquery/jquery.elevatezoom.js"></script>


      <?php foreach ($scripts as $script) { ?>
             <script type="text/javascript" src="<?php echo $script; ?>"></script>
          <?php } ?>
      <!--[if IE 7]> 
      <link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie7.css" />
      <![endif]-->
      <!--[if lt IE 7]>
      <link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie6.css" />
      <script type="text/javascript" src="catalog/view/javascript/DD_belatedPNG_0.0.8a-min.js"></script>
      <script type="text/javascript">
      DD_belatedPNG.fix('#logo img');
      </script>
      <![endif]-->
      <?php if ($stores) { ?>
             <script type="text/javascript"><!--
             $(document).ready(function() {
       <?php foreach ($stores as $store) { ?>
                      $('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
       <?php } ?>
                });
       //--></script>
          <?php } ?>
      <?php echo $google_analytics; ?>
   </head>
   <body>
      
      <div id="container">
         <div id="header">
            <div id="top"></div>
            <div id="trazd">
               <a href="<?php echo $home; ?>"><img src="catalog/view/theme/default/image/tr_bl.png" title="Таблица разделов" alt="Таблица разделов" /></a>
            </div>
            <div id="slogan">
               <img src="catalog/view/theme/default/image/vkach_bl.png" />
            </div>

            <?php if ($logo) { ?>
                   <div id="logo">
                      <?php if ($home == $og_url) { ?>
                         <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
                      <?php } else { ?>
                         <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
                      <?php } ?>
                   </div>
                <?php } ?>
            <!--
            <?php echo $language; ?>
            -->
            <?php echo $currency; ?>

            <div id="phone">
               <img src="catalog/view/theme/default/image/phon_bl.png" />
            </div>
            <div id="mycart">
               <img src="catalog/view/theme/default/image/cart_bl.png" /> Моя корзина
            </div>
            <div id="iwsphone">
               <?php if ($phone) { ?>
                      <?php echo $phone; ?> 
                   <?php } ?>                
            </div>
            <?php echo $cart; ?>
            <div id="search">
               <div class="button-search"></div>
               <input type="text" name="search"  placeholder="<?php echo $text_search; ?>" value="<?php echo $search; ?>" />
            </div>
            <div id="welcome">
               <?php if (!$logged) { ?>
                      <?php echo $text_welcome; ?>
                   <?php } else { ?>
                      <?php echo $text_logged; ?>
                   <?php } ?>
            </div>

            <!--Menu 2014 (c) Izyum Web System www.izyum.name -->
            <div class="links">
               <div id="sunladymenu">
                  <ul>
                     <?php if (preg_match("/index.php\?route\=common\//i", $_SERVER['REQUEST_URI'])) { ?>
                            <li id="sunladymenuactiv"><a href="<?php echo $home; ?>"><?php echo $text_home; ?></a></li>
                         <?php } else { ?>
                            <li><a href="<?php echo $home; ?>"><?php echo $text_home; ?></a></li>
                         <?php } ?>

                     <?php if (preg_match("/information_id\=6/i", $_SERVER['REQUEST_URI'])) { ?>
                            <li id="sunladymenuactiv"><a href="/index.php?route=information/information&information_id=6">Оплата и доставка</a></li>
                         <?php } else { ?>
                            <li><a href="/index.php?route=information/information&information_id=6">Оплата и доставка</a></li>
                         <?php } ?>

                     <?php if (preg_match("/information_id\=4/i", $_SERVER['REQUEST_URI'])) { ?>
                            <li id="sunladymenuactiv"><a href="/index.php?route=information/information&information_id=4">О магазине</a></li>
                         <?php } else { ?>
                            <li><a href="/index.php?route=information/information&information_id=4">О магазине</a></li>
                         <?php } ?>

                     <?php if (preg_match("/index.php\?route\=product\/manufacturer/i", $_SERVER['REQUEST_URI'])) { ?>
                            <li id="sunladymenuactiv"><a href="index.php?route=product/manufacturer" >Производители</a></li>
                         <?php } else { ?>
                            <li><a href="index.php?route=product/manufacturer" >Производители</a></li>
                         <?php } ?>

                     <?php if (preg_match("/index.php\?route\=information\/contact/i", $_SERVER['REQUEST_URI'])) { ?>
                            <li id="sunladymenuactiv"><a href="/index.php?route=information/contact">Контакты</a></li>
                         <?php } else { ?>
                            <li><a href="/index.php?route=information/contact">Контакты</a></li>
                         <?php } ?>

                     <?php if (preg_match("/index.php\?route\=checkout\/checkout/i", $_SERVER['REQUEST_URI'])) { ?>
                            <li id="sunladymenuactiv"><a href="/index.php?route=checkout/checkout"><?php echo $text_checkout; ?></a></li>
                         <?php } else { ?>
                            <li><a href="/index.php?route=checkout/checkout"><?php echo $text_checkout; ?></a></li>
                         <?php } ?>
                  </ul>
               </div>
            </div>
            <!--Menu 2014 (c) Izyum Web System www.izyum.name -->
         </div>
         
         <div id="notification"></div>
