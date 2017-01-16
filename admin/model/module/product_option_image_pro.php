<?php
class ModelModuleProductOptionImagePro extends Model {
  
  
  public function deleteAllImages() {
    $this->db->query("DELETE FROM ".DB_PREFIX."poip_option_image ");
  }
  
  
  public function add_product_option_value_image($product_id, $option_value_id, $image) {
    
    $query = $this->db->query("SELECT * FROM ".DB_PREFIX."product_option_value WHERE product_id = ".(int)$product_id." AND option_value_id = ".(int)$option_value_id." ");
    if ($query->num_rows) {
      
      $query_i = $this->db->query("SELECT * FROM ".DB_PREFIX."poip_option_image
                                    WHERE product_id = ".(int)$product_id."
                                    AND product_option_id = ".(int)$query->row['product_option_id']."
                                    AND product_option_value_id = ".(int)$query->row['product_option_value_id']."
                                    AND image = '".$this->db->escape((string)$image)."'
                                    ");
      if (!$query_i->num_rows) {
      
        $query_p = $this->db->query("SELECT sort_order FROM ".DB_PREFIX."poip_option_image WHERE product_id = ".(int)$product_id." ORDER BY sort_order DESC LIMIT 1 ");
        if ($query_p->num_rows) {
          $sort_order = 1+$query_p->row['sort_order'];
        } else {
          $sort_order = 1;
        }
        
        $this->db->query("INSERT INTO ".DB_PREFIX."poip_option_image
                              SET product_id = ".(int)$product_id."
                                , product_option_id = ".(int)$query->row['product_option_id']."
                                , product_option_value_id = ".(int)$query->row['product_option_value_id']."
                                , image = '".$this->db->escape((string)$image)."'
                                , sort_order = ".$sort_order."
                                ");
        
        return true;
        
      }
      
    }
    
    return false;
    
  }
  
  public function getProductOptionImages($product_id) {
    
    $images = array();
    
    if (!$this->installed()) return $images;
    
    $query = $this->db->query("SELECT * FROM ".DB_PREFIX."poip_option_image WHERE product_id = ".(int)$product_id." ORDER BY sort_order ");
    foreach ($query->rows as $row) {
      if (!isset($images[$row['product_option_id']])) {
        $images[$row['product_option_id']] = array();
      }
      if (!isset($images[$row['product_option_id']][$row['product_option_value_id']])) {
        $images[$row['product_option_id']][$row['product_option_value_id']] = array();
      }
      $images[$row['product_option_id']][$row['product_option_value_id']][] = array('image'=>$row['image'],'srt'=>$row['sort_order']);
    }
    
    return $images;
    
  }
  
  public function getSettingsNames($for_product=true) {
    $settings = array();
    $settings[] = "img_change";
    if (!$for_product) {
      $settings[] = "img_hover";
    }
    $settings[] = "img_use";
    $settings[] = "img_limit";
    if (!$for_product) {
      $settings[] = "img_gal";
    }
    $settings[] = "img_option";
    $settings[] = "img_category";
    $settings[] = "img_first";
    $settings[] = "img_cart";
    
    
    return $settings;
  }
  
  public function getSettingsValues() {
    
    return array('img_use_v0', 'img_use_v1', 'img_use_v2');
    
  }
  
  public function saveProductOptionValueImages($product_id, $product_option_id, $product_option_value_id, $images) {
    
    if (!$this->installed()) return;
    
    if (is_array($images)) {
      foreach ($images as $image) {
        if (is_array($image) && isset($image['image']) && $image['image']) {
          $this->db->query("INSERT INTO ".DB_PREFIX."poip_option_image
                            SET product_id = ".(int)$product_id."
                              , product_option_id = ".(int)$product_option_id."
                              , product_option_value_id = ".(int)$product_option_value_id."
                              , image = '".$this->db->escape((string)$image['image'])."'
                              , sort_order = ".(isset($image['srt']) ? (int)$image['srt'] : 0)."
                              ");
        }
      }
    }
    
  }
  
  public function deleteProductOptionValueImages($product_id) {
    
    if (!$this->installed()) return;
    
    $this->db->query("DELETE FROM ".DB_PREFIX."poip_option_image WHERE product_id = ".(int)$product_id." ");
    
  }
  
  // Real
  public function getRealOptionSettings($option_id) {
    
    $settings = array();
    
    if (!$this->installed()) return $settings;
    
    if (!$option_id) return $settings;
    
    $settings_names = $this->getSettingsNames();
    
    $query = $this->db->query("SELECT * FROM ".DB_PREFIX."poip_main_option_settings WHERE option_id = ".(int)$option_id." ");
    if ($query->num_rows) {
      $row = $query->row;
      foreach ($settings_names as $setting_name) {
        $settings[$setting_name] = isset($row[$setting_name]) ? $row[$setting_name] : 0;
      }
      
    }
    
    return $settings;
  }
  
  public function getRealProductSettings($product_id) {
    
    $settings = array();
    
    if (!$this->installed()) return $settings;
    
    if (!$product_id) return $settings;
    
    $settings_names = $this->getSettingsNames();
    
    $query = $this->db->query("SELECT * FROM ".DB_PREFIX."poip_option_settings WHERE product_id = ".(int)$product_id." ");
    foreach ($query->rows as $row) {
      $settings[$row['product_option_id']] = array();
      foreach ($settings_names as $setting_name) {
        $settings[$row['product_option_id']][$setting_name] = isset($row[$setting_name]) ? $row[$setting_name] : 0;
      }
      
    }
    
    return $settings;
  }
  
  public function deleteRealProductSettings($product_id) {
    
    if (!$this->installed()) return;
    $this->db->query("DELETE FROM ".DB_PREFIX."poip_option_settings WHERE product_id = ".(int)$product_id." ");
    
  }
  
  public function deleteRealOptionSettings($option_id) {
    
    if (!$this->installed()) return;
    $this->db->query("DELETE FROM ".DB_PREFIX."poip_main_option_settings WHERE option_id = ".(int)$option_id." ");
    
  }
  
  public function setRealOptionSettings($option_id, $settings) {
    
    if (!$this->installed()) return;
    
    $this->model_module_product_option_image_pro->deleteRealOptionSettings($option_id);
    
    $sql = "";
    $settings_names = $this->getSettingsNames();
    foreach ($settings_names as $setting_name) {
      $sql .= ", ".$setting_name." = ".(isset($settings[$setting_name]) ? (int)$settings[$setting_name] : 0)." ";
    }
    
    $this->db->query("INSERT INTO ".DB_PREFIX."poip_main_option_settings
                        SET option_id = ".(int)$option_id."
                          ".$sql."
                          ");
    
  }
  
  public function setRealProductSettings($product_id, $product_option_id, $settings) {
    
    if (!$this->installed()) return;
		
    $this->db->query("DELETE FROM ".DB_PREFIX."poip_option_settings WHERE product_option_id = ".(int)$product_option_id." ");
    
    $sql = "";
    $settings_names = $this->getSettingsNames();
    foreach ($settings_names as $setting_name) {
      $sql .= ", ".$setting_name." = ".(isset($settings[$setting_name]) ? (int)$settings[$setting_name] : 0)." ";
    }
    
    $this->db->query("INSERT INTO ".DB_PREFIX."poip_option_settings
                        SET product_id = ".(int)$product_id."
                          , product_option_id = ".(int)$product_option_id."
                          ".$sql."
                          ");
    
  }
  
  
  
  public function installed() {
    
    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `type` = 'module' AND `code` = 'product_option_image_pro'");
    
    // не работает в mijoshop
    //$query = $this->db->query('SHOW TABLES LIKE `' . DB_PREFIX . 'poip_option_image`');
    return $query->num_rows; 
  }
  
  public function install() {
    
    $this->uninstall();
    
    $this->db->query(
        'CREATE TABLE IF NOT EXISTS
          `' . DB_PREFIX . 'poip_option_image` (
            `product_id` int(11) NOT NULL,
            `product_option_id` int(11) NOT NULL,
            `product_option_value_id` int(11) NOT NULL,
            `image` varchar(255) NOT NULL,
            `sort_order` int(11) NOT NULL,
            KEY (`product_id`),
            KEY (`product_option_id`),
            KEY (`product_option_value_id`),
            FOREIGN KEY (product_id) REFERENCES `'. DB_PREFIX .'product`(product_id) ON DELETE CASCADE,
            FOREIGN KEY (product_option_id) REFERENCES `'. DB_PREFIX .'product_option`(product_option_id) ON DELETE CASCADE,
            FOREIGN KEY (product_option_value_id) REFERENCES `'. DB_PREFIX .'product_option_value`(product_option_value_id) ON DELETE CASCADE
          ) ENGINE=MyISAM DEFAULT CHARSET=utf8'
    );
    
    /*
    $this->db->query(
        'CREATE TABLE IF NOT EXISTS
          `' . DB_PREFIX . 'poip_product_settings` (
            `product_id` int(11) NOT NULL,
            `img_use` tinyint(1) NOT NULL,
            `img_limit` tinyint(1) NOT NULL,
            `img_select` tinyint(1) NOT NULL,
            KEY (`product_id`),
            FOREIGN KEY (product_id) REFERENCES '. DB_PREFIX .'product(product_id) ON DELETE CASCADE
          ) ENGINE=MyISAM DEFAULT CHARSET=utf8'
    );
    */
    
    $this->db->query(
        'CREATE TABLE IF NOT EXISTS
          `' . DB_PREFIX . 'poip_option_settings` (
            `product_id` int(11) NOT NULL,
            `product_option_id` int(11) NOT NULL,
            `img_change` tinyint(1) NOT NULL,
            `img_hover` tinyint(1) NOT NULL,
            `img_use` tinyint(1) NOT NULL,
            `img_limit` tinyint(1) NOT NULL,
            `img_gal` tinyint(1) NOT NULL,
            `img_option` tinyint(1) NOT NULL,
            `img_category` tinyint(1) NOT NULL,
            `img_first` tinyint(1) NOT NULL,
            `img_sort` tinyint(1) NOT NULL,
            `img_select` tinyint(1) NOT NULL,
						`img_cart` tinyint(1) NOT NULL,
            KEY (`product_id`),
            KEY (`product_option_id`),
            FOREIGN KEY (product_id) REFERENCES `'. DB_PREFIX .'product`(product_id) ON DELETE CASCADE,
            FOREIGN KEY (product_option_id) REFERENCES `'. DB_PREFIX .'product_option`(product_option_id) ON DELETE CASCADE
          ) ENGINE=MyISAM DEFAULT CHARSET=utf8'
    );
    
    $this->db->query(
        'CREATE TABLE IF NOT EXISTS
          `' . DB_PREFIX . 'poip_main_option_settings` (
            `option_id` int(11) NOT NULL,
            `img_change` tinyint(1) NOT NULL,
            `img_hover` tinyint(1) NOT NULL,
            `img_use` tinyint(1) NOT NULL,
            `img_limit` tinyint(1) NOT NULL,
            `img_gal` tinyint(1) NOT NULL,
            `img_option` tinyint(1) NOT NULL,
            `img_category` tinyint(1) NOT NULL,
            `img_first` tinyint(1) NOT NULL,
            `img_sort` tinyint(1) NOT NULL,
            `img_select` tinyint(1) NOT NULL,
						`img_cart` tinyint(1) NOT NULL,
            KEY (`option_id`),
            FOREIGN KEY (`option_id`) REFERENCES `'. DB_PREFIX .'option`(`option_id`) ON DELETE CASCADE
          ) ENGINE=MyISAM DEFAULT CHARSET=utf8'
    );
    
    
    $this->load->model('setting/setting');
		$msettings = array('poip_module'=>array('img_change'=>1,'img_hover'=>1,'img_use'=>1,'img_limit'=>1,'img_gal'=>1,'img_cart'=>1));
		$this->model_setting_setting->editSetting('poip_module', $msettings);
    
  }
  
  public function uninstall() {
    
    $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "poip_option_image`;");
    $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "poip_main_option_settings`;");
    //$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "poip_product_settings`;");
    $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "poip_option_settings`;");
    
  }
  
}
?>