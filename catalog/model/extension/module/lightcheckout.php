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
	
	public function getBaseColumns() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "lightcheckout_column");
		
		$results_column = array();
		
		if ($query->rows) {
			foreach ($query->rows as $result) {
				$results_column[$result['column_id']] = ($result['value'] ? $result['value'] : 12);
				
				if ($result['column_id'] == 1) {
					$results_column[$result['column_id']] = ($result['value'] ? $result['value'] : 12);
					$results_column[2] = ($result['value'] ? (12 - $result['value']) : 12);
				}
				if ($result['column_id'] == 3) {
					$results_column[$result['column_id']] = ($result['value'] ? $result['value'] : 12);
					$results_column[4] = ($result['value'] ? (12 - $result['value']) : 12);
				}
				
			}
		}
		
		return $results_column;
	}
	
	public function getBaseStatus() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "lightcheckout_status");
		
		$results_status = array();
		
		if ($query->rows) {
			foreach ($query->rows as $result) {
				$results_status[$result['name']] = $result['status'];
			}
		}
		
		return $results_status;
	}
	
	public function getBaseFields($group_id, $group_name_id = false) {
		
		$sql_group_name_id = '';
		
		if ($group_name_id) {
			$sql_group_name_id = "and `group_name_id` = '" . $this->db->escape($group_name_id) . "'";
		}
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "lightcheckout_fields WHERE `group_id` = '" . $this->db->escape($group_id) . "'" . $sql_group_name_id . " ORDER BY sort");
		
		$groups = array();
		
		if ($query->rows) {
			foreach ($query->rows as $row) {
				$groups[$row['name_id']] = array(
					'show' 			=> $row['show'],
					'required' 		=> $row['required'],
					'name' 			=> json_decode($row['name'], true),
					'placeholder' 	=> json_decode($row['placeholder'], true),
					'sort' 			=> $row['sort'],
				);
			}
		}
		return $groups;
	}
	
	public function getBaseFieldsParameters($group_id, $group_name_id, $name_id, $parameter){
		
		$query = $this->db->query("SELECT `" . $parameter . "` FROM " . DB_PREFIX . "lightcheckout_fields WHERE `group_id` = '" . $this->db->escape($group_id) . "' and `group_name_id` = '" . $this->db->escape($group_name_id) . "' and `name_id` = '" . $this->db->escape($name_id) . "'");
		
		$param = false;
		
		if (isset($query->row[$parameter])) {
			$param = $query->row[$parameter];
		}
		return $param;
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
	
	public function currencies() {
		$currencies = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "currency");

		foreach ($query->rows as $result) {
			$currencies[$result['code']] = array(
				'symbol_left'   => $result['symbol_left'],
				'symbol_right'   => $result['symbol_right']
			);
		}
		return $currencies;
	}
	
	public function getBaseRestrictions() {
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "lightcheckout_restrictions");
		
		$results = array();
		if ($query->rows) {
			foreach ($query->rows as $result) {
				$results[$result['customer_group_id']][$result['type']] = $result['value'];
			}
		}
		
		return $results;
	}
	
	public function totals($restrictions) {
		$this->load->model('setting/extension');

		$totals = array();
		$taxes = $this->cart->getTaxes();
		$total = 0;
		
		// Because __call can not keep var references so we put them into an array. 			
		$total_data = array(
			'totals' => &$totals,
			'taxes'  => &$taxes,
			'total'  => &$total
		);
		
		// Display prices
		if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
			$sort_order = array();

			$results = $this->model_setting_extension->getExtensions('total');

			foreach ($results as $key => $value) {
				$sort_order[$key] = $this->config->get('total_' . $value['code'] . '_sort_order');
			}

			array_multisort($sort_order, SORT_ASC, $results);

			foreach ($results as $result) {
				if ($this->config->get('total_' . $result['code'] . '_status')) {
					$this->load->model('extension/total/' . $result['code']);
					
					// We have to put the totals in an array so that they pass by reference.
					$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
				}
			}

			$sort_order = array();

			foreach ($totals as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}

			array_multisort($sort_order, SORT_ASC, $totals);
		}
		
		$data['totals'] = array(); $totals_max = array();

		foreach ($totals as $total) {
			$data['totals']['total'][] = array(
				'title' => $total['title'],
				'text'  => $this->currency->format($total['value'], $this->session->data['currency'])
			);
			$totals_max[] = $this->currency->format($total['value'], $this->session->data['currency'], '', false);
		}
		
		$summa = max($totals_max);
		
		$config_customer_group_id = $this->config->get('config_customer_group_id');
		
		$min_summa_currency = '';
		
		foreach (array('min_summa', 'max_summa') as $limit) {
			
			if (isset($restrictions[$config_customer_group_id][$limit])) {
				
				$data[$limit] = $restrictions[$config_customer_group_id][$limit];
				
				$currencies = $this->currencies();
				$symbol_left = $currencies[$this->session->data['currency']]['symbol_left'];
				$symbol_right = $currencies[$this->session->data['currency']]['symbol_right'];
				
				$string = '';
				if ($symbol_left) {
					$string .= $symbol_left;
				}
				
				$string .= ceil($this->currency->format($data[$limit], $this->session->data['currency'], '', false));
				
				if ($symbol_right) {
					$string .= ' ' . $symbol_right;
				}
				
				$data[$limit . '_currency'] = $string;

			} else {
				$data[$limit] = false;
			}
			
			if (!$restrictions[$config_customer_group_id]) {
				$data[$limit] = 0;
			}
			
			if (isset($data[$limit . '_currency'])) {
				if ($limit == 'min_summa') {
					if ($summa < $data[$limit]) {
						$data['totals']['error_close'] = sprintf($this->language->get('text_' . $limit), $data[$limit . '_currency']);
					}
				} elseif ($limit == 'max_summa') {
					if ($summa > $data[$limit]) {
						$data['totals']['error_close'] = sprintf($this->language->get('text_' . $limit), $data[$limit . '_currency']);
					}
				}
			}
		}
		
		return $data['totals'];
	}
}
