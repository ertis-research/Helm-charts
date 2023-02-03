{{/*
Expand the name of the chart.
*/}}
{{- define "OpenTwins-MongoDB.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "OpenTwins-MongoDB.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}


{{- define "installation.name" -}}
{{- default .Release.Name -}}
{{- end -}}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "OpenTwins-MongoDB.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "OpenTwins-MongoDB.labels" -}}
helm.sh/chart: {{ include "OpenTwins-MongoDB.chart" . }}
{{ include "OpenTwins-MongoDB.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "OpenTwins-MongoDB.selectorLabels" -}}
app.kubernetes.io/name: {{ include "OpenTwins-MongoDB.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "OpenTwins-MongoDB.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "OpenTwins-MongoDB.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
