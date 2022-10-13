# Fedora CoreOS with Image Builder layer

[![quay.io repository](https://img.shields.io/badge/updated-2022--10--11-green)](https://quay.io/repository/miabbott/fcos-image-builder)

This is builds a version of Fedora CoreOS using the [ostree native container](https://fedoraproject.org/wiki/Changes/OstreeNativeContainer)
features.

The GitHub workflow generates a new container image weekly. (See <https://github.com/jlebon/pet> for inspiration)

The customizations in the Containerfile enable the `rpm-ostreed-automatic.timer` which will cause the system to automatically update when a new container image is available.
The reboot logic is handled by a custom service that fires after the completion of the `ostree-finalize-staged.service`.
Currently there is no protection for any workloads running on the system, so the reboot could be harmful.

## Initialization

This assumes you have booted a vanilla Fedora CoreOS image using the provided Butane -> Ignition config to disable `zincati` and rebase to the layered image.

I used `yq` as a cheap YAML editor to insert SSH keys into the Butane config.

```bash
$ KEY=$(cat ~/.ssh/id_rsa.pub) yq e '.passwd.users[0].ssh_authorized_keys[0] = strenv(KEY)' ignition.bu | butane --pretty --strict > ignition.json
$
```

## TODO

- Ultimately, I hope to have a complete deployment/workflow showing how to build a RHEL for Edge image using Image Builder, along with an e2e story for generating
and managing the ostree updates.
- Work on a more sane image promotion process + old tag pruning
