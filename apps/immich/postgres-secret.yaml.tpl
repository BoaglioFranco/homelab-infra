{{- $password := "" -}}
{{- range listSecrets "1239898e-9537-423b-a106-50ddca4bb1a1" "prod" "/immich" -}}
  {{- if eq .Key "DB_PASSWORD" -}}
    {{- $password = .Value -}}
  {{- end -}}
{{- end -}}
{{- if eq $password "" -}}
  {{- fail "Missing DB_PASSWORD in Infisical prod /immich" -}}
{{- end -}}
apiVersion: v1
kind: Secret
metadata:
  name: immich-postgres-auth
  namespace: immich
  labels:
    cnpg.io/reload: "true"
type: kubernetes.io/basic-auth
data:
  username: {{ "immich" | b64enc | quote }}
  password: {{ $password | b64enc | quote }}
