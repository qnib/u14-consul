### QNIBTerminal ubuntu image
FROM qnib/u14-supervisor

ENV TERM=xterm \
    CONSUL_VER=0.5.2 \
    CON_TEMP_VER=0.10.0
RUN apt-get update && \
    apt-get install -y bsdtar curl 
RUN curl -fsL https://dl.bintray.com/mitchellh/consul/${CONSUL_VER}_linux_amd64.zip | bsdtar xf - -C /usr/local/bin/ && \
    chmod +x /usr/local/bin/consul
RUN mkdir -p /opt/consul-web-ui/ && \
    curl -fsL http://dl.bintray.com/mitchellh/consul/${CONSUL_VER}_web_ui.zip | bsdtar xf - -C /opt/consul-web-ui/ && \
    unset CONSUL_VER
RUN curl -fsL https://github.com/hashicorp/consul-template/releases/download/v${CON_TEMP_VER}/consul-template_${CON_TEMP_VER}_linux_amd64.tar.gz |tar xfz - -C /opt/ && \
    mv /opt/consul-template_${CON_TEMP_VER}_linux_amd64/consul-template /usr/local/bin/ && \
    chmod +x /usr/local/bin/consul-template && \
    unset CON_TEMP_VER

ADD etc/consul.json /etc/consul.json
ADD etc/supervisord.d/consul.ini /etc/supervisord.d/
ADD opt/qnib/bin/start_consul.sh /opt/qnib/bin/start_consul.sh
