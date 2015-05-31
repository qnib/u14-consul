FROM qnib/u14-supervisor
MAINTAINER "Christian Kniep <christian@qnib.org>"

WORKDIR /tmp/
ENV TERM=xterm
RUN apt-get install -y unzip wget 
RUN wget -q -O /tmp/consul.zip https://dl.bintray.com/mitchellh/consul/0.5.1_linux_amd64.zip && \
    unzip /tmp/consul.zip && rm -f /tmp/consul.zip && \
    mv consul /usr/local/bin/

RUN wget -q -O /tmp/consul_web_ui.zip http://dl.bintray.com/mitchellh/consul/0.5.1_web_ui.zip && \
    unzip /tmp/consul_web_ui.zip && rm -f /tmp/consul_web_ui.zip && \
    mv dist /opt/consul-web-ui
WORKDIR /root/
ADD etc/consul.json /etc/consul.json
ADD etc/supervisord.d/consul.ini /etc/supervisord.d/
ADD opt/qnib/bin/start_consul.sh /opt/qnib/bin/start_consul.sh
