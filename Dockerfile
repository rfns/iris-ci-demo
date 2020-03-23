FROM alpine:latest as stage

WORKDIR /opt/stage

RUN \
  apk update \
  && apk add wget \
  && mkdir -p /opt/stage/deps \
  && wget https://github.com/rfns/forgery/releases/download/v1.2.1/forgery-v1.2.1.xml --quiet --output-document /opt/stage/deps/forgery-v1.2.1.xml

FROM rfns/iris-ci:0.5.3

COPY  --from=stage /opt/stage/deps /opt/ci/deps

USER ROOT

USER irisowner
SHELL ["/opt/ci/scripts/setup-iris.sh"]

RUN do $System.OBJ.Load("/opt/ci/deps/forgery-v1.2.1.xml", "c")



