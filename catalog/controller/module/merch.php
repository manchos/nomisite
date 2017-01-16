<?php
class ControllerModuleMerch extends Controller {
	protected function index($setting) {
		
		$this->language->load('module/merch'); 

		
		$this->data['button_cart'] = $this->language->get('button_cart');
		
		$this->load->model('catalog/product'); 
		
		$this->load->model('tool/image');

		$this->data['products'] = array();
		$this->data['tabs'] = array();
		$id = $setting['id'];
		$this->data['id'] = $setting['id'];
		$prods = $this->config->get('merch_product');
		$products = explode(',', $prods[$id]);		
		$this->data['heading'] = $setting['header'];
		$this->data['show_price'] = $setting['price'];
		$this->data['show_buy'] = $setting['buy'];
		$this->data['hint'] = $setting['hint'];
		$this->data['max_hint_char'] = $setting['max_hint_char'];
		$this->data['hint_border_width'] = $setting['hint_border_width'];
		$this->data['hint_border_radius'] = $setting['hint_border_radius'];
		$this->data['hint_border_color'] = $setting['hint_border_color'];
		$this->data['hint_color'] = $setting['hint_color'];
		$this->data['hint_background'] = $setting['hint_background'];
		$this->data['visible_header'] = $setting['visible_header'];
		foreach ($products as $product_id) {

			if(stripos($product_id,'tab:') === false)
			{		
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
					$desc = '';
					if(isset($setting['max_hint_char']) && $setting['max_hint_char'] != '') $desc = $this->getShortText($product_info['description'],$setting['max_hint_char']);
					else $desc = $product_info['description'];				
					$this->data['products'][] = array(
						'product_id' => $product_info['product_id'],
						'thumb'   	 => $image,
						'name'    	 => $product_info['name'],
						'price'   	 => $price,
						'special' 	 => $special,
						'rating'     => $rating,
						'reviews'    => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
						'href'    	 => $this->url->link('product/product', 'product_id=' . $product_info['product_id']),
						'description'=> $desc,
					);
				}
				}
			else
			{
				$name = explode(':',$product_id);
				$this->data['products'][] = array(
					'name'    	 => $name[1],
				);	
				$this->data['tabs'][] = array(
					'name' => $name[1],
				);
			}
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/merch.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/merch.tpl';
		} else {
			$this->template = 'default/template/module/merch.tpl';
		}

		$this->render();
	}
	private function getShortText($source,$trim)
	{
		$text=strip_tags($source);
		if(mb_strlen($text, 'UTF-8')>$trim)
		{
			$pos = mb_strpos($text, ' ', $trim, 'UTF-8');
			$text = mb_substr($text, 0, $pos, 'UTF-8');
			return $text.'...';
		}
		else
		return $text;
	}
	
}
?>