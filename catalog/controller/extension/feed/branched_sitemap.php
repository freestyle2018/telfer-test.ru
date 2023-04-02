<?php

/**
 * @category   OpenCart
 * @package    Branched Sitemap
 * @copyright  © Serge Tkach, 2018–2022, http://sergetkach.com/
 */

class ControllerExtensionFeedBranchedSitemap extends Controller {
	private $sitemap;
	private $exist_main_cat;
	private $rn = PHP_EOL;
	private $xml_image_href;
	private $base_url;
	private $page;
	private $limit;
	private $changefreq;
	private $cachetime;

	function __construct($registry) {
		parent::__construct($registry);

		// Prevent dependency for page 404 from sitemap status when friendlyURLWithoutHtaccess() is called
		if (isset($this->session->data['bs_flag']) && $this->session->data['bs_flag']) {
			if (!$this->config->get('branched_sitemap_status')) {
				$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');
				exit;
			}
		}

		// In OpenCart 3 here is language detection by $this->request->get['lang_code']
		// It is not need for OpenCart 2

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->base_url = $this->config->get('config_ssl');
		} else {
			$this->base_url = $this->config->get('config_url');
		}

		$this->page = 1;

		if (isset($this->request->get['page'])) {
			$this->page = $this->request->get['page'];
		}

		// cachetime
		$this->cachetime = $this->config->get('branched_sitemap_cachetime');

		// limit
		$this->limit = $this->config->get('branched_sitemap_limit');

		if (!$this->limit) {
			$this->limit = 1000;
		}

		$this->load->model('extension/feed/branched_sitemap');
		
		$this->exist_main_cat = $this->model_extension_feed_branched_sitemap->existMainCat();

		// if images are included
		if ($this->config->get('branched_sitemap_image_status')) {
			$this->load->model('tool/image');

			$this->xml_image_href = ' xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"';
		}

		if (version_compare(PHP_VERSION, '7.2') >= 0) {
			$php_v = '72_73';
		} elseif (version_compare(PHP_VERSION, '7.1') >= 0) {
			$php_v = '71';
		} elseif (version_compare(PHP_VERSION, '5.6.0') >= 0) {
			$php_v = '56_70';
		} elseif (version_compare(PHP_VERSION, '5.4.0') >= 0) {
			$php_v = '54_56';
		} else {
			echo "Sorry! Version for PHP 5.3 Not Supported!<br>Please contact to author!";
			exit;
		}

		$file = DIR_SYSTEM . 'library/branched_sitemap/branched_sitemap_' . $php_v . '.php';

		if (is_file($file)) {
			require_once $file;
		} else {
			echo "No file '$file'<br>";
			exit;
		}

		// todo...
		// get licence
		$this->sitemap = new Sitemap($this->config->get('branched_sitemap_licence'));

		$this->changefreq = array(
			'category_changefreq_default'			 => 'yearly', // Более 1 года
			'category_changefreq_correlation'	 => array(
				'1'		 => 'daily',
				'7'		 => 'weekly',
				'30'	 => 'monthly',
				'365'	 => 'yearly',
			),
			'product_changefreq_default'			 => 'yearly', // Более 1 года
			'product_changefreq_correlation'	 => array(
				'1'		 => 'daily',
				'7'		 => 'weekly',
				'30'	 => 'monthly',
				'365'	 => 'yearly',
			),
		);
	}

	public function index()	{
		if ($this->config->get('branched_sitemap_sitemapindex_status')) {
      return $this->sitemaindex();
    } else {
      return $this->allInOne();
    }
  }

	private function allInOne()	{
		$output	 = '<?xml version="1.0" encoding="UTF-8"?>' . $this->rn;
		$output	 .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"' . $this->xml_image_href . '>' . $this->rn;
		$output	 .= '<url>';
		$output	 .= '<loc>' . $this->url->link('common/home') . '</loc>';
		$output	 .= '<lastmod>' . date('Y-m-d\TH:i:sP', time()) . '</lastmod>';
//		$output	 .= '<changefreq>daily</changefreq>';
		$output	 .= '<priority>1.0</priority>';
		$output	 .= '</url>';

		$output	 .= $this->getCategoriesAll();
		$output	 .= $this->getProductsAll();
		$output	 .= $this->getManufacturersAll();
		$output	 .= $this->getInformationAll();

		// Blogs . Begin
		if ($this->config->get('branched_sitemap_blogs')) {
			if (array_key_exists('octemplates', $this->config->get('branched_sitemap_blogs'))) {
				$output	 .= $this->getOCTemplatesBlogCategoriesAll();
				$output	 .= $this->getOCTemplatesBlogArticlesAll();
			}
		}
		// Blogs . End

		$output .= '</urlset>' . $this->rn;

		$this->response->addHeader('Content-Type: text/xml; charset=UTF-8');
		$this->response->setOutput($output);
	}

	private function sitemaindex() {
		$output	 = '<?xml version="1.0" encoding="UTF-8"?>' . $this->rn;
		/* $output .= '<?xml-stylesheet type="text/xsl" href="' . $this->base_url. 'catalog/view/theme/default/stylesheet/xml-sitemap.xls"?>' . $this->rn; */
		$output	 .= '<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . $this->rn;

		$output .= '<sitemap>'
			. '<loc>' . $this->branchLink('main') . '</loc>'
			. '</sitemap>';

		$output	 .= $this->getCategoriesIndex();
		$output	 .= $this->getProductsIndex();
		$output	 .= $this->getManufacturersIndex();
		$output	 .= $this->getInformationIndex();

		// Blogs . Begin
		if ($this->config->get('branched_sitemap_blogs')) {
			if (array_key_exists('octemplates', $this->config->get('branched_sitemap_blogs'))) {
				$output	 .= $this->getOCTemplatesBlogCategoriesIndex();
				$output	 .= $this->getOCTemplatesBlogArticlesIndex();
			}
		}
		// Blogs . End

		$output .= '</sitemapindex>' . $this->rn;

		$this->response->addHeader('Content-Type: text/xml; charset=UTF-8');
		$this->response->setOutput($output);
	}

	/* Main
	  --------------------------------------------------------------------------- */

	public function main() {
		$output	 = '<?xml version="1.0" encoding="UTF-8"?>' . $this->rn;
		$output	 .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . $this->rn;
		$output	 .= '<url>';
		$output	 .= '<loc>' . $this->url->link('common/home') . '</loc>';
		$output	 .= '<lastmod>' . date('Y-m-d\TH:i:sP', time()) . '</lastmod>';
//		$output	 .= '<changefreq>daily</changefreq>';
		$output	 .= '<priority>1.0</priority>';
		$output	 .= '</url>';
		$output	 .= '</urlset>' . $this->rn;

		$this->response->addHeader('Content-Type: text/xml; charset=UTF-8');
		$this->response->setOutput($output);
	}

	/* Categories
	  --------------------------------------------------------------------------- */

	public function categories() {
		if (!$this->page) {
			return $this->getCategoriesIndex();
		} else {
			return $this->getCategoriesOnPage();
		}
	}

	private function getCategoriesIndex() {
		$output = '';

		// No Levels - important date modified
		$categories_total = $this->model_extension_feed_branched_sitemap->getTotalCategories();

		$n_pages = ceil($categories_total / $this->limit);

		$i = 1;
		while ($i <= $n_pages) {
			$output	 .= '<sitemap>' . $this->rn;
			$output	 .= '<loc>' . $this->branchLink('categories', $i) . '</loc>' . $this->rn;
			$output	 .= '<lastmod>' . date('Y-m-d\TH:i:sP', time()) . '</lastmod>' . $this->rn;
			$output	 .= '</sitemap>' . $this->rn;
			$i++;
		}

		return $output;
	}

	private function getCategoriesOnPage() {
		$file = DIR_CACHE . 'branched_sitemap_store' . $this->config->get('config_store_id') . '_lang' . $this->config->get('config_language_id') . '_' . 'categories_' . $this->page . '.xml';

		if ($this->cachedFile($file, $this->cachetime)) {
			$this->readFile($file);
			exit;
		}

		$output	 = '<?xml version="1.0" encoding="UTF-8"?>' . $this->rn;
		/* $output .= '<?xml-stylesheet type="text/xsl" href="' . $this->base_url. 'catalog/view/theme/default/stylesheet/xml-sitemap.xls"?>' . $this->rn; */
		$output	 .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . $this->rn;

		$filter_data = array(
			'start'	 => ($this->page - 1) * $this->limit,
			'limit'	 => $this->limit
		);

		// No Levels - important date modified
		$categories = $this->model_extension_feed_branched_sitemap->getCategories($filter_data);

		$output .= $this->categoriesList($categories);

		$output .= '</urlset>' . $this->rn;



		if ($this->cachetime > 0) {
			$this->saveFile($file, $output);
		}

		$this->response->addHeader('Content-Type: text/xml; charset=UTF-8');
		$this->response->setOutput($output);
	}

	private function getCategoriesAll() {
		$file = DIR_CACHE . 'branched_sitemap_store' . $this->config->get('config_store_id') . '_lang' . $this->config->get('config_language_id') . '_' . 'categories_' . 'all' . '.xml';

		if ($this->cachedFile($file, $this->cachetime)) {
			return file_get_contents($file);
		}

		// No Levels - important date modified
		$categories = $this->model_extension_feed_branched_sitemap->getCategories();

		$output = $this->categoriesList($categories);

		if ($this->cachetime > 0) {
			$this->saveFile($file, $output);
		}

		return $output;
	}

	private function categoriesList($categories) {
		$output = '';

		foreach ($categories as $category) {
			$output .= '<url>' . $this->rn;

			//$output .= '<loc>' . $this->url->link('product/category', 'path=' . $category['category_id']) . '</loc>' . $this->rn;
			$output .= '<loc>' . $this->url->link('product/category', 'path=' . $this->model_extension_feed_branched_sitemap->getPathByCategory($category['category_id'])) . '</loc>' . $this->rn;

			if ($category['date_modified'] > '0000-00-00 00:00:00')
				$date		 = $category['date_modified'];
			else
				$date		 = $category['date_added'];
			$output	 .= '<lastmod>' . date('Y-m-d\TH:i:sP', strtotime($date)) . '</lastmod>' . $this->rn;

//			$data = array(
//				'date'									 => $date,
//				'changefreq_correlation' => $this->changefreq['category_changefreq_correlation'],
//				'changefreq_default'		 => $this->changefreq['category_changefreq_default']
//			);
//
//			$output .= '<changefreq>' . $this->sitemap->getCategoryChangefreq($data) . '</changefreq>' . $this->rn;

			$output .= '<priority>' . $this->config->get('branched_sitemap_priority_category_level_1') . '</priority>' . $this->rn;

			$output .= '</url>' . $this->rn;
		}

		return $output;
	}

	/* Products
	  --------------------------------------------------------------------------- */

	public function products() {
		if (!$this->page) {
			return $this->getProductsIndex();
		} else {
			return $this->getProductsOnPage();
		}
	}

	private function getProductsIndex() {
		$output = '';

		$product_total = $this->model_extension_feed_branched_sitemap->getTotalProducts();

		$n_pages = ceil($product_total / $this->limit);

		$i = 1;
		while ($i <= $n_pages) {
			$output	 .= '<sitemap>' . $this->rn;
			$output	 .= '<loc>' . $this->branchLink('products', $i) . '</loc>' . $this->rn;
			$output	 .= '<lastmod>' . date('Y-m-d\TH:i:sP', time()) . '</lastmod>' . $this->rn;
			$output	 .= '</sitemap>' . $this->rn;
			$i++;
		}

		return $output;
	}

	private function getProductsOnPage() {
		$file = DIR_CACHE . 'branched_sitemap_store' . $this->config->get('config_store_id') . '_lang' . $this->config->get('config_language_id') . '_' . 'products_' . $this->page . '.xml';

		if ($this->cachedFile($file, $this->cachetime)) {
			$this->readFile($file);
			exit;
		}

		$output	 = '<?xml version="1.0" encoding="UTF-8"?>' . $this->rn;
		/* $output .= '<?xml-stylesheet type="text/xsl" href="' . $this->base_url. 'catalog/view/theme/default/stylesheet/xml-sitemap.xls"?>' . $this->rn; */
		$output	 .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"' . $this->xml_image_href . '>' . $this->rn;

		$filter_data = array(
			'start'	 => ($this->page - 1) * $this->limit,
			'limit'	 => $this->limit
		);

		$products = $this->model_extension_feed_branched_sitemap->getProducts($filter_data);

		$output .= $this->productsList($products);

		$output .= '</urlset>' . $this->rn;

		if ($this->cachetime > 0) {
			$this->saveFile($file, $output);
		}

		$this->response->addHeader('Content-Type: text/xml; charset=UTF-8');
		$this->response->setOutput($output);
	}

	private function getProductsAll() {
		$file = DIR_CACHE . 'branched_sitemap_store' . $this->config->get('config_store_id') . '_lang' . $this->config->get('config_language_id') . '_' . 'products_' . 'all' . '.xml';

		if ($this->cachedFile($file, $this->cachetime)) {
			return file_get_contents($file);
		}

		$products = $this->model_extension_feed_branched_sitemap->getProducts();

		$output = $this->productsList($products);

		if ($this->cachetime > 0) {
			$this->saveFile($file, $output);
		}

		return $output;
	}

	private function productsList($products) {
		$output = '';

		foreach ($products as $product) {
			$output .= '<url>' . $this->rn;

			if ($this->exist_main_cat) {
				$output .= '<loc>' . $this->url->link('product/product', 'path=' . $this->model_extension_feed_branched_sitemap->getPathByProduct($product['product_id']) . '&product_id=' . $product['product_id']) . '</loc>' . $this->rn;
			} else {
				$output .= '<loc>' . $this->url->link('product/product', 'product_id=' . $product['product_id']) . '</loc>' . $this->rn;
			}

			if ($product['date_modified'] > '0000-00-00 00:00:00')
				$date		 = $product['date_modified'];
			else
				$date		 = $product['date_added'];
			$output	 .= '<lastmod>' . date('Y-m-d\TH:i:sP', strtotime($date)) . '</lastmod>' . $this->rn;

//			$data = array(
//				'date'									 => $date,
//				'changefreq_correlation' => $this->changefreq['product_changefreq_correlation'],
//				'changefreq_default'		 => $this->changefreq['product_changefreq_default']
//			);
//
//			$output .= '<changefreq>' . $this->sitemap->getProductChangefreq($data) . '</changefreq>' . $this->rn;

			$output .= '<priority>' . $this->config->get('branched_sitemap_priority_product') . '</priority>' . $this->rn;

			// image
			if ($this->config->get('branched_sitemap_image_status')) {
				if ($product['image']) {
					$image_info = pathinfo($product['image']);

					// Sometimes can be 'undefined' ... - bug of filemanager or...
					if (isset($image_info['extension'])) {
						// Image Config is defferent for 2.1 (2.2), for 2.3 & for 3.0.2 !!
						// A! WebP
						if ($this->config->get('branched_sitemap_webp_status')) {
							$image_info['extension'] = 'webp';
						}

						// Image Resize create hight load - so we can avoid it
						if ($this->config->get('branched_sitemap_off_check_image_file')) {
							$image = $image_info['dirname'] . '/' . $image_info['filename'] . '-' . $this->config->get($this->config->get('config_theme') . '_image_popup_width') . 'x' . $this->config->get($this->config->get('config_theme') . '_image_popup_height') . '.' . $image_info['extension'];

							$image = HTTPS_SERVER . 'image/cache/' . $image;

							if (!is_file(DIR_IMAGE . 'cache/' . $image)) {
								// Report :)
								$this->log->write('Branched Sitemap :: Image "' . $image . '" not exists on page ' . $this->url->link('product/product', '&product_id=' . $product['product_id']));
							}
						} else {
							$image = $this->model_tool_image->resize($product['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
						}
					}

					if ($image) {
						$output	 .= '<image:image>' . $this->rn;
						$output	 .= '<image:loc>' . $image . '</image:loc>' . $this->rn;
						if ($this->config->get('branched_sitemap_require_image_caption') && $product['name']) {
							$output	 .= '<image:caption>' . $this->cleanup($product['name']) . '</image:caption>' . $this->rn;
							$output	 .= '<image:title>' . $this->cleanup($product['name']) . '</image:title>' . $this->rn;
						}
						$output .= '</image:image>' . $this->rn;
					}
				}
			}

			$output .= '</url>' . $this->rn;
		}

		return $output;
	}

	/* Manufacturers
	  --------------------------------------------------------------------------- */

	public function manufacturers() {
		if (!$this->page) {
			return $this->getManufacturersIndex();
		} else {
			return $this->getManufacturersOnPage();
		}
	}

	private function getManufacturersIndex() {
		$output = '';

		$manufacturers_total = $this->model_extension_feed_branched_sitemap->getTotalManufacturers();

		$n_pages = ceil($manufacturers_total / $this->limit);

		$i = 1;
		while ($i <= $n_pages) {
			$output	 .= '<sitemap>' . $this->rn;
			$output	 .= '<loc>' . $this->branchLink('manufacturers', $i) . '</loc>' . $this->rn;
			$output	 .= '<lastmod>' . date('Y-m-d\TH:i:sP', time()) . '</lastmod>' . $this->rn;
			$output	 .= '</sitemap>' . $this->rn;
			$i++;
		}

		return $output;
	}

	private function getManufacturersOnPage()	{
		$file = DIR_CACHE . 'branched_sitemap_store' . $this->config->get('config_store_id') . '_lang' . $this->config->get('config_language_id') . '_' . 'manufacturers_' . $this->page . '.xml';

		if ($this->cachedFile($file, $this->cachetime)) {
			$this->readFile($file);
			exit;
		}

		$output	 = '<?xml version="1.0" encoding="UTF-8"?>' . $this->rn;
		/* $output .= '<?xml-stylesheet type="text/xsl" href="' . $this->base_url. 'catalog/view/theme/default/stylesheet/xml-sitemap-manufacturers.xls"?>' . $this->rn; */
		$output	 .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . $this->rn;

		$filter_data = array(
			'start'	 => ($this->page - 1) * $this->limit,
			'limit'	 => $this->limit
		);

		$manufacturers = $this->model_extension_feed_branched_sitemap->getManufacturers($filter_data);

		$output .= $this->manufacturersList($manufacturers);

		$output .= '</urlset>' . $this->rn;

		if ($this->cachetime > 0) {
			$this->saveFile($file, $output);
		}

		$this->response->addHeader('Content-Type: text/xml; charset=UTF-8');
		$this->response->setOutput($output);
	}

	private function getManufacturersAll() {
		$file = DIR_CACHE . 'branched_sitemap_store' . $this->config->get('config_store_id') . '_lang' . $this->config->get('config_language_id') . '_' . 'manufacturers_' . $this->page . '.xml';

		if ($this->cachedFile($file, $this->cachetime)) {
			return file_get_contents($file);
		}

		$manufacturers = $this->model_extension_feed_branched_sitemap->getManufacturers();

		$output = $this->manufacturersList($manufacturers);

		if ($this->cachetime > 0) {
			$this->saveFile($file, $output);
		}

		return $output;
	}

	private function manufacturersList($manufacturers) {
		$output = '';

		foreach ($manufacturers as $manufacturer) {
			$output	 .= '<url>' . $this->rn;
			$output	 .= '<loc>' . $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer['manufacturer_id']) . '</loc>' . $this->rn;
			$output	 .= '<priority>' . $this->config->get('branched_sitemap_priority_manufacturer') . '</priority>' . $this->rn;
			$output	 .= '</url>' . $this->rn;
		}

		return $output;
	}

	/* Information
	  --------------------------------------------------------------------------- */

	public function information() {
		if (!$this->page) {
			return $this->getInformationIndex();
		} else {
			return $this->getInformationOnPage();
		}
	}

	private function getInformationIndex() {
		$output = '';

		$information_total = $this->model_extension_feed_branched_sitemap->getTotalInformation();

		$n_pages = ceil($information_total / $this->limit);

		$i = 1;
		while ($i <= $n_pages) {
			$output	 .= '<sitemap>' . $this->rn;
			$output	 .= '<loc>' . $this->branchLink('information', $i) . '</loc>' . $this->rn;
			$output	 .= '<lastmod>' . date('Y-m-d\TH:i:sP', time()) . '</lastmod>' . $this->rn;
			$output	 .= '</sitemap>' . $this->rn;
			$i++;
		}

		return $output;
	}

	private function getInformationOnPage() {
		$file = DIR_CACHE . 'branched_sitemap_store' . $this->config->get('config_store_id') . '_lang' . $this->config->get('config_language_id') . '_' . 'information_' . $this->page . '.xml';

		if ($this->cachedFile($file, $this->cachetime)) {
			$this->readFile($file);
			exit;
		}

		$output	 = '<?xml version="1.0" encoding="UTF-8"?>' . $this->rn;
		/* $output .= '<?xml-stylesheet type="text/xsl" href="' . $this->base_url. 'catalog/view/theme/default/stylesheet/xml-sitemap-information.xls"?>' . $this->rn; */
		$output	 .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . $this->rn;

		$filter_data = array(
			'start'	 => ($this->page - 1) * $this->limit,
			'limit'	 => $this->limit
		);

		$informations = $this->model_extension_feed_branched_sitemap->getInformation($filter_data);

		$output .= $this->informationList($informations);

		$output .= '</urlset>' . $this->rn;

		if ($this->cachetime > 0) {
			$this->saveFile($file, $output);
		}

		$this->response->addHeader('Content-Type: text/xml; charset=UTF-8');
		$this->response->setOutput($output);
	}

	private function getInformationAll() {
		$file = DIR_CACHE . 'branched_sitemap_store' . $this->config->get('config_store_id') . '_lang' . $this->config->get('config_language_id') . '_' . 'information_' . 'all' . '.xml';

		if ($this->cachedFile($file, $this->cachetime)) {
			return file_get_contents($file);
		}

		$informations = $this->model_extension_feed_branched_sitemap->getInformation();

		$output = $this->informationList($informations);

		if ($this->cachetime > 0) {
			$this->saveFile($file, $output);
		}

		return $output;
	}

	private function informationList($informations) {
		$output = '';

		foreach ($informations as $information) {
			$output	 .= '<url>' . $this->rn;
			$output	 .= '<loc>' . $this->url->link('information/information', 'information_id=' . $information['information_id']) . '</loc>' . $this->rn;
			$output	 .= '<priority>' . $this->config->get('branched_sitemap_priority_other') . '</priority>' . $this->rn;
			$output	 .= '</url>' . $this->rn;
		}

		return $output;
	}

	public function cleanup($str) {
		//htmlentities($product['name'], ENT_QUOTES, "UTF-8"); // &laquo; - not valid char - see protocol...
		return str_replace(array('&', '\'', '"', '>', '<'), array('&amp;', '&apos;', '&quot;', '&gt;', '&lt;'), $str);
	}

	/* Blogs . Begin
	  --------------------------------------------------------------------------- */

	// OCTemplatesBlogCategories
	public function OCTemplatesBlogCategories() {
		if (!$this->page) {
			return $this->getOCTemplatesBlogCategoriesIndex();
		} else {
			return $this->getOCTemplatesBlogCategoriesOnPage();
		}
	}

	public function getOCTemplatesBlogCategoriesIndex() {
		$output = '';

		$total = $this->model_extension_feed_branched_sitemap->getTotalOCTemplatesBlogCategories();

		$n_pages = ceil($total / $this->limit);

		$i = 1;
		while ($i <= $n_pages) {
			$output	 .= '<sitemap>' . $this->rn;
			$output	 .= '<loc>' . $this->branchLink('OCTemplatesBlogCategories', $i) . '</loc>' . $this->rn;
			$output	 .= '<lastmod>' . date('Y-m-d\TH:i:sP', time()) . '</lastmod>' . $this->rn;
			$output	 .= '</sitemap>' . $this->rn;
			$i++;
		}

		return $output;
	}

	public function getOCTemplatesBlogCategoriesOnPage() {
		$file = DIR_CACHE . 'branched_sitemap_store' . $this->config->get('config_store_id') . '_lang' . $this->config->get('config_language_id') . '_' . 'OCTemplatesBlogCategories_' . $this->page . '.xml';

		if ($this->cachedFile($file, $this->cachetime)) {
			$this->readFile($file);
			exit;
		}

		$output	 = '<?xml version="1.0" encoding="UTF-8"?>' . $this->rn;
		/* $output .= '<?xml-stylesheet type="text/xsl" href="' . $this->base_url. 'catalog/view/theme/default/stylesheet/xml-sitemap.xls"?>' . $this->rn; */
		$output	 .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . $this->rn;

		$filter_data = array(
			'start'	 => ($this->page - 1) * $this->limit,
			'limit'	 => $this->limit
		);

		// No Levels - important date modified
		$categories = $this->model_extension_feed_branched_sitemap->getOCTemplatesBlogCategories($filter_data);

		$output = $this->OCTemplatesBlogCategoriesList($categories);

		if ($this->cachetime > 0) {
			$this->saveFile($file, $output);
		}

		$this->response->addHeader('Content-Type: text/xml; charset=UTF-8');
		$this->response->setOutput($output);
	}

	public function getOCTemplatesBlogCategoriesAll()	{
		$file = DIR_CACHE . 'branched_sitemap_store' . $this->config->get('config_store_id') . '_lang' . $this->config->get('config_language_id') . '_' . 'OCTemplatesBlogCategories_' . 'all' . '.xml';

		if ($this->cachedFile($file, $this->cachetime)) {
			return file_get_contents($file);
		}
		// No Levels - important date modified
		$categories = $this->model_extension_feed_branched_sitemap->getOCTemplatesBlogCategories();

		$output .= $this->OCTemplatesBlogCategoriesList($categories);

		$output .= '</urlset>' . $this->rn;

		if ($this->cachetime > 0) {
			$this->saveFile($file, $output);
		}

		return $output;
	}

	private function OCTemplatesBlogCategoriesList($categories)	{
		$output = '';

		foreach ($categories as $category) {
			$output .= '<url>' . $this->rn;

			// todo...
			//$output .= '<loc>' . $this->url->link('octemplates/blog/oct_blogcategory', 'blog_path=' . $this->model_extension_feed_branched_sitemap->getOCTemplatesBlogPathByCategory($category['blogcategory_id'])) . '</loc>' . $this->rn;
			$output .= '<loc>' . $this->url->link('octemplates/blog/oct_blogcategory', 'blog_path=' . $category['blogcategory_id']) . '</loc>' . $this->rn;

			if ($category['date_modified'] > '0000-00-00 00:00:00')
				$date	 = $category['date_modified'];
			else
				$date	 = $category['date_added'];

			$output .= '<lastmod>' . date('Y-m-d\TH:i:sP', strtotime($date)) . '</lastmod>' . $this->rn;

//			$output .= '<changefreq>monthly</changefreq>' . $this->rn;

			$output .= '<priority>' . $this->config->get('branched_sitemap_priority_blog') . '</priority>' . $this->rn;

			$output .= '</url>' . $this->rn;
		}

		return $output;
	}

	// OCTemplatesBlogArticles
	public function OCTemplatesBlogArticles() {
		if (!$this->page) {
			return $this->getOCTemplatesBlogArticlesIndex();
		} else {
			return $this->getOCTemplatesBlogArticlesOnPage();
		}
	}

	public function getOCTemplatesBlogArticlesIndex() {
		$output = '';

		$total = $this->model_extension_feed_branched_sitemap->getTotalOCTemplatesBlogArticles();

		$n_pages = ceil($total / $this->limit);

		$i = 1;
		while ($i <= $n_pages) {
			$output	 .= '<sitemap>' . $this->rn;
			$output	 .= '<loc>' . $this->branchLink('OCTemplatesBlogArticles', $i) . '</loc>' . $this->rn;
			$output	 .= '<lastmod>' . date('Y-m-d\TH:i:sP', time()) . '</lastmod>' . $this->rn;
			$output	 .= '</sitemap>' . $this->rn;
			$i++;
		}

		return $output;
	}

	public function getOCTemplatesBlogArticlesOnPage() {
		$file = DIR_CACHE . 'branched_sitemap_store' . $this->config->get('config_store_id') . '_lang' . $this->config->get('config_language_id') . '_' . 'OCTemplatesBlogArticles_' . $this->page . '.xml';

		if ($this->cachedFile($file, $this->cachetime)) {
			$this->readFile($file);
			exit;
		}

		$output	 = '<?xml version="1.0" encoding="UTF-8"?>' . $this->rn;
		/* $output .= '<?xml-stylesheet type="text/xsl" href="' . $this->base_url. 'catalog/view/theme/default/stylesheet/xml-sitemap-information.xls"?>' . $this->rn; */
		$output	 .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . $this->rn;

		$filter_data = array(
			'start'	 => ($this->page - 1) * $this->limit,
			'limit'	 => $this->limit
		);

		$articles = $this->model_extension_feed_branched_sitemap->getOCTemplatesBlogArticles($filter_data);

		$output .= $this->OCTemplatesBlogArticlesList($articles);

		$output .= '</urlset>' . $this->rn;

		if ($this->cachetime > 0) {
			$this->saveFile($file, $output);
		}

		$this->response->addHeader('Content-Type: text/xml; charset=UTF-8');
		$this->response->setOutput($output);
	}

	public function getOCTemplatesBlogArticlesAll() {
		$file = DIR_CACHE . 'branched_sitemap_store' . $this->config->get('config_store_id') . '_lang' . $this->config->get('config_language_id') . '_' . 'OCTemplatesBlogArticles_' . 'all' . '.xml';

		if ($this->cachedFile($file, $this->cachetime)) {
			return file_get_contents($file);
		}

		$articles = $this->model_extension_feed_branched_sitemap->getOCTemplatesBlogArticles();

		$output .= $this->OCTemplatesBlogArticlesList($articles);

		if ($this->cachetime > 0) {
			$this->saveFile($file, $output);
		}

		return $output;
	}

	private function OCTemplatesBlogArticlesList($articles) {
		$output = '';

		foreach ($articles as $article) {
			$blog_path = $this->model_extension_feed_branched_sitemap->getOCTemplatesBlogPathByArticle($article['blogarticle_id']);

			$output .= '<url>' . $this->rn;
			//'href'			        => $this->url->link('octemplates/blog/oct_blogarticle', 'blog_path=' . $this->request->get['blog_path'] . '&blogarticle_id=' . $result['blogarticle_id'] . $url)

			$output	 .= '<loc>' . $this->url->link('octemplates/blog/oct_blogarticle', 'blog_path=' . $blog_path . '&blogarticle_id=' . $article['blogarticle_id']) . '</loc>' . $this->rn;
			if ($article['date_modified'] > '0000-00-00 00:00:00')
				$date		 = $article['date_modified'];
			else
				$date		 = $article['date_added'];

			$output .= '<lastmod>' . date('Y-m-d\TH:i:sP', strtotime($date)) . '</lastmod>' . $this->rn;

			$output	 .= '<priority>' . $this->config->get('branched_sitemap_priority_blog') . '</priority>' . $this->rn;
			$output	 .= '</url>' . $this->rn;
		}

		return $output;
	}

	// ocStore 3 Default Blog
	// ... not for 2


	/* Blogs . End
	  --------------------------------------------------------------------------- */



	/* Helpers
	  --------------------------------------------------------------------------- */

	public function cachedFile($file, $cachetime) {
		if ('0' == $cachetime)
			return false;

		if (!is_file($file))
			return false;

		if (time() - filemtime($file) > $cachetime) {
			unlink($file);
			return false;
		}

		clearstatcache(true, $file);

		if (@filesize($file) > 0) {
			return true;
		}

		return false;
	}

	public function saveFile($file, $data) {
		$res = @file_put_contents($file, $data);

		if (false !== $res) {
			return true;
		} else {
			return false;
		}
	}

	public function readFile($file) {
		header('Content-Type: text/xml; charset=UTF-8');
		readfile($file);
	}
	
	// ocStore 3 only
	// for ocdev.pro - multilang compatibility
	// ... getLanguageIdByCode()

	public function branchLink($essence, $page = 1) {
		$branched_sitemap_url_base = str_replace('.xml', '', $this->config->get('branched_sitemap_url'));

		$server = $this->request->server['HTTPS'] ? $this->config->get('config_ssl') : $this->config->get('config_url');

		$lang_flags	 = $this->config->get('branched_sitemap_lang_flags');
		$lang_flag	 = $lang_flags[$this->config->get('config_language_id')];

		if ($lang_flag)
			$lang_flag .= '/';

		$add_page = ($page > 1) ? '-' . $page : '';

		return $server . $lang_flag . $branched_sitemap_url_base . '/' . $essence . $add_page . '.xml';
	}
	
	// Ex
	// http://oc-store-3020-test.loc/branched-sitemap.xml
	// http://oc-store-3020-test.loc/branched-sitemap/categories.xml
	// http://oc-store-3020-test.loc/branched-sitemap/categories-1.xml
	// http://oc-store-3020-test.loc/en/branched-sitemap.xml
	// http://oc-store-3020-test.loc/en/branched-sitemap/categories.xml
	// http://oc-store-3020-test.loc/en/branched-sitemap/categories-1.xml

	public function friendlyURLWithoutHtaccess() {
		if (!$this->config->get('branched_sitemap_url')) {
			return;
		}

		$branched_sitemap_url_base = str_replace('.xml', '', $this->config->get('branched_sitemap_url'));

		// $this->request->get['_route_'] - в тройке есть при $this->request->get['route'] == 'error/not_found'
		// а в двойке его нету. Поэтому работаю с $this->request->server['REQUEST_URI']
		if (false !== strpos($this->request->server['REQUEST_URI'], $branched_sitemap_url_base)) {
			$uri = ltrim($this->request->server['REQUEST_URI'], '/');
			
			$lang_flags = $this->config->get('branched_sitemap_lang_flags');

			// Default language
			$language_flag	 = '';
			$url_language_id = $this->config->get('config_language_id');

			if (false !== strpos($uri, '/')) {
				$parts1 = explode('/', $uri);

				// Lang code is present in URL
				if (in_array($parts1[0], $lang_flags)) {
					foreach ($lang_flags as $id => $flag) {
						if ($parts1[0] == $flag) {
							$url_language_id = $id;
							$language_flag	 = $flag;

							// Var 2: Define language
							$this->config->set('config_language_id', $url_language_id);
						}
					}
				}
			}

			$url = str_replace([
				$language_flag . '/',
				$branched_sitemap_url_base, // http://oc-store-3020-test.loc/branched-sitemap.xml
				'/', // http://oc-store-3020-test.loc/branched-sitemap/categories.xml
				'.xml',
				],
				'',
				$uri);

			$parts = explode('-', $url);

			$action = '';
			if (null !== $parts[0] && $parts[0]) {
				$action = '/' . $parts[0];
			}

			// Prevent opening page with $branched_sitemap_url_base
			if ('' == $action) {
				if (false === strpos($uri, $this->config->get('branched_sitemap_url'))) {
					return;
				}
			}

			if (isset($parts[1])) {
				$this->request->get['page'] = $parts[1];
			}
			
			$this->session->data['bs_flag'] = true;

			$this->load->controller('extension/feed/branched_sitemap' . $action);
			$this->response->output();
			exit;
		}
	}

}
