FROM fedora:latest

MAINTAINER Arthur

# updating and installing required packages
RUN dnf -y upgrade && \
    dnf -y groupinstall javaenterprise && \
    dnf -y install hibernate-entitymanager hibernate-envers hibernate-java8 hibernate-infinispan jbossws-cxf glassfish-jaxb-jxc slf4j-ext slf4j-jboss-logmanager && \
    dnf -y install postgresql-jdbc.noarch && \
    dnf clean all

# bug fix
RUN ln -sf /usr/share/java/wildfly/wildfly-clustering-singleton-api.jar /usr/share/wildfly/modules/system/layers/base/org/wildfly/clustering/singleton/main/wildfly-clustering-singleton-api-10.1.0.Final.jar && \
    ln -sf /usr/share/java/wildfly/wildfly-clustering-singleton-extension.jar /usr/share/wildfly/modules/system/layers/base/org/wildfly/clustering/singleton/main/wildfly-clustering-singleton-extension-10.1.0.Final.jar

# add database connection
RUN mkdir -p /usr/share/wildfly/modules/system/layers/base/org/postgresql/main
RUN ln -s /usr/share/java/postgresql-jdbc.jar /usr/share/wildfly/modules/system/layers/base/org/postgresql/main/postgresql-jdbc.jar

# set einvironment
ENV JAVA_HOME /usr/lib/jvm/java-openjdk
ENV JBOSS_HOME /usr/share/wildfly
ENV LAUNCH_JBOSS_IN_BACKGROUND true

USER wildfly

EXPOSE 8080 9990

CMD ["/usr/share/wildfly/bin/standalone.sh", "-c", "standalone.xml", "-b", "0.0.0.0"]
