# dotfiles

Just my dotfiles, to easily share them between several hosts, but you may find them useful as an example.

## Install

### Fedora

~~~bash
sudo dnf config-manager addrepo -y --from-repofile=https://download.opensuse.org/repositories/home:TheLocehiliosan:yadm/Fedora_Rawhide/home:TheLocehiliosan:yadm.repo y
sudo apt install -y yadm
yadm clone https://github.com/glehmann/dotfiles.git
~~~

### Alpine

The user should be already created and have `sudo` access (`adduser x && adduser x wheel`).

~~~bash
sudo apk add yadm
yadm clone https://github.com/glehmann/dotfiles.git
~~~

### Debian/Ubuntu

~~~bash
sudo apt update
sudo apt install -y yadm
yadm clone https://github.com/glehmann/dotfiles.git
~~~
