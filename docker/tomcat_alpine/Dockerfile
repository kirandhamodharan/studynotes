FROM alpine:latest as base
WORKDIR /tmp
ARG OPEN_JDK_URL="https://download.java.net/java/early_access/alpine/14/binaries/openjdk-17-ea+14_linux-x64-musl_bin.tar.gz"
ARG TOMCAT_URL="https://downloads.apache.org/tomcat/tomcat-9/v9.0.45/bin/apache-tomcat-9.0.45.tar.gz"

RUN apk --update add curl openjdk11\
    # && curl -o openjdk.tar.gz $OPEN_JDK_URL && tar xvf openjdk.tar.gz --directory /opt\
    && curl -o tomcat.tar.gz $TOMCAT_URL && tar xvf tomcat.tar.gz --directory /opt\
    && apk del curl && rm -rf /var/cache/apk/*
    # && mkdir -p /opt/apache-tomcat-9.0.45/webapps/myapp && echo "Hi from Tomcat server on container!!!" >> /opt/apache-tomcat-9.0.45/webapps/myapp/index.html

FROM alpine:latest
RUN apk --update add openjdk11-jre && mkdir -p /opt/tomcat-9.0.45 && rm -rf /var/cache/apk/*

COPY --from=base /opt/apache-tomcat-9.0.45 /opt/tomcat-9.0.45

EXPOSE 8080
CMD ["/opt/tomcat-9.0.45/bin/catalina.sh", "run"]

# docker build -t tomcatserver:v1 .
# docker run -dp 80:8080 tomcatserver:v1
# docker run -d -v /SOURCE:/opt/tomcat-9.0.45/webapps/mywebapp -p 8081:8080 tomcatserver:v1