FROM ghcr.io/qlicks/magento-php-8.4:latest

RUN composer2 global config --no-plugins allow-plugins.phpro/grumphp true

RUN composer2 global require --dev \
    php-parallel-lint/php-parallel-lint \
    phpro/grumphp \
    "squizlabs/php_codesniffer=*"

ENV PATH="/app-home/.config/composer/vendor/bin:$PATH"

COPY entrypoint.sh /entrypoint.sh
COPY grumphp.yml /grumphp.yml

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
