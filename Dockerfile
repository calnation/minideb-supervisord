FROM bitnami/minideb:jessie

ENV TINI_VERSION 0.16.1


# Enable https download of packages
RUN install_packages apt-transport-https ca-certificates

# Basic Dependencies
RUN install_packages \
						curl \
						# manage all processes in the container, act as
						# init script, has PID 1 and handles POSIX signals
						supervisor \
						python-setuptools \
						# for automated security updates
						unattended-upgrades \
						# install the tool to rotate logs
						logrotate

# configuring supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf
RUN /usr/bin/easy_install supervisor-stdout \
 && mkdir -p /var/log/supervisor \
 && mkdir -p /var/run/supervisor \
 && chmod 700 /etc/supervisor/supervisord.conf

# apt upgrade configuration
COPY 02periodic /etc/apt/apt.conf.d/02periodic

# Use tini as subreaper to adopt zombie processes & manage graceful exit
RUN curl -L https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static > /usr/bin/tini \
        && chmod +x /usr/bin/tini


ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
