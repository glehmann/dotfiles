# dotfiles

Just my dotfiles, to easily share them between several hosts, but you may find them useful as an example.

## Install

~~~bash
sudo dnf config-manager addrepo -y --from-repofile=https://download.opensuse.org/repositories/home:TheLocehiliosan:yadm/Fedora_Rawhide/home:TheLocehiliosan:yadm.repo y
sudo apt install -y yadm
yadm clone https://github.com/glehmann/dotfiles.git
yadm bootstrap
~~~
