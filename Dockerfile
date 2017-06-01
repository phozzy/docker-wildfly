FROM fedora:latest

MAINTAINER Arthur

# updating and installing required packages
RUN dnf -y upgrade && \
    dnf -y groupinstall javaenterprise && \
    dnf -y install hibernate-entitymanager hibernate-envers hibernate-java8 hibernate-infinispan jbossws-cxf glassfish-jaxb-jxc slf4j-ext slf4j-jboss-logmanager && \
    dnf -y install mysql-connector-java.noarch && \
    dnf clean all

# bug fix
RUN ln -sf /usr/share/java/wildfly/wildfly-clustering-singleton-api.jar /usr/share/wildfly/modules/system/layers/base/org/wildfly/clustering/singleton/main/wildfly-clustering-singleton-api-10.1.0.Final.jar && \
    ln -sf /usr/share/java/wildfly/wildfly-clustering-singleton-extension.jar /usr/share/wildfly/modules/system/layers/base/org/wildfly/clustering/singleton/main/wildfly-clustering-singleton-extension-10.1.0.Final.jar

# set einvironment
ENV JAVA_HOME /usr/lib/jvm/java-openjdk
ENV JBOSS_HOME /usr/share/wildfly
ENV LAUNCH_JBOSS_IN_BACKGROUND true

# add database connection
COPY files /tmp/files
RUN mkdir -p /usr/share/wildfly/modules/system/layers/base/com/mysql/main && \
    ln -s /usr/share/java/mysql-connector-java.jar /usr/share/wildfly/modules/system/layers/base/com/mysql/main/mysql-connector-java.jar && \
    cp /tmp/files/module.xml /usr/share/wildfly/modules/system/layers/base/com/mysql/main/ && \
    sed -i -e '/<datasources>/ r /tmp/files/datasource.xml' /usr/share/wildfly/standalone/configuration/standalone.xml && \
    sed -i -e '/<drivers>/ r /tmp/files/driver.xml' /usr/share/wildfly/standalone/configuration/standalone.xml

USER wildfly

EXPOSE 8080 9990

CMD ["/usr/share/wildfly/bin/standalone.sh", "-c", "standalone.xml", "-b", "0.0.0.0"]
