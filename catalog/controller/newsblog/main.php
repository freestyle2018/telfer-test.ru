<?php

class ControllerNewsblogMain extends Controller {

    public function index() {
        $this->document->setTitle($this->config->get('config_meta_title'));
        $this->document->setDescription($this->config->get('config_meta_description'));
        $this->document->setKeywords($this->config->get('config_meta_keyword'));
        $this->document->addStyle('catalog/view/theme/default/stylesheet/ck_newsblog.css');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $data['breadcrumbs'][] = array(
            'text' => 'Публикации',
            'href' => $this->url->link('newsblog/main')
        );

//		if (isset($this->request->get['route'])) {
//			$this->document->addLink($this->config->get('config_url'), 'canonical');
//		}
        $data['heading_title'] = 'Публикации';

        $this->load->model('newsblog/article');

        $news_main_id = $this->model_newsblog_article->getSetting('main_news_id');

        if ($news_main_id) {
            $article_main_info = $this->model_newsblog_article->getMainArticle($news_main_id);


            if (isset($article_main_info)) {

                $this->load->model('tool/image');

                if ($article_main_info['image']) {
                    $data['original'] = HTTP_SERVER . 'image/' . $article_main_info['image'];
                    $data['popup'] = $this->model_tool_image->resize($article_main_info['image'], 500, 500);
                    $data['thumb'] = $this->model_tool_image->resize($article_main_info['image'], 300, 300);
                } else {
                    $data['original'] = false;
                    $data['popup'] = 'false';
                    $data['thumb'] = false;
                }

                $url = '';

                if (isset($this->request->get['newsblog_path'])) {
                    $url .= '&newsblog_path=' . $this->request->get['newsblog_path'];
                }


//            $data['breadcrumbs'][] = array(
//                'text' => $article_main_info['name'],
//                'href' => $this->url->link('newsblog/article', $url . '&newsblog_article_id=' . $news_main_id)
//            );



                if ($article_main_info['name']) {
                    $data['name_main_news'] = $article_main_info['name'];
                } else {
                    $data['name_main_news'] = 'Главная новость';
                }


                $data['article_id'] = $news_main_id;

                $data['affiliate_id'] = $article_main_info['affiliate_id'];
                $data['affiliate_firstname'] = $article_main_info['affiliate_firstname'];
                $data['affiliate_lastname'] = $article_main_info['affiliate_lastname'];


                $data['preview'] = html_entity_decode($article_main_info['preview'], ENT_QUOTES, 'UTF-8');

                $mainCategoryId = $this->model_newsblog_article->getArticleMainCategoryId($news_main_id);

                $data['href'] = $this->url->link('newsblog/article', 'newsblog_path=' . $mainCategoryId . '&newsblog_article_id=' . $news_main_id);

                $date_format = $this->language->get('date_format_short');
//            if ($settings) $date_format = $settings['date_format'];

                $data['date'] = ($date_format ? date($date_format, strtotime($article_main_info['date_available'])) : false);
                $data['date_modified'] = ($date_format ? date($date_format, strtotime($article_main_info['date_modified'])) : false);

                $data['viewed'] = $article_main_info['viewed'];
                $data['isset_main'] = true;
            } 
        }else {
                $data['isset_main'] = false;
            }



        if ($news_main_id) {
            $articles = $this->model_newsblog_article->getSecondArticles($news_main_id) ? $this->model_newsblog_article->getSecondArticles($news_main_id) : false;
            
            if ($articles) {
                foreach ($articles as $article) {

                $mainCategoryId = $this->model_newsblog_article->getArticleMainCategoryId($article['article_id']);

                $data['articles'][] = array(
                    'article_id' => $article['article_id'],
                    'image' => $article['image'],
                    'name' => $article['name'],
                    'preview' => $article['preview'],
                    'viewed' => $article['viewed'],
                    'href' => $this->url->link('newsblog/article', 'newsblog_path=' . $mainCategoryId . '&newsblog_article_id=' . $article['article_id']),
                    'affiliate_id' => $article['affiliate_id'],
                    'affiliate_firstname' => $article['affiliate_firstname'],
                    'affiliate_lastname' => $article['affiliate_lastname'],
                );
            }
            } else {
                $data['articles'] = false;
            }
            
        } else {
            $data['articles'] = false;
        }






        $data['categories'] = array();

//		$filter_data = array(
//			'sort'  => $sort,
//			'order' => $order,
//			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
//			'limit' => $this->config->get('config_limit_admin')
//		);
//		$category_total = $this->model_newsblog_category->getTotalCategories();

        $results = $this->model_newsblog_article->getAllCategories();

        foreach ($results as $result) {
            $data['categories'][] = array(
                'category_id' => $result['category_id'],
                'name' => $result['name'],
                'count_elements' => $this->model_newsblog_article->getTotalArticles(array('filter_category' => $result['category_id'])),
                'sort_order' => $result['sort_order'],
                'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $result['category_id'])
            );
        }

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('newsblog/main', $data));
    }

}
