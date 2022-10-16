# Last built from commit: 33b30af8a59013eebaeca37ec41febb3794a17e6
FROM quay.io/fedora/fedora-coreos:stable
COPY usr/bin /usr/bin
COPY etc /etc
RUN rpm-ostree install osbuild-composer composer-cli && \
    rpm-ostree cleanup -m && \
    sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf && \
    systemctl enable osbuild-composer.socket && \
    systemctl enable rpm-ostreed-automatic.timer && \
    ostree container commit
