<?php
class ControllerLightcheckoutConfirm extends Controller {
	
	public function add() {
		
	}
	
	public function index() {
		$redirect = '';
		
		$data = array();
		
		$this->load->language('lightcheckout/checkout');
		$language_get = array('button_confirm','text_loading','text_none');
		foreach ($language_get as $get){
			$data[$get] = $this->language->get($get);
		}
		
		if ($this->cart->hasShipping()) {
			// Validate if shipping address has been set.
			/*if (!isset($this->session->data['shipping_address'])) {
				$redirect = $this->url->link('lightcheckout/checkout', '', true);
			}*/

			// Validate if shipping method has been set.
			/*if (!isset($this->session->data['shipping_method'])) {
				$redirect = $this->url->link('lightcheckout/checkout', '', true);
			}*/
		} else {
			unset($this->session->data['shipping_address']);
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
		}

		// Validate if payment address has been set.
		/*if (!isset($this->session->data['payment_address'])) {
			$redirect = $this->url->link('lightcheckout/checkout', '', true);
		}*/

		// Validate if payment method has been set.
		/*if (!isset($this->session->data['payment_method'])) {
			$redirect = $this->url->link('lightcheckout/checkout', '', true);
		}*/

		// Validate cart has products and has stock.
		/*if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$redirect = $this->url->link('checkout/cart');
		}*/

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
				$redirect = $this->url->link('checkout/cart');

				break;
			}
		}
		
		$this->load->model('setting/setting');
		$setting_info = $this->model_setting_setting->getSetting('theme_' . $this->config->get('config_theme'), $this->config->get('config_store_id'));
		
		if (isset($setting_info['theme_' . $this->config->get('config_theme') . '_directory'])) {
			$data['theme'] = $setting_info['theme_' . $this->config->get('config_theme') . '_directory'];
		} elseif (isset($setting_info['theme_default_directory'])) {
			$data['theme'] = $setting_info['theme_default_directory'];
		} else {
			$data['theme'] = $this->config->get('config_theme');
		}
		
		$config_version = substr(VERSION, 0, 3);

		if (!$redirect) {
			
			if (isset($this->request->get['save'])) {
				
				$data['save'] = $this->request->get['save'];
				
				$order_data = array();

				$totals = array();
				$taxes = $this->cart->getTaxes();
				$total = 0;

				// Because __call can not keep var references so we put them into an array.
				$total_data = array(
					'totals' => &$totals,
					'taxes'  => &$taxes,
					'total'  => &$total
				);

				

				$sort_order = array();
				
				if ($config_version == '3.0' or $config_version == '3.1'){
					$this->load->model('setting/extension');
					$results = $this->model_setting_extension->getExtensions('total');
					$total_ = 'total_';
				} else {
					$this->load->model('extension/extension');
					$results = $this->model_extension_extension->getExtensions('total');
					$total_ = '';
				}

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($total_ . $value['code'] . '_sort_order');
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
					if ($this->config->get($total_ . $result['code'] . '_status')) {
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

				$order_data['totals'] = $totals;

				$order_data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
				$order_data['store_id'] = $this->config->get('config_store_id');
				$order_data['store_name'] = $this->config->get('config_name');

				if ($order_data['store_id']) {
					$order_data['store_url'] = $this->config->get('config_url');
				} else {
					if ($this->request->server['HTTPS']) {
						$order_data['store_url'] = HTTPS_SERVER;
					} else {
						$order_data['store_url'] = HTTP_SERVER;
					}
				}
				
				$this->load->model('extension/module/lightcheckout');
				$status = $this->model_extension_module_lightcheckout->getBaseStatus();
			
				$order_data['customer_id'] = 0;
				$order_data['customer_group_id'] = 0;
				$order_data['firstname'] = '';
				$order_data['lastname'] = '';
				$order_data['email'] = '';
				$order_data['telephone'] = ''; 
				$order_data['custom_field'] = '';
				$order_data['payment_firstname'] = '';
				$order_data['payment_lastname'] = '';
				$order_data['payment_company'] = '';
				$order_data['payment_address_1'] = '';
				$order_data['payment_address_2'] = '';
				$order_data['payment_city'] = '';
				$order_data['payment_postcode'] = '';
				$order_data['payment_zone'] = '';
				$order_data['payment_zone_id'] = '';
				$order_data['payment_country'] = '';
				$order_data['payment_country_id'] = '';
				$order_data['payment_address_format'] = '';
				$order_data['payment_custom_field'] = '';
				$order_data['shipping_firstname'] = '';
				$order_data['shipping_lastname'] = '';
				$order_data['shipping_company'] = '';
				$order_data['shipping_address_1'] = '';
				$order_data['shipping_address_2'] = '';
				$order_data['shipping_city'] = '';
				$order_data['shipping_postcode'] = '';
				$order_data['shipping_zone'] = '';
				$order_data['shipping_zone_id'] = '';
				$order_data['shipping_country'] = '';
				$order_data['shipping_country_id'] = '';
				$order_data['shipping_address_format'] = '';
				$order_data['shipping_custom_field'] = '';
				$order_data['comment'] = '';
				$order_data['fax'] = '';
			
				$this->load->model('account/customer');
				
				if ($this->customer->isLogged()) {
					$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());

					$order_data['customer_id'] = $this->customer->getId();
					$order_data['customer_group_id'] = $customer_info['customer_group_id'];
					$order_data['firstname'] = $customer_info['firstname'];
					$order_data['lastname'] = $customer_info['lastname'];
					$order_data['email'] = $customer_info['email'];
					$order_data['telephone'] = $customer_info['telephone'];
					$order_data['custom_field'] = json_decode($customer_info['custom_field'], true);
				} elseif (isset($this->session->data['guest'])) {
					$order_data['customer_id'] = 0;
					if (isset($this->session->data['guest']['customer_group_id'])){$order_data['customer_group_id'] = $this->session->data['guest']['customer_group_id'];}
					if (isset($this->session->data['guest']['firstname'])){$order_data['firstname'] = $this->session->data['guest']['firstname'];}
					if (isset($this->session->data['guest']['lastname'])){$order_data['lastname'] = $this->session->data['guest']['lastname'];}
					if (isset($this->session->data['guest']['email'])){$order_data['email'] = $this->session->data['guest']['email'];}
					if (isset($this->session->data['guest']['telephone'])){$order_data['telephone'] = $this->session->data['guest']['telephone'];}
					if (isset($this->session->data['guest']['custom_field'])){$order_data['custom_field'] = $this->session->data['guest']['custom_field'];}
				}
				
				// Payment
					if (isset($this->session->data['payment_address'])) {
						
						// Payments Fields
						$payments = array('firstname','lastname','company','address_1','address_2','city','postcode','zone','zone_id','country','country_id','address_format');
						
						
						foreach ($payments as $field) {
							if (isset($this->session->data['payment_address'][$field])) {
								$order_data['payment_' . $field] = $this->session->data['payment_address'][$field];
							}
						}
						
						if (isset($this->session->data['payment_address']['email'])) {
							$order_data['email'] = $this->session->data['payment_address']['email'];
						} 
						if (isset($this->session->data['payment_address']['telephone'])) {
							$order_data['telephone'] = $this->session->data['payment_address']['telephone'];
						}
						if (isset($this->session->data['payment_address']['custom_field'])) {
							$order_data['payment_custom_field'] = (isset($this->session->data['payment_address']['custom_field']) ? $this->session->data['payment_address']['custom_field'] : array());
						}
					}				

					if (isset($this->session->data['payment_method']['title'])) {
						$order_data['payment_method'] = $this->session->data['payment_method']['title'];
					} else {
						$order_data['payment_method'] = $this->language->get('text_empty_method');
					}

					if (isset($this->session->data['payment_method']['code'])) {
						$order_data['payment_code'] = $this->session->data['payment_method']['code'];
					} else {
						$order_data['payment_code'] = '';
					}
				
				// Shipping
					if ($this->cart->hasShipping()) {
						
						// Test Shipping Fields
						$session_shipping_address = array();
						if (isset($this->session->data['shipping_address'])) {
							$session_shipping_address = $this->session->data['shipping_address'];
							unset($session_shipping_address['country_id']);
							unset($session_shipping_address['zone_id']);
						}
						
						// Test Payment Fields
						$session_payment_address = array();
						if (isset($this->session->data['payment_address'])) {
							$session_payment_address = $this->session->data['payment_address'];
							unset($session_payment_address['email']);
							unset($session_payment_address['telephone']);
							unset($session_payment_address['country_id']);
							unset($session_payment_address['zone_id']);
						}
						
						if ($session_shipping_address || $session_payment_address) {
							if ($session_shipping_address) {
								// Shipping Fields
								$shippings = array('firstname','lastname','company','address_1','address_2','city','postcode','zone','zone_id','country','country_id','address_format');
								foreach ($shippings as $field) {
									if (isset($this->session->data['shipping_address'][$field])) {
										$order_data['shipping_' . $field] = $this->session->data['shipping_address'][$field];
									}
								}
								if (isset($this->session->data['shipping_address']['custom_field'])) {
									$order_data['shipping_custom_field'] = (isset($this->session->data['shipping_address']['custom_field']) ? $this->session->data['shipping_address']['custom_field'] : array());
								}
								
								if (!$session_payment_address) {
									// Payment Fields If Empty Payment
									$payments = array('firstname','lastname','company','address_1','address_2','city','postcode','zone','zone_id','country','country_id');
									foreach ($payments as $field) {
										if (isset($this->session->data['shipping_address'][$field])) {
											$order_data['payment_' . $field] = $this->session->data['shipping_address'][$field];
										}
									}
								}
							}
						
							if ($session_payment_address) {
								// Payment Fields
								$payments = array('firstname','lastname','company','address_1','address_2','city','postcode','zone','zone_id','country','country_id');
								foreach ($payments as $field) {
									if (isset($this->session->data['payment_address'][$field])) {
										$order_data['payment_' . $field] = $this->session->data['payment_address'][$field];
									}
								}
								if (isset($this->session->data['payment_address']['custom_field'])) {
									$order_data['payment_custom_field'] = (isset($this->session->data['payment_address']['custom_field']) ? $this->session->data['payment_address']['custom_field'] : array());
								}
								
								if (!$session_shipping_address) {
									// Shipping Fields If Empty Shipping
									$shippings = array('firstname','lastname','company','address_1','address_2','city','postcode','zone','zone_id','country','country_id','address_format');
									foreach ($shippings as $field) {
										if (isset($this->session->data['payment_address'][$field])) {
											$order_data['shipping_' . $field] = $this->session->data['payment_address'][$field];
										}
									}
									
								}
							}
						} else {
							// Для всех параметров
								if (isset($this->session->data['payment_address'])) {
									// Payment Fields If Not Empty Payment
									$payments = array('firstname','lastname','company','address_1','address_2','city','postcode','zone','zone_id','country','country_id');
									foreach ($payments as $field) {
										if (isset($this->session->data['payment_address'][$field])) {
											$order_data['payment_' . $field] = $this->session->data['payment_address'][$field];
										}
									}
									if (isset($this->session->data['payment_address']['custom_field'])) {
										$order_data['payment_custom_field'] = (isset($this->session->data['payment_address']['custom_field']) ? $this->session->data['payment_address']['custom_field'] : array());
									}
								}
								if (isset($this->session->data['shipping_address'])) {
									// Payment Fields If Not Empty Payment
									$payments = array('firstname','lastname','company','address_1','address_2','city','postcode','zone','zone_id','country','country_id');
									foreach ($payments as $field) {
										if (isset($this->session->data['shipping_address'][$field])) {
											$order_data['shipping_' . $field] = $this->session->data['shipping_address'][$field];
										}
									}
									if (isset($this->session->data['shipping_address']['custom_field'])) {
										$order_data['shipping_custom_field'] = (isset($this->session->data['shipping_address']['custom_field']) ? $this->session->data['shipping_address']['custom_field'] : array());
									}
								}
						}
						
						if (isset($this->session->data['shipping_method']['title'])) {
							$order_data['shipping_method'] = $this->session->data['shipping_method']['title'];
						} else {
							$order_data['shipping_method'] = $this->language->get('text_empty_method');
						}

						if (isset($this->session->data['shipping_method']['code'])) {
							$order_data['shipping_code'] = $this->session->data['shipping_method']['code'];
						} else {
							$order_data['shipping_code'] = '';
						}
					} else {
						$order_data['shipping_firstname'] = '';
						$order_data['shipping_lastname'] = '';
						$order_data['shipping_company'] = '';
						$order_data['shipping_address_1'] = '';
						$order_data['shipping_address_2'] = '';
						$order_data['shipping_city'] = '';
						$order_data['shipping_postcode'] = '';
						$order_data['shipping_zone'] = '';
						$order_data['shipping_zone_id'] = '';
						$order_data['shipping_country'] = '';
						$order_data['shipping_country_id'] = '';
						$order_data['shipping_address_format'] = '';
						$order_data['shipping_custom_field'] = array();
						$order_data['shipping_method'] = '';
						$order_data['shipping_code'] = '';
					}

				$order_data['products'] = array();

				foreach ($this->cart->getProducts() as $product) {
					$option_data = array();

					foreach ($product['option'] as $option) {
						$option_data[] = array(
							'product_option_id'       => $option['product_option_id'],
							'product_option_value_id' => $option['product_option_value_id'],
							'option_id'               => $option['option_id'],
							'option_value_id'         => $option['option_value_id'],
							'name'                    => $option['name'],
							'value'                   => $option['value'],
							'type'                    => $option['type']
						);
					}

					$order_data['products'][] = array(
						'product_id' => $product['product_id'],
						'name'       => $product['name'],
						'model'      => $product['model'],
						'option'     => $option_data,
						'download'   => $product['download'],
						'quantity'   => $product['quantity'],
						'subtract'   => $product['subtract'],
						'price'      => $product['price'],
						'total'      => $product['total'],
						'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
						'reward'     => $product['reward']
					);
				}

				// Gift Voucher
				$order_data['vouchers'] = array();

				if (!empty($this->session->data['vouchers'])) {
					foreach ($this->session->data['vouchers'] as $voucher) {
						$order_data['vouchers'][] = array(
							'description'      => $voucher['description'],
							'code'             => token(10),
							'to_name'          => $voucher['to_name'],
							'to_email'         => $voucher['to_email'],
							'from_name'        => $voucher['from_name'],
							'from_email'       => $voucher['from_email'],
							'voucher_theme_id' => $voucher['voucher_theme_id'],
							'message'          => $voucher['message'],
							'amount'           => $voucher['amount']
						);
					}
				}
			
				if (isset($this->session->data['comment'])) {
					$order_data['comment'] = $this->session->data['comment'];
				}
			
				$order_data['total'] = $total_data['total'];

				if (isset($this->request->cookie['tracking'])) {
					$order_data['tracking'] = $this->request->cookie['tracking'];

					$subtotal = $this->cart->getSubTotal();

					// Affiliate
					$affiliate_info = $this->model_account_customer->getAffiliateByTracking($this->request->cookie['tracking']);

					if ($affiliate_info) {
						$order_data['affiliate_id'] = $affiliate_info['customer_id'];
						$order_data['commission'] = ($subtotal / 100) * $affiliate_info['commission'];
					} else {
						$order_data['affiliate_id'] = 0;
						$order_data['commission'] = 0;
					}

					// Marketing
					$this->load->model('checkout/marketing');

					$marketing_info = $this->model_checkout_marketing->getMarketingByCode($this->request->cookie['tracking']);

					if ($marketing_info) {
						$order_data['marketing_id'] = $marketing_info['marketing_id'];
					} else {
						$order_data['marketing_id'] = 0;
					}
				} else {
					$order_data['affiliate_id'] = 0;
					$order_data['commission'] = 0;
					$order_data['marketing_id'] = 0;
					$order_data['tracking'] = '';
				}

				$order_data['language_id'] = $this->config->get('config_language_id');
				$order_data['currency_id'] = $this->currency->getId($this->session->data['currency']);
				$order_data['currency_code'] = $this->session->data['currency'];
				$order_data['currency_value'] = $this->currency->getValue($this->session->data['currency']);
				$order_data['ip'] = $this->request->server['REMOTE_ADDR'];

				if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
					$order_data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
				} elseif (!empty($this->request->server['HTTP_CLIENT_IP'])) {
					$order_data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
				} else {
					$order_data['forwarded_ip'] = '';
				}

				if (isset($this->request->server['HTTP_USER_AGENT'])) {
					$order_data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
				} else {
					$order_data['user_agent'] = '';
				}

				if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
					$order_data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
				} else {
					$order_data['accept_language'] = '';
				}

				$this->load->model('checkout/order');
				
				if (!$order_data['firstname']) {
					if ($order_data['payment_firstname']) {
						$order_data['firstname'] = $order_data['payment_firstname'];
					} elseif ($order_data['shipping_firstname']) {
						$order_data['firstname'] = $order_data['shipping_firstname'];
					}
				}
				
				if (!$order_data['lastname']) {
					if ($order_data['payment_lastname']) {
						$order_data['lastname'] = $order_data['payment_lastname'];
					} elseif ($order_data['shipping_lastname']) {
						$order_data['lastname'] = $order_data['shipping_lastname'];
					}
				}
				
				if (!isset($order_data['email']) or !$order_data['email']) {
					$order_data['email'] = $this->config->get('config_email');
				}
				
				$this->session->data['order_id'] = $this->model_checkout_order->addOrder($order_data);
				
			}
			
			if (!isset($this->session->data['order_id'])) {
				$this->session->data['order_id'] = 0;
			}
			
			if (isset($this->session->data['payment_method'])) {
				$data['payment'] = $this->load->controller('extension/payment/' . $this->session->data['payment_method']['code']);
			} else {
				$data['nopayment'] = true;
			}
				
			
		} else {
			$data['redirect'] = $redirect;
			
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
		}
		
		if ($config_version == '3.0' or $config_version == '3.1'){} else {
			if (!isset($this->session->data['guest']['firstname'])){$this->session->data['guest']['firstname'] = '';}
			if (!isset($this->session->data['guest']['lastname'])){$this->session->data['guest']['lastname'] = '';}
		}
		
		$this->response->setOutput($this->load->view('lightcheckout/confirm', $data));
			
	}
	
	public function validation() {
		
		$this->load->language('lightcheckout/checkout');
			
		$json = array();
			
		if (!$json) {
			$this->load->model('account/customer');
			$this->load->model('extension/module/lightcheckout');
			
			$register_show = $this->model_extension_module_lightcheckout->getBaseFieldsParameters('checked_alogin', 'register', 'register', 'show');
			
			if (isset($this->request->post['account']) && $this->request->post['account'] == 'guest') {
				$json['guest'] = true;
				$register_show = false;
			}
			
			/*unset($this->session->data['payment_address']);
			unset($this->session->data['shipping_address']);*/
			
			$status = $this->model_extension_module_lightcheckout->getBaseStatus();
			
			if (isset($status['alogin'])) {
				$json['alogin'] = true;
			}
			if (!$register_show) {
				$json['no_register'] = true;
			}
			if (isset($status['shipping'])) {
				$json['shipping'] = true;
			}
			if (isset($status['payment_address'])) {
				$json['payment_address'] = true;
			}
			if (isset($status['shipping_method'])) {
				$json['shipping_method'] = true;
			}
			if (isset($status['payment_method'])) {
				$json['payment_method'] = true;
			}
			
			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
		}
	}
	
	public function confirm() {
		$json = array();
		
		$order_status_id = $this->config->get('payment_cod_order_status_id');
		
		$this->load->model('extension/module/lightcheckout');
		$settings = $this->model_extension_module_lightcheckout->getBaseSettings();
		if (isset($settings['payment_status']) && $settings['payment_status']) {
			$order_status_id = $settings['payment_status'];
		}		
		
		if (!isset($this->session->data['payment_method'])) {
			$this->load->model('checkout/order');
			$this->model_checkout_order->addOrderHistory($this->session->data['order_id'], $order_status_id);
		
			$json['redirect'] = $this->url->link('checkout/success');
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));		
	}
}
