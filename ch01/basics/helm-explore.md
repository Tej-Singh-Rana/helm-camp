# Helm Pull

- To pull helm chart archive file.
- `helm pull repo/name`.

```
$ helm pull
cassandra/  file://     http://     https://

$ helm repo add cassandra https://charts.bitnami.com/bitnami

$ helm repo list
NAME            URL
cassandra       https://charts.bitnami.com/bitnami

$ helm search repo cassandra
NAME                                    CHART VERSION   APP VERSION     DESCRIPTION
cassandra/cassandra                     6.0.2           3.11.8          Apache Cassandra is a free and open-source dist...
cassandra/airflow                       6.6.1           1.10.12         Apache Airflow is a platform to programmaticall...
cassandra/apache                        7.5.0           2.4.46          Chart for Apache HTTP Server
cassandra/aspnet-core                   0.3.2           3.1.9           ASP.NET Core is an open-source framework create...
cassandra/bitnami-common                0.0.8           0.0.8           Chart with custom templates used in Bitnami cha...
cassandra/common                        0.8.2           0.8.2           A Library Helm Chart for grouping common logic ...
...

$ helm pull cassandra/apache

$ ls
apache-7.5.0.tgz  start.sh

$ helm pull cassandra/tomcat --untar                        # It'll untar the file after download
apache-7.5.0.tgz  start.sh  tomcat

$ helm pull cassandra/zookeeper --version=5.22.1            # For specific version

$ ls
apache-7.5.0.tgz  start.sh  tomcat  zookeeper-5.22.1.tgz
```

# Helm Get

- To get the details about release.
- `helm get all|hooks|manifest|notes|values  release-name`.

```
$ helm status cassandra
NAME: cassandra                                  # Release name
LAST DEPLOYED: Fri Oct 16 19:40:22 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
...

$ helm get
all       hooks     manifest  notes     values

$ helm get all cassandra            # Complete details about release


$ helm get manifest cassandra
---
# Source: apache/templates/svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: cassandra-apache
  labels:
  ...
  
$ helm get values cassandra
USER-SUPPLIED VALUES:
null

$ helm get notes cassandra
NOTES:
** Please be patient while the chart is being deployed **

1. Get the Apache URL by running:
...
```

# Helm Upgrade

- To upgrade the helm release with the new version.
- `helm upgrade <release-name> repo/name  --version <chart-version>`.
- `helm install <new-release-name> repo/name  --version <chart-version>`.
- Adding flag `--version <chart-version>` to install or upgrade into the specific version.

```
$ helm search repo cassandra --versions                # It'll display all the specific versions
NAME                                    CHART VERSION   APP VERSION                             DESCRIPTION
cassandra/redmine                       14.1.21         4.1.1                                   A flexible project management web application.
cassandra/redmine                       14.1.20         4.1.1                                   A flexible project management web application.
cassandra/redmine                       14.1.19         4.1.1                                   A flexible project management web application.
cassandra/redmine                       14.1.18         4.1.1                                   A flexible project management web application.
cassandra/zookeeper                     1.1.1           3.4.12                                  A centralized service for maintaining configura...
cassandra/zookeeper                     1.1.0           3.4.12                                  A centralized service for maintaining configura...
cassandra/zookeeper                     1.0.3           3.4.12                                  A centralized service for maintaining configura...
cassandra/zookeeper                     1.0.2           3.4.12                                  A centralized service for maintaining configura...
...

$ helm install cassandra-power cassandra/zookeeper --version 5.22.1               # To install specific chart version
NAME: cassandra-power
LAST DEPLOYED: Fri Oct 16 20:15:40 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None

$ kubectl get all                                                          # Successfully deployed in the k8s cluster
NAME                              READY   STATUS    RESTARTS   AGE
pod/cassandra-power-zookeeper-0   1/1     Running   0          12m

NAME                                         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE
service/cassandra-power-zookeeper            ClusterIP   10.104.0.199   <none>        2181/TCP,2888/TCP,3888/TCP   12m

NAME                                         READY   AGE
statefulset.apps/cassandra-power-zookeeper   1/1     12m

$ helm upgrade cassandra-power cassandra/zookeeper --version 5.22.0               # Upgrading into the other version so release count will be changed.
Release "cassandra-power" has been upgraded. Happy Helming!
NAME: cassandra-power
LAST DEPLOYED: Fri Oct 16 20:20:15 2020
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None

$ helm list          
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
cassandra-power default         2               2020-10-16 20:20:15.042432786 +0000 UTC deployed        zookeeper-5.22.0        3.6.2

$ helm history cassandra-power           # To get the history of complete release cycle
REVISION        UPDATED                         STATUS          CHART                   APP VERSION     DESCRIPTION
1               Fri Oct 16 20:15:40 2020        superseded      zookeeper-5.22.1        3.6.2           Install complete
2               Fri Oct 16 20:20:15 2020        deployed        zookeeper-5.22.0        3.6.2           Upgrade complete
```


# Helm Rollback

- 
```
```

# Helm History

- To get the history about release.
- `helm history release-name`.

```
$ helm history cassandra
REVISION        UPDATED                         STATUS          CHART           APP VERSION     DESCRIPTION
1               Fri Oct 16 19:40:22 2020        deployed        apache-7.5.0    2.4.46          Install complete

$ helm history cassandra-power               # After upgrade into the different version
REVISION        UPDATED                         STATUS          CHART                   APP VERSION     DESCRIPTION
1               Fri Oct 16 20:15:40 2020        superseded      zookeeper-5.22.1        3.6.2           Install complete
2               Fri Oct 16 20:20:15 2020        deployed        zookeeper-5.22.0        3.6.2           Upgrade complete
```

# Helm Show

- It'll show the all details of the chart individual or complete.
- `helm show readme|values|chart|all repo/name`.

```
$ helm show
all     chart   readme  values

$ helm show readme cassandra/apache
# Apache

The [Apache HTTP Server Project](https://httpd.apache.org/) is an effort to develop and maintain an open-source HTTP server.
...

$ helm show values cassandra/apache
# global:
#   imageRegistry: myRegistryName
#   imagePullSecrets:
#     - myRegistryKeySecretName
...

$ helm show chart cassandra/apache
annotations:
  category: Infrastructure
apiVersion: v1
appVersion: 2.4.46
dependencies:
- name: common
  repository: https://charts.bitnami.com/bitnami
  tags:
  - bitnami-common
  version: 0.x.x
description: Chart for Apache HTTP Server
...
```

# Helm Uninstall

- It'll uninstall the release.
- `--dry-run` & `--keep-history` option available.
- `--keep-history` - remove all associated resources and mark the release as deleted, but retain the release history.

```
$ helm status cassandra
NAME: cassandra
LAST DEPLOYED: Fri Oct 16 19:16:36 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **

$ helm uninstall cassandra --keep-history                       # Delete the release & keep the release records
release "cassandra" uninstalled

$ helm list
NAME    NAMESPACE       REVISION        UPDATED STATUS  CHART   APP VERSION

$ helm list --uninstalled             # To list the uninstalled release history
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
cassandra       default         1               2020-10-16 19:16:36.169454187 +0000 UTC uninstalled     apache-7.5.0    2.4.46

$ helm list --all
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
cassandra       default         1               2020-10-16 19:20:22.323210548 +0000 UTC uninstalled     apache-7.5.0    2.4.46
```

# Helm Plugin

- To install new plugin, uninstall, list and update.
- `helm plugin install|uninstall|list|update plugin-name`.

```
$ helm plugin
install    list       uninstall  update

$ helm plugin list                               # As of now no plugin installed
NAME    VERSION DESCRIPTION

```


# Helm Verify

- To verify newly created/modified charts.
- `helm verify <path-of-chart>`.

```
$ helm verify cassandra
```


**Notes: We can redirect values into the files.**

