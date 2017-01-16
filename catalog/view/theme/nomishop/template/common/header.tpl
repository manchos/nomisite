<!DOCTYPE html>
<!-- 2014 (c) Izyum Web System www.izyum.name -->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
   <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
      <link rel="stylesheet" type="text/css" href="catalog/view/theme/nomishop/stylesheet/style.css" />
      <?php foreach ($styles as $style) { ?>

             <link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
          <?php } ?>


        <script type="text/javascript" src="catalog/view/javascript/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/jquery/jquery-migrate-1.0.0.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.js"></script>
              <?php foreach ($scripts as $script) { ?>
             <script type="text/javascript" src="<?php echo $script; ?>"></script>
          <?php } ?>

            <script type="text/javascript" src="catalog/view/javascript/common.js"></script>





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
           //("user-menu__welcome a.user-menu__a").hover(function(){
             //$('.follows__item follows__item_welcome').hover();
             //})


                });
       //--></script>
          <?php } ?>
      <?php echo $google_analytics; ?>
   </head>
   <body>
        <div id="page">
            <div class="header_fon">
                <a href="/"><img  alt="N.O.M.I" id="logo" src="catalog/view/theme/nomishop/image/logo.png" /></a>
                        <div class="header__inner">
                            <div class="follows header_left">
                                <a class="follows__item follows__item_vk" target="blank" href="https://vk.com/nomidesign"></a>
                                <a class="follows__item follows__item_ins" target="blank" href="https://instagram.com/n.o.m.i_design/"></a>
                                <a class="follows__item follows__item_fb" target="blank" href="https://www.facebook.com/Nomiwear?ref=bookmarks"></a>
                            </div>
                            <div class="user-menu header_reight">
                                <div class="user-menu__welcome">
                                    <a class="user-menu__a" href="/login/">Личный кабинет</a>
                                    <i class="follows__item follows__item_welcome"></i>
                                </div>
                                <div class="user-menu__cart">
                                     <a  class="user-menu__a" href="/shopping-cart/">Ваша корзина</a>
                                     <i class="follows__item follows__item_cart"></i>
                                </div>
                            </div>
                        </div>
            </div>
            <div id="page__inner">
                <div id="header">
                    <div class="header__sizefix">
                        <div class="header__menu">

                                <ul class="top-menu">
                                    <li><a href="/collection/">КОЛЛЕКЦИИ</a>
                                        <ul>
                                            <li><a href="/collection/">Все коллекции</a></li>
                                            <?php 
                                            //print_r($colls);
                                            foreach($colls as $key => $cat) {?>
                                            <li>
                                                <a href="<?php echo $cat['collinfo']['seopro']; ?>"><?php echo $cat['collinfo']['name']; ?></a>
                                                <!--<ul>
                                                <?php //foreach($cat['cats'] as $k => $catinfo) {?>
                                                    <li><a href="<?php echo $catinfo['seopro'];?>"><?php echo $catinfo['name'];?></a></li>
                                                <?php //}?>
                                                </ul>
                                                -->
                                            </li>
                                            <?php }?>
                                        </ul>
                                    </li>
                                    <?php if (preg_match("/index.php\?route\=common\//i", $_SERVER['REQUEST_URI'])) { ?>
                                    <li class="active"><a href="<?php echo $home; ?>"><?php echo $text_home; ?></a></li>
                                    <?php } else { ?>
                                    <li><a href="/about_us/<?php //echo $home; ?>"><?php echo $text_home; ?></a></li>
                                    <?php } ?>
                                    <li><a href="/news/">НОВОСТИ</a></li>
                                    <li><a href="/sale/">SALE</a></li>
                                    <li><a href="/delivery/">ДОСТАВКА</a></li>
                                    <li><a href="/contact-us/">КОНТАКТЫ</a></li>
                                </ul>


                        </div>
                        <hr class="content__hr"/>
                    </div>


                </div>
                <div id="notification"></div>

















