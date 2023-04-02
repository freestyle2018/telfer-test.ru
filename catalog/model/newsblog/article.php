<?php

class ModelNewsBlogArticle extends Model {

    public function updateViewed($article_id) {
        $this->db->query("UPDATE " . DB_PREFIX . "newsblog_article SET viewed = (viewed + 1) WHERE article_id = '" . (int) $article_id . "'");
    }

    public function getArticleCategory($article_id) {
        $query = $this->db->query("SELECT ptc.category_id, ptc.article_id, c.image as image, d.name as category_name,
		(select price from " . DB_PREFIX . "newsblog_article where article_id='" . (int) $article_id . "') as price,
		(select name from " . DB_PREFIX . "newsblog_article_description where article_id='" . (int) $article_id . "') as name,
        (SELECT price FROM " . DB_PREFIX . "newsblog_article_special ps WHERE ps.article_id = '" . (int) $article_id . "' AND ps.customer_group_id = '" . (int) $this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special

		FROM " . DB_PREFIX . "newsblog_article_to_category ptc

		LEFT JOIN " . DB_PREFIX . "category c ON (c.category_id = ptc.category_id)
		LEFT JOIN " . DB_PREFIX . "category_description d ON (d.category_id = ptc.category_id)

		WHERE ptc.article_id = '" . (int) $article_id . "'");

        if ($query->num_rows) {
            return $query->row;
        } else {
            return false;
        }
    }

    public function getArticle($article_id) {
        $query = $this->db->query("SELECT DISTINCT *, p.date_added AS date_added, p.date_available AS date_available, pd.name AS name, p.image,
		p.sort_order

		FROM " . DB_PREFIX . "newsblog_article p
		LEFT JOIN " . DB_PREFIX . "newsblog_article_description pd ON (p.article_id = pd.article_id)
		LEFT JOIN " . DB_PREFIX . "newsblog_article_to_store p2s ON (p.article_id = p2s.article_id)
                LEFT JOIN " . DB_PREFIX . "affiliate a ON (pd.affiliate_id = a.affiliate_id)
                     
		WHERE p.article_id = '" . (int) $article_id . "' AND
		pd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND
		p.status = '1' AND
		
		p2s.store_id = '" . (int) $this->config->get('config_store_id') . "'");

        if ($query->num_rows) {
            return array(
                'article_id' => $query->row['article_id'],
                'name' => $query->row['name'],
                'preview' => $query->row['preview'],
                'description' => $query->row['description'],
                'meta_title' => $query->row['meta_title'],
                'meta_h1' => $query->row['meta_h1'],
                'meta_description' => $query->row['meta_description'],
                'meta_keyword' => $query->row['meta_keyword'],
                'tag' => $query->row['tag'],
                'image' => $query->row['image'],
                'date_added' => $query->row['date_added'],
				'date_available' => $query->row['date_available'],
                'sort_order' => $query->row['sort_order'],
                'status' => $query->row['status'],
                'date_modified' => $query->row['date_modified'],
                'viewed' => $query->row['viewed'],
                'affiliate_id' => $query->row['affiliate_id'],
                'affiliate_firstname' => $query->row['firstname'],
                'affiliate_lastname' => $query->row['lastname']
            );
        } else {
            return false;
        }
    }

    public function getArticles($data = array()) {
        $sql = "SELECT a.article_id";

        if (!empty($data['filter_category_id']) || !empty($data['filter_categories'])) {
            if (!empty($data['filter_sub_category'])) {
                $sql .= " FROM " . DB_PREFIX . "newsblog_category_path cp LEFT JOIN " . DB_PREFIX . "newsblog_article_to_category a2c ON (cp.category_id = a2c.category_id)";
            } else {
                $sql .= " FROM " . DB_PREFIX . "newsblog_article_to_category a2c";
            }

            $sql .= " LEFT JOIN " . DB_PREFIX . "newsblog_article a ON (a2c.article_id = a.article_id)";
        } else {
            $sql .= " FROM " . DB_PREFIX . "newsblog_article a";
        }

        $sql .= " LEFT JOIN " . DB_PREFIX . "newsblog_article_description ad ON (a.article_id = ad.article_id)
		LEFT JOIN " . DB_PREFIX . "newsblog_article_to_store a2s ON (a.article_id = a2s.article_id)

		WHERE ad.language_id = '" . (int) $this->config->get('config_language_id') . "' AND
		a.status = '1' AND
		a.date_available <= NOW() AND
		a2s.store_id = '" . (int) $this->config->get('config_store_id') . "'";

        if (!empty($data['filter_category_id'])) {
            if (!empty($data['filter_sub_category'])) {
                $sql .= " AND cp.path_id = '" . (int) $data['filter_category_id'] . "'";
            } else {
                $sql .= " AND a2c.category_id = '" . (int) $data['filter_category_id'] . "'";
            }
        }

        if (!empty($data['filter_categories'])) {
            if (!empty($data['filter_sub_category'])) {
                $sql .= " AND cp.path_id in (" . implode(',', $data['filter_categories']) . ")";
            } else {
                $sql .= " AND a2c.category_id in (" . implode(',', $data['filter_categories']) . ")";
            }
        }

        $sql .= " GROUP BY a.article_id";

        if (isset($data['sort'])) {
            if ($data['sort'] == 'ad.name') {
                $sql .= " ORDER BY LCASE(" . $data['sort'] . ")";
            } else {
                $sql .= " ORDER BY " . $data['sort'];
            }
        } else {
            $sql .= " ORDER BY a.sort_order";
        }

        if (isset($data['order'])) {
            $sql .= " " . $data['order'];
        } else {
            $sql .= " ASC";
        }

        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 10;
            }

            $sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
        }

        $article_data = array();

        $query = $this->db->query($sql);

        foreach ($query->rows as $result) {
            $article_data[$result['article_id']] = $this->getArticle($result['article_id']);
        }

        return $article_data;
    }

    public function getLatestarticles($limit) {
        $article_data = $this->cache->get('article.latest.' . (int) $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . (int) $limit);

        if (!$article_data) {
            $query = $this->db->query("SELECT p.article_id FROM " . DB_PREFIX . "newsblog_article p LEFT JOIN " . DB_PREFIX . "newsblog_article_to_store p2s ON (p.article_id = p2s.article_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "' ORDER BY p.date_added DESC LIMIT " . (int) $limit);

            foreach ($query->rows as $result) {

                $article_data[$result['article_id']] = $this->getArticleCategory($result['article_id']);
            }

            $this->cache->set('article.latest.' . (int) $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . (int) $limit, $article_data);
        }

        return $article_data;
    }

    public function getPopulararticles($limit) {
        $article_data = array();

        $query = $this->db->query("SELECT p.article_id FROM " . DB_PREFIX . "newsblog_article p LEFT JOIN " . DB_PREFIX . "newsblog_article_to_store p2s ON (p.article_id = p2s.article_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "' ORDER BY p.viewed DESC, p.date_added DESC LIMIT " . (int) $limit);

        foreach ($query->rows as $result) {
            $article_data[$result['article_id']] = $this->getArticle($result['article_id']);
        }

        return $article_data;
    }

    public function getArticleImages($article_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "newsblog_article_image WHERE article_id = '" . (int) $article_id . "' ORDER BY sort_order ASC");

        return $query->rows;
    }

    public function getArticleRelated($article_id) {
        $article_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "newsblog_article_related pr
		LEFT JOIN " . DB_PREFIX . "newsblog_article p ON (pr.related_id = p.article_id)
		LEFT JOIN " . DB_PREFIX . "newsblog_article_to_store p2s ON (p.article_id = p2s.article_id)
		WHERE pr.article_id = '" . (int) $article_id . "' AND pr.type=1 AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "'");

        foreach ($query->rows as $result) {
            $article_data[$result['related_id']] = $this->getArticle($result['related_id']);
        }

        return $article_data;
    }

    public function getArticleRelatedProducts($article_id) {
        $product_data = array();

        $query = $this->db->query("SELECT p.product_id FROM " . DB_PREFIX . "newsblog_article_related pr
		LEFT JOIN " . DB_PREFIX . "product p ON (pr.related_id = p.product_id)
		LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)
		WHERE pr.article_id = '" . (int) $article_id . "' AND pr.type=2 AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "'");

        foreach ($query->rows as $result) {
            $product_data[$result['product_id']] = $this->model_catalog_product->getProduct($result['product_id']);
        }

        return $product_data;
    }

    public function getArticleLayoutId($article_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "newsblog_article_to_layout WHERE article_id = '" . (int) $article_id . "' AND store_id = '" . (int) $this->config->get('config_store_id') . "'");

        if ($query->num_rows) {
            return $query->row['layout_id'];
        } else {
            return 0;
        }
    }

    public function getCategories($article_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "newsblog_article_to_category WHERE article_id = '" . (int) $article_id . "'");

        return $query->rows;
    }

    public function getTotalArticles($data = array()) {
        $sql = "SELECT COUNT(DISTINCT p.article_id) AS total";

        if (!empty($data['filter_category_id'])) {
            if (!empty($data['filter_sub_category'])) {
                $sql .= " FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "newsblog_article_to_category p2c ON (cp.category_id = p2c.category_id)";
            } else {
                $sql .= " FROM " . DB_PREFIX . "newsblog_article_to_category p2c";
            }

            if (!empty($data['filter_filter'])) {
                $sql .= " LEFT JOIN " . DB_PREFIX . "newsblog_article_filter pf ON (p2c.article_id = pf.article_id) LEFT JOIN " . DB_PREFIX . "newsblog_article p ON (pf.article_id = p.article_id)";
            } else {
                $sql .= " LEFT JOIN " . DB_PREFIX . "newsblog_article p ON (p2c.article_id = p.article_id)";
            }
        } else {
            $sql .= " FROM " . DB_PREFIX . "newsblog_article p";
        }

        $sql .= " LEFT JOIN " . DB_PREFIX . "newsblog_article_description pd ON (p.article_id = pd.article_id) LEFT JOIN " . DB_PREFIX . "newsblog_article_to_store p2s ON (p.article_id = p2s.article_id) WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "'";

        if (!empty($data['filter_category_id'])) {
            if (!empty($data['filter_sub_category'])) {
                $sql .= " AND cp.path_id = '" . (int) $data['filter_category_id'] . "'";
            } else {
                $sql .= " AND p2c.category_id = '" . (int) $data['filter_category_id'] . "'";
            }

            if (!empty($data['filter_filter'])) {
                $implode = array();

                $filters = explode(',', $data['filter_filter']);

                foreach ($filters as $filter_id) {
                    $implode[] = (int) $filter_id;
                }

                $sql .= " AND pf.filter_id IN (" . implode(',', $implode) . ")";
            }
        }

        if (!empty($data['filter_name']) || !empty($data['filter_tag'])) {
            $sql .= " AND (";

            if (!empty($data['filter_name'])) {
                $implode = array();

                $words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['filter_name'])));

                foreach ($words as $word) {
                    $implode[] = "pd.name LIKE '%" . $this->db->escape($word) . "%'";
                }

                if ($implode) {
                    $sql .= " " . implode(" AND ", $implode) . "";
                }

                if (!empty($data['filter_description'])) {
                    $sql .= " OR pd.description LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
                }
            }

            if (!empty($data['filter_name']) && !empty($data['filter_tag'])) {
                $sql .= " OR ";
            }

            if (!empty($data['filter_tag'])) {
                $sql .= "pd.tag LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_tag'])) . "%'";
            }

            $sql .= ")";
        }


        $query = $this->db->query($sql);

        return $query->row['total'];
    }

    public function getArticleMainCategoryId($article_id) {
        $query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "newsblog_article_to_category WHERE article_id = '" . (int) $article_id . "' order by main_category desc LIMIT 1");

        return ($query->num_rows ? (int) $query->row['category_id'] : 0);
    }

    public function getSetting($key, $store_id = 0) {
        $data = '';

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "newsblog_setting WHERE `key` = '" . $this->db->escape($key) . "'");

        foreach ($query->rows as $result) {
            $data = $result['value'];
        }

        return $data;
    }

    public function getMainArticle($article_id) {
        $query = $this->db->query("SELECT DISTINCT *, pd.name AS name, p.image,
		p.sort_order

		FROM " . DB_PREFIX . "newsblog_article p
		LEFT JOIN " . DB_PREFIX . "newsblog_article_description pd ON (p.article_id = pd.article_id)
		LEFT JOIN " . DB_PREFIX . "newsblog_article_to_store p2s ON (p.article_id = p2s.article_id)
                LEFT JOIN " . DB_PREFIX . "affiliate a ON (pd.affiliate_id = a.affiliate_id)
                    
		WHERE p.article_id = '" . (int) $article_id . "' AND
		pd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND
		p.status = '1' AND
                
		p2s.store_id = '" . (int) $this->config->get('config_store_id') . "'");

        if ($query->num_rows) {
            return array(
                'article_id' => $query->row['article_id'],
                'name' => $query->row['name'],
                'preview' => $query->row['preview'],
                'description' => $query->row['description'],
                'meta_title' => $query->row['meta_title'],
                'meta_h1' => $query->row['meta_h1'],
                'meta_description' => $query->row['meta_description'],
                'meta_keyword' => $query->row['meta_keyword'],
                'tag' => $query->row['tag'],
                'image' => $query->row['image'],
                'date_available' => $query->row['date_available'],
                'sort_order' => $query->row['sort_order'],
                'status' => $query->row['status'],
                'date_modified' => $query->row['date_modified'],
                'viewed' => $query->row['viewed'],
                'affiliate_id' => $query->row['affiliate_id'],
                'affiliate_firstname' => $query->row['firstname'],
                'affiliate_lastname' => $query->row['lastname']
            );
        } else {
            return false;
        }
    }

    public function getSecondArticles($main_article_id, $limit = 4) {
        $article_data = false;
        $query = $this->db->query("SELECT p.article_id FROM " . DB_PREFIX . "newsblog_article p
                    LEFT JOIN " . DB_PREFIX . "newsblog_article_to_store p2s ON (p.article_id = p2s.article_id)
                    
                    WHERE p.status = '1' AND p.article_id !='" . (int) $main_article_id . "' AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "' ORDER BY p.viewed DESC LIMIT " . (int) $limit);

        foreach ($query->rows as $result) {
            $article_data[$result['article_id']] = $this->getArticle($result['article_id']);
        }

        if ($article_data) {
            return $article_data;
        }
    }

    public function getAllCategories($data = array()) {
        $sql = "SELECT cp.category_id AS category_id,
		GROUP_CONCAT(cd1.name ORDER BY cp.level SEPARATOR '&nbsp;&nbsp;&gt;&nbsp;&nbsp;') AS name,
		c1.parent_id,
		c1.sort_order,
		c1.status,
		(select count(article_id) as product_count from " . DB_PREFIX . "newsblog_article_to_category pc where pc.category_id = c1.category_id) as article_count

		FROM " . DB_PREFIX . "newsblog_category_path cp
		LEFT JOIN " . DB_PREFIX . "newsblog_category c1 ON (cp.category_id = c1.category_id)
		LEFT JOIN " . DB_PREFIX . "newsblog_category c2 ON (cp.path_id = c2.category_id)
		LEFT JOIN " . DB_PREFIX . "newsblog_category_description cd1 ON (cp.path_id = cd1.category_id)
		LEFT JOIN " . DB_PREFIX . "newsblog_category_description cd2 ON (cp.category_id = cd2.category_id)

		WHERE cd1.language_id = '" . (int) $this->config->get('config_language_id') . "' AND
		cd2.language_id = '" . (int) $this->config->get('config_language_id') . "'";

        if (!empty($data['filter_name'])) {
            $sql .= " AND cd2.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
        }

        $sql .= " GROUP BY cp.category_id";

        $sort_data = array(
            'product_count',
            'name',
            'sort_order'
        );

        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];
        } else {
            $sql .= " ORDER BY sort_order";
        }

        if (isset($data['order']) && ($data['order'] == 'DESC')) {
            $sql .= " DESC";
        } else {
            $sql .= " ASC";
        }

        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }

            $sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
        }

        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function getCodeByAffiliate($affiliate_id) {
        $query = $this->db->query("SELECT `code` FROM " . DB_PREFIX . "affiliate WHERE affiliate_id = '" . (int) $affiliate_id . "'");

        if (isset($query->row['code'])) {
            return $query->row['code'];
        } else {
            return 1;
        }
    }

}
