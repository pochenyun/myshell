#!/bin/bash
# google云盘挂载点
mount="$HOME/Applications/Google Drive"
if [ ! -d "$mount" ]; then
    mkdir -p "$mount"
fi

google-drive-ocamlfuse "$mount"
