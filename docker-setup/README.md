
# Docker Bash Utilities

This directory contains bash scripts for common Docker management tasks, including installation, cleanup, monitoring, GPU support, and Docker Compose operations. All scripts are tested on Ubuntu 24.04 but should work on most modern Linux distributions.

## Portainer setup
To run the portainer ui for docker management follow the instructions below.  

[portainer docker hub](https://hub.docker.com/r/portainer/portainer-ce)  
[portainer github](https://github.com/portainer/portainer)

```bash
sudo docker volume create portainer_data

sudo docker run -d \
    --name=portainer \
    --restart=unless-stopped \
    -p 8000:8000 \
    -p 9000:9000 \
    -p 9443:9443 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce
```

```bash
# Open in chrome
google-chrome http://localhost:9000
```

## Watchtower setup
To run the watchtower for docker management follow the instructions below.  

[watchtower docs](https://containrrr.dev/watchtower/)  
[watchtower github](https://github.com/containrrr/watchtower)

> Note the offical image nolonger supports latest docker ce apis.  Using this image now `ghcr.io/nicholas-fedor/watchtower:latest`

Using label enabled flag so containers with this label will be checked on
`com.centurylinklabs.watchtower.enable=true`

```bash
sudo docker run -d \
    --name watchtower \
    --restart unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /home/mtnvencenzo/.docker/config.json:/config.json \
    ghcr.io/nicholas-fedor/watchtower:latest --label-enable --cleanup --interval 300
```

Add to .bashrc so acr is logged into when I log in
```bash
az acr login -n acrveceusgloshared001 >> /home/mtnvencenzo/acr_login.log 2>&1
```

Add a cron job so it keeps refreshing the token
```bash
# Open the cron table editor
crontab -e

# Add this to the file
0 */2 * * * az acr login -n acrveceusgloshared001

# View the crontab file
crontab -l
```