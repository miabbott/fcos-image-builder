# Fedora CoreOS with Image Builder layer

[![quay.io repository](https://img.shields.io/badge/updated-2023--06--18-green)](https://quay.io/repository/miabbott/fcos-image-builder)

This is builds a version of Fedora CoreOS using the [ostree native container](https://fedoraproject.org/wiki/Changes/OstreeNativeContainer) features.

The GitHub workflow generates a new container image weekly. (See <https://github.com/jlebon/pet> for inspiration)

The customizations in the Containerfile enable the install of the [osbuild-composer](https://www.osbuild.org/guides/) service and CLI.  In addition, there are systemd services that enable the automatic upgrade and reboot of the running system.

**WARNING** This example is not safe for production as the system could automatically reboot while a critical workload is running.

## Initialization

This assumes you have booted a vanilla [Fedora CoreOS](https://getfedora.org/en/coreos?stream=stable) image using the provided [Butane](https://coreos.github.io/butane/) -> [Ignition](https://coreos.github.io/ignition) config to disable `zincati` and rebase to the layered image.

I used `yq` as a cheap YAML editor to insert SSH keys into the Butane config.

```bash
$ KEY=$(cat ~/.ssh/id_rsa.pub) yq e '.passwd.users[0].ssh_authorized_keys[0] = strenv(KEY)' ignition.bu | butane --pretty --strict > ignition.json
$
```

## Automatic Upgrades & Reboots

Once the system has been rebased to the container image ([quay.io/miabbott/fcos-image-builder:latest](https://quay.io/repository/miabbott/fcos-image-builder)), the `rpm-ostreed-automatic.timer` will fire regularly and trigger `rpm-ostree upgrade` to run.

If an updated container image is available, the deployment will be staged via `ostree-finalize-staged.service`. On completion of that service, the `post-upgrade-reboot.service` will fire and check if there is an unbooted deployment (which should be the case after an upgrade).  If there is an unbooted deployment, the system reboots.

## TODO

- Ultimately, I hope to have a complete deployment/workflow showing how to build a RHEL for Edge image using Image Builder, along with an e2e story for generating
and managing the ostree updates.
- Work on a more sane image promotion process + old tag pruning
