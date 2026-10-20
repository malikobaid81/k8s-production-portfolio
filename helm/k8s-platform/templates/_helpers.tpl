{{- define "k8s-platform.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "k8s-platform.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "k8s-platform.labels" -}}
app.kubernetes.io/name: {{ include "k8s-platform.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{- define "k8s-platform.selectorLabels" -}}
app.kubernetes.io/name: {{ include "k8s-platform.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}