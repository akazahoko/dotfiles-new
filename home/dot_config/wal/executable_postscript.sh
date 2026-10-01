#!/usr/bin/env bash

awww img $(cat $HOME/.cache/wal/wal) &> /dev/null
wpg -n -s $(cat $HOME/.cache/wal/wal) --backend wal --noterminal &> /dev/null
