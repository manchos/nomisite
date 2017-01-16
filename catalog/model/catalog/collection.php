<?php
/**
 * 
 */
class ModelCatalogCollection extends Model {
	
        //private $cache_collections['rproduct']=array();
        /**
         *
         * @var type $rcoun 
         */
        //private $cache_collections['rcollect']=array();
        private $cache_collections = null;
        private $cache_data;
        static public $idparentcollections = 60;

        public function __construct($registry) {
            parent::__construct($registry);
            $this->cache_collections = $this->cache->get('collection');
            $this->cache_data = $this->cache->get('seo_pro');
            $seourl='';
            if (!$this->cache_collections) {
                $query = $this->db->query("select " . DB_PREFIX . "product.product_id, model, category_id, parent_id, " . 
                        DB_PREFIX . "product.sort_order, ". DB_PREFIX . "category.sort_order as cat_sort_order, " . 
                        DB_PREFIX . "category_description.name from " . DB_PREFIX . "product  LEFT JOIN " . 
                        DB_PREFIX . "product_to_category ON " . DB_PREFIX . "product.product_id = " . 
                        DB_PREFIX . "product_to_category.product_id left join " . 
                        DB_PREFIX . "category using(category_id) left join " . 
                        DB_PREFIX . "category_description using(category_id)" .
                        "ORDER BY cat_sort_order ASC");
                $this->cache_collections = array();
                foreach ($query->rows as $row){
                    
                    if ($row['parent_id'] == 60) {
                        $this->cache_collections['rproduct'][$row['product_id']]['coll'] = $row['category_id'];
                        $seourl =  'category_id='.$row['category_id'];
                        $this->cache_collections['collinfo'][$row['category_id']]['name'] = $row['name'];
                        $this->cache_collections['collinfo'][$row['category_id']]['sort_order'] = $row['cat_sort_order'];
                        $this->cache_collections['collinfo'][$row['category_id']]['seopro'] = $this->cache_data['queries'][$seourl];
                    }
                    else{
                        $this->cache_collections['rproduct'][$row['product_id']]['cat_id'] = $row['category_id'];
                        $this->cache_collections['rproduct'][$row['product_id']]['name'] = $row['name'];
                    }    
                    if ( !empty($this->cache_collections['rproduct'][$row['product_id']]['coll']) and !empty($this->cache_collections['rproduct'][$row['product_id']]['cat_id'])){
                        $seourl =  'category_id='.$this->cache_collections['rproduct'][$row['product_id']]['cat_id'];
                        $this->cache_collections['rcollect'][$this->cache_collections['rproduct'][$row['product_id']]['coll']][$this->cache_collections['rproduct'][$row['product_id']]['cat_id']]['count']+=1;
                        $this->cache_collections['rcollect'][$this->cache_collections['rproduct'][$row['product_id']]['coll']][$this->cache_collections['rproduct'][$row['product_id']]['cat_id']]['name']= $this->cache_collections['rproduct'][$row['product_id']]['name'];
                        $this->cache_collections['rcollect'][$this->cache_collections['rproduct'][$row['product_id']]['coll']][$this->cache_collections['rproduct'][$row['product_id']]['cat_id']]['seopro']=$this->cache_data['queries'][$seourl].'/?coll_id='.$this->cache_collections['rproduct'][$row['product_id']]['coll'];
                    }

                }
                $this->cache->set('collection', $this->cache_collections);
            } else {
                //$this->rprod = $this->cache_collections['rproduct'];
                //$this->rcount = $this->cache_collections['rcollect'];
            }
        }
        
        //получить все ссылки на категории, товары из которых входят в коллекцию
        // Имя категории, url категории
        public function getCategoriesFromCollection($category_id_collections){
            
            return $this->cache_collections['rcollect'][$category_id_collections];
        }
        
        public function getCollectionsByCategory($category_id, $collid = 0){
            
            $arr = array();
            $seourl='';
            foreach ($this->cache_collections['rcollect'] as $coll_id => $catincoll) {
                foreach ($catincoll as $cat_id => $category) {
                    if ($category_id == $cat_id){
                        
                        $arr[$coll_id]=array('coll_id' => $coll_id, 'count' => $category['count'], 
                        'coll-name' => $this->cache_collections['collinfo'][$coll_id]['name']);
                        if ($collid != $coll_id){
                           $seourl= 'category_id='.$cat_id;
                           $arr[$coll_id]['seopro'] = $this->cache_data['queries'][$seourl].'/?coll_id='.$coll_id;
                           
                        }
                    }
                }
            }
            return $arr;
        }
        
        public function getCollectionsId(){
            return self::$idparentcollections;
        }
        /*
         * масив cache_collections['rcollect']:
         * Array ( [59] => Array ( [61] => Array ( [count] => 13 [name] => Пальто [seopro] => coat/?coll_id=59 ) [17] => Array ( [count] => 3 [name] => Платки [seopro] => scarves/?coll_id=59 ) ) ) 
         * 
         * для формирования меню
         */
        public function getCC(){
            $arr = array();
                 
            foreach ($this->cache_collections['rcollect'] as $key => $cat) {
                $arr[$key]['collinfo'] = $this->getIfoCollection($key);
                foreach ($cat as $k => $value) {
                    $arr[$key]['cats'][$k]= $value;
                }
            }
            return $arr;//$this->cache_collections['rcollect'];

        }


        public function getIfoCollection($coll_id = 0){
            if ($coll_id)
                return  $this->cache_collections['collinfo'][$coll_id];
            else {
                return  $this->cache_collections['collinfo'];
            }
        }
        
        public function isCollection($coll_id){
            if (array_key_exists($coll_id, $this->cache_collections['collinfo'])){
                return TRUE;
            }  else {
                return FALSE;
            }
            
        }
        
        
        
        
        public function getIfoProductCollection($product_id){
            $arr=array();
            $arr = $this->getIfoCollection($this->cache_collections['rproduct'][$product_id]['coll']);
            $arr['coll_id'] = $this->cache_collections['rproduct'][$product_id]['coll'];
            return  $arr;
        }
}
/*
 * 
 * 
array (size=10)
  66 => 
    array (size=3)
      'cat' => string '20' (length=2)
      'name' => string 'Блузы' (length=10)
      'coll' => string '58' (length=2)
  69 => 
    array (size=2)
      'cat' => string '17' (length=2)
      'name' => string 'Платья' (length=12)
  70 => 
    array (size=3)
      'cat' => string '17' (length=2)
      'name' => string 'Платья' (length=12)
      'coll' => string '59' (length=2)
  71 => 
    array (size=3)
      'cat' => string '17' (length=2)
      'name' => string 'Платья' (length=12)
      'coll' => string '59' (length=2)
  72 => 
    array (size=3)
      'cat' => string '17' (length=2)
      'name' => string 'Платья' (length=12)
      'coll' => string '59' (length=2)
  73 => 
    array (size=3)
      'cat' => string '17' (length=2)
      'name' => string 'Платья' (length=12)
      'coll' => string '59' (length=2)
  74 => 
    array (size=3)
      'cat' => string '17' (length=2)
      'name' => string 'Платья' (length=12)
      'coll' => string '59' (length=2)
  75 => 
    array (size=3)
      'cat' => string '17' (length=2)
      'name' => string 'Платья' (length=12)
      'coll' => string '59' (length=2)
  68 => 
    array (size=3)
      'cat' => string '33' (length=2)
      'name' => string 'Сумки' (length=10)
      'coll' => string '59' (length=2)
  76 => 
    array (size=2)
      'cat' => string '17' (length=2)
      'name' => string 'Платья' (length=12)


array (size=2)
  58 => 
    array (size=1)
      20 => 
        array (size=2)
          'count' => int 1
          'name' => string 'Блузы' (length=10)
  59 => 
    array (size=2)
      17 => 
        array (size=2)
          'count' => int 6
          'name' => string 'Платья' (length=12)
      33 => 
        array (size=2)
          'count' => int 1
          'name' => string 'Сумки' (length=10)
 * 
 * 
 */