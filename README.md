docker-sickbeard
================

Sickbeard daemon running in a container. The default paths have been altered to:

 * `/config`
 * `/download`
 * `/media`

The `sickbeard` application runs with the HTTP RPC interface listening on TCP port `8081`.

Assumptions
-----------

I use a NAS with a "download" share with the following structure:

  - Download                  - Completed downloads
  - Download\Usenet           - Watch directory for .nzb files
  - Download\Usenet\Working   - Working directory where "in progress" files are located
  - Download\Torrents         - Watch directory for .torrent files
  - Download\Torrents\Working - Working directory where "in progress" files are located

Host directory to container `VOLUME` mapping:

| Host Directory | Container Directory | Comment |
|----------------|---------------------|---------|
| /mnt/download | /download | |
| /etc/docker/sickbeard | /config | |
| /media/television | /media | |
| /etc/localtime | /etc/localtime | Set the container's TZ to match the host |


Quick-start
-----------

Run the command `docker run -d --restart always -h sickbeard --name sickbeard -v /mnt/download:/download -v /etc/docker/sickbeard:/config -v /mnt/media/television:/media -v /etc/localtime:/etc/localtime:ro -p 8081:8081 randomparity/docker-sickbeard:latest

Then open `http://<docker host IP>:8081` in a browser.
