FROM ghcr.io/qlicks/magento-php-8.3:latest

# Allow Composer plugins
RUN composer2 global config --no-plugins \
        allow-plugins.phpro/grumphp true && \
    composer2 global config --no-plugins \
        allow-plugins.dealerdirect/phpcodesniffer-composer-installer true

# Install GrumPHP, PHP Parallel Lint, PHPCS and Magento Coding Standard
RUN composer2 global require --dev \
    php-parallel-lint/php-parallel-lint \
    phpro/grumphp \
    "squizlabs/php_codesniffer:^3.13" \
    magento/magento-coding-standard

# Make Composer binaries available
ENV PATH="/app-home/.config/composer/vendor/bin:$PATH"

# Register Magento and PHPCompatibility coding standards
RUN phpcs --config-set installed_paths \
    /app-home/.config/composer/vendor/magento/magento-coding-standard,\
/app-home/.config/composer/vendor/magento/php-compatibility-fork

COPY entrypoint.sh /entrypoint.sh
COPY grumphp.yml /grumphp.yml

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
