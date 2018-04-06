#!/usr/bin/env bash

gcloud compute instances create reddit-full-instance \
--boot-disk-size=10GB \
--image-family reddit-full \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure
