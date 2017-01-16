<?php  
class ControllerModuleOurProducts extends Controller {
	protected function index($setting) {
		static $module = 0;
		
		$this->language->load('module/our_products');
		
		$this->load->model('catalog/product'); 
		$this->load->model('tool/image');
		
		$this->document->addStyle('catalog/view/theme/default/stylesheet/our_products.css');
		$this->document->addStyle('catalog/view/javascript/jquery/ourproducts/css/smoothDivScroll.css');
		$this->document->addScript('catalog/view/javascript/jquery/ourproducts/jquery.mousewheel.min.js');
		$this->document->addScript('catalog/view/javascript/jquery/ourproducts/jquery.kinetic.js');
		$this->document->addScript('catalog/view/javascript/jquery/ourproducts/jquery.smoothDivScroll-1.3.js');
		$this->document->addScript('catalog/view/javascript/jquery/tabs.js');
		$this->document->addScript('catalog/view/javascript/jquery/ourproducts/colorbox/jquery.colorbox-min.js');
		$this->document->addStyle('catalog/view/javascript/jquery/ourproducts/colorbox/colorbox.css');
		$this->document->addStyle('catalog/view/javascript/jquery/poshytip/src/tip-twitter/tip-twitter.css');
		$this->document->addScript('catalog/view/javascript/jquery/poshytip/src/jquery.poshytip.min.js');
		$this->document->addScript('catalog/view/javascript/jquery/ourproducts/common.js');
		
		$this->document->addScript('catalog/view/javascript/jquery/jquery.jcarousel.min.js');

		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/carousel.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/carousel.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/carousel.css');
		}
		
		$language = $this->config->get('config_language_id');
		
		$this->data['button_quick_view'] = $this->language->get('button_quick_view');
		$this->data['button_cart'] = $this->language->get('button_cart');
		$this->data['button_wishlist'] = $this->language->get('button_wishlist');
		$this->data['button_compare'] = $this->language->get('button_compare');
		
		$this->data['module_name_on_off']  = $setting['module_name_on_off'];
		
		if($setting['module_name'][$language]) {		
			$this->data['heading_title'] = html_entity_decode($setting['module_name'][$language], ENT_QUOTES, 'UTF-8');
		} else {
			$this->data['heading_title'] = $this->language->get('heading_title');
		}
		
		if(empty($setting['width'])) {
			$setting['width'] = 220;
		}
		if(empty($setting['height'])) {
			$setting['height'] = 220;
		}

		if(empty($setting['limit'])) {
			$setting['limit'] = 20;
		}
		
		if(empty($setting['day_new'])) {
			$setting['day_new'] = 31;
		}
		
		if(empty($setting['view_popular'])) {
			$setting['view_popular'] = 50;
		}
		
		$this->data['description'] 		= $setting['description'];
		$this->data['price'] 			= $setting['price'];
		$this->data['rating'] 			= $setting['rating'];
		$this->data['btn_cart'] 		= $setting['button_cart'];
		$this->data['btn_wishlist'] 	= $setting['button_wishlist'];
		$this->data['btn_compare'] 		= $setting['button_compare'];
		$this->data['btn_quick_view'] 	= $setting['button_quick_view'];
		$this->data['scroll_tabs'] 		= $setting['scroll_tabs'];

		$timestamp 			= time();
		$date_time_array 	= getdate($timestamp);
		$hours 				= $date_time_array['hours'];
		$minutes 			= $date_time_array['minutes'];
		$seconds 			= $date_time_array['seconds'];
		$month 				= $date_time_array['mon'];
		$day 				= $date_time_array['mday'];
		$year 				= $date_time_array['year'];

		$timestamp = mktime($hours, $minutes, $seconds, $month,$day - $setting['day_new'], $year);
		
		$this->data['tabs'] = array();
		if (is_array($setting['tabs'])) {		
			$tabs = $setting['tabs'];			
			foreach ($tabs as $tab) {								
				if (isset($tab['tab_name'][$language])) { 
					$tab_name = html_entity_decode($tab['tab_name'][$language], ENT_QUOTES, 'UTF-8'); 
				}
				$products = array();
				if ($tab['title'] == 'bestseller' || $tab['title'] == 'latest' || $tab['title'] == 'special' || $tab['title'] == 'popular' || $tab['title'] == 'category_id') {
					if ($tab['title'] == 'bestseller') {
						$results = $this->model_catalog_product->getBestSellerProducts($setting['limit']);					
					} elseif ( $tab['title'] == 'latest') {
						$data = array(
							'sort'  => 'p.date_added',
							'order' => 'DESC',
							'start' => 0,
							'limit' => $setting['limit']
						);			
						$results = $this->model_catalog_product->getProducts($data);
					} elseif ($tab['title'] == 'special') {
						$data = array(
							'sort'  => 'pd.name',
							'order' => 'ASC',
							'start' => 0,
							'limit' => $setting['limit']
						);				
						$results = $this->model_catalog_product->getProductSpecials($data);
					} elseif ($tab['title'] == 'popular') {
						$results = $this->model_catalog_product->getPopularProducts($setting['limit']);	
					} elseif ($tab['title'] == 'category_id') {						
						$data = array(
							'filter_category_id' => $tab['category_id'],
							'sort'  => 'pd.name',
							'order' => 'ASC',
							'start' => 0,
							'limit' => $setting['limit']
						);							
						$results = $this->model_catalog_product->getProducts($data);						
					}
			
					foreach ($results as $result) {
						if ($result['image']) {
							$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
						} else {
							$image = false;
						}
									
						if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
							$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$price = false;
						}
								
						if ((float)$result['special']) {
							$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$special = false;
						}
						
						if ($this->config->get('config_review_status')) {
							$rating = $result['rating'];
						} else {
							$rating = false;
						}
						
						if ($setting['sticker_special']) {
							if ((float)$result['special']) {
								if ($result['price'] > 0) {
									$sale = '<div class="stiker-special-module">' . '-' . round((($result['price'] - $result['special'])/$result['price'])*100, 0) . '<span>%</span>' . '</div>';
								} else {
									$sale = false;
								}	
							} else {
								$sale = false;
							}			
						} else {
							$sale = false;
						}					
						
						if ($setting['sticker_new']) {
							if (($result['date_available']) > strftime('%Y-%m-%d',$timestamp)) {
								$new = '<div class="stiker-new-module"></div>';
							} else {
								$new = false;
							}
						} else {
							$new = false;
						}
						
						if ($setting['sticker_popular']) {
							if (($result['viewed']) > ($setting['view_popular'])) {
								$popular = '<div class="stiker-popular-module"></div>';
							} else {
								$popular = false;
							}
						} else {
							$popular = false;
						}
						
						$products[] = array(
							'product_id'  => $result['product_id'],
							'thumb'   	  => $image,
							'name'    	  => $result['name'],
							'no_image'    => $this->model_tool_image->resize('no_image.jpg', $setting['width'], $setting['height']),
							'price'   	  => $price,
							'special' 	  => $special,
							'rating'      => $rating,
							'sale' 	  	  => $sale,
							'new'     	  => $new,
							'popular'     => $popular,
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $setting['symbol_description']) . '...',
							'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
							'href'    	  => $this->url->link('product/product', 'product_id=' . $result['product_id']),
						);
					}
				} elseif ($tab['title'] == 'products') {
					$featured_products = explode(',', $tab['products']);	
					$featured_products = array_slice($featured_products, 0, (int)$setting['limit']);	
					
					foreach ($featured_products as $product_id) {
						$product_info = $this->model_catalog_product->getProduct($product_id);
						
						if ($product_info) {
							if ($product_info['image']) {
								$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
							} else {
								$image = false;
							}
			
							if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
								$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
							} else {
								$price = false;
							}
									
							if ((float)$product_info['special']) {
								$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
							} else {
								$special = false;
							}
							
							if ($this->config->get('config_review_status')) {
								$rating = $product_info['rating'];
							} else {
								$rating = false;
							}
							
							if ($setting['sticker_special']) {
								if ((float)$product_info['special']) {
									if ($product_info['price'] > 0) {
										$sale = '<div class="stiker-special-module">' . '-' . round((($product_info['price'] - $product_info['special'])/$product_info['price'])*100, 0) . '<span>%</span>' . '</div>';
									} else {
										$sale = false;
									}	
								} else {
									$sale = false;
								}			
							} else {
								$sale = false;
							}					
							
							if ($setting['sticker_new']) {
								if (($product_info['date_available']) > strftime('%Y-%m-%d',$timestamp)) {
									$new = '<div class="stiker-new-module"></div>';
								} else {
									$new = false;
								}
							} else {
								$new = false;
							}
							
							if ($setting['sticker_popular']) {
								if (($product_info['viewed']) > ($setting['view_popular'])) {
									$popular = '<div class="stiker-popular-module"></div>';
								} else {
									$popular = false;
								}
							} else {
								$popular = false;
							}
								
							$products[] = array(
								'product_id'  => $product_info['product_id'],
								'thumb'   	  => $image,
								'name'    	  => $product_info['name'],
								'no_image'    => $this->model_tool_image->resize('no_image.jpg', $setting['width'], $setting['height']),
								'price'   	  => $price,
								'special' 	  => $special,
								'rating'      => $rating,
								'sale' 	  	  => $sale,
								'new'     	  => $new,
								'popular'     => $popular,
								'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $setting['symbol_description']) . '...',
								'reviews'     => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
								'href'    	  => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
							);
						}
					}
				}
						
				$this->data['tabs'][] = array(
					'tab_name'  => $tab_name,
					'title'     => $tab['title'],
					'products'  => $products
				);	
			}
		}
		
		$this->data['module'] = $module++;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/our_products.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/our_products.tpl';
		} else {
			$this->template = 'default/template/module/our_products.tpl';
		}
		
		$this->render();
	}
}
?>