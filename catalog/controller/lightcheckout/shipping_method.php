<?php
class ControllerLightcheckoutShippingMethod extends Controller {
	public function index() {
		
		$this->load->model('extension/module/lightcheckout');
		$this->load->language('lightcheckout/checkout');
		$language_get = array('text_comments','text_shipping_method','text_none');
		foreach ($language_get as $get){
			$data[$get] = $this->language->get($get);
		}
		
		$data['language_id'] = (int)$this->config->get('config_language_id');
		
		$settings = $this->model_extension_module_lightcheckout->getBaseSettings();
		$data['fields'] = $this->model_extension_module_lightcheckout->getBaseFields('checked_shipping_method', 'shipping_method');
		
		if (isset($this->request->post['shipping_zone_id'])) {
			$this->session->data['shipping_address']['zone_id'] = $this->request->post['shipping_zone_id'];
		} elseif (!isset($this->session->data['shipping_address']['zone_id']) or !$this->session->data['shipping_address']['zone_id']) {
			if (isset($settings['zone_id']) and $settings['zone_id']) {
				$this->session->data['shipping_address']['zone_id'] = $settings['zone_id'];
			} else {
				$this->session->data['shipping_address']['zone_id'] = $this->config->get('config_zone_id');
			}
		}

		if (isset($this->request->post['shipping_country_id'])) {
			$this->session->data['shipping_address']['country_id'] = $this->request->post['shipping_country_id'];
		} elseif (!isset($this->session->data['shipping_address']['country_id']) or !$this->session->data['shipping_address']['country_id']) {
			if (isset($settings['country_id']) and $settings['country_id']) {
				$this->session->data['shipping_address']['country_id'] = $settings['country_id'];
			} else {
				$this->session->data['shipping_address']['country_id'] = $this->config->get('config_country_id');
			}
		}
		
		if (isset($this->session->data['shipping_address'])) {
			// Shipping Methods
			$this->session->data['shipping_methods'] = $this->ShippingMethods($this->session->data['shipping_address']);
		}

		if (empty($this->session->data['shipping_methods'])) {
			$data['error_warning'] = sprintf($this->language->get('error_no_shipping'), $this->url->link('information/contact'));
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['shipping_methods'])) {
			$data['shipping_methods'] = $this->session->data['shipping_methods'];
		} else {
			$data['shipping_methods'] = array();
		}
		
		if (isset($this->session->data['shipping_method']['code'])) {
			$data['code'] = $this->session->data['shipping_method']['code'];
		} else {
			$data['code'] = '';
		}

		if (isset($this->session->data['comment'])) {
			$data['comment'] = $this->session->data['comment'];
		} else {
			$data['comment'] = '';
		}
		
		$this->response->setOutput($this->load->view('lightcheckout/shipping_method', $data));
	}
	
	public function ShippingMethods($shipping_address) {
		
		$method_data = array();
		
		$config_version = substr(VERSION, 0, 3);
		
		if ($config_version == '3.0' or $config_version == '3.1'){
			$this->load->model('setting/extension');
			$results = $this->model_setting_extension->getExtensions('shipping');
			$shipping_ = 'shipping_';
		} else {
			$this->load->model('extension/extension');
			$results = $this->model_extension_extension->getExtensions('shipping');
			$shipping_ = '';
		}
		
		foreach ($results as $result) {
			if ($this->config->get($shipping_ . $result['code'] . '_status')) {
				$this->load->model('extension/shipping/' . $result['code']);

				$quote = $this->{'model_extension_shipping_' . $result['code']}->getQuote($shipping_address);

				if ($quote) {
					$method_data[$result['code']] = array(
						'title'      => $quote['title'],
						'quote'      => $quote['quote'],
						'sort_order' => $quote['sort_order'],
						'error'      => $quote['error']
					);
				}
			}
		}

		$sort_order = array();

		foreach ($method_data as $key => $value) {
			$sort_order[$key] = $value['sort_order'];
		}

		array_multisort($sort_order, SORT_ASC, $method_data);

		return $method_data;
	}

	public function save() {
				
		$this->load->language('lightcheckout/checkout');

		$json = array();
		/*
		// Validate if shipping is required. If not the customer should not have reached this page.
		if (!$this->cart->hasShipping()) {
			$json['redirect'] = $this->url->link('lightcheckout/checkout', '', true);
		}

		// Validate if shipping address has been set.
		if (!isset($this->session->data['shipping_address'])) {
			$json['redirect'] = $this->url->link('lightcheckout/checkout', '', true);
		}

		// Validate cart has products and has stock.
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$json['redirect'] = $this->url->link('checkout/cart');
		}
		*/
		// Validate minimum quantity requirements.
		$products = $this->cart->getProducts();

		foreach ($products as $product) {
			$product_total = 0;

			foreach ($products as $product_2) {
				if ($product_2['product_id'] == $product['product_id']) {
					$product_total += $product_2['quantity'];
				}
			}

			if ($product['minimum'] > $product_total) {
				$json['redirect'] = $this->url->link('checkout/cart');

				break;
			}
		}
		
		$this->load->model('extension/module/lightcheckout');
		$status = $this->model_extension_module_lightcheckout->getBaseStatus();
		$fields = $this->model_extension_module_lightcheckout->getBaseFields('checked_shipping_method', 'shipping_method');
		
		if (isset($this->session->data['shipping_address'])) {
			$this->session->data['shipping_methods'] = $this->ShippingMethods($this->session->data['shipping_address']);
		}
		
		if (isset($status['shipping_method']) and !isset($this->session->data['shipping_address']) and isset($this->session->data['payment_address'])){
			$this->session->data['shipping_methods'] = $this->ShippingMethods($this->session->data['payment_address']);
		}
		
		if (!isset($this->request->post['shipping_method'])) {
			$json['error']['warning'] = $this->language->get('error_shipping');
		} else {
			$shipping = explode('.', $this->request->post['shipping_method']);
			
			if (!isset($shipping[0]) || !isset($shipping[1]) || !isset($this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]])) {
				$json['error']['warning'] = $this->language->get('error_shipping');
			}
		}
		
		if (isset($this->request->post['comment']) and $fields['shipping_comment']['required'] and $fields['shipping_comment']['show']) {
			if ((utf8_strlen(trim($this->request->post['comment'])) < 2) || (utf8_strlen(trim($this->request->post['comment'])) > 128)) {
				$json['error']['comment'] = $this->language->get('error_comment');
			}
		}
		
		if (isset($this->request->get['updatecart'])) {
			unset($json['error']);
		}

		if (!$json) {
			$this->session->data['shipping_method'] = $this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]];

			if (isset($this->request->post['comment'])){$this->session->data['comment'] = strip_tags($this->request->post['comment']);}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function accountaddress(){
		$json = array();
		
		if (isset($this->request->post['address_id'])) {
			$this->load->model('account/address');
			$this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->request->post['address_id']);
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}















