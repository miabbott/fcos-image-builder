# Last built from commit: 6e07be45cb241e7329f60da0b0e62df39cad5ea3
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
