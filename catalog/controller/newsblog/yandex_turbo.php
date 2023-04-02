<?php

class ControllerNewsblogYandexTurbo extends Controller {

    private static $yandex_turbo_allowed_tags = '<p><a><h1><h2><h3><figure><img><figcaption><header><ul><ol><li><video><source><br><b><strong><i><pre><abbr><u><table><tr><td><th><tbody><col><thead><tfoot><button><iframe><embed>';

    public function index() {

        $this->load->model('newsblog/setting');
        $this->load->model('setting/setting');

        if ($this->model_newsblog_setting->getSetting('yandex_turbo_status')) {

            $data['config_name'] = $this->config->get('config_name');
            $data['config_meta_description'] = $this->config->get('config_meta_description');
            $data['config_url'] = $this->config->get('config_url');

            $this->load->model('newsblog/yandex_turbo');
            $this->load->model('newsblog/category');
            $this->load->model('newsblog/article');

            $this->load->model('tool/image');

            $product_data = array();

            $yandex_turbo_categories = $this->model_newsblog_yandex_turbo->getCategories();

            foreach ($yandex_turbo_categories as $yandex_turbo_category) {
                $filter_data = array(
                    'filter_category_id' => $yandex_turbo_category['category_id'],
                    'filter_filter' => false
                );

                $articles = $this->model_newsblog_article->getArticles($filter_data);

                foreach ($articles as $article) {
                    if ($article['article_id'] && $article['description']) {

                        if ($article['image']) {
                            $image = $this->model_tool_image->resize($article['image'], 500, 500); //$this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
                        } else {
                            $image = $this->model_tool_image->resize('placeholder.png', 500, 500); //$this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
                        }

                        $turbo_content = strip_tags(html_entity_decode($article['description']), self::$yandex_turbo_allowed_tags);
                        
                        
                        $turbo_content = preg_replace('/<p>\s*<\/p>/', '', $turbo_content);
                        $turbo_content = preg_replace('/class\s*=\s*".*?"/', '', $turbo_content);
                        $turbo_content = preg_replace('/class\s*=\s*\'.*?\'/', '', $turbo_content);
                        $turbo_content = preg_replace('/style\s*=\s*".*?"/', '', $turbo_content);
                        $turbo_content = preg_replace('/style\s*=\s*\'.*?\'/', '', $turbo_content);
                        $turbo_content = preg_replace('/\s+>/', '>', $turbo_content);

                        $data['articles'][] = array(
                            'article_id' => $article['article_id'],
                            'thumb' => $image,
                            'name' => $article['name'],
                            'description' => $turbo_content,
                            'date_available' => $article['date_available'],
                            'href' => $this->url->link('newsblog/article&newsblog_article_id=' . $article['article_id'])
                        );
                    }
                }
            }

            $this->response->addHeader('Content-Type: application/xml; charset=utf-8');
            $this->response->setOutput($this->load->view('newsblog/yandex_turbo_article', $data));
        } else {
            $this->response->redirect($this->url->link('newsblog/main', true));
        }
    }

}
