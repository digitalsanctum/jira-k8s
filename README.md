# jira-k8s

JIRA Version: 7.13.8
PostgreSQL Version: 9.6

## Known Issue

There seems to be a race condition where JIRA attempts to connect to the PostgreSQL container before it's available.

There are two possible workarounds:

1. Delete the JIRA pod after waiting a couple minutes after the `jira-software-db-0` comes up.
2. Add the `--wait` flag to the `helm install` command.

## Add Helm repository

```bash
helm repo add mox https://helm.mox.sh
helm repo update
```

## Add Namespace

```bash
kubectl create ns jira
```

## Install

Update `values.yaml` with values that suit your needs (see https://chartcenter.io/mox/jira-software) then run the following:

```bash
helm install jira mox/jira-software -n jira -f values.yaml
```

Get the URL:

```bash
./url.sh
```

## Uninstall

```bash
helm delete jira -n jira
```

The PostgreSQL PVC will not get automatically delete so:

```bash
kubectl delete -n jira persistentvolumeclaim data-jira-software-db-0
```

where `data-jira-software-db-0` is the PVC.

## Troubleshooting

To get access to JIRA application container:

```bash
kubectl exec -it jira-jira-software-6545f4c998-tclwt -n jira -- /bin/bash
```

where `jira-jira-software-6545f4c998-9nmb7` is JIRA pod.

To get access to the PostgreSQL container:

```bash
kubectl exec -it jira-software-db-0 -n jira -- /bin/bash
```

## References

* https://github.com/bitnami/bitnami-docker-postgresql
* https://github.com/bitnami/charts/tree/master/bitnami/postgresql
* https://chartcenter.io/mox/jira-software