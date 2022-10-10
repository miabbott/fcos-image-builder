# Last built from commit: 156fbaf7327898f827709bca9255e973b5bd9b7e
FROM quay.io/fedora/fedora-coreos:stable
RUN rpm-ostree install osbuild-composer composer-cli && rpm-ostree cleanup -m && \
    systemctl enable osbuild-composer.socket && \
    ostree container commit
