<?php
class ControllerModuleHttpsFix extends Controller
{
	protected $error = array();
	protected $data;
	protected $url_link_ssl;

	public function __construct($registry) {
	    parent::__construct($registry);
		$this->cont('httpsfix/httpsfix');
        if (is_callable(array('Response', 'httpsfix_setRegistry'))) {
        	$this->response->httpsfix_setRegistry($this->registry);
        }
		$sc_ver = VERSION;
		if (!defined('SC_VERSION')) define('SC_VERSION', (int)substr(str_replace('.','',$sc_ver), 0,2));

        if ((isset($_SERVER['HTTPS']) && (strtolower($_SERVER['HTTPS']) == 'on' || $_SERVER['HTTPS'] == '1')) || (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && (strtolower($_SERVER['HTTP_X_FORWARDED_PROTO']) == 'https') || (!empty($_SERVER['HTTP_X_FORWARDED_SSL']) && strtolower($_SERVER['HTTP_X_FORWARDED_SSL']) == 'on'))) {
        	$this->url_link_ssl = true;
        } else {
        	if (SC_VERSION < 20) {
        		$this->url_link_ssl = 'NONSSL';
        	} else {
        		$this->url_link_ssl = false;
        	}
        }
	    $this->language->load('module/httpsfix');
	    $server_date = $this->config->get('httpsfix_server_date');
	    $server_content = $this->config->get('httpsfix_server_content');
	    $this->data['text_new_version'] = "<div style='text-align: center;'>".$this->language->get('text_update_version_begin')." ".$this->language->get('httpsfix_version_model')." ".$this->language->get('httpsfix_version')." "."<span style='font-size: 11px; color: #909090; font-weight: normal;'>(".$server_date.")</span> ".$server_content. $this->language->get('text_update_version_end')."</div>";
	}

	public function index() {

		require_once(DIR_SYSTEM . 'library/exceptionizer.php');

		$this->load->model('setting/setting');
		$this->load->model('localisation/language');

        if (SC_VERSION > 23) {
        	$this->data['token_name'] = 'user_token';
        } else {
        	$this->data['token_name'] = 'token';
        }

        $this->cacheremove();
        $this->breadcrumbs();
        $this->language_get();

   		$this->data['url_create'] = $this->url->link('module/httpsfix/install_ocmod', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']], $this->url_link_ssl);

        $this->data['languages'] = $this->model_localisation_language->getLanguages();

        $response_content = $this->config->get('httpsfix_server_content');
        $this->data['httpsfix_server_date'] = $this->config->get('httpsfix_server_date');
        $date_current = date('d-m-Y');
        $date_diff = ((strtotime($date_current) - strtotime($this->data['httpsfix_server_date']))/3600/24);

        if ($date_diff > 7) {
	        //$response = $this->server_check();
	        $response['content'] = '';
	        $response['status'] = true;
    	    $response_content = $response['content'];
        	$response_status = $response['status'];
        	$this->data['httpsfix_server_date'] = $date_current;
        }

		if (isset($this->data['httpsfix_version']) && $this->data['httpsfix_version'] != $response_content) {
        	$this->data['text_new_version'] = $this->language->get('text_new_version')." <span style='color: #000; font-weight: normal;'>(".$this->data['httpsfix_server_date'].")</span>". $response_content. $this->language->get('text_new_version_end');
		} else {
			$this->data['text_new_version'] = '';
		}
    	$this->data['text_currnent_version'] = $this->data['httpsfix_version_model'].' '.$this->data['httpsfix_version'];
    	$this->data['text_server_version'] = $response_content;
        $this->data['text_new_version'] = $this->language->get('text_update_version_begin')." <span style='font-size: 11px; color: #909090; font-weight: normal;'>(".$this->data['httpsfix_server_date'].")</span> ".$response_content. $this->language->get('text_update_version_end');
		$this->data['httpsfix_version'] = $httpsfix_version = $this->language->get('httpsfix_version');


		$this->document->setTitle(strip_tags($this->language->get('httpsfix_version_model_html')));

		if (file_exists(DIR_APPLICATION . 'view/stylesheet/httpsfix/httpsfix.css')) {
			$this->document->addStyle('view/stylesheet/httpsfix/httpsfix.css');
		}

		if (file_exists(DIR_APPLICATION . 'view/stylesheet/httpsfix/colpick.css')) {
			$this->document->addStyle('view/stylesheet/httpsfix/colpick.css');
		}
		if (file_exists(DIR_APPLICATION . 'view/javascript/httpsfix/colpick/colpick.js')) {
			$this->document->addScript('view/javascript/httpsfix/colpick/colpick.js');
		}
		if (file_exists(DIR_APPLICATION . 'view/javascript/jquery/tabs.js')) {
			$this->document->addScript('view/javascript/jquery/tabs.js');
		} else {
			if (file_exists(DIR_APPLICATION . 'view/javascript/httpsfix/tabs/tabs.js')) {
				$this->document->addScript('view/javascript/httpsfix/tabs/tabs.js');
			}
		}
		if (file_exists(DIR_APPLICATION . 'view/javascript/httpsfix/httpsfix.js')) {
			$this->document->addScript('view/javascript/httpsfix/httpsfix.js');
		}

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->cache->delete('httpsfix');

			if (isset($this->request->post['settings_httpsfix']['add_url_type'])) {
              foreach ($this->request->post['settings_httpsfix']['add_url_type'] as $type_id => $add_url_type) {

                 if ($add_url_type['url']== '') {
                    $this->request->post['settings_httpsfix']['add_url_type'][$add_url_type ['type_id']] ['url'] = $type_id;
                 }

                 if ($add_url_type['url_replace']== '') {
                    $this->request->post['settings_httpsfix']['add_url_type'][$add_url_type ['type_id']] ['url_replace'] = '//'.$type_id;
                 }

                 if ($add_url_type ['title'][$this->config->get('config_language_id')]=='') {
                 	$this->request->post['settings_httpsfix']['add_url_type'][$add_url_type ['type_id']] ['title'][$this->config->get('config_language_id')] = $add_url_type ['type_id'];
              	 }

              	 if ($type_id != $add_url_type ['type_id']) {
              	 	unset($this->request->post['settings_httpsfix']['add_url_type'][$type_id]);
              	 	$this->request->post['settings_httpsfix']['add_url_type'][$add_url_type ['type_id']] = $add_url_type;
              	 }
              }
			}

			if (isset($this->request->post['settings_httpsfix']['add_ps_js_type'])) {
              foreach ($this->request->post['settings_httpsfix']['add_ps_js_type'] as $type_id => $add_ps_js_type) {

                 if ($add_ps_js_type['keyword']== '') {
                    $this->request->post['settings_httpsfix']['add_ps_js_type'][$add_ps_js_type ['type_id']] ['keyword'] = $type_id;
                 }

                 if ($add_ps_js_type ['title'][$this->config->get('config_language_id')]=='') {
                 	$this->request->post['settings_httpsfix']['add_ps_js_type'][$add_ps_js_type ['type_id']] ['title'][$this->config->get('config_language_id')] = $add_ps_js_type ['type_id'];
              	 }

              	 if ($type_id != $add_ps_js_type ['type_id']) {
              	 	unset($this->request->post['settings_httpsfix']['add_ps_js_type'][$type_id]);
              	 	$this->request->post['settings_httpsfix']['add_ps_js_type'][$add_ps_js_type ['type_id']] = $add_ps_js_type;
              	 }
              }
			}

			$this->model_setting_setting->editSetting('settings_httpsfix', $this->request->post);
  			$this->model_setting_setting->editSetting('settings_httpsfix_admin', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if (SC_VERSION < 20) {
				if (!$this->registry->get('no_redirect')) {
						$this->redirect($this->url->link('module/httpsfix', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']], $this->url_link_ssl));
				}
			} else {
		       	if (!$this->registry->get('no_redirect')) {
		       		$this->response->redirect($this->url->link('module/httpsfix', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']], $this->url_link_ssl));
		       	}
	        }
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$this->data['token'] = $this->session->data[$this->data['token_name']];

		$this->data['url_version_check'] = $this->url->link('module/httpsfix/vercheck', $this->data['token_name'] . '=' . $this->session->data[$this->data['token_name']], $this->url_link_ssl);

        if (version_compare(VERSION, '2.0', '<')) {
	        $mod_str = 'module/httpsfix/cacheremove';
	        $mod_str_value = 'mod=1&';
        } else {
	        $mod_str = 'extension/modification/refresh';
	        $mod_str_value = '';
        }

        $this->data['url_ocmod_refresh'] = $this->url->link($mod_str, $mod_str_value.$this->data['token_name'] . '=' . $this->session->data[$this->data['token_name']], $this->url_link_ssl);

        $this->data['url_cache_remove'] = $this->url->link('module/httpsfix/cacheremove', $this->data['token_name'] . '=' . $this->session->data[$this->data['token_name']], $this->url_link_ssl);
        $this->data['url_cache_image_remove'] = $this->url->link('module/httpsfix/cacheremove', 'image=1&'.$this->data['token_name'].'=' . $this->session->data[$this->data['token_name']], $this->url_link_ssl);
        $this->data['url_delete_settings'] = $this->url->link('module/httpsfix/deletesettings', 'image=1&'.$this->data['token_name'].'=' . $this->session->data[$this->data['token_name']], $this->url_link_ssl);

		$this->data['action'] = $this->url->link('module/httpsfix', $this->data['token_name'] . '=' . $this->session->data[$this->data['token_name']], $this->url_link_ssl);
		$this->data['cancel'] = $this->url->link('extension/module', $this->data['token_name'] . '=' . $this->session->data[$this->data['token_name']], $this->url_link_ssl);
        $this->data['widgets'] = array();

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

        $no_image = '';
        if (file_exists(DIR_IMAGE . 'no_image.jpg')) {
			$no_image = 'no_image.jpg';
		}
        if (file_exists(DIR_IMAGE . 'no_image.png')) {
			$no_image = 'no_image.png';
		}

		if (isset($this->request->post['settings_httpsfix'])) {
			$this->data['settings_httpsfix'] = $this->request->post['settings_httpsfix'];
		} else {
			$this->data['settings_httpsfix'] = $this->config->get('settings_httpsfix');
		}

		if (isset($this->request->post['settings_httpsfix_admin'])) {
			$this->data['settings_httpsfix_admin'] = $this->request->post['settings_httpsfix_admin'];
		} else {
			$this->data['settings_httpsfix_admin'] = $this->config->get('settings_httpsfix_admin');
		}

		if (SC_VERSION > 21 && !$this->config->get('config_template')) {
			$this->config->set('config_template', $this->config->get('config_theme'));
		}

        $file_theme_settings =  DIR_CATALOG . "view/theme/" . $this->config->get('config_template') . "/template/agootemplates/settings.php";
		if (file_exists($file_theme_settings)) {
        	require($file_theme_settings);
        	if (isset($ascp_settings_settings) && !empty($ascp_settings_settings)) {
	        	foreach ($ascp_settings_settings as $settings_var => $settings_value) {
	        		if (!isset($this->data['settings_httpsfix'][$settings_var])) {
	        			$this->data['settings_httpsfix'][$settings_var] = $settings_value;
	        		}
	        	}
        	}
		}

		$this->load->model('localisation/order_status');
		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

        if (!isset($this->data['settings_httpsfix']['complete_status']) || !is_array($this->data['settings_httpsfix']['complete_status'])) {
           	if (SC_VERSION < 20) {
         		$this->data['settings_httpsfix']['complete_status'] = Array( 0 => $this->config->get('config_complete_status_id'));
         	} else {
         		$this->data['settings_httpsfix']['complete_status'] = $this->config->get('config_complete_status');
         	}
        }

		$this->load->model('tool/image');
		if (isset($this->data['settings_httpsfix']['avatar_default']) && $this->data['settings_httpsfix']['avatar_default']!=''  && file_exists(DIR_IMAGE . $this->data['settings_httpsfix']['avatar_default'])) {
			$this->data['avatar_default'] = $this->model_tool_image->resize($this->data['settings_httpsfix']['avatar_default'], 100, 100);
		} else {
			$this->data['avatar_default'] = $this->model_tool_image->resize($no_image, 100, 100);
		}
		if (!isset($this->data['settings_httpsfix']['ps_ex_js'])) {
			$this->data['settings_httpsfix']['ps_ex_js'] = 'DD_belatedPNG'.PHP_EOL.'yandex.'.PHP_EOL.'vk.'.PHP_EOL.'facebook.';

		}
		if (!isset($this->data['settings_httpsfix']['ps_ex_css'])) {
			$this->data['settings_httpsfix']['ps_ex_css'] = 'bootstrap.min.css';

		}
		if (!isset($this->data['settings_httpsfix']['ps_ex_route'])) {
			$this->data['settings_httpsfix']['ps_ex_route'] = 'checkout';

		}

		if (!isset($this->data['settings_httpsfix']['add_url_type'])) {
			 $this->data['settings_httpsfix']['add_url_type'] =
			 array(
					'1' =>
			 		array( 	'type_id' => '1',
			 				'url' => '<link href="http://',
			 				'url_replace' => '<link href="https://',
			 				'title' => array ( $this->config->get('config_language_id') => '')
			 			 )

			 );
		}
		if (!isset($this->data['settings_httpsfix']['add_ps_js_type']) || empty($this->data['settings_httpsfix']['add_ps_js_type'])) {
			 $this->data['settings_httpsfix']['add_ps_js_type'] =
			 array(
					'1' =>
			 		array( 	'type_id' => '1',
			 				'keyword' => 'yandex.',
			 				'title' => array ( $this->config->get('config_language_id') => 'Yandex JS')
			 			 ),
					'2' =>
			 		array( 	'type_id' => '2',
			 				'keyword' => 'vk.',
			 				'title' => array ( $this->config->get('config_language_id') => 'VKontakte JS')
			 			 ),
					'3' =>
			 		array( 	'type_id' => '3',
			 				'keyword' => 'facebook.',
			 				'title' => array ( $this->config->get('config_language_id') => 'Facebook JS')
			 			 ),
					'4' =>
			 		array( 	'type_id' => '4',
			 				'keyword' => 'DD_belatedPNG',
			 				'title' => array ( $this->config->get('config_language_id') => 'Fix IE PNG')
			 			 )


			 );
		}

		$this->data['no_image'] = $this->model_tool_image->resize($no_image, 100, 100);

		$this->load->model('design/layout');
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

        $directory = '';
		foreach ($this->data['languages'] as $language) {
			if ($this->config->get('config_admin_language') == $language['code']) {
				if (isset($language['directory'])) {
					$directory = $language['directory'];
				} else {
					$directory = $language['code'];
				}
			}
		}

		foreach ($this->data['languages'] as $code => $language) {
			if (!isset($language['image'])) {
            	$this->data['languages'][$code]['image'] = "language/".$code."/".$code.".png";
			} else {
                $this->data['languages'][$code]['image'] = "view/image/flags/".$language['image'];
			}
			if (!file_exists(DIR_APPLICATION.$this->data['languages'][$code]['image'])) {
				$this->data['languages'][$code]['image'] = "view/image/httpsfix/sc_1x1.png";
			}
		}

		$this->data['url_force'] = array(0 => $this->language->get('url_force_0'), 'http' => $this->language->get('url_force_http'), 'https' => $this->language->get('url_force_https') );

		if (!isset($this->data['settings_httpsfix']['httpsfix_force'])) {
			$this->data['settings_httpsfix']['httpsfix_force'] = false;
		}

    	$this->data['url_www'] = array(0 => $this->language->get('url_www_0'), 'www' => $this->language->get('url_www_www'), 'no_www' => $this->language->get('url_www_no_www') );

		if (!isset($this->data['settings_httpsfix']['httpsfix_www'])) {
			$this->data['settings_httpsfix']['httpsfix_www'] = false;
		}

		if (!isset($this->data['settings_httpsfix']['httpsfix_pagespeed_css_first'])) {
			$this->data['settings_httpsfix']['httpsfix_pagespeed_css_first'] = true;
		}
        $main_content = '';

		if (isset($_SERVER['REMOTE_ADDR'])) $ip = $_SERVER['REMOTE_ADDR']; else $ip = '';
		if (isset($_SERVER['HTTP_USER_AGENT'])) $agent = $_SERVER['HTTP_USER_AGENT']; else $agent = '';

		if (((isset($_SERVER['HTTPS']) && (strtolower($_SERVER['HTTPS']) == 'on' || $_SERVER['HTTPS'] == '1')) || (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && (strtolower($_SERVER['HTTP_X_FORWARDED_PROTO']) == 'https') || (!empty($_SERVER['HTTP_X_FORWARDED_SSL']) && strtolower($_SERVER['HTTP_X_FORWARDED_SSL']) == 'on')))) {
         	$server['url'] = rtrim(HTTP_CATALOG, '/');
		} else {
			$server['url'] = rtrim(HTTPS_CATALOG, '/');
		}

		$query = http_build_query(array('httpsfix' => 'true'));

		$server['request']  = 'Content-Type: application/x-www-form-urlencoded\r\n';

		$server['options'] = array( 'http' =>
		array('method' => 'POST',
		'header' => $server['request'],
		'content' => $query));
		$stream_context = stream_context_create($server['options']);
        $exceptionizer = new PHP_Exceptionizer(E_ALL);
	    try {
	    	$main_content = file_get_contents($server['url'], FALSE , $stream_context);
            $this->data['text_redirect'] = true;
	    }  catch (E_WARNING $e) {
 			try {
				$main_content = file_get_contents(HTTPS_CATALOG, FALSE , $stream_context);
				$this->data['text_redirect'] = $this->language->get('text_redirect');
		    }  catch (E_WARNING $e) {
 				try {
	 				if ($curl = curl_init()) {
						curl_setopt($curl, CURLOPT_URL, $server['url']);
						curl_setopt($curl, CURLOPT_RETURNTRANSFER,true);
						$main_content = curl_exec($curl);
						curl_close($curl);
					} else {
						$main_content = '';
						$this->data['text_redirect'] = '';
					}
				}  catch (E_WARNING $e) {
					$main_content = '';
					$this->data['text_redirect'] = '';
				}
		    }
	    }

//		$httpsfix_scripts = "!(<link[^>]+rel\\s*=\\s*(\"stylesheet\"|'stylesheet'|stylesheet)([^>]*)>|<style\\s+type\\s*=\\s*(\"text/css\"|'text/css'|text/css)([^>]*)>(.*?)</style>)!is";
		$httpsfix_scripts = "!(<link[^>]+rel\\s*=\\s*(\"stylesheet\"|'stylesheet'|stylesheet)([^>]*)>)!is";

        preg_match_all($httpsfix_scripts, $main_content, $httpsfix_scripts_all, PREG_SET_ORDER);

		$httpsfix_css_scripts = array();
		$this->data['httpsfix_css_scripts'] = array();

        foreach ($httpsfix_scripts_all as $httpsfix_this_script) {
        	$this->data['httpsfix_css_scripts'][] = htmlentities($httpsfix_this_script[0], ENT_QUOTES, 'UTF-8');
        }

        if (!isset($this->data['settings_httpsfix']['httpsfix_css_scripts'])) {
        	$this->data['settings_httpsfix']['httpsfix_css_scripts'] = array();
        	$this->data['settings_httpsfix']['httpsfix_css_scripts_all'] = $this->data['httpsfix_css_scripts'];
        }


		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->data['registry'] = $this->registry;
		$this->data['config'] 	= $this->config;
		$this->data['language'] = $this->language;

 		$this->template = 'httpsfix/httpsfix';

		if (SC_VERSION > 23) {
	        $this->template_engine = $this->config->get('template_engine');
        }

		if (SC_VERSION < 30) {
			$this->template = $this->template . '.tpl';
		}

		if (SC_VERSION < 20) {
			$this->data['column_left'] = '';
			$html = $this->render();
		} else {

			if (SC_VERSION > 23) {
				$this->config->set('template_engine', $this->template_engine);
	        }
			$this->data['header'] = $this->load->controller('common/header');
			$this->data['footer'] = $this->load->controller('common/footer');
			$this->data['column_left'] = $this->load->controller('common/column_left');

            if (SC_VERSION > 23) {
	            $this->config->set('template_engine', 'template');
	        }
			$html = $this->load->view($this->template, $this->data);
            if (SC_VERSION > 23) {
	            $this->config->set('template_engine', $this->template_engine);
	        }


		}
		$this->response->setOutput($html);

	}




	public function language_get() {
		$this->data['httpsfix_version'] = $this->language->get('httpsfix_version');
        $this->data['httpsfix_version_model'] = $this->language->get('httpsfix_version_model');
		$this->data['heading_title'] = $this->language->get('httpsfix_version_model_html');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['tab_list'] = $this->language->get('tab_list');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_add_url'] = $this->language->get('entry_add_url');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
       	$this->data['text_loading_main'] = $this->language->get('text_loading_main');
        $this->data['url_create_text'] = $this->language->get('url_create_text');
	}


	public function breadcrumbs() {

		$this->data['breadcrumbs'] = array();
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', $this->data['token_name'] . '=' . $this->session->data[$this->data['token_name']], $this->url_link_ssl),
			'separator' => false
		);
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', $this->data['token_name'] . '=' . $this->session->data[$this->data['token_name']], $this->url_link_ssl),
			'separator' => ' :: '
		);
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('httpsfix_version_model'),
			'href' => $this->url->link('module/httpsfix', $this->data['token_name'] . '=' . $this->session->data[$this->data['token_name']], $this->url_link_ssl),
			'separator' => ' / '
		);
	}

	public function vercheck() {

	    if ($this->validate()) {
	   		$this->load->model('setting/setting');
	        $this->cache->delete('httpsfix');

			$this->data['httpsfix_version'] = $this->language->get('httpsfix_version');
	        $this->data['httpsfix_version_model'] = $this->language->get('httpsfix_version_model');

			$this->model_setting_setting->editSetting('httpsfix_server', Array('httpsfix_server_date' => '', 'httpsfix_server_content' => ''));

			$this->model_setting_setting->deleteSetting('httpsfix_version');
	        $this->model_setting_setting->deleteSetting('httpsfix_version_model');

	        $response = $this->server_check();

	        $this->model_setting_setting->editSetting('httpsfix_server', Array('httpsfix_server_date' => date('d-m-Y'), 'httpsfix_server_content' => $response['content']));

	        $html = $server_version = $response['content'];
	        $status = $response['status'];

	        if ($status) {
	        	$html = $this->language->get('text_vercheck_success'). $this->language->get('text_version_server'). $html;
	        	$html.= $this->language->get('text_version_current');
	        	$html.= $this->data['httpsfix_version_model']." ".$this->data['httpsfix_version'];

	        	if (strtolower(preg_replace("/\s{1,}/","",$this->data['httpsfix_version_model']." ".$this->data['httpsfix_version']))  != strtolower(preg_replace("/\s{1,}/","",$server_version))) {
	        		$html.= $this->language->get('text_version_update');
	        	} else {
	        		$html.= $this->language->get('text_version_no_update');
	        	}

	        } else {
	        	$html.= $this->language->get('text_vercheck_fail');
	        }

	    } else {
			$html = $this->language->get('text_no_access');
		}
		$this->response->setOutput($html);
	}


	public function cacheremove() {
		if ($this->validate()) {
			$sc_ver = VERSION;
			if (!defined('SC_VERSION')) define('SC_VERSION', (int)substr(str_replace('.','',$sc_ver), 0,2));
			$status = false;
			$html = '';
			require_once(DIR_SYSTEM . 'library/exceptionizer.php');
	        $exceptionizer = new PHP_Exceptionizer(E_ALL);

            $status = true;

			if (!isset($this->request->get['image'])) {
				$dir_for_clear = DIR_CACHE;
			} else {
				$dir_for_clear = DIR_IMAGE.'cache/';
			}

			if (isset($this->request->get['mod'])) {
				$dir_root = str_ireplace('/system/', '', DIR_SYSTEM);
  				$dir_for_clear = $dir_root.'/vqmod/vqcache/';

  				if (!is_dir($dir_for_clear)) {
  					$html.= $this->language->get('text_cache_remove_fail');
  					$status = false;
  				}
			}
            if ($status) {
		        $files = $this->getDelFiles($dir_for_clear, '*', array('index.html', '.htaccess'));
				if ($files) {
					foreach ($files as $file) {
						if (file_exists($file)) {
						    try {
						    	//$html.=$file."<br>";
								unlink($file);
								$status = true;
						    }  catch (E_WARNING $e) {
		                     	$status = false;
						    }
						}
					}
				}
			}

	        if ($status) {
	        	$html.= $this->language->get('text_cache_remove_success');
	        } else {
	        	$html.= $this->language->get('text_cache_remove_fail');
	        }

		} else {
			$html = $this->language->get('text_no_access');
		}
		$this->response->setOutput($html);
	}

	private function delTree($dir) {
		require_once(DIR_SYSTEM . 'library/exceptionizer.php');
	    $exceptionizer = new PHP_Exceptionizer(E_ALL);
	    try {
			$files = array_diff(scandir($dir), array('.','..'));
			foreach ($files as $file) {
			  (is_dir("$dir/$file")) ? $this->delTree("$dir/$file") : unlink("$dir/$file");
			}
			return rmdir($dir);
			$status = true;
	    }  catch (E_WARNING $e) {
	       	$status = false;
	    }
	}

	private function getDelFiles($dir, $ext = "*", $exp = array()) {
		$files = Array();
		require_once(DIR_SYSTEM . 'library/exceptionizer.php');
        $exceptionizer = new PHP_Exceptionizer(E_ALL);
		try {
		    $handle = opendir($dir);
		    $subfiles = Array();
		    while (false !== ($file = readdir($handle))) {
		      if ($file != '.' && $file != '..') {
		        if (is_dir($dir."/".$file)) {

		          $subfiles = $this->getDelFiles($dir."/".$file, $ext);
	              $this->delTree($dir."/".$file);
		          $files = array_merge($files,$subfiles);
		        } else {
			        $flie_name = $dir."/".$file;
			        $flie_name = str_replace("//", "/",$flie_name);
			        if ((substr($flie_name, strrpos($flie_name, '.')) == $ext) || ($ext == "*")) {
						if (!in_array($file, $exp)) {
							$files[] = $flie_name;
						}
					}
		        }
		      }
		    }
		    closedir($handle);
			$status = true;
		}  catch (E_WARNING $e) {
            $status = false;
		}
	    return $files;
	}

	public function deletesettings() {

        if (!$this->validate()) {
	        $html = $this->language->get('error_permission');
	        $this->response->setOutput($html);
	        return;
        }
      	$this->load->model('setting/setting');
       	$this->model_setting_setting->deleteSetting('settings_httpsfix');
       	$this->model_setting_setting->deleteSetting('httpsfix_module');
		$html = $this->language->get('ok_delete_settings');
		$this->cache->delete('httpsfix');
		$this->response->setOutput($html);
	}

	private function getModId($code) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "modification WHERE code = '" . $this->db->escape($code)."'");
		if ($query->row) {
			return $query->row;
		} else {
			return false;
		}
	}

	public function install_ocmod() {
		if ($this->validate()) {
            $this->language->load('module/httpsfix');
			$html = '';
	        if (SC_VERSION > 23) {
	        	$this->data['token_name'] = 'user_token';
	        } else {
	        	$this->data['token_name'] = 'token';
	        }

	        if ((isset($_SERVER['HTTPS']) && (strtolower($_SERVER['HTTPS']) == 'on' || $_SERVER['HTTPS'] == '1')) || (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && (strtolower($_SERVER['HTTP_X_FORWARDED_PROTO']) == 'https') || (!empty($_SERVER['HTTP_X_FORWARDED_SSL']) && strtolower($_SERVER['HTTP_X_FORWARDED_SSL']) == 'on'))) {
	        	$this->url_link_ssl = true;
	        } else {
	        	if (SC_VERSION < 20) {
	        		$this->url_link_ssl = 'NONSSL';
	        	} else {
	        		$this->url_link_ssl = false;
	        	}
	        }

            $this->cont('httpsfix/httpsfix');

	        if (is_callable(array('Response', 'httpsfix_setRegistry'))) {
	        	$this->response->httpsfix_setRegistry($this->registry);
	        }

			if (file_exists(DIR_APPLICATION . "controller/agooa/seohttpsfixpro/seohttpsfixpro.ocmod.xml")) {

	            if (SC_VERSION > 23) {
	            	$mod_controller = 'marketplace';
	             	$modification_model = 'setting';
	             } else {
	             	$mod_controller = 'extension';
	             	$modification_model = 'extension';
	            }

	            $mod_content = file_get_contents(DIR_APPLICATION . "controller/agooa/seohttpsfixpro/seohttpsfixpro.ocmod.xml");
	            $mod_content = str_replace('{NAME}', 'SEO HTTPS FIX PRO', $mod_content);
	            $mod_content = str_replace('{MOD}', 'seohttpsfixpro', $mod_content);
	            $mod_content = str_replace('{VERSION}', $this->language->get('httpsfix_version') , $mod_content);
	            $mod_content = str_replace('{AUTHOR}', $this->language->get('text_mod_author') , $mod_content);
	            $agoo_widget = 'seohttpsfixpro';

            	if (SC_VERSION > 15) {

	                $mod_mod = $this->getModId($agoo_widget);
	                $mod_id = $mod_mod['modification_id'];

					if (SC_VERSION > 23) {
	                	$mod_ext_id = $mod_mod['extension_install_id'];
	                } else {
	                	$mod_ext_id = false;
	                }

	                $mod_model = 'model_'.$modification_model.'_modification';
	                $this->load->model($modification_model.'/modification');
	                $this->$mod_model->deleteModification($mod_id);

	                if (SC_VERSION > 23) {
	                    $this->load->model('setting/extension');
	                    $this->model_setting_extension->deleteExtensionInstall($mod_ext_id);
	                    $mod_ext_id = $this->model_setting_extension->addExtensionInstall($agoo_widget.'.ocmod.zip');
	                }

	                $mod_data['code'] = $agoo_widget;
	                $mod_data['name'] = $this->language->get('text_widget_'.$agoo_widget);
	                $mod_data['author'] = $this->language->get('text_mod_author');
	                $mod_data['version'] = $this->language->get('widget_'.$agoo_widget.'_version');
	                $mod_data['link'] = $this->language->get('url_opencartadmin');
	                $mod_data['status'] = 1;
	                $mod_data['xml'] = $mod_content;
	                $mod_data['extension_install_id'] = $mod_ext_id;

	                $this->$mod_model->addModification($mod_data);

	                $html.= $this->language->get('text_mod_add');

				//$this->control($mod_controller.'/modification');
	           // Not correct working in 2.1
	           // $this->controller_extension_modification->refresh();

	        		$url_route_refresh = $mod_controller.'/modification/refresh&'.$this->data['token_name'].'=' . $this->session->data[$this->data['token_name']];
	        		$url_ocmod_refresh = $this->url->link($url_route_refresh, '', $this->url_link_ssl);

					$html.= <<<EOF
						<script>
							$.ajax({url: '$url_ocmod_refresh',
										dataType: 'html',
										beforeSend: function() {
										},
										success: function(content) {
											if (content) {
											}
										},
										error: function(content) {
											//alert('Error modifications refresh');
										}
									});
						</script>

EOF;
                } else {
                	if (is_dir(DIR_SYSTEM . "../vqmod/xml")) {
                    	file_put_contents(DIR_SYSTEM . "../vqmod/xml/seohttpsfixpro.ocmod.xml", $mod_content);
                	}

                }

	            $html.= $this->language->get('text_mod_refresh');
			}
	      	$this->response->setOutput($html);
	    }
	}

	public function install() {
	    if ($this->validate()) {
        	$html = '';
	    } else {
			$html = $this->language->get('text_no_access');
		}
		$this->response->setOutput($html);
  	}

	public function uninstall() {
	    if ($this->validate()) {
        	$html = '';
	    } else {
			$html = $this->language->get('text_no_access');
		}
		$this->response->setOutput($html);
	}

	private function validate() {

		if (!$this->user->hasPermission('modify', 'module/httpsfix')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if (!$this->error) {
			return true;
		} else {
			$this->request->post = array();
			return false;
		}
	}

   private function server_check() {
		$sc_ver = VERSION;
		if (!defined('SC_VERSION')) define('SC_VERSION', (int)substr(str_replace('.','',$sc_ver), 0,2));
		require_once(DIR_SYSTEM . 'library/exceptionizer.php');

		$this->load->model('setting/setting');
        $this->model_setting_setting->editSetting('httpsfix_server', Array('httpsfix_server_date' => date('d-m-Y')));
		if (isset($_SERVER['REMOTE_ADDR'])) $ip = $_SERVER['REMOTE_ADDR']; else $ip = '';
		if (isset($_SERVER['HTTP_USER_AGENT'])) $agent = $_SERVER['HTTP_USER_AGENT']; else $agent = '';

        $store_info = $this->model_setting_setting->getSetting('config', 0);
        if (isset($store_info['config_email'])) { $email = $store_info['config_email']; } else { $email = ''; }

		$currnet['version'] = $this->language->get('httpsfix_version');
		$current['model'] = $this->language->get('httpsfix_version_model');
        $current['email'] = $email;
        $current['language'] = $this->config->get('config_language');
        $current['ip'] = $ip;
        $current['date'] = date('d-m-Y');

		if ((isset($_SERVER['HTTPS']) && (strtolower($_SERVER['HTTPS']) == 'on' || $_SERVER['HTTPS'] == '1')) || (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && (strtolower($_SERVER['HTTP_X_FORWARDED_PROTO']) == 'https') || (!empty($_SERVER['HTTP_X_FORWARDED_SSL']) && strtolower($_SERVER['HTTP_X_FORWARDED_SSL']) == 'on')))  {
			$current['server'] = HTTPS_CATALOG;
		} else {
			$current['server'] = HTTP_CATALOG;
		}

        $currnet['opencart'] = VERSION;

		$server['url'] = 'https://opencartadmin.com/index.php?route=record/ver';

		$query = http_build_query(array('catalog' => $current['server'], 'ver' => $currnet['version'], 'model' => $current['model'], 'email' => $current['email'], 'lang' => $current['language'], 'ip' => $current['ip'], 'date' => $current['date'], 'domen' => $current['server'], 'opencart' => $currnet['opencart']));
		$server['request'] = "Content-Type: application/x-www-form-urlencoded\r\n";

		$server['options'] = array( 'http' =>
		array('method' => 'POST',
		'header' => $server['request'],
		'content' => $query));
		$stream_context = stream_context_create($server['options']);
        $exceptionizer = new PHP_Exceptionizer(E_ALL);
	    try {
	    	$response['content'] = file_get_contents($server['url'], FALSE , $stream_context);
            $response['status'] = true;
	    }  catch (E_WARNING $e) {
        	$response['content'] = '';
        	$response['status'] = false;
	    }
	    $response['content']= htmlspecialchars(strip_tags(html_entity_decode($response['content'], ENT_QUOTES, 'UTF-8')), ENT_COMPAT, 'UTF-8');
		return $response;
   }


	public function cont($cont) {
		$file  = DIR_CATALOG . 'controller/' . $cont . '.php';
		if (file_exists($file)) {
           $this->cont_loading($cont, $file);
           return true;
		} else {
			$file  = DIR_APPLICATION . 'controller/' . $cont . '.php';
            if (file_exists($file)) {
             	$this->cont_loading($cont, $file);
            } else {
				trigger_error('Error: Could not load controller ' . $cont . '!');
				exit();
			}
		}
	}

	private function cont_loading ($cont, $file) {
			$class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $cont);
			include_once($file);
			$this->registry->set('controller_' . str_replace('/', '_', $cont), new $class($this->registry));
	}

	public function control($cont) {
		$file = DIR_APPLICATION . 'controller/' . $cont . '.php';
		$class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $cont);
		if (file_exists($file)) {
			include_once($file);
			$this->registry->set('controller_' . str_replace('/', '_', $cont), new $class($this->registry));
		} else {
			trigger_error('Error: Could not load controller ' . $cont . '!');
			exit();
		}
    }

  	public function deletecache($key) {
		$files = glob(DIR_CACHE . preg_replace('/[^A-Z0-9\._-]/i', '', $key) . '.*');

		if ($files) {
    		foreach ($files as $file) {
      			if (file_exists($file)) {
					unlink($file);
				}
    		}
		}
  	}

	private function table_exists($tableName) {
		$found= false;
		$like   = addcslashes($tableName, '%_\\');
		$result = $this->db->query("SHOW TABLES LIKE '" . $this->db->escape($like) . "';");
		$found  = $result->num_rows > 0;
		return $found;
	}

	private function isAva($func) {

		$edom_efas = $this->language->get('text_edom_efas');
		$teg_ini = $this->language->get('text_teg_ini');
		if ($teg_ini($edom_efas))
			return false;
		$disabled = $teg_ini('disable_functions');
		if ($disabled) {
			$disabled = explode(',', $disabled);
			$disabled = array_map('trim', $disabled);
			return !in_array($func, $disabled);
		}
		return true;
	}

	private function dir_permissions($file) {
		error_reporting(0);
		set_error_handler('agoo_error_handler');
		if ($this->isAva('exec')) {
			$files = array(
				$file
			);
			@exec('chmod 7777 ' . implode(' ', $files));
			@exec('chmod 0777 ' . implode(' ', $files));
		}
		@umask(0);
		@chmod($file, 0777);
		restore_error_handler();
		error_reporting(E_ALL);
	}

    public function __call($name, $args) {
        if (function_exists($name)){
            array_unshift($args, $this);
            return call_user_func_array($name, $args);
        }
    }
}

if (!function_exists('agoo_error_handler')) {
	function agoo_error_handler($errno, $errstr){}
}
