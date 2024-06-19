FROM  ghcr.io/qlicks/magento-php-8.3:latest



RUN composer2 global require --dev php-parallel-lint/php-parallel-lint && composer global require --dev phpro/grumphp && \
    composer2 global require --dev "squizlabs/php_codesniffer=*" && \
    composer2 global require --dev magento/magento-coding-standard && \
#    composer2 global require --dev phpcompatibility/php-compatibility:dev-develop && \
#    composer2 global require --dev dealerdirect/phpcodesniffer-composer-installer && \ 
    /app-home/.composer/vendor/bin/phpcs --config-set installed_paths /app-home/.composer/vendor/phpcompatibility/php-compatibility,/app-home/.composer/vendor/magento/magento-coding-standard/
    
     
#Disabled
#    composer2 global require --dev friendsofphp/php-cs-fixer:v3.4.0 && \
#    composer2 global require --dev phpstan/phpstan && \
#    composer2 global require --dev phpmd/phpmd && \


COPY entrypoint.sh /entrypoint.sh
COPY grumphp.yml  /grumphp.yml
ENV PATH "$HOME/.composer/vendor/bin:$PATH"

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

