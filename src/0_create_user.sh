#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

apt update && apt upgrade
# apt install fontconfig freetype libXfont mesa-libGL mesa-libGLU Xvfb hostname gettext-base libxtst6 libxi6 libxrender1
apt install -y curl gettext net-tools

/usr/sbin/useradd --create-home --home-dir /arcgis --shell /bin/bash arcgis

echo "arcgis soft nofile 65535" >> /etc/security/limits.conf
echo "arcgis hard nofile 65535" >> /etc/security/limits.conf
echo "arcgis soft nproc 25059" >> /etc/security/limits.conf
echo "arcgis hard nproc 25059" >> /etc/security/limits.conf

apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
