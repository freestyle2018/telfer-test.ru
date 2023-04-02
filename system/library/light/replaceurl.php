<?php

namespace Light;
class Replaceurl {
	
    private $config;

    public function __construct($config) {
        $this->config = $config;
    }

    public function rewrite($url){
		
		$config_version = substr(VERSION, 0, 3);
		
		if ($config_version == '3.0' or $config_version == '3.1'){
			$module_ = 'module_';
		} else {
			$module_ = '';
		}
		
		if ($this->config->get($module_ . 'lightcheckout_status')) {
			if (!$this->config->get($module_ . 'lightcheckout_debugging')) {
				foreach (array('=checkout/checkout', '=checkout/unicheckout', '=checkout/uni_checkout', '=checkout/oct_fastorder', '=checkout/buy', '=revolution/revcheckout', '=checkout/pixelshopcheckout') as $page) {
					if (strpos($url, $page)){
						$url = str_replace($page, '=lightcheckout/checkout', $url);
						break;
					}
				}
			}
			if ($this->config->get($module_ . 'lightcheckout_skipcart') and $this->config->get('light_empty_cart')) {
				foreach (array('=checkout/cart') as $page) {
					if (strpos($url, $page)){
						$url = str_replace($page, !$this->config->get($module_ . 'lightcheckout_debugging') ? '=lightcheckout/checkout' : '=checkout/checkout', $url);
						break;
					}
				}
			}
		}
		
        return $url;
    }
	
	private function clean($data = false) {
		if (is_array($data)) {
			foreach ($data as $key => $value) {
				unset($data[$key]);

				$data[$this->clean($key)] = $this->clean($value);
			}
		} else {
			$data = htmlspecialchars($data, ENT_COMPAT, 'UTF-8');
		}

		return $data;
	
	}
}