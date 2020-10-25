FROM rabbitmq:3.8.9-management-alpine

LABEL MAINTAINER="Chong Zhi Kang <chongz.kang@gmail.com>"

RUN apk add --no-cache --upgrade bash

RUN apk add --no-cache procps 

COPY rabbitmq.conf /etc/rabbitmq/

COPY .erlang.cookie /var/lib/rabbitmq/

COPY rabbit.sh /opt/rabbitmq/

RUN chmod u+rw /etc/rabbitmq/rabbitmq.conf \
  && chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie \
  && chmod 400 /var/lib/rabbitmq/.erlang.cookie \
  && chmod a+x /opt/rabbitmq/rabbit.sh 

ENTRYPOINT ["/opt/rabbitmq/rabbit.sh"]