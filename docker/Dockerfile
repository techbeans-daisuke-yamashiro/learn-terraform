FROM hashicorp/terraform
ARG CONTAINER_USER
ARG CONTAINER_UID
ARG CONTAINER_GID

WORKDIR /usr/local/
# gcloud CLIのインストール準備
RUN apk update && apk add --no-cache sudo shadow curl bash libc6-compat python3 py3-pip && \
  pip install --break-system-packages --upgrade pip 
# gcloud CLIのインストール準備
RUN curl -sL -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-460.0.0-linux-x86_64.tar.gz && \
  tar -xf google-cloud-cli-460.0.0-linux-x86_64.tar.gz && \
  ./google-cloud-sdk/install.sh --quiet && \
  rm -rf google-cloud-cli-460.0.0-linux-x86_64.tar.gz && \
  useradd ${CONTAINER_USER} -u ${CONTAINER_UID} -d /home/${CONTAINER_USER}
ENV PATH="/usr/local/google-cloud-sdk/bin:${PATH}"
WORKDIR /terraform
USER ${CONTAINER_USER}


