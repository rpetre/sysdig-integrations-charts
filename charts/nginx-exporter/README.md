# Nginx integration
This helm chart is part of the [integration of PromCat.io for Nginx](https://promcat.io/apps/nginx) and installs our version of the [nginx Prometheus exporter](https://github.com/nginxinc/nginx-prometheus-exporter).

Visit [PromCat.io](https://promcat.io/apps/nginx) for dashboards, alerts and further documentation for this integration. 

# Requirements
* Helm v3

# Usage

Use the following options: 
```
helm template nginx ./charts/nginx-exporter
```

## Sysdig configuration

If you want to apply Sysdig configuration to these helm commands, add these other params to each helm command:

```
helm template nginx ./charts/nginx-exporter --set sysdig.integrationType="nginx"
```

- IntegrationType is the name of the integration

# Attributions
This helm chart is maintained by [Sysdig team](https://sysdig.com/).

Exporter and user queries: [Nginx Exporter](https://github.com/nginxinc/nginx-prometheus-exporter) with Apache v2 license. 