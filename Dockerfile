FROM yunnysunny/jre:latest
ENV PULSAR_LOG_DIR=/data/app/log
ENV PULSAR_HOME=/opt/pulsar
ENV PULSAR_PIDFILE=$PULSAR_HOME/bin/pulsar-standalone.pid
ARG PULSAR_VERSION

COPY install_pulsar.sh /data/install_pulsar.sh
RUN /data/install_pulsar.sh

COPY config.sh /data/config.sh
COPY util.sh /root/util.sh
# ARG PULSAR_DATA_DIR=/data/pulsar-logs
RUN /data/config.sh

COPY pulsar /etc/init.d/pulsar

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
