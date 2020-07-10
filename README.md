# Pure Container Explorer for 

A unified view into container storage, empowering Kubernetes admins and storage admins with 360-degree container storage visibility.

## What is Pure Container Explorer?

Pure Container Explorer provides a web based user interface for [Pure Service Orchestrator PSO](https://github.com/purestorage/helm-charts). It shows details of the persistent volumes and snapshots that have been provisioned using PSO, showing provisioned space, actual used space, performance and growth characteristics. The Pure Container Explorer dashboard provides a quick overview of the number of volumes, snapshots, storageclasses and arrays in the cluster, in addition to the volume usage, the volume growth over the last 24 hours and cluster-level performance statistics.

## Software Pre-Requisites
- [Kubernetes](https://kubernetes.io/) 1.13+
- [Pure Service Orchestrator](https://github.com/purestorage/helm-charts) (PSO) 2.x, 5.x and 6.x (the Flex Driver and CSI Driver are both supported)
- [Helm3](https://helm.sh/)

## How to install
Add the Pure Container Explorer helm chart repository to your Helm3 repo's:

```bash
helm repo add pce-repo 'https://raw.githubusercontent.com/PureStorage-OpenConnect/pure-container-explorer/master/'
helm repo update
helm search repo pure-container-explorer -l
```

### Configuration (optional)
You can change the configuraton of the deployment, by downloading the [./helm-chart/pure-container-explorer/values.yaml](./helm-chart/pure-container-explorer/values.yaml) file and changing the deployment settings. The following table lists the configurable parameters and their default values.

| Parameter                                      | Description                                                                                                                                                | Default                                       |
|------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| `images.webserver.repository`                  | The image repo and name to pull Pure Container Explorer webserver from                                                                                               | `quay.io/purestorage/pure-container-explorer`       |
| `images.webserver.tag`                         | The image tag to pull                                                                                                                                      | `latest`                                      |
| `images.webserver.pullPolicy`                  | Image pull policy                                                                                                                                          | `Always`                                      |
| `images.redis.repository`                      | The image repo and name to pull redis server from                                                                                                          | `redis`                                       |
| `images.redis.tag`                             | The image tag to pull                                                                                                                                      | `alpine`                                      |
| `images.redis.pullPolicy`                      | Image pull policy                                                                                                                                          | `IfNotPresent`                                |
| `service.type`                                 | The service type used for exposing the webserver, LoadBalancer and ClusterIP are both allowed                                                              | `LoadBalancer`                                |
| `service.port`                                 | TCP port used for exposing the webserver                                                                                                                   | `80`                                          |
| `clusterrolebinding.serviceAccount.name`       | The service account name for the deployment                                                                                                                | `pure-container-explorer`                               |


## Installation
For security reason, it is strongly recommended to install Pure Container Explorer in a separate namespace/project. Make sure the namespace is existing, otherwise create it before installing the plugin.

```bash
kubectl create namespace <namespace>
```

###Run the Install

#### Install with default settings

```bash
helm install pure-container-explorer pce-repo/pure-container-explorer --namespace <namespace>
```

#### Install with changed settings (values.yaml)

```bash
helm install pure-container-explorer pce-repo/pure-container-explorer --namespace <namespace> -f <your_own_dir>/yourvalues.yaml
```

The values in your values.yaml overwrite the ones in helm-chart/pure-container-explorer/values.yaml.

## Using Pure Container Explorer
To access Pure Container Explorer, use the following command to reveal the IP address assigned to the service.

```bash
kubectl get service pure-container-explorer -n <namespace>
```
Now use your web browser to connect to the IP address and port number:
```bash
http://<ip address>:<port>/
