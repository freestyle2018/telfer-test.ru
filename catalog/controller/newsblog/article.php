<?php

class ControllerNewsBlogArticle extends Controller {

    private $error = array();

    public function index() {

        $this->document->addStyle('catalog/view/theme/default/stylesheet/ck_newsblog.css');

        $this->load->language('newsblog/article');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );
        
        $data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_main'),
				'href' => $this->url->link('newsblog/main')
	);

        $this->load->model('newsblog/category');

        $category_info = false;
        $settings = false;

        $images_size_articles_big = array($this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
        $images_size_articles_small = array($this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));

        if (isset($this->request->get['newsblog_path'])) {
            $newsblog_path = '';

            $parts = explode('_', (string) $this->request->get['newsblog_path']);

            $category_id = (int) array_pop($parts);

            foreach ($parts as $newsblog_path_id) {

                if (!$newsblog_path) {
                    $newsblog_path = $newsblog_path_id;
                } else {
                    $newsblog_path .= '_' . $newsblog_path_id;
                }

                $category_info = $this->model_newsblog_category->getCategory($newsblog_path_id);

                if ($category_info) {
                    $data['breadcrumbs'][] = array(
                        'text' => $category_info['name'],
                        'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $newsblog_path)
                    );
                }
            }

            // Set the last category breadcrumb
            $category_info = $this->model_newsblog_category->getCategory($category_id);

            if ($category_info) {
                $data['breadcrumbs'][] = array(
                    'text' => $category_info['name'],
                    'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $this->request->get['newsblog_path'])
                );                
            }
        }

        if (isset($this->request->get['newsblog_article_id'])) {
            $newsblog_article_id = (int) $this->request->get['newsblog_article_id'];
        } else {
            $newsblog_article_id = 0;
        }

        $this->load->model('newsblog/article');

        $article_info = $this->model_newsblog_article->getArticle($newsblog_article_id);
        
       
        if ($article_info) {
            $url = '';

            if (isset($this->request->get['newsblog_path'])) {
                $url .= '&newsblog_path=' . $this->request->get['newsblog_path'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            $data['breadcrumbs'][] = array(
                'text' => $article_info['name'],
                'href' => $this->url->link('newsblog/article', $url . '&newsblog_article_id=' . $newsblog_article_id)
            );

            if ($article_info['meta_title']) {
                $this->document->setTitle($article_info['meta_title']);
            } else {
                $this->document->setTitle($article_info['name']);
            }

            $this->document->setDescription($article_info['meta_description']);
            $this->document->setKeywords($article_info['meta_keyword']);
            $mainCategoryId = $this->model_newsblog_article->getArticleMainCategoryId($newsblog_article_id);
            $data['canonical'] = $this->url->link('newsblog/article', 'newsblog_path=' . $mainCategoryId . '&newsblog_article_id=' . $newsblog_article_id);
            $this->document->addLink($data['canonical'], 'canonical');

            $this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
            $this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');

            if ($article_info['meta_h1']) {
                $data['heading_title'] = $article_info['meta_h1'];
            } else {
                $data['heading_title'] = $article_info['name'];
            }

            $data['text_tags'] = $this->language->get('text_tags');
            $data['text_related'] = $this->language->get('text_related');
            $data['text_related_products'] = $this->language->get('text_related_products');
           

            //for related products
            $this->load->language('product/product');
            $data['text_tax'] = $this->language->get('text_tax');
            $data['button_cart'] = $this->language->get('button_cart');
            $data['button_wishlist'] = $this->language->get('button_wishlist');
            $data['button_compare'] = $this->language->get('button_compare');

            $data['article_id'] = $newsblog_article_id;

            $this->load->model('tool/image');

            if ($article_info['image']) {
                $data['original'] = HTTP_SERVER . 'image/' . $article_info['image'];
                $data['popup'] = $this->model_tool_image->resize($article_info['image'], 750, 200);
                $data['thumb'] = $this->model_tool_image->resize($article_info['image'], 750, 250);
            } else {
                $data['original'] = false;
                $data['popup'] = false;
                $data['thumb'] = false;
            }

//			if ($settings && $settings['show_preview'])
            $data['preview'] = html_entity_decode($article_info['preview'], ENT_QUOTES, 'UTF-8');
//			else
//			$data['preview'] = '';

            $data['description'] = html_entity_decode($article_info['description'], ENT_QUOTES, 'UTF-8');

            $data['images'] = array();

            $results = $this->model_newsblog_article->getArticleImages($newsblog_article_id);

            foreach ($results as $result) {
                $data['images'][] = array(
                    'original' => HTTP_SERVER . 'image/' . $result['image'],
                    'popup' => $this->model_tool_image->resize($result['image'], 750, 250),
                    'thumb' => $this->model_tool_image->resize($result['image'], $images_size_articles_small[0], $images_size_articles_small[1])
                );
            }



            $data['href'] = $this->url->link('newsblog/article', 'newsblog_article_id=' . $newsblog_article_id);

            $date_format = $this->language->get('date_format_short');
            if ($settings)
                $date_format = 'd.m.Y';

            $data['date'] = ($date_format ? date($date_format, strtotime($article_info['date_added'])) : false);

            $data['date_modified'] = strtotime($article_info['date_modified']);

            $data['viewed'] = $article_info['viewed'];

            $data['affiliate_id'] = $article_info['affiliate_id'];
            $data['affiliate_firstname'] = $article_info['affiliate_firstname'];
            $data['affiliate_lastname'] = $article_info['affiliate_lastname'];

            $data['articles'] = array();

            $results = $this->model_newsblog_article->getArticleRelated($newsblog_article_id);

            foreach ($results as $result) {

                if ($result['image']) {
                    $original = HTTP_SERVER . 'image/' . $result['image'];
                    $thumb = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
                } else {
                    $original = false;
                    $thumb = false;
                }

                $mainCategoryId = $this->model_newsblog_article->getArticleMainCategoryId($result['article_id']);

                $data['articles'][] = array(
                    'article_id' => $result['article_id'],
                    'original' => $original,
                    'thumb' => $thumb,
                    'name' => $result['name'],
                    'preview' => html_entity_decode($result['preview'], ENT_QUOTES, 'UTF-8'),
                    'href' => $this->url->link('newsblog/article', 'newsblog_path=' . $mainCategoryId . '&newsblog_article_id=' . $result['article_id']),
                    'date' => ($date_format ? date($date_format, strtotime($result['date_added'])) : false),
                    'date_modified' => ($date_format ? date($date_format, strtotime($result['date_modified'])) : false),
                    'viewed' => $result['viewed']
                );
            }


            $data['products'] = array();

            $this->load->model('catalog/product');
            $results = $this->model_newsblog_article->getArticleRelatedProducts($newsblog_article_id);
            
            $tracking = 1;
            
            foreach ($results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
                } else {
                    $image = $this->model_tool_imageimages->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
                }

                if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $price = false;
                }

                if ((float) $result['special']) {
                    $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $special = false;
                }

                if ($this->config->get('config_tax')) {
                    $tax = $this->currency->format((float) $result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
                } else {
                    $tax = false;
                }

                if ($this->config->get('config_review_status')) {
                    $rating = (int) $result['rating'];
                } else {
                    $rating = false;
                }

                $data['products'][] = array(
                    'product_id' => $result['product_id'],
                    'thumb' => $image,
                    'name' => $result['name'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                    'price' => $price,
                    'special' => $special,
                    'tax' => $tax,
                    'minimum' => $result['minimum'] > 0 ? $result['minimum'] : 1,
                    'rating' => $rating,
                    'href' => str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $result['product_id'] . '&tracking=' . $this->model_newsblog_article->getCodeByAffiliate($article_info['affiliate_id'])))
                );
            }

            $data['tags'] = array();

            if ($article_info['tag']) {
                $tags = explode(',', $article_info['tag']);

                foreach ($tags as $tag) {
                    $data['tags'][] = array(
                        'tag' => trim($tag),
                        'href' => $this->url->link('product/search', 'tag=' . trim($tag))
                    );
                }
            }

            $this->model_newsblog_article->updateViewed($this->request->get['newsblog_article_id']);

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            $template_default = 'article.tpl';
            if ($settings && $settings['template_article'])
                $template_default = $settings['template_article'];

            $this->response->setOutput($this->load->view('newsblog/' . $template_default, $data));
        } else {
            $url = '';

            if (isset($this->request->get['newsblog_path'])) {
                $url .= '&newsblog_path=' . $this->request->get['newsblog_path'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_error'),
                'href' => $this->url->link('newsblog/article', $url . '&newsblog_article_id=' . $newsblog_article_id)
            );

            $this->document->setTitle($this->language->get('text_error'));

            $data['heading_title'] = $this->language->get('text_error');

            $data['text_error'] = $this->language->get('text_error');

            $data['button_continue'] = $this->language->get('button_continue');

            $data['continue'] = $this->url->link('common/home');

            $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            $this->response->setOutput($this->load->view('error/not_found.tpl', $data));
        }
    }
}
