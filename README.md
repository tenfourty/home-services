# Home Services

Repo containing scripts for my home services.

## Jump Server

I'm using Fedora IoT running on a Raspberry Pi 3B+

```
# Install the arm-image-installer package:
sudo dnf install arm-image-installer

# this command gets my machine built with root login only allowed with my ssh password
sudo arm-image-installer --image=Fedora-IoT-[version].raw.xz --target=rpi3 --media=/dev/XXX --addkey --norootpass --relabel --resizefs
```

## QNAP

My NAS. QNAP constantly screw around with their users so I've moved my containers into a VM running on my NAS. Only Plex runs natively using the app downlaed from Plex themselves.

[How to update Plex on the command line using ssh](https://forums.plex.tv/t/howto-update-pms-on-qnap-using-ssh/485831):

Browse to https://www.plex.tv/media-server-downloads/
    Select the relevant QPKG
    Right-Click on the download link, and copy to your clipboard

Open an SSH connection to your QNAP and in the console, type:

```
cd /share/Public
curl <DOWNLOADLINK> --output pms.qpkg
chmod +x pms.qpkg
./pms.qpkg
```

## Container host

I'm using a Rocky Linux 8 VM running on my QNAP.

Setup steps:

From [Using Podman and Docker Compose](https://www.redhat.com/sysadmin/podman-docker-compose):

```
sudo dnf install podman-docker
sudo systemctl start podman.socket
sudo curl -H "Content-Type: application/json" --unix-socket /var/run/docker.sock http://localhost/_ping
```

Install docker-compose following this tutorial - [Install Compose](https://docs.docker.com/compose/install/)

I have the following nfs mounts from my NAS:

```
/Media /mnt/Media
/NextCloud /mnt/NextCloud
/Old_Container /mnt/Container
/QDownload /mnt/QDownload
```

I handle secrets via plaintext files in secrets/ subdirectory (e.g. secrets/myservice.txt) and use [git-crypt](https://github.com/AGWA/git-crypt) to encrypt them. That way, it's easy to add more secrets to the repository, but also only authorized people and the deployment server has access to the files.

```
sudo dnf install git-crypt
git-crypt unlock
```

I'm currently using docker-compose

>docker-compose up -d

And I have the following helper scripts:

`pull-all-containers.sh` - pull all containers and reload the ones that have changed

`restart-all-containers.sh` - restart everything

`plex-restart.sh` - restart plex



