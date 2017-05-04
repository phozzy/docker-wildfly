FROM fedora

MAINTAINER Arthur Fayzullin <arthur.fayzullin@gmail.com>

# updating according to best practicies
RUN dnf -y update && dnf clean all

# installing dependencies & wildfly packages
RUN dnf -y groupinstall javaenterprise && dnf clean all
