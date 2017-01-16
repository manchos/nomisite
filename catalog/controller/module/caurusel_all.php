<?php
class ControllerModuleCauruselAll extends Controller {
	protected function index($setting) {
		static $module = 0;

		$this->document->addScript('catalog/view/javascript/jquery/jquery.jcarousel.min.js');
                $this->document->addScript('catalog/view/javascript/jquery/jquery.qtip.js');
                $this->document->addStyle('catalog/view/theme/'.$this->config->get('config_template').'/stylesheet/jquery.qtip.css');
		
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/carousel.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/carousel.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/carousel.css');
		}
                
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/caurusel_all.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/caurusel_all.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/caurusel_all.css');
		}
		
		$this->load->model('caurusel_all/model');
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		
		$this->data['use_scrolling_panel'] = $setting['use_scrolling_panel'];
		$this->data['scroll'] = $setting['scroll'];
		$this->data['visible'] = $setting['visible'];
		$this->data['button_cart'] = $this->language->get('button_cart');
		
		$results = array();
		$filter_type = $setting['filter_type'];
		switch($filter_type)
		{
		case "popular":
			$results = $this->model_catalog_product->getPopularProducts($setting['limit']);
			break;
			
//рекомендуемые
		case "featureds":
		$this->data['products'] = array();

		$products = explode(',', $this->config->get('featureds_product'));		

		if (empty($setting['limit'])) {
			$setting['limit'] = 5;
		}
		
		$products = array_slice($products, 0, (int)$setting['limit']);
		
		foreach ($products as $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);
			
			if ($product_info) {
				if ($product_info['image']) {
					$image = $this->model_tool_image->resize($product_info['image'], $setting['image_width'], $setting['image_height']);
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
					
				$this->data['products'][] = array(
					'product_id' => $product_info['product_id'],
					'thumb'   	 => $image,
					'name'    	 => $product_info['name'],
                                        'color'          => $product_info['seo_h1'],
					'price'   	 => $price,
					'special' 	 => $special,
                                        'sku'            => $product_info['sku'],
					'rating'     => $rating,
					'attribute_groups' => $this->model_catalog_product->getProductAttributes($product_info['product_id']),
					'description' => mb_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, 250) . '..',
					'reviews'    => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
					'href'    	 => $this->url->link('product/product', 'product_id=' . $product_info['product_id']),
				);
			}
		}
			break;
//рекомендуемые end

		case "special":
			$data = array(
			'sort'  => 'pd.name',
			'order' => 'ASC',
			'start' => 0,
			'limit' => $setting['limit']
			);
			$results = $this->model_catalog_product->getProductSpecials($data);
			break;
		case "bestseller":
			$results = $this->model_catalog_product->getBestSellerProducts($setting['limit']);
			break;
		case "latest":
			$results = $this->model_catalog_product->getLatestProducts($setting['limit']);
			break;
		case "latestreview":		
			$results_data = $this->model_caurusel_all_model->getLatestReviewProducts($setting['limit']);
			foreach($results_data as $products_data){
				$results[] = $this->model_catalog_product->getproduct($products_data['product_id']);
			}
			break;
		case "category":	
			$data = array(
			'filter_category_id' => $setting['filter_type_category'],
			'sort'  => 'pd.name',
			'order' => 'ASC',
			'start' => 0,
			'limit' => $setting['limit'],
			$this->data['category_href'] = $this->url->link('product/category', 'path=' . $setting['filter_type_category'])
			);
			$results = $this->model_catalog_product->getProducts($data);
			break;
		}
		
		$this->data['heading_title'] = $setting['title'][$this->config->get('config_language_id')];
		
		
		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height']);
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
							
			$this->data['products'][] = array(
				'product_id' => $result['product_id'],
				'thumb'   	 => $image,
				'name'    	 => $result['name'],
                                'color'          => $result['seo_h1'],
				'price'   	 => $price,
                                'sku'            => $result['sku'],
				'special' 	 => $special,
				'rating'     => $rating,
				'attribute_groups' => $this->model_catalog_product->getProductAttributes($result['product_id']),
                'description' => mb_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 250) . '..',
				'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
				'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
			);
		}
		
		$this->data['module'] = $module++;
		$this->data['template'] = $this->config->get('config_template');
                
                
                
		
                
                //применяем другой шаблон для layout product/collection
                if ($this->request->get['route'] != 'product/collection'){
                    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/caurusel_all.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/caurusel_all.tpl';
                    } else {
                            $this->template = 'default/template/module/caurusel_all.tpl';
                    }
                } else {
                    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/caurusel_all_coll.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/caurusel_all_coll.tpl';
                    } else {
                            $this->template = 'default/template/module/caurusel_all.tpl';
                    }
                }
		$this->render();
	}
}
?>
