#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket

#### Make `ucore-brew` package additions

# Add Homebrew to `ucore`
# Add Packages repo
dnf5 -y copr enable ublue-os/packages
# Install Homebrew
dnf5 -y install ublue-brew
# Ensure appropriate permissions for Homebrew
chown -R core "/var/home/linuxbrew/*"
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable ublue-os/packages

#### Make `ucore-brew` Systemd modifications (using example from Bluefin)
#### https://github.com/ublue-os/bluefin/blob/5d0b3e67601f87fd3435f39c79d0582a299e566a/build_files/base/17-cleanup.sh#L18-L20

systemctl enable brew-setup.service
systemctl enable brew-upgrade.timer
systemctl enable brew-update.timer
