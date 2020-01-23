# Start with:
# docker run -d --restart=always --name icaclient z3dm4n/icaclient
# ssh -X ff@$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' icaclient)

FROM ubuntu:latest
MAINTAINER z3dm4n

ENV LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp/install
ADD icaclient_19*.deb icaclient.deb
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install firefox openssh-server libwebkit2gtk-4.0-37 libgtk2.0-0 libxmu6 libxpm4
RUN dpkg -i icaclient.deb
RUN apt-get -y clean

RUN ln -s /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts/
RUN c_rehash /opt/Citrix/ICAClient/keystore/cacerts/
RUN cp /opt/Citrix/ICAClient/nls/en.UTF-8/eula.txt /opt/Citrix/ICAClient/nls/en/
RUN echo 'pref("plugin.state.npica", 2);' > /usr/lib/firefox/defaults/pref/icaclient.js
RUN mkdir /var/run/sshd
RUN echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config
RUN echo 'X11UseLocalhost no' >> /etc/ssh/sshd_config
RUN sed -i '1iauth sufficient pam_permit.so' /etc/pam.d/sshd

RUN useradd -ms /home/ff/ff.sh ff
USER ff
WORKDIR /home/ff
RUN echo "#!/bin/bash" > ff.sh
RUN echo "firefox --new-instance \$*" >> ff.sh
RUN chmod +x ff.sh
RUN mkdir .ICAClient
ADD wfclient.ini /home/ff/.ICAClient/wfclient.ini

USER root
CMD /usr/sbin/sshd -D
