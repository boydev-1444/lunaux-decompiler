#!/bin/bash
cd "$(dirname "$0")"
gnome-terminal -- bash -c "python3 main.py; exec bash"