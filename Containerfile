# Last built from commit: 3e591756ebca332f1399a93ec5e9c73d9a1239a5
FROM quay.io/fedora/fedora-coreos:stable
COPY usr/bin /usr/bin
COPY etc /etc
RUN rpm-ostree install osbuild-composer composer-cli && \
    rpm-ostree cleanup -m && \
    sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf && \
    systemctl enable osbuild-composer.socket && \
    systemctl enable rpm-ostreed-automatic.timer && \
    systemctl enable post-upgrade-reboot.service && \
    rm -rf /var/lib/unbound && \
    ostree container commit
