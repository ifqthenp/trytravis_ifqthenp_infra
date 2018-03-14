# ifqthenp_infra

### SSH alias for Homework 4
Use this configuration in your `~/.ssh/config` file to gain SSH access
to an inner private network via `bastion` public host.
```
Host bastion
	Hostname <bastion_host_name>
	User <username1>
	ForwardAgent yes
Host someinternalhost
	Hostname <private_host_name>
	User <username1>
	ProxyCommand ssh -qxT bastion nc %h %p
```
Alternative solution: `ProxyCommand ssh -W %h:%p bastion`
