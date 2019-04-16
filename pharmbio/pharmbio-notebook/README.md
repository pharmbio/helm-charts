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

### Settings for notebook deployment
The following values can be configured in the `values.yaml` file, or set as command line arguments for helm with `--set <parameter>=<value>`:

**_Note!_** If the given tag has no GPU support and you don't enable TensorFlow support, python will exit when trying to import tensorflow, even if it seems to be installed. Enable TF support to run TF on CPU if GPU's are not used.


| Parameter                   | Description              | Default                      |
|-----------------------------|--------------------------|------------------------------|
| `users`                     | Users in notebook        | `{pharmbio-user}`            |
| `notebookPasswSha1`         | Notebook password hash   | `nil`                        |
| `image.repository`          | Image docker repo        | `pharmbio/pharmbio-notebook` |
| `*.tag`                     | Image tag                | `latest`                     |
| `*.pullPolicy`              | Image pull policy        | `Always`                     |
| `resources.limits.cpu`      | Cpu limit                | `4`                          |
| `*.*.memory`                | Memory limit             | `4000Mi`                     |
| `*.requests.cpu`            | Minimum cpu              | `1`                          |
| `*.*.memory`                | Minimum memory           | `1000Mi`                     |
| `gpuAccess.enabled`         | Gpu access available     | `false`                      |
| `*.gpus`                    | Number of gpus           | `0`                          |
| `tfSupport.enabled`         | Support for TensorFlow   | `true`                       |
| `secrets.secretsPath`       | Secrets path in notebook | `/credentials`               |
| `*.secretNames`             | Secrets to mount         | _see values.yaml_            |
| `ingress.enabled`           | Ingress to notebook      | `true`                       |
| `*.host`                    | Ingress hostname         | `k8s-prod.pharmb.io`         |

Refer to the yaml file for more detailed descriptions of some of the fields.


### Accessing jupyter notebook

     # Your access url will be:
     https://pharmbio-notebook.<username-from-values-file>.<your-domain>

     # e.g
     https://pharmbio-notebook.myname.k8s-prod.pharmb.io

     # or via kubectl/docker exec method
     kubectl exec -n your-namespace -it pharmbio-notebook-myname bash




## Accessing credentials
Secret will be mounted at the location specified in the values file, and can be accessed like this

```cat /credentials/<secret-name>/<secret key>```

, which will print the value of `<secret key>`. You can describe secrets in kubectl with `kubectl describe secret <name>`, provided you have access, to see what keys are available.

In the _pharmbio/pharmbio-notebook_ container images, there will also be both a notebook and python script which can print the contents of all mounted secrets.

## Available services
### Chembl database
MySQL database with [chembl](https://www.ebi.ac.uk/chembl/), accessible with the commandline tool `mysql` or in python via `pymysql`

Connecting via commandline:

`mysql -u root -h chembl-mysql -A -p`

This prompts for the password, see [above](#accessing-credentials) for how to get the password, alternatively you can set it as an environment variable and provide it as such:

```
export MYSQL_PASSWORD=<password>
mysql -u root -h chembl-mysql -A -p $MYSQL_PASSWORD
```

### Pachyderm
Pachyderm can be interacted with either via pachctl or via python client.

To use pachctl, first set the ADDRESS environment variable with

```export ADDRESS=pachd.labinf.svc.cluster.local:650```

For using the python client, the host is `pachd.labinf.svc.cluster.local` and port 650. See https://github.com/pachyderm/python-pachyderm/blob/master/examples/opencv.py for a simple example of usage

### Minio s3 storage
Currently there is a Minio S3 server hosted in the cluster, with a volume on the NFS. This can for example be accessed via the aws commandline client. First you'll need to set the minio credentials to environment variables, which can be done by sourcing this convenient script (provided you mounted the secret called _minio_):

```source /home/source_minio_credentials.rc```

, which sets the environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY. Then you can interact with minio (or any other S3 storage if you provide you own credentials and endpoint) like this:


```aws s3 --endpoint minio.labinf.svc.cluster.local:9000 <command...>```

Refer to `aws s3 help` and/or the [aws documentation](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html) for more help on connecting