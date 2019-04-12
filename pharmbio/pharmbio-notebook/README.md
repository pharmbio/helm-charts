# Pharmbio notebook
A helm chart for deploying on-demand notebooks with access to different services running in the rancher cluster. Meant to be the goto environment when a user wants to interact with these services. See [below](#available-services) for what services are available and how to interact with them.


## Installing the Chart
You can install the Chart via Helm CLI:

    # Make sure pharmbio repo is installed
    helm repo add pharmbio https://pharmbio.github.io/helm-charts/

    # Add and edit your values.yaml file (example below)
    vim myvals.yaml

    # You can create a jupyter-notebook password with the password generator:
    wget https://raw.githubusercontent.com/pharmbio/helm-charts/master/pharmbio/ml-container/jupyter-hashpass-generator.sh
    chmod +x jupyter-hashpass-generator.sh
    ./jupyter-hashpass-generator.sh <my-password>

    # Install chart
    helm install --namespace your-namespace --name my-pharmbio-notebook -f myvals.yaml pharmbio/pharmbio-notebook


### Accessing jupyter notebook

     # Your access url will be:
     https://pharmbio-notebook.<username-from-values-file>.<your-domain>

     # e.g
     https://pharmbio-notebook.myname.k8s-prod.pharmb.io

     # or via kubectl/docker exec method
     kubectl exec -n your-namespace -it pharmbio-notebook-myname bash


### Example values file

```
# Default values for pharmbio-notebook.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

users:
  - student1
  - student2

notebookPasswSha1: "sha1:126256b7627a:408ab6ac552a506d58872aae0ae4386892aa6606"

# image and tag for notebook, multiple tags may exist with different tools preinstalled, check at:
# https://cloud.docker.com/u/pharmbio/repository/docker/pharmbio/notebook-playground
image:
  repository: pharmbio/notebook-playground
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

## Accessing credentials

## Available services
### chembl database
MySQL database with [chembl](https://www.ebi.ac.uk/chembl/), accessible with the commandline tool `mysql` or in python via `pymysql`

Connecting via commandline: 

`mysql -u root -h chembl-mysql -A -p`

This prompts for the password, see [above](#accessing-credentials) for how to get the password, alternatively you can set it as an environment variable and provide it as such:

```
export MYSQL_PASSWORD=<password>
mysql -u root -h chembl-mysql -A -p $MYSQL_PASSWORD
```



