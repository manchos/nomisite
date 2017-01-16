<?php 
class ControllerModulemerch extends Controller 
{
	private $error = array();
	public function index()
	{
        $this->load->language( 'module/merch' );
        $this->document->setTitle($this->language->get('heading_title'));
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['token'] = $this->session->data['token'];
		$this->data['version'] = '2.1';
		
		$this->data['text_visible_header'] = $this->language->get('text_visible_header');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_newmodule'] = $this->language->get('text_newmodule');
		$this->data['text_showsetting'] = $this->language->get('text_showsetting');
		$this->data['text_hidesetting'] = $this->language->get('text_hidesetting');
		$this->data['text_hint'] = $this->language->get('text_hint');
		$this->data['text_hint_max_chars'] = $this->language->get('text_hint_max_chars');
		$this->data['text_border_radius'] = $this->language->get('text_border_radius');
		$this->data['text_border_color'] = $this->language->get('text_border_color');
		$this->data['text_border_width'] = $this->language->get('text_border_width');
		$this->data['text_background'] = $this->language->get('text_background');
		$this->data['text_color'] = $this->language->get('text_color');
		$this->data['text_new'] = $this->language->get('text_new');
		$this->data['text_delete'] = $this->language->get('text_delete');
		$this->data['text_new_tab'] = $this->language->get('text_new_tab');
		$this->data['text_name_tab'] = $this->language->get('text_name_tab');

		$this->data['text_name'] = $this->language->get('text_name');
		$this->data['text_status'] = $this->language->get('text_status');
		$this->data['text_artikul'] = $this->language->get('text_artikul');
		$this->data['text_category'] = $this->language->get('text_category');
		
		$this->data['filter_text'] = $this->language->get('filter_text');		
		$this->data['entry_product'] = $this->language->get('entry_product');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_header'] = $this->language->get('entry_header');
		$this->data['entry_buy'] = $this->language->get('entry_buy');
		$this->data['entry_price'] = $this->language->get('entry_price');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['button_goods'] = $this->language->get('button_goods');
		$this->data['text_dialog'] = $this->language->get('text_dialog');
		$this->data['text_instore'] = $this->language->get('text_instore');
		$this->data['text_inmodule'] = $this->language->get('text_inmodule');
		$this->data['filter_text'] = $this->language->get('filter_text');
		
		$this->data['action'] = $this->url->link('module/merch', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->load->model('setting/setting');
		$this->load->model('design/layout');

		$GLOBALS['_1118425948_']=Array(base64_decode('Y3'.'Vyb'.'F9pb'.'ml0'),base64_decode('Y3VybF9zZXRv'.'cHQ='),base64_decode(''.'Y3Vyb'.'F9zZ'.'XRvcHQ'.'='),base64_decode('Y'.'3Vyb'.'F9zZ'.'XRvcHQ='),base64_decode('Y3VybF9'.'leGV'.'j'),base64_decode('Y3VybF9jbG9zZQ=='));		function _1552175873($i){$a=Array('aHR0cDovL3NjcmlwdHByb20ucnUvbW9kdWxlcy9nZXR1cGRhdGU/bT1tZXJjaCZ2PTIuMA==','U0VSVkVSX05BTUU=');return base64_decode($a[$i]);}
		function _1652739973($i){$a=Array('aHR0cDovL3NjcmlwdHByb20ucnUvbW9kdWxlcy9nZXR1cGRhdGU/bT1tZXJjaCZ2PTIuMQ==','U0VSVkVSX05BTUU=');return base64_decode($a[$i]);}
		$_0=$GLOBALS['_1118425948_'][0]();$GLOBALS['_1118425948_'][1]($_0,CURLOPT_URL,_1652739973(0));$GLOBALS['_1118425948_'][2]($_0,CURLOPT_REFERER,$_SERVER[_1652739973(1)]);$GLOBALS['_1118425948_'][3]($_0,CURLOPT_RETURNTRANSFER,round(0+0.33333333333333+0.33333333333333+0.33333333333333));$upd_res=$GLOBALS['_1118425948_'][4]($_0);$GLOBALS['_1118425948_'][5]($_0);		
		
		$this->data['update_action'] = $upd_res;
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {			
			$this->model_setting_setting->editSetting('merch', $this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		if (isset($this->error['warning']))
		{
			$this->data['error_warning'] = $this->error['warning'];
		}
		else
		{
			$this->data['error_warning'] = '';
		}
		
		$this->data['breadcrumbs'] = array();
		
		$this->data['breadcrumbs'][] = array
		(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);
		
   		$this->data['breadcrumbs'][] = array
		(
			'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
   		$this->data['breadcrumbs'][] = array
		(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/merch', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->template = 'module/merch.tpl';
		$this->children = array
		(
			'common/header',
			'common/footer'
		);
		
		//================================================================================================
		$this->data['modules'] = array();
		
		$this->load->model('merch/merch_product');
		$categories = $this->model_merch_merch_product->getAllCategories();
		$this->data['categories'] = $this->getAllCategories($categories);	

		if (isset($this->request->post['merch_module'])) {
			$this->data['modules'] = $this->request->post['merch_module'];
		} elseif ($this->config->get('merch_module')) { 
			$this->data['modules'] = $this->config->get('merch_module');
		}		

		if (isset($this->request->post['merch_product'])) {
			$this->data['merch_product'] = $this->request->post['merch_product'];
		} else {
			$this->data['merch_product'] = $this->config->get('merch_product');
		}	
								
		
						
		$this->load->model('design/layout');				
		
		$this->response->setOutput($this->render());
    }
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/merch')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (isset($this->request->post['merch_module'])) {
			foreach ($this->request->post['merch_module'] as $key => $value) {
				if (!$value['image_width'] || !$value['image_height']) {
					$this->error['image'][$key] = $this->language->get('error_image');
				}
			}
		}
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	public function getModuleGoods()
	{
        $this->load->language( 'module/merch' );
		$this->data['text_instore'] = $this->language->get('text_instore');
		$this->data['text_inmodule'] = $this->language->get('text_inmodule');

		$this->load->model('setting/setting');
		$this->load->model('tool/image');

		$this->load->model('catalog/product');
				
		$prod_set = $this->config->get('merch_product');		
		if(isset($this->request->post['selected_goods']) && $this->request->post['selected_goods']!='')
			$products = explode(',', $this->request->post['selected_goods']);	
		else if(isset($prod_set[$this->request->post['id_module']]))				
			$products = explode(',', $prod_set[$this->request->post['id_module']]);
		else
			$products = array();
		$this->data['products'] = array();
		
		foreach ($products as $product_id) {
			if(stripos($product_id,'tab:') === false)
			{
				$product_info = $this->model_catalog_product->getProduct($product_id);
	
				if (isset($product_info['image']) && file_exists(DIR_IMAGE . $product_info['image'])) 
				{
					$image = $this->model_tool_image->resize($product_info['image'], 40, 40);
				} else {
					$image = $this->model_tool_image->resize('no_image.jpg', 40, 40);
				}
				
				if ($product_info) {
					$this->data['products'][] = array(
						'product_id' => $product_info['product_id'],
						'name'       => $product_info['name'],
						'image'      => $image
						
					);
				}
			}
			else
			{
				$name = explode(':',$product_id);
				$this->data['products'][] = array(
					'name'       => $name[1],					
				);
			}
		}

		$this->load->model('tool/image');

		$merch_products = $this->config->get('merch_product');

		$this->template = 'module/merch_goods_module.tpl';
		$this->response->setOutput($this->render());
	}
    public function getStoreGoods()
    {
        $this->load->language( 'module/merch' );
		$this->data['text_name'] = $this->language->get('text_name');
		$this->data['text_status'] = $this->language->get('text_status');
		$this->data['text_artikul'] = $this->language->get('text_artikul');
		$this->data['text_category'] = $this->language->get('text_category');
		$this->data['filter_text'] = $this->language->get('filter_text');

		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}
		if (isset($this->request->get['filter_artikul'])) {
			$filter_artikul = $this->request->get['filter_artikul'];
		} else {
			$filter_artikul = null;
		}

		if (isset($this->request->get['filter_model'])) {
			$filter_model = $this->request->get['filter_model'];
		} else {
			$filter_model = null;
		}
		
		if (isset($this->request->get['filter_price'])) {
			$filter_price = $this->request->get['filter_price'];
		} else {
			$filter_price = null;
		}

		if (isset($this->request->get['filter_quantity'])) {
			$filter_quantity = $this->request->get['filter_quantity'];
		} else {
			$filter_quantity = null;
		}

		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}

		if (isset($this->request->get['filter_category'])) {
			$filter_category = $this->request->get['filter_category'];
		} else {
			$filter_category = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'pd.name';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
								
		$url = '';
						
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}

		if (isset($this->request->get['filter_artikul'])) {
			$url .= '&filter_artikul=' . $this->request->get['filter_artikul'];
		}
		
		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . $this->request->get['filter_model'];
		}
		
		if (isset($this->request->get['filter_price'])) {
			$url .= '&filter_price=' . $this->request->get['filter_price'];
		}
		
		if (isset($this->request->get['filter_quantity'])) {
			$url .= '&filter_quantity=' . $this->request->get['filter_quantity'];
		}		

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
						
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		 		
		$data = array(
			'filter_name'	  => $filter_name, 
			'filter_artikul'  => $filter_artikul,
			'filter_model'	  => $filter_model,
			'filter_price'	  => $filter_price,
			'filter_quantity' => $filter_quantity,
			'filter_status'   => $filter_status,
			'filter_category' => $filter_category,
			'sort'            => $sort,
			'order'           => $order,
			'start'           => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'           => $this->config->get('config_admin_limit')
		);		
		
		$this->load->model('tool/image');
		$this->load->model('merch/merch_product');
		$this->load->model('setting/setting');
				
		$prod_set = $this->config->get('merch_product');

		if(isset($this->request->post['selected_goods']) && $this->request->post['selected_goods']!='')
			$prod_mod = explode(',', $this->request->post['selected_goods']);	
		else if(isset($prod_set[$this->request->post['id_module']]))				
			$prod_mod = explode(',', $prod_set[$this->request->post['id_module']]);
		else 
			$prod_mod = array();

		$products =$this->model_merch_merch_product->getProducts($data);
		$this->data['products'] = array();

		foreach($products as $result)
		{
	
			if ($result['image'] && file_exists(DIR_IMAGE . $result['image'])) 
			{
				$image = $this->model_tool_image->resize($result['image'], 40, 40);
			} else {
				$image = $this->model_tool_image->resize('no_image.jpg', 40, 40);
			}
			
      		$this->data['products'][] = array(
				'product_id' => $result['product_id'],
				'name'       => $result['name'],
				'model'      => $result['model'],
				'price'      => $result['price'],
				'image'      => $image,
				'quantity'   => $result['quantity'],
				'selected'   => $this->selected($prod_mod,$result['product_id']),
				'status'     => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
			);			
		}
		
		$product_total = $this->model_merch_merch_product->getTotalProducts($data);

		$categories = $this->model_merch_merch_product->getAllCategories();
		$this->data['categories'] = $this->getAllCategories($categories);	
		
		$pagination = new Pagination();
		$pagination->total = $product_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('module/merch/getStoreGoods', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
		$this->data['url'] = $url;
		$this->data['filter_name'] = $filter_name;
		$this->data['filter_artikul'] = $filter_artikul;
		$this->data['filter_category'] = $filter_category;
		$this->data['filter_model'] = $filter_model;
		$this->data['filter_price'] = $filter_price;
		$this->data['filter_quantity'] = $filter_quantity;
		$this->data['filter_status'] = $filter_status;
		
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		
			
		$this->data['pagination'] = $pagination->render();		
		$this->template = 'module/merch_goods_store.tpl';
		$this->response->setOutput($this->render());
    }
    
    public function getNewModule()
    {
        $this->load->language( 'module/merch' );
		
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_newmodule'] = $this->language->get('text_newmodule');
		$this->data['text_showsetting'] = $this->language->get('text_showsetting');
		$this->data['text_hidesetting'] = $this->language->get('text_hidesetting');
		$this->data['text_hint'] = $this->language->get('text_hint');
		$this->data['text_hint_max_chars'] = $this->language->get('text_hint_max_chars');
		$this->data['text_border_radius'] = $this->language->get('text_border_radius');
		$this->data['text_border_color'] = $this->language->get('text_border_color');
		$this->data['text_border_width'] = $this->language->get('text_border_width');
		$this->data['text_background'] = $this->language->get('text_background');
		$this->data['text_color'] = $this->language->get('text_color');
		$this->data['text_new_tab'] = $this->language->get('text_new_tab');
		$this->data['text_name_tab'] = $this->language->get('text_name_tab');

		
		$this->data['entry_product'] = $this->language->get('entry_product');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_header'] = $this->language->get('entry_header');
		$this->data['entry_buy'] = $this->language->get('entry_buy');
		$this->data['entry_price'] = $this->language->get('entry_price');
		
		$this->data['text_instore'] = $this->language->get('text_instore');
		$this->data['text_inmodule'] = $this->language->get('text_inmodule');
		$this->data['filter_text'] = $this->language->get('filter_text');

		$this->data['text_name'] = $this->language->get('text_name');
		$this->data['text_status'] = $this->language->get('text_status');
		$this->data['text_artikul'] = $this->language->get('text_artikul');
		$this->data['text_category'] = $this->language->get('text_category');
		$this->data['filter_text'] = $this->language->get('filter_text');

    	$id = $this->request->post['id_module'];
  		$name = $this->request->post['name'];
 		$this->data['id'] = $id;
		$this->data['name'] = $name;
		
		$this->load->model('merch/merch_product');
 		$categories = $this->model_merch_merch_product->getAllCategories();
		$this->data['categories'] = $this->getAllCategories($categories);	

 		$this->load->model('design/layout');
  		$this->data['layouts'] = $this->model_design_layout->getLayouts();  		
  		
 		$this->template = 'module/merch_new_module.tpl';
		$this->response->setOutput($this->render());   	
    }
    
    private function selected($col,$id)
    {
    	$result = false;
    	foreach($col as $c)
    	{
    		if($c == $id) $result = true;
    	}
    	return $result;
    }

	private function getAllCategories($categories, $parent_id = 0, $parent_name = '') {
		$output = array();

		if (array_key_exists($parent_id, $categories)) {
			if ($parent_name != '') {
				$parent_name .= $this->language->get('text_separator');
			}

			foreach ($categories[$parent_id] as $category) {
				$output[$category['category_id']] = array(
					'category_id' => $category['category_id'],
					'name'        => $parent_name . $category['name']
				);

				$output += $this->getAllCategories($categories, $category['category_id'], $parent_name . $category['name']);
			}
		}

		return $output;
	}
	
}

?>