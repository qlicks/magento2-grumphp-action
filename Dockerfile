FROM  ghcr.io/qlicks/magento-php-7.3:latest



RUN composer global require --dev php-parallel-lint/php-parallel-lint
RUN composer global require --dev phpro/grumphp
RUN composer global require --dev "squizlabs/php_codesniffer=*"
RUN composer global require --dev magento/magento-coding-standard
RUN composer global require --dev friendsofphp/php-cs-fixer
RUN composer global require --dev phpstan/phpstan
RUN composer global require --dev phpmd/phpmd
RUN ls -la $HOME/.composer/vendor/
RUN /app-home/.composer/vendor/bin/phpcs --config-set installed_paths /app-home/.composer/vendor/magento/magento-coding-standard/


COPY entrypoint.sh /entrypoint.sh
COPY grumphp.yml  /grumphp.yml
ENV PATH "$HOME/.composer/vendor/bin:$PATH"

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

