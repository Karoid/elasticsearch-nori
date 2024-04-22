## For release new version
# docker buildx create --use
# docker buildx build --build-arg ES_VERSION=7.17.20 --platform linux/amd64,linux/arm64 -t karoid/elasticsearch-nori:7.17.20 --push .

## For debugging command lines
# docker run --rm -it --user root elasticsearch:7.17.20 bash

ARG ES_VERSION="2.3.0"
FROM elasticsearch:$ES_VERSION
ARG ES_VERSION

RUN bin/elasticsearch-plugin install analysis-nori analysis-kuromoji

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/docker-entrypoint.sh"]

CMD ["eswrapper"]

HEALTHCHECK --interval=10s --timeout=5s --start-period=1m --retries=5 CMD curl -I -f --max-time 5 http://localhost:9200 || exit 1