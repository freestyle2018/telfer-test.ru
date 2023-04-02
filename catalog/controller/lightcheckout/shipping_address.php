<?php
class ControllerLightcheckoutShippingAddress extends Controller {
	public function index() {
		$this->load->language('lightcheckout/checkout');
		
		$language_get = array('entry_firstname','entry_lastname','entry_email','entry_telephone','entry_company','entry_address_1','entry_address_2','entry_city','entry_postcode','entry_country','entry_zone','text_none','text_select');
		foreach ($language_get as $get){
			$data[$get] = $this->language->get($get);
		}
		
		$data['language_id'] = (int)$this->config->get('config_language_id');
		
		$this->load->model('extension/module/lightcheckout');
		
		$data['fields'] = $this->model_extension_module_lightcheckout->getBaseFields('checked_shipping', 'shipping');
		
		$settings = $this->model_extension_module_lightcheckout->getBaseSettings();

		if (isset($this->session->data['shipping_address']['address_id'])) {
			$data['address_id'] = $this->session->data['shipping_address']['address_id'];
		} else {
			$data['address_id'] = $this->customer->getAddressId();
		}

		$this->load->model('account/address');

		$data['addresses'] = $this->model_account_address->getAddresses();

		if (isset($this->session->data['shipping_address']['postcode'])) {
			$data['postcode'] = $this->session->data['shipping_address']['postcode'];
		} else {
			$data['postcode'] = '';
		}

		if (isset($this->session->data['shipping_address']['country_id'])) {
			$data['country_id'] = $this->session->data['shipping_address']['country_id'];
		} else {
			if (isset($settings['country_id']) && $settings['country_id']) {
				$data['country_id'] = $settings['country_id'];
			} else {
				$data['country_id'] = $this->config->get('config_country_id');
			}
		}

		if (isset($this->session->data['shipping_address']['zone_id'])) {
			$data['zone_id'] = $this->session->data['shipping_address']['zone_id'];
		} else {
			if (isset($settings['zone_id']) && $settings['zone_id']) {
				$data['zone_id'] = $settings['zone_id'];
			} else {
				$data['zone_id'] = $this->config->get('config_zone_id');
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

		if (isset($this->session->data['shipping_address']['custom_field'])) {
			$data['shipping_address_custom_field'] = $this->session->data['shipping_address']['custom_field'];
		} else {
			$data['shipping_address_custom_field'] = array();
		}

		$this->load->model('localisation/zone');

		$data['zones'] = $this->model_localisation_zone->getZonesByCountryId($data['country_id']);
		
		$this->response->setOutput($this->load->view('lightcheckout/shipping_address', $data));
	}

	public function save() {
		$this->load->language('lightcheckout/checkout');
		
		$json = array();

		// Validate if customer is logged in.
		/*if (!$this->customer->isLogged()) {
			$json['redirect'] = $this->url->link('lightcheckout/checkout', '', true);
		}*/

		// Validate if shipping is required. If not the customer should not have reached this page.
		/*if (!$this->cart->hasShipping()) {
			$json['redirect'] = $this->url->link('lightcheckout/checkout', '', true);
		}*/

		// Validate cart has products and has stock.
		/*if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$json['redirect'] = $this->url->link('checkout/cart');
		}*/
		
		$this->load->model('extension/module/lightcheckout');
		$status = $this->model_extension_module_lightcheckout->getBaseStatus();

		// Validate minimum quantity requirements.
		$products = $this->cart->getProducts();

		foreach ($products as $product) {
			$product_total = 0;

			foreach ($products as $product_2) {
				if ($product_2['product_id'] == $product['product_id']) {
					$product_total += $product_2['quantity'];
				}
			}

			/*if ($product['minimum'] > $product_total) {
				$json['redirect'] = $this->url->link('checkout/cart');

				break;
			}*/
		}
		
		

		if (!$json) {
			
			
			
			$this->load->model('account/address');
			
			if (!isset($this->request->post['shipping_address']) and isset($this->request->post['shipping_address_shipping'])) {
				$this->request->post['shipping_address'] = $this->request->post['shipping_address_shipping'];
			}
			
			if (isset($this->request->post['shipping_address']) && $this->request->post['shipping_address'] == 'existing') {
				if (empty($this->request->post['address_id'])) {
					$json['error']['warning'] = $this->language->get('error_address');
				} elseif (!in_array($this->request->post['address_id'], array_keys($this->model_account_address->getAddresses()))) {
					$json['error']['warning'] = $this->language->get('error_address');
				}

				if (!$json) {
					$this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->request->post['address_id']);
				}
				
			} else {
				
				$this->load->model('extension/module/lightcheckout');
				$fields_shipping = $this->model_extension_module_lightcheckout->getBaseFields('checked_shipping', 'shipping');
				
				if (isset($this->request->post['shipping_firstname']) and  $fields_shipping['shipping_firstname']['required'] and $fields_shipping['shipping_firstname']['show']) {
					if ((utf8_strlen(trim($this->request->post['shipping_firstname'])) < 1) || (utf8_strlen(trim($this->request->post['shipping_firstname'])) > 32)) {
						$json['error']['firstname'] = $this->language->get('error_firstname');
					}
				}
				if (isset($this->request->post['shipping_lastname']) and  $fields_shipping['shipping_lastname']['required'] and $fields_shipping['shipping_lastname']['show']) {
					if ((utf8_strlen(trim($this->request->post['shipping_lastname'])) < 1) || (utf8_strlen(trim($this->request->post['shipping_lastname'])) > 32)) {
						$json['error']['lastname'] = $this->language->get('error_lastname');
					}
				}
				if (isset($this->request->post['shipping_email']) and $fields_shipping['shipping_email']['show'] and $fields_shipping['shipping_email']['required']) {
					if ((utf8_strlen($this->request->post['shipping_email']) > 96) || !filter_var($this->request->post['shipping_email'], FILTER_VALIDATE_EMAIL)) {
						$json['error']['email'] = $this->language->get('error_email');
					}
				}
				if (isset($this->request->post['shipping_telephone']) and  $fields_shipping['shipping_telephone']['required'] and $fields_shipping['shipping_telephone']['show']) {
					if ((utf8_strlen($this->request->post['shipping_telephone']) < 3) || (utf8_strlen($this->request->post['shipping_telephone']) > 32)) {
						$json['error']['telephone'] = $this->language->get('error_telephone');
					}
				}
				if (isset($this->request->post['shipping_company']) and  $fields_shipping['shipping_company']['required'] and $fields_shipping['shipping_company']['show']) {
					if ((utf8_strlen(trim($this->request->post['shipping_company'])) < 3) || (utf8_strlen(trim($this->request->post['shipping_company'])) > 128)) {
						$json['error']['company'] = $this->language->get('error_company');
					}
				}
				if (isset($this->request->post['shipping_address_1']) and  $fields_shipping['shipping_address_1']['required'] and $fields_shipping['shipping_address_1']['show']) {
					if ((utf8_strlen(trim($this->request->post['shipping_address_1'])) < 3) || (utf8_strlen(trim($this->request->post['shipping_address_1'])) > 128)) {
						$json['error']['address_1'] = $this->language->get('error_address_1');
					}
				}
				if (isset($this->request->post['shipping_address_2']) and  $fields_shipping['shipping_address_2']['required'] and $fields_shipping['shipping_address_2']['show']) {
					if ((utf8_strlen(trim($this->request->post['shipping_address_2'])) < 3) || (utf8_strlen(trim($this->request->post['shipping_address_2'])) > 128)) {
						$json['error']['address_2'] = $this->language->get('error_address_1');
					}
				}
				if (isset($this->request->post['shipping_city']) and  $fields_shipping['shipping_city']['required'] and $fields_shipping['shipping_city']['show']) {
					if ((utf8_strlen(trim($this->request->post['shipping_city'])) < 2) || (utf8_strlen(trim($this->request->post['shipping_city'])) > 128)) {
						$json['error']['city'] = $this->language->get('error_city');
					}
				}
				
				if (isset($this->request->post['shipping_country_id'])) {
					$this->load->model('localisation/country');
					$country_info = $this->model_localisation_country->getCountry($this->request->post['shipping_country_id']);
					if ((($country_info && $country_info['postcode_required']) or ($fields_shipping['shipping_postcode']['required'] and $fields_shipping['shipping_postcode']['show'])) && (utf8_strlen(trim($this->request->post['shipping_postcode'])) < 2 || utf8_strlen(trim($this->request->post['shipping_postcode'])) > 10)) {
						$json['error']['postcode'] = $this->language->get('error_postcode');
					}
					if ($fields_shipping['shipping_country_id']['required'] and $fields_shipping['shipping_country_id']['show']) {
						if ($this->request->post['shipping_country_id'] == '') {
							$json['error']['country'] = $this->language->get('error_country');
						}
					}
				}
				if ($fields_shipping['shipping_zone_id']['required'] and $fields_shipping['shipping_zone_id']['show']) {
					if (!isset($this->request->post['shipping_zone_id']) || $this->request->post['shipping_zone_id'] == '' || !is_numeric($this->request->post['shipping_zone_id'])) {
						$json['error']['zone'] = $this->language->get('error_zone');
					}
				}
				
				if (isset($fields_shipping['shipping_custom']) and $fields_shipping['shipping_custom']['show']) {
					// Custom field validation
					$this->load->model('account/custom_field');
					
					$custom_fields = $this->model_account_custom_field->getCustomFields($this->config->get('config_customer_group_id'));
					
					foreach ($custom_fields as $custom_field) {
						if ($custom_field['location'] == 'address') {
							if ($custom_field['required'] && empty($this->request->post['shipping_custom_field'][$custom_field['location']][$custom_field['custom_field_id']])) {
								$json['error']['custom_field' . $custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
							} elseif (($custom_field['type'] == 'text') && !empty($custom_field['validation']) && !filter_var($this->request->post['shipping_custom_field'][$custom_field['location']][$custom_field['custom_field_id']], FILTER_VALIDATE_REGEXP, array('options' => array('regexp' => $custom_field['validation'])))) {
								$json['error']['custom_field' . $custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
							}
						}
					}
				}
				
				$json_new = $json;
				unset($json_new['shipping_address']);
				
				if (!$json_new) {
					
					if (isset($this->request->post['shipping_address'])) {
						
						if (!isset($status['payment_address'])) {
							unset($this->session->data['payment_address']);
						}
						
						// Shipping Session == Payment Session
						if ($this->request->post['shipping_address'] == 1) {
							if (isset($this->request->post['firstname']) and !isset($this->request->post['shipping_firstname'])) {
								$this->session->data['shipping_address']['firstname'] = $this->request->post['shipping_firstname'] = $this->request->post['firstname'];
							}
							if (isset($this->request->post['lastname']) and !isset($this->request->post['shipping_lastname'])) {
								$this->session->data['shipping_address']['lastname'] = $this->request->post['shipping_lastname'] = $this->request->post['lastname'];
							}
							if (isset($this->request->post['email']) and !isset($this->request->post['shipping_email'])) {
								$this->session->data['shipping_address']['email'] = $this->request->post['shipping_email'] = $this->request->post['email'];
							}
							if (isset($this->request->post['telephone']) and !isset($this->request->post['shipping_telephone'])) {
								$this->session->data['shipping_address']['telephone'] = $this->request->post['shipping_telephone'] = $this->request->post['telephone'];
							}
							if (isset($this->request->post['company']) and !isset($this->request->post['shipping_company'])) {
								$this->session->data['shipping_address']['company'] = $this->request->post['shipping_company'] = $this->request->post['company'];
							}
							if (isset($this->request->post['address_1']) and !isset($this->request->post['shipping_address_1'])) {
								$this->session->data['shipping_address']['address_1'] = $this->request->post['shipping_address_1'] = $this->request->post['address_1'];
							}
							if (isset($this->request->post['address_2']) and !isset($this->request->post['shipping_address_2'])) {
								$this->session->data['shipping_address']['address_2'] = $this->request->post['shipping_address_2'] = $this->request->post['address_2'];
							}
							if (isset($this->request->post['city']) and !isset($this->request->post['shipping_city'])) {
								$this->session->data['shipping_address']['city'] = $this->request->post['shipping_city'] = $this->request->post['city'];
							}
							if (isset($this->request->post['postcode']) and !isset($this->request->post['shipping_postcode'])) {
								$this->session->data['shipping_address']['postcode'] = $this->request->post['shipping_postcode'] = $this->request->post['postcode'];
							}
							if (isset($this->request->post['country_id']) and !isset($this->request->post['shipping_country_id'])) {
								$this->session->data['shipping_address']['country_id'] = $this->request->post['shipping_country_id'] = $this->request->post['country_id'];
								$this->load->model('localisation/country');
								$country = $this->model_localisation_country->getCountry($this->request->post['country_id']);
								$this->session->data['shipping_address']['country'] = $country['name'];
							}
							if (isset($this->request->post['zone_id'])) {
								$this->session->data['shipping_address']['zone_id'] = $this->request->post['shipping_zone_id'] = $this->request->post['zone_id'];
								$this->load->model('localisation/zone');
								$country = $this->model_localisation_zone->getZone($this->request->post['zone_id']);
								if (isset($country['name'])) {$this->session->data['shipping_address']['zone'] = $country['name'];}
							}
							if (isset($this->request->post['custom_field']) and !isset($this->request->post['shipping_custom_field'])) {
								$this->session->data['shipping_address']['custom_field'] = $this->request->post['shipping_custom_field'] = $this->request->post['custom_field'];
							}
						}
						
						// Shipping Session != Payment Session
						if ($this->request->post['shipping_address'] == 'new') {
							if (isset($this->request->post['shipping_firstname'])) {
								$this->session->data['shipping_address']['firstname'] = $this->request->post['shipping_firstname'];
							}
							if (isset($this->request->post['shipping_lastname'])) {
								$this->session->data['shipping_address']['lastname'] = $this->request->post['shipping_lastname'];
							}
							if (isset($this->request->post['shipping_email'])) {
								$this->session->data['shipping_address']['email'] = $this->request->post['shipping_email'];
							}
							if (isset($this->request->post['shipping_telephone'])) {
								$this->session->data['shipping_address']['telephone'] = $this->request->post['shipping_telephone'];
							}
							if (isset($this->request->post['shipping_company'])) {
								$this->session->data['shipping_address']['company'] = $this->request->post['shipping_company'];
							}
							if (isset($this->request->post['shipping_address_1'])) {
								$this->session->data['shipping_address']['address_1'] = $this->request->post['shipping_address_1'];
							}
							if (isset($this->request->post['shipping_address_2'])) {
								$this->session->data['shipping_address']['address_2'] = $this->request->post['shipping_address_2'];
							}
							if (isset($this->request->post['shipping_city'])) {
								$this->session->data['shipping_address']['city'] = $this->request->post['shipping_city'];
							}
							if (isset($this->request->post['shipping_postcode'])) {
								$this->session->data['shipping_address']['postcode'] = $this->request->post['shipping_postcode'];
							}
							
							if (isset($this->request->post['shipping_country_id'])) {
								$this->session->data['shipping_address']['country_id'] = $this->request->post['shipping_country_id'];
								$this->load->model('localisation/country');
								$country = $this->model_localisation_country->getCountry($this->request->post['shipping_country_id']);
								if (isset($country['name'])) {$this->session->data['shipping_address']['country'] = $country['name'];}
							}
							if (isset($this->request->post['shipping_zone_id'])) {
								$this->session->data['shipping_address']['zone_id'] = $this->request->post['shipping_zone_id'];
								$this->load->model('localisation/zone');
								$country = $this->model_localisation_zone->getZone($this->request->post['shipping_zone_id']);
								if (isset($country['name'])) {$this->session->data['shipping_address']['zone'] = $country['name'];}
							}
							
							if (isset($this->request->post['shipping_custom_field'])) {
								$this->session->data['shipping_address']['custom_field'] = $this->request->post['shipping_custom_field'];
							}					
							
							/*
							if (!$this->customer->isLogged()) {

								if (isset($this->request->post['shipping_firstname'])) {$this->request->post['firstname'] = $this->request->post['shipping_firstname'];}
								if (isset($this->request->post['shipping_lastname'])) {$this->request->post['lastname'] = $this->request->post['shipping_lastname'];}
								if (isset($this->request->post['shipping_company'])) {$this->request->post['company'] = $this->request->post['shipping_company'];}
								if (isset($this->request->post['shipping_address_1'])) {$this->request->post['address_1'] = $this->request->post['shipping_address_1'];}
								if (isset($this->request->post['shipping_address_2'])) {$this->request->post['address_2'] = $this->request->post['shipping_address_2'];}
								if (isset($this->request->post['shipping_city'])) {$this->request->post['city'] = $this->request->post['shipping_city'];}
								if (isset($this->request->post['shipping_postcode'])) {$this->request->post['postcode'] = $this->request->post['shipping_postcode'];}
								if (isset($this->request->post['shipping_country_id'])) {$this->request->post['country_id'] = $this->request->post['shipping_country_id'];}
								if (isset($this->request->post['shipping_zone_id'])) {$this->request->post['zone_id'] = $this->request->post['shipping_zone_id'];}
								if (isset($this->request->post['shipping_custom_field'])) {$this->request->post['custom_field'] = $this->request->post['shipping_custom_field'];}
								
								if (isset($status['shipping']) and !isset($status['payment_address'])) {
									if (isset($this->session->data['shipping_address'])){
										$this->session->data['payment_address'] = $this->session->data['shipping_address'];
									}
									if (isset($this->request->post['shipping_email']) and !isset($this->request->post['email'])) {
										$this->session->data['payment_address']['email'] = $this->request->post['shipping_email'];
									}
									
									if (isset($this->request->post['shipping_telephone']) and !isset($this->request->post['telephone'])) {
										$this->session->data['payment_address']['telephone'] = $this->request->post['shipping_telephone'];
									}
								}
							}	*/			
							
							$json['shipping_address'] = 1;
							unset($json['shipping_address']);
							
							if (isset($this->session->data['shipping_address']['email']) and !isset($this->session->data['payment_address']['email']) and !isset($this->request->post['email'])) {
								$this->session->data['payment_address']['email'] = $this->session->data['shipping_address']['email'];
							}
							if (isset($this->session->data['shipping_address']['telephone']) and !isset($this->session->data['payment_address']['telephone']) and !isset($this->request->post['telephone'])) {
								$this->session->data['payment_address']['telephone'] = $this->session->data['shipping_address']['telephone'];
							}
							if (isset($this->session->data['shipping_address']['country_id']) and !isset($this->session->data['payment_address']['country_id']) and !isset($this->request->post['country_id'])) {
								$this->session->data['payment_address']['country_id'] = $this->session->data['shipping_address']['country_id'];
							}
							if (isset($this->session->data['shipping_address']['zone_id']) and !isset($this->session->data['payment_address']['zone_id']) and !isset($this->request->post['zone_id'])) {
								$this->session->data['payment_address']['zone_id'] = $this->session->data['shipping_address']['zone_id'];
							}
						}
					}
				}
				
				/*if (!$json_new) {
					
					$address_id = $this->model_account_address->addAddress($this->customer->getId(), $this->request->post);
					
					if (isset($this->request->post['shipping_address'])) {
						if ($this->request->post['shipping_address'] == 1 or $this->request->post['shipping_address'] == 'existing') {
							$this->session->data['shipping_address'] = $this->model_account_address->getAddress($address_id);
						}
					}
					
					// If no default address ID set we use the last address
					if (!$this->customer->getAddressId()) {
						$this->load->model('account/customer');
						
						$this->model_account_customer->editAddressId($this->customer->getId(), $address_id);
					}			
				}*/			
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}