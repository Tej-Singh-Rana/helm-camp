# Helm Create

- Creating a helm chart.
- `helm create <chart-name>`.

```
# It'll create a chart directory
$ helm create nginx-deploy

# chart directory
$ ls nginx-deploy/
charts  Chart.yaml  templates  values.yaml

# templates directory
$ ls templates/
deployment.yaml  _helpers.tpl  ingress.yaml  NOTES.txt  serviceaccount.yaml  service.yaml  tests

# tests directory
$ ls tests/
test-connection.yaml
```

# Helm Install

- Deploying a chart.
- `helm install <chart-name> <path-of-chart>`.

```
$ helm install nginx ./nginx-deploy/
NAME: nginx
LAST DEPLOYED: Tue Oct 06 17:12:52 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
First Chart
```

- Deployed in the cluster.

```
$ kubectl get all
NAME                        READY   STATUS    RESTARTS   AGE
pod/nginx-f89759699-87bkt   1/1     Running   0          31m

NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/kubernetes      ClusterIP   10.96.0.1       <none>        443/TCP        43m
service/nginx-service   NodePort    10.105.212.82   <none>        80:30128/TCP   31m

NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx   1/1     1            1           31m

NAME                              DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-f89759699   1         1         1       31m
```

# Helm List

- View the deployed chart.
- **Aliases:** list, ls  **Ex:** `helm ls`.

```
$ helm list
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
nginx   default         1               2020-10-06 17:12:52.041939038 +0000 UTC deployed        nginx-deploy-0.1.0      1.16.0
```

- It creates a `secret` in the cluster.
```
$ kubectl get secret
NAME                          TYPE                                  DATA   AGE
default-token-td8cm           kubernetes.io/service-account-token   3      28m
sh.helm.release.v1.nginx.v1   helm.sh/release.v1                    1      16m
```

# Helm Package

- It'll create an archive file.
- `helm package <path-of-chart> --destination <path-to-save>`.

```
$ helm package ./nginx-deploy/ --destination .
Successfully packaged chart and saved it to: /root/nginx-deploy-0.1.0.tgz

$ ls
nginx-deploy  nginx-deploy-0.1.0.tgz  start.sh
```

# Helm Delete

- Delete the chart.
- `helm delete <chart-name>`.
- **Aliases:** uninstall, del, delete, un **Ex:** `helm del cassandra`.
  
```
$ helm delete nginx
release "nginx" uninstalled
```

# Helm Repo

- Adding repo in the helm. 
- `helm repo add <repo-name> <URL>`.

```
$ helm repo add http://127.0.0.1:8080
```

- Push to chart.

```
$ curl --data-binary "@nginx-deploy-0.1.0.tgz" http://localhost:8080/api/charts
```

- `helm repo update` to update repo to reload the latest changes. Make sure update repo whenever you added new repo in local env.

```
$ helm repo update
```

- To list the repo

```
$ helm repo list
```

# Helm Search 

- To search the repository. 
- `helm search repo <repo-name>/<chart-name>`.

```
$ helm search repo nginx-deploy/nginx-deploy
```

- To search in the helm hub.
- `helm search hub <repo-name>`.

```
# It'll display all repository

$ helm search hub
```

- To view the `repository.yaml` file which containing information of old or new added repository.

```
$ cat /root/.config/helm/repositories.yaml
```

- To view the containing cached repository indexes.

```
$ cat /root/.cache/helm/repository
```

# Remote Helm Repository

- Clone the git repository locally.

```
$ git clone https://github.com/Tej-Singh-Rana/helm-chart.git
```

- Copy the chart archive file into the cloned repo directory and index.

```
$ ls
helm-chart  nginx-deploy  nginx-deploy-0.1.0.tgz  start.sh

$ cp -v nginx-deploy-0.1.0.tgz helm-chart/.
'nginx-deploy-0.1.0.tgz' -> 'helm-chart/./nginx-deploy-0.1.0.tgz'

$ cd helm-chart/

$ pwd
/root/helm-chart

# Generate the index.yaml file which contains the information about packages, version.
$ helm repo index .

$ ls
index.yaml  nginx-deploy-0.1.0.tgz

$ cat index.yaml
apiVersion: v1
entries:
  nginx-deploy:
  - apiVersion: v2
    appVersion: 1.16.0
```

- Git add, commit and push to the github repository.

```
$ git add .

$ git commit -m "Chart package" .

$ git push
```

- Add github repo into the helm repository.

```
$ helm repo add remote-helm https://raw.githubusercontent.com/Tej-Singh-Rana/helm-chart/main
```

- List the helm repo.

```
$ helm repo list
```
