{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "pharmbio-notebook.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pharmbio-notebook.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pharmbio-notebook.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Label with the notebook owner's Slack member ID, used by alerting to @-mention the user.
Renders nothing if slackUserId is not set.
*/}}
{{- define "pharmbio-notebook.slackUserLabel" -}}
{{- with .Values.slackUserId -}}
{{- if not (regexMatch "^[UW][A-Z0-9]{6,20}$" .) -}}
{{- fail (printf "slackUserId %q is not a Slack member ID (e.g. U01AB2CD3EF), find it in Slack under Profile -> ... -> Copy member ID" .) -}}
{{- end -}}
slack-user-id: {{ . | quote }}
{{- end -}}
{{- end -}}
