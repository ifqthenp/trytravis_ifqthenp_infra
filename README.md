# ifqthenp_infra

| Emoji | Meaning |
| --- | --- |
| :large_blue_diamond: | Main task |
| :large_orange_diamond: | Extra task for self-study |
| :pushpin: | Useful information |
| :checkered_flag: | Homework delimeter |

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

### Testapp connection config

testapp_IP = 35.197.215.51
testapp_port = 9292

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

## Homework 6. Creating GCP VM instances with HashiCorp Packer

### Completed tasks

:large_blue_diamond: Added packer builder template `ubuntu16.json` parameterized with `variables.json`. The latter has been added to `.gitignore` and `variables.json.example` will be pushed to the repo instead of original file with user variables.

To validate the syntax and configuration of a template use `packer validate` command:

```shell
packer validate -var-file=variables.json ubuntu16.json
```

:large_blue_diamond: Extra options for packer builder have been added to `variables.json` file

- disk_type
- disk_size
- network
- tags
- image_description

:large_orange_diamond: Created "baked" `reddit-full` image ready to be used in immutable infrastructure. The `immutable.json` template includes `puma-reddit.service` provisioning file and `puma-reddit_setup.sh` script enabling application to start as `systemd` unit. To build "baked" image using `packer` image run

```shell
packer build immutable.json
```

To create new VM instance based on `reddit-full` image with live reddit application run

```shell
./config-scripts/create-reddit.sh
```

### :pushpin: Useful commands

Copy and execute script using SSH on remote host. This command is handy for puma server deploy when a new VM instance created with `reddit-base` image.

```shell
ssh appuser@< REMOTE_IP > "bash -s" < ./config-scripts/deploy.sh
```

### :pushpin: Useful links

- HashiCorp [Packer tool][6] automates the creation of any type of machine image
- [Puma systemd][7] configuration instructions
- [Creating and Modifying systemd Unit Files][8] by RedHat
- [Immutable Infrastructure tutorial][9] by Digital Ocean

[6]: https://www.packer.io/downloads.html
[7]: https://github.com/puma/puma/blob/master/docs/systemd.md
[8]: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/sect-managing_services_with_systemd-unit_files
[9]: https://www.digitalocean.com/community/tutorials/what-is-immutable-infrastructure
