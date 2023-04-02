<?php
class ModelExtensionModuleLightcheckout extends Model {
	
	public function createBaseSort() {
		
		$results = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "lightcheckout_sort'");
		
		if ($results->num_rows == 0) {
			$this->db->query("
				CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "lightcheckout_sort` (
				  `name` varchar(255) NOT NULL,
				  `group_id` int(11) NOT NULL,
				  `sort` int(11) NOT NULL,
				  PRIMARY KEY (`name`)
				) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
			");
		}
	}
	
	public function createBaseStatus() {
		
		$results = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "lightcheckout_status'");
		
		if ($results->num_rows == 0) {
			$this->db->query("
				CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "lightcheckout_status` (
				  `name` varchar(255) NOT NULL,
				  `status` int(11) NOT NULL,
				  PRIMARY KEY (`name`)
				) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
			");
		}
	}
	
	public function createBaseColumn() {
		
		$results = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "lightcheckout_column'");
		
		if ($results->num_rows == 0) {
			$this->db->query("
				CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "lightcheckout_column` (
				  `column_id` int(11) NOT NULL,
				  `value` int(11) NOT NULL,
				  PRIMARY KEY (`column_id`)
				) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
			");
		}
	}

	public function createBaseFields() {
		
		$results = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "lightcheckout_fields'");
		
		if ($results->num_rows == 0) {
			$this->db->query("
				CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "lightcheckout_fields` (
				  `id` int(11) NOT NULL AUTO_INCREMENT,
				  `group_id` varchar(255) NOT NULL,
				  `group_name_id` varchar(255) NOT NULL,
				  `name_id` varchar(255) NOT NULL,
				  `show` int(11) NOT NULL,
				  `required` int(11) NOT NULL,
				  `name` varchar(255) NOT NULL,
				  `placeholder` varchar(255) NOT NULL,
				  `sort` int(11) NOT NULL,
				  PRIMARY KEY (`id`)
				) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
			");
		}
	}
	
	public function createBaseSettings() {
		
		$results = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "lightcheckout_settings'");
		
		if ($results->num_rows == 0) {
			$this->db->query("
				CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "lightcheckout_settings` (
				  `name` varchar(255) NOT NULL,
				  `value` varchar(255) NOT NULL,
				  PRIMARY KEY (`name`)
				) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
			");
		}
	}
	
	public function createBaseSettingsCart() {
		
		$results = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "lightcheckout_settings_cart'");
		
		if ($results->num_rows == 0) {
			$this->db->query("
				CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "lightcheckout_settings_cart` (
				  `name` varchar(255) NOT NULL,
				  `value` varchar(255) NOT NULL,
				  PRIMARY KEY (`name`)
				) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
			");
		}
	}
	
	public function createBaseHtml() {
		
		$results = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "lightcheckout_html'");
		
		if ($results->num_rows == 0) {
			$this->db->query("
				CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "lightcheckout_html` (
				  `code` varchar(255) NOT NULL,
				  `language_id` int(11) NOT NULL,
				  `description` text NOT NULL
				) ENGINE=MyISAM DEFAULT CHARSET=utf8;
			");
		}
	}
	
	public function createBaseRestrictions() {
		
		$results = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "lightcheckout_restrictions'");
		
		if ($results->num_rows == 0) {
			$this->db->query("
				CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "lightcheckout_restrictions` (
				  `type` varchar(255) NOT NULL,
				  `customer_group_id` int(11) NOT NULL,
				  `value` int(11) NOT NULL
				) ENGINE=MyISAM DEFAULT CHARSET=utf8;
			");
		}
	}
	
	
	public function insertBaseSort($sorts) {
		
		if ($sorts) {
			
			$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "lightcheckout_sort");
			
			foreach ($sorts as $group_id => $arr_name) {
				foreach ($arr_name as $name => $sort) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "lightcheckout_sort SET `name` = '" . $this->db->escape($name) . "',`group_id` = '" . $this->db->escape($group_id) . "', `sort` = '" . (int)$sort . "'");
				}
			}
		}
	}
	
	public function insertBaseHtml($html) {
		
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "lightcheckout_html");
		
		if ($html) {
			foreach ($html as $code => $value) {
				if ($value) {
					foreach ($value as $language_id => $text) {
						$this->db->query("INSERT INTO " . DB_PREFIX . "lightcheckout_html SET `code` = '" . $this->db->escape($code) . "',`language_id` = '" . (int)$language_id . "', `description` = '" . $this->db->escape(json_encode($text, true)) . "'");
					}
				}
			}			
		}
	}
	
	public function insertBaseStatus($statuss) {
		
		if ($statuss) {
			
			$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "lightcheckout_status");
			
			foreach ($statuss as $name => $sort) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "lightcheckout_status SET `name` = '" . $this->db->escape($name) . "', `status` = '" . (int)$sort . "'");
			}
		}
	}
	
	public function insertBaseFields($data) {
		if ($data) {			
			foreach ($data as $group_id => $groups) {
				$this->db->query("DELETE FROM " . DB_PREFIX . "lightcheckout_fields WHERE `group_id` = '" . $this->db->escape($group_id) . "'");
				
				foreach ($groups as $group_name_id => $group_name) {
					foreach ($group_name as $name_id => $res) {
						if (isset($res['required'])){$required = $res['required'];} else {$required = false;}
						if (isset($res['show'])){$show = $res['show'];} else {$show = false;}
						
						if (isset($res['placeholder'])){$placeholder = json_encode($res['placeholder'], true);} else {$placeholder = false;}
						if (isset($res['sort'])){$sort = $res['sort'];} else {$sort = false;}
						if (!isset($res['name'])){$name = array();} else {$name = $res['name'];}
						
						$this->db->query("INSERT INTO " . DB_PREFIX . "lightcheckout_fields SET `group_id` = '" . $this->db->escape($group_id) . "',`group_name_id` = '" . $this->db->escape($group_name_id) . "',`name_id` = '" . $this->db->escape($name_id) . "',`show` = '" . (int)$show . "',`required` = '" . (int)$required . "',`name` = '" . $this->db->escape(json_encode($name, true)) . "',`placeholder` = '" . $this->db->escape($placeholder) . "', `sort` = '" . (int)$sort . "'");
					}
				}
			}
		}
		return true;
	}
	
	public function insertBaseColumn($columns) {
		
		if ($columns) {
			
			$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "lightcheckout_column");
			
			foreach ($columns as $column_id => $value) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "lightcheckout_column SET `column_id` = '" . (int)$column_id . "', `value` = '" . (int)$value . "'");
			}
		}
	}
	
	public function insertBaseSettings($settings) {
		
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "lightcheckout_settings");
		
		if ($settings) {			
			foreach ($settings as $name => $value) {
				if (is_array($value)){
					$value = json_encode($value, true);
				}
				$this->db->query("INSERT INTO " . DB_PREFIX . "lightcheckout_settings SET `name` = '" . $this->db->escape($name) . "', `value` = '" . $this->db->escape($value) . "'");
			}			
		}
	}
	
	public function insertBaseRestrictions($restrictions) {
		
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "lightcheckout_restrictions");
		
		if (isset($restrictions['lightrestrictions'])) {			
			foreach ($restrictions['lightrestrictions'] as $restriction) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "lightcheckout_restrictions SET `type` = '" . $this->db->escape($restriction['type']) . "', `customer_group_id` = '" . (int)$restriction['customer_group_id'] . "', `value` = '" . (int)$restriction['value'] . "'");
			}			
		}
	}
	
	public function insertBaseSettingsCart($settings = array()) {

		foreach (array('coupon', 'reward', 'voucher') as $name) {
			
			$this->db->query("DELETE FROM " . DB_PREFIX . "lightcheckout_settings_cart WHERE `name` = '" . $this->db->escape($name) . "'");
			
			if (array_key_exists($name, $settings)) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "lightcheckout_settings_cart SET `name` = '" . $this->db->escape($name) . "', `value` = '1'");
			} else {
				$this->db->query("INSERT INTO " . DB_PREFIX . "lightcheckout_settings_cart SET `name` = '" . $this->db->escape($name) . "', `value` = '0'");
			}
		}
		return true;
	}
	
	public function getBaseHtml() {

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "lightcheckout_html");
		
		$data = array();
		
		if ($query->num_rows) {
			foreach ($query->rows as $key => $result) {
				$data[$result['code']][$result['language_id']] = html_entity_decode(json_decode($result['description'], true), ENT_QUOTES, 'UTF-8');
			}
		}
		return $data;
	}
	
	public function deleteBaseSeoUrl($query) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "seo_url` WHERE query = '" . $this->db->escape($query) . "'");
	}
	
	public function getSeoUrlsByQuery($keyword) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "seo_url` WHERE query = '" . $this->db->escape($keyword) . "'");
		
		$lightseo = array();
		if ($query->num_rows) {
			foreach ($query->rows as $key => $result) {
				$lightseo['name'][$result['language_id']] = $result['keyword'];
			}
		}
		return $lightseo;
	}
	
	public function deleteBaseUrlAlias($query) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE query = '" . $this->db->escape($query) . "'");
	}
	
	public function getUrlAliasQuery($keyword) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "url_alias` WHERE query = '" . $this->db->escape($keyword) . "'");
		
		$lightseo = array();
		if ($query->num_rows) {
			foreach ($query->rows as $key => $result) {
				$lightseo['name'] = $result['keyword'];
			}
		}
		return $lightseo;
	}
	
	public function getUrlAliasByKeyword($keyword) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "url_alias` WHERE keyword = '" . $this->db->escape($keyword) . "'");

		return $query->rows;
	}
	
	public function addSeoUrl($keyword) {
		$this->db->query("INSERT INTO `" . DB_PREFIX . "url_alias` SET query = 'lightcheckout/checkout', keyword = '" . $this->db->escape($keyword) . "'");
	}
	
	public function checkBaseFields($status) {
		$stats = array();
		if ($status) {
			foreach ($status as $checked => $stat){
				$group_id = 'checked_' . $checked;
				$results = $this->db->query("SELECT * FROM " . DB_PREFIX . "lightcheckout_fields WHERE `group_id` = '" . $this->db->escape($group_id) . "'");
				if (!$results->num_rows){
					$stats[] = $group_id;
				}
			}
		}
		return $stats;
	}
	
	public function getBaseSort() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "lightcheckout_sort ORDER BY sort");
		
		$results_sort = array();
		
		if ($query->rows) {
			foreach ($query->rows as $result) {
				$results_sort[$result['group_id']][] = array(
					'name' 	=> $result['name'],
					'sort' 	=> $result['sort']			
				);
			}
		}
		
		return $results_sort;
	}
	
	public function getBaseStatus() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "lightcheckout_status");
		
		$results_status = array();
		
		if ($query->rows) {
			foreach ($query->rows as $result) {
				$results_status[$result['name']] = $result['name'];
			}
		}
		
		return $results_status;
	}
	
	public function getBaseSettings() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "lightcheckout_settings");
		
		$settings = array();
		
		if ($query->rows) {
			foreach ($query->rows as $result) {
				$settings[$result['name']] = $result['value'];
			}
		}
		
		return $settings;
	}
	
	public function getBaseSettingsCart() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "lightcheckout_settings_cart");
		
		$settings = array();
		
		if ($query->rows) {
			foreach ($query->rows as $result) {
				$settings[$result['name']] = $result['value'];
			}
		}
		
		return $settings;
	}
	
	public function getBaseColumns() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "lightcheckout_column");
		
		$results_column = array();
		
		if ($query->rows) {
			foreach ($query->rows as $result) {
				$results_column[$result['column_id']] = $result['value'];
				
				if ($result['column_id'] == 1) {
					$results_column[$result['column_id']] = $result['value'];
					$results_column[2] = 12 - $result['value'];
				}
				if ($result['column_id'] == 3) {
					$results_column[$result['column_id']] = $result['value'];
					$results_column[4] = 12 - $result['value'];
				}
			}
		}
		
		return $results_column;
	}
	
	public function getBaseRestrictions() {
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "lightcheckout_restrictions");
		
		$results = array();
		if ($query->rows) {
			foreach ($query->rows as $result) {
				$results[$result['type']] = array(
					'customer_group_id' => $result['customer_group_id'],
					'value' => $result['value']
				);
			}
		}
		
		return $results;
	}
	
	public function getBaseFields($group_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "lightcheckout_fields WHERE `group_id` = '" . $this->db->escape($group_id) . "' ORDER BY group_name_id DESC, sort ASC");

		return $query->rows;
	}
	
	public function getBaseFieldsParameters($group_id, $group_name_id, $name_id, $parameter){
		
		$query = $this->db->query("SELECT `" . $parameter . "` FROM " . DB_PREFIX . "lightcheckout_fields WHERE `group_id` = '" . $this->db->escape($group_id) . "' and `group_name_id` = '" . $this->db->escape($group_name_id) . "' and `name_id` = '" . $this->db->escape($name_id) . "'");
		
		$param = false;
		
		if (isset($query->row[$parameter])) {
			$param = $query->row[$parameter];
		}
		return $param;
	}
	
	function LightMethods($type){
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `type` = '" . $this->db->escape($type) . "'");
		
		$payments = array();
		if ($query->rows) {
			foreach ($query->rows as $code) {
				$payments[] = $code['code'];
			}
		}

		return $payments;
	}
	
	public function currencies() {

		$currencies = '';
		
		$query = $this->db->query("SELECT title FROM " . DB_PREFIX . "currency WHERE ROUND(`value`,0) = '1'");
		
		$or = '';
		foreach ($query->rows as $key => $title) {
			if ($key > 0) {$or = $this->language->get('text_or');}
			$currencies .= $or . $title['title'];
		}
		
		return $currencies;
	}

}
