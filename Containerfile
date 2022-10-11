# Last built from commit: 4f39ee28a7b0e38d654632a482f3dc96e688953c
FROM quay.io/fedora/fedora-coreos:stable
ADD rpm-ostree-upgrade-reboot.service /etc/systemd/system/rpm-ostree-upgrade-reboot.service
ADD rpm-ostree-upgrade-reboot.timer /etc/systemd/system/rpm-ostree-upgrade-reboot.timer
ADD rpm-ostree-upgrade-reboot.sh /usr/local/bin/rpm-ostree-upgrade-reboot.sh
RUN rpm-ostree install osbuild-composer composer-cli && \
    rpm-ostree cleanup -m && \
    systemctl enable osbuild-composer.socket && \
    systemctl enable rpm-ostree-upgrade-reboot.timer && \
    ostree container commit
