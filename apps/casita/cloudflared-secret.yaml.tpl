apiVersion: v1
kind: Secret
metadata:
  name: cloudflared-config
  namespace: casita
type: Opaque
data:
{{- range listSecrets "1239898e-9537-423b-a106-50ddca4bb1a1" "prod" "/cloudflared" }}
  {{ .Key }}: {{ .Value | b64enc | quote }}
{{- end }}
