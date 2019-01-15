This repository contains Helm packages that are maintained by pharmbio. The packages are hosted by GitHub pages, and a fully automated release of charts is provided using Travis CI.

[![Build Status](https://travis-ci.com/pharmbio/helm-charts.svg?branch=master)](https://travis-ci.com/pharmbio/helm-charts)

## Getting started

To be able to deploy Helm charts from this repository, you should first run the following command:

```console
$ helm repo add pharmbio https://pharmbio.github.io/helm-charts/
```

Test deploy a chart
```
$ helm install --name cheese --set domain=your.domain.name pharmbio/cheese
```

### Manually build and test charts

https://docs.helm.sh/chart_best_practices/

    
    # charts root dir
    cd pharmbio/

    # Create skeleton chart
    helm create testchart
    
    # lint
    helm lint ./testchart
    
    # test-install
    helm install --name test --namespace test --dry-run --debug ./testchart
    
    # install
    helm install --name test --namespace test ./testchart
    
    # delete
    helm delete --purge
    
    # update deps (if there are any)
    helm dep update ./testchart
    
    # build package (for testing)
    helm package ./testchart
    
    # test install package
    helm install --dry-run testchart-0.1.0.tgz
    
    # commit and push branch to publish changes on pharmbio chart-repo
    git .......


