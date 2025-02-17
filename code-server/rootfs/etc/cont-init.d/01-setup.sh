#! /usr/bin/bash

mkdir -p /root/.local/share
mkdir -p /root/.config
mkdir -p /config/code-server/config
mkdir -p /data/local
mkdir -p /data/files

if ! test -f /config/code-server/config/config.yaml; then
  cp /code-server.yaml /config/code-server/config/config.yaml
fi

ln -s /data/local /root/.local/share/code-server
ln -s /config/code-server/config /root/.config/code-server
ln -s /config/code-server/data /root/old
ln -s /data/files /root/data

# Move all files from /config to /data and remove old folder
mv /root/old/* /root/data
rm -rf /config/code-server/data

# Mova all files from /config/code-server/local to /data
mv /config/code-server/local/* /data/local
rm -rf /config/code-server/local

if ! test -d /data/local/User; then
  mkdir -p /data/local/User
fi

if ! test -f /data/local/User/settings.json; then
  echo "{\"workbench.colorTheme\": \"Default Dark+\",\"terminal.integrated.profiles.linux\": {\"bash\": {\"path\": \"bash\",\"icon\": \"terminal-bash\"},\"zsh\": {\"path\": \"zsh\"}},\"terminal.integrated.defaultProfile.linux\": \"zsh\"}" > /data/local/User/settings.json
fi

chmod a+rwx /root/*
chmod a+rwx /data/files
