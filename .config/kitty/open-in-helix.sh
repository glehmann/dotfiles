#!/bin/bash

zellij action toggle-floating-panes
zellij action write-chars $':o \e[200~'"$1"$'\e[201~'
zellij action write 13
