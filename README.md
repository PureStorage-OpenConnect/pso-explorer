# Pure Service Orchestrator (PSO) Analytics GUI

## What is PSO Analytics GUI?
PSO Analytics GUI provides a web based GUI for [Pure Storage PSO](https://github.com/purestorage/helm-charts). It shows details of the volumes that have been provisioned using PSO. 
The PSO Analytics GUI dashboard provides a quick overview of the number of volumes, storageclasses, statefulsets and arrays in addition to actual volume usage (in addition to the provisioned size), the volume growth over the last 24 hours and performance statistics.

## Software Pre-Requisites
- Kubernetes 1.13+
- Pure Service Orchestrator (PSO) 2.x, 5.x and 6.x (the Flex Driver and CSI Driver are supported)

## How to install
Add the PSO Analytics GUI helm repo

```bash
helm repo add pso-analytics 'https://raw.githubusercontent.com/PureStorage-OpenConnect/pso-analytics-gui/master/'
helm repo update
helm search repo pso-analytics-gui -l
```

### Configuration (optional)
You can change the configuraton of the deployment, by downloading the [./helm-chart/pso-analytics-gui/values.yaml](./helm-chart/pso-analytics-gui/values.yaml) file and changing the deployment settings. The following table lists the configurable parameters and their default values.

| Parameter                                      | Description                                                                                                                                                | Default                                       |
|------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| `images.webserver.repository`                  | The image repo and name to pull PSO Analytics webserver from                                                                                               | `quay.io/purestorage/pso-analytics-gui`       |
| `images.webserver.tag`                         | The image tag to pull                                                                                                                                      | `latest`                                      |
| `images.webserver.pullPolicy`                  | Image pull policy                                                                                                                                          | `Always`                                      |
| `images.redis.repository`                      | The image repo and name to pull redis server from                                                                                                          | `redis`                                       |
| `images.redis.tag`                             | The image tag to pull                                                                                                                                      | `alpine`                                      |
| `images.redis.pullPolicy`                      | Image pull policy                                                                                                                                          | `IfNotPresent`                                |
| `service.type`                                 | The service type used for exposing the webserver, LoadBalancer and ClusterIP are both allowed                                                              | `LoadBalancer`                                |
| `service.port`                                 | TCP port used for exposing the webserver                                                                                                                   | `80`                                          |
| `clusterrolebinding.serviceAccount.name`       | The service account name for the deployment                                                                                                                | `pso-analytics`                               |


## Installation
For security reason, it is strongly recommended to install PSO Analytics in a separate namespace/project. Make sure the namespace is existing, otherwise create it before installing the plugin.

```bash
kubectl create namespace <namespace>
```

###Run the Install

#### Install with default settings

```bash
helm install pso-analytics-gui pso-analytics/pso-analytics-gui --namespace <namespace>
```

#### Install with changed settings (values.yaml)

```bash
helm install pso-analytics-gui pso-analytics/pso-analytics-gui --namespace <namespace> -f <your_own_dir>/yourvalues.yaml
```

The values in your values.yaml overwrite the ones in helm-chart/pso-analytics-gui/values.yaml.

## Using PSO Analytics GUI
To access PSO Analytics GUI, use the following command to reveal the IP address assigned to the service.

```bash
kubectl get service pso-analytics-gui -n <namespace>
```
Now use a browser to connect to the IP address and port number:
```bash
http://<ip address>:<port>/
