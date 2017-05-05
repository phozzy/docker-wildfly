FROM fedora

MAINTAINER Arthur Fayzullin <arthur.fayzullin@gmail.com>

# updating according to best practicies
RUN dnf -y update && dnf clean all

# installing dependencies & wildfly packages
RUN dnf -y groupinstall javaenterprise && dnf clean all

# Set the JAVA_HOME variable to make it clear where Java is located
ENV JAVA_HOME /usr/lib/jvm/java
# Set JBOSS_HOME env variable
ENV JBOSS_HOME /usr/share/wildfly
# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

# switch to user wildfly
USER wildfly

# Expose the ports we're interested in
EXPOSE 8080 9990

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/usr/share/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
