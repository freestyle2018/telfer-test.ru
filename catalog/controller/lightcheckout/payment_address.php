<?php
class ControllerLightcheckoutPaymentAddress extends Controller {
	public function index() {
		$this->load->language('lightcheckout/checkout');
		
		$language_get = array('entry_firstname','entry_lastname','entry_email','entry_telephone','entry_company','entry_address_1','entry_address_2','entry_city','entry_postcode','entry_country','entry_zone','text_none','text_select');
		foreach ($language_get as $get){
			$data[$get] = $this->language->get($get);
		}
		
		$data['language_id'] = (int)$this->config->get('config_language_id');

		if (isset($this->session->data['payment_address']['address_id'])) {
			$data['address_id'] = $this->session->data['payment_address']['address_id'];
		} else {
			$data['address_id'] = $this->customer->getAddressId();
		}

		$this->load->model('account/address');

		$data['addresses'] = $this->model_account_address->getAddresses();
		
		$this->load->model('extension/module/lightcheckout');
		
		$data['status'] = $this->model_extension_module_lightcheckout->getBaseStatus();
		
		$data['fields'] = $this->model_extension_module_lightcheckout->getBaseFields('checked_payment_address', 'payment_address');
		
		$settings = $this->model_extension_module_lightcheckout->getBaseSettings();

		if (isset($this->session->data['payment_address']['country_id'])) {
			$data['country_id'] = $this->session->data['payment_address']['country_id'];
		} else {
			if (isset($settings['country_id']) && $settings['country_id']) {
				$data['country_id'] = $settings['country_id'];
			} else {
				$data['country_id'] = $this->config->get('config_country_id');
			}
		}

		if (isset($this->session->data['payment_address']['zone_id'])) {
			$data['zone_id'] = $this->session->data['payment_address']['zone_id'];
		} else {
			if (isset($settings['zone_id']) && $settings['zone_id']) {
				$data['zone_id'] = $settings['zone_id'];
			} else {
				$data['zone_id'] = $this->config->get('config_zone_id');
			}
		}
		
		if ($this->customer->isLogged()) {
			if ($this->config->get('config_tax_customer') == 'payment') {
				$this->load->model('account/address');
				$this->session->data['payment_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
			}
		}

		$this->load->model('localisation/country');

		$data['countries'] = $this->model_localisation_country->getCountries();

		// Custom Fields
		$data['custom_fields'] = array();
		
		$this->load->model('account/custom_field');

		$custom_fields = $this->model_account_custom_field->getCustomFields($this->config->get('config_customer_group_id'));

		foreach ($custom_fields as $custom_field) {
			if ($custom_field['location'] == 'address') {
				$data['custom_fields'][] = $custom_field;
			}
		}

		if (isset($this->session->data['payment_address']['custom_field'])) {
			$data['payment_address_custom_field'] = $this->session->data['payment_address']['custom_field'];
		} else {
			$data['payment_address_custom_field'] = array();
		}
		
		$this->load->model('localisation/zone');

		$data['zones'] = $this->model_localisation_zone->getZonesByCountryId($data['country_id']);
		
		
		
		$this->response->setOutput($this->load->view('lightcheckout/payment_address', $data));
	}

	public function save() {
		
		$config_version = substr(VERSION, 0, 3);
		
		$this->load->language('lightcheckout/checkout');

		$json = array();
/*
		// Validate if customer is logged in.
		if (!$this->customer->isLogged()) {
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

		if (!$json) {
			$this->load->model('account/address');
			$this->load->model('account/customer');
							
			if (isset($this->request->post['payment_address']) && $this->request->post['payment_address'] == 'existing') {
				if (empty($this->request->post['address_id'])) {
					$json['error']['warning'] = $this->language->get('error_address');
				} elseif (!in_array($this->request->post['address_id'], array_keys($this->model_account_address->getAddresses()))) {
					$json['error']['warning'] = $this->language->get('error_address');
				}

				if (!$json) {
					$this->session->data['payment_address'] = $this->model_account_address->getAddress($this->request->post['address_id']);

					unset($this->session->data['payment_method']);
					unset($this->session->data['payment_methods']);
				}
			} else {
				
				$this->load->model('extension/module/lightcheckout');
				$fields = $this->model_extension_module_lightcheckout->getBaseFields('checked_payment_address', 'payment_address');
				
				if (isset($this->request->post['firstname']) and $fields['firstname']['required'] and $fields['firstname']['show']) {
					if ((utf8_strlen(trim($this->request->post['firstname'])) < 1) || (utf8_strlen(trim($this->request->post['firstname'])) > 32)) {
						$json['error']['firstname'] = $this->language->get('error_firstname');
					}
				}
				if (isset($this->request->post['lastname']) and $fields['lastname']['required'] and $fields['lastname']['show']) {
					if ((utf8_strlen(trim($this->request->post['lastname'])) < 1) || (utf8_strlen(trim($this->request->post['lastname'])) > 32)) {
						$json['error']['lastname'] = $this->language->get('error_lastname');
					}
				}
				if (isset($this->request->post['email']) and $fields['email']['required'] and $fields['email']['show']) {
					if ((utf8_strlen($this->request->post['email']) > 96) || !filter_var($this->request->post['email'], FILTER_VALIDATE_EMAIL)) {
						$json['error']['email'] = $this->language->get('error_email');
					}
				}
				if (isset($this->request->post['telephone']) and $fields['phone']['required'] and $fields['phone']['show']) {
					if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
						$json['error']['telephone'] = $this->language->get('error_telephone');
					}
				}
				if (isset($this->request->post['company']) and  $fields['company']['required'] and $fields['company']['show']) {
					if ((utf8_strlen(trim($this->request->post['company'])) < 3) || (utf8_strlen(trim($this->request->post['company'])) > 128)) {
						$json['error']['company'] = $this->language->get('error_company');
					}
				}
				if (isset($this->request->post['address_1']) and $fields['address_1']['required'] and $fields['address_1']['show']) {
					if ((utf8_strlen(trim($this->request->post['address_1'])) < 3) || (utf8_strlen(trim($this->request->post['address_1'])) > 128)) {
						$json['error']['address_1'] = $this->language->get('error_address_1');
					}
				}
				if (isset($this->request->post['address_2']) and $fields['address_2']['required'] and $fields['address_2']['show']) {
					if ((utf8_strlen(trim($this->request->post['address_2'])) < 3) || (utf8_strlen(trim($this->request->post['address_2'])) > 128)) {
						$json['error']['address_2'] = $this->language->get('error_address_1');
					}
				}
				if (isset($this->request->post['city']) and $fields['city']['required'] and $fields['city']['show']) {
					if ((utf8_strlen($this->request->post['city']) < 2) || (utf8_strlen($this->request->post['city']) > 32)) {
						$json['error']['city'] = $this->language->get('error_city');
					}
				}
				if (isset($this->request->post['light_country_id'])) {
					$this->load->model('localisation/country');
					$country_info = $this->model_localisation_country->getCountry($this->request->post['light_country_id']);
					if ((($country_info && $country_info['postcode_required']) or ($fields['postcode']['required'] and $fields['postcode']['show'])) && (utf8_strlen(trim($this->request->post['postcode'])) < 2 || utf8_strlen(trim($this->request->post['postcode'])) > 10)) {
						$json['error']['postcode'] = $this->language->get('error_postcode');
					}
					if ($fields['country_id']['required'] and $fields['country_id']['show']) {
						if ($this->request->post['light_country_id'] == '') {
							$json['error']['country'] = $this->language->get('error_country');
						}
					}
				}
				if (isset($this->request->post['light_zone_id']) and $fields['zone_id']['required'] and $fields['zone_id']['show']) {
					if (!isset($this->request->post['light_zone_id']) || $this->request->post['light_zone_id'] == '' || !is_numeric($this->request->post['light_zone_id']) || !$this->request->post['light_zone_id']) {
						$json['error']['zone'] = $this->language->get('error_zone');
					}
				}
				if (isset($fields['custom']) and $fields['custom']['required'] and $fields['custom']['show']) {
					// Custom field validation
					$this->load->model('account/custom_field');
					$custom_fields = $this->model_account_custom_field->getCustomFields($this->config->get('config_customer_group_id'));
					foreach ($custom_fields as $custom_field) {
						if ($custom_field['location'] == 'address') {
							if ($custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['location']][$custom_field['custom_field_id']])) {
								$json['error']['custom_field' . $custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
							} elseif (($custom_field['type'] == 'text') && !empty($custom_field['validation']) && !filter_var($this->request->post['custom_field'][$custom_field['location']][$custom_field['custom_field_id']], FILTER_VALIDATE_REGEXP, array('options' => array('regexp' => $custom_field['validation'])))) {
								$json['error']['custom_field' . $custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
							}
						}
					}
				}
				if (!$json) {
					
					if (isset($this->request->post['light_zone_id'])){$this->request->post['zone_id'] = $this->request->post['light_zone_id'];}
					if (isset($this->request->post['light_country_id'])){$this->request->post['country_id'] = $this->request->post['light_country_id'];}
					
					foreach (array('firstname', 'lastname', 'company', 'address_1', 'address_2', 'postcode', 'city', 'zone_id', 'country_id') as $field){
						if (!isset($this->request->post[$field])){
							$this->request->post[$field] = '';
						}
					}
					
					if ($config_version == '3.0' or $config_version == '3.1'){
						$address_id = $this->model_account_address->addAddress($this->customer->getId(), $this->request->post);
					} else {
						$address_id = $this->model_account_address->addAddress($this->request->post);
					}

					$this->session->data['payment_address'] = $this->model_account_address->getAddress($address_id);
					
					if (isset($this->request->post['email'])) {
						$this->session->data['payment_address']['email'] = $this->request->post['email'];
					}
					
					if (isset($this->request->post['telephone'])) {
						$this->session->data['payment_address']['telephone'] = $this->request->post['telephone'];
					}
					
					if ($config_version == '3.0' or $config_version == '3.1'){
						// If no default address ID set we use the last address
						if (!$this->customer->getAddressId()) {
							$this->load->model('account/customer');
							
							$this->model_account_customer->editAddressId($this->customer->getId(), $address_id);
						}
					} else {
						if ($this->config->get('config_customer_activity')) {
							$this->load->model('account/activity');

							$activity_data = array(
								'customer_id' => $this->customer->getId(),
								'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
							);

							$this->model_account_activity->addActivity('address_add', $activity_data);
						}
					}
					
				}
			}
			
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}