#ansible-tower dockerfile
# WORK IN PROGRESS
# DO NOT USE IN PRODUCTION
FROM centos:7

MAINTAINER tim@arctium.io

ENV TOWER_VER 3.0.3
    
# Enable EPEL-Repo, install Ansible
RUN yum update -y \
    && yum install -y sudo \
    && yum install -y http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum install -y ansible

# Download and install Tower
RUN cd /opt \
    && curl -O https://releases.ansible.com/ansible-tower/setup-bundle/ansible-tower-setup-bundle-${TOWER_VER}-1.el7.tar.gz \
    && tar xvzf ansible-tower-setup-bundle-${TOWER_VER}-1.el7.tar.gz \
    && cd ansible-tower-setup-bundle-${TOWER_VER}-1.el7
    
ADD inventory /opt/ansible-tower-setup-bundle-${TOWER_VER}-1.el7/inventory

RUN cd /opt/ansible-tower-setup-bundle-${TOWER_VER}-1.el7 \
    && su root \
    && ./setup.sh

EXPOSE 443 8080
