# Last built from commit: d4b87e40044799f9752ef75f8a7b64838bab431e
FROM quay.io/fedora/fedora-coreos:stable
RUN rpm-ostree install osbuild-composer composer-cli && rpm-ostree cleanup -m && \
    systemctl enable osbuild-composer.socket && \
    ostree container commit
