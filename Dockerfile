FROM php:7.2-cli-alpine

# Install PHP CodeSniffer
ARG PHPCS_RELEASE="3.3.1"
RUN pear install PHP_CodeSniffer-$PHPCS_RELEASE

# Install the PHPCompatibility standard
ARG PHPCOMP_RELEASE="8.2.0"
RUN set -eux &&\
    apk --no-cache add git &&\
    mkdir -p "/opt/" &&\
    cd "/opt/" &&\
    git clone -v --single-branch --depth 1 https://github.com/PHPCompatibility/PHPCompatibility.git --branch $PHPCOMP_RELEASE &&\
    rm -rf PHPCompatibility/.git &&\
    apk del git

# Configure phpcs defaults
RUN phpcs --config-set installed_paths /opt/PHPCompatibility &&\
    phpcs --config-set default_standard PHPCompatibility &&\
    phpcs --config-set testVersion 7.2 &&\
    phpcs --config-set report_width 120

# Configure PHP with some extra memory
RUN echo "memory_limit = 256M" >> /usr/local/etc/php/conf.d/memory.ini

WORKDIR /mnt/src

ENTRYPOINT ["/usr/local/bin/phpcs"]

CMD ["-p", "--colors", "."]
