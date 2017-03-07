#!/bin/bash
docker run --rm centos /bin/bash -c 'if grep -Fq "docker" /proc/1/cgroup; then echo "OK"; else echo "ERROR: Not running in Docker."; fi'
