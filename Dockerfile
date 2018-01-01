FROM gradle:alpine
ADD . project
USER root
RUN chown -R gradle:gradle project

RUN apk add -U java-cacerts curl && ln -sf /etc/ssl/certs/java/cacerts $JAVA_HOME/jre/lib/security/cacerts

USER gradle
WORKDIR project
ENTRYPOINT gradle
CMD ["gradle", "bootRun"]
