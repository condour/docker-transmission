# transmission container
# VERSION               0.0.4
FROM angelrr7702/ubuntu-13.10-sshd
MAINTAINER Angel Rodriguez  "angelrr7702@gmail.com"
RUN echo "deb http://archive.ubuntu.com/ubuntu saucy-backports main restricted universe" >> /etc/apt/sources.list
ENV DEBIAN_FRONTEND noninteractive
ENV USER_T guest
ENV PASSWD_T guest
RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get install -y -q transmission-daemon supervisor
ADD settings.json /var/lib/transmission-daemon/info/settings.json
ADD foreground.sh /etc/transmission-daemon/foreground.sh
RUN chmod 755 /etc/transmission-daemon/foreground.sh
ADD start.sh /start.sh
RUN chmod 755 /start.sh
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 9091 22
CMD ["/bin/bash", "-e", "/start.sh"]