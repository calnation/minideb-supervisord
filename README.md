Extends [bitnami's minideb](https://github.com/bitnami/minideb)

## Goal
Standardized extensibility for production-environment containers by:
* Utilizing `supervisord` (set to run with container's start) to run any script or process by passing
the configuration for that process in a `*.conf` file inside `/etc/supervisor/conf.d/`

For example, to run a program:
```
[program:mongo]
command=/opt/mongodb/bin/mongod
redirect_stderr=true
```

* Using `envsubst` to inject runtime environment variables into configuration files 

## Additional Features
- `unattended-upgrades` already automating security updates
- `logrotate` to rotate logs. Just add `logrotate` configuration for your processes under `/etc/logrotate.d/`
