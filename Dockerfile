FROM ghcr.io/qlicks/magento-php-8.4:latest

# Allow GrumPHP Composer plugin
RUN composer2 global config --no-plugins allow-plugins.phpro/grumphp true
RUN composer2 global config --no-plugins allow-plugins.dealerdirect/phpcodesniffer-composer-installer true

# Install GrumPHP, PHP Parallel Lint and PHP_CodeSniffer
# Magento Coding Standard currently requires PHP_CodeSniffer 3.x
RUN composer2 global require --dev \
    php-parallel-lint/php-parallel-lint \
    phpro/grumphp \
    "squizlabs/php_codesniffer:^3.13" \
    magento/magento-coding-standard

# Make global Composer binaries available
ENV PATH="/app-home/.config/composer/vendor/bin:$PATH"

# Register Magento Coding Standard with PHPCS
RUN phpcs --config-set installed_paths \
    /app-home/.config/composer/vendor/magento/magento-coding-standard,\
/app-home/.config/composer/vendor/magento/php-compatibility-fork


COPY entrypoint.sh /entrypoint.sh
COPY grumphp.yml /grumphp.yml

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
