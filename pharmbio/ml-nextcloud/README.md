## Installing the Chart
You can install the Chart via Helm CLI:

    # Make sure pharmbio repo is installed
    helm repo add pharmbio https://pharmbio.github.io/helm-charts/

    # Add and edit your values.yaml file (example below)
    vim ml-nextcloud-myvals.yaml

    # Install chart
    helm install --namespace your-namespace --name ml-nextcloud -f nextcloud-myvals.yaml pharmbio/ml-nextcloud


Accessing jupyter notebook

     # Your access url will be:
     https://nextcloud.<username-from-values-file>.<your-domain>

     # e.g
     https://nextcloud.student1.k8s-prod.pharmb.io


Example values file

```
# Default values for ml-nextcloud.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

users:
  - student1
  - student2

password: easy-peasy

image:
  repository: nextcloud
  tag: 15.0.2-apache
  pullPolicy: Always

resources: {}
  # limits:
  #   cpu: "1"
  #   memory: "1000Mi"
  # requests:
  #   cpu: "100m"
  #   memory: 100Mi

ingress:
  enabled: true
  host: k8s-prod.pharmb.io
```
