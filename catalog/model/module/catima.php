<?php 
class ModelModuleCatima extends Model {
	public function getSetting($category_id) {
		$data = array(); 
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `store_id` = 0 AND `group` = 'catima' AND `key` = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$data = unserialize($result['value']);
		}

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `store_id` = 0 AND `group` = 'catima' AND `key` = 'status'");

		foreach ($query->rows as $result) {
			$data['status'] = $result['value'];
		}

		return $data;
	}
}
?>