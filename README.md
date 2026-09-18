# About this fork

See [this issue](https://github.com/timothystewart6/k3s-ansible/issues/667) for where this comes from. This updates a few versions:
- k3s to v1.34.2+k3s1 (also tested with v1.35.0+k3s1 and v1.36.0+k3s1)
- Calico to v3.31.0 (also tested with v3.32.0)
- Cilium to v1.18.5 (also tested with v1.19.0 and v1.19.4)
- All playbooks have been modified to reflect this and are working.
- Small disclaimer: the original playbook was tested for Debian, Ubuntu and Rocky. I use Ubuntu 24.04 / 26.04 usually, but it works with Rocky 10, Alma 10 and Debian 13. If you're using (minimal) cloud-init style images for Rocky 10 and Alma 10 you'll need to install extra kernel modules; you can do so by running `sudo dnf install -y kernel-modules kernel-modules-extra` followed by `sudo reboot` and `sudo modprobe br_netfilter` before running the whole playbook. More about that can be found on [this page](https://forums.rockylinux.org/t/docker-installation-failed-on-rhel-10/20024).

See the [readme](https://github.com/marooncap/k3s-ansible/blob/master/README.md) in the original repo for more information.

# Branches
There is another branch with an added feature of deploying Longhorn in your cluster as part of the playbook, which can be convenient. You can check it out [here](https://github.com/panoptikoe/k3s-ansible/tree/longhorn).

# Example deployments
If you're looking for some examples of stuff to run on K3S in a homelab setting, you can check out my [other repo](https://github.com/panoptikoe/homelabexamples).

## Thanks 🤝

This repo is really standing on the shoulders of giants. Thank you to all those who have contributed and thanks to these repos for code and ideas:

- [k3s-io/k3s-ansible](https://github.com/k3s-io/k3s-ansible)
- [geerlingguy/turing-pi-cluster](https://github.com/geerlingguy/turing-pi-cluster)
- [212850a/k3s-ansible](https://github.com/212850a/k3s-ansible)
- [timothystewart6/k3s-ansible](https://github.com/timothystewart6/k3s-ansible)
