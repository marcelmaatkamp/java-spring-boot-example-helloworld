FROM gradle:alpine
ADD . project
USER root
RUN chown -R gradle:gradle project

# certificates in /usr/local/share/ca-certificates
#  keytool -noprompt -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -importcert -alias root -file /tmp/root.crt 

RUN \
 apk add -U ca-certificates java-cacerts sudo curl &&\ 
 rm -rf /var/cache/apk/* /tmp/* &&\
 update-ca-certificates &&\
 ln -sf /etc/ssl/certs/java/cacerts $JAVA_HOME/jre/lib/security/cacerts &&\ 
 echo 'gradle ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER gradle
WORKDIR project
ENTRYPOINT gradle
CMD ["gradle", "bootRun"]
