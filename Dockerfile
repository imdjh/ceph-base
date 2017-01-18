# CEPH BASE IMAGE
# CEPH VERSION: Jewel
# CEPH VERSION DETAIL: 10.2.5

FROM index.alauda.cn/library/ubuntu:14.04
MAINTAINER Jiahao Dai "jiahao.dai@hypers.com"

ENV ETCDCTL_VERSION v2.2.4
ENV ETCDCTL_ARCH linux-amd64
ENV CEPH_VERSION jewel
ENV KVIATOR_VERSION 0.0.7
ENV CONFD_VERSION 0.10.0
ENV KUBECTL_VERSION v1.4.0

# Install prerequisites
RUN DEBIAN_FRONTEND=noninteractive apt-get update &&  apt-get install -y wget unzip uuid-runtime python-setuptools udev sharutils && \
\
# Install Ceph
    wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | apt-key add - && \
    echo deb http://mirrors.163.com/ceph/debian-${CEPH_VERSION}/ trusty main | tee /etc/apt/sources.list.d/ceph-${CEPH_VERSION}.list && \
    apt-get update && apt-get install -y --force-yes ceph radosgw rbd-mirror && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add and set entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
