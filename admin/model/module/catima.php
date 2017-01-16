<?php 
class ModelModuleCatima extends Model {
	public function getSetting($category_id) {
		$data = array(); 
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `store_id` = 0 AND `group` = 'catima' AND `key` = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$data = unserialize($result['value']);
		}

		return $data;
	}

	public function addSetting($data) {
		$query = $this->db->query("SELECT max(category_id) AS max FROM " . DB_PREFIX . "category");

		$category_id = $query->row['max'];

		$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET `store_id` = 0, `group` = 'catima', `key` = '" . (int)$category_id . "', `value` = '" . $this->db->escape(serialize($data)) . "', `serialized` = 1");
	}

	public function updateSetting($data, $category_id) {
		$this->deleteSetting($category_id);

		$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET `store_id` = 0, `group` = 'catima', `key` = '" . (int)$category_id . "', `value` = '" . $this->db->escape(serialize($data)) . "', `serialized` = 1");
	}

	public function deleteSetting($category_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `store_id` = 0 AND `group` = 'catima' AND `key` = '" . (int)$category_id . "'");
	}
}
?>