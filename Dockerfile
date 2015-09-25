### QNIBTerminal ubuntu image
FROM qnib/u14-supervisor

ENV TERM=xterm
RUN apt-get update && \
    apt-get install -y bsdtar curl 
RUN curl -fsL https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip | bsdtar xf - -C /usr/local/bin/ && \
    chmod +x /usr/local/bin/consul
RUN mkdir -p /opt/consul-web-ui/ && \
    curl -fsL http://dl.bintray.com/mitchellh/consul/0.5.2_web_ui.zip | bsdtar xf - -C /opt/consul-web-ui/

ADD etc/consul.json /etc/consul.json
ADD etc/supervisord.d/consul.ini /etc/supervisord.d/
ADD opt/qnib/bin/start_consul.sh /opt/qnib/bin/start_consul.sh
