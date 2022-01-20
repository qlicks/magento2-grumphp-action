FROM  ghcr.io/qlicks/magento-php-7.4:latest



RUN composer2 global require --dev php-parallel-lint/php-parallel-lint && composer global require --dev phpro/grumphp && \
    composer2 global require --dev "squizlabs/php_codesniffer=*" && \
    composer2 global require --dev magento/magento-coding-standard && \
    composer2 global require --dev friendsofphp/php-cs-fixer && \
    composer2 global require --dev phpstan/phpstan && \
    composer2 global require --dev phpmd/phpmd:2.8.2 && \
    /app-home/.composer/vendor/bin/phpcs --config-set installed_paths /app-home/.composer/vendor/magento/magento-coding-standard/


COPY entrypoint.sh /entrypoint.sh
COPY grumphp.yml  /grumphp.yml
ENV PATH "$HOME/.composer/vendor/bin:$PATH"

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

