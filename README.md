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

Manually build and test charts
