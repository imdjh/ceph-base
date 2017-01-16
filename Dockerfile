# CEPH BASE IMAGE
# CEPH VERSION: Jewel
# CEPH VERSION DETAIL: 10.2.5

FROM index.alauda.cn/library/ubuntu:14.04

ENV ETCDCTL_VERSION v2.2.0
ENV ETCDCTL_ARCH linux-amd64
ENV CEPH_VERSION jewel

ENV KVIATOR_VERSION 0.0.5
ENV CONFD_VERSION 0.10.0

# Install prerequisites
RUN apt-get update &&  apt-get install -y wget unzip uuid-runtime

# Install Ceph
RUN wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | apt-key add -
RUN echo deb http://download.ceph.com/debian-${CEPH_VERSION}/ trusty main | tee /etc/apt/sources.list.d/ceph-${CEPH_VERSION}.list
RUN apt-get update && apt-get install -y --force-yes ceph radosgw && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add and set entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
