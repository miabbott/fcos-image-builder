#!/usr/bin/bash
set -xeou pipefail

IMAGE=quay.io/miabbott/fcos-image-builder:latest

# Check the digest of the container used for the rebase locally and on the registry
installed_digest=$(rpm-ostree status --json | jq -r '.deployments[0]["container-image-reference-digest"]')
remote_digest=$(skopeo inspect docker://"${IMAGE}" | jq -r .Digest)

if [ "${installed_digest}" == "${remote_digest}" ]; then
    echo "No updated digest for ${IMAGE} found"
    exit 0
fi

echo "Found an updated digest for ${IMAGE}"
rpm-ostree upgrade --trigger-automatic-update-policy
systemctl reboot
