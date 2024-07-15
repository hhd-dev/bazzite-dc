ARG BAZZITE_TAG=40-20240427

FROM ghcr.io/ublue-os/bazzite-deck:${BAZZITE_TAG}

RUN sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/_copr_hhd-dev-hhd.repo

ARG BAZZITE_TAG
ARG REVISION_ID=6
ARG DC_TAG=dc${BAZZITE_TAG}.${REVISION_ID}
RUN sed -E "s/PRETTY_NAME=\".+\"/PRETTY_NAME=\"Bazzite: Directors Cut (${DC_TAG})\"/" -i /etc/os-release && \
    cat /etc/os-release

RUN rpm-ostree override replace --experimental \
    --from repo=copr:copr.fedorainfracloud.org:hhd-dev:hhd \
    hhd hhd-ui adjustor python-fuse

RUN mkdir -p usr/lib/systemd/system/hhd@.service.d/

COPY ./hhd_override.conf /usr/lib/systemd/system/hhd@.service.d/override.conf
COPY ./bazzite-hardware-setup /usr/libexec/bazzite-hardware-setup
COPY ./device-quirks /usr/share/gamescope-session-plus/device-quirks
RUN systemctl mask power-profiles-daemon.service && \
    systemctl disable power-profiles-daemon.service

LABEL io.artifacthub.package.logo-url=https://raw.githubusercontent.com/ublue-os/bazzite/main/repo_content/logo.png
LABEL io.artifacthub.package.readme-url=https://github.com/hhd-dev/bazzite-dc
LABEL org.opencontainers.image.description="Bazzite: Director's Cut is a Bazzite edition based on a stable build of bazzite-deck, with an up-to-date Handheld Daemon + other niceties."
LABEL org.opencontainers.image.licenses=Apache-2.0
LABEL org.opencontainers.image.version=${DC_TAG}
LABEL org.opencontainers.image.source=https://github.com/hhd-dev/bazzite-dc
LABEL org.opencontainers.image.title=bazzite-dc
LABEL org.opencontainers.image.url=https://github.com/hhd-dev/bazzite-dc
# LABEL org.opencontainers.image.created=<timestamp>
# LABEL org.opencontainers.image.revision=


# NAME="Fedora Linux"
# VERSION="40.20240427.0 (Kinoite)"
# ID=fedora
# VERSION_ID=40
# VERSION_CODENAME=""
# PLATFORM_ID="platform:f40"
# PRETTY_NAME="Fedora Linux 40.20240427.0 (Bazzite)"
# ANSI_COLOR="0;38;2;60;110;180"
# LOGO=fedora-logo-icon
# CPE_NAME="cpe:/o:fedoraproject:fedora:40"
# DEFAULT_HOSTNAME="fedora"
# HOME_URL="https://kinoite.fedoraproject.org"
# DOCUMENTATION_URL="https://docs.fedoraproject.org/en-US/fedora-kinoite/"
# SUPPORT_URL="https://ask.fedoraproject.org/"
# BUG_REPORT_URL="https://pagure.io/fedora-kde/SIG/issues"
# REDHAT_BUGZILLA_PRODUCT="Fedora"
# REDHAT_BUGZILLA_PRODUCT_VERSION=40
# REDHAT_SUPPORT_PRODUCT="Fedora"
# REDHAT_SUPPORT_PRODUCT_VERSION=40
# SUPPORT_END=2025-05-13
# VARIANT="Kinoite"
# VARIANT_ID=kinoite
# OSTREE_VERSION='40.20240427.0'