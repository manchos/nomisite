
<!--<a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></a>//-->
<script type="text/javascript"><!--
     $(document).ready(function() {
     
    $(".owl-carousel").owlCarousel({
      navigation : true,
      navigationText : false,
      pagination: false
//    items : 10, //10 изображений на 1000px
//    itemsDesktop : [1000,5], //5 изображений на ширину между 1000px и 901px
//    itemsDesktopSmall : [900,3], // 3 изображения между 900px и 601px
//    itemsTablet: [600,2], //2 изображения между 600 и 0;
//    itemsMobile : false
    });
    
    	$("a.fancy").fancybox({
		'transitionIn'	:	'elastic',
		'transitionOut'	:	'elastic',
		'speedIn'		:	600, 
		'speedOut'		:	200, 
		'overlayShow'	:	false
	});
    }); 
    
//$('#carousel<?php echo $module; ?> ul').jcarousel({
//	vertical: false,
//	visible: <?php echo $limit; ?>,
//	scroll: <?php echo $scroll; ?>
//});
//--></script>
<hr class="content__hr" />
<div id="owl-demo" class="owl-carousel owl-theme">
    <?php foreach ($banners as $banner) { ?>
        <div class="item"><a rel="group" title="<?php echo $banner['title']; ?>" class="fancy" href="<?php echo $banner['simage']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></a></div>
    <?php } ?>
</div>
<hr class="content__hr" />


