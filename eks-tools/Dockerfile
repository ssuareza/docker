FROM alpine:3.6

ARG KUBECTL_VERSION=1.14.0
ARG AWSCLI_VERSION=1.16.310
ARG JQ_VERSION=1.5
ARG YQ_VERSION=1.15.0
ARG HELM_VERSION=2.9.1

RUN apk -v --update add \
    python \
    py-pip \
    groff \
    less \
    mailcap \
    curl \
    ca-certificates \
    && \
    pip install --upgrade awscli==${AWSCLI_VERSION} python-magic && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*

# Install kubectl
RUN curl -sL https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && chmod a+x /usr/local/bin/kubectl

# Install jq
RUN curl -sL https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 -o /usr/local/bin/jq && chmod a+x /usr/local/bin/jq

# Install yq
RUN curl -sL https://github.com/mikefarah/yq/releases/download/1.15.0/${YQ_VERSION}_linux_amd64 -o /usr/local/bin/yq && chmod a+x /usr/local/bin/yq

# Install helm
RUN curl -sL https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz \
    && tar xzf helm.tar.gz \
    && mv ./linux-amd64/helm /usr/local/bin/helm \
    && chmod a+x /usr/local/bin/helm
