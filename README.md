# Fedora CoreOS with Image Builder layer

[![quay.io repository](https://img.shields.io/badge/updated-2022--10--10-green)](https://quay.io/repository/miabbott/fcos-image-builder)

This is builds a version of Fedora CoreOS using the [ostree native container](https://fedoraproject.org/wiki/Changes/OstreeNativeContainer)
features.

The GitHub workflow generates a new container image weekly.

The customizations in the Containerfile provide a hacky systemd service + timer
that will automatically upgrade a system to the new version of the container image
if it is available.

Ultimately, I hope to have a complete deployment/workflow showing how to build a
RHEL for Edge image using Image Builder, along with an e2e story for generating
and managing the ostree updates.
