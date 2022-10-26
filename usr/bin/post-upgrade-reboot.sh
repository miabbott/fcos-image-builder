#!/usr/bin/bash
set -eou pipefail

# Check if the first deployment is booted; if false, should indicate that
# an update was staged by `rpm-ostreed-automatic.service`
if [ "$(rpm-ostree status --json | jq -r '.deployments[0]["booted"]')" == "true" ]; then
    echo "First deployment is already booted; nothing to do."
    exit 0
fi

echo "First deployment is not booted; upgrade (probably) staged; rebooting..."
systemctl reboot
