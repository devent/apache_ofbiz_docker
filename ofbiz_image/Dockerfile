FROM java:8-jdk
MAINTAINER Erwin Mueller "erwin.mueller@nttdata.com"

# Apache Ofbiz version.
ENV OFBIZ_VERSION 13.07.03

# Set apt noninteractive.
ENV DEBIAN_FRONTEND noninteractive

# Apache Ofbiz local user.
RUN set -x \
    && if ! id "www-data">/dev/null; then useradd -rU www-data; fi

# deactivate recomended packages.
RUN set -x \
    && echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
    && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends

# Optional add proxy entries for apt.
RUN set -x \
    && if [ -n "${http_proxy}" ]; then echo Acquire::http::Proxy \"$http_proxy\"; >> /etc/apt/apt.conf.d/08proxy; fi \
    && if [ -n "${ftp_proxy}" ]; then echo Acquire::ftp::Proxy \"$ftp_proxy\"; >> /etc/apt/apt.conf.d/08proxy; fi

# Add tools.
RUN set -x \
    && apt-get update \
    && apt-get install -y dnsutils net-tools bsdmainutils sed \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Apache Ofbiz.
RUN set -x \
    && OFBIZ_ZIP_SOURCE="http://mirror.serversupportforum.de/apache/ofbiz/apache-ofbiz-${OFBIZ_VERSION}.zip" \
    && OFBIZ_ZIP_ASC_SOURCE="http://www.apache.org/dist/ofbiz/apache-ofbiz-${OFBIZ_VERSION}.zip.asc" \
    && OFBIZ_ZIP="/tmp/apache-ofbiz.zip" \
    && OFBIZ_ZIP_ASC="/tmp/apache-ofbiz.zip.asc" \
    && apt-get update \
    && apt-get install -y \
                        wget \
                        gnupg \
                        unzip \

    # download and verify Apache Ofbiz

    && cd /tmp \
    && wget -nv -O $OFBIZ_ZIP $OFBIZ_ZIP_SOURCE \
    && wget -nv -O $OFBIZ_ZIP_ASC $OFBIZ_ZIP_ASC_SOURCE \
    && gpg --keyserver pgp.uni-mainz.de --recv-key 847AF9E0 \
    && gpg --verify $OFBIZ_ZIP_ASC $OFBIZ_ZIP \
    && unzip $OFBIZ_ZIP \
    && mkdir -p /usr/src \
    && mv apache-ofbiz-${OFBIZ_VERSION} /usr/src \
    && cd /usr/src \
    && ln -sf /usr/src/apache-ofbiz-${OFBIZ_VERSION} /usr/src/apache-ofbiz \

    # build Apache Ofbiz

    && apt-get install -y \
                        ant \
    && cd apache-ofbiz \
    && ant load-demo \

    # cleanup

    && cd /tmp \
    && rm -rf $OFBIZ_ZIP $OFBIZ_ZIP_ASC \
    && apt-get remove --auto-remove -y unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# expose Tomcat
EXPOSE 8080
EXPOSE 8443

# add entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN set -x \
    && chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

WORKDIR /var/www/html/apache-ofbiz

# run Apache Ofbiz
CMD ["./ant", "start"]
