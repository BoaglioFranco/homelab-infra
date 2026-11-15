{{- $token := (getSecretByName "1239898e-9537-423b-a106-50ddca4bb1a1" "prod" "/ghcr" "GHCR_TOKEN").Value -}}
{{- $auth := printf "BoaglioFranco:%s" $token | b64enc -}}
{{- $config := dict "auths" (dict "ghcr.io" (dict "auth" $auth)) -}}
apiVersion: v1
kind: Secret
metadata:
  name: ghcr-pull
  namespace: casita
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: {{ $config | toJson | b64enc | quote }}
