FROM randomparity/docker-supervisor:latest

MAINTAINER David Christensen <randomparity@gmail.com>

ENV LAST_UPDATE_SICKBEARD 2015-01-16

# Install prerequisites and clone the SickBeard repository
RUN apt-get -qy install python-cheetah && \
    mkdir /opt/sickbeard && \
    git clone https://www.github.com/midgetspy/Sick-Beard.git /opt/sickbeard && \
    chown -R $BASE_USER:$BASE_GROUP /opt/sickbeard

# We've got everything we need so clear out the apt data
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*

VOLUME ["/config", "/download", "/media"]

EXPOSE 8081

# Copy the supervisord configuration files into the container
COPY sickbeard.conf /etc/supervisor/conf.d/sickbeard.conf
RUN echo "user=$BASE_USER" >> /etc/supervisor/conf.d/sickbeard.conf

# No need to setup a CMD directive since that was handled in the FROM container.

