## Installing the Chart
You can install the Chart via Helm CLI:

    # Make sure pharmbio repo is installed
    helm repo add pharmbio https://pharmbio.github.io/helm-charts/

    # Add and edit your values.yaml file (example below)
    vim ml-container-myvals.yaml
    
    # You can create a jupyter-notebook password with the password generator:
    wget https://raw.githubusercontent.com/pharmbio/helm-charts/master/pharmbio/ml-container/jupyter-hashpass-generator.sh 
    chmod +x jupyter-hashpass-generator.sh
    ./jupyter-hashpass-generator.sh <my-password>

    # Install chart 
    helm install --namespace your-namespace --name my-ml-container -f ml-container-myvals.yaml pharmbio/ml-container


Accessing jupyter notebook

     # Your access url will be:
     https://notebook.<username-from-values-file>.<your-domain>

     # e.g
     https://notebook.student1.k8s-prod.pharmb.io
     
     # or via kubectl/docker exec method
     kubectl exec -n your-namespace -it my-ml-container bash


Example values file

```
# Default values for ml-container.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

users:
  - student1
  - student2

notebookPasswSha1: "sha1:126256b7627a:408ab6ac552a506d58872aae0ae4386892aa6606"

image:
  repository: pharmbio/ml-container
  tag: master
  pullPolicy: Always

resources: {}
  # limits:
  #  cpu: "4"
  #  memory: 8000Mi
  #  nvidia.com/gpu: "1"
  #  memory: 128Mi
  # requests:
  #  cpu: "2"
  #  memory: 4000Mi
  #  nvidia.com/gpu: "1"

ingress:
  enabled: true
  host: k8s-prod.pharmb.io
```
