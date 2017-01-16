<?php
class ControllerModulesocnetauth2popup extends Controller {

	public function index() 
	{
		$this->redirect(HTTPS_SERVER . 'index.php?route=module/socnetauth2&token=' . $this->session->data['token']);
	}
	
	public function install()
	{
		$this->redirect(HTTPS_SERVER . 'index.php?route=extension/module/install&token='.$this->session->data['token'].
		'&extension=socnetauth2');
	}
	
	public function uninstall()
	{
		$this->redirect(HTTPS_SERVER . 'index.php?route=extension/module/uninstall&token='.$this->session->data['token'].
		'&extension=socnetauth2');
	}
}

?>