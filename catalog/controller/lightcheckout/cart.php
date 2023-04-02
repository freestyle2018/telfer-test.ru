<?php
class ControllerLightcheckoutCart extends Controller {
	public function index() {
		
		$config_version = substr(VERSION, 0, 3);
		
		$this->load->language('checkout/cart');		
		$this->load->language('lightcheckout/checkout');
		
		$language_get = array('heading_title_light','entry_lightcoupon','entry_lightapply','entry_lightvoucher','column_image','column_name','column_quantity','column_price','column_total','column_model','heading_title_cart','button_update','button_remove','text_none','text_loading');
		foreach ($language_get as $get){
			$data[$get] = $this->language->get($get);
		}

		if ($this->cart->hasProducts() || !empty($this->session->data['vouchers'])) {
			if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
				$data['error_warning'] = $this->language->get('error_stock');
			} elseif (isset($this->session->data['error'])) {
				$data['error_warning'] = $this->session->data['error'];

				unset($this->session->data['error']);
			}

			if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
				$data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
			} else {
				$data['attention'] = '';
			}

			if (isset($this->session->data['success'])) {
				$data['success'] = $this->session->data['success'];

				unset($this->session->data['success']);
			} else {
				$data['success'] = '';
			}

			$data['action'] = $this->url->link('checkout/cart/edit', '', true);
			
			$weight = $this->cart->getWeight();

			if ($this->config->get('config_cart_weight')) {
				$data['weight'] = $this->weight->format($weight, $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
			} else {
				$data['weight'] = '';
			}
			
			$this->load->model('tool/image');
			$this->load->model('tool/upload');
			
			$this->load->model('extension/module/lightcheckout');
			$restrictions = $this->model_extension_module_lightcheckout->getBaseRestrictions();
			
			if ($restrictions) {
				$model_totals = $this->model_extension_module_lightcheckout->totals($restrictions);
				$data['totals'] = $model_totals['total'];
				if (isset($model_totals['error_close'])){
					$data['error_close'] = $model_totals['error_close'];
				}				
			}			
			
			$config_customer_group_id = $this->config->get('config_customer_group_id');

			$points_total = 0; $count_products = array();

			$data['products'] = array();

			$products = $this->cart->getProducts();

			foreach ($products as $product) {
				
				$count_products[] = $product['quantity'];
				
				$product_total = 0;

				foreach ($products as $product_2) {
					if ($product_2['product_id'] == $product['product_id']) {
						$product_total += $product_2['quantity'];
					}
				}

				if ($product['minimum'] > $product_total) {
					$data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
				}
				
				if ($product['points']) {
					$points_total += $product['points'];
				}

				if ($product['image']) {
					if ($config_version == '3.0' or $config_version == '3.1'){
						$image = $this->model_tool_image->resize($product['image'], $this->config->get('theme_' . $this->config->get('config_theme') . '_image_cart_width'), $this->config->get('theme_' . $this->config->get('config_theme') . '_image_cart_height'));
					} else {
						$image = $this->model_tool_image->resize($product['image'], $this->config->get($this->config->get('config_theme') . '_image_cart_width'), $this->config->get($this->config->get('config_theme') . '_image_cart_height'));
					}
				} else {
					$image = '';
				}

				$option_data = array();

				foreach ($product['option'] as $option) {
					if ($option['type'] != 'file') {
						$value = $option['value'];
					} else {
						$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

						if ($upload_info) {
							$value = $upload_info['name'];
						} else {
							$value = '';
						}
					}

					$option_data[] = array(
						'name'  => $option['name'],
						'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
					);
				}

				// Display prices
				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$unit_price = $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
					
					$price = $this->currency->format($unit_price, $this->session->data['currency']);
					$total = $this->currency->format($unit_price * $product['quantity'], $this->session->data['currency']);
				} else {
					$price = false;
					$total = false;
				}

				$recurring = '';

				if ($product['recurring']) {
					$frequencies = array(
						'day'        => $this->language->get('text_day'),
						'week'       => $this->language->get('text_week'),
						'semi_month' => $this->language->get('text_semi_month'),
						'month'      => $this->language->get('text_month'),
						'year'       => $this->language->get('text_year')
					);

					if ($product['recurring']['trial']) {
						$recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
					}

					if ($product['recurring']['duration']) {
						$recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					} else {
						$recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					}
				}

				$data['products'][] = array(
					'cart_id'   => $product['cart_id'],
					'thumb'     => $image,
					'name'      => $product['name'],
					'model'     => $product['model'],
					'option'    => $option_data,
					'recurring' => $recurring,
					'quantity'  => $product['quantity'],
					'stock'     => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
					'reward'    => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),
					'price'     => $price,
					'total'     => $total,
					'href'      => $this->url->link('product/product', 'product_id=' . $product['product_id'])
				);
			}
			
			$points = $this->customer->getRewardPoints();
			$data['entry_lightreward'] = sprintf($this->language->get('entry_lightreward'), $points);
			
			// Gift Voucher
			$data['vouchers'] = array();

			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $key => $voucher) {
					$data['vouchers'][] = array(
						'key'         => $key,
						'description' => $voucher['description'],
						'amount'      => $this->currency->format($voucher['amount'], $this->session->data['currency']),
						'remove'      => $this->url->link('checkout/cart', 'remove=' . $key)
					);
				}
			}
			
			$settings = $this->model_extension_module_lightcheckout->getBaseSettings();
			
			$settings_cart = $this->model_extension_module_lightcheckout->getBaseSettingsCart();
			
			if ($count_products and $restrictions) {
				if (isset($restrictions[$config_customer_group_id]['min_qty'])) {
					$min_qty = $restrictions[$config_customer_group_id]['min_qty'];
					if (min($count_products) < $min_qty) {
						$data['error_close'] = sprintf($this->language->get('text_min_qty'), $min_qty);
					}
				}			
				if (isset($restrictions[$config_customer_group_id]['max_qty'])) {
					$max_qty = $restrictions[$config_customer_group_id]['max_qty'];
					if (max($count_products) > $max_qty) {
						$data['error_close'] = sprintf($this->language->get('text_max_qty'), $max_qty);
					}
				}
				if (isset($restrictions[$config_customer_group_id]['min_weight'])) {
					$min_weight = $restrictions[$config_customer_group_id]['min_weight'];
					if ($weight and $weight < $min_weight) {
						$data['error_close'] = sprintf($this->language->get('text_min_weight'), $min_weight);
					}
				}
				if (isset($restrictions[$config_customer_group_id]['max_weight'])) {
					$max_weight = $restrictions[$config_customer_group_id]['max_weight'];
					if ($weight and $weight > $max_weight) {
						$data['error_close'] = sprintf($this->language->get('text_max_weight'), $max_weight);
					}
				}
			}
			
			$totals = $this->totals();
			
			$data['totals_cart'] = array();

			foreach ($totals as $total) {
				$data['totals_cart'][] = array(
					'title' => $total['title'],
					'text'  => $this->currency->format($total['value'], $this->session->data['currency'])
				);
			}

			$data['continue'] = $this->url->link('common/home');

			$data['checkout'] = $this->url->link('checkout/checkout', '', true);

			$data['modules'] = array();
			$data['modules_cart'] = array();
			
			$files = glob(DIR_APPLICATION . '/controller/extension/total/*.php');

			if ($files) {
				foreach ($files as $file) {
					$result = $this->load->controller('extension/total/' . basename($file, '.php'));
					$file_basename = basename($file, '.php');
					if ($result) {
						if ($file_basename == 'coupon' || $file_basename == 'voucher' || $file_basename == 'reward') {
							$data['modules_cart'][$file_basename] = $result;
						} else {
							$data['modules'][$file_basename] = $result;
						}
					}
				}
			}
			
			foreach (array('coupon', 'reward', 'voucher') as $name){
				if (isset($settings_cart) and $settings_cart) {
					if (!$settings_cart[$name]) {
						unset($data['modules_cart'][$name]);
					}
				}
			}
			
			if (isset($this->session->data['coupon'])) {
				$data['coupon'] = $this->session->data['coupon'];
			} else {
				$data['coupon'] = '';
			}
			
			if (isset($this->session->data['voucher'])) {
				$data['voucher'] = $this->session->data['voucher'];
			} else {
				$data['voucher'] = '';
			}
			
			if (isset($this->session->data['reward'])) {
				$data['reward'] = $this->session->data['reward'];
			} else {
				$data['reward'] = '';
			}
			
			if (isset($settings['qty'])) {
				$data['qty'] = $settings['qty'];
			} else {
				$data['qty'] = false;
			}			
			if (!$settings) {
				$data['qty'] = true;
			}
			
			$data['updatecart'] = false;
			if (isset($this->request->get['updatecart'])) {
				$data['updatecart'] = true;
				$this->response->setOutput($this->load->view('lightcheckout/cart', $data));
			} else {
				return $this->load->view('lightcheckout/cart', $data);
			}
			
		} else {
			$data['text_error'] = $this->language->get('text_empty');
			
			$data['continue'] = $this->url->link('common/home');

			unset($this->session->data['success']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');
	
			return $this->load->view('lightcheckout/cart', $data);
		}
	}

	public function add() {
		$this->load->language('checkout/cart');

		$json = array();

		if (isset($this->request->post['product_id'])) {
			$product_id = (int)$this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
			if (isset($this->request->post['quantity'])) {
				$quantity = (int)$this->request->post['quantity'];
			} else {
				$quantity = 1;
			}

			if (isset($this->request->post['option'])) {
				$option = array_filter($this->request->post['option']);
			} else {
				$option = array();
			}

			$product_options = $this->model_catalog_product->getProductOptions($this->request->post['product_id']);

			foreach ($product_options as $product_option) {
				if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
					$json['error']['option'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
				}
			}

			if (isset($this->request->post['recurring_id'])) {
				$recurring_id = $this->request->post['recurring_id'];
			} else {
				$recurring_id = 0;
			}

			$recurrings = $this->model_catalog_product->getProfiles($product_info['product_id']);

			if ($recurrings) {
				$recurring_ids = array();

				foreach ($recurrings as $recurring) {
					$recurring_ids[] = $recurring['recurring_id'];
				}

				if (!in_array($recurring_id, $recurring_ids)) {
					$json['error']['recurring'] = $this->language->get('error_recurring_required');
				}
			}

			if (!$json) {
				$this->cart->add($this->request->post['product_id'], $quantity, $option, $recurring_id);

				$json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('checkout/cart'));

				// Unset all shipping and payment methods
				unset($this->session->data['shipping_method']);
				unset($this->session->data['shipping_methods']);
				unset($this->session->data['payment_method']);
				unset($this->session->data['payment_methods']);

				$totals = $this->totals();
			
				$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
			} else {
				$json['redirect'] = str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']));
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function totals() {
		
		$config_version = substr(VERSION, 0, 3);
		
		// Totals
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
		}
		return $totals;
	}

	public function edit() {
		
		$config_version = substr(VERSION, 0, 3);
		
		$this->load->language('checkout/cart');
		$this->load->language('common/cart');
		$this->load->language('lightcheckout/themes');
		
		$json = array();

		// Update
		if (!empty($this->request->post['quantity'])) {
			foreach ($this->request->post['quantity'] as $key => $value) {
				$this->cart->update($key, $value);
			}

			$this->session->data['success'] = $this->language->get('text_remove');
		}
		
		if (count($this->cart->getProducts()) == 0) {
			$json['location'] = true;
		}
		
		/*$this->load->language('extension/total/coupon');
		
		$this->load->model('extension/total/coupon');
		
		if (isset($this->request->post['coupon'])) {
			$coupon = $this->request->post['coupon'];
		} else {
			$coupon = '';
		}

		$coupon_info = $this->model_extension_total_coupon->getCoupon($coupon);

		if (empty($this->request->post['coupon'])) {
			unset($this->session->data['coupon']);
		} elseif ($coupon_info) {
			$this->session->data['coupon'] = $this->request->post['coupon'];
			$this->session->data['success'] = $this->language->get('text_success');
		} else {
			$json['error'] = $this->language->get('error_coupon');
			unset($this->session->data['coupon']);
		}*/
		
		// Totals		

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
		}
		
		$text_items = $this->language->get('text_items');
		$this->load->model('extension/module/lightcheckout');
		$htmls = $this->model_extension_module_lightcheckout->getBaseHtml();
		
		if (isset($htmls['items'][(int)$this->config->get('config_language_id')])){
			$text_items = $htmls['items'][(int)$this->config->get('config_language_id')];
		}
		
		$this->load->model('setting/setting');		
		$setting_info = $this->model_setting_setting->getSetting('theme_' . $this->config->get('config_theme'), $this->config->get('config_store_id'));
		
		if (isset($setting_info['theme_' . $this->config->get('config_theme') . '_directory'])) {
			$theme = $setting_info['theme_' . $this->config->get('config_theme') . '_directory'];
		} elseif (isset($setting_info['theme_default_directory'])) {
			$theme = $setting_info['theme_default_directory'];
		} else {
			$theme = $this->config->get('config_theme');
		}
		
		if (isset($theme) and $this->language->get('text_items_' . $theme) != 'text_items_' . $theme . '_directory') {
			$text_items = $this->language->get('text_items_' . $theme);
			
			$json['theme'] = $theme;
		}
		
		$json['total'] = sprintf($text_items, $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));	

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function remove() {
		
		$config_version = substr(VERSION, 0, 3);
		
		$this->load->language('checkout/cart');

		$json = array();

		// Remove
		if (isset($this->request->post['key'])) {
			$this->cart->remove($this->request->post['key']);

			unset($this->session->data['vouchers'][$this->request->post['key']]);

			$json['success'] = $this->language->get('text_remove');

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);

			// Totals			

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
			}

			$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function voucheremptydelete() {
		$this->load->language('extension/total/voucher');

		$json = array();

		$this->load->model('extension/total/voucher');

		if (isset($this->request->post['voucher'])) {
			$voucher = $this->request->post['voucher'];
		} else {
			$voucher = '';
		}

		$voucher_info = $this->model_extension_total_voucher->getVoucher($voucher);

		if (empty($this->request->post['voucher'])) {
			unset($this->session->data['voucher']);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
