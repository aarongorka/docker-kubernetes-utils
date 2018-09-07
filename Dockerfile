FROM alpine:3.8

ADD https://storage.googleapis.com/kubernetes-release/release/v1.8.4/bin/linux/amd64/kubectl /usr/bin/kubectl

RUN chmod +x /usr/bin/kubectl

ENTRYPOINT ["kubectl"]
