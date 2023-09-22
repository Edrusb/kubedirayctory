# kubedirayctory
Ray cluster instantiated from Kubedirectory on Ezmeral Runtime

## Contents
This repo contains 2 components:
- <b>ray cluster</b> docker images and kubedirector yaml definition [Subdirectory Cluster]
- <b>Jupyterlab</b> docker images with the same ray and python version (Ray would complain else) to connect to a remote cluster [Subdirectory Jupyter]

The docker images are published on docker.io/edrusb/ray and docker.io/edrusb/jupyray but you are provided the Dockerfile for each to rebuid trim and adapt those images in their relative directories (adapt the Makefile to your docker repo or container registry)

## Licensing
All code and script provided are released under GPLv3 licensing (see LICENSE file for terms and conditions)

