{{/* vim: set filetype=mustache: */}}
{{/*
Define the name of the chart/application.
*/}}

{{- define "application.name" -}}
{{- default .Chart.Name .Values.applicationName | trunc 63 | trimSuffix "-" }}
{{- end }}


{{- define "application.labels.selector" -}}
app: {{ template "application.name" . }}
{{- end -}}

{{- define "application.labels" -}}
{{ template "application.labels.selector" . }}
appVersion: "{{ .Values.deployment.image.tag }}"
{{- end -}}

{{- define "application.labels.chart" -}}
group: {{ .Values.labels.group }}
chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
release: {{ .Release.Name | quote }}
heritage: {{ .Release.Service | quote }}
{{- end -}}
