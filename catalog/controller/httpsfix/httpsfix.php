<?php
if (!class_exists('ControllerHttpsfixHttpsfix')) {
class ControllerHttpsfixHttpsfix extends Controller {
	protected $data;
	protected $template;
	protected $settings_httpsfix;
	protected $token_name;
	protected $output;
	protected $httpsfix_route;
	protected $is_admin_httpsfix = false;
	protected $is_admin = false;

	public function httpsfix_construct($output) {

		$sc_ver = VERSION; if (!defined('SC_VERSION')) define('SC_VERSION', (int) substr(str_replace('.', '', $sc_ver), 0, 2));

		if ($this->config->get('settings_httpsfix') != '') {
			$this->settings_httpsfix = $this->config->get('settings_httpsfix');
		} else {
			$this->settings_httpsfix = Array();
		}

        $this->output = $output;

        if (SC_VERSION > 23) {
        	$this->token_name = 'user_token';
        } else {
        	$this->token_name = 'token';
        }

        if (isset($this->request->get['route'])) {
        	if ($this->request->get['route'] != '') {
        		$this->httpsfix_route = $this->request->get['route'];
        	} else {
        		$this->httpsfix_route = 'common/home';
        	}
        } else {
			if (!isset($this->request->get['_route_'])) {
            	$this->httpsfix_route = 'common/home';
			}
        }

        if (defined('DIR_CATALOG') && DIR_CATALOG != '') {
        	$this->is_admin = true;
        } else {
        	$this->is_admin = false;
        }

        if (isset($this->request->get['route']) && $this->request->get['route'] == 'module/httpsfix') {
           	$this->is_admin_httpsfix = true;
        } else {
           	$this->is_admin_httpsfix = false;
        }

        return true;
	}

	public function index() {

			if ($this->output && ((isset($this->settings_httpsfix['httpsfix_module_status']) && $this->settings_httpsfix['httpsfix_module_status'])  )) {
                if (!$this->is_admin) {
                    $base_replace = $this->config->get('config_ssl');
	                $http_server_json_httpsfix = str_ireplace('/', '\/', $this->config->get('config_url'));
	                $https_server_json_httpsfix = str_ireplace('/', '\/', $this->config->get('config_ssl'));

	    			if (isset($this->settings_httpsfix['httpsfix_www']) && $this->settings_httpsfix['httpsfix_www'] == 'www') {
	                    $array_scheme_in = array('http:', 'https:');
	                    $array_scheme_out = array('', '');
	    			    $sever_no_scheme = str_ireplace($array_scheme_in, $array_scheme_out, $this->config->get('config_url'));
	    			    $sever_no_scheme_json = str_ireplace($array_scheme_in, $array_scheme_out, $http_server_json_httpsfix);

	                	if (stripos($sever_no_scheme, '//www.') === false) {
	                    	$fix_http_server = str_ireplace('//', '//www.', $sever_no_scheme);
	                    	$this->output = str_ireplace($sever_no_scheme, $fix_http_server, $this->output);
	                	}
	                	// For json
	                	if (stripos($sever_no_scheme_json, '\/\/www.') === false) {
	                    	$fix_http_server = str_ireplace('\/\/', '\/\/www.', $sever_no_scheme_json);
	                    	$this->output = str_ireplace($sever_no_scheme_json, $fix_http_server, $this->output);
	                	}
	    			}

	    			if (isset($this->settings_httpsfix['httpsfix_www']) && $this->settings_httpsfix['httpsfix_www'] == 'no_www') {
	                    $array_scheme_in = array('http://www.', 'https://www.', 'http://', 'https://', 'http:\/\/www.', 'https:\/\/www.', 'http:\/\/', 'https:\/\/');
	                    $array_scheme_out = array('', '', '', '', '', '', '', '');
	    			    $sever_no_scheme = str_ireplace($array_scheme_in, $array_scheme_out, $this->config->get('config_url'));
	                    $sever_no_scheme_json = str_ireplace($array_scheme_in, $array_scheme_out, $http_server_json_httpsfix);

	                    $this->output= str_ireplace('//www.'.$sever_no_scheme, '//'.$sever_no_scheme, $this->output);
	                    $this->output= str_ireplace('\/\/www.'.$sever_no_scheme_json, '\/\/'.$sever_no_scheme_json, $this->output);
	    			}

					if ((!isset($this->settings_httpsfix['httpsfix_sitemap_work']) || !$this->settings_httpsfix['httpsfix_sitemap_work']) && (isset($this->settings_httpsfix['httpsfix_path_status']) && $this->settings_httpsfix['httpsfix_path_status'])) {
			           	$this->output = str_ireplace($this->config->get('config_ssl'), '/', $this->output);
		            	$this->output = str_ireplace($this->config->get('config_url'), '/', $this->output);

			           	$this->output = str_ireplace($https_server_json_httpsfix, '\/', $this->output);
		            	$this->output = str_ireplace($http_server_json_httpsfix, '\/', $this->output);
					} else {
						if ((isset($this->settings_httpsfix['httpsfix_force']) && $this->settings_httpsfix['httpsfix_force'] == 'https' && $this->settings_httpsfix['httpsfix_force'] != 'http') || ((isset($_SERVER['HTTPS']) && (strtolower($_SERVER['HTTPS']) == 'on' || $_SERVER['HTTPS'] == '1')) || (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && (strtolower($_SERVER['HTTP_X_FORWARDED_PROTO']) == 'https') || (!empty($_SERVER['HTTP_X_FORWARDED_SSL']) && strtolower($_SERVER['HTTP_X_FORWARDED_SSL']) == 'on'))) && (isset($this->settings_httpsfix['httpsfix_force']) && $this->settings_httpsfix['httpsfix_force'] != 'http')) {
							$this->output = str_ireplace($this->config->get('config_url'), $this->config->get('config_ssl'), $this->output);
							$this->output = str_ireplace($http_server_json_httpsfix, $https_server_json_httpsfix, $this->output);
							$base_replace = $this->config->get('config_ssl');
						} else {
							$this->output = str_ireplace($this->config->get('config_ssl'), $this->config->get('config_url'), $this->output);
							$this->output = str_ireplace($https_server_json_httpsfix, $http_server_json_httpsfix, $this->output);
							$base_replace = $this->config->get('config_url');

						}
					}

	                $this->output = str_ireplace('<base href=""', '<base href="'.$base_replace.'"', $this->output);
                    $this->output = str_ireplace('<base href="/"', '<base href="'.$base_replace.'"', $this->output);
				    if (isset($this->settings_httpsfix['add_url_type']) && !empty($this->settings_httpsfix['add_url_type'])) {
				    	foreach ($this->settings_httpsfix['add_url_type'] as $num => $value) {
	                    	$this->output = str_ireplace(html_entity_decode($value['url'], ENT_QUOTES, 'UTF-8'), html_entity_decode($value['url_replace'], ENT_QUOTES, 'UTF-8') , $this->output);
				    	}
				    }

				}
            }

			if (isset($this->settings_httpsfix['httpsfix_admin_replace_status']) && $this->is_admin && $this->settings_httpsfix['httpsfix_admin_replace_status']) {
				if (!$this->is_admin_httpsfix) {
					$http_catalog_without_protocol = rtrim(str_ireplace(array('http://','https://', '//') , array('', '', ''), trim(HTTP_CATALOG)), '/');
					$this->output = str_ireplace('http://' . $http_catalog_without_protocol, 'https://' . $http_catalog_without_protocol, $this->output);
					$this->output = str_ireplace('http:\/\/' . $http_catalog_without_protocol, 'https:\/\/' . $http_catalog_without_protocol, $this->output);
				}
			}



			return $this->output;
	}

	public function setOutputRegistry($registry) {
		if (is_callable(array('Response', 'httpsfix_setRegistry'))) {
			$this->response->httpsfix_setRegistry($registry);
		}
		if (is_callable(array('DB', 'httpsfix_setRegistry'))) {
			$this->db->httpsfix_setRegistry($registry);
		}
	}

    public function httpsfix_minify() {

        if (!$this->is_admin) {

			if (isset($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
			} else {
			  	$pos = false;
			  	if (!empty($this->settings_httpsfix['ps_ex_route'])) {
					$ps_ex = explode(PHP_EOL, $this->settings_httpsfix['ps_ex_route']);
					foreach ($ps_ex as $num => $val) {
		            	$pos = stripos(trim($this->httpsfix_route), trim($val));
		                if ($pos !== false) {
		                	$pos = true;
		                	break;
		                }
					}
				}

			   if ($pos === false) {
					if ($this->output && !defined('DIR_CATALOG') && isset($this->settings_httpsfix['httpsfix_module_status']) && $this->settings_httpsfix['httpsfix_module_status']) {
			        	if (isset($this->settings_httpsfix['httpsfix_pagespeed_css_first']) && $this->settings_httpsfix['httpsfix_pagespeed_css_first']) {
							$this->httpsfixEndCSS();
						}
			            $this->httpsfixEndScripts();
			        	if (!isset($this->settings_httpsfix['httpsfix_pagespeed_css_first']) || !$this->settings_httpsfix['httpsfix_pagespeed_css_first']) {
							$this->httpsfixEndCSS();
						}
		  	            $this->httpsfixMiniHTML();
					}
				}
			}
		}
        return $this->output;
    }

	private function httpsfixEndScripts() {
		if ($this->output && isset($this->settings_httpsfix['httpsfix_module_status']) && $this->settings_httpsfix['httpsfix_module_status']) {
	    	if (isset($this->settings_httpsfix['httpsfix_pagespeed_js']) && $this->settings_httpsfix['httpsfix_pagespeed_js']) {

		        $httpsfix_scripts = '/(<script[^>]*>.*?<\/script>)/s';
		        $httpsfix_paste_position = '/<\/body>/';

		        preg_match_all($httpsfix_scripts, $this->output, $httpsfix_scripts_all, PREG_SET_ORDER);

                // http://writing.colin-gourlay.com/safely-using-ready-before-including-jquery/
		        $header_script = '<script>(function(w,d,u){w.readyQ=[];w.bindReadyQ=[];function p(x,y){if(x=="ready"){w.bindReadyQ.push(y);}else{w.readyQ.push(x);}};var a={ready:p,bind:p};w.$=w.jQuery=function(f){if(f===d||f===u){return a}else{p(f)}}})(window,document)</script>';
            	$footer_script = '<script>(function($,d){$.each(readyQ,function(i,f){$(f)});$.each(bindReadyQ,function(i,f){$(d).bind("ready",f)})})(jQuery,document)</script>';

				$this->output = str_ireplace('</head>', $header_script.PHP_EOL.'</head>', $this->output);

 		        $httpsfix_scripts_paste = PHP_EOL;

		        foreach ($httpsfix_scripts_all as $key => $value) {
	                $pos = false;
				    if (!empty($this->settings_httpsfix['ps_ex_js'])) {
				    	$ps_ex = explode(PHP_EOL, $this->settings_httpsfix['ps_ex_js']);
				    	foreach ($ps_ex as $num => $val) {
	                    	$pos = stripos(trim($value[0]), trim($val));
	                        if ($pos !== false) {
	                        	$pos = true;
	                        	break;
	                        }
				    	}
				    }
	                if ($pos === false) {
			            $this->output = str_replace($value[0], '',$this->output);
			            $httpsfix_scripts_paste .= $value[0].PHP_EOL;
		            }
		        }

		        $httpsfix_scripts_paste .= $footer_script . PHP_EOL . '</body>' . PHP_EOL;

		        $this->output = preg_replace($httpsfix_paste_position, $httpsfix_scripts_paste, $this->output);
	    	}
		}
	}

	private function httpsfixEndCSS() {
		if ($this->output && isset($this->settings_httpsfix['httpsfix_module_status']) && $this->settings_httpsfix['httpsfix_module_status']) {
	    	if (isset($this->settings_httpsfix['httpsfix_pagespeed_css']) && $this->settings_httpsfix['httpsfix_pagespeed_css']) {

		        $httpsfix_scripts = "!(<link[^>]+rel\\s*=\\s*(\"stylesheet\"|'stylesheet'|stylesheet)([^>]*)>|<style\\s+type\\s*=\\s*(\"text/css\"|'text/css'|text/css)([^>]*)>(.*?)</style>)!is";
		        $httpsfix_paste_position = '/<\/body>/';

		        preg_match_all($httpsfix_scripts, $this->output, $httpsfix_scripts_all, PREG_SET_ORDER);

 		        $httpsfix_scripts_paste = PHP_EOL;

		        foreach ($httpsfix_scripts_all as $key => $value) {
	                $pos = false;
				    if (!empty($this->settings_httpsfix['ps_ex_css'])) {
				    	$ps_ex = explode(PHP_EOL, $this->settings_httpsfix['ps_ex_css']);
				    	foreach ($ps_ex as $num => $val) {
	                    	$pos = stripos(trim($value[0]), trim($val));

	                        if ($pos !== false) {
	                        	$pos = true;
	                        	break;
	                        }
				    	}
				    }

	                if ($pos === false) {
			            $this->output = str_replace($value[0], '',$this->output);
			            $httpsfix_scripts_paste .= $value[0].PHP_EOL;
		            }
		        }

		        $httpsfix_scripts_paste .= '</body>' . PHP_EOL;
		        $this->output = preg_replace($httpsfix_paste_position, $httpsfix_scripts_paste, $this->output);

	    	}
		}
	}

	private function httpsfixMiniHTML() {
		if ($this->output && isset($this->settings_httpsfix['httpsfix_module_status']) && $this->settings_httpsfix['httpsfix_module_status']) {
	    	if (isset($this->settings_httpsfix['httpsfix_pagespeed_mini']) && $this->settings_httpsfix['httpsfix_pagespeed_mini']) {
	    		$this->output = preg_replace('/(?![^<]*<\/pre>)[\n\r\t]+/', "\n", $this->output);
				$this->output = preg_replace('/ {2,}/', ' ', $this->output);
				$this->output = preg_replace('/>[\n]+/', '>', $this->output);
	    	}
		}
	}



}
}
