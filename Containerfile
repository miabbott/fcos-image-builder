# Last built from commit: 3a1049c64d1aca416d0c8f860827b718407fa15f
FROM quay.io/fedora/fedora-coreos:stable
COPY rpm-ostree-upgrade-reboot.service /etc/systemd/system/rpm-ostree-upgrade-reboot.service
COPY rpm-ostree-upgrade-reboot.timer /etc/systemd/system/rpm-ostree-upgrade-reboot.timer
COPY rpm-ostree-upgrade-reboot.sh /usr/bin/rpm-ostree-upgrade-reboot.sh
RUN rpm-ostree install osbuild-composer composer-cli && \
    rpm-ostree cleanup -m && \
    systemctl enable osbuild-composer.socket && \
    systemctl enable rpm-ostree-upgrade-reboot.timer && \
    ostree container commit
