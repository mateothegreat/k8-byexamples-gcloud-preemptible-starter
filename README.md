
## Install

```sh
$ make install

[ INSTALLING MANIFESTS/CONFIGMAP.YAML ]: configmap "gcloud-config" created
[ INSTALLING MANIFESTS/CRONJOB.YAML ]: cronjob "gcloud-preemptible-starter" created

yomateod@DESKTOP-SR72DSK:/mnt/c/workspace/k8-byexamples-gcloud-job$ kubectl get cronjob
NAME                         SCHEDULE      SUSPEND   ACTIVE    LAST SCHEDULE   AGE
gcloud-preemptible-starter   */5 * * * *   False     0         <none>

yomateod@DESKTOP-SR72DSK:/mnt/c/workspace/k8-byexamples-gcloud-job$ kubectl logs -f po/gcloud-preemptible-starter-84d469bfb9-28m7f
lrwxrwxrwx    1 root     root            27 Feb 21 07:46 /config/service_account.json -> ..data/service_account.json
Activated service account credentials for: [k8-gcloud@streaming-platform-devqa.iam.gserviceaccount.com]
Starting instance(s) centos-1...
.done.
Updated [https://www.googleapis.com/compute/v1/projects/streaming-platform-devqa/zones/us-central1-a/instances/centos-1]
```

## Test
```sh
$ make test

docker run -i   -v /c/workspace/k8-byexamples-gcloud-job/config:/config \
                                        --rm            \
                                        google/cloud-sdk:183.0.0-alpine         \
                                /bin/sh -c 'gcloud auth activate-service-account --key-file /config/service_account.json && gcloud compute instances start centos-1 --project $(PROJECT) --zone $(ZONE)'

Activated service account credentials for: [k8-gcloud@streaming-platform-devqa.iam.gserviceaccount.com]

Starting instance(s) centos-1...
.done.

Updated [https://www.googleapis.com/compute/v1/projects/streaming-platform-devqa/zones/us-central1-a/instances/centos-1].

```