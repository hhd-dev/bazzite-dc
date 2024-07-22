ARG BAZZITE_TAG=40-20240427

FROM ghcr.io/ublue-os/bazzite-deck:${BAZZITE_TAG}

ARG BAZZITE_TAG
ARG REVISION_ID=8   
ARG DC_TAG=dc${BAZZITE_TAG}.${REVISION_ID}

# Cache invalidate on revision change
RUN sed -E "s/PRETTY_NAME=\".+\"/PRETTY_NAME=\"Bazzite: Directors Cut (${DC_TAG})\"/" -i /etc/os-release && \
    cat /etc/os-release

RUN sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/_copr_hhd-dev-hhd.repo && \
    rpm-ostree override remove tuned tuned-ppd tuned-utils tuned-gtk \
        tuned-profiles-cpu-partitioning tuned-profiles-atomic && \
    rpm-ostree install power-profiles-daemon && \
    rpm-ostree override replace --experimental \
        --from repo=copr:copr.fedorainfracloud.org:hhd-dev:hhd \
        hhd hhd-ui adjustor python-fuse

COPY ./hhd_override.conf ./bazzite-hardware-setup ./device-quirks /tmp/
RUN \
    mkdir -p usr/lib/systemd/system/hhd@.service.d/ && \
    mv /tmp/hhd_override.conf /usr/lib/systemd/system/hhd@.service.d/override.conf && \
    mv /tmp/bazzite-hardware-setup /usr/libexec/bazzite-hardware-setup && \
    mv /tmp/device-quirks /usr/share/gamescope-session-plus/device-quirks && \
    systemctl mask power-profiles-daemon.service && \
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