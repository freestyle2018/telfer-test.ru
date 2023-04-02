<?php

class ModelNewsblogYandexTurbo extends Model {

    public function getCategories() {
        $query = $this->db->query("SELECT category_id, (SELECT name FROM `" . DB_PREFIX . "newsblog_category_description` cd WHERE cd.category_id = gbc2c.category_id AND cd.language_id = '" . (int) $this->config->get('config_language_id') . "') AS category FROM `" . DB_PREFIX . "yandex_turbo_category_to_category` gbc2c ORDER BY category_id ASC");

        return $query->rows;
    }

    public function getTotalCategories() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "yandex_turbo_category_to_category`");

        return $query->row['total'];
    }

}
