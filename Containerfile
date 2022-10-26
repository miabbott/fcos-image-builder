# Last built from commit: de0e788a6f0d9b3e6f6ddd0c7f65021486ff312d
FROM quay.io/fedora/fedora-coreos:stable
COPY usr/bin /usr/bin
COPY etc /etc
RUN rpm-ostree install osbuild-composer composer-cli && \
    rpm-ostree cleanup -m && \
    sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf && \
    systemctl enable osbuild-composer.socket && \
    systemctl enable rpm-ostreed-automatic.timer && \
    systemctl enable post-upgrade-reboot.service && \
    ostree container commit
