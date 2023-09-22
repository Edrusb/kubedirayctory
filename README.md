# kubedirayctory
Ray cluster instantiated from Kubedirector on HPE Ezmeral Runtime

## Contents
This repo contains 2 components:
- <b>ray cluster</b> docker images and kubedirector yaml definition [Subdirectory Cluster]
- <b>Jupyterlab</b> docker images with the same ray and python version (Ray would complain else) to connect to a remote cluster [Subdirectory Jupyter]

The docker images are published on docker.io/edrusb/ray and docker.io/edrusb/jupyray but you are provided the Dockerfile for each to rebuid trim and adapt those images in their relative directories (adapt the Makefile to your docker repo or container registry)

## Licensing
All codes and scripts are provided under GPLv3 licensing (see LICENSE file for terms and conditions)

## Installation
- upload **Cluster/raycluster.yaml** and **Jupyter/jupyray.yaml** kubedirector cluster definitions to HPE Ezmeral Runtime (for example using the *kubectl* tab in the *Applications* menu)
- From the *kubectl* tab in the GUI, select in turn each yaml file and click the *open* button then the *create* action at the bottom of the page (this will create a new card in the list of available applications)

## Usage
- select the Ray application, provide the resources for the *Head node* (CPU, RAM and eventually GPU) select one or more *Worker node*. There is two types of worker to ease having GPU nodes and non GPU nodes, or any different profile combination of nodes, but all worker (type 1 and type 2) have the exact same role in the Ray Cluster
- wait for the cluster to be created
- go the the **Service Endpoints** tab and open the Ray Dashboard
- use the *connect port* provided URL in your application when calling ray.init() prepending it with "ray://" for example: *ray.init("ray://gateway.ezmeral.hpe.com:10015")*

The provided Jupyterlab is here as demo to play with cluster, launch it as previously seen with the ray cluster.  Once available, you'll find a notebook inside the Jupyter lab to explore Ray Core features. For the *Ray Data*, *Ray Train*, *Ray Tune* and other higher level modules, depending on the tool you plan to use (XGBoost, Pytorch, Ternsorflow, Keras...) you'll probably need to add aditional libraries to Ray cluster's nodes and Jupyter Lab, either deriving the existing Docker images or reuinsing the provided Dockerfile, or even live in the pods (for temporarily testing).
## Optimization and performances
Ray uses /dev/shm directory which is usually a tmpfs filesystem (filesystem in RAM) and expects it to be sized to at least 30% of the total RAM available/visible for the POD (which is what you have specified when you created Ray cluster for the header node, worker-type-1 and worker-type-2). If the /dev/shm is smaller than expected, Ray relies on filesystem instead of memory to store objects which has magnitude less performances (check the ray output in */tmp/ray.log* file in each pod of the ray cluster).

