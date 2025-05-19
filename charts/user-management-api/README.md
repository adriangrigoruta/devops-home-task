# user-management-api

A Helm chart for deploying the User Management API on Kubernetes.

## Chart Details
| Name              | Version |
|-------------------|---------|
| Chart version     | 0.1.0   |
| App version       | latest  |

## Introduction
This chart deploys the User Management API, providing endpoints for populating and managing user data. It includes configuration for image settings, environment variables, service account, networking (Service and Ingress), autoscaling, and resource requests/limits.

## Prerequisites
- Kubernetes 1.14+ or higher
- Helm 3+
- A Kubernetes cluster with an Ingress controller (if using `ingress.enabled`)

## Installing the Chart
Add the Helm repository (if published):
```bash
helm repo add my-repo https://example.com/charts
helm repo update
```

Install the chart with the release name `my-release`:
```bash
helm install my-release charts/user-management-api
```
Alternatively, install directly from the local directory:
```bash
helm install my-release ./charts/user-management-api
```
You can specify a namespace:
```bash
helm install my-release ./charts/user-management-api --namespace my-namespace --create-namespace
```

## Uninstalling the Chart
```bash
helm uninstall my-release
# or
helm uninstall my-release --namespace my-namespace
```

## Configuration
The following table lists the configurable parameters of the user-management-api chart and their default values.

| Parameter                                    | Description                                                  | Default                                                                 |
|----------------------------------------------|--------------------------------------------------------------|-------------------------------------------------------------------------|
| `image.repository`                           | Docker image repository                                      | `ghcr.io/adriangrigoruta/devops-home-task`                             |
| `image.pullPolicy`                           | Image pull policy                                            | `IfNotPresent`                                                         |
| `image.tag`                                  | Image tag (defaults to `Chart.appVersion`)                   | `""`                                                                  |
| `imagePullSecrets`                           | Image pull secrets                                           | `[{ name: "ghcr-secret" }]`                                          |
| `serviceAccount.create`                      | Create a service account                                     | `false`                                                                |
| `serviceAccount.name`                        | Name of the service account to use                           | `""`                                                                  |
| `env`                                        | Environment variables for the container                      | See `values.yaml`                                                      |
| `service.type`                               | Kubernetes service type                                      | `ClusterIP`                                                            |
| `service.port`                               | Kubernetes service port                                      | `8000`                                                                 |
| `ingress.enabled`                            | Enable ingress resource                                      | `true`                                                                 |
| `ingress.className`                          | Ingress class name                                           | `nginx`                                                                |
| `ingress.hosts`                              | Ingress hostnames and paths                                  | See `values.yaml`                                                      |
| `ingress.tls`                                | TLS configuration for ingress                                | `[]`                                                                   |
| `resources.requests.cpu`                     | CPU request                                                  | `0.5`                                                                  |
| `resources.requests.memory`                  | Memory request                                               | `512Mi`                                                                |
| `resources.limits.cpu`                       | CPU limit                                                    | `1`                                                                    |
| `resources.limits.memory`                    | Memory limit                                                 | `2G`                                                                   |
| `autoscaling.enabled`                        | Enable Horizontal Pod Autoscaler                             | `true`                                                                 |
| `autoscaling.minReplicas`                    | Minimum number of replicas                                   | `1`                                                                    |
| `autoscaling.maxReplicas`                    | Maximum number of replicas                                   | `2`                                                                    |
| `autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization percentage for autoscaling             | `80`                                                                   |
| `autoscaling.targetMemoryUtilizationPercentage` | Target memory utilization percentage for autoscaling         | `80`                                                                   |
| `nodeSelector`                               | Node labels for pod assignment                               | `{}`                                                                   |
| `tolerations`                                | Tolerations for pods                                         | `[]`                                                                   |
| `affinity`                                   | Affinity settings for pods                                   | `{}`                                                                   |

### Secret Configuration
The deployment expects a Kubernetes secret named `galactic-secrets` with the following keys:
- `DATABASE_URL`: Connection string for the database.
- `AWS_ACCESS_KEY_ID`: AWS access key.
- `AWS_SECRET_ACCESS_KEY`: AWS secret key.

Example:
```bash
kubectl create secret generic galactic-secrets \
  --from-literal=DATABASE_URL='postgres://user:password@host:5432/dbname' \
  --from-literal=AWS_ACCESS_KEY_ID='AKIA...' \
  --from-literal=AWS_SECRET_ACCESS_KEY='...' \
  --namespace my-namespace
```


And also `ghcr-secret` login secret in order to pull image:
```bash 
kubectl create secret docker-registry ghcr-secret \
  --docker-server=https://ghcr.io \
  --docker-username=XXX \
  --docker-password=
```

## Usage
After installing the chart, you can check the status:
```bash
kubectl get all --selector app.kubernetes.io/instance=my-release
```
Follow the instructions provided by Helm notes:
```bash
helm status my-release
```

## Testing
Run the chart tests (if enabled):
```bash
helm test my-release
```

## Rendering Templates
To debug or inspect the rendered templates:
```bash
helm template my-release ./charts/user-management-api
```
