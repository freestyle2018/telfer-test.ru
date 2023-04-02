<?php echo '<?xml version="1.0" encoding="UTF-8" ?>'; ?>
<rss xmlns:yandex="http://news.yandex.ru" xmlns:media="http://search.yahoo.com/mrss/" xmlns:turbo="http://turbo.yandex.ru" version="2.0">
    <channel>
        <title>
            <?php echo preg_replace("/[\x{2600}-\x{26FF}]/u", "", $config_name); ?>
        </title>
        <turbo:content>
            <?php echo preg_replace('~[\x{10000}-\x{10FFFF}]~u', '', $config_meta_description); ?>
        </turbo:content>			
        <link>
            <?php echo $config_url; ?>
        </link>

        <?php foreach ($articles as $article) { ?>
        <?php if ($article['article_id'] && $article['description']) { ?>
        <item turbo="true">
            <title><?php echo $article['name']; ?></title>
            <link>
                <?php echo $article['href']; ?>
            </link>
            <pubDate><?php echo $article['date_available']; ?></pubDate>
            <turbo:content><?php echo '<![CDATA[' ?>
                <header>
                    <h1><?php echo $article['name']; ?></h1>
                    <figure>
                        <img src="<?php echo $article['thumb']; ?>"/>
                    </figure>
                </header>
                <?php echo $article['description']; ?>
            <?php echo ']]>'; ?>
            </turbo:content>
        </item>
         <? } ?>
        <? } ?>
    </channel>

</rss>