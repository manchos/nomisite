<?php

    class ControllerProductCollection extends Controller {

        private $error = array();
        
        
        public function index(){
            $this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');
            $this->document->addStyle('catalog/view/theme/'.$this->config->get('config_template').'/stylesheet/collection.css');
            #назначаем заголовок страницы (обязательно)
            $title = 'КОЛЛЕКЦИИ';
            $this->document->setTitle($title);
            $this->data['heading_title'] = $title;
            #Добавляем хлебные крошки (обязательно)
            $this->data['breadcrumbs'] = array();
            $this->data['breadcrumbs'][] = array(
                'text'      => $this->language->get('text_home'),
                'href'      => $this->url->link('common/home'),        	
                'separator' => false
            ); 
            $this->data['breadcrumbs'][] = array(
                'text'      => $title,
                'href'      => $this->url->link('product/collection', '', 'SSL'),       	
                'separator' => $this->language->get('text_separator')
            );
             # стандартный код загрузки файла шаблона (обязательно)
             if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/collection.tpl')) {
                 $this->template = $this->config->get('config_template') . '/template/product/collection.tpl';
             } else {     
                 $this->template = 'default/template/product/collection.tpl';
             }
             
             
             


             # (Не обязательно) Если хотите использовать модули в левой или правой колонке, то:
             $this->children = array(
                 'common/column_left',
                 'common/column_right',
                 'common/content_top',
                 'common/content_bottom',
                 'common/footer',
                 'common/header'
             );
             #рендеринг шаблона (Обязательно)
             $this->response->setOutput($this->render());
     } 

    }

?>