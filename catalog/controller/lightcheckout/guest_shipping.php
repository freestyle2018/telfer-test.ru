<?php
class ControllerLightcheckoutGuestShipping extends Controller {
	public function index() {
		$this->load->language('lightcheckout/checkout');
		
		$data['language_id'] = (int)$this->config->get('config_language_id');
		
		$this->load->model('extension/module/lightcheckout');
		$data['fields'] = $this->model_extension_module_lightcheckout->getBaseFields('checked_shipping', 'shipping');
		$settings = $this->model_extension_module_lightcheckout->getBaseSettings();

		if (isset($this->session->data['shipping_address']['firstname'])) {
			$data['firstname'] = $this->session->data['shipping_address']['firstname'];
		} else {
			$data['firstname'] = '';
		}

		if (isset($this->session->data['shipping_address']['lastname'])) {
			$data['lastname'] = $this->session->data['shipping_address']['lastname'];
		} else {
			$data['lastname'] = '';
		}

		if (isset($this->session->data['shipping_address']['company'])) {
			$data['company'] = $this->session->data['shipping_address']['company'];
		} else {
			$data['company'] = '';
		}

		if (isset($this->session->data['shipping_address']['address_1'])) {
			$data['address_1'] = $this->session->data['shipping_address']['address_1'];
		} else {
			$data['address_1'] = '';
		}

		if (isset($this->session->data['shipping_address']['address_2'])) {
			$data['address_2'] = $this->session->data['shipping_address']['address_2'];
		} else {
			$data['address_2'] = '';
		}

		if (isset($this->session->data['shipping_address']['postcode'])) {
			$data['postcode'] = $this->session->data['shipping_address']['postcode'];
		} else {
			$data['postcode'] = '';
		}

		if (isset($this->session->data['shipping_address']['city'])) {
			$data['city'] = $this->session->data['shipping_address']['city'];
		} else {
			$data['city'] = '';
		}

		if (isset($this->session->data['shipping_address']['country_id'])) {
			$data['country_id'] = $this->session->data['shipping_address']['country_id'];
		} else {
			if (isset($settings['country_id']) and $settings['country_id']) {
				$data['country_id'] = $settings['country_id'];
			} else {
				$data['country_id'] = $this->config->get('config_country_id');
			}
		}

		if (isset($this->session->data['shipping_address']['zone_id'])) {
			$data['zone_id'] = $this->session->data['shipping_address']['zone_id'];
		} else {
			if (isset($settings['zone_id']) and $settings['zone_id']) {
				$data['zone_id'] = $settings['zone_id'];
			} else {
				$data['zone_id'] = $this->config->get('config_zone_id');
			}
		}

		$this->load->model('localisation/country');

		$data['countries'] = $this->model_localisation_country->getCountries();
		
		if (isset($this->session->data['guest']['customer_group_id'])) {
			// Custom Fields
			$this->load->model('account/custom_field');
			
			$custom_fields = $this->model_account_custom_field->getCustomFields($this->session->data['guest']['customer_group_id']);

			foreach ($custom_fields as $custom_field) {
				if ($custom_field['location'] == 'address') {
					$data['custom_fields'][] = $custom_field;
				}
			}
		}			
		
		if (isset($this->session->data['shipping_address']['custom_field'])) {
			$data['address_custom_field'] = $this->session->data['shipping_address']['custom_field'];
		} else {
			$data['address_custom_field'] = array();
		}
		
		$this->response->setOutput($this->load->view('lightcheckout/guest_shipping', $data));
	}

	public function save() {
		$this->load->language('lightcheckout/checkout');

		$json = array();

		// Validate if customer is logged in.
		if ($this->customer->isLogged()) {
			$json['redirect'] = $this->url->link('lightcheckout/checkout', '', true);
		}

		// Validate cart has products and has stock.
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$json['redirect'] = $this->url->link('checkout/cart');
		}

		// Check if guest checkout is available.
		if (!$this->config->get('config_checkout_guest') || $this->config->get('config_customer_price') || $this->cart->hasDownload()) {
			$json['redirect'] = $this->url->link('lightcheckout/checkout', '', true);
		}

		if (!$json) {
			
			$this->load->model('extension/module/lightcheckout');
			$fields_shipping = $this->model_extension_module_lightcheckout->getBaseFields('checked_shipping', 'shipping');
			
			if (isset($this->request->post['shipping_address'])) {
				if (isset($this->request->post['firstname'])) {$this->request->post['shipping_firstname'] = $this->request->post['firstname'];}
				if (isset($this->request->post['lastname'])) {$this->request->post['shipping_lastname'] = $this->request->post['lastname'];}
				if (isset($this->request->post['address_1'])) {$this->request->post['shipping_address_1'] = $this->request->post['address_1'];}
				if (isset($this->request->post['city'])) {$this->request->post['shipping_city'] = $this->request->post['city'];}
				if (isset($this->request->post['postcode'])) {$this->request->post['shipping_postcode'] = $this->request->post['postcode'];}
				if (isset($this->request->post['country_id'])) {$this->request->post['shipping_country_id'] = $this->request->post['country_id'];}
				if (isset($this->request->post['zone_id'])) {$this->request->post['shipping_zone_id'] = $this->request->post['zone_id'];}
				if (isset($this->request->post['custom_field'])) {$this->request->post['shipping_custom_field'] = $this->request->post['custom_field'];}
				$json['shipping_address'] = 1;
			}
			
			if (isset($this->request->post['shipping_firstname']) and $fields_shipping['shipping_firstname']['required'] and $fields_shipping['shipping_firstname']['show']) {
				if ((utf8_strlen(trim($this->request->post['shipping_firstname'])) < 1) || (utf8_strlen(trim($this->request->post['shipping_firstname'])) > 32)) {
					$json['error']['firstname'] = $this->language->get('error_firstname');
				}
			}
			if (isset($this->request->post['shipping_lastname']) and  $fields_shipping['shipping_lastname']['required'] and $fields_shipping['shipping_lastname']['show']) {
				if ((utf8_strlen(trim($this->request->post['shipping_lastname'])) < 1) || (utf8_strlen(trim($this->request->post['shipping_lastname'])) > 32)) {
					$json['error']['lastname'] = $this->language->get('error_lastname');
				}
			}
			if (isset($this->request->post['shipping_address_1']) and  $fields_shipping['shipping_address_1']['required'] and $fields_shipping['shipping_address_1']['show']) {
				if ((utf8_strlen(trim($this->request->post['shipping_address_1'])) < 3) || (utf8_strlen(trim($this->request->post['shipping_address_1'])) > 128)) {
					$json['error']['address_1'] = $this->language->get('error_address_1');
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
			
			if (isset($fields_shipping['shipping_custom']) and $fields_shipping['shipping_custom']['required']) {
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
		}

		if (!$json) {
			
			if (isset($this->request->post['shipping_firstname'])) {$this->session->data['shipping_address']['firstname'] = $this->request->post['shipping_firstname'];}
			if (isset($this->request->post['shipping_lastname'])) {$this->session->data['shipping_address']['lastname'] = $this->request->post['shipping_lastname'];}
			if (isset($this->request->post['shipping_company'])) {$this->session->data['shipping_address']['company'] = $this->request->post['shipping_company'];}
			if (isset($this->request->post['shipping_address_1'])) {$this->session->data['shipping_address']['address_1'] = $this->request->post['shipping_address_1'];}
			if (isset($this->request->post['shipping_address_2'])) {$this->session->data['shipping_address']['address_2'] = $this->request->post['shipping_address_2'];}
			if (isset($this->request->post['shipping_postcode'])) {$this->session->data['shipping_address']['postcode'] = $this->request->post['shipping_postcode'];}
			if (isset($this->request->post['shipping_city'])) {$this->session->data['shipping_address']['city'] = $this->request->post['shipping_city'];}
			if (isset($this->request->post['shipping_country_id'])) {$this->session->data['shipping_address']['country_id'] = $this->request->post['shipping_country_id'];}
			if (isset($this->request->post['shipping_zone_id'])) {$this->session->data['shipping_address']['zone_id'] = $this->request->post['shipping_zone_id'];}

			$this->load->model('localisation/country');
			
			if (isset($this->request->post['light_zone_id']) and !isset($this->request->post['shipping_zone_id'])){
				$this->request->post['shipping_zone_id'] = $this->request->post['light_zone_id'];
			}
			if (isset($this->request->post['light_country_id']) and !isset($this->request->post['shipping_country_id'])){
				$this->request->post['shipping_country_id'] = $this->request->post['light_country_id'];
			}

			$country_info = $this->model_localisation_country->getCountry($this->request->post['shipping_country_id']);

			if ($country_info) {
				$this->session->data['shipping_address']['country'] = $country_info['name'];
				$this->session->data['shipping_address']['iso_code_2'] = $country_info['iso_code_2'];
				$this->session->data['shipping_address']['iso_code_3'] = $country_info['iso_code_3'];
				$this->session->data['shipping_address']['address_format'] = $country_info['address_format'];
			} else {
				$this->session->data['shipping_address']['country'] = '';
				$this->session->data['shipping_address']['iso_code_2'] = '';
				$this->session->data['shipping_address']['iso_code_3'] = '';
				$this->session->data['shipping_address']['address_format'] = '';
			}

			$this->load->model('localisation/zone');

			$zone_info = $this->model_localisation_zone->getZone($this->request->post['shipping_zone_id']);

			if ($zone_info) {
				$this->session->data['shipping_address']['zone'] = $zone_info['name'];
				$this->session->data['shipping_address']['zone_code'] = $zone_info['code'];
			} else {
				$this->session->data['shipping_address']['zone'] = '';
				$this->session->data['shipping_address']['zone_code'] = '';
			}

			if (isset($this->request->post['shipping_custom_field'])) {
				$this->session->data['shipping_address']['custom_field'] = $this->request->post['shipping_custom_field']['address'];
			} else {
				$this->session->data['shipping_address']['custom_field'] = array();
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}