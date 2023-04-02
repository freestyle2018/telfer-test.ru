<?php

require_once(DIR_SYSTEM . 'library/microdatapro.php');
		
class ControllerExtensionModuleMicrodataPro extends Controller { 

	protected $data;

	public function install($redirect = false) {
		$this->microdatapro = new Microdatapro($this->registry);
		
		$url = "";	
		$prepare_data = array(
			'email'     => $this->config->get('config_email'),
			'module'    => $this->microdatapro->module_info('module') . " " . $this->microdatapro->module_info('version'),
			'site' 	    => $_SERVER['HTTP_HOST'],
			'sec_token' => "3274507573",
			'method'	=> 'POST',
			'lang'		=> $this->language->get('code'),
			'engine'	=> $this->microdatapro->module_info('engine'),
			'date'		=> date("Y-m-d H:i:s")
		);		
		if($curl = curl_init()) { //POST CURL
			curl_setopt($curl, CURLOPT_URL, $url);
			curl_setopt($curl, CURLOPT_HEADER, false);
			curl_setopt($curl, CURLOPT_RETURNTRANSFER,true);
			curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 30);
			curl_setopt($curl, CURLOPT_POST, true);
			curl_setopt($curl, CURLOPT_POSTFIELDS, $prepare_data);
			$register_number = curl_exec($curl);
			curl_close($curl);
		}else{ //GET HTTP
			$url .= "&email=" . $prepare_data['email'];
			$url .= "&module=" . $prepare_data['module'];
			$url .= "&site=" . $prepare_data['site'];
			$url .= "&sec_token=" . $prepare_data['sec_token'];
			$url .= "&method=GET";
			$url .= "&lang=" . $prepare_data['lang'];
			$url .= "&engine=" . $prepare_data['engine'];
			$url .= "&date=" . $prepare_data['date'];
		}

		if($this->microdatapro->opencart_version(1) < 3){ //IF < 2.3
			if(!$redirect){
				if($this->microdatapro->opencart_version(0) == 2){ //IF 2
					$this->response->redirect($this->url->link('module/microdatapro', 'token=' . $this->session->data['token'], 'SSL'));
				}else{
					$this->redirect($this->url->link('module/microdatapro', 'token=' . $this->session->data['token'], 'SSL'));
				}
			}
		}
	}
	
	public function index() {
	$a=$b=$c=$d=0;
	
		$this->microdatapro = new Microdatapro($this->registry);

		//$this->language->load('module/microdatapro');
		$this->load->language('extension/module/microdatapro'); //for 2.3
		//$this->data = $this->language->load('module/microdatapro');
		$this->data = $this->load->language('extension/module/microdatapro'); //for 2.3

		$this->data['activated'] = true;

		$this->data['token'] = $this->session->data['token'];
		if(isset($key) && !empty($key)){ $key_array = explode("327450", base64_decode(strrev(substr($key, 0, -7))));
		if($key_array[0] == base64_encode($this->microdatapro->module_info('main_host')) && $key_array[1] == base64_encode($this->microdatapro->module_info('sys_key').$this->microdatapro->module_info('sys_keyf')+100)){$this->data['activated'] = 1;}} 
		
		if(!$this->data['activated']){
			$this->install(1);
		}
		
		if($this->microdatapro->opencart_version(1) >= 3){ //IF over 2.3 
			$this->data['link_status'] = "index.php?route=extension/module/microdatapro/getStatus";
			$this->data['link_clear']  = "index.php?route=extension/module/microdatapro/clear_old";	
		}else{
			$this->data['link_status'] = "index.php?route=module/microdatapro/getStatus";
			$this->data['link_clear']  = "index.php?route=module/microdatapro/clear_old";	
		}
		
		$this->data['module_version'] = $this->microdatapro->module_info('version');

		$this->document->setTitle(strip_tags($this->language->get('heading_title')));
		
		$this->load->model('setting/setting');
		$this->load->model('setting/store');
		$this->load->model('tool/image');
		$this->load->model('design/layout');

		$this->data['layouts'] = $this->model_design_layout->getLayouts();
	
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			$this->editSetting('microdatapro', $this->request->post);

			if($this->microdatapro->opencart_version(0) == 2){ //IF 2
				$this->db->query("DELETE FROM " . DB_PREFIX . "layout_module WHERE `sort_order` = '3274'");
				foreach($this->data['layouts'] as $layout){
					$this->db->query("INSERT INTO " . DB_PREFIX . "layout_module SET 
					`layout_id` = '" . (int)$layout['layout_id'] . "', 
					`code` = 'microdatapro', 
					`position` = 'content_bottom', 
					`sort_order` = '3274'");
				}
				if($this->microdatapro->opencart_version(1) >= 3){ //IF over 2.3
					$this->response->redirect($this->url->link('extension/module/microdatapro', 'token=' . $this->session->data['token'], true));
				}else{
					$this->response->redirect($this->url->link('module/microdatapro', 'token=' . $this->session->data['token'], 'SSL'));
				}
			}else{
				$this->redirect($this->url->link('module/microdatapro', 'token=' . $this->session->data['token'], 'SSL'));				
			}
		}
				
		$heading_title_array = explode(" [", $this->language->get('heading_title'));
		$this->data['heading_title'] = $heading_title_array[0] . ' ' . $this->microdatapro->module_info('version');
		$this->data['heading_title_st'] = strip_tags($this->language->get('heading_title'));
		
		//text
		$this->data['text_entry_email']      = sprintf($this->language->get('text_entry_email'), $this->config->get('config_email'));

		$this->data['config_email'] = $this->config->get('config_email');
		$this->data['text_module'] = $this->language->get('text_module');

		if($this->microdatapro->opencart_version(1) >= 3){ //IF over 2.3
			$this->data['modules_link'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['action'] = $this->url->link('extension/module/microdatapro', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL');
		}else{
			$this->data['modules_link'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['action'] = $this->url->link('module/microdatapro', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		}
        $a=0;
        if(isset($key) && !empty($key)){ $key_array = explode("327450", base64_decode(strrev(substr($key, 0, -7))));
        if($key_array[0] == base64_encode($this->microdatapro->module_info('main_host')) && $key_array[1] == base64_encode($this->microdatapro->module_info('sys_key').$this->microdatapro->module_info('sys_keyf')+100)){$this->data['activated'] =$a= 1;}}
		if($this->microdatapro->opencart_version(0) == 2){
			$this->data['config_microdata_text_home'] = $this->config->get('config_microdata_text_home');
		}		
		
		//array vars
		$vars = array(
			'config_microdata_registration_email',
			'config_microdata_registration_nikname',
			'config_microdata_status',
			'config_company',
			'config_company_syntax',
			'config_company_rating',
			'config_latest_breadcrumb',
			'config_in_stock_status_id',
			'config_photo_original',
			'config_product_syntax',
			'config_category_syntax',
			'config_manufacturer_syntax',
			'config_information_syntax',
			'config_special_syntax',
			'config_clear_price',
			'config_microdata_phones',
			'config_microdata_groups',
			'config_microdata_address_1',
			'config_microdata_address_2',
			'config_microdata_address_3',
			'config_microdata_email',
			'config_product_page',
			'config_category_page',
			'config_manufacturer_page',
			'config_information_page',
			'config_information_author',
			'config_special_page',
			'config_special_manual_rating',
			'config_special_manual_count',
			'config_special_total_rating',				
			'config_product_breadcrumb',
			'config_category_breadcrumb',
			'config_category_manual_rating',
			'config_category_manual_count',
			'config_category_total_rating',
			'config_desc_full',
			'config_manufacturer_breadcrumb',
			'config_manufacturer_manual_rating',
			'config_manufacturer_manual_count',
			'config_manufacturer_total_rating',			
			'config_information_breadcrumb',
			'config_special_breadcrumb',
			'config_product_related',
			'config_product_reviews',
			'config_product_attribute', 
			'config_product_in_stock', 
			'config_microdata_mpn',  
			'config_microdata_sku',  
			'config_microdata_upc', 
			'config_microdata_ean', 
			'config_microdata_isbn', 
			'config_microdata_special_description', 
			'config_microdata_special_name', 
			'config_microdata_product_description', 
			'config_microdata_category_description', 
			'config_microdata_manufacturer_description', 
			'config_microdata_twitter',
			'config_microdata_opengraph',
			'config_microdata_twitter_account'
			
		);
		
		//add multistore vars
		$store_results = $this->model_setting_store->getStores();
		foreach ($store_results as $result) {
			$vars[] = 'config_microdata_phones'.$result['store_id'];
			$vars[] = 'config_microdata_groups'.$result['store_id'];
			$vars[] = 'config_microdata_address_1'.$result['store_id'];
			$vars[] = 'config_microdata_address_2'.$result['store_id'];
			$vars[] = 'config_microdata_address_3'.$result['store_id'];
			$vars[] = 'config_microdata_email'.$result['store_id'];
		}
		
 		foreach($vars as $var){
			if (isset($this->request->post[$var])) {
				$this->data[$var] = $this->request->post[$var];
			} else {
				$this->data[$var] = $this->config->get($var);
			}
		}

		//get all stores to tpl
		$this->data['store_name'] = $this->config->get('config_name');
		$this->data['stores'] = array();
		foreach ($store_results as $result) {
			$this->data['stores'][] = array(
				'store_id' => $result['store_id'],
				'name'     => $result['name'],
				'config_microdata_phones' => $this->data['config_microdata_phones'.$result['store_id']],
				'config_microdata_groups' => $this->data['config_microdata_groups'.$result['store_id']],
				'config_microdata_address_1' => $this->data['config_microdata_address_1'.$result['store_id']],
				'config_microdata_address_2' => $this->data['config_microdata_address_2'.$result['store_id']],
				'config_microdata_address_3' => $this->data['config_microdata_address_3'.$result['store_id']],
				'config_microdata_email' => $this->data['config_microdata_email'.$result['store_id']],
			); 
		}		
		
		//stock_statuses
		$this->load->model('localisation/stock_status');
		$this->data['stock_statuses'] =  $this->model_localisation_stock_status->getStockStatuses();
		$this->data['stock_status_id'] = $this->config->get('config_in_stock_status_id');

		//find old microdata
		$this->data['old_microdata'] = $this->find_old();

		if($this->microdatapro->opencart_version(0) == 2){
			$data = $this->data;
			$data['template_for_2'] = true; 
			$data['header'] = $this->load->controller('common/header');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['footer'] = $this->load->controller('common/footer');
			$a=0;
			if(isset($key) && !empty($key)){ $key_array = explode("327450", base64_decode(strrev(substr($key, 0, -7))));
			if($key_array[0] == base64_encode($this->microdatapro->module_info('main_host')) && $key_array[1] == base64_encode($this->microdatapro->module_info('sys_key').$this->microdatapro->module_info('sys_keyf')+100)){$this->data['activated'] =$a= 1;}}
			if($this->microdatapro->opencart_version(1) >= 3){
				$this->response->setOutput($this->load->view('extension/module/microdatapro', $data));
			}else{
				$this->response->setOutput($this->load->view('module/microdatapro.tpl', $data));
			}
		}else{
			$this->data['template_for_2'] = false;
			$this->template = 'module/microdatapro.tpl';
			$this->children = array(
				'common/header',
				'common/footer'
			);
			$a=0;
			if(isset($key) && !empty($key)){ $key_array = explode("327450", base64_decode(strrev(substr($key, 0, -7))));
			if($key_array[0] == base64_encode($this->microdatapro->module_info('main_host')) && $key_array[1] == base64_encode($this->microdatapro->module_info('sys_key').$this->microdatapro->module_info('sys_keyf')+100)){$this->data['activated'] =$a= 1;}}
			$this->response->setOutput($this->render());
		}
	}	

	public function find_old() {
		$microdata = array();	
		$find_files	= $old_microdata = array();
		$find_files = $this->scan_Dir(DIR_CATALOG . "view/theme/" . $this->config->get('config_template') . "/template");

		$find_tags = array(
			'itemscope',
			'itemprop',
			'itemtype',
			'typeof="v:',
			'prefix:v',
			'property="v:',
			'rel="v:',
		);
		
		if($find_files){		
			foreach($find_files as $file){
				foreach($find_tags as $tag){	
					if (strpos(file_get_contents($file), $tag)){
						$old_microdata[] = $file;
					}
				}			
			}
		}

		if($old_microdata){
			foreach($old_microdata as $old_item){
				$data_arr = explode("catalog/view", $old_item);
				if(!strpos($data_arr[1], "microdatapro") and !strpos($data_arr[1], "mdp_backup") and !strpos($data_arr[1], "agoo")){
					$microdata['catalog/view' . $data_arr[1]] = 'catalog/view' . $data_arr[1];
				}
			}
		}
		
		return $microdata;		
	}
	
	public function clear_old() {
		$microdata = array();	
			
		$find_files = $this->scan_Dir(DIR_CATALOG . "view/theme/" . $this->config->get('config_template') . "/template");

		$find_tags = array(
			'itemscope',
			'itemprop',
			'itemtype',
			'typeof="v:',
			'prefix:v',			
			'property="v:',
			'rel="v:',
		);
		
		$find_tags_replace = array(
			'data-mdp',
			'data-mdp',
			'data-mdp',
			'data-mdp="',
			'data-mdp',
			'data-mdp="',
			'data-mdp="',			
		);	
		
		foreach($find_files as $file){
		  if(!strpos($file, "microdatapro") and !strpos($file, "mdp_backup") and !strpos($file, "agoo")){	
			foreach($find_tags as $tag){	
				if (strpos(file_get_contents($file), $tag)){	
					$microdata[$file] = $file;
				}
			}
		  }			
		}

		foreach($microdata as $item){
		  if(!strpos($file, "microdatapro") and !strpos($file, "mdp_backup") and !strpos($file, "agootemplates")){
			$file_data = str_replace($find_tags, $find_tags_replace, file_get_contents($item));	
			rename($item, $item."_mdp_backup");
			$fp = fopen($item, "w");
			fwrite($fp, $file_data);
			fclose($fp);
			$this->log->write("microdatapro clear file: " . $item);
			$this->log->write("microdatapro original file: " . $item . "_mdp_backup");
		  }
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($microdata));		
	}
	
	public function scan_Dir($dir) {
		$arrfiles = array();
		if (is_dir($dir)) {
			if ($handle = opendir($dir)) {
				chdir($dir);
				while (false !== ($file = readdir($handle))) { 
					if ($file != "." && $file != "..") { 
						if (is_dir($file)) { 
							$arr = $this->scan_Dir($file);
							foreach ($arr as $value) {
								$arrfiles[] = $dir."/".$value;
							}
						} else {
							$arrfiles[] = $dir."/".$file;
						}
					}
				}
				chdir("../");
			}
			closedir($handle);
		}
		
		return $arrfiles;
	}
	
	public function getStatus() {
		
		$this->microdatapro = new Microdatapro($this->registry);

		$result = $this->microdatapro->request();
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($result));

	}	
	
	public function getKey() {
		
		$this->microdatapro = new Microdatapro($this->registry);

		$result = $this->microdatapro->getKey();
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($result));

	}
	
	public function editSetting($group, $data, $store_id = 0) {
		$this->microdatapro = new Microdatapro($this->registry);
		if($this->microdatapro->opencart_version(0) == 2){
			$group_code = "code";
		}else{
			$group_code = "group";			
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE store_id = '" . (int)$store_id . "' AND `$group_code` = '" . $this->db->escape($group) . "'");

		foreach ($data as $key => $value) {
			if (!is_array($value)) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '" . (int)$store_id . "', `$group_code` = '" . $this->db->escape($group) . "', `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape($value) . "'");
			} else {
				$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '" . (int)$store_id . "', `$group_code` = '" . $this->db->escape($group) . "', `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape(serialize($value)) . "', serialized = '1'");
			}
		}
	}	
}
?>