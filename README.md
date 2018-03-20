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
