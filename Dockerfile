FROM alpine:3.8

ENV K8S_LOGIN_TARGET_DIR=/tmp/kube

RUN apk add --no-cache gettext make git curl bash jq

# kubectl
ADD https://storage.googleapis.com/kubernetes-release/release/v1.10.3/bin/linux/amd64/kubectl /usr/bin/kubectl

# helm
RUN mkdir /tmp/helm && \
	curl https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz -o /tmp/helm/helm.tar.gz && \
	tar -xvf /tmp/helm/helm.tar.gz -C /tmp/helm && \ 
	cp /tmp/helm/linux-amd64/helm /usr/local/bin/helm && \
	chmod +x /usr/local/bin/helm && \
	rm -rf /tmp/helm && \
	helm init -c
RUN helm plugin install https://github.com/rimusz/helm-tiller

# kops https://github.com/kubernetes/kops/blob/master/docker/Dockerfile-light
RUN KOPS_URL=$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | jq -r ".assets[] | select(.name == \"kops-linux-amd64\") | .browser_download_url") && \
	curl -SsL --retry 5 "${KOPS_URL}" > /usr/local/bin/kops && \
	chmod +x /usr/local/bin/kops

# Kubeseal
RUN curl -L https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.7.0/kubeseal-linux-amd64 -o kubeseal && \
	mv kubeseal /usr/local/bin/kubeseal && \
	chmod +x /usr/local/bin/kubeseal
