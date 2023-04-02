<?php

class ControllerAffiliateArticle extends Controller {

    public function index() {

        if (!$this->affiliate->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('affiliate/account', '', true);

            $this->response->redirect($this->url->link('affiliate/login', '', true));
        }

        $this->language->load('affiliate/article');
        $this->document->setTitle($this->language->get('heading_title'));
        $this->load->model('affiliate/article');

        $this->getList();
    }

    public function add() {
        $this->language->load('affiliate/article');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('affiliate/article');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_affiliate_article->addArticle($this->request->post, $this->affiliate->getId());

            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            $this->response->redirect($this->url->link('affiliate/article', $url, true));
        }

        $this->getForm();
    }

    public function edit() {
        $this->language->load('affiliate/article');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('affiliate/article');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_affiliate_article->editArticle($this->request->get['article_id'], $this->request->post, $this->affiliate->getId());

            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';

            if (isset($this->request->get['filter_name'])) {
                $url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
            }

            if (isset($this->request->get['filter_category'])) {
                $url .= '&filter_category=' . $this->request->get['filter_category'];
            }

            if (isset($this->request->get['filter_status'])) {
                $url .= '&filter_status=' . $this->request->get['filter_status'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            $this->response->redirect($this->url->link('affiliate/article', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getForm();
    }

    protected function getList() {
        $url = '';

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
            $url .= '&page=' . $this->request->get['page'];
        } else {
            $page = 1;
        }

        $affiliate_id = $this->affiliate->getId();

        $this->load->language('affiliate/account');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_account'),
            'href' => $this->url->link('affiliate/article', '', true)
        );

        $this->load->language('affiliate/article');
        $data['add'] = $this->url->link('affiliate/article/add', $url, true);

        $data['articles'] = array();

        $filter_data = array(
            'affiliate_id' => $affiliate_id,
            'start' => ($page - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );

        $article_total = $this->model_affiliate_article->getTotalArticles($filter_data);

        $results = $this->model_affiliate_article->getArticles($filter_data);

        foreach ($results as $result) {
            $data['articles'][] = array(
                'article_id' => $result['article_id'],
                'name' => $result['name'],
                'date_added' => $result['date_available'],
                'date_modified' => $result['date_modified'],
                'status' => ($result['status']) ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
                'edit' => $this->url->link('affiliate/article/edit', '&article_id=' . $result['article_id'] . $url, true)
            );
        }

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_no_results'] = $this->language->get('text_no_results');
        $data['text_confirm'] = $this->language->get('text_confirm');

        $data['column_name'] = $this->language->get('column_name');
        $data['column_category'] = $this->language->get('column_category');
        $data['column_status'] = $this->language->get('column_status');
        $data['column_date_available'] = $this->language->get('column_date_available');
        $data['column_date_modified'] = $this->language->get('column_date_modified');
        $data['column_action'] = $this->language->get('column_action');

        $data['button_add'] = $this->language->get('button_add');
        $data['button_edit'] = $this->language->get('button_edit');
        $data['text_description'] = $this->language->get('text_description');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }

        $pagination = new Pagination();
        $pagination->total = $article_total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_limit_admin');
        $pagination->url = $this->url->link('affiliate/article', $url . '&page={page}', true);

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($article_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($article_total - $this->config->get('config_limit_admin'))) ? $article_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $article_total, ceil($article_total / $this->config->get('config_limit_admin')));

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_my_account'] = $this->language->get('text_my_account');
        $data['text_my_tracking'] = $this->language->get('text_my_tracking');
        $data['text_my_transactions'] = $this->language->get('text_my_transactions');
        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_password'] = $this->language->get('text_password');
        $data['text_payment'] = $this->language->get('text_payment');
        $data['text_tracking'] = $this->language->get('text_tracking');
        $data['text_transaction'] = $this->language->get('text_transaction');
        $data['text_list'] = $this->language->get('text_list');

        $data['edit'] = $this->url->link('affiliate/edit', '', true);
        $data['password'] = $this->url->link('affiliate/password', '', true);
        $data['payment'] = $this->url->link('affiliate/payment', '', true);
        $data['tracking'] = $this->url->link('affiliate/tracking', '', true);
        $data['transaction'] = $this->url->link('affiliate/transaction', '', true);

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('affiliate/article_list.tpl', $data));
    }

    protected function getForm() {
////    //CKEditor
////    if ($this->config->get('config_editor_default')) {
////        $this->document->addScript('view/javascript/ckeditor/ckeditor.js');
////        $this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
////    } else {
//        $this->document->addScript('/catalog/view/javascript/summernote/summernote.js');
//        $this->document->addScript('/catalog/view/javascript/summernote/lang/summernote-' . $this->language->get('lang') . '.js');
//        $this->document->addScript('/catalog/view/javascript/summernote/opencart.js');
//        $this->document->addStyle('/catalog/view/javascript/summernote/summernote.css');
////    }
        $this->document->addScript('view/javascript/auto_translit.js');

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_form'] = !isset($this->request->get['article_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_none'] = $this->language->get('text_none');
        $data['text_default'] = $this->language->get('text_default');

        $data['entry_name_article'] = $this->language->get('entry_name_article');
        $data['entry_preview'] = $this->language->get('entry_preview');
        $data['entry_description'] = $this->language->get('entry_description');
        $data['entry_meta_title'] = $this->language->get('entry_meta_title');
        $data['entry_meta_h1'] = $this->language->get('entry_meta_h1');
        $data['entry_meta_description'] = $this->language->get('entry_meta_description');
        $data['entry_meta_keyword'] = $this->language->get('entry_meta_keyword');
        $data['entry_tag'] = $this->language->get('entry_tag');

        $data['entry_image'] = $this->language->get('entry_image');
        $data['entry_keyword'] = $this->language->get('entry_keyword');

        $data['entry_main_category'] = $this->language->get('entry_main_category');
        $data['entry_category'] = $this->language->get('entry_category');
        $data['text_select_all'] = $this->language->get('text_select_all');
        $data['text_unselect_all'] = $this->language->get('text_unselect_all');
        $data['entry_store'] = $this->language->get('entry_store');
        $data['entry_related'] = $this->language->get('entry_related');
        $data['entry_related_products'] = $this->language->get('entry_related_products');

        $data['entry_text'] = $this->language->get('entry_text');

        $data['help_keyword'] = $this->language->get('help_keyword');
        $data['help_related'] = $this->language->get('help_related');
        $data['help_tag'] = $this->language->get('help_tag');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['button_attribute_add'] = $this->language->get('button_attribute_add');
        $data['button_image_add'] = $this->language->get('button_image_add');
        $data['button_remove'] = $this->language->get('button_remove');

        $data['text_description'] = $this->language->get('text_description');



        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->error['name'])) {
            $data['error_name'] = $this->error['name'];
        } else {
            $data['error_name'] = array();
        }

        if (isset($this->error['keyword'])) {
            $data['error_keyword'] = $this->error['keyword'];
        } else {
            $data['error_keyword'] = '';
        }

        $url = '';

        if (isset($this->request->get['filter_name'])) {
            $url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
        }

        if (isset($this->request->get['filter_category'])) {
            $url .= '&filter_category=' . $this->request->get['filter_category'];
        }

        if (isset($this->request->get['filter_status'])) {
            $url .= '&filter_status=' . $this->request->get['filter_status'];
        }

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        $data['token'] = $this->session->data['token'];

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('newsblog/main', 'token=' . $this->session->data['token'], true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('affiliate/article', 'token=' . $this->session->data['token'] . $url, true)
        );

        if (!isset($this->request->get['article_id'])) {
            $data['action'] = $this->url->link('affiliate/article/add', $url, true);
        } else {
            $data['action'] = $this->url->link('affiliate/article/edit', '&article_id=' . $this->request->get['article_id'] . $url, true);
        }

        $data['cancel'] = $this->url->link('affiliate/article', $url, true);

        if (isset($this->request->get['article_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $article_info = $this->model_affiliate_article->getArticle($this->request->get['article_id']);
        }

        $data['ckeditor'] = $this->config->get('config_editor_default');

        $this->load->model('localisation/language');

        $data['languages'] = $this->model_localisation_language->getLanguages();

        $data['lang'] = $this->language->get('lang');

        if (isset($this->request->post['article_description'])) {
            $data['article_description'] = $this->request->post['article_description'];
        } elseif (isset($this->request->get['article_id'])) {
            $data['article_description'] = $this->model_affiliate_article->getArticleDescriptions($this->request->get['article_id']);
        } else {
            $data['article_description'] = array();
        }

        if (isset($this->request->post['image'])) {
            $data['image'] = $this->request->post['image'];
        } elseif (!empty($article_info)) {
            $data['image'] = $article_info['image'];
        } else {
            $data['image'] = '';
        }

        if (isset($this->request->post['keyword'])) {
            $data['keyword'] = $this->request->post['keyword'];
        } elseif (!empty($article_info)) {
            $data['keyword'] = $article_info['keyword'];
        } else {
            $data['keyword'] = '';
        }

        if (isset($this->request->post['article_related'])) {
            $articles = $this->request->post['article_related'];
        } elseif (isset($this->request->get['article_id'])) {
            $articles = $this->model_affiliate_article->getArticleRelated($this->request->get['article_id']);
        } else {
            $articles = array();
        }

        $data['article_relateds'] = array();

        foreach ($articles as $article_id) {
            $related_info = $this->model_affiliate_article->getArticle($article_id);

            if ($related_info) {
                $data['article_relateds'][] = array(
                    'article_id' => $related_info['article_id'],
                    'name' => $related_info['name']
                );
            }
        }

        if (isset($this->request->post['article_related_products'])) {
            $products = $this->request->post['article_related_products'];
        } elseif (isset($this->request->get['article_id'])) {
            $products = $this->model_affiliate_article->getArticleRelatedProducts($this->request->get['article_id']);
        } else {
            $products = array();
        }

        $data['article_relateds_products'] = array();

        if ($products) {
            $this->load->model('catalog/product');

            foreach ($products as $product_id) {
                $related_info = $this->model_catalog_product->getProduct($product_id);

                if ($related_info) {
                    $data['article_relateds_products'][] = array(
                        'product_id' => $related_info['product_id'],
                        'name' => $related_info['name']
                    );
                }
            }
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('affiliate/article_form.tpl', $data));
    }

    protected function validateForm() {
        // формируем SEO URL из названия статьи
        $this->language->load('affiliate/seotranslit');
        $translit_array = $this->language->get('translit_array');

        foreach ($this->request->post['article_description'] as $value) {
            $name = mb_strtolower($value['name']);
            $translit = strtr($name, $translit_array);
            $translit = preg_replace("/[\-]+/", "-", $translit);

            $this->request->post['keyword'] = $translit;
            break;
        }

        if ($this->error && !isset($this->error['warning'])) {
            $this->error['warning'] = $this->language->get('error_warning');
        }

        return !$this->error;
    }

    public function autocomplete() {
        $json = array();

        if (isset($this->request->get['filter_name'])) {
            $this->load->model('newsblog/article');

            $limit = 5;
            $filter_name = $this->request->get['filter_name'];

            $filter_data = array(
                'filter_name' => $filter_name,
                'start' => 0,
                'limit' => $limit
            );

            $results = $this->model_newsblog_article->getArticles($filter_data);

            foreach ($results as $result) {
                $json[] = array(
                    'article_id' => $result['article_id'],
                    'name' => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
                );
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function autocomplete_products() {
        $json = array();

        if (isset($this->request->get['filter_name'])) {
            $this->load->model('catalog/product');

            $limit = 5;
            $filter_name = $this->request->get['filter_name'];

            $filter_data = array(
                'filter_name' => $filter_name,
                'filter_model' => false,
                'start' => 0,
                'limit' => $limit
            );

            $results = $this->model_catalog_product->getProducts($filter_data);

            foreach ($results as $result) {
                $json[] = array(
                    'product_id' => $result['product_id'],
                    'name' => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
                );
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

}
