<?php
class ControllerModuleCatima extends Controller {
	private $error = array();

    public function index() {
        $this->language->load('module/catima');

        $this->document->setTitle($this->language->get('heading_title_fake'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate_modify()) {
			$this->model_setting_setting->editSetting('catima', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('module/catima', 'token=' . $this->session->data['token'], 'SSL'));
		}

 		if (isset($this->error['warning'])) {
			$this->data['warning'] = $this->error['warning'];
		} else {
			$this->data['warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_status'] = $this->language->get('text_status');

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/catima', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['action'] = $this->url->link('module/catima', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif ($this->config->get('status')) { 
			$this->data['status'] = $this->config->get('status');
		}	

		$this->template = 'module/catima.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
    }

    private function validate_modify() {
        if (!$this->user->hasPermission('modify', 'module/catima')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
		if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }
}
?>