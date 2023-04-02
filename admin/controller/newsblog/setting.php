<?php

class ControllerNewsblogSetting extends Controller {

    private $error = array();

    public function index() {
        $this->load->language('newsblog/setting'); 

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('newsblog/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_newsblog_setting->editSetting('newsblog', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('newsblog/setting', 'token=' . $this->session->data['token'] . '&type=module', true));
        }
  
        $data['heading_title'] = $this->language->get('heading_title');
        $data['heading_turbo'] = $this->language->get('heading_turbo');          

        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_yes'] = $this->language->get('text_yes');
        $data['text_no'] = $this->language->get('text_no');
        $data['text_none'] = $this->language->get('text_none');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');

        $data['tab_yandex_turbo'] = $this->language->get('tab_yandex_turbo');
        $data['tab_about'] = $this->language->get('tab_about');
        $data['tab_general'] = $this->language->get('tab_general');

        $data['entry_main_news'] = $this->language->get('entry_main_news');
        $data['entry_status'] = $this->language->get('entry_status');
        $data['entry_yandex_category'] = $this->language->get('entry_yandex_category');
        $data['entry_category'] = $this->language->get('entry_category');
        $data['entry_data_feed'] = $this->language->get('entry_data_feed');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['button_category_add'] = $this->language->get('button_category_add');

        $data['token'] = $this->session->data['token'];

        $data['data_feed'] = HTTP_CATALOG . 'index.php?route=newsblog/yandex_turbo';


        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_extension'),
            'href' => $this->url->link('newsblog/setting', 'token=' . $this->session->data['token'] . '&type=module', true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('newsblog/setting', 'token=' . $this->session->data['token'], true)
        );

        $data['action'] = $this->url->link('newsblog/setting', 'token=' . $this->session->data['token'], true);

        $data['cancel'] = $this->url->link('newsblog/setting', 'token=' . $this->session->data['token'] . '&type=module', true);


//		if (isset($this->request->post['newsblog_status'])) {
//			$data['newsblog_status'] = $this->request->post['newsblog_status'];
//		} else {
//			$data['newsblog_status'] = $this->config->get('newsblog_status');
//		}

        if (isset($this->request->post['main_news_id'])) {
            $data['main_news_id'] = $this->request->post['main_news_id'];
        } else {
            $data['main_news_id'] = $this->model_newsblog_setting->getSetting('main_news_id');
        }
        
        if (isset($this->request->post['yandex_turbo_status'])) {
            $data['yandex_turbo_status'] = $this->request->post['yandex_turbo_status'];
        } else {
            $data['yandex_turbo_status'] = $this->model_newsblog_setting->getSetting('yandex_turbo_status');
        }
                 
        $this->load->model('newsblog/article');
        $data['news'] = $this->model_newsblog_article->getArticles();        

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('newsblog/setting', $data));
    }

    public function category() {
        $this->load->language('newsblog/setting');

        $data['text_no_results'] = $this->language->get('text_no_results');
        $data['text_loading'] = $this->language->get('text_loading');

        $data['column_category'] = $this->language->get('column_category');
        $data['column_action'] = $this->language->get('column_action');

        $data['button_remove'] = $this->language->get('button_remove');

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $data['yandex_turbo_categories'] = array();

        $filter_data = array(
            'start' => ($page - 1) * 10,
            'limit' => 10
        );

        $this->load->model('newsblog/setting');


        $results = $this->model_newsblog_setting->getCategories($filter_data);

        foreach ($results as $result) {
            $data['yandex_turbo_categories'][] = array(
                'category_id' => $result['category_id'],
                'category' => $result['category']
            );
        }

        $category_total = $this->model_newsblog_setting->getTotalCategories();

        $pagination = new Pagination();
        $pagination->total = $category_total;
        $pagination->page = $page;
        $pagination->limit = 10;
        $pagination->url = $this->url->link('newsblog/setting/category', 'token=' . $this->session->data['token'] . '&page={page}', true);

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($category_total) ? (($page - 1) * 10) + 1 : 0, ((($page - 1) * 10) > ($category_total - 10)) ? $category_total : ((($page - 1) * 10) + 10), $category_total, ceil($category_total / 10));

        $this->response->setOutput($this->load->view('newsblog/yandex_turbo_category', $data));
    }

    //добавление яндекс турбо категории
    public function addCategory() {
        $this->load->language('newsblog/setting');

        $json = array();
//
//        if (!$this->user->hasPermission('modify', 'newsblog/setting')) {
//            $json['error'] = $this->language->get('error_permission');
//        } elseif (!empty($this->request->post['category_id'])) {
            $this->load->model('newsblog/setting');

            $this->model_newsblog_setting->addCategory($this->request->post);

            $json['success'] = $this->language->get('text_success');
//        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    // удаление яндекс турбо категории
    public function removeCategory() {
        $this->load->language('newsblog/setting');

        $json = array();
//
//        if (!$this->user->hasPermission('modify', 'newsblog/setting')) {
//            $json['error'] = $this->language->get('error_permission');
//        } else {
            $this->load->model('newsblog/setting');

            $this->model_newsblog_setting->deleteCategory($this->request->post['category_id']);

            $json['success'] = $this->language->get('text_success');
//        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'newsblog/setting')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        return !$this->error;
    }

}
