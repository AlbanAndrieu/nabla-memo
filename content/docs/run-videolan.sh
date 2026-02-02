#!/bin/bash
set -xv
vlc --open http://mafreebox.freebox.fr/freeboxtv/playlist.m3u
pip install -U yturl
vlc "$(yturl 'https://www.youtube.com/watch?v=aKflhTrRh2k')"
