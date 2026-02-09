#!/bin/bash
set -xv

# Perf testing pyroscope
# https://github.com/grafana/pyroscope

# brew install pyroscope-io/brew/pyroscope
# pyroscope server
docker pull grafana/pyroscope:latest

# ERROR pkg/agent/ebpfspy/session_linux.go:297:12: pattern bpf/profile.bpf.o: no matching files found

# See http://localhost:4040/?

exit 0
