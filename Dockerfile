FROM alpine:3.22.2

RUN apk add --no-cache \
	subversion==1.14.5-r0 \
	wget==1.25.0-r1

USER svn

EXPOSE 3690

HEALTHCHECK CMD netstat -ln | grep 3690 || exit 1

# mount point that can be used to hold config files common to all svn repos
VOLUME [ "/etc/svnserve" ]

# root path for all repos
VOLUME [ "/var/opt/svn" ]
WORKDIR /var/opt/svn

CMD [ "/usr/bin/svnserve", "--daemon", "--foreground", "--root", "/var/opt/svn" ]
