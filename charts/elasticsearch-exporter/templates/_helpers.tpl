{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "elasticsearch-exporter.name" -}}
{{- (printf "%s-%s-%s" (default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-") .Values.namespaceName .Values.workloadName) | trunc 63 }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name. Trunc to 55 (63 - "-deploy").
*/}}
{{- define "elasticsearch-exporter.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 55 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-%s" .Chart.Name .Values.namespaceName .Values.workloadName | trunc 55 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "elasticsearch-exporter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "elasticsearch-exporter.labels" -}}
helm.sh/chart: {{ include "elasticsearch-exporter.chart" . }}
{{ include "elasticsearch-exporter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "elasticsearch-exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "elasticsearch-exporter.name" . }}
{{- end }}

{{/*
Annotations
*/}}
{{- define "elasticsearch-exporter.sysdigAnnotations" -}}
promcat.sysdig.com/port: "{{ .Values.exporter.port }}"
promcat.sysdig.com/target_ns: {{ required "A valid namespace for the application must be passed in .Values.sysdig.namespaceName" .Values.sysdig.namespaceName | quote }}
promcat.sysdig.com/target_workload_type: {{ required "A valid workload type for the application must be passed in .Values.sysdig.workloadType" .Values.sysdig.workloadType | quote }}
promcat.sysdig.com/target_workload_name: {{ required "A valid workload name for the application must be passed in .Values.sysdig.workloadName" .Values.sysdig.workloadName | quote }}
promcat.sysdig.com/integration_type: {{ required "A valid integration type name for the application must be passed in .Values.sysdig.integrationType" .Values.sysdig.integrationType | quote }}
{{- end }}

{{- define "elasticsearch-exporter.prometheusAnnotations" -}}
prometheus.io/scrape: "true"
prometheus.io/port: "{{ .Values.exporter.port }}"
{{- end }}

{{/*
Create name of the exporter deployment
*/}}
{{- define "elasticsearch-exporter.exporterDeploymentName" -}}
{{- printf "%s-deploy" (include "elasticsearch-exporter.fullname" .) }}
{{- end }}
