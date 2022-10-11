# Last built from commit: a17ad6627e1d036f9ebc69189a5d3bf1ac4da49a
FROM quay.io/fedora/fedora-coreos:stable
COPY rpm-ostree-upgrade-reboot.service /etc/systemd/system/rpm-ostree-upgrade-reboot.service
COPY rpm-ostree-upgrade-reboot.timer /etc/systemd/system/rpm-ostree-upgrade-reboot.timer
COPY rpm-ostree-upgrade-reboot.sh /usr/bin/rpm-ostree-upgrade-reboot.sh
RUN rpm-ostree install osbuild-composer composer-cli && \
    rpm-ostree cleanup -m && \
    systemctl enable osbuild-composer.socket && \
    systemctl enable rpm-ostree-upgrade-reboot.timer && \
    ostree container commit
