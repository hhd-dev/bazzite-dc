# Bazzite: Director's Cut
Bazzite: Director's Cut is a Bazzite edition based on a stable build of 
bazzite-deck, with an up-to-date Handheld Daemon + other niceties.

Currently, this is the 40-20240427 image which contained the 3.13 gamescope
that was very stable and had touch gesture, XTEST support, VRR support etc.
This meant that the QAM button opens a lot faster and touch gestures work.

Most of the issues with the new gamescope are ironed out, and we are preparing
touch gestures as part of Handheld Daemon.
When that happens, the cherry-picked version of Bazzite will be bumped, and we
keep going as usual.

## Installation Instructions
Run the following command from a Bazzite install:
```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/hhd-dev/bazzite-dc:stable
```