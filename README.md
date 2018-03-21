# ifqthenp_infra

## Homework 4. GCP Infrastructure

### SSH aliases

Use this configuration in your `~/.ssh/config` file to gain SSH access
to an inner private network via `bastion` public host.

```shell
Host bastion
    Hostname 35.230.132.206
    User appuser
    ForwardAgent yes
Host someinternalhost
    Hostname 10.154.0.3
    User appuser
    ProxyCommand ssh -qxT bastion nc %h %p
```

Alternative solution: `ProxyCommand ssh -W %h:%p bastion`

### Connection configuration

bastion_IP = 35.230.132.206
someinternalhost_IP = 10.154.0.3

To check  OpenVPN server connection:

```shell
sudo apt-get install openvpn
sudo openvpn --config /path/to/config.ovpn
ssh -i ~/.ssh/appuser appuser@< inner private network IP >
```

## Homework 5. Testapp deploy to GCP

### GCP startup script

Use this script to automate application deployment to GCP using a [local startup script file][1] and [gcloud][2] command-line tool.

```shell
gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--metadata-from-file startup-script=startup_script.sh
```

To deploy application with a remote startup script stored on GCP use [startup-script-url][3].

```shell
gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--scopes storage-ro \
--metadata startup-script-url=gs://otus-devops-storage/startup_script.sh
```

### Firewall rules for puma server

Create a Google Compute Engine [firewall rule][4] using `gcloud` tool.

```shell
gcloud compute firewall-rules create default-puma-server \
--allow tcp:9292 \
--target-tags puma-server
```

Delete Google Compute Engine [firewall rules][5] using `gcloud` tool.

```shell
gcloud compute firewall-rules delete default-puma-server
```

[1]: https://cloud.google.com/compute/docs/startupscript#using_a_local_startup_script_file
[2]: https://cloud.google.com/sdk/gcloud/
[3]: https://cloud.google.com/compute/docs/startupscript#cloud-storage
[4]: https://cloud.google.com/sdk/gcloud/reference/compute/firewall-rules/create
[5]: https://cloud.google.com/sdk/gcloud/reference/compute/firewall-rules/delete
