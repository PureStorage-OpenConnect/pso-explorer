[![Apache License](https://img.shields.io/badge/license-Apache%202-blue.svg)](https://raw.githubusercontent.com/PureStorage-OpenConnect/pso-explorer/master/LICENSE)
[![GitHub Release](https://img.shields.io/github/v/release/PureStorage-OpenConnect/pso-explorer.svg)]()
[![PR's Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat)](http://makeapullrequest.com)

# Pure Service Orchestrator™ eXplorer

<img src="./images/psox_logo.png" width="250">

A unified view into storage, empowering Kubernetes admins and storage admins with 360-degree container storage visibility.

## What is PSO eXplorer?

Pure Service Orchestrator™ eXplorer (or PSO eXplorer) provides a web based user interface for [Pure Service Orchestrator™](https://github.com/purestorage/helm-charts). It shows details of the persistent volumes and snapshots that have been provisioned using PSO, showing provisioned space, actual used space, performance and growth characteristics. The PSO eXplorer dashboard provides a quick overview of the number of volumes, snapshots, storageclasses and arrays in the cluster, in addition to the volume usage, the volume growth over the last 24 hours and cluster-level performance statistics.

## Software Pre-Requisites
- [Kubernetes](https://kubernetes.io/) 1.13+
- [Pure Service Orchestrator™](https://github.com/purestorage/helm-charts) (PSO) 2.x, 5.x and 6.x (the Flex Driver and CSI Driver are both supported)
- [Helm3](https://helm.sh/)

## How to install
Add the PSO eXplorer helm chart repository to your Helm3 repo's:

```bash
helm repo add pso-explorer 'https://raw.githubusercontent.com/PureStorage-OpenConnect/pso-explorer/master/'
helm repo update
helm search repo pso-explorer
```

### Configuration (optional)
You can change the configuraton of the deployment, by downloading the [./pso-explorer/values.yaml](./pso-explorer/values.yaml) file and changing the deployment settings. The following table lists the configurable parameters and their default values.

| Parameter                                      | Description                                                                                                                                                | Default                                       |
|------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| `timeouts.dashboard_refresh`                   | Timeout in seconds for the dashboard view (home view) to refresh (page reload).                                                                            | `60`                                          |
| `timeouts.cache_refresh`                       | Timeout in seconds to clear cache, once this timeout is reached updates will be collected from K8S and the Pure Storage systems                            | `300`                                         |
| `images.webserver.repository`                  | The image repo and name to pull PSO eXplorer webserver from                                                                                                | `quay.io/purestorage/pso-explorer`            |
| `images.webserver.tag`                         | The image tag to pull                                                                                                                                      | `[release version]`                           |
| `images.webserver.pullPolicy`                  | Image pull policy                                                                                                                                          | `Always`                                      |
| `images.redis.repository`                      | The image repo and name to pull redis server from                                                                                                          | `redis`                                       |
| `images.redis.tag`                             | The image tag to pull                                                                                                                                      | `alpine`                                      |
| `images.redis.pullPolicy`                      | Image pull policy                                                                                                                                          | `IfNotPresent`                                |
| `service.type`                                 | The service type used for exposing the webserver, LoadBalancer and ClusterIP are both allowed                                                              | `LoadBalancer`                                |
| `service.port`                                 | TCP port used for exposing the webserver                                                                                                                   | `80`                                          |
| `clusterrolebinding.serviceAccount.name`       | The service account name for the deployment                                                                                                                | `pso-explorer`                                |


## Installation
For security reason, it is strongly recommended to install PSO Explorer in a separate namespace/project. Make sure the namespace is existing, otherwise create it before installing the plugin.

```bash
kubectl create namespace <namespace>
```

### Run the Install

#### Install with default settings

```bash
helm install pso-explorer pso-explorer/pso-explorer --namespace <namespace>
```

#### Install specifying options via the command line

```bash
helm install pso-explorer pso-explorer/pso-explorer --namespace <namespace> --set timeouts.dashboard_refresh=30 --set timeouts.cache_refresh=60
```

#### Install with changed settings (values.yaml)

```bash
helm install pso-explorer pso-explorer/pso-explorer --namespace <namespace> -f <your_own_dir>/yourvalues.yaml
```

The values in your values.yaml overwrite the ones in helm-chart/pso-explorer/values.yaml.

## How to upgrade
To upgrade your existing PSO Exporer installation to a new version, follow these steps:

```bash
helm repo update
helm search repo pso-explorer
```
The search command will return the latest version of the Helm Chart.

If you do not know the Helm deployment name you used to deploy PSO Explorer, use the following:

```bash
helm list -A |grep pso-explorer
```
The first column returned is the Helm deployment name you used and the second column is the namespace PSO Explorer was deployed in.
Now you can run the update as follows:

```bash
helm upgrade pso-explorer -n pso-explorer pso-explorer/pso-explorer
```
Make sure you replace the first occurance of `pso-explorer` with your Helm deployment name and `-n pso-explorer` with the namespace you've deployed PSO Explorer in.

## Using PSO Explorer
To access PSO Explorer, use the following command to reveal the IP address assigned to the service.

```bash
kubectl get service pso-explorer -n <namespace>
```
Now use your web browser to connect to the IP address and port number:
```bash
http://<ip address>:<port>/
