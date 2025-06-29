FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    curl \
    netcat \
    bash \
    git \
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common

# Install Helm
RUN curl https://baltocdn.com/helm/signing.asc | gpg --dearmor -o /usr/share/keyrings/helm.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" \
    > /etc/apt/sources.list.d/helm-stable-debian.list && \
    apt-get update && \
    apt-get install -y helm

# Install rtfctl from Mulesoft
RUN curl -L https://anypoint.mulesoft.com/runtimefabric/api/download/rtfctl/latest -o /usr/local/bin/rtfctl && \
    chmod +x /usr/local/bin/rtfctl

# Show installed versions (optional)
RUN bash -c 'echo "\nInstalled Versions:" && \
    bash --version && \
    curl --version && \
    git --version && \
    helm version && \
    /usr/local/bin/rtfctl version || echo "rtfctl version check failed" && \
    nc -h || true'

CMD [ "bash" ]
