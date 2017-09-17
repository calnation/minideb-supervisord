This is an image for a small debian-based container. The main idea here is to use `supervisord` (already
set to run with container start) to run any script or process. This is done by passing
the configuration for that process in a `*.conf` file inside `/etc/supervisor/conf.d/`

For example, to run a program:
```
[program:mongo]
command=/opt/mongodb/bin/mongod
redirect_stderr=true
```

The container will also have:
- `curl` to download whatever
- `unattended-upgrades` to automate security updates
- `logrotate` to install the tool to rotate logs
