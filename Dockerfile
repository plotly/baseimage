FROM ubuntu:14.04
MAINTAINER Jun HU <junhufr@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y openssh-server sudo supervisor
RUN apt-get autoremove && apt-get autoclean
RUN mkdir /var/run/sshd

RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22 9010
CMD ["/usr/bin/supervisord"]
