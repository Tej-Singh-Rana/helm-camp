# Helm Pull

- To pull archive file.
- 'helm pull repo/name`.

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

$ helm pull cassandra/tomcat --untar                        # It'll untar the file after download.
apache-7.5.0.tgz  start.sh  tomcat

$ helm pull cassandra/zookeeper --version=5.22.1            # For specific version.

$ ls
apache-7.5.0.tgz  start.sh  tomcat  zookeeper-5.22.1.tgz
```

# Helm Get

```
$ helm get
all       hooks     manifest  notes     values

```

# Helm Upgrade

```
```


# Helm Rollback

```
```

# Helm History

```
```

# Helm Show

- It'll show the all details of the chart individual or complete.
- `helm show readme|values|chart|all repo/name`

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

$ helm uninstall cassandra --keep-history                       # Delete the release & keep the release records.
release "cassandra" uninstalled

 $ helm list
NAME    NAMESPACE       REVISION        UPDATED STATUS  CHART   APP VERSION

$ helm list --uninstalled
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
cassandra       default         1               2020-10-16 19:16:36.169454187 +0000 UTC uninstalled     apache-7.5.0    2.4.46
```

# Helm Plugin



# Helm Verify
