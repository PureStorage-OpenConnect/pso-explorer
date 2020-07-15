# Pure Service Orchestrator Explorer

A unified view into storage, empowering Kubernetes admins and storage admins with 360-degree container storage visibility.

## What is PSO Explorer?

Pure Service Orchestrator Explorer (or PSO Explorer) provides a web based user interface for [Pure Service Orchestrator™ PSO](https://github.com/purestorage/helm-charts). It shows details of the persistent volumes and snapshots that have been provisioned using PSO, showing provisioned space, actual used space, performance and growth characteristics. The PSO Explorer dashboard provides a quick overview of the number of volumes, snapshots, storageclasses and arrays in the cluster, in addition to the volume usage, the volume growth over the last 24 hours and cluster-level performance statistics.

## Software Pre-Requisites
- [Kubernetes](https://kubernetes.io/) 1.13+
- [Pure Service Orchestrator](https://github.com/purestorage/helm-charts) (PSO) 2.x, 5.x and 6.x (the Flex Driver and CSI Driver are both supported)
- [Helm3](https://helm.sh/)

## How to install
Add the PSO Explorer helm chart repository to your Helm3 repo's:

```bash
helm repo add pure-explorer 'https://raw.githubusercontent.com/PureStorage-OpenConnect/pso-explorer/master/'
helm repo update
helm search repo pure-explorer -l
```

### Configuration (optional)
You can change the configuraton of the deployment, by downloading the [./helm-chart/pso-explorer/values.yaml](./helm-chart/pso-explorer/values.yaml) file and changing the deployment settings. The following table lists the configurable parameters and their default values.

| Parameter                                      | Description                                                                                                                                                | Default                                       |
|------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| `images.webserver.repository`                  | The image repo and name to pull PSO Explorer webserver from                                                                                               | `quay.io/purestorage/pso-explorer`       |
| `images.webserver.tag`                         | The image tag to pull                                                                                                                                      | `latest`                                      |
| `images.webserver.pullPolicy`                  | Image pull policy                                                                                                                                          | `Always`                                      |
| `images.redis.repository`                      | The image repo and name to pull redis server from                                                                                                          | `redis`                                       |
| `images.redis.tag`                             | The image tag to pull                                                                                                                                      | `alpine`                                      |
| `images.redis.pullPolicy`                      | Image pull policy                                                                                                                                          | `IfNotPresent`                                |
| `service.type`                                 | The service type used for exposing the webserver, LoadBalancer and ClusterIP are both allowed                                                              | `LoadBalancer`                                |
| `service.port`                                 | TCP port used for exposing the webserver                                                                                                                   | `80`                                          |
| `clusterrolebinding.serviceAccount.name`       | The service account name for the deployment                                                                                                                | `pso-explorer`                               |


## Installation
For security reason, it is strongly recommended to install PSO Explorer in a separate namespace/project. Make sure the namespace is existing, otherwise create it before installing the plugin.

```bash
kubectl create namespace <namespace>
```

###Run the Install

#### Install with default settings

```bash
helm install pure-explorer pure-explorer/pso-explorer --namespace <namespace>
```

#### Install with changed settings (values.yaml)

```bash
helm install pure-explorer pure-explorer/pso-explorer --namespace <namespace> -f <your_own_dir>/yourvalues.yaml
```

The values in your values.yaml overwrite the ones in helm-chart/pso-explorer/values.yaml.

## Using PSO Explorer
To access PSO Explorer, use the following command to reveal the IP address assigned to the service.

```bash
kubectl get service pso-explorer -n <namespace>
```
Now use your web browser to connect to the IP address and port number:
```bash
http://<ip address>:<port>/
